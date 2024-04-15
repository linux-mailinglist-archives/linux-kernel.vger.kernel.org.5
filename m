Return-Path: <linux-kernel+bounces-144820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBAD8A4B29
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B26E1C2136E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DE93C488;
	Mon, 15 Apr 2024 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="o8LwR7fh"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F6E3BBF0;
	Mon, 15 Apr 2024 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713172267; cv=none; b=jy9hvr7OFf8NvHMKbX+uFaKPJz+sw+k9KhW97lD8RagxSl2+CC/VclycpKXffbxnWAC++7Hh9flmY4em0jnBy8GxsZfz+VG2PFnhNUsL7dbpK+iMUnqPw+waYPJ0X4n1/OF90GqtxkEeiBKDUp10bRzo3jGLGYsbhruA6hAFHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713172267; c=relaxed/simple;
	bh=5gS3HAEyiIt2xs4qyJW1Aavxa3MAFTLia1wWYFx0ySY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pu3ucUgi5P80hRKn5CdFogLEY4Nr4jEbz7wMz1S8IvZtdy9TFFU22+uN3BAF6ILpUtUArRKY3oV/bpUnVNQN7yV6xFCHqqRk6DguI24I7P06W3gmPYQH4NR36YHted4ZmCR2jXHz0D6IWxSwQtG43cFqOVLj58CdM5vmzKOmD0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=o8LwR7fh; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D9F22000B;
	Mon, 15 Apr 2024 09:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713172257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CNj8sphrF2+SiBow5PBnuyEwJMzJ7P/0tyqEvIc9L8g=;
	b=o8LwR7fhwk2bxkYUj6hwB6xXojxK5MYd25pyHNkg7m1olyQhS3e8QCDGXAPQf8656mP1GG
	kD8lygC22LAXUoQlRWifQVPDzQl0xV3D1OswLLTYb99X88FVfS6ZuvJ662HC5pwrkc/+Pm
	t7qICZZG7KPhK4KZtm/EvjAFcsk4OjsS2V6t5pAakMibAHZkbmX9Dgb178fUwPT8Tsf7w5
	kBIZWKgIwSTYZxMEfv2tqqOZj+1YtP+m6HQeOh09EKdPUcNV5S2qnWT7JZguKdhmKJeLfY
	p+S1nw6hicJOBRNgKpG2SVUlA+63NgKMZkzunAv6v/BaZ/7ubyJQyF9wdGyK4A==
Message-ID: <00ba4593-d720-419a-a97d-37c402c91e44@arinc9.com>
Date: Mon, 15 Apr 2024 12:10:43 +0300
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
 <85261d11-d6cb-4718-88d9-95a7efe5c0ab@arinc9.com>
 <e6cfe735-0a46-4c07-90ee-4ae25c921b03@kernel.org>
 <335cdd4b-7309-4633-9b4f-6487c72c395c@arinc9.com>
 <07c9c5f5-c4b9-44d6-b909-5aa306f56898@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <07c9c5f5-c4b9-44d6-b909-5aa306f56898@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 15.04.2024 10:57, Krzysztof Kozlowski wrote:
> On 14/04/2024 22:21, Arınç ÜNAL wrote:
>> NVRAM is described as both flash device partition and memory mapped NVMEM.
>> This platform stores NVRAM on flash but makes it also memory accessible.
>>
>> As device partitions are described in board DTS, the nvram node must also
> 
> Sorry, but we do not talk about partitions. Partitions are indeed board
> property. But the piece of hardware, so NVMEM, is provided by SoC.
> 
>> be defined there as its address and size will be different by board. It has
>> been widely described on at least bcm4709 and bcm47094 SoC board DTS files
>> here.
> 
> These not proper arguments. What you are saying here is that SoC does no
> have nvram at address 0x1c08000. Instead you are saying there some sort
> of bus going out of SoC to the board and on the board physically there
> is some NVRAM sort of memory attached to this bus.

Yes that is the case. NVRAM is stored on a partition on the flash. On the
Broadcom NorthStar platform, the NAND flash base is 0x1c000000, the NOR
flash base is 0x1e000000.

For the board in this patch, the flash is a NAND flash. The NVRAM partition
starts at address 0x00080000. Therefore, the NVRAM component's address is
0x1c080000.

> 
> 
>>
>>>
>>> 2. You cannot have MMIO node outside of soc. That's a W=1 warning.
>>
>> I was not able to spot a warning related to this with the command below.
>> The source code directory is checked out on a recent soc/soc.git for-next
>> tree. Please let me know the correct command to do this.
>>
>> $ make W=1 dtbs
>> [...]
>>     DTC     arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb
>> arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0.dtsi:10.18-19.5: Warning (avoid_unnecessary_addr_size): /nand-controller@18028000/nand@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>>     also defined at arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0-bch8.dtsi:13.9-17.3
>>     also defined at arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts:137.9-160.3
>> arch/arm/boot/dts/broadcom/bcm-ns.dtsi:24.28-47.4: Warning (unique_unit_address_if_enabled): /chipcommon-a-bus@18000000: duplicate unit-address (also used in node /axi@18000000)
>> arch/arm/boot/dts/broadcom/bcm-ns.dtsi:323.22-328.4: Warning (unique_unit_address_if_enabled): /mdio@18003000: duplicate unit-address (also used in node /mdio-mux@18003000)
> 
> Hm, indeed, that way it works. Actually should work if we allow soc@0
> and memory@x, obviously.

I was a bit confused with memory@x too.

> 
> Anyway, it is outside of soc node and soc dtsi, which leads to previous
> point - you claim that it is not physically in the SoC package. How is
> it connected? If it is on the board, why does it have brcm compatible,
> not some "ti,whatever-eeprom-nvram"?

I don't know what to tell you. I don't know this set of SoCs' dt-bindings.
I am merely submitting a board device tree source file. It would be great
if this didn't block this patch series and this conversation was further
discussed with Rafal who maintains this set of SoCs' dt-bindings, from what
I remember.

Arınç

