Return-Path: <linux-kernel+bounces-88208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56F686DEAC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF8E1C225EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96BE6A8CB;
	Fri,  1 Mar 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="md+BSHWV"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E4E69D28;
	Fri,  1 Mar 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286962; cv=none; b=UcXKFpW2UbgrAfg6zNlnN0tv16edHSq03AHyJxLH0SoT/i9Laiu3IEj93K94NuCxDeRZudkLcibLR+rYqLygi7fndqsJEOOPmvL2Jh1OmSzls90Jb/EToxDu9t2DdutQZZJLPAQHlSMO97TfppKQIuoxvGhd8Ut7O4LICHvMJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286962; c=relaxed/simple;
	bh=nB4RoPzo73ug6c/YARrBpRfTTCLpVLkR1rpzscqqvgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4g2TJyw8wpU6EEjlOvqgvl6/6drJrK6D79Pw4qWGwHTElb5LoOCXIsuyTgITnA2TDBs2+X+GKFzGuxXBmoqKcJCt+JW0I+gwiknZPpxFvbODYXd2BZlPjT+qEcjqFz6viTCFzs3unhhSK9dLCD70FmFqMd/wwsL72ydSJ2mBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=md+BSHWV; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9342088129;
	Fri,  1 Mar 2024 10:55:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709286957;
	bh=ehYEHbfNMu0NChRHIbLyuBBhUQ+KLNUH2S3I+Evt6mw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=md+BSHWVhlHlIUcLhpNsX8Sen20evAEtzBgResu8ktPoVX0nOA/ZD6V4avVaikqdv
	 xiQMPoRWzT5oOKpLcXsyt4G2K1F9h24gRZ6moGOBx+zNfNXDlGB5ww0qf0k9hLU+Vm
	 0o5CZs/fC4N7hXugfc4TU39IFY+CcVduudBeRTWXpWATOYF/quBPjAAXbbx6aqB2eH
	 1YSePGlanb5PAwZ1WsCzmIfSMgXV3208O+fSUwp8962OThkN5rxtWXVH/BjvTOIjQq
	 lzxsIkWoFSdRsMZ/qpBc05/K5wpumvlu/MTV0mYgRPLkrUgQCrsvusPW4BTFURv+B/
	 MapNhPolb6Ccg==
Date: Fri, 1 Mar 2024 10:55:50 +0100
From: Lukasz Majewski <lukma@denx.de>
To: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, "Florian Fainelli"
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 <netdev@vger.kernel.org>, <Tristram.Ha@microchip.com>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>, "Ravi
 Gunasekaran" <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>,
 "Wojciech Drewek" <wojciech.drewek@intel.com>, Nikita Zhandarovich
 <n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>, Kristian Overskeid
 <koverskeid@gmail.com>, Matthieu Baerts <matttbe@kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] net: hsr: Provide RedBox support
Message-ID: <20240301105550.26de5271@wsk>
In-Reply-To: <64ddec9f-42a8-089a-fb4a-a49a2e80337c@huawei.com>
References: <20240228150735.3647892-1-lukma@denx.de>
	<64ddec9f-42a8-089a-fb4a-a49a2e80337c@huawei.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FQHjZg_Cf39XqB1x9daHbJ/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/FQHjZg_Cf39XqB1x9daHbJ/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi William,

> Give opinions only from the code level.
>=20
> > =20
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
> > +		return;
> > +	} =20
> I think we can use "goto label" to reduce duplicate codes for error
> handling.

This code is already NAK'ed from network maintainers, as debugfs is not
acceptable to give any "API like" information.

Instead the "netlink" API shall be used to provide this information.

>=20
> >  }
> > =20
> > @@ -296,6 +298,7 @@ static void send_hsr_supervision_frame(struct
> > hsr_port *master, struct hsr_priv *hsr =3D master->hsr;
> >  	__u8 type =3D HSR_TLV_LIFE_CHECK;
> >  	struct hsr_sup_payload *hsr_sp;
> > +	struct hsr_sup_tlv *hsr_stlv;
> >  	struct hsr_sup_tag *hsr_stag;
> >  	struct sk_buff *skb;
> > =20
> > @@ -335,6 +338,16 @@ static void send_hsr_supervision_frame(struct
> > hsr_port *master, hsr_sp =3D skb_put(skb, sizeof(struct
> > hsr_sup_payload)); ether_addr_copy(hsr_sp->macaddress_A,
> > master->dev->dev_addr);=20
> > +	if (hsr->redbox) {
> > +		hsr_stlv =3D skb_put(skb, sizeof(struct
> > hsr_sup_tlv));
> > +		hsr_stlv->HSR_TLV_type =3D PRP_TLV_REDBOX_MAC;
> > +		hsr_stlv->HSR_TLV_length =3D sizeof(struct
> > hsr_sup_payload); +
> > +		/* Payload: MacAddressRedBox */
> > +		hsr_sp =3D skb_put(skb, sizeof(struct
> > hsr_sup_payload));
> > +		ether_addr_copy(hsr_sp->macaddress_A,
> > hsr->macaddress_redbox);
> > +	} =20
> If hsr->redbox is true, hsr_sp->macaddress_A will be covered. Do
> ether_addr_copy() twice. Is it better like this:
>=20
> hsr_sp =3D skb_put(skb, sizeof(struct hsr_sup_payload));
>=20
> if (hsr->redbox) {
> 	...
> 	ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
> } else {
> 	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
> }

It may be a bit misleading, as the hsr_sp is the payload for TLV fields
in HSR supervisory frames.

It shall be done as in the code as:

1. First you need to send this HSR "node" MAC address (the
ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr))

2. If the box is a RedBox, then this supervisory frame shall have
_appended_ another TLV with RedBox mac address (it can be the same
as the HSR node in the special case).

The hsr_sp->macaddress_A holds the address to the V (value) field of
the TLV.

>=20
> > +
> >  	if (skb_put_padto(skb, ETH_ZLEN)) {
> >  		spin_unlock_bh(&hsr->seqnr_lock);
> >  		return; =20
>=20
> > =20
> > @@ -448,13 +455,14 @@ static void hsr_forward_do(struct
> > hsr_frame_info *frame) }
> > =20
> >  		/* Check if frame is to be dropped. Eg. for PRP no
> > forward
> > -		 * between ports.
> > +		 * between ports, or sending HSR supervision to
> > RedBox. */
> >  		if (hsr->proto_ops->drop_frame &&
> >  		    hsr->proto_ops->drop_frame(frame, port))
> >  			continue;
> > =20
> > -		if (port->type !=3D HSR_PT_MASTER)
> > +		if (port->type =3D=3D HSR_PT_SLAVE_A ||
> > +		    port->type =3D=3D HSR_PT_SLAVE_B) =20
>=20
> (port->type !=3D HSR_PT_MASTER) is not equivalent to (port->type =3D=3D
> HSR_PT_SLAVE_A || port->type =3D=3D HSR_PT_SLAVE_B). port->type may be
> HSR_PT_INTERLINK or others. Or here is a bugfix? Please check.

Without Redbox support you don't use HSR_PT_INTERLINK. This port shall
behave in similar way to HSR_PT_MASTER - e.g. it will send/receive HSR
untagged frames. That is why the condition has been altered to only
prepare HSR tagged frames for HSR ring port A/B.

>=20
> >  			skb =3D
> > hsr->proto_ops->create_tagged_frame(frame, port); else
> >  			skb =3D
> > hsr->proto_ops->get_untagged_frame(frame, port); @@ -469,7 +477,9
> > @@ static void hsr_forward_do(struct hsr_frame_info *frame)
> > hsr_deliver_master(skb, port->dev, frame->node_src); } else {
> >  			if (!hsr_xmit(skb, port, frame))
> > -				sent =3D true;
> > +				if (port->type =3D=3D HSR_PT_SLAVE_A ||
> > +				    port->type =3D=3D HSR_PT_SLAVE_B)
> > +					sent =3D true;
> >  		}
> >  	}
> >  } =20
>=20
> If my opinions be accepted, Can you add "Reviewed-by: Ziyang Xuan
> <william.xuanziyang@huawei.com>" at next version of patch?

I will add your Reviewed-by: tag, no problem.

Thanks for the input :-)

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/FQHjZg_Cf39XqB1x9daHbJ/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmXhpiYACgkQAR8vZIA0
zr3S1gf/WjpsxibQboT9bZVmYqBI42CusZQPAtv+BKCCQPIAKeU+uxZJYFNdY9X1
1RvPcYudaPtPYdz7MXbVOjFojxHh46PltWoUM3SH+B7NvHFTdFHibnjE//GvDxP1
zEJ3yf2Yk24L9U/F6gc0l4aXAbIlIwF3ptTxUFZBaEEC51XEvPpU+f6PEeABHiK6
seqRQGq6nlU6YUAFpPpvmSTjIx8RYNem/nMApysdVynQeY5J5WyAFNb2Rh2bN6KY
m9wFDWUzXH81aj+nyZ65h11QqIkh5XLhv10AcSFjHpswgbUNZCV5G/zQ8N37mLRX
yxUR5tYuntWOhUG6A6QzcyDp0CNkfw==
=xyoM
-----END PGP SIGNATURE-----

--Sig_/FQHjZg_Cf39XqB1x9daHbJ/--

