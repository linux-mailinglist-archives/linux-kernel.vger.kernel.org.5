Return-Path: <linux-kernel+bounces-107055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E326B87F704
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BFE282AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F066648CFC;
	Tue, 19 Mar 2024 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDlgJ/ke"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2B4597B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827904; cv=none; b=qIOk9hUaIsWcGlh77X+I5lG5WkDUTCaBlOFuwxpLzAiBDE7fdXRZ05Ht1O2CF5onwN0Bbank/1WHXOlxspOdeMUoxjaidNQtHuP7NZAGzXbgUqyMgbt+9nH4vVo0SZxgGEb+gHv8b9Lh0wFRw0DSqpcTPtGX0QICuo9iJpCyuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827904; c=relaxed/simple;
	bh=iuILi4ybvF4jXQB5CtOgfy62ouBhBX1NWwlTy2XH6+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cit9PgPtrfTeQFYfr3Cr63fa291Gw7xJm7Q4SXkXs3GN6G2e0kUwQNaEDj30P/QsGTgSlq72+I0Iy8CgbxohIm7PwcWjD4iAIaz25KZTT0PlatuMeXWHUZ0sD2eBKOqt9/HwwU6DokKz+HBoZUeCPO7S83g1gmaQeIAK4k8rHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kDlgJ/ke; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46ba938de0so264674766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710827900; x=1711432700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AHZxkIrQigLNKh0NYZ3VY9vjzcY5knHl+RRNaM0i/mU=;
        b=kDlgJ/kecoQfeAVA/U2LRXGpJKlvtPKurIhy6+D/MpePVgJ7aV6VCpkxBhcfZ8fIMI
         qXG5klP8Ts3anRidG3xTH41fZKvgVfjn/kPR/3eFzG/fRNN3K8JuVAcoZadQtH47jwaF
         s1oM8w9KaMci742yuF3Wx+SgqHNA6tg5OZCPiq9LCKefx4MxVI+CYBknBc2c2E8VIte+
         D0omgVGhnKaOyikbW2b4gGhWKQFj0Vd1FjQ2Fz+kzhhvBhellV+QovjYrjgFeTFIMHBh
         PjdNtyUr80JSfgb63vlu57JjiYHPG/5B2MEpvNROqTQsxpyoSmJn8ye1ZH0BOIKBTaUO
         /e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710827900; x=1711432700;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHZxkIrQigLNKh0NYZ3VY9vjzcY5knHl+RRNaM0i/mU=;
        b=YLEKHN0j6gvoNlAUKsaGmLhUazJnCxDQ9tnpnEh54eadYMi5vXh1TCkMAaChgXJPx0
         mWwOcj1jwJUF9J2Fxzcsyzr8WS7UU87jT7+5VzzN0e+u5NyWbeYIpp9PfyNKDTIlKpU8
         1bsIfnvrp6McCuRVGMbmBngkJX+FvEPkAOflwe3KPloxpBPeFi3n6DO4wByCbwklFDB7
         rd663YLnoTTU1JN11vs3Ms0QeYVcTPKs/Ko2I4eWPn6A7IStgshdVqLSbOKN30MoOGFm
         F1aTLZpsk4p1F7Ft6Lh+Ur9UfXE5PrkNaN25XKSeq+TcfwKSC46N6dBjcyQYAsVkkF2v
         afCA==
X-Forwarded-Encrypted: i=1; AJvYcCUfNEn30DYOMkUWPg/8VAhVAmAfuuhjlabd0NunoKIER4N/dipl2tLLc7kqp8gElxE04OO6cpHDzHeCvPb/X49CqIEGHhNmGkFWINj3
X-Gm-Message-State: AOJu0YwZyZMSeykBiUOkI0/VyZ+mIp7A1xUi2vueo3ruG9fPWkiREZg5
	qzJN/krZa1sqwnmvwZtVpFjZG+V7r4or5gIGhONRTOe3KdenWF2G87jc7FJn7l0=
X-Google-Smtp-Source: AGHT+IHwCkG40hy/SFzMED/6wGkOQzF7IaTU5dKiPXmf1qRgBL8tjx21tNtw6xjZGClaExB5EjL6IA==
X-Received: by 2002:a17:906:2787:b0:a46:4771:4611 with SMTP id j7-20020a170906278700b00a4647714611mr8493593ejc.36.1710827900213;
        Mon, 18 Mar 2024 22:58:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id lg20-20020a170906f89400b00a4664e6ad8esm5616547ejb.169.2024.03.18.22.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 22:58:19 -0700 (PDT)
Message-ID: <0f3f56d4-3381-44f1-91bc-c126f3ced085@linaro.org>
Date: Tue, 19 Mar 2024 06:58:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: Ayush Singh <ayushdevel1325@gmail.com>, Michael Walle
 <mwalle@kernel.org>, open list <linux-kernel@vger.kernel.org>
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
 Vaishnav M A <vaishnav@beagleboard.org>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
 <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2024 18:20, Ayush Singh wrote:
> On 3/18/24 17:52, Michael Walle wrote:
> 
>> On Sun Mar 17, 2024 at 8:37 PM CET, Ayush Singh wrote:
>>> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
>>> developed by MikroElektronika for connecting add-on boards to
>>> microcontrollers or microprocessors.
>>>
>>> mikroBUS is a connector and does not have a controller. Instead the
>>> software is responsible for identification of board and setting up /
>>> registering uart, spi, i2c, pwm and other buses. Thus it needs a way to
>>> get uart, spi, i2c, pwm and gpio controllers / adapters.
>>>
>>> A mikroBUS addon board is free to leave some of the pins unused which
>>> are marked as NC or Not Connected.
>>>
>>> Some of the pins might need to be configured as GPIOs deviating from their
>>> reserved purposes Eg: SHT15 Click where the SCL and SDA Pins need to be
>>> configured as GPIOs for the driver (drivers/hwmon/sht15.c) to work.
>>>
>>> For some add-on boards the driver may not take care of some additional
>>> signals like reset/wake-up/other. Eg: ENC28J60 click where the reset line
>>> (RST pin on the mikrobus port) needs to be pulled high.
>>>
>>> Here's the list of pins in mikroBUS connector:
>>> Analog - AN
>>> Reset - RST
>>> SPI Chip Select - CS
>>> SPI Clock - SCK
>>> SPI Master Input Slave Output - MISO
>>> SPI Master Output Slave Input - MOSI
>>> VCC-3.3V power - +3.3V
>>> Reference Ground - GND
>>> PWM - PWM output
>>> INT - Hardware Interrupt
>>> RX - UART Receive
>>> TX - UART Transmit
>>> SCL - I2C Clock
>>> SDA - I2C Data
>>> +5V - VCC-5V power
>>> GND - Reference Ground
>>>
>>> Additionally, some new mikroBUS boards contain 1-wire EEPROM that contains
>>> a manifest to describe the addon board to provide plug and play
>>> capabilities.
>>>
>>> Link: https://www.mikroe.com/mikrobus
>>> Link:
>>> https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standard-specification-v200.pdf
>>> mikroBUS specification
>>> Link: https://www.mikroe.com/sht1x-click SHT15 Click
>>> Link: https://www.mikroe.com/eth-click ENC28J60 Click
>>> Link: https://www.mikroe.com/clickid ClickID
>>>
>>> Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
>>> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
>>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>>> ---
>>>   .../connector/mikrobus-connector.yaml         | 113 ++++++++++++++++++
>> See also
>> https://lore.kernel.org/r/YmFo+EntwxIsco%2Ft@robh.at.kernel.org/
>>
>> Looks like this proposal doesn't have the subnodes. How do you
>> attach a kernel driver to it's spi port for example? Only through
>> the manifest files?
>>
>> -michael
> 
> 
> So I looked at the Patch, and it seems the approach of fundamentally 
> different than this PR. So, let me try to explain what this patch set 
> does for an add-on board using SPI.
> 
> The device tree defines the SPI controller associated with mikroBUS SPI 
> pins. The driver on match queries and takes a reference to the SPI 
> controller but does nothing with it. Once a mikroBUS add-on board is 
> detected (by passing manifest using sysfs or reading from 1-wire 
> EEPROM), the driver parses the manifest, and if it detects an SPI device 

As I understood Mikrobus does not have EEPROM.

> in manifest, it registers SPI device along with setting properties such 
> as `chip_select`, `max_speed_hz`, `mode`, etc., which are defined in the 
> manifest. On board removal, it unregisters the SPI device and waits for 
> a new mikroBUS board to be detected again.

You explained drivers, not hardware for DT.

> 
> It is also possible for SPI not to be used by a device, in which case, 
> no SPI device is registered to the controller. It is also possible that 
> the SPI pins will be used as normal GPIOs. Everything is identified from 
> the manifest.


Best regards,
Krzysztof


