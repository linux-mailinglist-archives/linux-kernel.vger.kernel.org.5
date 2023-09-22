Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770CE7AB921
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjIVSYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjIVSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:24:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38796FB;
        Fri, 22 Sep 2023 11:23:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2577C433C8;
        Fri, 22 Sep 2023 18:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695407038;
        bh=RRQu2DA14XEsOavEYlHhXKY49cxRSB7CmCyQBdCxHsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vt7kTBkEKWFfO5XRpzx3MKYN6JXRa3iKFBaOej4PW93d6qyYji0JQB24eFF7nAUTn
         aTUuIM1SSFKHU0qc6T62YQNfsSGywaoVqU/PDZvPRv4nPhWtKpRbyNl4JjiqIdVlFj
         MGM51PE+7PeQXBMaIzpIkaZ2FT2C7+zSYT644q0E4RrTZHwVf97zQVLUbeCrOWeyM5
         8Eyc/sK2T9XWgAkelq9E3ZPX1RX7f08WgwKfxHBXASSvqzbjx0hYNv1EXR07m9YvIu
         UM0SYVkgVxuHjWq/7hK0sioaL7KuRcnPmISLoglHmY9vYhGKrlkLUY5I69qq+gRvDE
         n0WnYi4Db29Nw==
Date:   Fri, 22 Sep 2023 20:23:50 +0200
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Can Guo <quic_cang@quicinc.com>, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH 4/6] phy: qualcomm: phy-qcom-qmp-ufs: Move data structs
 and setting tables to header
Message-ID: <20230922182350.GA3381@thinkpad>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-5-git-send-email-quic_cang@quicinc.com>
 <CAA8EJpoWnXeJKPB04kJW6Qo7ifAnt1u2ZSiq+W2HWOez=hi5gA@mail.gmail.com>
 <20230919121524.GD4732@thinkpad>
 <CAA8EJpoqRBxS7HJrFdRAvv677hKJw+d_K+fN_4ABDrj+68r28w@mail.gmail.com>
 <20230920101923.GG4732@thinkpad>
 <20230921140220.GK1487598@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230921140220.GK1487598@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 07:02:20AM -0700, Bjorn Andersson wrote:
> On Wed, Sep 20, 2023 at 12:19:23PM +0200, Manivannan Sadhasivam wrote:
> [..]
> > Btw, why do we have "phy-qcom" prefix inside drivers/phy/qualcomm/?
> > 
> 
> That would be a historical artifact, but it does provide nice
> namespacing for the generated .ko files - and iirc mkinitcpio doesn't
> automatically pick these up, so changing it would cause issues for our
> users.
> 

Well, my concern is only with the driver name and not with the module name.
And yes, module name should have the proper prefix (unlike "msm" for the
DRM module).

- Mani

> Regards,
> Bjorn

-- 
மணிவண்ணன் சதாசிவம்
