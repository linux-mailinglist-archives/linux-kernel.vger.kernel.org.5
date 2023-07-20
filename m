Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9F075A934
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGTI0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjGTI0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:26:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C82D5D;
        Thu, 20 Jul 2023 01:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E7A36192A;
        Thu, 20 Jul 2023 08:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FA3C433CA;
        Thu, 20 Jul 2023 08:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689841577;
        bh=8hXpYZiC5flMcBz6vQdYkhcT3AAczzerq09YWQX34Cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgwNTyWkIX9IAhNeqFtqPOGah7eaiV9bf+YbUC2Q2COcOrErULar1+CtssefQrxLM
         CNJN8xf7glOlEBIZujkUMCpAwCBXxVeE0nlEGFTZrlnhyYG2rUox5DClgUbq+RgpE1
         cOdm/3wDyvRrLzLz5OIdnHPKyU5ovFzeMvHrWRidr2dIdlAewobJlZg9QLmSCNqy4c
         OG9Dxrvf5Lm2veAwozJtBEq9auoYsDwisSQMsyQlPm5HfYfEPueXe5JC+DI9h3mupQ
         xCxnwOyehlTfgFtvwLCuFPwD8rFw/vwsNIl8yO0lfLba2v0qeYrXpAdT/AKKt4ZRlX
         EPxhe9yDpIEdA==
Date:   Thu, 20 Jul 2023 13:56:02 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     quic_cang@quicinc.com, stanley.chu@mediatek.com,
        bvanassche@acm.org, quic_asutoshd@quicinc.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        konrad.dybcio@linaro.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, jejb@linux.ibm.com,
        linux-arm-msm@vger.kernel.org, quic_ziqichen@quicinc.com
Subject: Re: [PATCH V2] scsi: ufs: ufs-qcom: Update UFS devfreq Parameters
Message-ID: <20230720082602.GA4863@thinkpad>
References: <20230716074907.12356-1-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230716074907.12356-1-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 01:19:07PM +0530, Nitin Rawat wrote:
> To support the periodic polling mode without stop caused by CPU idle
> state, enable delayed timer as default instead of deferrable timer
> for qualcomm platforms.

How about,

"Devfreq uses the default DEVFREQ_TIMER_DEFERRABLE mode which uses the deferred
timer for scheduling the devfreq load monitor function. This causes the load
monitoring to be done only with non-idle CPUs and not making use of the idle
CPUs. Hence, use the DEVFREQ_TIMER_DELAYED mode which uses the delayed timer
thereby making use of idle CPUs as well for load monitoring."

> And change UFS devfreq downdifferential threshold to 65 for less
> aggressive downscaling.
> 

This change needs to be done in a separate patch. Also please provide any
benchmark if available to justify the patch.

> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

Your signed-off-by should come last, as you are the one sending this patch.

- Mani

> ---
> 
> Changes in v2:
> - Realigned the commit text
> 
>  drivers/ufs/host/ufs-qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 82d02e7f3b4f..a15815c951ca 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1388,8 +1388,9 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
>  					struct devfreq_simple_ondemand_data *d)
>  {
>  	p->polling_ms = 60;
> +	p->timer = DEVFREQ_TIMER_DELAYED;
>  	d->upthreshold = 70;
> -	d->downdifferential = 5;
> +	d->downdifferential = 65;
>  }
>  #else
>  static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
> --
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
