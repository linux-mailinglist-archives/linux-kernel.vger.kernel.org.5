Return-Path: <linux-kernel+bounces-119105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E2A88C43D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E324B22BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F252B7581E;
	Tue, 26 Mar 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="DAuhoM/m";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="sj61wnSZ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81DF535AB;
	Tue, 26 Mar 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461625; cv=none; b=sREUV9JIr7E9fGvx+lRPLH55gmPVO0LedC4Sq8uqQu4VigOZcrub2ter5YqBHk2UVMqeDQM0omFWjUOzI0hr4HX67XC+L8NdYdE+NH5GKouggQqSJ7jx1PB6P3JDTMLCTWfo8DVh79MZVdvfau9u5OtgbY3aND/xYyprzWwfvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461625; c=relaxed/simple;
	bh=Gm1WAIrYB3cH17+JMV26qz73QxvJFbmWHlQKnpd2C/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=de5tPLef++HD9YR8G0j4KNwSQFFe6i6NgpiJ96hKnXUrntUqm7ltugSaraO+vS0oKGq348+lpvSYlxySSdGVdBrUPI4tfEbM//GVYdv17dIalt8ozBvT8eWft/BQIQTFrTFKjf/2cCNqoYfYDQX916gZN2mMWCTudHJJ8N68noE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=DAuhoM/m; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=sj61wnSZ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1711461622; x=1742997622;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0EKpZTo5hv6iT79UBNQej/4K4vOd3xcIXh9ByDCTvaQ=;
  b=DAuhoM/m5W+q4Vuq43GmWF+XpDmr8/djsRbECp3At2APu+FIjVnXNI55
   KpZ7yC6Arbgz5NlZZvuhvEARtD5C54NBeQAxnYNWKa27LArSnE05/l9Uk
   mIV9DUVQQ2PB7ruUnfyjPFsn/xnxoZ7KwNMwqzC7ADiGRukPTvjMpCtVk
   O3CY1G6hyPfm5f8ulnnVWJr8GGqwt/8vg5hUcDdtB9uWEXvvn44A54EUd
   JilF9pBV1k+tsc6ZSj/PUhTwfUxEV4F3UnsVufpR9oG5eqokqx1zABRr7
   TVziW7ucSTV/88yyWkJgfbZiL6VPKIhf6/QLjF/LD6AGR9FOpU3wmb/cW
   g==;
X-IronPort-AV: E=Sophos;i="6.07,156,1708383600"; 
   d="scan'208";a="36107278"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Mar 2024 15:00:19 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 080E716E108;
	Tue, 26 Mar 2024 15:00:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1711461614;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0EKpZTo5hv6iT79UBNQej/4K4vOd3xcIXh9ByDCTvaQ=;
	b=sj61wnSZ5Rd6TXOyCPp7MuFTO3vrxAMy34iifMO13YKrF8Jnu2HdtLoSOPIz01z3mEBTg+
	r/EtJoGdeebPAn0LswvOxjbabAriHPjTr3Tlye1G2zSrScT//GzTUa7fiPkwx1YCrPU3MV
	CN4QlrbDeCqCC9byFN7i4SubtjKEB0mst9WizrwOQk4B+lOzDg9fbkrWbLbYWxtpI4ic8p
	1RhubmELwyCy8ECAJjgG676RVW1cL1wHFaWzTkOaMJ0HxMFxl34X3VU4UQlUPdjmWEl57H
	aniAi43PK9b7JgtFKNfiPllyWhOh/tGt6VLehCNyBYKEA/ILEPO6YObeVIpgIg==
Message-ID: <35cc888230a0146a7687d8b859e5a6ceffec581a.camel@ew.tq-group.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: fix usable ports on 88e6020
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux@ew.tq-group.com, Michael Krummsdorf
 <michael.krummsdorf@tq-group.com>
Date: Tue, 26 Mar 2024 15:00:12 +0100
In-Reply-To: <20240326143424.3368d9b1@wsk>
References: <20240326123655.40666-1-matthias.schiffer@ew.tq-group.com>
	 <20240326143424.3368d9b1@wsk>
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

On Tue, 2024-03-26 at 14:34 +0100, Lukasz Majewski wrote:
> Hi Matthias,
>=20
> > From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
> >=20
> > The switch has 4 ports with 2 internal PHYs, but ports are numbered up
> > to 6, with ports 0, 1, 5 and 6 being usable.
> >=20
> > Fixes: 71d94a432a15 ("net: dsa: mv88e6xxx: add support for MV88E6020
> > switch") Signed-off-by: Michael Krummsdorf
> > <michael.krummsdorf@tq-group.com> Signed-off-by: Matthias Schiffer
> > <matthias.schiffer@ew.tq-group.com> ---
> >=20
> > I was unfortunately too busy to notice the issue when the patch this
> > Fixes was resubmitted in my name. It would have been better to change
> > my From into a Based-on-patch-by or similar when modifying it
>=20
> The "discussion" about this work was lasting at least a few months with
> several iterations and changing the design decisions ...
>=20
> > - and
> > the final version obviously wasn't even tested on an 88E6020...
>=20
>=20
> Can you share on which kernel version have you tested the patch that
> you claim that testing was omitted?

Hi Lukasz,

we are currently testing with commit 71d94a432a15 backported onto a recent =
Linux 6.1.y. At least on
this kernel version, the driver will reject a Device Tree configuration tha=
t uses the=C2=A0ports 5 and 6
(rightfully so, as num_ports is set to 4), leaving only the internal-PHY po=
rts 0 and 1, and none of
the *MII ports that are likely to be used as CPU ports.

So if the accepted version worked fine for you, your configuration possibly=
 only used the first two
ports, or newer kernels somehow ignore num_ports when determining if a port=
 number is valid.

We should be able to repeat our test on a newer kernel next week if needed.

Best regards,
Matthias


>=20
> >=20
> >=20
> >  drivers/net/dsa/mv88e6xxx/chip.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/dsa/mv88e6xxx/chip.c
> > b/drivers/net/dsa/mv88e6xxx/chip.c index 9ed1821184ece..c95787cb90867
> > 100644 --- a/drivers/net/dsa/mv88e6xxx/chip.c
> > +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> > @@ -5503,8 +5503,12 @@ static const struct mv88e6xxx_info
> > mv88e6xxx_table[] =3D { .family =3D MV88E6XXX_FAMILY_6250,
> >  		.name =3D "Marvell 88E6020",
> >  		.num_databases =3D 64,
> > -		.num_ports =3D 4,
> > +		/* Ports 2-4 are not routed to pins
> > +		 * =3D> usable ports 0, 1, 5, 6
> > +		 */
> > +		.num_ports =3D 7,
> >  		.num_internal_phys =3D 2,
> > +		.invalid_port_mask =3D BIT(2) | BIT(3) | BIT(4),
> >  		.max_vid =3D 4095,
> >  		.port_base_addr =3D 0x8,
> >  		.phy_base_addr =3D 0x0,
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
>  Attention external email:=C2=A0Open attachments and links only if you kn=
ow that they are from a secure source and are safe. In doubt forward the em=
ail to the IT-Helpdesk to check it.
>=20
> =C2=A0


