Return-Path: <linux-kernel+bounces-161992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE398B544B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4531C2133E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79792249ED;
	Mon, 29 Apr 2024 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="D5SIQ/B/"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE117C60;
	Mon, 29 Apr 2024 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714383143; cv=none; b=U9FSmex0Mp0mGGqvUUWvq9F5vHvFXeDkaHjuI9UF2Kozm1hiS11uyhORfwUPOO7uIjmNjo5kPZULvnmcDWn4SQp+sPNwFnVE0Fm5SaEC5oSBvisqQqiRD9TPoepTKqSS9vap/Ut7Il2glnOaQBXDxc13fprgaXV7bx+vTpGYNmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714383143; c=relaxed/simple;
	bh=XNloNzoCKfywSthQl66EQHHudIv1fxwmL/2J+3y+tLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sn+C8b8XPV8og0GbkbAOr+quzAI1VADILkWhnqLZS8rAZPl1Vv02RZbwFxXedr+GnH+L7XjI8NyoByMiQ0OP+QXalmcYUjYq/EAJmPdHtX/x7uQiTZUS4z0qulSnY/dj9OsjH/mAq1p/QwlIzNGYhbt2SdzRPOfD2+/AIYUapx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=D5SIQ/B/; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 47F3188921;
	Mon, 29 Apr 2024 11:32:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714383140;
	bh=681o/mJoNfUKWFCVcPu8QnHizCVqw29Eqq6HLhF92TY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D5SIQ/B/UmDW/iri0AZWnFo/QNGXmXo+z5QJ5Y0BrYaoW2UWkzL9LGh4FllXPjbAR
	 +eVHr7GYOxKMaa3saUZlR2PEWyB4Z4LCS5qrOiwiKlPMyib87wFh6+mLqV8uXVkR0Z
	 6o4LNzL7nyB5CvbFIgn52nbYFcWnz3rU30ZZUq71JnkYqgeahkyQiT9+JwjhRjLssO
	 rJqN86Pzv4ZrYPqwu8vvVBxh9Q4TaUhRGRubZ9U2HKP7yXnOZf5zrPq7HyGTRi9dB5
	 BnGZpOgJELbLwwVmE5m+R0MjwRsxx1o+8JmASvYiXWcrz/3gMR5nu6ataH3TxQ0V/2
	 Y5fPoES6hmfQQ==
Date: Mon, 29 Apr 2024 11:32:17 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Casper Andersson <casper.casan@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Tristram.Ha@microchip.com, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon
 Horman <horms@kernel.org>, Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Murali Karicheri <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan
 Carpenter <dan.carpenter@linaro.org>, Ziyang Xuan
 <william.xuanziyang@huawei.com>, Shigeru Yoshida <syoshida@redhat.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v5 1/4] net: hsr: Provide RedBox support
 (HSR-SAN)
Message-ID: <20240429113217.0fb8d6d7@wsk>
In-Reply-To: <8634rho41l.fsf@gmail.com>
References: <20240415124928.1263240-1-lukma@denx.de>
	<20240415124928.1263240-2-lukma@denx.de>
	<86mspt7glf.fsf@gmail.com>
	<20240416150359.7362c762@wsk>
	<86bk66hjyf.fsf@gmail.com>
	<20240418173706.206e6a2f@wsk>
	<86mspploa3.fsf@gmail.com>
	<20240419124223.2388295d@wsk>
	<8634rho41l.fsf@gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C6CorqEZXRzDpTNmg9+Lr3=";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/C6CorqEZXRzDpTNmg9+Lr3=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Casper,

> >
> > Hmm... I'm wondering how "proxy" is implemented then.
> > Also, what is the purpose of ProxyNodeTable in that case? =20
>=20
> The ProxyNodeTable becomes the same as the MAC table for the interlink
> port. I.e. normal MAC learning, when a frame is sent by a SAN and
> received on interlink the HW learns that that SMAC is on the interlink
> port (until it ages out).=20

+1

> This table can be read out and used for
> supervision frames.
>=20

I've go through the standard again and it looks like it is mandatory
for RedBox to send supervisory frames with MAC addresses from
ProxyNodeTable as its payload. Moreover, the RedBox MAC address shall
be also send as the second (i.e. following) payload in this frame.

The current RedBox (from net-next) needs to be extended to support it
 - I've started working on this.

> Though, the NodesTable I don't think is used in HW. As I understand
> it's an optional feature.

+1


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/C6CorqEZXRzDpTNmg9+Lr3=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYvaSEACgkQAR8vZIA0
zr2klgf9FsTRrBZ8kpx4smbAThax9QN7aEiGWidRjn19R88sc8gDaGp0I3DCWs/c
uGcLx/7VwFQwjj5FqCxfwWbus7+1Wo3B67dNU62U0TCpN9fqtKeHLFNgtjqStrOO
Q8E3g+pWwvTQFar+FTOSAzmExX4R7eK3BAlq8bFsTT4nd3ET030lVRa/sisDOhWi
RMWHKCea7svwuOYV45dYwzlfXdu0hx8Y7cGUHBmbp8zxcfKN+MJa+ktWwdqNgUPn
xAGGvo4IAzluqbzjNZjaeok1uML4nw8Vm6g/FigO0fM1JylKawhwyy9HpxZhh0jF
zxo+jvH+MSVrvg4Hsh1AzWUUeyqfww==
=H3gL
-----END PGP SIGNATURE-----

--Sig_/C6CorqEZXRzDpTNmg9+Lr3=--

