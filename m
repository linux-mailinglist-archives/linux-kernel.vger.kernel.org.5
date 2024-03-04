Return-Path: <linux-kernel+bounces-90793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29E087051A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49291C236A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301313B29A;
	Mon,  4 Mar 2024 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZwIb9/L8"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E843D977;
	Mon,  4 Mar 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565145; cv=none; b=eKcIvX2J5QXStWWLiMGMNyvBjbchTv7NaxJk5br/otN0s0SZuUqg707ag1OUnYyDUPEQI5bvhpVRoj6lJA6wu3+SxfvQXsz4dcgSMcNUgOYdZzn29YNG2dbgh+qx4OtzEHkuiW2kkzRqVcWYXNW6IO4hdEKsXfwTjIOgqd2GA0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565145; c=relaxed/simple;
	bh=b0p50hTtt8W7peOgfISHPiGdFO1VppSjrn+SSf5nf3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3jwb6kVNTADS82rg1+DeNqTIYcqKuw4Zg2zLUL1bMJ4dFsMDfTnsNXWsaTl/niqzzgBR+9qz+TsxeRuWeWHNhaCOUdOOalBB4tmowsNvtkQI+qOisyYzKjrXi9AVE1F9waCEGYUEIBiAJSQnZ1Woh+FwqP6wLNsIJ8NuMhpBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZwIb9/L8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB00E240003;
	Mon,  4 Mar 2024 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709565141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbiwlUjr6ExtcFQ9Ws/RMeHGGDWtQPpyfYEDdyzTn7Y=;
	b=ZwIb9/L8b9+P8hLQkwWecey4tX3uV5MxStei82bELTW70MoNAszGdfg9U+L17+0xYPJ7TV
	mPV4eMjTgI2WQZ4XQk53YcILAVAZa+SxRbX+rcRo8ZWnDa/UIMxt+9fH65HFviksUyPyJ7
	Dc2+1xpf6cg06BrR3nSY1A9A/clQxlyR+2Ootnefw4IiR88iJQNMviQgoQROwURKwKT2km
	jdWYjyZgbRL5YfDuP4hq1/M4gNpMUG7WFj/5CSALNd9AjFeoC+2Eb0iEYnK+haThLWNOZ8
	MjI/XkMV/Y6VNfSi2tohjFKhXasMgOEKmMXxSkbDmFJVIIGjjF6N8P8Tp4CCkg==
Message-ID: <021dbe50-5eb9-4552-b2bb-80d58d3eb076@bootlin.com>
Date: Mon, 4 Mar 2024 16:12:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: dp83822: support
 configuring RMII master/slave mode
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Miqu=C3=A8l_Raynal?=
 <miquel.raynal@bootlin.com>, Yen-Mei Goh <yen-mei.goh@keysight.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
 <20240222103117.526955-2-jeremie.dautheribes@bootlin.com>
 <d14ba685-dc7e-4f99-a21e-bae9f3e6bc79@lunn.ch>
 <860648fa-11f5-4e0d-ac4e-e81ea111ef31@bootlin.com>
 <68112ecb-532f-4799-912d-16d6ceb9a6f3@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
In-Reply-To: <68112ecb-532f-4799-912d-16d6ceb9a6f3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

Hi Andrew,

On 29/02/2024 22:23, Andrew Lunn wrote:
>>>> --- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
>>>> @@ -80,6 +80,22 @@ properties:
>>>>               10625, 11250, 11875, 12500, 13125, 13750, 14375, 15000]
>>>>        default: 10000
>>>> +  ti,rmii-mode:
>>>> +    description: |
>>>> +       If present, select the RMII operation mode. Two modes are
>>>> +       available:
>>>> +         - RMII master, where the PHY operates from a 25MHz clock reference,
>>>> +         provided by a crystal or a CMOS-level oscillator
>>>> +         - RMII slave, where the PHY operates from a 50MHz clock reference,
>>>> +         provided by a CMOS-level oscillator
>>>
>>> What has master and slave got to do with this?
>>>
>>> Sometimes, the MAC provides a clock to the PHY, and all data transfer
>>> over the RMII bus is timed by that.
>>>
>>> Sometimes, the PHY provides a clock to the MAC, and all data transfer
>>> over the RMII bus is timed by that.
>>>
>>> Here there is a clear master/slave relationship, who is providing the
>>> clock, who is consuming the clock. However, what you describe does not
>>> fit that. Maybe look at other PHY bindings, and copy what they do for
>>> clocks.
>>
>> In fact, I hesitated a lot before choosing this master/slave designation
>> because of the same reasoning as you. But the TI DP83826 datasheet [1] uses
>> this name for two orthogonal yet connected meanings, here's a copy of the
>> corresponding § (in section 9.3.10):
>>
>> "The DP83826 offers two types of RMII operations: RMII Slave and RMII
>> Master. In RMII Master operation, the DP83826 operates from either a 25-MHz
>> CMOS-level oscillator connected to XI pin, a 25-MHz crystal connected across
>> XI and XO pins. A 50-MHz output clock referenced from DP83826 can be
>> connected to the MAC. In RMII Slave operation, the DP83826 operates from a
>> 50-MHz CMOS-level oscillator connected to the XI pin and shares the same
>> clock as the MAC. Alternatively, in RMII slave mode, the PHY can operate
>> from a 50-MHz clock provided by the Host MAC."
>>
>> So it seems that in some cases this also fits the master/slave relationship
>> you describe.
> 
> We are normally interested in this 50Mhz reference clock. So i would
> drop all references to 25Mhz. It is not relevant to the binding, since
> it is nothing to do with connecting the PHY to the MAC, and it has a
> fixed value.
> 
> So you can simplify this down to:
> 
> RMII Master: Outputs a 50Mhz Reference clock which can be connected to the MAC.
> 
> RMII Slave: Expects a 50MHz Reference clock input, shared with the
> MAC.
> 
>> That said, would you like me to include this description (or some parts) in
>> the binding in addition to what I've already written? Or would you prefer me
>> to use a more meaningful property name?
> 
> We don't really have any vendor agnostic consistent naming. dp83867
> and dp83869 seems to call this ti,clk-output-sel. Since this is
> another dp83xxx device, it would be nice if there was consistency
> between all these TI devices. So could you check if the concept is the
> same, and if so, change dp83826 to follow what other TI devices do.


So I had a look at this ti,clk-output-sel property on the TI DP8386x 
bindings, but unfortunately it does not correspond to our use case. In 
their case, it is used to select one of the various internal clocks to 
output on the CLK_OUT pin.
In our case, we would prefer to describe the direction of the clock (OUT 
in master mode, IN in slave mode).

Given this, should we stick to "ti,rmii-mode" which is consistent with 
the datasheet terminology, or consider perhaps something like 
ti,clock-dir-sel (with possible values of in/out)?"

Best regards,
Jérémie

