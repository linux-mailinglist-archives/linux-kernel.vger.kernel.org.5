Return-Path: <linux-kernel+bounces-125821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2518892CA1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ACB9B22145
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CD8374C3;
	Sat, 30 Mar 2024 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrMzuvjA"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B640E1FB2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711824129; cv=none; b=udTxVl2vN/Im+6ETo+7+kscwV3xtg6GdxLRdb2YK4MuWdmK92uxAS1kOH2YZMchg7fZu0907hDYejuZBMfCG1cTa/DMLKtHGJX1P+8V94sPRCRGfpm78oIAXRdyunJGu3uPFIGuRMmkpYVs2sQwbLEjlJTCappjoIKCSgX1qvgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711824129; c=relaxed/simple;
	bh=vaxfMlkCFBAyU9A6NWMaloTZz+NYjMmryUmHuhDKtrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pnb2MiY263AWfOvG2xcvpHtMFRzMqc76uLdZ2k7C16pF8cjpQwz1tX91mu7F9ENaG1gBvBj1D5KIL9IJ7otT3M2f9+UNsRgOXsA6ewr8SlfjNMOVL6Xv8tXf5hfWYFBLL160QM2SS+xQWRjop9Uw9hDra3yZdb2ge7nzdZ4ShTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrMzuvjA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4154d24cc77so11875925e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711824126; x=1712428926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bGfQYGPavWP1V2uL0DkxTrollseu1eXm9PXycD1dsJk=;
        b=rrMzuvjA6i24cXSW2wOQP/vVz108j9FKg6/UPFnR8PmkIub63Hji4bjOZa+GNFy7ng
         3Wz0E4nvosovp+iYpFWL4UVIyaIbGWC7r8u87rIAT+/PkdBqyE45DhbSXEvwalOerYWj
         vVbjIudAXHFmVVaeX9QPetOIfPzY+u6fcvmydDWOQ5VxnRN6Im32/ln+MsdKfKjz66zv
         oQlZe9TUCdXHm2cXSJsgpv8Xmir6ek6BPPEb/auOYfnBVHoBMEg4vCKsModFCegTRm82
         2DYAKDSvnXampKsVSh3Tu9xBdENSJ7w+b+XLMdGiAXq9FeElW4na7Y349/VeSr2/03Vm
         VyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711824126; x=1712428926;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGfQYGPavWP1V2uL0DkxTrollseu1eXm9PXycD1dsJk=;
        b=KMZTWrM5OvpICBlrSXeZ5kJ5w9v4coHHPLWc2fw9tK8CSKEUMlaSgDArhhOhemuH0e
         PIaHF/ChAvdROS/UFJ1xzqC+0ytbf0j+zgq2lPayyhZR/7zyMqeYOg1jGHW2WMKJjhUR
         55nDplAW+X9nEbmRlpObfaDe5J/cN/ISBDxoxgmXwjNF6LUkBLkQt9PlVXQvKdWDEAGd
         CgSX4uzC2hjZR1Z6rKhih4yWrAgzPE720qYTs7iCoqqnWAdNdR+QGMpHg42FzDUC8mux
         FPE0BXPxGJ4lrVivc8d+LYhN18ky1v8S3rckZBw55HBmUmUO1tbFl2DgxpgzpF1ZeEdk
         WjUw==
X-Forwarded-Encrypted: i=1; AJvYcCXYgBHOcvvCyPm9TjC8fgfG570uaAxTtO89PNp7mgsZunwSBXzZkHKKHpneIQA+cffVNpYSRq9at6OIzVS2Tp/sr/2B12ZNiQZEzVuu
X-Gm-Message-State: AOJu0Ywad8PbhrqsqiEvB8DVafdFSl1m8uodiAvnRNXijHeB606fKlbO
	uJBg5wTjiyMjRDVnJ5Qt4V5pg4hrut6jQ9UByYpDXtyVIClYKwck5HoO9IthykE=
X-Google-Smtp-Source: AGHT+IFrKjvRaQeZ5Vm9UZ8uA+9teyc8CH705lm5YgMaMcD3cHTCbFoOjUsX1AbbW7LVFQQzIhCQIA==
X-Received: by 2002:a05:600c:4443:b0:414:846:4469 with SMTP id v3-20020a05600c444300b0041408464469mr4989993wmn.38.1711824126110;
        Sat, 30 Mar 2024 11:42:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c139600b00414906f1ea1sm9230407wmf.17.2024.03.30.11.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 11:42:05 -0700 (PDT)
Message-ID: <a11c2adf-d72f-4385-a59e-ce640b8bb7d3@linaro.org>
Date: Sat, 30 Mar 2024 19:42:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8916/8216-samsung-fortuna: Add
 samsung,fortuna binding
To: Raymond Hackley <raymondhackley@protonmail.com>,
 linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>,
 Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20240326141222.200452-1-raymondhackley@protonmail.com>
 <20240326141222.200452-2-raymondhackley@protonmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240326141222.200452-2-raymondhackley@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 15:12, Raymond Hackley wrote:
> Add common binding samsung,fortuna used by the following
> Samsung Galaxy Grand Prime devices:
> - SM-G530FZ (msm8916-samsung-grandprimelte)
> - SM-G530H  (msm8216-samsung-fortuna3g)
> - SM-G530W  (msm8916-gprimeltecan)
> 
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts     | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts  | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts b/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
> index 366914be7d53..877fd2d7bb57 100644
> --- a/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
> @@ -6,6 +6,6 @@
>  
>  / {
>  	model = "Samsung Galaxy Grand Prime (SM-G530H)";
> -	compatible = "samsung,fortuna3g", "qcom,msm8916";
> +	compatible = "samsung,fortuna3g", "samsung,fortuna", "qcom,msm8916";

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof


