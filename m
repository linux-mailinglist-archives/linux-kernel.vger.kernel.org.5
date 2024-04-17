Return-Path: <linux-kernel+bounces-148674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41788A85EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DF01F21962
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478B51422A5;
	Wed, 17 Apr 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="g2R5mg+K"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0F31420D0;
	Wed, 17 Apr 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364054; cv=none; b=WJAUuSg7t5zR+qnb4dixMz3hIHEf4bkTuq/qevNl58R6a/aD4rEnSfdfWHEeZ8+FnDJUmvkTggxmsjtoNxmgIl7kFKOuxiSzkqwPhyWOP4YZPjC0Ro2afMSU/vf2UyKVK98PI8BR0Quww0UYh35v1uhFYErErKhZw5rRgFx3PKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364054; c=relaxed/simple;
	bh=suRdOZdZT8ehpEWUF7y0LbYIln0iGCwzo5Xf1sGLs9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ky/vjrMEi0owB+IVW9dTPzKPR3HjY0XIUiwird4N7e2Xn0bu+DYCXo4CJRWXpr9aGrnN43wCs26wdB09jg4Qry8OX6zRGFc6Ow0ulyvh2AeOrRItj2Yd/+AcrmqJ0gfYuPPoOGQfHPfDSwW4z7CuZWLr+Jj74I21UUvPbJJ7sEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=g2R5mg+K; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 917121C0005;
	Wed, 17 Apr 2024 14:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713364049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xA6l7RFsBEkh5flTkvMEFcXnuI487losILGjxWdYq/w=;
	b=g2R5mg+KWgOM2MwrXTeGf8b9KZdc/HFuRHwdFYYr8I76CSUGhr4n9AJrDLwc8itMIkLQVz
	2ynurvw/7OoTf+OkTUlxhGzoM4TeQrOncuCEiaZbfnOgqDBAavSyufI4sfIkkJ4tP2Mb1+
	FwPaw74XUmjoTSfnp3IAYC0avIdlnYsnru0jncrFj/8cOJKNOxh/XMrLCuFpF3hZMgxhD7
	rpJjAP5zytmiPWrTo+kfREC0J6pT6CMYr0NqsNT5Rw6VMCaXlu0Xg3g6h1ey+mfBDxQmlF
	J2krC6wtL6+DLTWWfmDpMwqD9V7aQVa7C/MFsapGNW5YjynhrXFPxp3N/2CW8w==
Message-ID: <11fbce03-46e9-450f-ac60-af0540299f21@arinc9.com>
Date: Wed, 17 Apr 2024 17:27:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
To: Krzysztof Kozlowski <krzk@kernel.org>,
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
 <b215bc1e-a7d3-477a-899d-59c3c313c74a@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <b215bc1e-a7d3-477a-899d-59c3c313c74a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 17/04/2024 16:23, Krzysztof Kozlowski wrote:
> On 17/04/2024 10:24, Arınç ÜNAL wrote:
>> On 17/04/2024 06:15, Florian Fainelli wrote:
>>>
>>>
>>> On 4/15/2024 2:10 AM, Arınç ÜNAL wrote:
>>>> On 15.04.2024 10:57, Krzysztof Kozlowski wrote:
>>>>> On 14/04/2024 22:21, Arınç ÜNAL wrote:
>>>>>> NVRAM is described as both flash device partition and memory mapped NVMEM.
>>>>>> This platform stores NVRAM on flash but makes it also memory accessible.
>>>>>>
>>>>>> As device partitions are described in board DTS, the nvram node must also
>>>>>
>>>>> Sorry, but we do not talk about partitions. Partitions are indeed board
>>>>> property. But the piece of hardware, so NVMEM, is provided by SoC.
>>>>>
>>>>>> be defined there as its address and size will be different by board. It has
>>>>>> been widely described on at least bcm4709 and bcm47094 SoC board DTS files
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
>>> Because the flash is memory mapped into the CPU's address space, a separate node was defined since it is not part of the "soc" node which describes the bridge that connects all of the peripherals.
>>>
>>> Whether we should create an additional bus node which describes the bridge being used to access the flash devices using the MMIO windows is debatable. Rafal, what do you think?
>>
>> Will this block this patch series? If not, I'd like to submit the next
>> version with Krzysztof's comments on earlycon and stdout-path addressed.
> 
> Why are you so impatient? The review process takes time and your
> reluctance to take responsibility for issues here are no helping.

I have already stated that I don't maintain this architecture and I don't
know it very well, and called on at least Rafal to further discuss the
issue you've raised. I've already answered your questions to the best of my
knowledge. If I was impatient, I would declare that I have no
responsibility in the SoC dt-bindings and send the next version without a
care. What I am doing instead is confirming whether or not you or Florian
think that this SoC dt-bindings issue must be resolved before my patches
that add board DTS files go in.

Arınç

