Return-Path: <linux-kernel+bounces-120625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F048588DA72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F10C1C25929
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D1B383BB;
	Wed, 27 Mar 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="dlJZikWu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XXnV9/jC"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B103E381CD;
	Wed, 27 Mar 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532581; cv=none; b=G2J583N9GKZw7riHqkfRyKvYOp/RLPc5IERssuc6qVWWSxtMMrH7AUjwaLSRYaKasXKYk+pUmsSim00JdRxIQ3ik+SNF/ZUhJgrng17GGZ0jUmnVI9q+CD1J8VT1CKW2eLQCOhz+H8kzzg3iappFWlnslYwiPWlP71GzNJRPVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532581; c=relaxed/simple;
	bh=JS90u7tq7VFJO/hnamqzxcTLZD6N3Vt7MknyUw/cu/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MGIt/8xYiSGSkdCAHGDIrzV6htAxwc5+gKN+yA6qd5u40J3ML/gtXsTGCpmOimpWpw4KWepPcUk2UWgwJHnLsnO0nz49PnXQO4iKByhb0R0B+TLtU4ydMI6YbNoZcAkLug0cdeoGFdEeQA12a/X4DehMlgQHcREdwaZkqwYJEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=dlJZikWu; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XXnV9/jC reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1711532577; x=1743068577;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=rQ/JY3X0GomTvd9YbXCROPDzE84c887ZCDkKnstdjVQ=;
  b=dlJZikWuAgfQR6vCdVDIhLzE/dDyQcKcKZ04y0kqmBKnuKVzK3aFQAJx
   +spxnExRuj5Iwp0f4HwyqBn8jp8bgLgHQ0CIblwmtygnITfcRBbWM7y1C
   +jVqpOrGA5uYgTSFfNZmA5zp+Po+79Sb7UQD8NgQ52JISJNCk4DXCxrHL
   xD60LCgdnFTe7nbgU8gcS9amUDHcs4CSMFS1iN/EyyhM5helvzcR0PyQQ
   nNulOIbZbUMx4jqThlJCsZWsoah78KghGFxDA+mvrYW6d4V6RkY3m188/
   lx0NyQnmVTKSik2Za95Z2HmTu0pZlRlW4Rc0mZI6DXycGmDD+rTJQc8lt
   g==;
X-IronPort-AV: E=Sophos;i="6.07,158,1708383600"; 
   d="scan'208";a="36125462"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 27 Mar 2024 10:42:48 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3B9C716E0A1;
	Wed, 27 Mar 2024 10:42:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1711532563;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rQ/JY3X0GomTvd9YbXCROPDzE84c887ZCDkKnstdjVQ=;
	b=XXnV9/jCsuQjKp99nK+OeU2p9yzI8WrAX73jXfym0mPinV8mDCqW3LF7g/bvIZdOAT84hS
	lSklUjSTkIC+Vf7Wi82lhDQ8Gu42argZpjiHFzftfwWjSJDFSTEW4k5WzTw8JdUoG2xrJs
	kTOC2p3PEu+aPBSsqVxxblWJvCcOFki3OmFRJTMWhgYhH+AfNPom3yKhGhQt//tmhie98+
	Krf5h1bdD/lbugbqcW2YuVOAARWS2YhBr4R8+koqpoxuwfFLlnLQG32Flq+ltv6UkugxhD
	vuq091QLQcZC/Qx80TvI+Dwb4O5FbbPfTdPjs8GcKrnwTPTYBsR07Yu9YIwFRg==
Message-ID: <d3e4e88b64f8a5c5f5b16563f670e61325c891db.camel@ew.tq-group.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: fix usable ports on 88e6020
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux@ew.tq-group.com, Michael Krummsdorf
 <michael.krummsdorf@tq-group.com>
Date: Wed, 27 Mar 2024 10:42:41 +0100
In-Reply-To: <20240326165215.5fb4326c@wsk>
References: <20240326123655.40666-1-matthias.schiffer@ew.tq-group.com>
	 <20240326143424.3368d9b1@wsk>
	 <35cc888230a0146a7687d8b859e5a6ceffec581a.camel@ew.tq-group.com>
	 <20240326165215.5fb4326c@wsk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 2024-03-26 at 16:52 +0100, Lukasz Majewski wrote:
> Hi Matthias,
>=20
> > On Tue, 2024-03-26 at 14:34 +0100, Lukasz Majewski wrote:
> > > Hi Matthias,
> > >  =20
> > > > From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
> > > >=20
> > > > The switch has 4 ports with 2 internal PHYs, but ports are
> > > > numbered up to 6, with ports 0, 1, 5 and 6 being usable.
> > > >=20
> > > > Fixes: 71d94a432a15 ("net: dsa: mv88e6xxx: add support for
> > > > MV88E6020 switch") Signed-off-by: Michael Krummsdorf
> > > > <michael.krummsdorf@tq-group.com> Signed-off-by: Matthias Schiffer
> > > > <matthias.schiffer@ew.tq-group.com> ---
> > > >=20
> > > > I was unfortunately too busy to notice the issue when the patch
> > > > this Fixes was resubmitted in my name. It would have been better
> > > > to change my From into a Based-on-patch-by or similar when
> > > > modifying it =20
> > >=20
> > > The "discussion" about this work was lasting at least a few months
> > > with several iterations and changing the design decisions ...
> > >  =20
> > > > - and
> > > > the final version obviously wasn't even tested on an 88E6020... =
=20
> > >=20
> > >=20
> > > Can you share on which kernel version have you tested the patch that
> > > you claim that testing was omitted? =20
> >=20
> > Hi Lukasz,
> >=20
> > we are currently testing with commit 71d94a432a15 backported onto a
> > recent Linux 6.1.y. At least on this kernel version, the driver will
> > reject a Device Tree configuration that uses the=C2=A0ports 5 and 6
> > (rightfully so, as num_ports is set to 4), leaving only the
> > internal-PHY ports 0 and 1, and none of the *MII ports that are
> > likely to be used as CPU ports.
> >=20
> > So if the accepted version worked fine for you, your configuration
> > possibly only used the first two ports,
>=20
> And then the penny has dropped....
>=20
>=20
> 	switch@10 {
> 			compatible =3D "marvell,mv88e6250";
> 			reg =3D <0x10>;
>=20
> 			ports {
> 				#address-cells =3D <1>;
> 				#size-cells =3D <0>;
>=20
> 				port@0 {
> 					reg =3D <0>;
> 					label =3D "lan1";
> 				};
>=20
> 				port@1 {
> 					reg =3D <1>;
> 					label =3D "lan2";
> 				};
>=20
> 				port@6 {
> 					reg =3D <6>;
> 					label =3D "cpu";
> 					phy-mode =3D "rmii";
> 					ethernet =3D <&fec2>;
>=20
> 					fixed-link {
> 						   speed =3D <100>;
> 						   full-duplex;
> 					};
> 				};
> 			};
> 		};
>=20
>=20
>=20
> > or newer kernels somehow
> > ignore num_ports when determining if a port number is valid.
> >=20
> > We should be able to repeat our test on a newer kernel next week if
> > needed.
>=20
> I think that considering the above snippet - customer was using only
> port 0 and 1.


Hmm, I don't think that's right - the DTS has port 6 as CPU port, which sho=
uld make the whole probe
of the switch fail with num_ports =3D=3D 4 (`reg >=3D ds->num_ports` check =
in dsa_switch_parse_ports_of())
- that's what we saw on kernel 6.1.y with our board for CPU on port 5.

Best regards,
Matthias


> >=20
> > >  =20
> > > >=20
> > > >=20
> > > >  drivers/net/dsa/mv88e6xxx/chip.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/net/dsa/mv88e6xxx/chip.c
> > > > b/drivers/net/dsa/mv88e6xxx/chip.c index
> > > > 9ed1821184ece..c95787cb90867 100644 ---
> > > > a/drivers/net/dsa/mv88e6xxx/chip.c +++
> > > > b/drivers/net/dsa/mv88e6xxx/chip.c @@ -5503,8 +5503,12 @@ static
> > > > const struct mv88e6xxx_info mv88e6xxx_table[] =3D { .family =3D
> > > > MV88E6XXX_FAMILY_6250, .name =3D "Marvell 88E6020",
> > > >  		.num_databases =3D 64,
> > > > -		.num_ports =3D 4,
> > > > +		/* Ports 2-4 are not routed to pins
> > > > +		 * =3D> usable ports 0, 1, 5, 6
> > > > +		 */
> > > > +		.num_ports =3D 7,
> > > >  		.num_internal_phys =3D 2,
> > > > +		.invalid_port_mask =3D BIT(2) | BIT(3) | BIT(4),
> > > >  		.max_vid =3D 4095,
> > > >  		.port_base_addr =3D 0x8,
> > > >  		.phy_base_addr =3D 0x0, =20
> > >=20
> > >=20
> > >=20
> > >=20
> > > Best regards,
> > >=20
> > > Lukasz Majewski
> > >=20
> > > --
> > >=20
> > > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > > lukma@denx.de Achtung externe E-Mail:=C2=A0=C3=96ffnen Sie Anh=C3=A4n=
ge und Links
> > > nur, wenn Sie wissen, dass diese aus einer sicheren Quelle stammen
> > > und sicher sind. Leiten Sie die E-Mail im Zweifelsfall zur Pr=C3=BCfu=
ng
> > > an den IT-Helpdesk weiter. Attention external email:=C2=A0Open
> > > attachments and links only if you know that they are from a secure
> > > source and are safe. In doubt forward the email to the IT-Helpdesk
> > > to check it.
> > >=20
> > > =C2=A0 =20
> >=20
>=20
>=20
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de
> Achtung externe E-Mail:=C2=A0=C3=96ffnen Sie Anh=C3=A4nge und Links nur, =
wenn Sie wissen, dass diese aus einer sicheren Quelle stammen und sicher si=
nd. Leiten Sie die E-Mail im Zweifelsfall zur Pr=C3=BCfung an den IT-Helpde=
sk weiter.
>   Attention external email:=C2=A0Open attachments and links only if you k=
now that they are from a secure source and are safe. In doubt forward the e=
mail to the IT-Helpdesk to check it.
>=20
> =C2=A0


