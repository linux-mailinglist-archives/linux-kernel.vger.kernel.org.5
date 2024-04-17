Return-Path: <linux-kernel+bounces-148134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07C28A7E25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C351F21BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F517EF1B;
	Wed, 17 Apr 2024 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="dlprTLWJ"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3A5D8F6;
	Wed, 17 Apr 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342257; cv=none; b=CIpgM48ueXl7NE9TyydCKTxz4PgIl9YLha2B7eiujthqGWvqNu2+h9f8uR62d/q0dkcnIrjqW4Uh4O5s8uU6b7I3tXKA6zUSgbDFb8v9ib6CuiWYoNWa8zP0lB2wAJPgf0qYjIAf6m3gex/ogm3MkW/z2IQt4O5DeNaXt7Wdin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342257; c=relaxed/simple;
	bh=UnJDeGW6hTOWzM5xTq9iID1BjEcevOyGCrGHXGGwe+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Twx1wq540uT9a2MR/CKnQL1KG5KdIJWek5jxf3KyNP67l+qY5Ac/TAwVJRRARomSpfPT/eb0qwcuIFXZg41277ZVj+fjMT286Inph3hKfsPlXzPllqpxWoq4jJi1w298NLt8O2GuAR5/z5qpveGi1AeFTw+VJw92I07djqBFZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=dlprTLWJ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70A831BF20C;
	Wed, 17 Apr 2024 08:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713342251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNl2kpmyXA4EHz7sEmeC1SnU4Qf3LOV2W8Qe8fDoaho=;
	b=dlprTLWJZaB2rIyPzBM8ThbSYbelvbq/IxjTNJ7L+SPus8J681T/AATFX5fEGJ0nZlYiKu
	DCDAJecOWm5735clknwrECBHmbnsrtvhA85W4/eKi7hFufQHcVtHao+XPVuauI/tF8T2dZ
	qXFgtbJ9aH5q1IHc7RFkZiBTjmPD0MfeaHBEraCbd5hmCOBMh469nKcoMKMhG/5fWzTMq3
	XYLf9fkW6kkUW9bk/3cYcM/eaDF7yoH/+G18OkFAaIKl0MNXU42IGswTB+xarf99oJnTFk
	QUC3qaqO6aKgcgBoQ+7TZXuE1XhiLaRZXrFJYqhwXmUGTOuSxIRK6E0UmRJhvw==
Message-ID: <29f098cb-db41-4d4f-9033-a88d70ebdd0f@arinc9.com>
Date: Wed, 17 Apr 2024 11:24:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
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
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <7b465ddb-2b18-4e7f-8b03-d4e51006e1cb@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 17/04/2024 06:15, Florian Fainelli wrote:
> 
> 
> On 4/15/2024 2:10 AM, Arınç ÜNAL wrote:
>> On 15.04.2024 10:57, Krzysztof Kozlowski wrote:
>>> On 14/04/2024 22:21, Arınç ÜNAL wrote:
>>>> NVRAM is described as both flash device partition and memory mapped NVMEM.
>>>> This platform stores NVRAM on flash but makes it also memory accessible.
>>>>
>>>> As device partitions are described in board DTS, the nvram node must also
>>>
>>> Sorry, but we do not talk about partitions. Partitions are indeed board
>>> property. But the piece of hardware, so NVMEM, is provided by SoC.
>>>
>>>> be defined there as its address and size will be different by board. It has
>>>> been widely described on at least bcm4709 and bcm47094 SoC board DTS files
>>>> here.
>>>
>>> These not proper arguments. What you are saying here is that SoC does no
>>> have nvram at address 0x1c08000. Instead you are saying there some sort
>>> of bus going out of SoC to the board and on the board physically there
>>> is some NVRAM sort of memory attached to this bus.
>>
>> Yes that is the case. NVRAM is stored on a partition on the flash. On the
>> Broadcom NorthStar platform, the NAND flash base is 0x1c000000, the NOR
>> flash base is 0x1e000000.
>>
>> For the board in this patch, the flash is a NAND flash. The NVRAM partition
>> starts at address 0x00080000. Therefore, the NVRAM component's address is
>> 0x1c080000.
> 
> Because the flash is memory mapped into the CPU's address space, a separate node was defined since it is not part of the "soc" node which describes the bridge that connects all of the peripherals.
> 
> Whether we should create an additional bus node which describes the bridge being used to access the flash devices using the MMIO windows is debatable. Rafal, what do you think?

Will this block this patch series? If not, I'd like to submit the next
version with Krzysztof's comments on earlycon and stdout-path addressed.

Arınç

