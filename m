Return-Path: <linux-kernel+bounces-144363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FFC8A4507
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE552814FF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166BF13698A;
	Sun, 14 Apr 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="kosZY0qE"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C68219FD;
	Sun, 14 Apr 2024 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713126079; cv=none; b=Cox+5yPLI6tdNRoC6LkgZJ6ja8CStqwf4zMxY6lFa8h5Hk5YQJFZi9TMzV2m3i33ao3fOpscVJU1PStxrclaB1XGiUtph/t5puk4/IoH0X4wyJN7hg3C8lCoVfzlGGoJo5M94r9QXKQhue1jztRzQtK75+pOPnfg6LsfxFZTQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713126079; c=relaxed/simple;
	bh=JzFLNuRjCMlM/caJA26X85O0PnN11wXSUA1cnb92poI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLhIiOESziCSmeFjGaj2V3q3YybySZqJOBF9G1FM9yes90bq6AoJl1RlTZpFs2aa26W98wTofqV/xAOc4ahOjGl/ZE3/EBfjmlEuHCAUV0f/+kU0SokyVyq3/XlWebKvtjlgmNuzoW3S0XvldzLQs5CfvSGODZObBwsqkT5gxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=kosZY0qE; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D7B51C0004;
	Sun, 14 Apr 2024 20:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713126074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FIsDi6ng2aSJz7jUrD/WiOaFEVDZgz7xD82PmhjPSY=;
	b=kosZY0qErWfQz/ChxhHR7JIVvn8JqUwL4iezepHXlGfiflkvfgiRcVPCfiQ1+xqYzKnQkk
	lxTYT53NmS0DvFzdqSFOHPFru4gUG2lcOzgOsVzGX6Z/GQtgkHJiAdjaZn6LQMPTYUbdhK
	9kqXoXWwk3zcCNKg2qG1pBwhsi6g73ebxBwysqmNcwXYw9HiYlPIcKGOp100usY1LC1UI3
	TjO67g4ZWDY0ipZ2kknAuffcd5jVG3Zu4lQ3wtxiEYJODZU7dcgBsRzBsVLZxjH7XHriK0
	Zi3z6Eqrd3d+cUDIrFWKaMWFcKmwKzZZz1j/SxnEgjbq7lrISXf/ssBJmfsLWQ==
Message-ID: <335cdd4b-7309-4633-9b4f-6487c72c395c@arinc9.com>
Date: Sun, 14 Apr 2024 23:21:02 +0300
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
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <e6cfe735-0a46-4c07-90ee-4ae25c921b03@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 14.04.2024 22:12, Krzysztof Kozlowski wrote:
> On 14/04/2024 18:59, Arınç ÜNAL wrote:
>>>> +	};
>>>> +
>>>> +	memory@0 {
>>>> +		device_type = "memory";
>>>> +		reg = <0x00000000 0x08000000>,
>>>> +		      <0x88000000 0x08000000>;
>>>> +	};
>>>> +
>>>> +	nvram@1c080000 {
>>>> +		compatible = "brcm,nvram";
>>>> +		reg = <0x1c080000 0x00180000>;
>>>
>>> Why is this outside of soc? Both soc node and soc DTSI?
>>
>> I don't maintain the SoC device tree files so I don't know. The nvram node
>> doesn't exist on any of the device tree files included by this device tree.
> 
> There are two problems here:
> 1. This looks like SoC component and such should not be in board DTS.
> Regardless whether you maintain something or not, you should not add
> incorrect code. Unless this is correct code, but then please share some
> details.

NVRAM is described as both flash device partition and memory mapped NVMEM.
This platform stores NVRAM on flash but makes it also memory accessible.

As device partitions are described in board DTS, the nvram node must also
be defined there as its address and size will be different by board. It has
been widely described on at least bcm4709 and bcm47094 SoC board DTS files
here.

> 
> 2. You cannot have MMIO node outside of soc. That's a W=1 warning.

I was not able to spot a warning related to this with the command below.
The source code directory is checked out on a recent soc/soc.git for-next
tree. Please let me know the correct command to do this.

$ make W=1 dtbs
[...]
   DTC     arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb
arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0.dtsi:10.18-19.5: Warning (avoid_unnecessary_addr_size): /nand-controller@18028000/nand@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   also defined at arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0-bch8.dtsi:13.9-17.3
   also defined at arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts:137.9-160.3
arch/arm/boot/dts/broadcom/bcm-ns.dtsi:24.28-47.4: Warning (unique_unit_address_if_enabled): /chipcommon-a-bus@18000000: duplicate unit-address (also used in node /axi@18000000)
arch/arm/boot/dts/broadcom/bcm-ns.dtsi:323.22-328.4: Warning (unique_unit_address_if_enabled): /mdio@18003000: duplicate unit-address (also used in node /mdio-mux@18003000)

Arınç

