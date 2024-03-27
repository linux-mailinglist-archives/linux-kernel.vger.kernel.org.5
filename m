Return-Path: <linux-kernel+bounces-120556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B788D94D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04331F2C891
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B417364A4;
	Wed, 27 Mar 2024 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="yvd26rQF"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0536133;
	Wed, 27 Mar 2024 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528827; cv=none; b=c4LFchDNTVgM5ZotEw22l2xP8jFfUlxsGM+dESyFco4ArbpXUuWCLVuOGUSKDsmHse27Jpzlu4td9miq+ji2H7OZrhM/Mmnt7BjRAwCdZw2l6Ar6t3VxRtzp6GTv8sa7IYkGITv2KMitgNb8wQBSw9EjzJryNOKWqgXnd5in2K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528827; c=relaxed/simple;
	bh=2cHvX2C1EUb4ZihP2jus1JA5EJeiOZXe6b2Yw+HyARA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ck2/PH6lUSz6NXN+4e7LSuMy072CZgC6CJsYvYI/PUuWoOJSyWayYOgny9NEwDSDbNXaSHasbt4vLs79yTt0DU1SCg5DKttk7AqkKYF7tGBPrjxz/cOeeXF7uvdmHMfL4994GU7i7caJT27UaraIiwClG4zUXOl8+2xz3B1sv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=yvd26rQF; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 489DD8803A;
	Wed, 27 Mar 2024 09:40:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711528823;
	bh=Q8ShEKulJS2t/RaIJVmNPYxB7tPMAJ4wYuwJT4NRjz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yvd26rQFjPQKq/wEIkNDNEs5+3WaGPNlf3CKXDfkTUJWlIwxp2ajGHKpUKylonGzJ
	 YU0KYsb1oU1Ufo7w6CGHZoQmAkOMcSS2KYHxQPVQFqcodTNU/IOJTIFsY08HTS1wNK
	 Q/QaJW7Qo+8JwYVAX9B5aK4Bh9jM6hXhcdp4AzlTBaVjnYgka+f+bcm/6YepttIWyZ
	 s45y3Yadualx+VUyJ/3RTDk2ZWstliEtrU1SNPPAIYI4J1J4p9lPPT7aCXzeU9v5jS
	 bp2n5h9SCVH6uC8uu8VAGB7MNgbeNyje2akPviUXjE6WWRG2lMeeydKhajoExrezE/
	 N97HFI9ubdc2w==
Date: Wed, 27 Mar 2024 09:40:15 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Oleksij
 Rempel <o.rempel@pengutronix.de>, <Tristram.Ha@microchip.com>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
 <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan Carpenter
 <dan.carpenter@linaro.org>, Ziyang Xuan <william.xuanziyang@huawei.com>,
 Shigeru Yoshida <syoshida@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 RESEND] net: hsr: Provide RedBox support
Message-ID: <20240327094015.3d2580b0@wsk>
In-Reply-To: <20240327033512.GA1371300@maili.marvell.com>
References: <20240326090220.3259927-1-lukma@denx.de>
	<20240327033512.GA1371300@maili.marvell.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i4=XqKExMgdCHq8s3zAcw2a";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/i4=XqKExMgdCHq8s3zAcw2a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ratheesh,

> On 2024-03-26 at 14:32:20, Lukasz Majewski (lukma@denx.de) wrote:
> > --- a/net/hsr/hsr_device.h
> > +++ b/net/hsr/hsr_device.h
> > @@ -16,8 +16,8 @@
> >  void hsr_del_ports(struct hsr_priv *hsr);
> >  void hsr_dev_setup(struct net_device *dev);
> >  int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device
> > *slave[2],
> > -		     unsigned char multicast_spec, u8
> > protocol_version,
> > -		     struct netlink_ext_ack *extack);
> > +		     struct net_device *interlink, unsigned char
> > multicast_spec,
> > +		     u8 protocol_version, struct netlink_ext_ack
> > *extack); void hsr_check_carrier_and_operstate(struct hsr_priv
> > *hsr); int hsr_get_max_mtu(struct hsr_priv *hsr);
> >  #endif /* __HSR_DEVICE_H */
> > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > index 5d68cb181695..7c5a4bda1cca 100644
> > --- a/net/hsr/hsr_forward.c
> > +++ b/net/hsr/hsr_forward.c
> > @@ -377,6 +377,15 @@ static int hsr_xmit(struct sk_buff *skb,
> > struct hsr_port *port, */
> >  		ether_addr_copy(eth_hdr(skb)->h_source,
> > port->dev->dev_addr); }
> > +
> > +	/* When HSR node is used as RedBox - the frame received
> > from HSR ring
> > +	 * requires source MAC address (SA) replacement to one
> > which can be
> > +	 * recognized by SAN devices (otherwise, frames are
> > dropped by switch)
> > +	 */
> > +	if (port->type =3D=3D HSR_PT_INTERLINK)
> > +		memcpy(&eth_hdr(skb)->h_source,
> > port->hsr->macaddress_redbox,
> > +		       ETH_ALEN); =20
> why not ether_addr_copy here too ?

Good point. I will add it here too.

Thanks for review.

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/i4=XqKExMgdCHq8s3zAcw2a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYD228ACgkQAR8vZIA0
zr0LUggAtzFAXWvLp8aKstfZZplKjvTGe1KpdvV/x35Zgy7CLyU91benf2V5U3y3
fvK70bzEQFLekvrZc60yXq1OMuc6toXj0p8kNf4aJAmoSs4S7+zCTrwGs33J3rV2
MSDTmU8K3foQ2PLEL9wOokriNngu9bREk58p//ABCphDsA6tx/bfOSYvNllyruiB
ASkXP3ECM6aHSdmiPKd6S46hg+fgEaSjigHDX6lE5kkqSTQ3aDUtab2K7dbSQXEO
GNVj3SKFKj37Yk0JdPS/AGuKBAnOTun2v6CnlGwtAYT6PP/8Hs5h4sScWPruDszX
L+yBWf7zfXJUGdmYllwMjYmgWzoWqA==
=/l2d
-----END PGP SIGNATURE-----

--Sig_/i4=XqKExMgdCHq8s3zAcw2a--

