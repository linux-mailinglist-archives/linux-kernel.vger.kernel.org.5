Return-Path: <linux-kernel+bounces-48229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16468458DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1D91F2395F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7BF53390;
	Thu,  1 Feb 2024 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYzoFL8P"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87A5336F;
	Thu,  1 Feb 2024 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793917; cv=none; b=NJPpH6Ab6kU8//ke+vd0twxCUz0dLhkaP9byW1JxmZHYInYDuj8yCpTGGr4WDgVYeu0F5BezFg5tBv9l0IprnS9i9WMFfXQ0741cSMWnjS5m3ChxfEZJNqXK4f9Db8W8ATUxjaBrJLnKF1g8Zm26nTxG9wVS7rhgZy7LMP94OW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793917; c=relaxed/simple;
	bh=CzGxwkYE8eOq19rgvtWqPBgqaZx1eLdwkDkHFM1oipw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yq8IARPoLudgO1DdQisJMuJp2IIYmEyUPmnvzfGBHbjL5zR76T5SVgMPGA4yWxQ6FwI8u19W1JHbf4hE32GNKUHC4UoHYFujKkWekhhUxUkjkukY+BkUeF3JTVKtTjrg0ymExvhM3UzDK++1s0lQcNOyhXOFjpuu3XVZ0kfmdKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYzoFL8P; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d746ce7d13so7692315ad.0;
        Thu, 01 Feb 2024 05:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706793915; x=1707398715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=43xzHgXXu6oYc15FDGGWE+BE2/u2KH29mhM7SS7NCUY=;
        b=HYzoFL8PPeCIJ7PrFsUWJcXhf0VzTEVd06khInF4lY5g5fphgSUbAxVpQ6AwDu+ghA
         v9TfFc5UM3l+cJ74/ZnfLWn4oaCbn7wGMtfVcflsZcoMtek7gsxkYYUTo1t5tiuBteKc
         VMO2VxIWlmCxSjvpaTb84RCyxSW9AjS85yRHGNgHZ50342EktV+xW8LuP4WhCxRDJtRx
         bacDbimft5kH0D1fXFXSnekhNqYx43hqFJoXjbVlOcJsLRLrRqaEFETBkN6JJRBR4w3B
         IifQl2bOz5SJYQleCDlkUu3g63V8ta8hexObLYjmjsjqbB7hXBh5X1KKCCARNg0jXSl/
         QQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706793915; x=1707398715;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43xzHgXXu6oYc15FDGGWE+BE2/u2KH29mhM7SS7NCUY=;
        b=xRb8yJL2AIkkbhUZpvrO/BaI92SSUrYzD6t7dua89wcgTGAAq+MqOomVBDzltSxvfo
         fVzwoQ178aQCojvifQC9KHfQZ1SPHfMLyZZUChotQnehUXj5mddzHbaMOBukznQwCW24
         9ResCa/c9ZJrNRMoV7SWlVmorR5caji3QHkgYfPg9gRmilihdPdyxspSKNM13z6lyl8L
         HpYQ+XKk/geqCpwNxmI8UfydDy6kN9wpq1Icn2rh1bLSIu5MgyN4O7KQjk1ZFgUPsXY2
         Vkk9nUYVIVNuUsCdggH9q7JZD0D451tO8JVlKdtO8UiAvf+0oC5heX1jD86WzbKKkVPH
         iieQ==
X-Gm-Message-State: AOJu0Yw0tLjnAzqxYDs3nJ75n9vUDu9RF7ylPziU7lmFYDKidt43TTnX
	vLBHsZrOgV4DgzP6zpUp47cwc7O8+nvFauusG6Q9vbm6/36Pb4O4
X-Google-Smtp-Source: AGHT+IGNKu5JkaDUSzbzBEHrTojeyGWLq8v0yRqoYl+HvZy8ZGP0GtCFLkjmNy6udCjTowaENnIs1g==
X-Received: by 2002:a17:902:daca:b0:1d9:53aa:220b with SMTP id q10-20020a170902daca00b001d953aa220bmr1482127plx.2.1706793914959;
        Thu, 01 Feb 2024 05:25:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUi4yTFHva1oSgNBOSU2K+mCJUppmk/kW1UgtAyQb1PhxyYKm0rL0ZNCYzrFoY+VliO1wcrgs1uYr+hIAkI05pVRPzHj0tIQwikBm9nD1ZZuEci4vkxHVZnKoJGMb9znLeEuz6QrjIHX0ig4ej8Pn1pJu6t//YPzK78P76yIa2v1a+CoOk6KPXcSWVL250jUaNjJZMLk8jnbJr0cB2xtaXcmwWO73gDXpbkKIQ=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902e00200b001d8fca928fbsm5795883plo.230.2024.02.01.05.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 05:25:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5461a237-1df4-4077-86ef-e9ff6ff17e27@roeck-us.net>
Date: Thu, 1 Feb 2024 05:25:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: trivial-devices: sort entries
 alphanumerically
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Charles Hsu <ythsu0511@gmail.com>, linux-hwmon@vger.kernel.org
References: <20240201075805.7492-1-krzysztof.kozlowski@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240201075805.7492-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/31/24 23:58, Krzysztof Kozlowski wrote:
> Sort entries alphanumerically.  This was a semi manual job with help of:
> 
>    cat Documentation/devicetree/bindings/trivial-devices.yaml | grep '    - ' > old
>    cat old | sort -n > new
>    diff -ubB old new
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Cc: Charles Hsu <ythsu0511@gmail.com>
> Cc: linux-hwmon@vger.kernel.org
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
>   .../devicetree/bindings/trivial-devices.yaml  | 73 ++++++++++---------
>   1 file changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 5b52950e6bfc..41982a41398a 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -28,6 +28,7 @@ properties:
>   
>     compatible:
>       items:
> +      # Entries are sorted alphanumerically by the compatible
>         - enum:
>               # Acbel fsg032 power supply
>             - acbel,fsg032
> @@ -49,12 +50,12 @@ properties:
>             - ams,iaq-core
>               # i2c serial eeprom (24cxx)
>             - at,24c08
> +            # i2c h/w elliptic curve crypto module
> +          - atmel,atecc508a
>               # ATSHA204 - i2c h/w symmetric crypto module
>             - atmel,atsha204
>               # ATSHA204A - i2c h/w symmetric crypto module
>             - atmel,atsha204a
> -            # i2c h/w elliptic curve crypto module
> -          - atmel,atecc508a
>               # BPA-RS600: Power Supply
>             - blutek,bpa-rs600
>               # Bosch Sensortec pressure, temperature, humididty and VOC sensor
> @@ -115,20 +116,6 @@ properties:
>             - fsl,mpl3115
>               # MPR121: Proximity Capacitive Touch Sensor Controller
>             - fsl,mpr121
> -            # Monolithic Power Systems Inc. multi-phase controller mp2856
> -          - mps,mp2856
> -            # Monolithic Power Systems Inc. multi-phase controller mp2857
> -          - mps,mp2857
> -            # Monolithic Power Systems Inc. multi-phase controller mp2888
> -          - mps,mp2888
> -            # Monolithic Power Systems Inc. multi-phase controller mp2971
> -          - mps,mp2971
> -            # Monolithic Power Systems Inc. multi-phase controller mp2973
> -          - mps,mp2973
> -            # Monolithic Power Systems Inc. multi-phase controller mp2975
> -          - mps,mp2975
> -            # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5990
> -          - mps,mp5990
>               # Honeywell Humidicon HIH-6130 humidity/temperature sensor
>             - honeywell,hi6130
>               # IBM Common Form Factor Power Supply Versions (all versions)
> @@ -197,6 +184,8 @@ properties:
>             - maxim,max1237
>               # Temperature Sensor, I2C interface
>             - maxim,max1619
> +            # 3-Channel Remote Temperature Sensor
> +          - maxim,max31730
>               # 10-bit 10 kOhm linear programmable voltage divider
>             - maxim,max5481
>               # 10-bit 50 kOhm linear programmable voltage divider
> @@ -209,8 +198,6 @@ properties:
>             - maxim,max6621
>               # 9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
>             - maxim,max6625
> -            # 3-Channel Remote Temperature Sensor
> -          - maxim,max31730
>               # mCube 3-axis 8-bit digital accelerometer
>             - mcube,mc3230
>               # Measurement Specialities I2C temperature and humidity sensor
> @@ -241,8 +228,6 @@ properties:
>             - memsic,mxc6655
>               # Menlo on-board CPLD trivial SPI device
>             - menlo,m53cpld
> -            # Micron SPI NOR Authenta
> -          - micron,spi-authenta
>               # Microchip differential I2C ADC, 1 Channel, 18 bit
>             - microchip,mcp3421
>               # Microchip differential I2C ADC, 2 Channel, 18 bit
> @@ -259,40 +244,56 @@ properties:
>             - microchip,mcp3427
>               # Microchip differential I2C ADC, 4 Channel, 16 bit
>             - microchip,mcp3428
> -            # Microchip 7-bit Single I2C Digital POT (5k)
> -          - microchip,mcp4017-502
>               # Microchip 7-bit Single I2C Digital POT (10k)
>             - microchip,mcp4017-103
> -            # Microchip 7-bit Single I2C Digital POT (50k)
> -          - microchip,mcp4017-503
>               # Microchip 7-bit Single I2C Digital POT (100k)
>             - microchip,mcp4017-104
>               # Microchip 7-bit Single I2C Digital POT (5k)
> -          - microchip,mcp4018-502
> +          - microchip,mcp4017-502
> +            # Microchip 7-bit Single I2C Digital POT (50k)
> +          - microchip,mcp4017-503
>               # Microchip 7-bit Single I2C Digital POT (10k)
>             - microchip,mcp4018-103
> -            # Microchip 7-bit Single I2C Digital POT (50k)
> -          - microchip,mcp4018-503
>               # Microchip 7-bit Single I2C Digital POT (100k)
>             - microchip,mcp4018-104
>               # Microchip 7-bit Single I2C Digital POT (5k)
> -          - microchip,mcp4019-502
> +          - microchip,mcp4018-502
> +            # Microchip 7-bit Single I2C Digital POT (50k)
> +          - microchip,mcp4018-503
>               # Microchip 7-bit Single I2C Digital POT (10k)
>             - microchip,mcp4019-103
> -            # Microchip 7-bit Single I2C Digital POT (50k)
> -          - microchip,mcp4019-503
>               # Microchip 7-bit Single I2C Digital POT (100k)
>             - microchip,mcp4019-104
> +            # Microchip 7-bit Single I2C Digital POT (5k)
> +          - microchip,mcp4019-502
> +            # Microchip 7-bit Single I2C Digital POT (50k)
> +          - microchip,mcp4019-503
>               # PWM Fan Speed Controller With Fan Fault Detection
>             - microchip,tc654
>               # PWM Fan Speed Controller With Fan Fault Detection
>             - microchip,tc655
> +            # Micron SPI NOR Authenta
> +          - micron,spi-authenta
>               # MiraMEMS DA226 2-axis 14-bit digital accelerometer
>             - miramems,da226
>               # MiraMEMS DA280 3-axis 14-bit digital accelerometer
>             - miramems,da280
>               # MiraMEMS DA311 3-axis 12-bit digital accelerometer
>             - miramems,da311
> +            # Monolithic Power Systems Inc. multi-phase controller mp2856
> +          - mps,mp2856
> +            # Monolithic Power Systems Inc. multi-phase controller mp2857
> +          - mps,mp2857
> +            # Monolithic Power Systems Inc. multi-phase controller mp2888
> +          - mps,mp2888
> +            # Monolithic Power Systems Inc. multi-phase controller mp2971
> +          - mps,mp2971
> +            # Monolithic Power Systems Inc. multi-phase controller mp2973
> +          - mps,mp2973
> +            # Monolithic Power Systems Inc. multi-phase controller mp2975
> +          - mps,mp2975
> +            # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5990
> +          - mps,mp5990
>               # Temperature sensor with integrated fan control
>             - national,lm63
>               # Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
> @@ -323,12 +324,12 @@ properties:
>             - samsung,exynos-sataphy-i2c
>               # Semtech sx1301 baseband processor
>             - semtech,sx1301
> -            # Sensirion low power multi-pixel gas sensor with I2C interface
> -          - sensirion,sgpc3
>               # Sensirion multi-pixel gas sensor with I2C interface
>             - sensirion,sgp30
>               # Sensirion gas sensor with I2C interface
>             - sensirion,sgp40
> +            # Sensirion low power multi-pixel gas sensor with I2C interface
> +          - sensirion,sgpc3
>               # Sensirion temperature & humidity sensor with I2C interface
>             - sensirion,sht4x
>               # Sensortek 3 axis accelerometer
> @@ -374,8 +375,6 @@ properties:
>             - ti,lm74
>               # Temperature sensor with integrated fan control
>             - ti,lm96000
> -            # I2C Touch-Screen Controller
> -          - ti,tsc2003
>               # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>             - ti,tmp103
>               # Thermometer with SPI interface
> @@ -397,10 +396,12 @@ properties:
>             - ti,tps544b25
>             - ti,tps544c20
>             - ti,tps544c25
> -            # Winbond/Nuvoton H/W Monitor
> -          - winbond,w83793
> +            # I2C Touch-Screen Controller
> +          - ti,tsc2003
>               # Vicor Corporation Digital Supervisor
>             - vicor,pli1209bc
> +            # Winbond/Nuvoton H/W Monitor
> +          - winbond,w83793
>   
>   required:
>     - compatible


