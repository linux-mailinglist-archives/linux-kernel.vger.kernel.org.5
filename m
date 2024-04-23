Return-Path: <linux-kernel+bounces-156029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 059328AFCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1189FB2457E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D28524A5;
	Tue, 23 Apr 2024 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arJljgSj"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79B4437D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916135; cv=none; b=hkTaBF+2OWg2vMTPmvmA8H9+dU1JY034qIsjMxdG6eTFsjJq1rV6zAZagOy+bsPMJ6bbSvmVD9Jgh9HQzunokfa1dkMOHMX5GE0zTn63PKKbqxbY6+qgzFxVMyD++HG1WbLSyehJ8YuKHk1GnJFGe0XbXJRSjodJVi5wtF23WSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916135; c=relaxed/simple;
	bh=O+pfz+OtQCyDo4+S17bvD89xB/KAdv6haRV5YqRwjyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhJ92+fmNVD6W/Wqlty7VvBQxokP6tXl8nuQ7BYU6hrAIWRIdWUhqSouaS4GqqwCI9AxXWQdHCudDynwnsr2Ase33TcIO+NWj2jGIEPaw6DMVdLqci+mli6ZVR+ZoQUFpKi3k+/L/o5ZTP11DWsqIifS6ZnAzaNaIvjDtW3gZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=arJljgSj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a58872c07d8so75716866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713916132; x=1714520932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qP3QDCXdvCgy9EMQKAFMtLndWf1Gq3dqKJVdLdrFV2Q=;
        b=arJljgSj+68N3xFS97D2LvesY2r/vgRdIArko46f6J1ztm0pLh3/hz8nDHSzItM1ZA
         si3hp1HtbKNPUr+8Dhb1Th7tRvQXSPn8PpgSQo8rRwp26eqOTVBMSOKKAR/FC+pShEcR
         jF5YFu61XMs0Jgc3pEzyGiI1D0hSXAmO22119RtBKSBisHKb3fnlNse4ek3+IX+l2YEi
         ywyrdpVoaYZopVFAjX5IVZJi+KxPlDzGLH5GVZ2s0FRYvNVDLZPY6nh1vHanzB+x5CRN
         lxy8bEJevLoYS5UMt87it6yutlBYlOp+xO0YRZZYcDVhpimP18flly6fwFPNvECYTC0U
         BoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713916132; x=1714520932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qP3QDCXdvCgy9EMQKAFMtLndWf1Gq3dqKJVdLdrFV2Q=;
        b=hP81VHeCDQlkpiyeQ55KSHYUwZhk+AwIPcyo2HqWCjJyAXLjgIXqGZCBOkoBD8zAd3
         /bmbX6hkoJhaTS/UToChwVs3swnosJOHUC00dy4PahiaTG5tld22wf9MXFjhOAGAjoXf
         pnR92UmPwy89rSM3ErU3FbOOBex9lj8mZK66y6BsMa9uwkXDboUxFuvnQmqepPqz7vEs
         Jo0eBL5ziM0UoWTpz71aUe9AM159CfMDAGse1F68oZZ1dIfdx25P4AwwK75Xp5M0o7w5
         3lCVuxHnjB2b1Q7Gnsa1shO7eUJiO8VLcFsZklsbqGIIG7jQIejDZTytAYslQtcNp8qP
         TWpA==
X-Forwarded-Encrypted: i=1; AJvYcCUfsHl6iwRxZu3OUxFt/OSC60YOOT/V8q3XcgyloB9rUqqaTuS9gjpmPStS3o753DwWGTJ7YaqlAI/4dWcu8yoykOiOESesC45txv04
X-Gm-Message-State: AOJu0YygeQoK6mwnJd4cZUqdk8XGsUCj+puH6krkEzNWJ/qEJwE60g8p
	GJnuWstlZL4NDUlV763pJ2L0eDlXLNls3s5iPgaTWJVJ6zh+a5rE1cL8E0iCrGs=
X-Google-Smtp-Source: AGHT+IEFXcr58PjTWkOGUBTopPC7H0jAaJReRUPaMqMe5LSgbDgixh7jul4TfOZmlJTgW+jQ740xaw==
X-Received: by 2002:a17:906:2849:b0:a54:e181:792b with SMTP id s9-20020a170906284900b00a54e181792bmr4050621ejc.5.1713916131990;
        Tue, 23 Apr 2024 16:48:51 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090653ca00b00a5587038aefsm6196673ejo.156.2024.04.23.16.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 16:48:51 -0700 (PDT)
Message-ID: <e70e0379-cab0-4586-825e-ade6775ca67c@linaro.org>
Date: Wed, 24 Apr 2024 00:48:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 3/5] clk: qcom: gdsc: Add set and get hwmode
 callbacks to switch GDSC mode
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>
References: <20240413152013.22307-1-quic_jkona@quicinc.com>
 <20240413152013.22307-4-quic_jkona@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240413152013.22307-4-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/04/2024 16:20, Jagadeesh Kona wrote:
> Some GDSC client drivers require the GDSC mode to be switched dynamically
> to HW mode at runtime to gain the power benefits. Typically such client
> drivers require the GDSC to be brought up in SW mode initially to enable
> the required dependent clocks and configure the hardware to proper state.
> Once initial hardware set up is done, they switch the GDSC to HW mode to
> save power. At the end of usecase, they switch the GDSC back to SW mode
> and disable the GDSC.
> 
> Introduce HW_CTRL_TRIGGER flag to register the set_hwmode_dev and
> get_hwmode_dev callbacks for GDSC's whose respective client drivers
> require the GDSC mode to be switched dynamically at runtime using
> dev_pm_genpd_set_hwmode() API.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/clk/qcom/gdsc.c | 37 +++++++++++++++++++++++++++++++++++++
>   drivers/clk/qcom/gdsc.h |  1 +
>   2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index df9618ab7eea..c5f6be8181d8 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -363,6 +363,39 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>   	return 0;
>   }
>   
> +static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct device *dev, bool mode)
> +{
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +	int ret;
> +
> +	ret = gdsc_hwctrl(sc, mode);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for 1usec for mode transition to properly complete */
> +	udelay(1);

A delay I suspect you don't need - if the HW spec says "takes 1 usec for 
this to take effect" that's 1 usec from io write completion from APSS to 
another system agent.

You poll for the state transition down below anyway.

I'd be pretty certain that's a redundant delay.

> +
> +	/*
> +	 * When GDSC is switched to HW mode, HW can disable the GDSC.
> +	 * When GDSC is switched back to SW mode, the GDSC will be enabled
> +	 * again, hence need to poll for GDSC to complete the power up.
> +	 */
> +	if (!mode)
> +		return gdsc_poll_status(sc, GDSC_ON);
> +
> +	return 0;
> +}

Other than that, seems fine.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


