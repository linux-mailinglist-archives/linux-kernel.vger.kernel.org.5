Return-Path: <linux-kernel+bounces-86412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917A286C50A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462C828DE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2495D74C;
	Thu, 29 Feb 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="OqkIH365"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A45D747;
	Thu, 29 Feb 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198775; cv=none; b=XxbEowVOkMUGEBuEcfBA9njpT8aQ96OGIsCU7iIBgKea+w49o29RmYz82qFgkznhzhvdlWew0J7LmuCFnwBUdkIDl14DTz5ruLmiJC7eeeH96FK5+8D89Sv2RtUcBSji5DAsublksulvPpRHxky0FRdBetd2jHmNKgXskigAqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198775; c=relaxed/simple;
	bh=LTz2lNXyKqAWl+OV2R4/W4e53JnuoSa6h/8g27FD3j0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scCMuaauj5TrDjaUwCJ8+YjYnW3+kD6fzMmGXzPlZf9JDVJ3TPevReRgZgWggJHiskefvfyf0FS73rzkufqhmKFLYM9ry1cOhvlIH3uoaoUS+TY+EBuMl7fNm+2WEC/PEoWDE/vVZc7CiNc51uG2m5/G0XKyhAu9fgeJoltkK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=OqkIH365; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9D014880CD;
	Thu, 29 Feb 2024 10:26:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709198766;
	bh=/3y3hwrWuyFglLG8ptOVhNQiCprvEAiPkPdCyqfV0T8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OqkIH365+dh/IZeNYGueDrwEvDTrdKquseXSwX3fPvqdjNkZ+YDAxENoLdLHQVPQL
	 7hnoqQPcf/yHuGKSHaKTTY94f/YDXE0+IctDCvncBAefHjYqVeYz3gpJqA5UesIVF5
	 m1kERA6heLxC2oZNTsG86Yrp+0UswTGFji4FJ+C7vvqHyjRy5tugZInpvbMfdve7sR
	 g2k10dZ0oVgvD8GFnHsxlTjLIQgQAGQvmwqxgQwC7qczu5Mv5+fMcGuyBTZd/4URGj
	 WyQ6+K44ZHEXxstwGaz4DJ8Hy/BTnz2KkqZ1nSe1DxZIL2e07p3U2FFx5Ar3a+KjSz
	 0nO+C8uTaJfEw==
Date: Thu, 29 Feb 2024 10:25:57 +0100
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
Message-ID: <20240229102557.615c02f3@wsk>
In-Reply-To: <c3880444-3665-4a60-b6ec-f8ae8a9fbf8d@lunn.ch>
References: <20240228150735.3647892-1-lukma@denx.de>
	<20240228083115.01d4c93e@hermes.local>
	<c3880444-3665-4a60-b6ec-f8ae8a9fbf8d@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HXhiR.+AvKxAWKdncrkr5ru";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/HXhiR.+AvKxAWKdncrkr5ru
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> On Wed, Feb 28, 2024 at 08:31:15AM -0800, Stephen Hemminger wrote:
> > On Wed, 28 Feb 2024 16:07:35 +0100
> > Lukasz Majewski <lukma@denx.de> wrote:
> >  =20
> > > =20
> > > +/* hsr_proxy_node_table_show - Formats and prints proxy
> > > node_table entries */ +static int
> > > +hsr_proxy_node_table_show(struct seq_file *sfp, void *data)
> > > +{
> > > +	struct hsr_priv *priv =3D (struct hsr_priv *)sfp->private;
> > > +	struct hsr_node *node;
> > > +
> > > +	seq_printf(sfp, "Proxy Node Table entries for HSR
> > > device\n");
> > > +	seq_puts(sfp, "MAC-Address-SAN,        time_in\n");
> > > +	rcu_read_lock();
> > > +	list_for_each_entry_rcu(node, &priv->proxy_node_db,
> > > mac_list) {
> > > +		seq_printf(sfp, "%pM ", &node->macaddress_A[0]);
> > > +		seq_printf(sfp, "%10lx\n",
> > > node->time_in[HSR_PT_INTERLINK]);
> > > +	}
> > > +	rcu_read_unlock();
> > > +	return 0;
> > > +}
> > > +
> > >  DEFINE_SHOW_ATTRIBUTE(hsr_node_table);
> > > +DEFINE_SHOW_ATTRIBUTE(hsr_proxy_node_table); =20
> >=20
> > NAK
> > Do not abuse sysfs to be a debug proc style output. =20
>=20
> This is actually debugfs, not sysfs.
>=20
> However, i agree, we want information like this exported via netlink
> as the primary interface to the end user. debugfs is not suitable for
> that.

Am I correct, that recommended approach would be to:

1. Modify iproute2 to support for example:

ip addr show dev hsr1 nodes {proxy} ?

2. Shall the currently exported:

/sys/kernel/debug/hsr/hsrX/node_table be left as it is (for legacy
usage) or shall it be removed and replaced with netlink and iproute2 ?

>=20
> 	 Andrew




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/HXhiR.+AvKxAWKdncrkr5ru
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmXgTaUACgkQAR8vZIA0
zr166Qf+PtTfzrYXP7ThEPCaBT1z1kOq7J1fD6bGHn0jQAAafLG3Km5OkuNNObdL
/0mxgNb7JfaPlXuY4SQtR5i1s9BZoWLpLmNQ5tCfvaVjy+e/ac5ct2YrqHCnOPdA
IXBRCf2iZYG6Cvci4S2JJol9ssQea/jgqmHfz1ze8YqtEdwaDS91bwOZshoG1xSl
I3Z7v80GgGGQECIkkznT8xF/sbuFzRUKgh7n4t4ynkopzjDTp6rPTmSo4fXfP4L/
2f/zhXUbzzLsdH8/6rGLRGCcKlF2cmBZpKZbUd8LgCS5y5Rs56IayHv7Rr47FUiZ
VfC9XqFdu2FEhEEok2EDmyXD7sfhUA==
=3OGX
-----END PGP SIGNATURE-----

--Sig_/HXhiR.+AvKxAWKdncrkr5ru--

