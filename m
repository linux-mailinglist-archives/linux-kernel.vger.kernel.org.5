Return-Path: <linux-kernel+bounces-90939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E0D87070D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBDC280E39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F609481B9;
	Mon,  4 Mar 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F5NN31SA"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE191DDE9;
	Mon,  4 Mar 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569925; cv=none; b=YHKu5x3NHVcXlhhLEL7gsp8m8nTbd4Jg/AaifE8xVma33kcXJBhxdO797S2p+GXKR0pEG00S+AWSMUFFIqMz5vr/9mioOrZIOqOH563fqnWI73H5drThYHhvCETiSe2PHqOToNdqnC2i3A3x1pM1Ojt0dVedIKqg9SbI2RZS2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569925; c=relaxed/simple;
	bh=+vFU8S+QBfINigPakfidbvLfH8t5sKKvHRwRghI+MSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOLPIOs6m4MtU55PuFAF30I8b9/l3JAcjTph8AXd4nlHGN7g0OGO5jp+8H7a+ERfaB+l0a1nN4nhNSy9fdvWlPmr0VrKg3Ss5Uaac0iy19GFg6sBiyVxGGvNKWkace+yV31FyPCW8HclVl8K9T1e0y8fBoe/Eb6LvhfNXu/uVgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F5NN31SA; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 973AE20002;
	Mon,  4 Mar 2024 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709569921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/qnNib0M9GUnijyk9s7zwiVKRUpPX2GRvn3P5WKj04=;
	b=F5NN31SAPn67/H+8+2IjeoMzc+jGn9CxQT4ANWg4ABSznO2IH5W6/E/rL/jKzLbY3zi1ti
	KJcBbJi+0ddgVIyU/I4hEB3Y10wnsk7PXY9il2GKJGkQNB0BHYZsuoEy1YlP2AV+7WNYOy
	gzXVVJZr4zn6XVVv0nmiFS5Qfhg17XTVZbSgvYreIX1qDQ3cx6KRStlh+JXU+k7gzq6D35
	82h1uWDCQg9Kd8ZkcZvn8VNep/XRL5ZEaNMVRH98rsg0HMqrZ7hExrncAykCkoVHau1xmY
	UVpKOW9OakW1X74yhAByY24evUAnmThSkJ1UoKgDioYSWahVsMvbc8P0QnjGEA==
Message-ID: <70a00ad4-ee8e-4325-af09-b013247a003a@bootlin.com>
Date: Mon, 4 Mar 2024 17:31:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: dp83822: support
 configuring RMII master/slave mode
Content-Language: en-US
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
 <021dbe50-5eb9-4552-b2bb-80d58d3eb076@bootlin.com>
 <d994001c-dff2-402d-bd19-7ddb0c148805@lunn.ch>
From: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
In-Reply-To: <d994001c-dff2-402d-bd19-7ddb0c148805@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

>>> We are normally interested in this 50Mhz reference clock. So i would
>>> drop all references to 25Mhz. It is not relevant to the binding, since
>>> it is nothing to do with connecting the PHY to the MAC, and it has a
>>> fixed value.
>>>
>>> So you can simplify this down to:
>>>
>>> RMII Master: Outputs a 50Mhz Reference clock which can be connected to the MAC.
>>>
>>> RMII Slave: Expects a 50MHz Reference clock input, shared with the
>>> MAC.
>>>
>>>> That said, would you like me to include this description (or some parts) in
>>>> the binding in addition to what I've already written? Or would you prefer me
>>>> to use a more meaningful property name?
>>>
>>> We don't really have any vendor agnostic consistent naming. dp83867
>>> and dp83869 seems to call this ti,clk-output-sel. Since this is
>>> another dp83xxx device, it would be nice if there was consistency
>>> between all these TI devices. So could you check if the concept is the
>>> same, and if so, change dp83826 to follow what other TI devices do.
>>
>>
>> So I had a look at this ti,clk-output-sel property on the TI DP8386x
>> bindings, but unfortunately it does not correspond to our use case. In their
>> case, it is used to select one of the various internal clocks to output on
>> the CLK_OUT pin.
>> In our case, we would prefer to describe the direction of the clock (OUT in
>> master mode, IN in slave mode).
> 
> I would suggest we keep with the current property name, but simplify
> the description. Focus on the reference clock, and ignore the crystal.


Ok noted, thanks for your feedback! I will send a v2 containing a 
simplified description + implement your suggested changes on patch 2.

Jérémie

