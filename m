Return-Path: <linux-kernel+bounces-148109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D98A7DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8C828211F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926C7D3F1;
	Wed, 17 Apr 2024 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="U9cQ+UQ3"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E2A7D08D;
	Wed, 17 Apr 2024 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341603; cv=none; b=bVeYO+mjvUOBW/fdNfLu6TWZjHpxETvHBQj7uePC6DfgHJPmfltv1QeV/8ucDOytEwEE3ImxlREgvEoThA8+MlikORU6RZru9jf0GDCIynuEHWwhyJwgvasV9oLiSaDXtuF19mp9DVa+tQf3ssAox7QlTcJlUjajCkwHiYLWcJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341603; c=relaxed/simple;
	bh=i+9ibrN7xQYF7jszyyKajXwvT9v6vT1EHAkllbhGHok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABqeKWIXW3or6FDM5KLWRgxvNWMuoIOKH3AjIaLe1pN37fnJw4McWLPQ/tQZWWHvQQV0Wumfe5hIgHKXVpVh8QVAB0LkpxUiPV+3L96ByV55B/mAMiBXcA5ZIU5bQSqWuInl1DF2yqhI11HePSSBn5KuHkcItVh0Czrhx7H60Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=U9cQ+UQ3; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 22A4688414;
	Wed, 17 Apr 2024 10:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713341599;
	bh=EBRwVJBVGCvWEFjCFr9Su6sxchjpnOMHNir9g/hPkxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U9cQ+UQ34JjNLbJ5fP0O4qG7KxmT2+b6pRK7XyzsmfczUbKLPGiJvxofs6tVMCPek
	 TQArD17gTgQ7yFkXGeigRXN+RBT+BdF5gxxCZdgcgjLPKOm6PIirn6lgVNzzH+Rgme
	 P1Mw9Fimp9c5MPYdTCyuCLlYzVesUHwqzRxa4IenJc5UAZvgURRmhhvdblhTNBvaT9
	 M2GcDvJR2q0RMl9tRG2vnpIZcKjEWxRDTYep8z2tldqBX1bFdSobsPZmOGCoV/Mx+8
	 Jdv25h9lz+9kHsj/HMUTWA9SPPQu2bCF9Ud9yLP4PSQv83KLjOdnb+2jipktfK74xx
	 /DrHTClWDHZVw==
Date: Wed, 17 Apr 2024 10:13:11 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Casper Andersson <casper.casan@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
 <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan Carpenter
 <dan.carpenter@linaro.org>, Ziyang Xuan <william.xuanziyang@huawei.com>,
 Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] net: hsr: Provide RedBox support (HSR-SAN)
Message-ID: <20240417101311.72228af0@wsk>
In-Reply-To: <86v84yfhn9.fsf@gmail.com>
References: <20240402085850.229058-1-lukma@denx.de>
	<86v84yfhn9.fsf@gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ehB5eGyndMJSU/tCS.JccLQ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/ehB5eGyndMJSU/tCS.JccLQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Casper,

> Hi,
>=20
> Out of curiosity, are you planning to implement the remaining RedBox
> modes too (PRP-SAN, HSR-HSR, HSR-PRP)?
>=20

Currently I'm assigned to implement HSR-SAN.

> On 2024-04-02 10:58 +0200, Lukasz Majewski wrote:
> > Changes for v3:
> >
> > - Modify frame passed Port C (Interlink) to have RedBox's source
> > address (SA) This fixes issue with connecting L2 switch to
> > Interlink Port as switches drop frames with SA other than one
> > registered in their (internal) routing tables. =20
>=20
> > +	/* When HSR node is used as RedBox - the frame received
> > from HSR ring
> > +	 * requires source MAC address (SA) replacement to one
> > which can be
> > +	 * recognized by SAN devices (otherwise, frames are
> > dropped by switch)
> > +	 */
> > +	if (port->type =3D=3D HSR_PT_INTERLINK)
> > +		ether_addr_copy(eth_hdr(skb)->h_source,
> > +				port->hsr->macaddress_redbox); =20
>=20
> I'm not really understanding the reason for this change. Can you
> explain it in more detail?

According to the HSR standard [1] the RedBox device shall work as a
"proxy" [*] between HSR network and SAN (i.e. "normal" ethernet)
devices.

This particular snippet handles the situation when frame from HSR node
is supposed to be sent to SAN network. In that case the SA of HSR
(SA_A) is replaced with SA of RedBox (SA_RB) as the MAC address of
RedBox is known and used by SAN devices.


Node A  hsr1  |=3D=3D=3D=3D=3D=3D| hsr1 Node Redbox |   |
(SA_A) [**]   |	     |           eth3   |---| ethX SAN
	      |      |        	 (SA_RB)|   |  (e.g switch)


(the =3D=3D=3D=3D=3D=3D represents duplicate link - like lan1,lan2)

If the SA_A would be passed to SAN (e.g. switch) the switch could get
confused as also RedBox MAC address would be used. Hence, all the
frames going out from "Node Redbox" have SA set to SA_RB.

According to [1] - RedBox shall have the MAC address.
This is similar to problem from [2].

> The standard does not say to modify the
> SA. However, it also does not say to *not* modify it in HSR-SAN mode
> like it does in other places. In HSR-HSR and HSR-PRP mode modifying
> SA breaks the duplicate discard.

IMHO, the HSR-SAN shall be regarded as a "proxy" [*] between two types
(and not fully compatible) networks.

> So keeping the same behavior for all
> modes would be ideal.
>=20
> I imagine any HW offloaded solutions will not modify the SA, so if
> possible the SW should also behave as such.

The HW offloading in most cases works with HSR-HSR setup (i.e. it
duplicates frames automatically or discards them when recived - like
ksz9477).

I think that RedBox HW offloading would be difficult to achieve to
comply with standard. One "rough" idea would be to configure
aforementioned ksz9477 to pass all frames in its HW between.



>=20
> BR,
> Casper

Notes:

[*] - However there is no specific "guidelines" on how the "proxy"
shall be implemented.

[**] - With current approach - the SAN MAC addresses are added to
"node table" of Node A. For Node RedBox those are stored in a separate
ProxyNodeTable. I'm not sure if this is the best possible approach
[***], as ideally only MAC addresses of HSR "network" nodes shall be
visible.

[***] - I think that this "improvement" could be addressed when HSR
support is added to Linux as it is the pre-requisite to add support for
it to iproute2. Afterwards, the code can be further refined (as it
would be added to net-next anyway).

[****] - As I'm now "on the topic" - I can share full setup for busybox to =
run
tests included to v5 of this patch set.


Links:

[1] - IEC 62439-3:2021

[2] -
https://elixir.bootlin.com/linux/latest/source/net/hsr/hsr_framereg.c#L397

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ehB5eGyndMJSU/tCS.JccLQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYfhJcACgkQAR8vZIA0
zr2n0Af/YMTGB4xu7QXPD1weAXmR0tgdhdYYtwdh3U5rz9H5k5RLkwtFDyX63elc
0Bb2JGLzYpdJHt9c5OhQ6jxyLdJUOE4WfdJ237OMd3tUKQqU0oOPM2yK6h6N1r7g
2dgauxn1DuFI1UV2zHHH/n8H3Xb+efsK2vaOTtxWUsCwoXjnmcU0yo8qMtu/UXC1
aug03+4EBfqKkgdbTmcH8TlRt7uOHkd4ehdgU1w0LuGChj+Zl/YkM3SPsnQt1vL8
bAy/aIgMhIKWCOBsdXizz4be32uFVhjvizYfwlgcXr04P/O5H3F+MVTU3TpimVMA
LbdDk7JDSp4++jJS5eEdR/Dju6c/Cg==
=YZMw
-----END PGP SIGNATURE-----

--Sig_/ehB5eGyndMJSU/tCS.JccLQ--

