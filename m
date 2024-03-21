Return-Path: <linux-kernel+bounces-110047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B71C885953
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0AD281AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A875E83CC3;
	Thu, 21 Mar 2024 12:44:35 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A7E83CAA;
	Thu, 21 Mar 2024 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025075; cv=none; b=DtOJnmM4xolYnoDP+1BVdOzg53GHoLRE0F1nsfB2bCoqdv/BPvXPkhN7UmJrh+jRP+xtI1uX3d5ngOL6l2QRx/YJJxmYB/ZB8f6z5q5PX6no1XRLzpJMdiUU1oNN4bGuiMS7+ENErLj7QeJlF0g0Cz2iRx+AcKH3N8MAHu6ZkV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025075; c=relaxed/simple;
	bh=u+yR7s3tG85i6kdERMVCt3n56ayETNZhoAGnRsXV+sU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=F0XFFl933TLmKC5TncUW0dTllItdxovX4LuYG7yDmlf477cJ5t63XFvqaMKcknAg0V7ELMXVd7sUgjaRE9Ex/6t905CPJ7IIbo2AmldG25EWcbsszoua2ZVr9UEqIpJiDKelpohh8r8EgRJMnKLl/PzyQzh7t25s3tJPJAUXjg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 1D1C9AA;
	Thu, 21 Mar 2024 13:44:30 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 13:44:29 +0100
Message-Id: <CZZFRLRP6RKE.299OFG59KCK9L@kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, "Ayush Singh"
 <ayushdevel1325@gmail.com>, "open list" <linux-kernel@vger.kernel.org>,
 <jkridner@beagleboard.org>, <robertcnelson@beagleboard.org>,
 <lorforlinux@beagleboard.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>, "Derek Kiernan"
 <derek.kiernan@amd.com>, "Dragan Cvetic" <dragan.cvetic@amd.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Mark Brown" <broonie@kernel.org>, "Johan
 Hovold" <johan@kernel.org>, "Alex Elder" <elder@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, "moderated list:ARM/TEXAS INSTRUMENTS K3
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:SPI
 SUBSYSTEM" <linux-spi@vger.kernel.org>, "moderated list:GREYBUS SUBSYSTEM"
 <greybus-dev@lists.linaro.org>, "Vaishnav M A" <vaishnav@beagleboard.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Vaishnav Achath" <vaishnav.a@ti.com>, "Andrew Lunn" <andrew@lunn.ch>
X-Mailer: aerc 0.16.0
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
 <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
 <b62915ca-c151-4e37-bb03-c92c569c84ff@lunn.ch>
 <4b319264-bff7-48e5-85e8-201ca0bafec6@ti.com>
 <4c299d42-84c7-46fc-952f-292cef1bb4b4@lunn.ch>
 <ded6c350-4c70-4a26-8b18-6605dcc6e084@ti.com>
 <CZZBT3ZMDCVI.40UX5MB6LY4I@kernel.org>
 <ef6a1c28-70dc-4077-b644-2704ac3cf30f@ti.com>
In-Reply-To: <ef6a1c28-70dc-4077-b644-2704ac3cf30f@ti.com>

Hi,

> >>> Is that because the current software support is too limited? Are ther=
e
> >>> manufactures who want to create more complex designed, but are limite=
d
> >>> by what can be described in the manifest?
> >>>
> >>
> >> most mikroBUS add-on boards in production lies in the category of
> >> sensors, displays, connectivity, mixed signal (ADC/DAC .etc) and if yo=
u
> >> look at the existing bindings under bindings/iio/ , most devices need
> >> only simple descriptions and the properties are mainly standard bus
> >> properties (SPI/I2C properties), IRQ, named-gpios, named properties,
> >> regulators, clocks the extension to manifest was made taking this into
> >> account and the named property description interface just maps the
> >> manifest entries to the unified device property interface under
> >> include/linux/property.h
> >=20
> > How will the ethernet boards ([1], [2]) work? Where do they get
> > their MAC address from, for example. The DT has some nice properties
> > for that, but I doubt that will be possible with the manifest files.
> > I've looked at the manifest file for the w5500 board [3] and to me
> > it looks like that board will come up with a random MAC address on
> > each start. Thus, even today, you have some boards which require
> > a more complex description.
> >=20
>
> Agreed, this is a limitation, unless the corresponding=20
> drivers/subsystems use device_property_read_* helper to fetch=20
> properties, it will not work and net/core/of_net.c only implements=20
> of_get_* helpers even though the underlying functions can be implemented=
=20
> with equivalent device_property_read_* equivalent as well.

And I don't think this is a good idea given that the alternative is
just working.

> > Apart from the discussion whether the manifest is a suitable or
> > sufficient mechanism to describe the hardware, I think the main
> > problem with the proposed binding, is that it doesn't follow the
> > binding Rob was proposing for a socket. If I want to use DT
> > overlays, how would you describe an add-on board?
> >=20
> > The proposal was that the base board has something like
> >=20
> > mikrobus: socket {
> > 	compatible =3D "mikrobus-socket";
> > 	i2c-parent =3D <&i2c0>;
> > 	spi-parent =3D <&spi0>;
> >=20
> > 	i2c {};
> > 	spi {};
> > };
> >=20
> > an add-on board can then have a DT snippet/overlay like the
> > following:
> >=20
> > &mikrobus {
> > 	i2c {
> > 		eeprom@52: {
> > 			reg =3D <52>;
> > 			compatible =3D <atmel,at24..>;
> > 		}
> > 	};
> >=20
> > 	spi {
> > 		sensor@0: {
> > 			reg =3D <0>;
> > 			compatible =3D <foobar>;
> > 		};
> > 	};
> > };
> >=20
> > That should be possible with a binding for the mikrobus, which
> > in fact it is just a pin header with a standard pinout. Also as
> > Russell pointed out in v3, the EEPROM/manifest is not part of the
> > mikrobus standard. So maybe that deserves an own compatible, like
> >=20
> >     compatible =3D "mikroe,click", "mikrobus-socket";
> >=20
> > Or maybe click-eeprom? Although click seems to be the brand name of
> > MikroElektronika.
>
> Agreed, there is nothing preventing us to convert the binding and update=
=20
> the driver to follow the above proposed format and will be done in next=
=20
> revision. Click is brand name of MikroElektronika and they don't allow=20
> custom boards to use that branding, however clickid can be used in the=20
> case where EEPROM is present/enable the socket to be probeable.

Thinking about this again. I'm not sure this additional compatible
really helps the discovery. It's a chicken egg problem. Only the
modules knows if it has an EEPROM, but then, we already have to
know it's in the socket. So while it might help for a static
configuration, it does not for the discovery.

-michael

> > [1] https://www.mikroe.com/eth-3-click
> > [2] https://www.mikroe.com/eth-wiz-click
> > [3] https://github.com/MikroElektronika/click_id/blob/main/manifests/ET=
H-WIZ-CLICK.mnfs


