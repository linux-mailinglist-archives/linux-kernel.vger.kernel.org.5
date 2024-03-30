Return-Path: <linux-kernel+bounces-125646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1864892A09
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72D62832CE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79172F9E5;
	Sat, 30 Mar 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AP0CWIlR"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B6B64F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711791010; cv=none; b=JqezjTWhhZHLQEwmc4BZorN7t4656FdJ6dEIx2iCDSkNYTAo7jsJtgH80UJ3mN6bTCXpJBsAXkwFvI0vx1195yovvOsIif9IlREmycd3Oppv7er5PrwE5dK4lXjTjZnbPA4pCl3i9gzUE0SC80uW9Ud5E7VHKAYT6c64vkpp0SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711791010; c=relaxed/simple;
	bh=jH74SmsUJAEsV0nlVFruv378UYB/Cp922OOCePGSRZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUEtOZ67VTKxjAeKcd0TYg3gygVogswxbBhuxeDczWDKfG5G2qlIW/h59iTgMx1uw+5R/7alP+yMXxRx+VFFRbeTC9N6GcZ6py4f4sfhF10x2xTFOJfubFUShcb1/f9WJafYj09Ql4N9e+oij63EMFYnROyJaCSUalf9QViLCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AP0CWIlR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-415446af364so12455625e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711791007; x=1712395807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HRRPoA46ZiR7XyOWSlHygBjsRtwJEnGQX5rm2JJHl+E=;
        b=AP0CWIlR3IUOUHTROBB+9owtAqL9Uk5mq+iyguJRsPqtLp2ckhw600KA7BVSRuFhYP
         FEHfbhV4wwIDL9pYzT4GFq1jBglYq5AX4gCRyU5wwANuO8tT/kG6TdzEciCnmlkKieci
         PMdpf3iW1SwNaMYsiB6P2MOVRS6I4tPiy7wS7QUSofh+a32OJ+oUHHSxhwb3RWZRqyJj
         2xwgARw3eLyLJMle7GGysvViatdN/2eSjbvT4zF2XpzsDy+/j2x4VeXKBfZSfvF3N9Uo
         kp3i2KV6XIznpfl5QMCp7Hfj7G2n/qSqJ+xUFwguydnnwDdx8LgLPoOYoIElcGgkPpyh
         wmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711791007; x=1712395807;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRRPoA46ZiR7XyOWSlHygBjsRtwJEnGQX5rm2JJHl+E=;
        b=TCwlw5/iN+IhP6vUAB03/jTP5Aa1Ona9DAqomg1RTwPCbJ6Tr0KRwyiHLQ10NwnhId
         x1Z7q+GCUmGdeCmrl5Aqjxhf/aHZ+Nh5mJSsYdeVXUF4gZ3mvzMAu6yS++x77BEUaU8R
         UkHHH8uWhzIi4cAPmeP4RoxQHs3MXCJU7kJ+R1rL2explGynt/H5Y0W0mt7KL0ra16Wq
         MBi8LZllZ0+TDNPj/TUYirkmrCb3GM+pxw/IBsCXw5+o7Gzl2b8O1JJGA0WiaXxS4RuN
         y+lxN7Fo5P7Z7X9LTo7vxADFM9iH7Yrsrt4R2wlzcClWx5AWjhDxovaUOcOVME+mcsUB
         O+cA==
X-Forwarded-Encrypted: i=1; AJvYcCUVB7YOPXVu2eXgZmOnba+w0Qt7vkeT9lII11yOljGmWjTSop+IfmAxjX83LfJ1TLlBgdmvukzbpe/xhOE920Ho1LaZv/KAMi7F2DzW
X-Gm-Message-State: AOJu0YyK33JWlsv4hKNuaWmVr2/ku4jZwGmJpKXj0ft06dAGyoWkR+Zb
	L7F5Lu9OztOAZIjuKfaxWwo508wMMLes8y/04/oTVUd4TZV4afUXkthFdZMENtk=
X-Google-Smtp-Source: AGHT+IHah+u5LCx3ZcD5Y1/dZi9WB0vCE4py5e+wbLVYY5CxwNe1SifSkHNOIXHvYMQJ0iRzTli54w==
X-Received: by 2002:a5d:654c:0:b0:341:b5cc:f805 with SMTP id z12-20020a5d654c000000b00341b5ccf805mr5715381wrv.5.1711791007261;
        Sat, 30 Mar 2024 02:30:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c35ca00b004147ec48845sm10997057wmq.26.2024.03.30.02.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 02:30:06 -0700 (PDT)
Message-ID: <0b53cf44-b5ca-4ccc-9912-777b85f1bcbd@linaro.org>
Date: Sat, 30 Mar 2024 10:30:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: mfd: x-powers,axp152: add boost
 regulator
To: Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Ryan Walklin <ryan@testtoast.com>,
 Chris Morgan <macroalpha82@gmail.com>
References: <20240329235033.25309-1-andre.przywara@arm.com>
 <20240329235033.25309-3-andre.przywara@arm.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240329235033.25309-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/03/2024 00:50, Andre Przywara wrote:
> The X-Powers AXP717 contains a boost regulator, that it meant to provide
> the 5V USB VBUS voltage when the devices operates on battery.
> 
> Add the name "boost" to the regexp describing the allowed node names,
> to allow the regulator to be described in the devicetree.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> index b8e8db0d58e9c..14ab367fc8871 100644
> --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> @@ -274,7 +274,7 @@ properties:
>            Defines the work frequency of DC-DC in kHz.
>  
>      patternProperties:
> -      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|cpusldo|drivevbus|dc5ldo)$":
> +      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|cpusldo|drivevbus|dc5ldo|boost)$":

That's not an easy to read regex...

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

If driver does not depend on _, please consider dropping (_|-).


Best regards,
Krzysztof


