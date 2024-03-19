Return-Path: <linux-kernel+bounces-107177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E85287F87C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163AC282D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539463BBCA;
	Tue, 19 Mar 2024 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfG5B1PL"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4E7535C2;
	Tue, 19 Mar 2024 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833820; cv=none; b=F+GC7/WODCsr1abN9TbQOd0bd/OnzK91OrWa56MMqBN5G8QbZvP1cLnscWWEYd5lyLMtHEse7oagPoym6W6PFURKD2vm4OK5G2Hx2b5kLcjY/DB67yKRb7pNMzUrmGpu6SQMF3uyj3J0ybISqS39lJajWbqnYCM0gC67ke6v5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833820; c=relaxed/simple;
	bh=aYKF8fYK6GaqBm60AFe1ecR/BiZetgHAp/vvF6kUymI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixNKueJste0b1mmQ/ssfG1BpPI+4mBmFvPEWqp6fCY5Gl4owdboDdn7X6U8srNFdAVrpTe4H2lbyhue8mDlZ3S40iiCIgBMWwtHSHyvG8jvwcVYBBVIM/QqRcGL1ZMYHptjwtUdYOepHTskyYTAOFirdWzWTmVgjv+okgxmibyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfG5B1PL; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a47abe2ff7so2037603eaf.0;
        Tue, 19 Mar 2024 00:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710833818; x=1711438618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YHCJlZjtshIG0jJom0kvx9m2BM/FXwZE6cIGEiQKBVE=;
        b=ZfG5B1PL4StmrktOo8YojQGwRetO0eVwjmZvwo2IH250g1VVli4QfP84bsGNIwY6Cw
         pAYsym+mVZZDamX6W++oNNIej7Ay8JfXfiI6N2bXOuG898QPofL8/Zhju1Pei2uTBoup
         ym8elF3acUdzD+e80plXy+xFGs8MYPNleIkMO2qE0DfxUWhclYcLhRl8U3xL6t0S+XoB
         KgdrGdBlxbqoxDlyr5vQT9ezDV3vUiMl5YndfRmNXi9TW6qhZtqObp9r3byU5oBneK/0
         VpJY2ltedVNHzQiEFVrm8fZhkIta3TeS8NZ3MYUNPDu4C5p/d10lo2m6m6L9ALlRIZkI
         FADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710833818; x=1711438618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHCJlZjtshIG0jJom0kvx9m2BM/FXwZE6cIGEiQKBVE=;
        b=djBq2SIyDUDDexBY0mTTH8gSTg7ZQX8qXmxmPExj9K8p2C1boLnMyIFrZsXh6ohn/x
         U9GH62TkyRaMvz3Vjd49mgHQgj2SAe3SD1fKIF7wPHgRgB+9+eonBcvmOJAACvKgCIyd
         5l4bncdays9tCjiK0SdxLzD+3kO8deJ4Uhrv6jCI1xTdj3sPgOw86ZL9X3RsLajEixg4
         03NJkZlnERERk3g1TjZ1GLhIV2s/LgOQY76KJpGNK+Spljk1kOiyL+I5vI+dH47QTmHc
         vM55JGThYjRI52G4Z0CWukS6hNfsMVa62K72qaeVqODalL3rUu7YX4NBt0Sj5B84xaW6
         fpkw==
X-Forwarded-Encrypted: i=1; AJvYcCVFGEaxH13tYFHjZrKZKYV1U+q17Fs95WjlPxejviWoPd+JeY+urLqk5EMH7fZbmb/ENfXVbIA5AJFYU7FCovmlon4Z77Xa0jzE7LDuodMBLp7Cs6ocn+KYvBwAS5ZaRjM5YIcejBGtM5rQVeuODQ+o9p1FOhboFcEyLFd0rHoEYAdPIw==
X-Gm-Message-State: AOJu0YxtRYy7kp3eMrIOz4AiG5sPUV0FpmrViBC3wobo7fuFtLEPNyiU
	uAzbgiu+Y6ZaAu2MJr75eXl8lvpCFK9x8H3pSUmwb2jNrIgcQWpK
X-Google-Smtp-Source: AGHT+IHjuPClKQPIBso0PeBaQRxcjfszD2QnTuP0HROvRIimQAr/wBK/UV5WSm8hqR9OEWW0N8sFWw==
X-Received: by 2002:a05:6358:4319:b0:17e:69fd:e8cc with SMTP id r25-20020a056358431900b0017e69fde8ccmr8283727rwc.21.1710833817767;
        Tue, 19 Mar 2024 00:36:57 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id e15-20020aa7980f000000b006e6988c64a5sm9100478pfl.208.2024.03.19.00.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 00:36:57 -0700 (PDT)
Message-ID: <c8031e17-5ae8-4794-8b8c-1736be6452d3@gmail.com>
Date: Tue, 19 Mar 2024 13:06:39 +0530
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
 Michael Walle <mwalle@kernel.org>, open list <linux-kernel@vger.kernel.org>
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
 <0f3f56d4-3381-44f1-91bc-c126f3ced085@linaro.org>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <0f3f56d4-3381-44f1-91bc-c126f3ced085@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 11:28, Krzysztof Kozlowski wrote:

> On 18/03/2024 18:20, Ayush Singh wrote:
>> On 3/18/24 17:52, Michael Walle wrote:
>>
>>> On Sun Mar 17, 2024 at 8:37 PM CET, Ayush Singh wrote:
>>>> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
>>>> developed by MikroElektronika for connecting add-on boards to
>>>> microcontrollers or microprocessors.
>>>>
>>>> mikroBUS is a connector and does not have a controller. Instead the
>>>> software is responsible for identification of board and setting up /
>>>> registering uart, spi, i2c, pwm and other buses. Thus it needs a way to
>>>> get uart, spi, i2c, pwm and gpio controllers / adapters.
>>>>
>>>> A mikroBUS addon board is free to leave some of the pins unused which
>>>> are marked as NC or Not Connected.
>>>>
>>>> Some of the pins might need to be configured as GPIOs deviating from their
>>>> reserved purposes Eg: SHT15 Click where the SCL and SDA Pins need to be
>>>> configured as GPIOs for the driver (drivers/hwmon/sht15.c) to work.
>>>>
>>>> For some add-on boards the driver may not take care of some additional
>>>> signals like reset/wake-up/other. Eg: ENC28J60 click where the reset line
>>>> (RST pin on the mikrobus port) needs to be pulled high.
>>>>
>>>> Here's the list of pins in mikroBUS connector:
>>>> Analog - AN
>>>> Reset - RST
>>>> SPI Chip Select - CS
>>>> SPI Clock - SCK
>>>> SPI Master Input Slave Output - MISO
>>>> SPI Master Output Slave Input - MOSI
>>>> VCC-3.3V power - +3.3V
>>>> Reference Ground - GND
>>>> PWM - PWM output
>>>> INT - Hardware Interrupt
>>>> RX - UART Receive
>>>> TX - UART Transmit
>>>> SCL - I2C Clock
>>>> SDA - I2C Data
>>>> +5V - VCC-5V power
>>>> GND - Reference Ground
>>>>
>>>> Additionally, some new mikroBUS boards contain 1-wire EEPROM that contains
>>>> a manifest to describe the addon board to provide plug and play
>>>> capabilities.
>>>>
>>>> Link: https://www.mikroe.com/mikrobus
>>>> Link:
>>>> https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standard-specification-v200.pdf
>>>> mikroBUS specification
>>>> Link: https://www.mikroe.com/sht1x-click SHT15 Click
>>>> Link: https://www.mikroe.com/eth-click ENC28J60 Click
>>>> Link: https://www.mikroe.com/clickid ClickID
>>>>
>>>> Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
>>>> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
>>>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>>>> ---
>>>>    .../connector/mikrobus-connector.yaml         | 113 ++++++++++++++++++
>>> See also
>>> https://lore.kernel.org/r/YmFo+EntwxIsco%2Ft@robh.at.kernel.org/
>>>
>>> Looks like this proposal doesn't have the subnodes. How do you
>>> attach a kernel driver to it's spi port for example? Only through
>>> the manifest files?
>>>
>>> -michael
>>
>> So I looked at the Patch, and it seems the approach of fundamentally
>> different than this PR. So, let me try to explain what this patch set
>> does for an add-on board using SPI.
>>
>> The device tree defines the SPI controller associated with mikroBUS SPI
>> pins. The driver on match queries and takes a reference to the SPI
>> controller but does nothing with it. Once a mikroBUS add-on board is
>> detected (by passing manifest using sysfs or reading from 1-wire
>> EEPROM), the driver parses the manifest, and if it detects an SPI device
> As I understood Mikrobus does not have EEPROM.

mikroBUS add-on boards do not need to have EEPROM, but they can have it. 
Simply put, EEPROM is not part of mikroBUS specification, but you will 
find a lot (especially newer) addon boards with support for EEPROM manifest.

Regardless, this patch actually does not contain any code for EEPROM 
support I have just mentioned it to give more context on why mikroBUS 
manifest is the focus of this patch instead of DT overlay or something 
else.

>> in manifest, it registers SPI device along with setting properties such
>> as `chip_select`, `max_speed_hz`, `mode`, etc., which are defined in the
>> manifest. On board removal, it unregisters the SPI device and waits for
>> a new mikroBUS board to be detected again.
> You explained drivers, not hardware for DT.


Yes, I was replying to the question posed by Michael. Since this happens 
in the driver and not in the devicetree, I needed to explain the working 
of the driver:


 > How do you attach a kernel driver to it's spi port for example?


For more hardware side, the bindings are for mikrobus connector rather 
than for any addon board. Thus, while an addon board might not use some 
of the pins, the connector still needs to have all the pins and 
associated controllers.

>> It is also possible for SPI not to be used by a device, in which case,
>> no SPI device is registered to the controller. It is also possible that
>> the SPI pins will be used as normal GPIOs. Everything is identified from
>> the manifest.
>
> Best regards,
> Krzysztof
>

Ayush Singh


