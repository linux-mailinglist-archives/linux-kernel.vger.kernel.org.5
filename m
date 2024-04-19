Return-Path: <linux-kernel+bounces-151509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A781D8AAFDA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA141C22B93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B7C12D1FE;
	Fri, 19 Apr 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snPv7bew"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C8200D3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535016; cv=none; b=TKZCxlS7bHir0E9E4QmiLrlqHcmA9Rh+EU2FXgBIbfmMF552AH2JzeVkozSs9PWSC0LY0wkCSOC0HbxEjRB87eDfLei0guWFYA2oXA+eEYKYK6CYJWm/hEWXsjEjAQObubyHAsIpy9zYGO3T/Jts2d298lBYoeE+wjV4pwQ5Pc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535016; c=relaxed/simple;
	bh=HC5AjpYaeHDj8Mj5jLA96RcnHiHzcC4W3BA/9eZj0A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWy7GnYvMDAwAnRTA9lYRUsHVLb5ua7Y2LZgsQINcqLfS7cUWIttsc4gq3CGS1lXQterU0zSc5edfdAlP77nhgyFJqXfGan9gaQsYDzPJRDChY/1zKXt/EiasTaWVOVj5WTSezCzUcXgV/VFzDCnGCjCAi6yvy+TqGmGPOYx11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=snPv7bew; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cedfc32250so1361415a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713535014; x=1714139814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lDxhWRlfVkx8ifw3fFXKI2zA+Tw6hAZQJsO5ryHPBLg=;
        b=snPv7bewwmntbEEECfrOZO5k/lFluS9Uq/J8U91NAYik5ibg29XSe1iXP5wh1ChGy2
         sv8QOJOCN4F6AYg9Y9I6N309yQuKWoNYrbVWDYTeSKrI0mL9OocezNyg46ElbSAhnM92
         VpSGrjC7mO30mofUpDVAHn1Nb3L7seINnLRXDXJLZP5By81ct22gz6o49pahLuq2b5oD
         NFiq70p5UB6L5iAf7ZY/R1P6v9pvPJyyB6efQudheEetVz90NVoR9nPbF1amvOvNXwNq
         2WsOag8X3s962KsgSaMf9nngkC0tBeKJmLR3EUBskH4nfQfa4Nl8PLKVX8d/gwOoe9Jl
         DnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535014; x=1714139814;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDxhWRlfVkx8ifw3fFXKI2zA+Tw6hAZQJsO5ryHPBLg=;
        b=A+Dr3xlSw6vwYtOgJnAdsCr6a0fCJ4oHgkEjHHsGBM3YB7dakNSZU2pX/SIwcQO5G9
         i2fByXiEU0l3We7+dIu+QJozov+ak3pbITF9vfjSCVUWccz8hZvVetW0ADz+GonUhAOx
         Zw9Itdz0fSYpZXv8w1KhUD0pAD1rDBjDE4JnhCOnePAzB/Ni4qrNYO8Lq+DyY/NxGRm+
         ZripUpL74VzPLqQE6+0KCDW6BKiSS6uK6PgAPKQV2HyYYawM+R+4uFAxCoZJAh9uxg9p
         OGfXu4OJcudAC11AbZMKal1aNeezNGe4/WmRUed0monuR/nM9mqXQRRQJFIldol8YcUs
         22CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgRhxu12xgUX7vwWKwg3D+GLE3ZwQBMd5G1oxuJfgJDsB8O8+Ba1AIdnRFTrySHRiLs+bqGytA0M4kUUdv7ySItRxwrTsHT4MWqlqS
X-Gm-Message-State: AOJu0YyHnfepWDhdEXXC9E8XB7HY5+6eS2adQXJlUI+JJT0m+mQ+P04t
	+3I7UL8ycPRJzeTsZgcR4apXnaCbnzuoB+Z9Zgbp+vPPwAruhnk2XCkICxzjgwkey+avmodqpKG
	w
X-Google-Smtp-Source: AGHT+IEgMbiLkd1PuoCMXAPdhR42Mglbd/GTuMi3fUokX/KI02xKefFL9uHE/uCFgcq9jdB6EpU+pA==
X-Received: by 2002:a17:90b:3587:b0:2ac:88e4:2dd with SMTP id mm7-20020a17090b358700b002ac88e402ddmr1610993pjb.0.1713535014305;
        Fri, 19 Apr 2024 06:56:54 -0700 (PDT)
Received: from [172.20.9.36] ([209.37.221.130])
        by smtp.gmail.com with ESMTPSA id f21-20020a17090a4a9500b002a058af5e12sm4861636pjh.12.2024.04.19.06.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 06:56:54 -0700 (PDT)
Message-ID: <f297210a-ad3b-40f5-b8ab-e51e11cefbe4@linaro.org>
Date: Fri, 19 Apr 2024 15:56:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm64: dts: ti: k3-am62-main: Add eQEP nodes
To: Judith Mendez <jm@ti.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 William Breathitt Gray <william.gray@linaro.org>
Cc: David Lechner <david@lechnology.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20240418221417.1592787-1-jm@ti.com>
 <20240418221417.1592787-2-jm@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240418221417.1592787-2-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/04/2024 00:14, Judith Mendez wrote:
> Add eQEP DT nodes 0-2 for AM625 SoC.
> 
> Since external hardware was needed to test eQEP, the DT nodes
> for eQEP were not included in the introductory commit. Now that
> eQEP has been validated, add nodes to k3-am62-main.dtsi.
> 
> Fixes: f1d17330a5be ("arm64: dts: ti: Introduce base support for AM62x SoC")
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 30 ++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index e9cffca073efc..0877899b90667 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -844,6 +844,36 @@ ecap2: pwm@23120000 {
>  		status = "disabled";
>  	};
>  
> +	eqep0: counter@23200000 {
> +		compatible = "ti,am3352-eqep";

That's k3-am62, not am3352. See writing-bindings (and numerous
presentations telling you how to do it, e.g. from two previous EOSS/ELCE).

Best regards,
Krzysztof


