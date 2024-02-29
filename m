Return-Path: <linux-kernel+bounces-86429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C9886C53C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475DC1F23F47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ED85916C;
	Thu, 29 Feb 2024 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="xTyJG0Yj"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527845D90E;
	Thu, 29 Feb 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199055; cv=none; b=OUac2LAxGXxS3D72ngT5LkE0+YOEtrrBLeGBnxCQ13iTaocEEO9iev6AmxfoYGMnrBakhbuBt45tePNehyjBAQ2OxQb7bLDKpdh0uNdGz0MlOlWGF3E1sEhySdqp8q8a+QSKOOfPYb2u60KhXcQTomLNYFWN+9Z3XSBud7ecyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199055; c=relaxed/simple;
	bh=W1XkHC6kMs6fy5Z46APr+CC9gFn1z5X9mDJ/bLvAfeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPqfwCgX+JH20t8dU+BLxK1b0pIpNe18NG1nb16hzKziT1DZEUwwc23oYMYqH0OiC/8VTLlNYVW0TAHrhPjO8dph6cZbRhetVgDSbRhnOk2E19eV2SYNi6gQyBa8FKjjCeWxNS4tiJridQZxwXdRFgcO5JAaVErozqhNqpbbkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=xTyJG0Yj; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C7BDD87C56;
	Thu, 29 Feb 2024 10:30:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709199051;
	bh=CHfO3bdBeQx9G/TpZdihSC/0QgTINu1hZYfx1ot210I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xTyJG0Yj033yXj4MT7h9aUxGxXY6pSDTDtX4FMlRqXNGgzS634nLXLbfX6VGKnLLP
	 eQB2cjJMcgmEUO7byVP7MEUaZRKOK9CoSYQe1dsWRG0pP7ilSWaSW4wAvA47McJF79
	 MeoxCeO/19ke0O2Zg58H/am8n3GtugrYBl2u98rjNsE3brb8k9russdyiSCCXt2b6C
	 jl7yrKLeV1r2odYK6RLS22g8CPiirI2B3LplBxH3kkRz3mCfGQoMQkOeXEVEeGC45j
	 Vzxjf7rejNxhSUd7UJFGFR7qHNMZQ03vpaidTdFKuv8owsvu2qjRPgl/Ar6Ts2Ovqa
	 0lSWBisSeRu2Q==
Date: Thu, 29 Feb 2024 10:30:48 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Eric Dumazet
 <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Tristram.Ha@microchip.com, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>, Ravi Gunasekaran
 <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>, Wojciech Drewek
 <wojciech.drewek@intel.com>, Nikita Zhandarovich
 <n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, Ziyang Xuan
 <william.xuanziyang@huawei.com>, Kristian Overskeid <koverskeid@gmail.com>,
 Matthieu Baerts <matttbe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: hsr: Provide RedBox support
Message-ID: <20240229103048.45ecc1de@wsk>
In-Reply-To: <608850a9-966e-420b-8d16-1ab6baa65025@lunn.ch>
References: <20240228150735.3647892-1-lukma@denx.de>
	<608850a9-966e-420b-8d16-1ab6baa65025@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ugh8IGWgId5MP.WkOG54Lmt";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/ugh8IGWgId5MP.WkOG54Lmt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> >  void hsr_debugfs_rename(struct net_device *dev)
> >  {
> > @@ -95,6 +114,19 @@ void hsr_debugfs_init(struct hsr_priv *priv,
> > struct net_device *hsr_dev) priv->node_tbl_root =3D NULL;
> >  		return;
> >  	}
> > +
> > +	if (!priv->redbox)
> > +		return;
> > +
> > +	de =3D debugfs_create_file("proxy_node_table", S_IFREG |
> > 0444,
> > +				 priv->node_tbl_root, priv,
> > +				 &hsr_proxy_node_table_fops);
> > +	if (IS_ERR(de)) {
> > +		pr_err("Cannot create hsr proxy node_table
> > file\n");
> > +		debugfs_remove(priv->node_tbl_root);
> > +		priv->node_tbl_root =3D NULL;
> > +		return; =20
>=20
> You should not be checking return values from debugfs and not printing
> error messages etc. debugfs is totally option, so you should just keep
> going. The debugfs API should not explode because of a previous
> failure.
>=20
> > --- a/net/hsr/hsr_device.c
> > +++ b/net/hsr/hsr_device.c
> > @@ -142,30 +142,32 @@ static int hsr_dev_open(struct net_device
> > *dev) {
> >  	struct hsr_priv *hsr;
> >  	struct hsr_port *port;
> > -	char designation;
> > +	char *designation =3D NULL; =20
>=20
> Revere christmas tree place. When you go from RFC to a real
> submission, issues like this need fixing. For an RFC its not so bad.
>=20

Ok.

> >  	hsr =3D netdev_priv(dev);
> > -	designation =3D '\0';
> > =20
> >  	hsr_for_each_port(hsr, port) {
> >  		if (port->type =3D=3D HSR_PT_MASTER)
> >  			continue;
> >  		switch (port->type) {
> >  		case HSR_PT_SLAVE_A:
> > -			designation =3D 'A';
> > +			designation =3D "Slave A";
> >  			break;
> >  		case HSR_PT_SLAVE_B:
> > -			designation =3D 'B';
> > +			designation =3D "Slave B";
> > +			break;
> > +		case HSR_PT_INTERLINK:
> > +			designation =3D "Interlink";
> >  			break;
> >  		default:
> > -			designation =3D '?';
> > +			designation =3D "Unknown";
> >  		}
> >  		if (!is_slave_up(port->dev))
> > -			netdev_warn(dev, "Slave %c (%s) is not up;
> > please bring it up to get a fully working HSR network\n",
> > +			netdev_warn(dev, "%s (%s) is not up;
> > please bring it up to get a fully working HSR network\n",
> > designation, port->dev->name); }
> > =20
> > -	if (designation =3D=3D '\0')
> > +	if (designation =3D=3D NULL)
> >  		netdev_warn(dev, "No slave devices configured\n");
> > =20
>=20
> It would be good to split this into multiple patches. Do the A to
> Slave A, B to Slave B, etc as one patch. Then add Interlink.
>=20

Ok. This is particular one can be extracted to separate patch.

> Ideally you want lots of simple patches which are obviously correct,
> each with a good commit message explaining why the change is being
> made.

+1

>=20
> 	Andrew



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ugh8IGWgId5MP.WkOG54Lmt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmXgTsgACgkQAR8vZIA0
zr3DuQgAoKWa5XcWdNa0MSFdLtsAI/2lJu6Tfw52RJEKxtvKx12Qx0QYdyl6a8+l
6pF4aTNIDoQtANv4nrdDBFNSkXWEgc+CYNKooBqx8SEtSQe4mz/+2v4CutXB9PBi
m0vm4NZoVrqcmCnDEp3BfnQETfvFiE/cujMIzf9GP5eKEd0B5YzJ23QW34bMpVwy
ku4t7ZTsgploN7Yds8Z9d8hpsPkgabpmrbxUNdjBTnsNu5k6EBaVk9sIrJkvAjml
sos5d7oxKvKNFuZSqMktj5kNY53iCwEOhm0Ngc8GJcMG3sRs8JfhhMm9Yf88m4C+
y5RRRLNrKl+Jw5d3HQP8bMsTxoAkyw==
=NDUn
-----END PGP SIGNATURE-----

--Sig_/ugh8IGWgId5MP.WkOG54Lmt--

