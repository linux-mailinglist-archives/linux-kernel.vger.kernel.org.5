Return-Path: <linux-kernel+bounces-48766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E604A8460EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6827285E8C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337FA85289;
	Thu,  1 Feb 2024 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLvHqMt/"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77D18527B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815762; cv=none; b=LqRATIUfCTpZ0xug0vWpqzA6CPv1ct75ZS8PDl0YHzJA3c4K8GbH4wyjcYbtBlf+L6sfWu/uzkmXrIVIzqGKtCCRZLnJI8QifcpMny+edQtFpHxtrkAxH4fjxzjA3VBj6ZDezYNadBg4dcf3cKeRsKNC5a00FdmhPE1nf/YglfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815762; c=relaxed/simple;
	bh=Ru210vYUirXmPC551YBoaO/Nfq5UmrA9/VmSo9XR9jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9NxcK9HBvWt0ac7KHxXcsFifaKraQQIGcX4wtcBy6tqyS1m4ftMkcVkAQ+gsaMShvkMUzUqrRk2+ROqukHMSv5ij+VpaC5XXjy7OaHnBMpRDl+EXiv27eEh/rJD6VIUPyxD7dFkMEMbB3av0F5i6VbcGCRGKeD13oT+KrNgxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uLvHqMt/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso1714204a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706815758; x=1707420558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPsGwsaZvfDTUU6T3nzwrrshu8ZpuYLw7ClY7MjnkZU=;
        b=uLvHqMt/HSKYGY85Dcimomc/3H1fDXcQMu9pCN8BjfEubFmWi3wAOJJW8t9p5ffoBP
         BNedCh9Lrtplym36F7gfy8PCOCVf6hjG7ISpOQH6z+71XmyU/uegugoeVZs6Q+7ZWOSD
         ukZmtw65fq2n+YAJXWiLSj8f4rq4aCBMLtTcPfBUmh3FH9Dur3lqMvzNg5SWDzFarEk7
         6KX68qUw3rpE1x3fEOYqmZ6e5gOe6cR/eME7vfONjz95r3FkB75J2Y/MKIFwV8i0lxvd
         knvrngVjipojTuy3Y31IyAiKBF1O4bmD5h0fkqEBu9+d4ZXQ/uFbuhj/0DugY7HvxFJL
         Ob3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706815758; x=1707420558;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPsGwsaZvfDTUU6T3nzwrrshu8ZpuYLw7ClY7MjnkZU=;
        b=EhdlaUmTN1d6L4eIrStPmlE9UL+e17B8c93gftKGiFxlINhQAfqcaaKS8k9LOkWvOT
         fq5OYOOOMfohQp9BnZXtuhiMJe5Vww79TjOIRzyHuv8hHhJFBr6XXspHfSllMQe7c234
         mPCfPGO+yi2+hv2zS3nHfGSXyNEQoQZH/TA32e3USgc8cL68qbAx9qqNaScz/4pi9z9O
         cYWN+DYFoxLddqSUKxq+nGx0+Ak1vhtp7kFtsS+2/ooZxCFWQbXqY+gzuRHzkndVL1TF
         Bo7j7F/175KhkJesym0T2angcPbPG4TVBOxTneNATM+kYVNYTkpIe1k1YhDqkXSysC1y
         eW8Q==
X-Gm-Message-State: AOJu0Yx5vnbIj9yP3/lvLl34Qcy3dVcku1umxi6sQMgt89gXtXKoPlAo
	Sbjp5DeWgc9qwvqTPreXkvE2YTgdllhAscqqFxynbf0C5Q9bTEgm0TyvL14VUUU=
X-Google-Smtp-Source: AGHT+IGJDz6Fe+bbnc9Xi5P/k9+9fxUBuKzW7cC4uthAAbIP75KC1f92mI+gEbzzeP6rpuyYPyiYRA==
X-Received: by 2002:a05:6402:ca3:b0:55f:6b5a:6310 with SMTP id cn3-20020a0564020ca300b0055f6b5a6310mr3731456edb.33.1706815757972;
        Thu, 01 Feb 2024 11:29:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUptkfBBN56a+CIP/QuUBhfH4wFcLjDi7z6wvhH8lk+P63jA+eE76ZVe9MVsXJjSOd4QIlzyE6zaqc7BgBxvVihTERX3kkEcZUO9MbUq0W86MrDMI6LTsvmnejBBwu/tGyXzfcmOEbdCW5TcoTnnJ0N+VU8bHEOhR2LC5fQpgkgSCV5psg7aCkxTJhclT64jZ1E1LEHu6XZb6cER7x5cvG7oA5HKOIeqX7N05MgavqZSYZ41hC04+95kQks59M8GVxAXEnfYPGQI6El
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e0200b0055eed9cac54sm110982edh.12.2024.02.01.11.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 11:29:17 -0800 (PST)
Message-ID: <41b50356-fd64-4de1-948a-91324bc0b4fb@linaro.org>
Date: Thu, 1 Feb 2024 20:29:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] arm64: dts: qcom: sc8180x-lenovo-flex-5g: enable
 touchscreen
Content-Language: en-US
To: Anton Bambura <jenneron@postmarketos.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240130202755.2289952-1-jenneron@postmarketos.org>
 <20240130202755.2289952-4-jenneron@postmarketos.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240130202755.2289952-4-jenneron@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.01.2024 21:27, Anton Bambura wrote:
> Set regulators, reset gpio and delays according to ACPI tables.
> 
> Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
> ---
>  .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  | 32 +++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> index af61acf58d68..8e8e1fca11c0 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> @@ -271,6 +271,12 @@ vreg_l3c_1p2: ldo3 {
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_l4c_3p3: ldo4 {
> +			regulator-min-microvolt = <3296000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>  		vreg_l10c_3p3: ldo10 {
>  			regulator-min-microvolt = <3000000>;
>  			regulator-max-microvolt = <3312000>;
> @@ -337,6 +343,12 @@ vreg_l10e_2p9: ldo10 {
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_l12e_1p8: ldo12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>  		vreg_l16e_3p0: ldo16 {
>  			regulator-min-microvolt = <3072000>;
>  			regulator-max-microvolt = <3072000>;
> @@ -357,7 +369,7 @@ zap-shader {
>  &i2c1 {
>  	clock-frequency = <100000>;
>  
> -	pinctrl-0 = <&i2c1_active>, <&i2c1_hid_active>;
> +	pinctrl-0 = <&i2c1_active>, <&i2c1_hid_active>, <&ts_reset>;

I think you want to add a reference under the touchscreen node instead.

Konrad

