Return-Path: <linux-kernel+bounces-107118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1672287F7AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE68B2314D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4274F883;
	Tue, 19 Mar 2024 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGS8xLbO"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE851028;
	Tue, 19 Mar 2024 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830578; cv=none; b=FS6iQJ5MMfblWSpBMSQlq9TpxqJcyCFQB+0bG5WmkIyYVTM8sHKkKPta51Uwdz2tqanzSdmHrB4QzXAcW3aOpL84+X5q+MPX6A35IbiTNKTjvFp3ZWK3aA2365jyv3r1ao5cAdZ0RT4dmwdlPBkhnciRh1OeGsp/ou016M/OiLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830578; c=relaxed/simple;
	bh=3jam/nq9dx2B/NFGSZWgKyKZKWTdjQotnoF33x3s4vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWWJkqQaOu9q5T73o6pmD3V2yn1K6KO6g1n9quhcR6Y6oCovOs/NMXPpqOmtkcImzY9cjR2xLsbCcBFgIZ4GDCkKeH99tZWS1pApfTAjfn4DN/RVc9bsQPmgH8dE2rkfbX+SOkc91RYpdq90wVERdZLbeRkMd6tKJn2xJohGG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGS8xLbO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6ce174d45so4105838b3a.3;
        Mon, 18 Mar 2024 23:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710830576; x=1711435376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MekR1vkf79zx6hDhHO4dw0XGgAfid+zxEfjnfq9iFoY=;
        b=XGS8xLbO4wMn6rBK1XScmGPdO/cyscpa1Kfac4052/xXf8/TUvUpnfK9wSGGn+dH3C
         NW7APK7x2DI04lopyC58U1Z7ywhojDAqK/y1LhHkGJKCAqYhubJ4uDE+9QYDVxlqdf0Q
         YvrEnozMMxYR+thwgtlwojZFYhzID+bHEPdga8ANqArvz5mlVqjNC/BsUiraQkX/tSkk
         nTCTC/0QAax/mHyAI8Lns7+shop7li9s+ZovilvnvQIOfi/D7e2b7WazvIi4IXkRt2Vf
         yTiPWXqIn3J6mWwzjLVtus0aWM3LpySwcQ0OBHVswMrP5ipcdwNua9vY2gzOFwthK8er
         TcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710830576; x=1711435376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MekR1vkf79zx6hDhHO4dw0XGgAfid+zxEfjnfq9iFoY=;
        b=pddQEYQbHKVdK6JEs6L1FGaFtZRMr7Y/cH0yX/hzBKRljJAh4w8VKMHXcyx+FxK5xl
         xbi4xTHogkhDzBaK+gLIjygFsbLM4lFh7C8b2/4bXOvC1c+TuXW4DNjjWSA8Afdaii/M
         UuGwIOlZe3v6Kw0y2qTX/a7KNAWPWEoRn8LLLLAAhrngzXsoirLDf7QmFDRVpVF9/Pe6
         Z+dZBmkyTalS6UFMvpciJerLq4CWyA5QHKhF+9QFiIsRPv1+PkJJnlszCF1MH857hXDi
         LuXYZ0Sxd0aJw+Qh8q73iVQ/EDbPlymlplOd1Vc/cW2BQKDlpins+nkRMHNLRfCosKWP
         z1wA==
X-Forwarded-Encrypted: i=1; AJvYcCXF32ozUUV2DtpACj5vFCj0/Hy8erqI2hYUyLKgquIDXurOoMtItN1Ehcx3XnRVpN3+xT0CtbVyDByIahWS8v9VP/AC2/ArgXyhuYa9HXIBFJvcQmRkGBY6I6LxBcrubclBCrC8r4wybyE7Nz19k+CJVCL6ZcjlrJowb5WEj9qgttNX/g==
X-Gm-Message-State: AOJu0YxwzWKqtmeDs9ZNTSr0KvGDT13/qriuTscGoLRbJUZJ56BlBAXo
	vdmvA2+vi/itUoo3KMMJTAKu1AKqjxLw79bxOGTkVTLU9070f54I
X-Google-Smtp-Source: AGHT+IELy+WEtoYME8bn4yLFQ+wqr8qOT2Cs6dmJHNy7S8i5urAB8y1ed9hdTxndDnXa/NFifvMK5Q==
X-Received: by 2002:a05:6a00:1ad3:b0:6e6:4679:fa8b with SMTP id f19-20020a056a001ad300b006e64679fa8bmr2033581pfv.4.1710830576427;
        Mon, 18 Mar 2024 23:42:56 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id i3-20020a056a00004300b006e56e5c09absm9215698pfk.14.2024.03.18.23.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:42:56 -0700 (PDT)
Message-ID: <c85c3d7c-df50-4328-b260-753a036c92d8@gmail.com>
Date: Tue, 19 Mar 2024 12:12:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 lorforlinux@beagleboard.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Mark Brown <broonie@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
 Vaishnav M A <vaishnav@beagleboard.org>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <1be08004-fe29-4e0b-b0c9-7cc7af15d0b0@linaro.org>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <1be08004-fe29-4e0b-b0c9-7cc7af15d0b0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/19/24 11:33, Krzysztof Kozlowski wrote:
> On 17/03/2024 20:37, Ayush Singh wrote:
>> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
>> developed by MikroElektronika for connecting add-on boards to
>> microcontrollers or microprocessors.
>>
> ...
>
>> +title: mikroBUS add-on board socket
>> +
>> +maintainers:
>> +  - Ayush Singh <ayushdevel1325@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: mikrobus-connector
>> +
>> +  pinctrl-0: true
>> +  pinctrl-1: true
>> +  pinctrl-2: true
>> +  pinctrl-3: true
>> +  pinctrl-4: true
>> +  pinctrl-5: true
>> +  pinctrl-6: true
>> +  pinctrl-7: true
>> +  pinctrl-8: true
>> +
>> +  pinctrl-names:
>> +    items:
>> +      - const: default
>> +      - const: pwm_default
>> +      - const: pwm_gpio
>> +      - const: uart_default
>> +      - const: uart_gpio
>> +      - const: i2c_default
>> +      - const: i2c_gpio
>> +      - const: spi_default
>> +      - const: spi_gpio
>> +
>> +  mikrobus-gpios:
>> +    minItems: 11
>> +    maxItems: 12
> I don't see any of the issues resolved which I raised at v3. I think
> Russell pointed that you do not have EEPROM and that some pins are
> optional. You do not allow that.

So this patchset does not contain any EEPROM code. The bindings describe 
mikroBUS connector and not mikroBUS addon board. While it is optional 
for the mikroBUS addon board to not use sone pins (aka NC), the pins 
still exist on the connector on the device side. It is not optional to 
have pins in the host device.

> Plus I don't see him being Cced but he had quite detailed look and
> comments at your patchset, so *you are supposed to Cc* him.
>
> I also do not see Rob's comments fully addressed.
>
> Do not send next versions before resolving previous discusssion.

I apologize, I thought he was on the list by get_maintainers.pl, but it 
seems I was mistaken. I will try to remember going forward.

>> +
>> +  i2c-adapter:
>> +    description: i2c adapter attached to the mikrobus socket.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  spi-controller:
>> +    description: spi bus number of the spi-master attached to the mikrobus socket.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  uart:
>> +    description: uart port attached to the mikrobus socket
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  pwms:
>> +    description: the pwm-controller corresponding to the mikroBUS PWM pin.
>> +    maxItems: 1
>> +
>> +  spi-cs:
>> +    description: spi chip-select numbers corresponding to the chip-selects on the mikrobus socket.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    items:
>> +      - description: chip select corresponding to CS pin
>> +      - description: chip select corresponding to RST pin
>> +
>> +required:
>> +  - compatible
>> +  - pinctrl-0
>> +  - pinctrl-1
>> +  - pinctrl-2
>> +  - pinctrl-3
>> +  - pinctrl-4
>> +  - pinctrl-5
>> +  - pinctrl-6
>> +  - pinctrl-7
>> +  - pinctrl-8
>> +  - i2c-adapter
>> +  - spi-controller
>> +  - spi-cs
>> +  - uart
>> +  - pwms
>> +  - mikrobus-gpios
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    mikrobus {
>> +      compatible = "mikrobus-connector";
>> +      pinctrl-names = "default", "pwm_default", "pwm_gpio","uart_default", "uart_gpio", "i2c_default",
> Please properly wrap your code according to Linux and DTS coding style
> documents.
>
>
> Best regards,
> Krzysztof
>
Ayush Singh

