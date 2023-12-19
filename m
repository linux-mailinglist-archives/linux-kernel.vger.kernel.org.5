Return-Path: <linux-kernel+bounces-4880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018D9818343
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287701C21412
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E9311C9F;
	Tue, 19 Dec 2023 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGQnJ+qS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF811709;
	Tue, 19 Dec 2023 08:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771ADC433C7;
	Tue, 19 Dec 2023 08:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702974167;
	bh=FmCM3a684//V/bIDrG9a5kI2+uNKkLhT98DUvSSewC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGQnJ+qSxpGb5vN82otT1ZXIeafjXyBSyiq/ecFHosnYloJVBEDGjtJNZYWJO13GE
	 Etg2tV/suN/uRNVHczTAKniHLU1h/lCZ8UGWvy9hdtRy163K/Bprhw6iSGz3pIQBWa
	 IHydr394DHiTazdPjVPbPNiB+usyXCNmb4HSqapYUgTUliV2FqWb8FqyI51mBxqFnL
	 Mw3qtzZNMgToE4GEyloFLBJmwH3Y6e9t5yVc+9PyXVKFtbYNKvSLYTJqps7UHrZ+kR
	 HWYzZtgLm1Z2sxa3umZ8fdqGdBoDfDIO+hqrHm4polDAYwHgJgqlN3fFU4/JyR6MgT
	 2IstHvDaKba5g==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rFVND-0006xa-1S;
	Tue, 19 Dec 2023 09:22:44 +0100
Date: Tue, 19 Dec 2023 09:22:43 +0100
From: Johan Hovold <johan@kernel.org>
To: Marijn Suijten <marijn.suijten@somainline.org>,
	Lee Jones <lee@kernel.org>
Cc: phone-devel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Martin Botka <martin.botka@somainline.org>,
	Jami Kettunen <jami.kettunen@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Satya Priya <quic_c_skakit@quicinc.com>
Subject: Re: [PATCH v4 2/2] leds: qcom-lpg: Add PM660L configuration and
 compatible
Message-ID: <ZYFS04cznE5bhOeV@hovoldconsulting.com>
References: <20220719211848.1653920-1-marijn.suijten@somainline.org>
 <20220719211848.1653920-2-marijn.suijten@somainline.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719211848.1653920-2-marijn.suijten@somainline.org>

Hi Marijn and Lee,

On Tue, Jul 19, 2022 at 11:18:48PM +0200, Marijn Suijten wrote:
> Inherit PM660L PMIC LPG/triled block configuration from downstream
> drivers and DT sources, consisting of a triled block with automatic
> trickle charge control and source selection, three colored led channels
> belonging to the synchronized triled block and one loose PWM channel.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v3:
> - Rebased on -next;
> - (series) dropped DTS patches that have been applied through the
>   Qualcomm DTS tree, leaving only leds changes (driver and
>   accompanying dt-bindings).

> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index 02f51cc61837..102ab0c33887 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -1304,6 +1304,23 @@ static int lpg_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct lpg_data pm660l_lpg_data = {
> +	.lut_base = 0xb000,
> +	.lut_size = 49,
> +
> +	.triled_base = 0xd000,
> +	.triled_has_atc_ctl = true,
> +	.triled_has_src_sel = true,
> +
> +	.num_channels = 4,
> +	.channels = (const struct lpg_channel_data[]) {
> +		{ .base = 0xb100, .triled_mask = BIT(5) },
> +		{ .base = 0xb200, .triled_mask = BIT(6) },
> +		{ .base = 0xb300, .triled_mask = BIT(7) },
> +		{ .base = 0xb400 },
> +	},
> +};
> +
>  static const struct lpg_data pm8916_pwm_data = {
>  	.num_channels = 1,
>  	.channels = (const struct lpg_channel_data[]) {
> @@ -1424,6 +1441,7 @@ static const struct lpg_data pm8350c_pwm_data = {
>  };
>  
>  static const struct of_device_id lpg_of_table[] = {
> +	{ .compatible = "qcom,pm660l-lpg", .data = &pm660l_lpg_data },
>  	{ .compatible = "qcom,pm8150b-lpg", .data = &pm8150b_lpg_data },
>  	{ .compatible = "qcom,pm8150l-lpg", .data = &pm8150l_lpg_data },
>  	{ .compatible = "qcom,pm8350c-pwm", .data = &pm8350c_pwm_data },

When reviewing the Qualcomm SPMI PMIC bindings I noticed that this patch
was never picked up by the LEDs maintainer, while the binding and dtsi
changes made it in:

	https://lore.kernel.org/r/20220719211848.1653920-2-marijn.suijten@somainline.org

Looks like it may still apply cleanly, but otherwise, would you mind
rebasing and resending so that Lee can pick this one up?

Johan

