Return-Path: <linux-kernel+bounces-103775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5D187C459
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8A6B22B65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5742D763ED;
	Thu, 14 Mar 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzA0bQzQ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA73675812
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710448656; cv=none; b=JOdBHxcmUdh3ABQF+cG+QPXj3aeIBB/kHnqScan4/QtO3/st7pko2dj8jNqAi1j3ruHChUtIOBClDc7Qdrc++rs5Yr+P/RquGCt6Mqcv+RvjxxO3+otCkrKHyd071cOW1DSEQpoZ/YPiH60esYR/saO227opNoGp/C3YYU7enOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710448656; c=relaxed/simple;
	bh=VCh7PcIjSIdoiYHmmCV7KKa0WbmYYsKJts4kc1dCbp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWMPNGKGB7jdOn/WttVqkKqzYRJILFLidzw8PxSffC33iZIfot0WuDAk2KW3x3h5CiAXRYGvvX6TRWgwjs3iZun2wOwYV5Y7sTwWXcmo7+SXKuDJ1pNwfdlQeLY9lR5XX9k8uc/Dbi35g3PBeaVWku0cQjm7RDQ3aFArggduwXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OzA0bQzQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so186524366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710448653; x=1711053453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9f5lPvgLSiEoPXA2pIrXRDNGYkgn1Z0t8XOUQTE/qHg=;
        b=OzA0bQzQsj15UTFYjmvOMosfUOMb1z1rpQxzVTvqGlFd4LQX3Dq+YK8dzEURi48IiU
         5Mk/R60G4IfYE+mDnngcTZv4nngtqUgc2F9APY0dlZh8NT2S/rQj5XPeWwuUnxW7g4XQ
         4022piUmIiwjhfIGwRVIZNhWYf1wW+EHdT3QomR5UZW93kn4UHS7D6/wenUq83Bs9tt4
         +s2zrmvGgd+0t8M5xzSq+cpyK2cxVOfAFcTkswaLYAq02ZSvoZ8G5Ph3KG7DtILSuHkb
         +JWSF7XXzeGmjsJ1rYsZYT++MaixG1ed4mZFkfB7mOkqMSIz8xt1lTTCGGN1MaubzADo
         AnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710448653; x=1711053453;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f5lPvgLSiEoPXA2pIrXRDNGYkgn1Z0t8XOUQTE/qHg=;
        b=UmsybmZOBcOd3OM+mbKwBNr60alWyHBcViA5OWsaKoPTPT7LUmXllCSRon+sDjpFtp
         kAmvQjuWhO8Owx70lQs86sFfmqF9stvG0aFLoJNNW9XvV8NUBXwJky+SMo0yuy5ZF8hf
         BAB072nwjwm0nANcX/SrGGblHxMU1udj5DuaYKBdXZzebVoHlKpUhjYG24eXZ7Nv9Ajw
         uioUs25SjqGBjhUvpBt3cb5pXXbJfE9ACQez9g+vYV9d91tFNl3alPHvZPG0RpA6bpMJ
         3fwyHOtHglWqtsumMNpqucJfCmqMRwA54ZOhPutAqcwtuoxiNIeAvaVZM3Xaa48W5OWU
         G4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDG/PAxEP0efgUkI3uIXzrM+8wG+uCRxQSXVopO+Ex8lIEsWd+4+8rtJYXhBYe1HSoJKvg5dgQ/GyujXFcpmF+Olt5mez5XnvUgd8B
X-Gm-Message-State: AOJu0Yxsf4HE6bZdfOIzjLYEalZHohQ5cqcbNfT1WD3PBl3seQHVZ2wC
	jSjL+D610QuLjfa814uYxY+qkp65/4adI/rgOIKYR5P5R31cpqdq1+BGl9rAXfybxXgnqBQD8Yq
	M
X-Google-Smtp-Source: AGHT+IHABuF+3TGwPMBOQxRbsETqBWyStRv86WQgRajyIkuZeueQPHNwPt5lg4PgDiUC2YQC3T/PnA==
X-Received: by 2002:a17:906:cd1a:b0:a46:6ba2:8168 with SMTP id oz26-20020a170906cd1a00b00a466ba28168mr2025151ejb.17.1710448652813;
        Thu, 14 Mar 2024 13:37:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ox12-20020a170907100c00b00a46203a86basm1019849ejb.27.2024.03.14.13.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 13:37:32 -0700 (PDT)
Message-ID: <fc7bda50-279e-4afb-8c31-4fcda0e8b2ed@linaro.org>
Date: Thu, 14 Mar 2024 21:37:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm630-nile: add pinctrl for camera key
To: Sebastian Raase <linux@sraa.de>
Cc: marijn.suijten@somainline.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240314200037.549206-1-linux@sraa.de>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240314200037.549206-1-linux@sraa.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 21:00, Sebastian Raase wrote:
> Add pinctrl configuration for gpio-keys. Without this,
> camera button half-presses are not detected.
> 
> Tested on discovery and pioneer.
> 
> Fixes: e781633b6067 ("arm64: dts: qcom: Add support for Sony Xperia XA2/Plus/Ultra (Nile platform)")
> Signed-off-by: Sebastian Raase <linux@sraa.de>
> ---
>  arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> index 87d0293c728d..5eedca6f288f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> @@ -90,6 +90,8 @@ cam_vana_rear_vreg: cam-vana-rear-regulator {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys_default>;

A nit: Please reverse the order: pinctrl-0 then names
>  
>  		key-camera-focus {
>  			label = "Camera Focus";
> @@ -635,6 +637,13 @@ ts_lcd_id_active: ts-lcd-id-active-state {
>  		bias-disable;
>  	};
>  
> +	gpio_keys_default: gpio-keys-default {

Looks missing suffix (state) and test, so:

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof


