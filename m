Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80EB7A624C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjISMPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISMPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:15:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56184E3;
        Tue, 19 Sep 2023 05:15:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AB2C433C7;
        Tue, 19 Sep 2023 12:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695125731;
        bh=xvCx7ZWNm6jnB4edU9vEvToGC6Z5Sc/hEVmL8SgiqZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZseuY35WtH77s0q6NFTQCnN8iQjLfnq+vTD+TAUlrk1wwvuAA+DFYeeWDHg+Fvv2
         2p6iwRJRenvbl6ao3MJAEqtuyGay6DGmaLxjZg6b1l2VHtsnzUtBHtes7Oij33Zb77
         ZfFX+F1k6Mf3stSs08AxTMhP+Go1OwBLN5x1+1uwlvf/2EhbrGuYo3QXWoHcFjP2Gw
         ZyDw0apc9XL/oqWyk+cv6tI5vgjRRTRkDU87aT5x4nGDyfPua3g5WTFmVoZeyMe+LT
         5Nt4CcQC2lHyCUj1KsDJGxI7CwdjierL8EemVsHwQ7gRYVYCp+RKS6T+xspknKRDa9
         bZAI19Hco5l0g==
Date:   Tue, 19 Sep 2023 14:15:24 +0200
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Can Guo <quic_cang@quicinc.com>, quic_nguyenb@quicinc.com,
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
Message-ID: <20230919121524.GD4732@thinkpad>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-5-git-send-email-quic_cang@quicinc.com>
 <CAA8EJpoWnXeJKPB04kJW6Qo7ifAnt1u2ZSiq+W2HWOez=hi5gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpoWnXeJKPB04kJW6Qo7ifAnt1u2ZSiq+W2HWOez=hi5gA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 03:28:59PM +0300, Dmitry Baryshkov wrote:
> On Mon, 11 Sept 2023 at 09:01, Can Guo <quic_cang@quicinc.com> wrote:
> >
> > To make the code more readable, move the data structs and PHY settting
> > tables to a header file, namely the phy-qcom-qmp-ufs.h.
> >
> > Signed-off-by: Can Guo <quic_cang@quicinc.com>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 802 +------------------------------
> >  drivers/phy/qualcomm/phy-qcom-qmp-ufs.h | 805 ++++++++++++++++++++++++++++++++
> >  2 files changed, 806 insertions(+), 801 deletions(-)
> >  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-ufs.h
> 
> Is there any reason to do so? Other than just moving stuff around, it
> doesn't give us anything. This header will not be shared with any
> other driver. Just moving data tables to the header (ugh, static data
> in the header) doesn't make code more readable.
> 

I think the motive here is to move the static tables to one file and have the
rest of the code in another. Because, the static tables itself occupy 1.2k LoC
now and it is going to grow. So let's keep them in a single file to avoid mixing
it with rest of the driver code.

- Mani

> If you really would like to clean up the QMP drivers, please consider
> splitting _common_ parts. But at this point I highly doubt that it is
> possible in a useful way.
> 
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்
