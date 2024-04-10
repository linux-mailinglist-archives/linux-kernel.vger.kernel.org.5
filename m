Return-Path: <linux-kernel+bounces-137834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4469589E822
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBF02859C4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446238F44;
	Wed, 10 Apr 2024 02:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="pAq+m9yk"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97510E3;
	Wed, 10 Apr 2024 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715974; cv=none; b=B6P31dAMTghbiC9UFrJ/uGQ5J/KAO6K5MZ4CQUfvpVTg9wEZVJqCyl7MC8hVighUigs+CnHXfawVJ+Ph9RmRc3bQ9FQQXuMFVt0P8DyhNx9GVlWxzY4WNIOrxAUDZAqaZt4GfLezev18da5cuQKzeD1f0hiWPDrl7s+OQ7z/4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715974; c=relaxed/simple;
	bh=J7vXo8gnzotGaAOZGaEFsf6LKD7BLcr3tjED66ZNRx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nM5n12/wfQa9oo/flFW/uk2ViVC6GLpf9PHovQiZn+Y7mEzWiyPbS1RqYSQFQp36Ok52qOlrL1IVUkrIToX5aNlRjqwVNxxkfLWuuxGJFqg3FVb010BVhIOxRsxjlY4i9jh49bAsvWvozXSryz3Wh0q3eBieFc7ezgKmIq+SVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=pAq+m9yk; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1712715645; bh=J7vXo8gnzotGaAOZGaEFsf6LKD7BLcr3tjED66ZNRx4=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=pAq+m9ykq3MBG8HAZqb5dhlh+bkT/EAkF76/uquZ0HDh4Lsh/kM8MVI+u0ZZbX9vl
	 mVNwgt3Bza4HRAYznNQ2l3Rf/mybYp1gjdllrS0BWbrL8NUP/ALM76OKZaIyWY1aPl
	 NVc0Woczth0IrK95PL/s8qaMFne2NEXykKreSVm4=
Date: Wed, 10 Apr 2024 04:20:44 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCHv3 1/2] dt-bindings: usb: typec: anx7688: start a binding
 document
Message-ID: <ounfv3vgg2esvxk2cxckeqyy52mghiyps2rszh7sf5poryyjzs@ftumsalmthza>
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
 <vbo7bacecuagu4qzrr6tsdh4qlejrv7ia67yylf6ay4u7qnwge@kqj27bun2m7d>
 <97f2d38d-c863-4c76-91f1-52cd250759d7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97f2d38d-c863-4c76-91f1-52cd250759d7@linaro.org>

On Mon, Apr 08, 2024 at 10:12:30PM GMT, Krzysztof Kozlowski wrote:
> On 08/04/2024 17:17, Ondřej Jirman wrote:
> > 
> > Now for things to not fail during suspend/resume based on PM callbacks
> > invocation order, anx7688 driver needs to enable this regulator too, as long
> > as it needs it.
> 
> No, the I2C bus driver needs to manage it. Not one individual I2C
> device. Again, why anx7688 is specific? If you next phone has anx8867,
> using different driver, you also add there i2c-supply? And if it is
> nxp,ptn5100 as well?

Yes, that could work, if I2C core would manage this.

> > 
> > I can put bus-supply to I2C controller node, and read it from the ANX7688 driver
> > I guess, by going up a DT node. Whether that's going to be acceptable, I don't
> > know. 
> > 
> > 
> > VCONN regulator I don't know where else to put either. It doesn't seem to belong
> > anywhere. It's not something directly connected to Type-C connector, so
> > not part of connector bindings, and there's nothing else I can see, other
> > than anx7688 device which needs it for core functionality.
> 
> That sounds like a GPIO, not regulator. anx7688 has GPIOs, right? On
> Pinephone they go to regulator, but on FooPhone also using anx7688 they
> go somewhere else, so why this anx7688 assumes this is a regulator?

CC1/CC2_VCONN control pins are "GPIO" of anx7688, sort of. They have fixed
purpose of switching external 5V regulator output to one of the CC pins
on type-c port. I don't care what other purpose with some other firmware
someone puts to those pins. It's irrelevant to the use case of anx7688
as a type-c controller/HDMI bridge, which we're describing here.

VCONN regulator is an actual GPIO controlled regulator on the board, and
needs to be controlled by the anx7688 driver. So that CC1/CC2_VCONN control
pins driven by the firmware actually do what they're supposed to do.

Not sure why it would be a business of anything else but anx7688 driver
enabling this regulator, because only this driver knows and cares about this.
If some other board doesn't have the need to manually enable the regulator, or
doesn't have the regulator, it can simply be optional.

There are also some other funky supplies in the bindings, that are not connected
to the chip in any way, but need to be controlled by the driver:

+  vbus-supply: true
+  vbus-in-supply: true

First one can be on the connector node instead, where the driver can fetch
it from.

The purpose of the second one is to link the Phone's PMIC's USB power input with
the type-c controller (anx7688), to make sure the PMIC has information about how
much power it can draw from external PSU.

The second one can be replaced by rewriting the anx7688 driver so that it
creates a power supply representing the USB PSU connected to the phone, and by
linking to anx7688 DT node from x-powers,axp813-usb-power-supply via
a power-supplies property, which would mean that USB input of the phone is
supplied by the external USB PSU. PMIC driver can be modified to watch
the power supply provided by anx7688 driver for information it detected
via USB-PD and update its input current limit via a standard helper function.

This is how eg. fusb302 works. Not sure if that's any better from the PoV of
DT bindings, though. Because power-supplies = <&anx7688>; will not look any
greater in DT bindings, IMO. It will just link the same nodes in the other
direction.

Anyway, the HW is that there's an external PSU (detected by type c controller)
and internal USB power input, and they are connected and one has to respect the
limits of the other. I guess I shouldn't be adding a device node for external PSU,
since it's not part of the phone. But that's what's trully being linked on
HW level.

Kind regards,
	o.

> 
> > 
> > ANX7688 chip desing doesn't have integrated VCONN mosfet switches so it always
> > needs external supply + switches that are controlled by the chip itself. There's
> > no sensible design where someone would not want this and the driver needs
> > to get this regulator reference from somewhere. The switches are sort of an
> > extension of the chip.
> 
> 
> Best regards,
> Krzysztof
> 

