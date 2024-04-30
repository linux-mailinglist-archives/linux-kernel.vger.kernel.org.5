Return-Path: <linux-kernel+bounces-163936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D099B8B7651
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005551C223A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEF317164B;
	Tue, 30 Apr 2024 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="RyuLuTwz"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654C17109E;
	Tue, 30 Apr 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481575; cv=none; b=TQbgTWmboFAmSvWq94XTvokpVs+Y133TOTSt1IOt4P763xn13Owb6R/pQL+6rCZO6boqhpRxod2oE2EMVyDx+6gMs6amNDvsq4kwbGVQOjWCY1cQfOXfprzlyIr5553uiOdo75ZYntU9JuO03SyIrVDV1LJ8V722DATYFOXl/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481575; c=relaxed/simple;
	bh=2E419P6fMJlzYdQ2LO4hCVUmJ5LcUx40GsPAGK5Pq4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkU5o253Nu6vFKX/Y/fIN9RFeRjwpjPrWFDSNxhdTkkZaqd+n4xoRPtLcbXG2kJWjaVMTdSZFQRvC+p7/BD1aWpKVe+Nb+nT7/qB/KHcR4d/4AM7QymrXk7ptETJu8NMetlEX7miWS3dP7vNqXJlQckpvDPfCIXQZ0SmQki/KRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=RyuLuTwz; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A92EE889D3;
	Tue, 30 Apr 2024 14:52:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714481566;
	bh=k1FoftdU31Qu+LEcIxZCVB74GjfGfCp4axxIDaVrqAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RyuLuTwzQYZ5Lwb3RJq4v9rAExaJgGybH8JhDGt69Z8JLyNE2fh1nsg4hDYolHdAu
	 SsSbX/07Vo1aSz1t9xr9H0/sYXGF1975/MdfFBHzQgAhziXXgBBoslSurgmsdMVa9H
	 9GqomdfYmxNGIK+7mhcuNw3MIrSB/gAT6oDY6SExCyB3ArJAJI00kx9wqFFaAjjZLw
	 W8rzV0iFe2ofQfMqo4dyzEczUwq8kHjF71dn7ZtddRUwy93hmbYk1BNv9PZqaCAf20
	 Sm7cWlzCVhEUhBr5p8Na9whQCQ8IwtLVE6fv4Jl+D7HEZjhqAFVDpyLEfuCUqv+9Z9
	 TMgdVc5qQaDPA==
Date: Tue, 30 Apr 2024 14:52:43 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Casper
 Andersson <casper.casan@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Tristram.Ha@microchip.com, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon
 Horman <horms@kernel.org>, Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Murali Karicheri <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan
 Carpenter <dan.carpenter@linaro.org>, Ziyang Xuan
 <william.xuanziyang@huawei.com>, Shigeru Yoshida <syoshida@redhat.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] hsr: Simplify code for announcing HSR nodes
 timer setup
Message-ID: <20240430145243.34b82105@wsk>
In-Reply-To: <20240429104026.0fe3de0f@kernel.org>
References: <20240425153958.2326772-1-lukma@denx.de>
	<20240426173317.2f6228a0@kernel.org>
	<20240429120904.2ab5248c@wsk>
	<20240429104026.0fe3de0f@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Bw.S4.DcI2Q_96DL9tIqW/s";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/Bw.S4.DcI2Q_96DL9tIqW/s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Mon, 29 Apr 2024 12:09:04 +0200 Lukasz Majewski wrote:
> > > if the
> > > timer is already running we'll mess with the spacing of the
> > > frames, no?   =20
> >=20
> > When NETDEV_CHANGE is trigger for reason different than carrier (or
> > port state) change and the netif_oper_up() returns true, the period
> > for HSR supervisory frames (i.e. HSR_ANNOUNCE_INTEVAL) would be
> > violated.
> >=20
> > What are here the potential threads? =20
>=20
> Practically speaking I'm not sure if anyone uses any of the weird
> IFF_* flags, but they are defined in uAPI (enum net_device_flags) and
> I don't see much validation so presumably it's possible to flip them.

Ok, I see.

Then - what would you recommend instead? The approach with manual
checking the previous state has described drawbacks.

I've poked around kernel sources and it looks like the netif_oper_up()
is used in conjunction with netif_running():

netif_running(dev) && netif_oper_up(dev)

so, IMHO the netif_running(dev) shall be added to the condition.


In the uapi/include/linux/if.h there are serveral IF_OPER_* flags
defined. It looks to me that only for the IF_OPER_UP the HSR interface
shall send announcement supervisory frames. With other conditions it
shall be turned off.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Bw.S4.DcI2Q_96DL9tIqW/s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYw6ZsACgkQAR8vZIA0
zr1vyQf/b9dD0cGGRR2fJR7RDNo7Ul0teNxdptDZ1BEmoUzA+9rqc7FbAks5fMpd
Yryrt5Lf18eUOgKRDXI8p393k61794K4TH6gSHklkI9InLA0pNhkCNufbE79VHhZ
ErviOn4c46V0J7OTlb3dDlmm0/Isg74a0wVboHKgBSvHnHaNlaClxeG3v70i3bBn
aQIVcmCQ3mYRbSY+/A/uOCryp27Ii53Llonk5FY3lLNFX3kwHCZdN9SbgC0OY1wJ
ggPSqcN1lcTuJkwDhdd03K2N6FSMCA8fRRBkj5ei4e4VWEbq/GyRDddS5HV/urox
6q/anTEaL7Haft6BGSgnn8yoB262bA==
=LiR9
-----END PGP SIGNATURE-----

--Sig_/Bw.S4.DcI2Q_96DL9tIqW/s--

