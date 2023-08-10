Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1837E777AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbjHJOiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbjHJOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:38:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083272684;
        Thu, 10 Aug 2023 07:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D64D65E46;
        Thu, 10 Aug 2023 14:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AC1C433C7;
        Thu, 10 Aug 2023 14:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691678297;
        bh=dma8etxQj28F8UTj/qSKe+KW6fpXEEl/4Ff+L1nZ6Lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YizyZBQGNHhqJ2u3CnZvafAwPR+Bogcyn+JN2WkFFI6k4hkFSk3WGW+dT1iGhQoBg
         CEL/bfruetDwwXgn4C784tctu0ACtE/BcnCTI//2B75K6mAc2emGGy1AwUEhnKdtef
         IEVqw6X9wbrQ0mUamgnQw/bAEtMsc4SoIFunzDSLXvekLNq7zLXE8/XJeZUsp2vNhs
         B/6w5KXE5ECTGlhJqnLSEO9zqy8oG1etYyXLVvPmDG1RkjyiK7RuL/+/rAbc9Tm4D9
         4dexzTtS90+ppwCWhDo14xoggjBdsNJ9sKS1+QialOdMp2vnGjuvwVaAMmR5u/UuMm
         7CcqurgX1r5Eg==
Date:   Thu, 10 Aug 2023 07:41:08 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     mani@kernel.org, quic_nguyenb@quicinc.com, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        linux-arm-msm@vger.kernel.org, quic_ziqichen@quicinc.com,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: Re: [PATCH V3] scsi: ufs: qcom: Align programming sequence as per HW
 spec
Message-ID: <yw5mgmk5q6vhwmu5oiqpg5kvafhlojzposoiaiy4j7wynov6sg@fgbx3twcsuwd>
References: <20230809151243.17531-1-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809151243.17531-1-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 08:42:43PM +0530, Nitin Rawat wrote:
> Align clock configuration as per Qualcomm UFS controller
> hardware specification.
> 
> This change updates UFS_SYS1CLK_1US, CORE_CLK_1US_CYCLES,
> PA_VS_CORE_CLK_40NS_CYCLES timer configuration for Qunipro
> and UTP to align with Qualcomm UFS HW specification.

"Code is wrong, make code right"


I find it hard to believe that "the clock configuration is wrong" takes
207 lines of code to address.

Please instead describe the problem you're solving, to ensure that
current and future readers of this commit message have a chance to
understand why this change was made.

The "describing your changes" section in the documentation is good,
please read it:
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

Regards,
Bjorn
