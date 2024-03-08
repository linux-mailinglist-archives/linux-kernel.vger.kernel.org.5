Return-Path: <linux-kernel+bounces-97079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C5C87653B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63C5285F0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C6656B83;
	Fri,  8 Mar 2024 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="opr5oXJB"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594124B29;
	Fri,  8 Mar 2024 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904289; cv=none; b=ararNmcX3f3svlkljInuBwrvPngFHPlohISeN21x5cIwuV+5+rDKn4TD77gfj/x167X1NFj4sMhCu/dxlT99n48ubo0ehCMxvmjUWTlx0/tE/clh5ox04EeQR7nTK/8zKMj0mHBXzw2NYgD+TXupHbT8sBKwoXOgBvPodS0XAe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904289; c=relaxed/simple;
	bh=EO6N1bw92GyHIduYd0hZjLOILhTNDv0lTE7ZSpHhRJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1C095zZhLOKl7HnQXRoOI9Cw0uDDadaQflJdBdfHNDEneGtdJLS+l+JgtAmDJjnnJpYxJYf8iHi5mIPMghMMMO+5wuaUPyCo0WODt+fotnlOXhO3YGc/AO1JmWbNUnlfBXNyc/gUW1YI5I4E8NW17BswvDTy2Si7SRnSXX14bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=opr5oXJB; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F7811C0007;
	Fri,  8 Mar 2024 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1709904279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4h7ZiQXl6RCyjokpJIQcZhTaIjok855YoEQWGnJoYg=;
	b=opr5oXJBfybVfKVKwrzmnp0nnEJpggoJJi0wgSdWcFgu5j+KPI3rcFVERj0wB3R1yN9tOZ
	+RZugGTlp4hQ3iPKqqnhSxm0LKsdxbJQuWWh4mHjcQ2iiyNE+4hoRylXbhuRyAg6OAzpBz
	V5pcc9lD/oXssVovG/oK/obsnqmEPmZ3NeJUK8sE0PSiowG/N2eLA3MAORqyEDXwkMMgfo
	3BECecOJbTi0jTWV7N8fiMnv2p61p9dApLlp8bWggpIicwOrWwdmVyFMHlANg2jCgCfTJ2
	ptCKtIOgWlpUFOTkNCbF1nv5NEKjkfRG1ZXVcaO3Yn37vVuJffpZ/uzdQ0/H/w==
Message-ID: <cbbbe5f8-6505-4f0f-80ce-77759e03235b@arinc9.com>
Date: Fri, 8 Mar 2024 16:24:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mips: dts: ralink: mt7621: associate uart1_pins
 with serial0
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-mips@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <CAMhs-H_eUKm7C40oCzuKwwEMZAcOJ-g4MghAfkGAmxRM0AXPUw@mail.gmail.com>
 <20240307190408.23443-1-justin.swartz@risingedge.co.za>
 <ff708cd5-efe1-47e0-8112-ac7a2658cd8d@collabora.com>
 <9634b4fe726e711bd6bec7e487caab76@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <9634b4fe726e711bd6bec7e487caab76@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 8.03.2024 15:40, Justin Swartz wrote:
> Hi Angelo
> 
> On 2024-03-08 10:41, AngeloGioacchino Del Regno wrote:
>> Il 07/03/24 20:04, Justin Swartz ha scritto:
>>> Add missing pinctrl-name and pinctrl-0 properties to declare
>>> that the uart1_pins group is associated with serial0.
>>>
>>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
>>> ---
>>>   arch/mips/boot/dts/ralink/mt7621.dtsi | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
>>> index 35a10258f..dca415fdd 100644
>>> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
>>> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
>>> @@ -123,6 +123,9 @@ serial0: serial@c00 {
>>>               reg-shift = <2>;
>>>               reg-io-width = <4>;
>>>               no-loopback-test;
>>> +
>>> +            pinctrl-names = "default";
>>> +            pinctrl-0 = <&uart1_pins>;
>>>           };
>>>             spi0: spi@b00 {
>>
>> The pins are muxed and can be either UART, or some other function that
>> is supported by the mux: this means that the pinctrl-xxx properties shall
>> *not* go into the SoC dtsi file, but in board dts files instead.
>>
>> Said differently: the usage of the UART pins is board-specific, not SoC-wide.
> 
> Thanks for the explanation. I agree that the pinctrl properties
> would make more sense in a serial node extension in a board's dts,
> but my reason for including them in the SoC's dtsi is due to the
> precedent set with these existing nodes:
> 
>    i2c
>    spi0
>    mmc
>    ethernet
>    pcie
> 
> There is also a default function declared for each of the pin
> groups defined under the pinctrl node. These functions co-incide
> with what is intended for each of those device nodes to function
> correctly, rather than in the alternative GPIO-mode.
> 
> So I thought that sticking with that existing pattern would get
> the least resistance from the community.
> 
> I can imagine how moving the pinctrl node to the board dts, and
> then moving all of the pinctrl properties associated with device
> nodes to their board dts references could be a better separation
> logically.
> 
> What do you recommend?

As a maintainer, this is the logic I follow on the MT7621 device tree
source files regarding the description of pin groups:

- Claim the relevant pin group with the default function (pinctrl-names &
   pinctrl-0) on the node that describes a component of the SoC.

- Keep the node disabled and leave it to the board DTS file to enable it.

I don't disable serial@c00 as we can expect every board to use it. Same
goes for ethernet@1e100000. Some boards use the pins on the rgmii2 pin
group as GPIO, so the pinctrl-0 property on ethernet@1e100000 is
overwritten on the board DTS file without rgmii2_pins listed.

So I'm fine with this patch as is.

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

