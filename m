Return-Path: <linux-kernel+bounces-135354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8506D89BF67
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E9B1F22CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFD870CC5;
	Mon,  8 Apr 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="LJCAULDv"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9666CDDC;
	Mon,  8 Apr 2024 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580525; cv=none; b=hUfOW4HlxtFmD5vn/XxWE30Tr/cBoVcgPBGZ8ztv9bOe1onJp0cSZ2QN8rp33HgeuelYuDCGgMtKcZjh4q9nTe0ugzQn0bisZ99K8aihNyjGThHQ0Ph20AQThkX6GK7Qmc2ZYfvNcfKilxderPci5q2FUd3qQmbO00rDthow6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580525; c=relaxed/simple;
	bh=mpZN8yjoALuYbnUIvl1Jzyjr8C6Q7zr6LsHovN0NC9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pg/1sNDCftqUSG4xz2HvJYG8T6kem8NsZznnfoGyfS6DMxcNohJLRE0z3TsO984j+37MdYsxXtPBhNZQRMOZjlKNFv/mbekEQjcgPi4PiKqzvZhb0+PLWX8/hBrOGG1sUP/e34a+p07MWNhlIXymo37X9ErjNByi068xEQmzwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=LJCAULDv; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1712580519; bh=mpZN8yjoALuYbnUIvl1Jzyjr8C6Q7zr6LsHovN0NC9o=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=LJCAULDvuMRsyIafPbaNQo3zkuo+WIc3xesyh+5O/DMXTH821QOZoCFUWMhY56ryb
	 bdQrZ4Gd/lD/OfSRlQI4uE3EQ+4UKfom3efaJSgRAX7bq7X7M3aFOVBPxgCUAcc6Dd
	 evsI4KdJmuuktBmlLXiO7nv/NLo+xIJ2MS8MHbMg=
Date: Mon, 8 Apr 2024 14:48:38 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCHv3 1/2] dt-bindings: usb: typec: anx7688: start a binding
 document
Message-ID: <uoo7xltbfx7u6iai7urj3wez7cwotokxt6lwjhff57xbljusqn@fr2xejnrlak7>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <ZhPMHdt6r/4D99Zg@duo.ucw.cz>
 <ab9affc8-de68-4ec9-bdfc-02131191bc3a@linaro.org>
 <ZhPTTxI4oTF3pgrk@duo.ucw.cz>
 <e7841ad2-fa3d-442d-804d-51f12e05c234@linaro.org>
 <e6vvuttix5k5fioy7q44ick5wj6u5gleh7mht36s4zjjcym7vy@bziejyohtc4b>
 <7976e254-ed1e-406d-870b-1ecdc4b1e23c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7976e254-ed1e-406d-870b-1ecdc4b1e23c@linaro.org>

On Mon, Apr 08, 2024 at 01:59:12PM GMT, Krzysztof Kozlowski wrote:
> On 08/04/2024 13:52, Ondřej Jirman wrote:
> > On Mon, Apr 08, 2024 at 01:24:03PM GMT, Krzysztof Kozlowski wrote:
> >> On 08/04/2024 13:21, Pavel Machek wrote:
> >>> Hi!
> >>>
> >>>>> Add binding for anx7688 usb type-c bridge. I don't have a datasheet,
> >>>>> but I did best I could.
> >>>>>
> >>>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >>>>
> >>>> ...
> >>>>
> >>>>> +  cabledet-gpios:
> >>>>> +    maxItems: 1
> >>>>> +    description: GPIO controlling CABLE_DET (C3) pin.
> >>>>> +
> >>>>> +  avdd10-supply:
> >>>>> +    description: 1.0V power supply going to AVDD10 (A4, ...) pins
> >>>>> +
> >>>>> +  dvdd10-supply:
> >>>>> +    description: 1.0V power supply going to DVDD10 (D6, ...) pins
> >>>>> +
> >>>>> +  avdd18-supply:
> >>>>> +    description: 1.8V power supply going to AVDD18 (E3, ...) pins
> >>>>> +
> >>>>> +  dvdd18-supply:
> >>>>> +    description: 1.8V power supply going to DVDD18 (G4, ...) pins
> >>>>> +
> >>>>> +  avdd33-supply:
> >>>>> +    description: 3.3V power supply going to AVDD33 (C4, ...) pins
> >>>>> +
> >>>>> +  i2c-supply: true
> >>>>> +  vconn-supply: true
> >>>>
> >>>> There are no such supplies like i2c and vconn on the schematics.
> >>>>
> >>>> I think this represents some other part of component which was added
> >>>> here only for convenience.
> >>>
> >>> Can you give me pointer to documentation you are looking at?
> >>
> >> The schematics you linked in the document at the beginning. Page 13. Do
> >> you see these pins there? I saw only VCONN1_EN, but that's not a supply.
> > 
> > The supply is U1308.
> 
> That's not a supply to anx7688.

Yeah, I understand where the confusion is. The driver is not for anx7688 chip
really. The driver is named anx7688, but that's mostly a historical accident at
this point.

I guess there can be a driver for anx7688 chip that can directly use the chip's
resources from the host by directly manipulating its registers and implementing
type-c functionality via eg. Linux's TCPM or TCPCI stack, etc. (eg. like
fusb302 driver, or various tcpci subdrivers).

But in this case the chip is driven by an optional on-chip microcontroller's
firmware and *this driver* is specifically for *the Type-C port on Pinephone*
and serves as an integration driver for quite a bunch of things that need to
work together on Pinephone for all of the Type-C port's features to operate
reasonably well (and one of those is some communication with anx7688 firmware
that we use, and enabling power to this chip and other things as appropriate,
based on the communication from the firmware).

It handles the specific needs of the Pinephone's Type-C implementation, all of
its quirks (of which there are many over several HW revisions) that can't be
handled by the particular implementation of on-chip microcontroller firmware
directly and need host side interaction.

In an ideal world, many of the things this driver handles would be handled by
embedded microcontroller on the board (like it is with some RK3399 based Google
devices), but Pinephone has no such thing and this glue needs to be implemented
somewhere in the kernel.

Kind regards,
	o.

> Best regards,
> Krzysztof
> 

