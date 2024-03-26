Return-Path: <linux-kernel+bounces-118842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EF288C014
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C241F39709
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A72E1BC2F;
	Tue, 26 Mar 2024 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wfrcZoCN"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133F219EA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450811; cv=none; b=etzk/hdUoda9uz+fZ9nWmv0yyOX3N3bC3SiLDx9gv48xFXtfApD3kH9JQIhjnMi+rtK5Xf5TK6ys/s1coAUhhuL+L0Yh3WrvzMaropIRwgiq18tpsGAz2AltLXPkKjmJ0tQ6WtcisQJr4POcJkUUGMLjJZG9hj8/kzQAYMPi+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450811; c=relaxed/simple;
	bh=Divj/8DtpHGT03S5LOxYHvCY7ocMY4N4D8r1EnHpwTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnUq/3jAk9XHmh6ZkRcHzSCSM+XKg6+KBNwD8giivm85KsBP+mEZNRZxumIw9fG3+asB4jRw51gatf7kuR4Wsjw9P5961pD4/Kh0JjVNxFCo0fBwVIuMAtzHvyO1hvLU+T1GjJTjqJ4d91lU9WeeTRkg1S18vcfXXSb7Z0kCOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wfrcZoCN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4148c2a3a3fso8376555e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711450807; x=1712055607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVML1MZKg+pEkFh9usl1FUGcFZrDQno7a6oVSt1v8Ic=;
        b=wfrcZoCNFeXV1ZxCnFkwBD7cdj1D+q7Wj39L/e8URvwQxDzG0/LrKelqEZapfbScm7
         J2RFMAa1ElRSDbv7wIenLCmGfXFsPGMn6YA0/UWs9e8mAFwdmttxTpWJ9NDYbSC8Y1Pp
         OBDh49nAJhhfUrCz5DiLMIj0TYk+Ng2jIc85NWUDNSsmtvSpPcafWR7k3UKUONzr4Wgk
         z6O4tZRFefh/qnvTudAGUm6USMkbISP6fnsRXBdoW6NqfjBxi4QyrEMANX8cRCwj7RTE
         nwcearEZh3YRLnPbxqgKT2NxL/IfGDOlFUM8opxL8EqhpVSX/1SXwmAgxQOJNTDNsn95
         iZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711450807; x=1712055607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVML1MZKg+pEkFh9usl1FUGcFZrDQno7a6oVSt1v8Ic=;
        b=QXEAe7tm6KeyG0qKyS4r42vZGiWbaD1BxrguzuRjhWWThXbR46GuNkyB12d52A/AlY
         WtekRLN362PCRBRC1gw/RpPi736K1o6h9/bUHlWhAkMPca1QKIRLyiiJ4nNHLOlWZ/iE
         pfVffe5yoKS4X3k8CkyIo8T76lEj3GBXoaNXxj58iP+uEyOqbync+yKdimFe6lclS/G/
         /BmsECZw5eYyznhwLuP6zwHuauqJFHltO8SqKhp+BU1w4mDSTPOJbTSDabGYn6KZJilE
         WyMwXgIXShRMl+g4CrSHs4aRs/zsZEZbsFDNOr3Lkj35OKlcYNx2qgrwKUhQTuf6Bf4n
         ED+w==
X-Forwarded-Encrypted: i=1; AJvYcCXal5F0HQXVV7hDsV/1trtAag+yuMtftC77ZiyoawcfRRbBmaDIm0m+BfZf6Ner5vYxUTruwseRIBzdx3fdJOTy7EKvp6LP8fCOFDCt
X-Gm-Message-State: AOJu0YzixN//uCzKLWhdDBMt7BNgEH5IrJ40+kvNaKyE/ZaJ0C4/gRwe
	MT4ZKlDzbclyTWklGlwMgpB8pmCw78+vrpul7j0SRbtrwH/+MluhOuACVSw+0AOgA1RrQFyCmxU
	Z
X-Google-Smtp-Source: AGHT+IH/v6lIhJFYa00AxrCwMQmInONIZpWW6fjPpY2MWiLb5mY0D3jsDtHCGwnOD83KHDMnlDvK3A==
X-Received: by 2002:a05:600c:1c1c:b0:413:f7a2:55e0 with SMTP id j28-20020a05600c1c1c00b00413f7a255e0mr6816746wms.30.1711450807049;
        Tue, 26 Mar 2024 04:00:07 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e3-20020a05600c4e4300b004148e1d938bsm1805685wmq.22.2024.03.26.04.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 04:00:06 -0700 (PDT)
Message-ID: <9bea167d-edcf-4d66-8ec7-051e97c8dffd@linaro.org>
Date: Tue, 26 Mar 2024 12:00:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] thermal/drivers/tsens: Add suspend to RAM support for
 tsens
Content-Language: en-US
To: Priyansh Jain <quic_priyjain@quicinc.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_manafm@quicinc.com
References: <20240326074033.17002-1-quic_priyjain@quicinc.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240326074033.17002-1-quic_priyjain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/03/2024 08:40, Priyansh Jain wrote:
> As part of suspend to RAM, tsens hardware will be turned off.
> While resume callback, re-initialize tsens hardware.
> 
> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
> ---
> V3 -> V4: Make tsens_reinit function specific to tsens v2. Add
> NULL resume callback support for platform whose versions < ver_2_x
> in tsens ops.
> V2 -> V3: Remove suspend callback & interrupt enablement part from
> resume callback.
> V1 -> V2: Update commit text to explain the necessity of this patch
> 
>   drivers/thermal/qcom/tsens-v0_1.c |  6 +++++
>   drivers/thermal/qcom/tsens-v1.c   |  3 +++
>   drivers/thermal/qcom/tsens-v2.c   |  1 +
>   drivers/thermal/qcom/tsens.c      | 37 +++++++++++++++++++++++++++++++
>   drivers/thermal/qcom/tsens.h      |  5 +++++
>   5 files changed, 52 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 32d2d3e33287..7ed85379247b 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -329,6 +329,7 @@ static const struct tsens_ops ops_8226 = {
>   	.init		= init_8226,
>   	.calibrate	= tsens_calibrate_common,
>   	.get_temp	= get_temp_common,
> +	.resume		= NULL,

As a static variable it is already set to NULL. Why do you need to 
explicitly set them everywhere ?

[ ... ]

> +#ifdef CONFIG_SUSPEND
> +static int tsens_reinit(struct tsens_priv *priv)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->ul_lock, flags);

What this lock is protecting ?

> +	if (tsens_version(priv) >= VER_2_X) {

May be move this test before the lock ?

> +		/*
> +		 * Re-enable the watchdog, unmask the bark.
> +		 * Disable cycle completion monitoring
> +		 */
> +		if (priv->feat->has_watchdog) {
> +			regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
> +			regmap_field_write(priv->rf[CC_MON_MASK], 1);
> +		}
> +
> +		/* Re-enable interrupts */
> +		tsens_enable_irq(priv);
> +	}
> +
> +	spin_unlock_irqrestore(&priv->ul_lock, flags);
> +
> +	return 0;
> +}
> +
> +int tsens_resume_common(struct tsens_priv *priv)
> +{
> +	if (pm_suspend_target_state == PM_SUSPEND_MEM)
> +		tsens_reinit(priv);
> +
> +	return 0;
> +}
> +
> +#endif /* !CONFIG_SUSPEND */


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


