Return-Path: <linux-kernel+bounces-100336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6CC8795E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE66285A44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FD67AE49;
	Tue, 12 Mar 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xaq2RTZp"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9A58AD4;
	Tue, 12 Mar 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253127; cv=none; b=UAgMU33MU9fuWYEHoS5Kt3Ic5w2Z3+TNmV3RmRMx4BnfQJvW3iHTRXjSCwixrIT0IOzy5k1fG3WVgFAVu0Tduew816GQoIB1t3hRP/e9iJmP602wuAUAxqFuSdKAGHsiWbbK6WN4pNHEqbHppFaHZJBJExRPXYm8On6Dryy0IYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253127; c=relaxed/simple;
	bh=gDhbS5GX3D28N410zYK3NRuThkWmlgG+G66CI56dYd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKiGuwYxN3OIIvAMUTv4e0MYkjFRZYOyRZNS7F9imIzIqr9JY/D7us5jCvboTfu0G44CWFKJoYTjL6m4QeD0I+ESMDELedU8LYaHytr/+wtbbvB4G1+YH37Z/ygBaJqEYH4LqSPt5PVBTQ2pNRz/43/ZqacB1tqpC1CqkGV9F1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xaq2RTZp; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CCE8E1C000E;
	Tue, 12 Mar 2024 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710253116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPax4SruT40V+SoIDKJmZxhUVVshW9nsuUSbxtxxykY=;
	b=Xaq2RTZpEk12qX0xAg9J2TshWgskMgyfkt3IsIxKrYp3SVGPL3ACwJf9ec2GWpLiJPLLao
	amQqYtEYOgdo/u/YNPA2ybIsiWnbM/mAJcKRneNthLTi0Mq62g9+ni5in/yV7DHE5vDC7p
	QSdjUDDW/Ua5/BdqPx5CyCoD/67EerLODzN82BSWxYn5w4uvhU/R3xI6sZD516Ha0NgJxV
	aAhBM0/v0u0TjPX/XGCAA42gE58QiTtO++W1oGqBzbBtDinUB9G5D1cMH4p+YUvIKRN2tP
	R1TC4S8grINRK0BuWdjB1MOmQrErNRDBbTBbnsZHrZZNvYKt95O0K9VSENB9+A==
Date: Tue, 12 Mar 2024 15:18:35 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Wolfram Sang
 <wsa@kernel.org>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, Android Kernel Team
 <kernel-team@android.com>
Subject: Re: [PATCH 1/2] driver core: Clear FWNODE_FLAG_NOT_DEVICE when a
 device is added
Message-ID: <20240312151835.29ef62a0@bootlin.com>
In-Reply-To: <CAGETcx-4RkuvsW5W5zPS4HMjSAGq5Yi9P2O0KPanA8HVJV0bvg@mail.gmail.com>
References: <20240220111044.133776-1-herve.codina@bootlin.com>
	<20240220111044.133776-2-herve.codina@bootlin.com>
	<CAGETcx-4RkuvsW5W5zPS4HMjSAGq5Yi9P2O0KPanA8HVJV0bvg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Saravana,

On Tue, 20 Feb 2024 18:41:03 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Tue, Feb 20, 2024 at 3:10 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Since commit 1a50d9403fb9 ("treewide: Fix probing of devices in DT
> > overlays"), when using device-tree overlays, the FWNODE_FLAG_NOT_DEVICE
> > is set on each overlay nodes.
> > When an overlay contains a node related to a bus (i2c for instance)
> > and its children nodes representing i2c devices, the flag is cleared for
> > the bus node by the OF notifier but the "standard" probe sequence takes
> > place (the same one is performed without an overlay) for the bus and
> > children devices are created simply by walking the children DT nodes
> > without clearing the FWNODE_FLAG_NOT_DEVICE flag for these devices.
> >
> > Clear the FWNODE_FLAG_NOT_DEVICE when the device is added, no matter if
> > an overlay is used or not.
> >
> > Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/base/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 14d46af40f9a..61d09ac57bfb 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -3619,6 +3619,7 @@ int device_add(struct device *dev)
> >          */
> >         if (dev->fwnode && !dev->fwnode->dev) {
> >                 dev->fwnode->dev = dev;
> > +               dev->fwnode->flags &= ~FWNODE_FLAG_NOT_DEVICE;
> >                 fw_devlink_link_device(dev);
> >         }  
> 
> Temporary Nack on this. I think depending on how we address patch 2/2
> this patch might not be necessary.
> 
> Also, I'd ideally prefer this gets cleared before the device is added,
> but it's a position that I'd be willing to change.
> 

Some more information about this current patch.

Several month ago, I sent a patch related to a warning raised during driver
unbinding [1]. This warning was raised by __device_links_no_driver() because
we unlink a consumer while its supplier links.status is DL_DEV_UNBINDING.
You suspected an issue with the device removal ordering.

On this system, I applied this current patch clearing FWNODE_FLAG_NOT_DEVICE
in device_add(). This fixes the warning described in [1].

[1]: https://lore.kernel.org/linux-kernel/CAGETcx-Mp0uKBF_BWFFBUm=eVOp8xhxF3+znFB8vTaFwpJWTnw@mail.gmail.com/


The use case on that system, involved DT overlays and the fragment applied is the
following:
--- 8< ---
   pci-ep-bus@0 {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;

	/*
	 * map @0xe2000000 (32MB) to BAR0 (CPU)
	 * map @0xe0000000 (16MB) to BAR1 (AMBA)
	 */
	ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
	          0xe0000000 0x01 0x00 0x00 0x1000000>;

	...

	flx0: flexcom@e0040000 {
		compatible = "atmel,sama5d2-flexcom";
		reg = <0xe0040000 0x100>;
		clocks = <&clks GCK_ID_FLEXCOM0>;
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x0 0xe0040000 0x800>;

		atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;

		i2c_lan966x: i2c@600 {
			compatible = "microchip,lan966x-i2c";
			reg = <0x600 0x200>;
			interrupt-parent = <&itc>;
			interrupts = <48>;
			#address-cells = <1>;
			#size-cells = <0>;
			clocks = <&clks GCK_ID_FLEXCOM0>;
			assigned-clocks = <&clks GCK_ID_FLEXCOM0>;
			assigned-clock-rates = <20000000>;
			pinctrl-0 = <&fc0_a_pins>;
			pinctrl-names = "default";
			i2c-analog-filter;
			i2c-digital-filter;
			i2c-digital-filter-width-ns = <35>;
		};
	};
	...
   };
--- 8< ---
This fragment is applied to a PCI device node.

Without clearing the FWNODE_FLAG_NOT_DEVICE, a link is present between the
i2c@600 and the PCI device. With the flag cleared, this link is replaced by
a link between the i2c@600 and the pci-ep-bus. Which looks better.

The flexcom driver is a MFD driver. As a MFD driver, it simply calls
devm_of_platform_populate(). In this path, devices are created and added but
nothing cleared the FWNODE_FLAG_NOT_DEVICE.

Based on your remark "I'd ideally prefer this gets cleared before the device
is added", I have the feeling that all calls to device_add() should clear the
flag before calling device_add(). So having FWNODE_FLAG_NOT_DEVICE cleared
in device_add() itself in that case makes sense.

What is your opinion ?

Also, feel free to ask for some more traces and/or logs if needed.

Best regards,
Hervé
-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

