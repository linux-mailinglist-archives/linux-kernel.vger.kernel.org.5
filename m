Return-Path: <linux-kernel+bounces-135586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7C589C800
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7C0B221BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812D13FD63;
	Mon,  8 Apr 2024 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="CRh4jbsE"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46EC13F44B;
	Mon,  8 Apr 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589469; cv=none; b=EHNe68mN/miWFr0EXBgEnhbsiq6u2XZlj2kyy8oEiVnjo3NdIkLHf7XCWG4VRNdnCDPPc4T8T0LDAwIflgtVNKasoGavgRGaxHIrDagi8tXtb5q9WcqspwHfK62cGl1Kb+ir4PgY8nugNb+dcCw7AXW0utBqYfCRKBbIhM3Stq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589469; c=relaxed/simple;
	bh=AYeVrQdvosASyC+HQOVAheJr5WOqO6RSDW3nYM7LFCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSY3ld3ZBMDkHWcsEF1Fp3tcdYoJ3+DOzEyX72qV3XrKwM7IUfH1I3jG+zasQNySQT7gKDD6G4+dp+Psk0U7Qpdl5qoqaGpJqQcE/q6hAgucyjUMvctwHyyy4Zg5KsJIxP5Ab9RkLUjxmfasOKXhpQIV/34VSx3uZgt/M5m9HGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=CRh4jbsE; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1712589461; bh=AYeVrQdvosASyC+HQOVAheJr5WOqO6RSDW3nYM7LFCE=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=CRh4jbsEXcrgqQwEusZ/7VrROvaujjQWLV+K0GrAG2YCVAUi2atlgp+xU9FW0szyN
	 GLZeUxyRCXIpjE9By0ZS0jffpIuTmdVlRP6lb4aBaMLosJXInjVvUA9z60RyxoJswh
	 8VBmcbLNQP5sd8/yVlTxNlYkJcZUZlatizw47KUY=
Date: Mon, 8 Apr 2024 17:17:41 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCHv3 1/2] dt-bindings: usb: typec: anx7688: start a binding
 document
Message-ID: <vbo7bacecuagu4qzrr6tsdh4qlejrv7ia67yylf6ay4u7qnwge@kqj27bun2m7d>
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
 <uoo7xltbfx7u6iai7urj3wez7cwotokxt6lwjhff57xbljusqn@fr2xejnrlak7>
 <1502383c-9caf-4362-8bd6-ed719a304f08@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1502383c-9caf-4362-8bd6-ed719a304f08@linaro.org>

On Mon, Apr 08, 2024 at 03:27:00PM GMT, Krzysztof Kozlowski wrote:
> On 08/04/2024 14:48, Ondřej Jirman wrote:
> > Yeah, I understand where the confusion is. The driver is not for anx7688 chip
> > really. The driver is named anx7688, but that's mostly a historical accident at
> > this point.
> > 
> > I guess there can be a driver for anx7688 chip that can directly use the chip's
> > resources from the host by directly manipulating its registers and implementing
> > type-c functionality via eg. Linux's TCPM or TCPCI stack, etc. (eg. like
> > fusb302 driver, or various tcpci subdrivers).
> > 
> > But in this case the chip is driven by an optional on-chip microcontroller's
> > firmware and *this driver* is specifically for *the Type-C port on Pinephone*
> 
> We do not talk here about the driver, but bindings, so hardware.

Got it. Bindings should be the same regardless of what driver would be used,
whether this OCM based one, or some future one based on the above mentioned
TCPCI in-kernel implementation. Hardware is the same in both cases.

Just trying to imagine how to actually solve the issues...

Basic thing with the I2C regulator thing is that needs to be enabled as long
as anx7688 needs to communicate over I2C. Other user of this power rail is
touchscreen controller for its normal power supply, and it needs to be able
to disable it during system suspend.

Now for things to not fail during suspend/resume based on PM callbacks
invocation order, anx7688 driver needs to enable this regulator too, as long
as it needs it.

I can put bus-supply to I2C controller node, and read it from the ANX7688 driver
I guess, by going up a DT node. Whether that's going to be acceptable, I don't
know. 


VCONN regulator I don't know where else to put either. It doesn't seem to belong
anywhere. It's not something directly connected to Type-C connector, so
not part of connector bindings, and there's nothing else I can see, other
than anx7688 device which needs it for core functionality.

ANX7688 chip desing doesn't have integrated VCONN mosfet switches so it always
needs external supply + switches that are controlled by the chip itself. There's
no sensible design where someone would not want this and the driver needs
to get this regulator reference from somewhere. The switches are sort of an
extension of the chip.

kind regards,
	o.


> > and serves as an integration driver for quite a bunch of things that need to
> > work together on Pinephone for all of the Type-C port's features to operate
> > reasonably well (and one of those is some communication with anx7688 firmware
> > that we use, and enabling power to this chip and other things as appropriate,
> > based on the communication from the firmware).
> 
> That's still looking like putting board design into particular device
> binding.
> 
> > 
> > It handles the specific needs of the Pinephone's Type-C implementation, all of
> > its quirks (of which there are many over several HW revisions) that can't be
> > handled by the particular implementation of on-chip microcontroller firmware
> > directly and need host side interaction.
> > 
> > In an ideal world, many of the things this driver handles would be handled by
> > embedded microcontroller on the board (like it is with some RK3399 based Google
> > devices), but Pinephone has no such thing and this glue needs to be implemented
> > somewhere in the kernel.
> 
> You might need multiple schemas, because this is for anx7688, not for
> Pinephone type-c implementation.
> 
> However I still do not see yet a limitation of DTS requiring stuffing
> some other properties into anx7688 or creating some other, virtual entity.
> 
> 
> Best regards,
> Krzysztof
> 

