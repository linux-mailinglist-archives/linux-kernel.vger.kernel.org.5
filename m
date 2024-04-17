Return-Path: <linux-kernel+bounces-148558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4774B8A8465
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA92A1F23AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C06613E035;
	Wed, 17 Apr 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEB6FuFL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219613F00C;
	Wed, 17 Apr 2024 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360238; cv=none; b=hhQT7q4Y9Gt7FLL2cqRCgCHD2/3Qw4TlFANDPt/wa7VQB87BoaLEa4k9eAz8SJoRgvgJcx63EtDfV5s7+UBrrUbOyd7R2Kf8HUQokE8AphPQf77eznyaf17knoh3fW6VsNheURRo3UFwf92xI8d7s4eKq2UEgC+1eesamLPsymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360238; c=relaxed/simple;
	bh=JSCkvU4mUWsadZRODNiRRuHtCgBOJJNgWumAcR1e2Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJ0y3cX2RkPluYbeDvqqNEywq+WFJ9hPqDLzHg0BI/h235RaBxggf9JplVtY72Y6gyOO+AyhzQGWpM08H/tBo21HR03Z1VcqGYbH6dvHNoH8MXTnLTyj3mTmt3hSsgyoamPBloDpciUvzPJo3M+UKAXpjHkLWlBgvbGv+sX2p9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEB6FuFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83CFC072AA;
	Wed, 17 Apr 2024 13:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713360238;
	bh=JSCkvU4mUWsadZRODNiRRuHtCgBOJJNgWumAcR1e2Qo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nEB6FuFLc3EhGLKatBirbpvmAA9YKNV5eG7c8EDn1Z0S8rQoObzxrhyjgeszo3i26
	 CUjq/iQVDgM55Kw8I9XokUt+HocJIpngD97esfUkP++3N8cmNGpeybrwTSPfdErovs
	 ElLZ29dyEBy7sQrtCFg2n3FIj8sthvwb7xar4puCmUwb/yKbxqEO0qTtSYsiFiK68B
	 Avs34Oi9JymMcL9Eb9QQmIumA8lF7/3La7WkR19Cj98YDTxQf4n+48wneZfpqJmuap
	 F2w5E//3hwxTV2GkQ2OrZO/QafkREqOPgY5gZ25Tr5LUyZ6OE33UC2HJ+kd6IekmOW
	 bFaSY2BEMqV7g==
Message-ID: <b215bc1e-a7d3-477a-899d-59c3c313c74a@kernel.org>
Date: Wed, 17 Apr 2024 15:23:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>,
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
 <29f098cb-db41-4d4f-9033-a88d70ebdd0f@arinc9.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <29f098cb-db41-4d4f-9033-a88d70ebdd0f@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/04/2024 10:24, Arınç ÜNAL wrote:
> On 17/04/2024 06:15, Florian Fainelli wrote:
>>
>>
>> On 4/15/2024 2:10 AM, Arınç ÜNAL wrote:
>>> On 15.04.2024 10:57, Krzysztof Kozlowski wrote:
>>>> On 14/04/2024 22:21, Arınç ÜNAL wrote:
>>>>> NVRAM is described as both flash device partition and memory mapped NVMEM.
>>>>> This platform stores NVRAM on flash but makes it also memory accessible.
>>>>>
>>>>> As device partitions are described in board DTS, the nvram node must also
>>>>
>>>> Sorry, but we do not talk about partitions. Partitions are indeed board
>>>> property. But the piece of hardware, so NVMEM, is provided by SoC.
>>>>
>>>>> be defined there as its address and size will be different by board. It has
>>>>> been widely described on at least bcm4709 and bcm47094 SoC board DTS files
>>>>> here.
>>>>
>>>> These not proper arguments. What you are saying here is that SoC does no
>>>> have nvram at address 0x1c08000. Instead you are saying there some sort
>>>> of bus going out of SoC to the board and on the board physically there
>>>> is some NVRAM sort of memory attached to this bus.
>>>
>>> Yes that is the case. NVRAM is stored on a partition on the flash. On the
>>> Broadcom NorthStar platform, the NAND flash base is 0x1c000000, the NOR
>>> flash base is 0x1e000000.
>>>
>>> For the board in this patch, the flash is a NAND flash. The NVRAM partition
>>> starts at address 0x00080000. Therefore, the NVRAM component's address is
>>> 0x1c080000.
>>
>> Because the flash is memory mapped into the CPU's address space, a separate node was defined since it is not part of the "soc" node which describes the bridge that connects all of the peripherals.
>>
>> Whether we should create an additional bus node which describes the bridge being used to access the flash devices using the MMIO windows is debatable. Rafal, what do you think?
> 
> Will this block this patch series? If not, I'd like to submit the next
> version with Krzysztof's comments on earlycon and stdout-path addressed.

Why are you so impatient? The review process takes time and your
reluctance to take responsibility for issues here are no helping.

Best regards,
Krzysztof


