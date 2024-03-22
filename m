Return-Path: <linux-kernel+bounces-111936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44AC8872FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D845C1C216B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A365BCA;
	Fri, 22 Mar 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceV+3LpG"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B326D62801;
	Fri, 22 Mar 2024 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131792; cv=none; b=BM4Gm5EuSiS1trrEZkAtitlpbi4YSQOAm05BBSmex0uqkeXKgm599xFWfX4FNClS/TmaRxx/oOOcfsopoVZmoOiAqJL3i0Y220W+jfaVse+lupHUTkE1LO64tFrjxor1BhZkVe7B2lqPRy33gdE48JtquDzJAlJPacAk/SYEfxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131792; c=relaxed/simple;
	bh=tqZKCAjqBBpQUKUy71DyJ8nm3DbNBXriXm91d/RLGEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlrwrOuLOzz9xbtmPwLo6E0qxdbL/QoGLuEio30hLrmv6/OXjAhtFyAcFoNE+NRI57QV/8qA4rXGv9jlX7McPHFLzEt0FmN9gbubunlycMtH6TXk3GtmhkhUW7dYAqkEDkRx23QTaEaTPSwnDt6THN3ChoV7wUsSGzlFY9wdhZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceV+3LpG; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-788598094c4so132539785a.0;
        Fri, 22 Mar 2024 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711131788; x=1711736588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVym+5J84D0U9MB20cuLgiHbdn7KsrTiTTYLm5nU3Ns=;
        b=ceV+3LpGIBIVnCrkM0E5nvCAqdu8eAl42O5G/m4cUiCR/6yfnTsh5hMfFsPMoHaF2i
         WFaF0PEeJklbIacinOCwgN1tX/Be0g7/lYaJNY7QHFw2f8/OXH3GCZLiuneYkW9spzXH
         Y4kkryQ+v4pkaESS7ZATtwqaSDEXMS6hTnAJgEAbiFm9ROJHe+S1jkSBIQKyNl7sLKgT
         rVmDl85H82EFkdq0CMObOPzoRgLuVWkqcjD5ez8/JGi5uVmpRQdNjZusrn4zPw43TqPD
         ilv3MV1X668AMtaRnBjjpk5VzWII5Fi2lFWa83vSeJ+o8Z06BOYKGpoqxYjo7kNmod4g
         cbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711131788; x=1711736588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVym+5J84D0U9MB20cuLgiHbdn7KsrTiTTYLm5nU3Ns=;
        b=w5DSIyqpEGfTaxX0m7q1BSSJQNN+lIw6ZMzStTViPtY9zd25Y99z2f8nbAD0iTwSHH
         Fut7ywqrd2wd0dAsN0c8Tzq31gdhlzCoNdPGPFrTXBeVpitrpGUV03TvizXhqibHMMkr
         aHk/3rSYPP/h9Fy1DS4h63Wc1n8l5M0XJah6ROu11LIknM8JFpUHpBmiziT0Ttf8MrxJ
         Yf4kInMZsaQ2ELQFrVKRlQ47fDYJ5fOcBLFllNrTEdwnJZU9u9HJDB5a4ZsWY+citwsP
         A5pvLViJ3qP70Wh4e2kAQtEQlaWTXe0Oqeq7hGHkGCDvFsuRfbBiEnTyhQDwKpAnTnhx
         PMaw==
X-Forwarded-Encrypted: i=1; AJvYcCX6A1zuRZcpXqKPKSQoQ3oKydoTYONw3i4xnn2up78EZFqOCi8r/BykODgkyoVQWTfIO/Gv44L39kXDzaQcnJD+RRAeTSxwpOJeNWuZSyWAS6ElQm93uRMNwEBOKexbb1QWckieng==
X-Gm-Message-State: AOJu0Yw7/5Ooy41RX9NkUYdu5hNIhphdk/OZIKu5YbgxQ5+g6Nvuagup
	5Cxt+7eHzZvwX5rcibxSgHRTc6cOFlDfmWkv616UHMkDs7TyysK1xW410YbG7K4=
X-Google-Smtp-Source: AGHT+IG/LMCZJH7aXi9h/am5L+n244m9THHyeSa1Xy+XIaj8rR+qWj8t1DixCN81CE+f8Df4CyPlww==
X-Received: by 2002:a05:6a21:329e:b0:1a3:a89b:a70a with SMTP id yt30-20020a056a21329e00b001a3a89ba70amr394321pzb.37.1711131352895;
        Fri, 22 Mar 2024 11:15:52 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78c06000000b006e5af565b1dsm43048pfd.201.2024.03.22.11.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 11:15:52 -0700 (PDT)
Message-ID: <711ff5ea-244d-4b64-a39c-3f2da63e30c0@gmail.com>
Date: Fri, 22 Mar 2024 23:45:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: open list <linux-kernel@vger.kernel.org>
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
 Vaishnav M A <vaishnav@beagleboard.org>, Michael Walle <mwalle@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <20240317193714.403132-2-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/24 01:07, Ayush Singh wrote:

> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
> developed by MikroElektronika for connecting add-on boards to
> microcontrollers or microprocessors.
>
> mikroBUS is a connector and does not have a controller. Instead the
> software is responsible for identification of board and setting up /
> registering uart, spi, i2c, pwm and other buses. Thus it needs a way to
> get uart, spi, i2c, pwm and gpio controllers / adapters.
>
> A mikroBUS addon board is free to leave some of the pins unused which
> are marked as NC or Not Connected.
>
> Some of the pins might need to be configured as GPIOs deviating from their
> reserved purposes Eg: SHT15 Click where the SCL and SDA Pins need to be
> configured as GPIOs for the driver (drivers/hwmon/sht15.c) to work.
>
> For some add-on boards the driver may not take care of some additional
> signals like reset/wake-up/other. Eg: ENC28J60 click where the reset line
> (RST pin on the mikrobus port) needs to be pulled high.
>
> Here's the list of pins in mikroBUS connector:
> Analog - AN
> Reset - RST
> SPI Chip Select - CS
> SPI Clock - SCK
> SPI Master Input Slave Output - MISO
> SPI Master Output Slave Input - MOSI
> VCC-3.3V power - +3.3V
> Reference Ground - GND
> PWM - PWM output
> INT - Hardware Interrupt
> RX - UART Receive
> TX - UART Transmit
> SCL - I2C Clock
> SDA - I2C Data
> +5V - VCC-5V power
> GND - Reference Ground
>
> Additionally, some new mikroBUS boards contain 1-wire EEPROM that contains
> a manifest to describe the addon board to provide plug and play
> capabilities.
>
> Link: https://www.mikroe.com/mikrobus
> Link:
> https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standard-specification-v200.pdf
> mikroBUS specification
> Link: https://www.mikroe.com/sht1x-click SHT15 Click
> Link: https://www.mikroe.com/eth-click ENC28J60 Click
> Link: https://www.mikroe.com/clickid ClickID
>
> Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>   .../connector/mikrobus-connector.yaml         | 113 ++++++++++++++++++
>   MAINTAINERS                                   |   6 +
>   2 files changed, 119 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
>
> diff --git a/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
> new file mode 100644
> index 000000000000..ee3736add41c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/mikrobus-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mikroBUS add-on board socket
> +
> +maintainers:
> +  - Ayush Singh <ayushdevel1325@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: mikrobus-connector
> +
> +  pinctrl-0: true
> +  pinctrl-1: true
> +  pinctrl-2: true
> +  pinctrl-3: true
> +  pinctrl-4: true
> +  pinctrl-5: true
> +  pinctrl-6: true
> +  pinctrl-7: true
> +  pinctrl-8: true
> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: pwm_default
> +      - const: pwm_gpio
> +      - const: uart_default
> +      - const: uart_gpio
> +      - const: i2c_default
> +      - const: i2c_gpio
> +      - const: spi_default
> +      - const: spi_gpio
> +
> +  mikrobus-gpios:
> +    minItems: 11
> +    maxItems: 12
> +
> +  i2c-adapter:
> +    description: i2c adapter attached to the mikrobus socket.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  spi-controller:
> +    description: spi bus number of the spi-master attached to the mikrobus socket.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  uart:
> +    description: uart port attached to the mikrobus socket
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  pwms:
> +    description: the pwm-controller corresponding to the mikroBUS PWM pin.
> +    maxItems: 1
> +
> +  spi-cs:
> +    description: spi chip-select numbers corresponding to the chip-selects on the mikrobus socket.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      - description: chip select corresponding to CS pin
> +      - description: chip select corresponding to RST pin
> +
> +required:
> +  - compatible
> +  - pinctrl-0
> +  - pinctrl-1
> +  - pinctrl-2
> +  - pinctrl-3
> +  - pinctrl-4
> +  - pinctrl-5
> +  - pinctrl-6
> +  - pinctrl-7
> +  - pinctrl-8
> +  - i2c-adapter
> +  - spi-controller
> +  - spi-cs
> +  - uart
> +  - pwms
> +  - mikrobus-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mikrobus {
> +      compatible = "mikrobus-connector";
> +      pinctrl-names = "default", "pwm_default", "pwm_gpio","uart_default", "uart_gpio", "i2c_default",
> +                      "i2c_gpio", "spi_default", "spi_gpio";
> +      pinctrl-0 = <&P2_03_gpio_input_pin &P1_04_gpio_pin &P1_02_gpio_pin>;
> +      pinctrl-1 = <&P2_01_pwm_pin>;
> +      pinctrl-2 = <&P2_01_gpio_pin>;
> +      pinctrl-3 = <&P2_05_uart_pin &P2_07_uart_pin>;
> +      pinctrl-4 = <&P2_05_gpio_pin &P2_07_gpio_pin>;
> +      pinctrl-5 = <&P2_09_i2c_pin &P2_11_i2c_pin>;
> +      pinctrl-6 = <&P2_09_gpio_pin &P2_11_gpio_pin>;
> +      pinctrl-7 = <&P1_12_spi_pin &P1_10_spi_pin &P1_08_spi_sclk_pin &P1_06_spi_cs_pin>;
> +      pinctrl-8 = <&P1_12_gpio_pin &P1_10_gpio_pin &P1_08_gpio_pin &P1_06_gpio_pin>;
> +      pwms = <&ehrpwm1 0 500000 0>;
> +      i2c-adapter = <&i2c1>;
> +      spi-controller = <&spi1>;
> +      spi-cs = <0 1>;
> +      uart = <&uart1>;
> +      mikrobus-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>, <&gpio0 23 GPIO_ACTIVE_HIGH>,
> +                       <&gpio0 30 GPIO_ACTIVE_HIGH>, <&gpio0 31 GPIO_ACTIVE_HIGH>,
> +                       <&gpio0 15 GPIO_ACTIVE_HIGH>, <&gpio0 14 GPIO_ACTIVE_HIGH>,
> +                       <&gpio0 4 GPIO_ACTIVE_HIGH>, <&gpio0 3 GPIO_ACTIVE_HIGH>,
> +                       <&gpio0 2 GPIO_ACTIVE_HIGH>, <&gpio0 5 GPIO_ACTIVE_HIGH>,
> +                       <&gpio2 25 GPIO_ACTIVE_HIGH>, <&gpio2 3 GPIO_ACTIVE_HIGH>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 375d34363777..69418a058c6b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14767,6 +14767,12 @@ M:	Oliver Neukum <oliver@neukum.org>
>   S:	Maintained
>   F:	drivers/usb/image/microtek.*
>   
> +MIKROBUS
> +M:	Ayush Singh <ayushdevel1325@gmail.com>
> +M:	Vaishnav M A <vaishnav@beagleboard.org>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
> +
>   MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
>   M:	Luka Kovacic <luka.kovacic@sartura.hr>
>   M:	Luka Perkov <luka.perkov@sartura.hr>


After going through all the discussions here, I have a few questions:

1. Is the old `*_register_device(controller, board_info)` style 
discouraged in favor of using device tree, at least for drivers using 
multiple fundamental buses (i2c, spi, etc)? Or is the problem just that 
these bindings do not leave open the possibility of using device tree 
overlays? Will it be fine if the dt bindings allow for dt overlays, but 
the driver still uses imperative registering of board?

2. Is the preferred way to handle virtual devices (like those created by 
greybus subsystem) now device tree? Is that one of the blockers for 
greybus i2c, spi etc to still be in staging?

3. How are virtual devices created in device tree? If I register an i2c 
adapter using `i2c_add_adapter`, is the device tree entry is dynamically 
created, which can then be used by a device tree overlay?


Ayush Singh


