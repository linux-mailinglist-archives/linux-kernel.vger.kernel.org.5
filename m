Return-Path: <linux-kernel+bounces-97106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871A487659A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1A51F21561
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6758D3BBE5;
	Fri,  8 Mar 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="mdafCrbE"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEED21DA5F;
	Fri,  8 Mar 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905738; cv=none; b=cMXS8okoZ7pD6NccXVIMjDRkTG4xNxxo+H+IeHxd+wqrrVnde0YK4PuLoz4eNregkJ2LV6nhwYQ5vmj/mQx3oSpdpKGmNPNM9wf+x8nP5xOozhp6ZQu6LzAMfTLoOauRnnuKEHsNkRt90Li34xD3wlp6+/oIY1wGsOI0SL7UA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905738; c=relaxed/simple;
	bh=vvvvYf26CIZ/Wxg5hOzKU0MiKEwKcgbx8mMiDy3OHyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8f4+BCsSqqZt1yEM7ZZC4X+Nhg7GUks4uyzvJA5ayLFuFyNoGGzcK8OfXdzajPFk4MTG0h3FKJM/bZ+lsjyiYE+6cl3XbQ79MlTEpwq2eNq5t7RCloYFXD+sUK42rzasI0P0UFFQik1LgT2osjB5YXlT3IH2dw4BarTO6NPrNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=mdafCrbE; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 599A620004;
	Fri,  8 Mar 2024 13:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1709905733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1W1uIW1yTRjaOWSrRZn4XPwWcs/FMebFW0j769IDic=;
	b=mdafCrbE238vktgOYBwyLl+3RD4vjLBbljQ4Wwj1cCVBr0Ytaw2p8D5AuTJRDZ2bILdkuM
	bzt0LDOrWPwlprR1NDCSGxokr/h7bz0UPV7wFn6WjyiQpW6yloK+NJA9sa8H5bUY6v+kA4
	MWRmEN/M5BLjRQXyJY5Lde9i8LWlF7B0J3CbhGMYb8XmWcZnLVRHKaqMbLgTA80g3JLs47
	5S+8E8cD4i2KeK431KaxiiwPR9YfR4VAFd0aRWxM4V6BigFAOnSn4QuHl02mVqtukihcQ3
	0mFNBqPQUxcDfd/ofQiFDD5qHErmLNUYiIIBJ52xkgoM2gM4qLyY7egttYMYkw==
Message-ID: <7e9221ae-e53b-475f-9b6f-4cab58b2d109@arinc9.com>
Date: Fri, 8 Mar 2024 16:48:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mips: dts: ralink: mt7621: add cell count properties
 to usb
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <0001-mips-dts-ralink-mt7621-add-cell-count-properties-to-.patch>
 <20240307223756.31643-1-justin.swartz@risingedge.co.za>
 <c445fd12-f8a8-41df-bee8-8b126b26110b@arinc9.com>
 <067071a9d57ffb09f437718cf905b121@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <067071a9d57ffb09f437718cf905b121@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 8.03.2024 16:21, Justin Swartz wrote:
> 
> On 2024-03-08 14:01, Arınç ÜNAL wrote:
>> On 8.03.2024 01:37, Justin Swartz wrote:
>>> Add default #address-cells and #size-cells properties to the
>>> usb node, which should be suitable for hubs and devices without
>>> explicitly declared interface nodes, as:
>>>
>>>    "#address-cells":
>>>      description: should be 1 for hub nodes with device nodes,
>>>        should be 2 for device nodes with interface nodes.
>>>      enum: [1, 2]
>>>
>>>    "#size-cells":
>>>      const: 0
>>>
>>> -- Documentation/devicetree/bindings/usb/usb-device.yaml
>>>
>>> This version of the patch places the properties according to
>>> the order recommended by:
>>>
>>>     Documentation/devicetree/bindings/dts-coding-style.rst
>>>
>>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
>>> ---
>>>   arch/mips/boot/dts/ralink/mt7621.dtsi | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
>>> index 5a89f0b8c..7532e17dd 100644
>>> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
>>> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
>>> @@ -289,10 +289,10 @@ usb: usb@1e1c0000 {
>>>           reg = <0x1e1c0000 0x1000
>>>                  0x1e1d0700 0x0100>;
>>>           reg-names = "mac", "ippc";
>>> -
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>>           clocks = <&sysc MT7621_CLK_XTAL>;
>>>           clock-names = "sys_ck";
>>> -
>>
>> Please keep the empty lines. It's easier to read. I don't see anything on
>> the Devicetree Sources (DTS) Coding Style that would restrict this.
> 
> The reason I removed them was due to the SoC DTSI example shown in [1]
> lacking empty lines between properties, but then using them instead as
> visual separation between properties and child nodes, or at least that's
> how I understood it when I looked at it.
> 
> Personally, I prefer the look of the SoC DTSI example - but I don't mind
> recreating the patch set with the empty lines between the properties left
> entact.
> 
> As there is a mix of property spacing and ordering styles in mt7621.dtsi
> already - what is the consensus on what a node in this file should look
> like?

There's no precise spacing style I maintain here. I simply group together
properties that describe a single attribute, and separate those that
describe different attributes.

> 
> I also don't mind following that pattern and cleaning up the whole dtsi
> according to that if it'll save us all time and energy in future.

If you'd like to improve the ordering style of the MT7621 device tree
sources accordingly with
Documentation/devicetree/bindings/dts-coding-style.rst, I'd be happy to
review those patches.

Arınç

