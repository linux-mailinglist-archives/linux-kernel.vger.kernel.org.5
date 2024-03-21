Return-Path: <linux-kernel+bounces-109861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C882F8856AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A65E1F21AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8C254FB7;
	Thu, 21 Mar 2024 09:44:42 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6514F1E5;
	Thu, 21 Mar 2024 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014282; cv=none; b=gEQjIMSa1UUTb5fyn84Oekf7bL/ocFYnind91yiTp18wdImThQlcSPxVAKJkT9pF36FuLRdFCkxMaUVv1iRZVQUw+MxfueBGIKL010sEOnBd3XACCov1QCIfw4fmQjmigCe2OS26Zz5HMtOy260IMAlRpe2omH1kqvEy0pM/dbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014282; c=relaxed/simple;
	bh=ziGevIGlkKiaegYPFPO/RtQW2rshXRVfR9JEheugHps=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=Xz4nlrAA5qYbw46Fc1WM7mUzI9cwgNZ+lEct09NRCDfqTe7tCCPcb6Q6Favznd0KpenUyAoYK5rwyIjZBleK5E3eXHrnb2GkjGutb6llmDZ4ZmG66FNzqziTl7mDDdE4lMEnn4d7Ai20VDHIJXRpjII1D3ErOSs/DWybhVag9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id CA427959;
	Thu, 21 Mar 2024 10:38:23 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 10:38:23 +0100
Message-Id: <CZZBT3ZMDCVI.40UX5MB6LY4I@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Vaishnav Achath" <vaishnav.a@ti.com>, "Andrew Lunn" <andrew@lunn.ch>
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
X-Mailer: aerc 0.16.0
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
 <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
 <b62915ca-c151-4e37-bb03-c92c569c84ff@lunn.ch>
 <4b319264-bff7-48e5-85e8-201ca0bafec6@ti.com>
 <4c299d42-84c7-46fc-952f-292cef1bb4b4@lunn.ch>
 <ded6c350-4c70-4a26-8b18-6605dcc6e084@ti.com>
In-Reply-To: <ded6c350-4c70-4a26-8b18-6605dcc6e084@ti.com>

Hi,

> > Is that because the current software support is too limited? Are there
> > manufactures who want to create more complex designed, but are limited
> > by what can be described in the manifest?
> >=20
>
> most mikroBUS add-on boards in production lies in the category of=20
> sensors, displays, connectivity, mixed signal (ADC/DAC .etc) and if you=
=20
> look at the existing bindings under bindings/iio/ , most devices need=20
> only simple descriptions and the properties are mainly standard bus=20
> properties (SPI/I2C properties), IRQ, named-gpios, named properties,=20
> regulators, clocks the extension to manifest was made taking this into=20
> account and the named property description interface just maps the=20
> manifest entries to the unified device property interface under=20
> include/linux/property.h

How will the ethernet boards ([1], [2]) work? Where do they get
their MAC address from, for example. The DT has some nice properties
for that, but I doubt that will be possible with the manifest files.
I've looked at the manifest file for the w5500 board [3] and to me
it looks like that board will come up with a random MAC address on
each start. Thus, even today, you have some boards which require
a more complex description.

Apart from the discussion whether the manifest is a suitable or
sufficient mechanism to describe the hardware, I think the main
problem with the proposed binding, is that it doesn't follow the
binding Rob was proposing for a socket. If I want to use DT
overlays, how would you describe an add-on board?

The proposal was that the base board has something like

mikrobus: socket {
	compatible =3D "mikrobus-socket";
	i2c-parent =3D <&i2c0>;
	spi-parent =3D <&spi0>;

	i2c {};
	spi {};
};

an add-on board can then have a DT snippet/overlay like the
following:

&mikrobus {
	i2c {
		eeprom@52: {
			reg =3D <52>;
			compatible =3D <atmel,at24..>;
		}
	};

	spi {
		sensor@0: {
			reg =3D <0>;
			compatible =3D <foobar>;
		};
	};
};

That should be possible with a binding for the mikrobus, which
in fact it is just a pin header with a standard pinout. Also as
Russell pointed out in v3, the EEPROM/manifest is not part of the
mikrobus standard. So maybe that deserves an own compatible, like

   compatible =3D "mikroe,click", "mikrobus-socket";

Or maybe click-eeprom? Although click seems to be the brand name of
MikroElektronika.

-michael

[1] https://www.mikroe.com/eth-3-click
[2] https://www.mikroe.com/eth-wiz-click
[3] https://github.com/MikroElektronika/click_id/blob/main/manifests/ETH-WI=
Z-CLICK.mnfs

