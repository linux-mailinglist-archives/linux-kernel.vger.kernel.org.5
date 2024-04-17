Return-Path: <linux-kernel+bounces-149099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2C78A8BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF901F223A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F370B208D6;
	Wed, 17 Apr 2024 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/1M7mpB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D8F9C1;
	Wed, 17 Apr 2024 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380612; cv=none; b=Hw267BxOFGjGkSpRGvf6x8ijRnDJ2BVXgkUyvEQSC/GcJzJbrswM9SDFbOTwn/sY3GUXjXszDxI6wBi3oK9ucr3IkSyGC0k0GBQsRoPRcsMQIvLqqrC9u4EoM2+3m7u5/pc7LggLNw+yn/ZOJzrqwt7pTQGaI/sq6VTjcimhWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380612; c=relaxed/simple;
	bh=rqO2Ru3dY8VMhtda5fd5IM1MOREemN1MWx0xvhbwL/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFdPPYJZHBZY6DWR6+5GPfVFN5NxHtzz3jAzgKyfTmdkJVwRd0C7ILPf/q1F459FEP81Ah7lL6vrzu0jROFUUu0IAl9lXIwLGDc/FYC/sVboQLqklEdniK6uEUhnFa3BVbliMGR1kKQFM8gvol8g1sWctzG+tdUb+rCTlZ8UfXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/1M7mpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D94C072AA;
	Wed, 17 Apr 2024 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713380611;
	bh=rqO2Ru3dY8VMhtda5fd5IM1MOREemN1MWx0xvhbwL/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K/1M7mpBQsIWBu7KuvdQ4t4AOkr4TQs7DEfnCg0RAgV9LTvEbtdBr8yBpiKyYpWog
	 bS5LQv02WWzM5O5QlseVzwRhsHzt04wB3u4UWd+0MwbuEra9cy4t7TSiXSjqWHBLzC
	 kscSNWC92xAQJSnj5dxGr1O5DHwy7DcSHG35QnhAwsTWr6ScEcoIgJrTsCpiNXwB9z
	 5WnqbDNx4A5Vq/Oz+6ZETDNBBYuVjOImEPLtP0rQ0Qy450L59GZOYKMOv4kxoyquml
	 6LIFUa5DOzlZioPnX6AKCqJNEjQmSI5ozyvhbmgezGYMFkNp+cWNphgGicxp7VWifi
	 1F32Gq8gOUl5Q==
Message-ID: <8a5a494c-48db-4f4d-a310-0103cef7d7ac@kernel.org>
Date: Wed, 17 Apr 2024 21:03:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>,
 Rafal Milecki <zajec5@gmail.com>,
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
 <00ba4593-d720-419a-a97d-37c402c91e44@arinc9.com>
 <7b465ddb-2b18-4e7f-8b03-d4e51006e1cb@broadcom.com>
 <48b2e0fd-4d7f-4bb6-aadd-804847e3250c@kernel.org>
 <eb6e33cf-0e1a-407a-bb62-9ef7202ec1ca@broadcom.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <eb6e33cf-0e1a-407a-bb62-9ef7202ec1ca@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/04/2024 18:47, Florian Fainelli wrote:
> 
> 
> On 4/17/2024 6:23 AM, Krzysztof Kozlowski wrote:
>> On 17/04/2024 05:15, Florian Fainelli wrote:
>>>
>>>
>>> On 4/15/2024 2:10 AM, Arınç ÜNAL wrote:
>>>> On 15.04.2024 10:57, Krzysztof Kozlowski wrote:
>>>>> On 14/04/2024 22:21, Arınç ÜNAL wrote:
>>>>>> NVRAM is described as both flash device partition and memory mapped
>>>>>> NVMEM.
>>>>>> This platform stores NVRAM on flash but makes it also memory accessible.
>>>>>>
>>>>>> As device partitions are described in board DTS, the nvram node must
>>>>>> also
>>>>>
>>>>> Sorry, but we do not talk about partitions. Partitions are indeed board
>>>>> property. But the piece of hardware, so NVMEM, is provided by SoC.
>>>>>
>>>>>> be defined there as its address and size will be different by board.
>>>>>> It has
>>>>>> been widely described on at least bcm4709 and bcm47094 SoC board DTS
>>>>>> files
>>>>>> here.
>>>>>
>>>>> These not proper arguments. What you are saying here is that SoC does no
>>>>> have nvram at address 0x1c08000. Instead you are saying there some sort
>>>>> of bus going out of SoC to the board and on the board physically there
>>>>> is some NVRAM sort of memory attached to this bus.
>>>>
>>>> Yes that is the case. NVRAM is stored on a partition on the flash. On the
>>>> Broadcom NorthStar platform, the NAND flash base is 0x1c000000, the NOR
>>>> flash base is 0x1e000000.
>>>>
>>>> For the board in this patch, the flash is a NAND flash. The NVRAM partition
>>>> starts at address 0x00080000. Therefore, the NVRAM component's address is
>>>> 0x1c080000.
>>>
>>> Because the flash is memory mapped into the CPU's address space, a
>>> separate node was defined since it is not part of the "soc" node which
>>> describes the bridge that connects all of the peripherals.
>>>
>>> Whether we should create an additional bus node which describes the
>>> bridge being used to access the flash devices using the MMIO windows is
>>> debatable. Rafal, what do you think?
>>
>> Sorry guys, I don't get. I don't know the addresses neither the names
>> like Broadcom Northstar, so this does not clarify me at all.
> 
> Northstar is just a code name for the BCM5301X SoC family. The SoC 
> memory map looks like this:
> 
> 0x0000_0000 ~ 0x07FF_FFFF - DDR
> 0x0800_0000 ~ 0x0FFF_FFFF - PCIe0
> 0x1800_0000 ~ 0x180F_FFFF - Core registers (that is 
> chipcommon-a-bus@18000000 and axi@18000000 in DT)
> 0x1810_0000 ~ 0x181F_FFFF - IDM registers
> 0x1900_0000 ~ 0x190F_FFFF - ARMCore registers (that is 
> mpcore-bus@19000000 in DT)
> 0x1C00_0000 ~ 0x1DFF_FFFF - NAND flash
> 0x1E00_0000 ~ 0x1FFF_FFFF - SPI-NOR flash
> 0x4000_0000 ~ 0x47FF_FFFF - PCIe1
> 0x4800_0000 ~ 0x4FFF_FFFF - PCIe2
> 0x8000_0000 ~ 0xBFFF_FFFF - DDR
> 
>  From the system diagram the CPU has 3 AXI ports to the NIC301 AXI 
> fabric, which itself has separate AXI ports to the NAND and SPI-NOR MMIO 
> interface and then different AXI and APB ports to various other peripherals.
> 
> This information was not accessible to Rafal at the time, so it would 
> not have been reasonable to expect from him to know such details.

Sure.

> 
>>
>> Please answer the simple questions:
>> 1. Is NAND flash part of SoC?
>> 2. If not, is NAND flash provided by Broadcom or anyone else?
> 
> The NAND flash is external to the SoC it is not manufactured by Broadcom 
> we have boards with Spansion, Micron, Macronix, Toshiba flashes etc.

Thanks, then this explains why this is no part of SoC and my concerns
are addressed. I have only one remaining question - you use "brcm,nvram"
compatible, which kind of suggests the NVRAM controller or part itself
is coming from Broadcom. Driver looks like software construct, but it is
so widely used that I guess that ship has sailed.

Best regards,
Krzysztof


