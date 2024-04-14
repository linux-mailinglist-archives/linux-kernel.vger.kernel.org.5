Return-Path: <linux-kernel+bounces-144292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A308A443B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 261A0B22292
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B7135A4D;
	Sun, 14 Apr 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="l2iWlvqw"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B856771;
	Sun, 14 Apr 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114002; cv=none; b=Nw9wPoDwtRFCsNfXWN493Z5tK8qzkhD45D5vvrOo/IgirEzipF9Dp5U0Rcp4RH7UQC/UvRaTLxOxVU+nicEz0azWwD9eouNc3jTZFNXaRzfIQhXjBIJLZ5PH0NufZs8YYh0Q9h7VFA3+fLHgPF3XN8IMZ8REdc7Y0SV8nOIytN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114002; c=relaxed/simple;
	bh=2vuBy3JddhPuK9fJ9dNH99j+JK+Ocuh5sJ+yj+qGuyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5t96SqAWluwajBQRP2Y4x+UAuTeMmThOKxpYD5fns1Hq3ADjPqjHUhZRiR19OqbUUSf6oyhJbq7dtB5TxKWhtlXMRzXSdAqXMNlHC92IBk/38oI8ZdW+BnrhNutWhcHSRJGPymxrFvnksLimy1MuhaXx1XiZhYjRw2HaPw1Grw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=l2iWlvqw; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 45EB7C0002;
	Sun, 14 Apr 2024 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713113997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipEBFetRHAp/1hDn1rxccOCzTGrkejfX5LP8iZREH/g=;
	b=l2iWlvqw93ZguKYWf/EEd7zOtf7nArGTD28rVSvnJ1QExWcS6YD43CtrdnuA8dRuTOQyDK
	caI9PHDFXWN7vndkxzfIjzd+qySS1bClcaPovKPT+LXMDjEH113OxG06x7PNPfw6uDelnC
	5HhlOxXzeJe6O59mh+hUX4QfqpM/OZ34pAUi5cB2/vaWzGire0ACgTR6vqIZQvvqmwdXT0
	vfKD/eEpilCNPtK85S5H1NibRGffTYGjs5tRauaLkEz4+WOHqqxQ92S3U8XX8v3WUSfGOS
	n5vS0vZ8RMNRKb9Z3wNQwHENDLl1OsBdTz2dAbHpqRDMrJygu+OhbqgtMt3j8Q==
Message-ID: <85261d11-d6cb-4718-88d9-95a7efe5c0ab@arinc9.com>
Date: Sun, 14 Apr 2024 19:59:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com>
 <20240414-for-soc-asus-rt-ac3200-ac5300-v1-3-118c90bae6e5@arinc9.com>
 <a88385a4-afad-4bd8-afc1-37e185e781f4@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <a88385a4-afad-4bd8-afc1-37e185e781f4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 14.04.2024 17:13, Krzysztof Kozlowski wrote:
> On 14/04/2024 13:46, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Add the device tree for ASUS RT-AC3200 which is an AC3200 router featuring
>> 5 Ethernet ports over the integrated Broadcom switch.
>>
>> Hardware info:
>> * Processor: Broadcom BCM4709A0 dual-core @ 1.0 GHz
>> * Switch: BCM53012 in BCM4709A0
>> * DDR3 RAM: 256 MB
>> * Flash: 128 MB
>> * 2.4GHz: BCM43602 3x3 single chip 802.11b/g/n SoC
>> * 5GHz: BCM43602 3x3 two chips 802.11a/n/ac SoC
>> * Ports: 4 LAN Ports, 1 WAN Port
>>
>> Co-developed-by: Tom Brautaset <tbrautaset@gmail.com>
>> Signed-off-by: Tom Brautaset <tbrautaset@gmail.com>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   arch/arm/boot/dts/broadcom/Makefile                |   1 +
>>   .../boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts   | 164 +++++++++++++++++++++
>>   2 files changed, 165 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/broadcom/Makefile b/arch/arm/boot/dts/broadcom/Makefile
>> index 7099d9560033..c61fca514775 100644
>> --- a/arch/arm/boot/dts/broadcom/Makefile
>> +++ b/arch/arm/boot/dts/broadcom/Makefile
>> @@ -64,6 +64,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
>>   	bcm47081-luxul-xap-1410.dtb \
>>   	bcm47081-luxul-xwr-1200.dtb \
>>   	bcm47081-tplink-archer-c5-v2.dtb \
>> +	bcm4709-asus-rt-ac3200.dtb \
>>   	bcm4709-asus-rt-ac87u.dtb \
>>   	bcm4709-buffalo-wxr-1900dhp.dtb \
>>   	bcm4709-linksys-ea9200.dtb \
>> diff --git a/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts b/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts
>> new file mode 100644
>> index 000000000000..8640dda211ae
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts
>> @@ -0,0 +1,164 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>> +/*
>> + * Author: Tom Brautaset <tbrautaset@gmail.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "bcm4709.dtsi"
>> +#include "bcm5301x-nand-cs0-bch8.dtsi"
>> +
>> +#include <dt-bindings/leds/common.h>
>> +
>> +/ {
>> +	compatible = "asus,rt-ac3200", "brcm,bcm4709", "brcm,bcm4708";
>> +	model = "ASUS RT-AC3200";
>> +
>> +	chosen {
>> +		bootargs = "console=ttyS0,115200 earlycon";
> 
> 1. Use stdout.
> 2. Drop earlycon, it is for debugging, not regular mainline usage.

I see that bcm4708.dtsi which this device tree includes already describes
stdout-path with the same value so I'll just get rid of the chosen node
here.

> 
>> +	};
>> +
>> +	memory@0 {
>> +		device_type = "memory";
>> +		reg = <0x00000000 0x08000000>,
>> +		      <0x88000000 0x08000000>;
>> +	};
>> +
>> +	nvram@1c080000 {
>> +		compatible = "brcm,nvram";
>> +		reg = <0x1c080000 0x00180000>;
> 
> Why is this outside of soc? Both soc node and soc DTSI?

I don't maintain the SoC device tree files so I don't know. The nvram node
doesn't exist on any of the device tree files included by this device tree.

Arınç

