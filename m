Return-Path: <linux-kernel+bounces-26514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4B82E27A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA6EB221D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218BA1B5B1;
	Mon, 15 Jan 2024 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mK8yDsDx"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820017BDC;
	Mon, 15 Jan 2024 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 7F256C5E91;
	Mon, 15 Jan 2024 22:11:11 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0BE28E0002;
	Mon, 15 Jan 2024 22:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705356663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNpSqsS8XC+o4t+8mb4+eClJ0FTb3VnER5NeEMVYzUk=;
	b=mK8yDsDxaA5F7ORFHTfdYDVAtRLbHg29t2GN/tpinTID/C73BtiJGw8SmjrtnuGx4q0Rha
	tBzMlvU53RmKMJtQOgAV3zPTrELcO/LfjLVCpv10cH5yDyPaMT/WnpXjs5RkngldQPRJh7
	McPsM4JI349fkggPDS9WFwa+CdiagK6gF6EEzfNFl4H4lMTyN1P+uz94KdRYkaC1WmZlh3
	kNgrLE3D0w8ilyc2YEVAlwNcqlr6GJoV/XctyyVoHCOoklwyVSKv5vfPyZFnA3ZeDNty2g
	Ck6JwFTtmdCNzkI1xK37qHPCi9nfriGsKRVzVEiRfELUqntq+u+ZNGZxNNWIeg==
Date: Mon, 15 Jan 2024 23:10:57 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Walle
 <michael@walle.cc>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de, =?UTF-8?B?UmFmYcWC?=
 =?UTF-8?B?IE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 1/6] dt-bindings: nvmem: layouts: add U-Boot
 environment variables layout
Message-ID: <20240115231057.6ac1dbd0@xps-13>
In-Reply-To: <20240115170903.GA911971-robh@kernel.org>
References: <20231221173421.13737-1-zajec5@gmail.com>
	<20240104001129.GA2045237-robh@kernel.org>
	<20240104085839.5624c354@xps-13>
	<8c8d2d38-faf2-47f2-bfbf-2e4842dded47@gmail.com>
	<20240115170903.GA911971-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Rob,

robh@kernel.org wrote on Mon, 15 Jan 2024 11:09:03 -0600:

> On Thu, Jan 04, 2024 at 10:10:13AM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> > On 4.01.2024 08:58, Miquel Raynal wrote:
> > > robh@kernel.org wrote on Wed, 3 Jan 2024 17:11:29 -0700:
> > > > On Thu, Dec 21, 2023 at 06:34:16PM +0100, Rafa=C5=82 Mi=C5=82ecki w=
rote:
> > > > > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > > > >=20
> > > > > U-Boot env data is a way of storing firmware variables. It's a fo=
rmat
> > > > > that can be used of top of various storage devices. Its binding s=
hould
> > > > > be an NVMEM layout instead of a standalone device.
> > > > >=20
> > > > > This patch adds layout binding which allows using it on top of MT=
D NVMEM
> > > > > device as well as any other. At the same time it deprecates the o=
ld
> > > > > combined binding.
> > > >=20
> > > > I don't understand the issue. From a DT perspective, there isn't. A
> > > > partition is not a device, but is describing the layout of storage
> > > > already.
> > >=20
> > > Actually I think what Rafa=C5=82 wants to do goes in the right direct=
ion but
> > > I also understand from a binding perspective it may be a little
> > > confusing, even more if we consider "NVMEM" a Linux specific concept.
> > >=20
> > > There is today a "u-boot env" NVMEM *device* description which
> > > almost sits at the same level as eg. an eeprom device. We cannot
> > > compare "an eeprom device" and "a u-boot environment" of course. But
> > > that's truly what is currently described.
> > >=20
> > > * Current situation
> > >=20
> > > 	Flash device -> U-Boot env layout -> NVMEM cells
>=20
> Isn't it?:
>=20
> Flash device -> fixed-partitions -> U-Boot env layout -> NVMEM cells
>=20
> > >=20
> > > * Improved situation
> > >=20
> > > 	Any storage device -> NVMEM -> U-Boot env layout -> NVMEM cells
>=20
> Why is this better? We don't need a container to say 'this is NVMEM=20
> stuff' or 'this is MTD stuff'. 'U-Boot env layout' can tell us 'this is=20
> NVMEM stuff' or whatever the kernel decides in the future.

Yes, I also want the U-boot env layout to tell us "this is nvmem
stuff". But that's not the case today. Today, it says "this is NVMEM
stuff on top of mtd stuff". This was a mistake in the first place, but
this compatible is heavily tight to mtd and cannot work on anything
else. And correcting this is IMO the right direction.

> > > The latter is of course the most relevant description as we expect
> > > storage devices to expose a storage-agnostic interface (NVMEM in
> > > this case) which can then be parsed (by NVMEM layouts) in a storage
> > > agnostic way.
> > >=20
> > > In the current case, the current U-Boot env binding tells people to
> > > declare the env layout on top of a flash device (only). The current
> > > description also expects a partition node which is typical to flash
> > > devices. Whereas what we should have described in the first place is a
> > > layout that applies on any kind of NVMEM device.
> > >=20
> > > Bonus point: We've been working the last couple years on clarifying
> > > bindings, especially with mtd partitions (with the partitions{}
> > > container) and NVMEM layouts (with the nvmem-layout{} container).
> > > The switch proposed in this patch makes use of the latter, of course.
> >=20
> > Thanks Miqu=C3=A8l for filling bits I missed in commit description. Des=
pite
> > years in Linux/DT I still struggle with more complex designs
> > documentation.
> >=20
> >=20
> > As per Rob's comment I think I see his point and a possible design
> > confusion. If you look from a pure DT perspective then "partitions" and
> > "nvmem-layout" serve a very similar purpose. They describe device's data
> > content structure. For fixed structures we have very similar
> > "fixed-partitions" and "fixed-cells".
> >=20
> > If we were to design those bindings today I'm wondering if we couldn't
> > have s/partitions/layout/ and s/nvmem-layout/layout/.
>=20
> Why!? It is just a name, and we can't get rid of the old names. We don't=
=20
> need 2 names.

We need 2 names because we are not capturing the same concepts here?

> > Rob: other than having different bindings for MTD vs. NVMEM layouts I
> > think they overall design makes sense. A single device may have content
> > structurized on more than 1 level:
> > 1. You may have fixed layout at top level (multiple partitions)
> > 2. Single partitions may have their own layouts (like U-Boot env data)
>=20
> Sure. Partitions is for 1 and Layouts is for 2.
>=20
> > Maybe ideally above should look more like:
> >=20
> > flash@0 {
> > 	compatible =3D "<flash-compatible>";
> >=20
> > 	layout {
> > 		compatible =3D "fixed-layout";
>=20
> Why does 'partitions' and 'fixed-partitions' not work here?

They do, and that's actually what we use. This example just illustrates
another proposal from Rafal. No panic :)

>=20
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <1>;
> >=20
> > 		partition@0 {
> > 			reg =3D <0x0 0x40000>;
> > 			label =3D "u-boot";
> > 		};
> >=20
> > 		partition@40000 {
> > 			reg =3D <0x40000 0x10000>;
> > 			label =3D "u-boot-env";
> >=20
> > 			layout {
> > 				compatible =3D "u-boot,env-layout";
> > 			};
> > 		};
> >=20
> > 		partition@50000 {
> > 			reg =3D <0x50000 0x100000>;
> > 			label =3D "u-boot";
> > 		};
> > 	};
> > };
> >=20
> > but I can clearly see a use for nested "layout"s. As I said maybe we
> > just shouldn't be so open in calling those MTD or NVMEM devices as that
> > is kind of Linux specific.
>=20
> The overall structure should be agnostic to the subsystem. Specific=20
> compatibles like 'u-boot,env' can be tied to a subsystem.
>=20
> Maybe some things need to be both MTD and NVMEM. MTD to operate on the=20
> opague region and NVMEM to access the contents.
>=20
>=20
> > I'm not sure if we should try renaming "nvmem-layout" to "layout" or
> > "partitions" in similar way at this point.
>=20
> You can't rename. It's an ABI though maybe the whole "nvmem-layout" is=20
> new enough we can. It's looking like it was a mistake to accept any of=20
> this.

I don't think so.

A partition and a layout are not the same concept, as acknowledged
above. We need both, and we need both because we can encapsulate
both as well:

flash { partitions { partA@x { layout { cell@Y } } } }

Renaming nvmem-layout to layout can be done if you want, I don't mind,
but I don't see the point in doing that.

Thanks,
Miqu=C3=A8l

