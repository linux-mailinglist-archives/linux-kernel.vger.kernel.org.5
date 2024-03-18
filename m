Return-Path: <linux-kernel+bounces-106435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B066287EEA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A3B1C21008
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF8855780;
	Mon, 18 Mar 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8Y/V3Mf"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B142454FB2;
	Mon, 18 Mar 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782472; cv=none; b=lhw8ZlvEldNm65SQLsZAb/JGrwn+5YHu4ugcSAk3qzLQSbcv7F3LJXmjS8PWSWR4d6/+j+JMoB9+0TkZfT/M5OGOUfozs1Idnlx121KqB5gNPk0YXzP5n0GiHSmz/yRccdmhEorC1mTdKEpY4eQ56O1kMkpBCIF0n5GtDAfNibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782472; c=relaxed/simple;
	bh=H8CEorSe8avCFphPIu3ah06E8xBOsK2aCL/dWC/0UQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uceMsSHAJORMGRHVGDuD+gHDsoUN9c7L0dCo4l5tZBmzZXTYWqxWfPgsYZ35YMyzLzMR9BOuOsKOCtjHbA87GRx9qd0eWkGl3WiGAAYnLry37d+6PYqzIVqIpHldMuoa+6Gnv+SkyTK+VLlQJiV7VDFeIOJRYTZI245+XI+BfYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8Y/V3Mf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1de0f92e649so29937765ad.0;
        Mon, 18 Mar 2024 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710782470; x=1711387270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/knzn9bTkesJADirI8KqYpzRa+RPpd7vXsAjKTfoE4=;
        b=N8Y/V3Mf7CIK39nZ+4Fnt01MJ7yjmq45HrZNkrHd0ihgSzx2o4ial+PmGjnaMVdUMv
         J9WfE5dohSvcq2NmyesgXBaJ2CA1nl1Fd/DWy824IqghRK4XmkaRLWU4VkmK2GUkNN9M
         dwvB9OLobwhqGkIycxksmmBxBgg+UqBJRayhmd5Q6ZnjBo5Y8E94ryfrPtwdbjYifvpE
         Jq7ytLfm5HFd6mn7KGxw6pzurzmuHbOGqNnVOfgfYkR2IX2pxF2UxuRzsW/CDbST6UKo
         eDAkxNt0m1HQjYL4dwIs8drL44JqptE88Ceuh4WqkTYaTFtXnoaBQIy8a1v4rtF8LoND
         osVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710782470; x=1711387270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/knzn9bTkesJADirI8KqYpzRa+RPpd7vXsAjKTfoE4=;
        b=ByR0tN2jPHGOWS3FYq5xod9BE812LZ78u7Ur8iptqI84wYaV7TR7Fc/ZQacPlw3XVm
         Y3R58PlyhPK+6lU0+Zo0nzCmE8crHXq46QMrqGMroYRn39FuRQVMCpjivFiaYoh4xFnY
         IF/kI9zaJMC+yB5MR0aVDrQrExOgrywKJbKQ2Kzw5hfjlpnEnOH5HnfVe8hjZIDXS4nj
         V1ecGz2s4kYN5386R3ksWMHlfNMJ99tbVjugJPCebcqdrtI/iJ2kvqK4rsM12ONZhPSe
         Gm2LE2By9epZT1b+H+uBTLY4jG4F+Wvjjb+mnb+uwskkyPMbQlgRuu99bqIh0b8ytjQW
         o/og==
X-Forwarded-Encrypted: i=1; AJvYcCWY9Z6MWXwrzxio43ERNTCZiGeCj6fnplagEtg14adr5XHtOBOEAbrAh8jarQ0E5tb9Fy8wG+b6kJValWLLchf+HfF1e/UX/TKmWY/I2CMUzkZSMbp7dPOUY4RkgljQU2CAfwzLEuj1vllU9zjKQ1tQO8hdFk2I4kvlQ3Sjd4Q7X5ze4g==
X-Gm-Message-State: AOJu0YwdzXAoqKqXMNp8VQ5vhyxMuNeWmOHF33vfCQObkLAo0bJctnOu
	nGooFX+mNrjKs7+Tw24rwepUCDXyBm1X7bUw8sQL7ETVN3jnBVKN
X-Google-Smtp-Source: AGHT+IEwDsNP9+G3XFWSMW4+vV0LFrP4NkkcgrwJoaAAj13Gy3eFsigEPk/8RfGXbGr0lNwTF62eRA==
X-Received: by 2002:a17:902:fc47:b0:1df:fe8a:2284 with SMTP id me7-20020a170902fc4700b001dffe8a2284mr7559061plb.8.1710782469893;
        Mon, 18 Mar 2024 10:21:09 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id lb4-20020a170902fa4400b001e0287592c4sm2177195plb.267.2024.03.18.10.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 10:21:09 -0700 (PDT)
Message-ID: <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
Date: Mon, 18 Mar 2024 22:50:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>,
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
 Vaishnav M A <vaishnav@beagleboard.org>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/24 17:52, Michael Walle wrote:

> On Sun Mar 17, 2024 at 8:37 PM CET, Ayush Singh wrote:
>> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
>> developed by MikroElektronika for connecting add-on boards to
>> microcontrollers or microprocessors.
>>
>> mikroBUS is a connector and does not have a controller. Instead the
>> software is responsible for identification of board and setting up /
>> registering uart, spi, i2c, pwm and other buses. Thus it needs a way to
>> get uart, spi, i2c, pwm and gpio controllers / adapters.
>>
>> A mikroBUS addon board is free to leave some of the pins unused which
>> are marked as NC or Not Connected.
>>
>> Some of the pins might need to be configured as GPIOs deviating from their
>> reserved purposes Eg: SHT15 Click where the SCL and SDA Pins need to be
>> configured as GPIOs for the driver (drivers/hwmon/sht15.c) to work.
>>
>> For some add-on boards the driver may not take care of some additional
>> signals like reset/wake-up/other. Eg: ENC28J60 click where the reset line
>> (RST pin on the mikrobus port) needs to be pulled high.
>>
>> Here's the list of pins in mikroBUS connector:
>> Analog - AN
>> Reset - RST
>> SPI Chip Select - CS
>> SPI Clock - SCK
>> SPI Master Input Slave Output - MISO
>> SPI Master Output Slave Input - MOSI
>> VCC-3.3V power - +3.3V
>> Reference Ground - GND
>> PWM - PWM output
>> INT - Hardware Interrupt
>> RX - UART Receive
>> TX - UART Transmit
>> SCL - I2C Clock
>> SDA - I2C Data
>> +5V - VCC-5V power
>> GND - Reference Ground
>>
>> Additionally, some new mikroBUS boards contain 1-wire EEPROM that contains
>> a manifest to describe the addon board to provide plug and play
>> capabilities.
>>
>> Link: https://www.mikroe.com/mikrobus
>> Link:
>> https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standard-specification-v200.pdf
>> mikroBUS specification
>> Link: https://www.mikroe.com/sht1x-click SHT15 Click
>> Link: https://www.mikroe.com/eth-click ENC28J60 Click
>> Link: https://www.mikroe.com/clickid ClickID
>>
>> Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
>> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>> ---
>>   .../connector/mikrobus-connector.yaml         | 113 ++++++++++++++++++
> See also
> https://lore.kernel.org/r/YmFo+EntwxIsco%2Ft@robh.at.kernel.org/
>
> Looks like this proposal doesn't have the subnodes. How do you
> attach a kernel driver to it's spi port for example? Only through
> the manifest files?
>
> -michael


So I looked at the Patch, and it seems the approach of fundamentally 
different than this PR. So, let me try to explain what this patch set 
does for an add-on board using SPI.

The device tree defines the SPI controller associated with mikroBUS SPI 
pins. The driver on match queries and takes a reference to the SPI 
controller but does nothing with it. Once a mikroBUS add-on board is 
detected (by passing manifest using sysfs or reading from 1-wire 
EEPROM), the driver parses the manifest, and if it detects an SPI device 
in manifest, it registers SPI device along with setting properties such 
as `chip_select`, `max_speed_hz`, `mode`, etc., which are defined in the 
manifest. On board removal, it unregisters the SPI device and waits for 
a new mikroBUS board to be detected again.

It is also possible for SPI not to be used by a device, in which case, 
no SPI device is registered to the controller. It is also possible that 
the SPI pins will be used as normal GPIOs. Everything is identified from 
the manifest.


Ayush Singh


