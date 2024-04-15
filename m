Return-Path: <linux-kernel+bounces-144709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5A28A4989
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE0E1C21787
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617AF2C85C;
	Mon, 15 Apr 2024 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPHT20zP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FAF2C1B6;
	Mon, 15 Apr 2024 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167845; cv=none; b=B2dmd57hZu0ZeRWRC+HwGaTitUO1sT1ZCMcjXWugbTVtuhSmWHg0RJF4Sdln+2CLJBws+++gYhEXsJkQ4ELlndVGWTFP8qAxmlv6E3isa2lxe4NFwCb2gJmKxqmegDCTkJahc+94z1H29GeSAq2nyqZKBnbTwpZr1kKsEQJn8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167845; c=relaxed/simple;
	bh=VMk72HLyRcA38+7muouKcqLS3YNIP0PuAQdBz4CAedY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJp4FxgGiW2mTs7Fj1VqnYikaSJ85dRFVdDleoSbNESXjqGZ4mwIzBhERd6oi/REjjNLoV7WIvhUeGeevBPTly9ToUt9ZpdsV31yXIkzyID3bIHRvRoKlI58AtWQX/N5Q0U37MymmU4edavMTAZCdNsugDMrlLpyEOAWbIjY+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPHT20zP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3A1C113CC;
	Mon, 15 Apr 2024 07:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713167845;
	bh=VMk72HLyRcA38+7muouKcqLS3YNIP0PuAQdBz4CAedY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IPHT20zP88ukcSnJTf+pXwf/RhjZg4/a3cCzF/4UrinIjyffepsYc/rGnXMD/zNuV
	 7Uz+J2TIJuCwLilayDLsHFvgGxg6CctohB2mm3OFNUFKY6tIOMxi+3c8mqAIt08fNg
	 Lg7hCTSCaEJKotyxWVvUofykSqO7HjPfDYwESD5Dp/o4nmIvaf3ugeBH9PckOr4WVJ
	 xVy1WBBs1JV+cDnd0To1uw9mnalMnp79j3WOHHMUFtAlIU52FsCe68NnvY7sFblHe8
	 vXvoM9DY7EEHXy9jp+3K5P+KuRPiPP0+2Q9Sr7Reofo3qe0UrMGjhfMo9T/nbdqh0o
	 79HnFs9jt+uOg==
Message-ID: <07c9c5f5-c4b9-44d6-b909-5aa306f56898@kernel.org>
Date: Mon, 15 Apr 2024 09:57:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
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
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <335cdd4b-7309-4633-9b4f-6487c72c395c@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/04/2024 22:21, Arınç ÜNAL wrote:
> On 14.04.2024 22:12, Krzysztof Kozlowski wrote:
>> On 14/04/2024 18:59, Arınç ÜNAL wrote:
>>>>> +	};
>>>>> +
>>>>> +	memory@0 {
>>>>> +		device_type = "memory";
>>>>> +		reg = <0x00000000 0x08000000>,
>>>>> +		      <0x88000000 0x08000000>;
>>>>> +	};
>>>>> +
>>>>> +	nvram@1c080000 {
>>>>> +		compatible = "brcm,nvram";
>>>>> +		reg = <0x1c080000 0x00180000>;
>>>>
>>>> Why is this outside of soc? Both soc node and soc DTSI?
>>>
>>> I don't maintain the SoC device tree files so I don't know. The nvram node
>>> doesn't exist on any of the device tree files included by this device tree.
>>
>> There are two problems here:
>> 1. This looks like SoC component and such should not be in board DTS.
>> Regardless whether you maintain something or not, you should not add
>> incorrect code. Unless this is correct code, but then please share some
>> details.
> 
> NVRAM is described as both flash device partition and memory mapped NVMEM.
> This platform stores NVRAM on flash but makes it also memory accessible.
> 
> As device partitions are described in board DTS, the nvram node must also

Sorry, but we do not talk about partitions. Partitions are indeed board
property. But the piece of hardware, so NVMEM, is provided by SoC.

> be defined there as its address and size will be different by board. It has
> been widely described on at least bcm4709 and bcm47094 SoC board DTS files
> here.

These not proper arguments. What you are saying here is that SoC does no
have nvram at address 0x1c08000. Instead you are saying there some sort
of bus going out of SoC to the board and on the board physically there
is some NVRAM sort of memory attached to this bus.


> 
>>
>> 2. You cannot have MMIO node outside of soc. That's a W=1 warning.
> 
> I was not able to spot a warning related to this with the command below.
> The source code directory is checked out on a recent soc/soc.git for-next
> tree. Please let me know the correct command to do this.
> 
> $ make W=1 dtbs
> [...]
>    DTC     arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb
> arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0.dtsi:10.18-19.5: Warning (avoid_unnecessary_addr_size): /nand-controller@18028000/nand@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>    also defined at arch/arm/boot/dts/broadcom/bcm5301x-nand-cs0-bch8.dtsi:13.9-17.3
>    also defined at arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts:137.9-160.3
> arch/arm/boot/dts/broadcom/bcm-ns.dtsi:24.28-47.4: Warning (unique_unit_address_if_enabled): /chipcommon-a-bus@18000000: duplicate unit-address (also used in node /axi@18000000)
> arch/arm/boot/dts/broadcom/bcm-ns.dtsi:323.22-328.4: Warning (unique_unit_address_if_enabled): /mdio@18003000: duplicate unit-address (also used in node /mdio-mux@18003000)

Hm, indeed, that way it works. Actually should work if we allow soc@0
and memory@x, obviously.

Anyway, it is outside of soc node and soc dtsi, which leads to previous
point - you claim that it is not physically in the SoC package. How is
it connected? If it is on the board, why does it have brcm compatible,
not some "ti,whatever-eeprom-nvram"?

Best regards,
Krzysztof


