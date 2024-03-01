Return-Path: <linux-kernel+bounces-88193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F5986DE60
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7774B1F25190
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876876A8B8;
	Fri,  1 Mar 2024 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="MTpq8QL3"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E423BD;
	Fri,  1 Mar 2024 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285842; cv=none; b=QDp6XcWNn7aOm2PxJVxhms75vBppuKau+zBMq9tELcJ1fs1NTgkxiEAqqsDux/wAaqnG9jly+2bUV4WGsR3uioL4JWJxwQF4DepYfXLmiMKtOBpmliQoYn3Rm/cSikIWhfcNHIGCNXsZ5IqMxpXci5BYTaYqkScF90JcxxkB/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285842; c=relaxed/simple;
	bh=UmCaLfTDgVu9H3AdRuLN0U4ks9rrBGcqfM0mq0kvurc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u64Nd0eSe5QMeAjpaHWIyvB+KzOjHiAJ80hiw9sUlbbM8tjMuSg7GkXDG2Dbj3wVqPoP4JaGPteAJg3+3icC2GIQZgpPSy3/ATkOi+QZOJXfMrVeE0YwpfOQHHXibAXMKI44q40nXViZHPubjTI9cvnoUu/zxK3C9tde5EeeHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=MTpq8QL3; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id DF0B388125;
	Fri,  1 Mar 2024 10:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709285833;
	bh=OUCLiwUxgrW9Y1OI4sLD33zS7d7BRB5TAcfygrVCJfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MTpq8QL3psHv2+KpKA8HhThm8sISWomYvr0L5JDechSCIV+eLlG2Ixlvllauh77kh
	 WLgPhqGc+kFxZ3xVV3StAVo/p4pQvxNHSogZX4oMgMqvOumJ3zxLvtWPbTnOkVYOxX
	 rLVeEqsR3XWEcq2z2gKU5K9wFgiTY7CJ6jdw8+7jQ2hz8Kxgz4xSp7FMpQQvO5I/Zd
	 uxbBk6LdjagJa1E7498KJj5CvDm1BIgZDD7+b/hi/kcDFADq90E2gNG9Kyfs9nPwKa
	 4+x6ifr3KFMWqxF43CVBtSSWto1hX1b2Sxe7uqU95WtRXl6FWkuoS+osl1TUxx0Tcd
	 jS2sgAByg0acg==
Date: Fri, 1 Mar 2024 10:37:05 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Eric Dumazet <edumazet@google.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Tristram.Ha@microchip.com, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>, Ravi
 Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>,
 Wojciech Drewek <wojciech.drewek@intel.com>, Nikita Zhandarovich
 <n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, Ziyang Xuan
 <william.xuanziyang@huawei.com>, Kristian Overskeid <koverskeid@gmail.com>,
 Matthieu Baerts <matttbe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: hsr: Provide RedBox support
Message-ID: <20240301103705.2f308b83@wsk>
In-Reply-To: <399bf6c2-c9be-4f41-8df5-8d9655e34003@lunn.ch>
References: <20240228150735.3647892-1-lukma@denx.de>
	<20240228083115.01d4c93e@hermes.local>
	<c3880444-3665-4a60-b6ec-f8ae8a9fbf8d@lunn.ch>
	<20240229102557.615c02f3@wsk>
	<399bf6c2-c9be-4f41-8df5-8d9655e34003@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gYCWTCB/.I.6xagM6ho1gyQ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/gYCWTCB/.I.6xagM6ho1gyQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> On Thu, Feb 29, 2024 at 10:25:57AM +0100, Lukasz Majewski wrote:
> > Hi Andrew,
> >  =20
> > > On Wed, Feb 28, 2024 at 08:31:15AM -0800, Stephen Hemminger
> > > wrote: =20
> > > > On Wed, 28 Feb 2024 16:07:35 +0100
> > > > Lukasz Majewski <lukma@denx.de> wrote:
> > > >    =20
> > > > > =20
> > > > > +/* hsr_proxy_node_table_show - Formats and prints proxy
> > > > > node_table entries */ +static int
> > > > > +hsr_proxy_node_table_show(struct seq_file *sfp, void *data)
> > > > > +{
> > > > > +	struct hsr_priv *priv =3D (struct hsr_priv
> > > > > *)sfp->private;
> > > > > +	struct hsr_node *node;
> > > > > +
> > > > > +	seq_printf(sfp, "Proxy Node Table entries for HSR
> > > > > device\n");
> > > > > +	seq_puts(sfp, "MAC-Address-SAN,        time_in\n");
> > > > > +	rcu_read_lock();
> > > > > +	list_for_each_entry_rcu(node, &priv->proxy_node_db,
> > > > > mac_list) {
> > > > > +		seq_printf(sfp, "%pM ",
> > > > > &node->macaddress_A[0]);
> > > > > +		seq_printf(sfp, "%10lx\n",
> > > > > node->time_in[HSR_PT_INTERLINK]);
> > > > > +	}
> > > > > +	rcu_read_unlock();
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  DEFINE_SHOW_ATTRIBUTE(hsr_node_table);
> > > > > +DEFINE_SHOW_ATTRIBUTE(hsr_proxy_node_table);   =20
> > > >=20
> > > > NAK
> > > > Do not abuse sysfs to be a debug proc style output.   =20
> > >=20
> > > This is actually debugfs, not sysfs.
> > >=20
> > > However, i agree, we want information like this exported via
> > > netlink as the primary interface to the end user. debugfs is not
> > > suitable for that. =20
> >=20
> > Am I correct, that recommended approach would be to:
> >=20
> > 1. Modify iproute2 to support for example:
> >=20
> > ip addr show dev hsr1 nodes {proxy} ? =20
>=20
> Something like that. iproute2 is more than the ip command. There is
> also bridge, dcb, vdpa, etc. So you need to decide where it fits best.
> Maybe as part of bridge? Or even a command of its own.

IMHO, 'bridge' is not the best place for hsr output, as 'NodeTable' can
(and should) be provided for non-redbox communication.

For now the ip looks like the best place.

>=20
> > 2. Shall the currently exported:
> >=20
> > /sys/kernel/debug/hsr/hsrX/node_table be left as it is (for legacy
> > usage) or shall it be removed and replaced with netlink and
> > iproute2 ? =20
>=20
> There is no legacy usage. debugfs is unstable, it is not KAPI. Nothing
> is expected to use it, because it could disappear at any time, its
> format can change, etc. For a long time, debugfs was not liked in
> networking, because it was abused and tools built on top of it, often
> vendor tools. We much prefer well defined interfaces such as
> netlink. But it seems like things are becoming a little bit more
> loose.

Ok. Thanks for the explanation.

> If you have a well defined netlink API making debugfs
> pointless, you can probably keep the debugfs code :-) But you can also
> remove it.

I would prefer to keep the code.

>=20
> 	   Andrew


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/gYCWTCB/.I.6xagM6ho1gyQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmXhocEACgkQAR8vZIA0
zr2XfggAt937GNfSLjMdbOOgWXh+2zIDkuWIoTWrbQ98heJ2eDIDXpK/mUWIxcWl
7aJMN6FEQhSKbSpqyFjVFOfGjtgEwHccWaQeQhifC/ta4aSXVd+1kTnGLRTw0pL9
Gyz/6R8kAphE+V7ZqToGDS/lkWA4OpRg4j/rKTwLhSj0skfNi8WYBKufz6fmygK1
843tUkfw87CzbHhp4zfIAG2dGTm9nrLt7MHiw6Vb7lYuOD9Vb6fCDCKh4C3TI/Gb
bNC41T4kUkZ9KAzT8Z4Z4CMXSwuIYitxoHB7iOgstrDKOK9qTXuz1cGEiSJoXbrJ
xj0e+eZ+DLhH2UnVb+GZeShJNfFLiA==
=xtnk
-----END PGP SIGNATURE-----

--Sig_/gYCWTCB/.I.6xagM6ho1gyQ--

