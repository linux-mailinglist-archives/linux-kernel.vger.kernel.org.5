Return-Path: <linux-kernel+bounces-87527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DCC86D586
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91401C229B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFE814A4CA;
	Thu, 29 Feb 2024 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iXg3gcke"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393831428FC;
	Thu, 29 Feb 2024 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239586; cv=none; b=Fh9fb713hHEJ5gOnxdiCvFDw9k+cdwcdiHlAC0zGsSprjLoyEV18Y1y0LMqxLbjkjNb3TYu+Sgl0d8xjgYrC/E1hODcGwBb/Gfn454/kTh6wp1+LcdUbYsw6s+8CLypeaRojCKKBoM4eG+EDiMPwlIwxCpksV/0HYiTX22XYIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239586; c=relaxed/simple;
	bh=CQx3KA2MK3LEfTY+Hogj/IbqUR7C0EreWLbSRWcjetE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljFYra1fD5OLjWy3ssrc5gE6NSjom5U4jvlrOMag1MJXm6ABsk4/Ys/5xDvRmkiGSRexWeg4k9LV6FHO1NKtaD03iTZkkoYVuL48JrPQW+JyfeCwnzU73K2SZ2z391KmDXFrHlsCLDP/n4D/AwxHi+ZqZUM9BHAU9aZhl6di89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iXg3gcke; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3CEC6C0003;
	Thu, 29 Feb 2024 20:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709239575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yC2KEk65Ak+51VQmZ/7ETdOjptWIvVuBFVWdWXcNv0=;
	b=iXg3gckeA+D8GH8kI4v8U3j0+bfu1iHOWuJtk5jarRNr/NgM0PDJ4S2oQ3F6WaS7CrSvV2
	8dBJhguouJNfQB/IzuGqHhXyBkk9820M7UZkdY/abhHDqncX1F6EzrknR9OKDE1nnR3G+B
	3w5z7vVKLv5Y2NcGCexFa3HZolQAfYnNPHKB6kTsPEikSZFuIn7pBp7W8Cv/0O1ylSZlyi
	Vex4u1xlJP5CMcZxE89tOUcz/exHS2v9pwyNxp8CTC2TPDfT3ohwLmBqhCvNkx+ahJ9mng
	CDoP7BYzrC3Bwsk76Gf2+YdV6apZLRie7MpqDDEllVSxTz1dh1YMcuE8TQsuIA==
Message-ID: <860648fa-11f5-4e0d-ac4e-e81ea111ef31@bootlin.com>
Date: Thu, 29 Feb 2024 21:46:12 +0100
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
From: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
In-Reply-To: <d14ba685-dc7e-4f99-a21e-bae9f3e6bc79@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

Hi Andrew,

On 26/02/2024 16:28, Andrew Lunn wrote:
> On Thu, Feb 22, 2024 at 11:31:15AM +0100, Jérémie Dautheribes wrote:
>> Add property ti,rmii-mode to support selecting the RMII operation mode
>> between:
>> 	- master mode (PHY operates from a 25MHz clock reference)
>> 	- slave mode (PHY operates from a 50MHz clock reference)
>>
>> If not set, the operation mode is configured by hardware straps.
>>
>> Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
>> ---
>>   .../devicetree/bindings/net/ti,dp83822.yaml      | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
>> index 8f4350be689c..8f23254c0458 100644
>> --- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
>> +++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
>> @@ -80,6 +80,22 @@ properties:
>>              10625, 11250, 11875, 12500, 13125, 13750, 14375, 15000]
>>       default: 10000
>>   
>> +  ti,rmii-mode:
>> +    description: |
>> +       If present, select the RMII operation mode. Two modes are
>> +       available:
>> +         - RMII master, where the PHY operates from a 25MHz clock reference,
>> +         provided by a crystal or a CMOS-level oscillator
>> +         - RMII slave, where the PHY operates from a 50MHz clock reference,
>> +         provided by a CMOS-level oscillator
> 
> What has master and slave got to do with this?
> 
> Sometimes, the MAC provides a clock to the PHY, and all data transfer
> over the RMII bus is timed by that.
> 
> Sometimes, the PHY provides a clock to the MAC, and all data transfer
> over the RMII bus is timed by that.
> 
> Here there is a clear master/slave relationship, who is providing the
> clock, who is consuming the clock. However, what you describe does not
> fit that. Maybe look at other PHY bindings, and copy what they do for
> clocks.

In fact, I hesitated a lot before choosing this master/slave designation 
because of the same reasoning as you. But the TI DP83826 datasheet [1] 
uses this name for two orthogonal yet connected meanings, here's a copy 
of the corresponding § (in section 9.3.10):

"The DP83826 offers two types of RMII operations: RMII Slave and RMII 
Master. In RMII Master operation, the DP83826 operates from either a 
25-MHz CMOS-level oscillator connected to XI pin, a 25-MHz crystal 
connected across XI and XO pins. A 50-MHz output clock referenced from 
DP83826 can be connected to the MAC. In RMII Slave operation, the 
DP83826 operates from a 50-MHz CMOS-level oscillator connected to the XI 
pin and shares the same clock as the MAC. Alternatively, in RMII slave 
mode, the PHY can operate from a 50-MHz clock provided by the Host MAC."

So it seems that in some cases this also fits the master/slave 
relationship you describe.

That said, would you like me to include this description (or some parts) 
in the binding in addition to what I've already written? Or would you 
prefer me to use a more meaningful property name?

BTW, this series has already been merged into the net-next tree, I'm not 
sure what procedure to follow in such cases.


Best regards,

Jérémie

[1] 
https://www.ti.com/lit/ds/symlink/dp83826i.pdf?ts=1708075771406&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FDP83826I

