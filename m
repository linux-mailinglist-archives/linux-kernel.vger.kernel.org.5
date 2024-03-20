Return-Path: <linux-kernel+bounces-109136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF9388151D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9259282ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0E154BCC;
	Wed, 20 Mar 2024 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXVPuvRs"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7652F78
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950506; cv=none; b=cpwHOJaMJQOCo85VBZ+bgE5URV/oJCJ/MYSTRbKHUQUaNmHmlVWxCuTrfALHunyFcuWOml/+xamhcIDsXI1KVf12Mjte55JqVOVL3Ad68d9eqp3uTrQBi2LZqRdTYO3ZC3UdCfJgfHAcrF5LFsnSFXKkzHCaZ2RtQzBPCm79AqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950506; c=relaxed/simple;
	bh=kJOH+rnAS2hEXejfUJZwazxTlSB8DY7It82kT/meYn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSp03qq3b7qbWFLkG48GS4DK3P7u68DM21BKcUc180wq3+UiqkuPcbTGDxyu8bvxr56oTO1la7eLL0OW1x7df3B1/aQNaIJJskbGMFEiOWnvwPo6I1lHhl96SChqODvA3u8N9w547ZwR65fQFHFLcpaoPCMnTzTDBJuYUPZnDxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zXVPuvRs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3417a3151c4so2487900f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710950503; x=1711555303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kL96kx3LN/9lm4lbLyIo1jNh4JW+F+59O3JF2oZwblI=;
        b=zXVPuvRs+uJ0obHjQjKp+UmikjjlQfiX3SSIrw2+PtFnxYp8pLjxy6Axv4OQcwsZP7
         zfBxqAFSQVfHfqMuB1PnWGhf0sGExhi7DTfff2KMJumzQcKfdYI29u08uaODET1zNUJW
         XNynpWwpGwfar+sgccAMpPE6LdWE4hxFtl9EPUy4iREkHml6OcDfn2vGWVcVOFKhLWmt
         jm3BESgVJB0Fdm4KwT88CpPrzxkRurtIpI7xgLJm5bfg8w5wYhN3Tvd04lUTfzu8ehGm
         ZdpQBiZccqXv/pMdWS1dzPd+uI4aekwQ+KSXRiKywcDurPosN4OFthxMJL3sRmhLmxij
         YIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710950503; x=1711555303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kL96kx3LN/9lm4lbLyIo1jNh4JW+F+59O3JF2oZwblI=;
        b=IenwgEvwV+d2LZQo1w8AIBV2k4d+ETyD8kW3SuO6Zmkg0HW8q3D0TNBCWMe0hNt6aN
         8kuGWlJmkfmsXGhaaXwIsXsI7c4sM0TFD+Iu5S9oNpC89ECK+zKZhyK/Qk+BBPaPTVbt
         SiPRaGeKS5fu05Lu/f72GPoR7IB2NOu8w8JJZpuoHkSvuCIu9K6ilipNLmRAe29As5V8
         EMowci4NSVGC5RXBkDpsmf5SrmOa98hsO1++dSszYsmT1I9Iu+WDmHjOAyYeQZT6qXEi
         hFdFXvDUiUJkDQ8XIoE1ZWhdFB35XCqmsaYtEMMjwvrlP+XGpEXsm8BeyrWJtDQVp6rF
         RWPg==
X-Gm-Message-State: AOJu0YwkGgFPzkm8ZCX+PGV1e51YwaVlbataSxwVwFx+JZDMztepAUiY
	XwU+4/9j6n83CwhHeee86utPxwvArKq6goNKL6htHvaAiG5chbzWaJ5x315YZOY=
X-Google-Smtp-Source: AGHT+IFIN6YIRXMa/mq1RLwjoKatqeyjBY5gl4ZOfUmSTIK1vlAArNKVYBMmbIRFvVAbqPe8dmgSPg==
X-Received: by 2002:a5d:560e:0:b0:33e:bfd0:335c with SMTP id l14-20020a5d560e000000b0033ebfd0335cmr12054591wrv.51.1710950503210;
        Wed, 20 Mar 2024 09:01:43 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id dd15-20020a0560001e8f00b0033ce727e728sm14983529wrb.94.2024.03.20.09.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 09:01:42 -0700 (PDT)
Message-ID: <944ff951-53dc-40f6-a7b0-5ecfc2cd4771@linaro.org>
Date: Wed, 20 Mar 2024 16:01:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] media: qcom: camss: Add sm8550 support
Content-Language: en-US
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org, quic_yon@quicinc.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240320141136.26827-1-quic_depengs@quicinc.com>
 <20240320141136.26827-9-quic_depengs@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240320141136.26827-9-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2024 14:11, Depeng Shao wrote:
> Add in functional logic throughout the code to support the SM8550.
> 
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
> ---
>   .../media/platform/qcom/camss/camss-csid.c    | 19 +++++++++++++++++++
>   .../media/platform/qcom/camss/camss-csiphy.c  |  1 +
>   drivers/media/platform/qcom/camss/camss-vfe.c |  7 +++++++
>   .../media/platform/qcom/camss/camss-video.c   |  1 +
>   4 files changed, 28 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
> index eb27d69e89a1..e9203dc15798 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
> @@ -590,6 +590,25 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
>   			csid->base = camss->vfe[id].base + VFE_480_LITE_CSID_OFFSET;
>   		else
>   			csid->base = camss->vfe[id].base + VFE_480_CSID_OFFSET;
> +	} else if (camss->res->version == CAMSS_8550) {
> +		/* for titan 780, CSID lite registers are inside the VFE lite region,
> +		 * between the VFE "top" and "bus" registers. this requires
> +		 * VFE to be initialized before CSID
> +		 */
> +		if (id >= 2)
> +			csid->base = camss->vfe[id].base;

Hard-coded magic numbers are definitely out.

If you need to differentiate - please include something in the struct 
resources so that the flag is always available and we don't have to 
start doing funky magic index/magic number gymnastics.

> +		else {
> +			csid->base =
> +				devm_platform_ioremap_resource_byname(pdev, res->reg[0]);
> +			if (id != 0)
> +				csid->top_base = camss->csid[0].top_base;
> +			else
> +				csid->top_base =
> +					devm_platform_ioremap_resource_byname(pdev, res->reg[1]);
> +		}

What is the point of hooking the TOP base just to clear our the status 
registers ?

We take no meaningful action in the ISR that I can see.


> +
> +		if (IS_ERR(csid->base))
> +			return PTR_ERR(csid->base);
>   	} else {
>   		csid->base = devm_platform_ioremap_resource_byname(pdev, res->reg[0]);
>   		if (IS_ERR(csid->base))
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
> index 45b3a8e5dea4..f35af0dd2147 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
> @@ -579,6 +579,7 @@ int msm_csiphy_subdev_init(struct camss *camss,
>   	case CAMSS_845:
>   	case CAMSS_8250:
>   	case CAMSS_8280XP:
> +	case CAMSS_8550:
>   		csiphy->formats = csiphy_formats_sdm845;
>   		csiphy->nformats = ARRAY_SIZE(csiphy_formats_sdm845);
>   		break;
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index d875237cf244..ff115c5521c6 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -226,6 +226,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
>   	case CAMSS_845:
>   	case CAMSS_8250:
>   	case CAMSS_8280XP:
> +	case CAMSS_8550:
>   		switch (sink_code) {
>   		case MEDIA_BUS_FMT_YUYV8_1X16:
>   		{
> @@ -296,6 +297,10 @@ int vfe_reset(struct vfe_device *vfe)
>   
>   	reinit_completion(&vfe->reset_complete);
>   
> +	// The reset has been moved to csid in 8550

Please run checkpatch.pl on your code before submission C++ are not allowed.

---
bod

