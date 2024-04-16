Return-Path: <linux-kernel+bounces-146845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE458A6BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9111C214CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DECD12BF3A;
	Tue, 16 Apr 2024 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="LL11ftvI"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD433BB30;
	Tue, 16 Apr 2024 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272653; cv=none; b=dBqs+7PryHtI/XdcYQz4c5Jp7aXoRSEyNRedCq/q/L7hZgkBIJGxrY5q1fS0ubpYv2HrPXnaUKZw14JnrszXfPJ9NPIQVt1YpyOe2/ps0Ecg0IDfPpsD8a0x5Tvt2aOgOqH7DI+VzeDTAibOZCiJcQvQAFrYgkXtwB/Nhou3+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272653; c=relaxed/simple;
	bh=jyl2cZDoiVvnuF7lXdamfX/f0T/b00HRDO03z0SlXSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVgE6XrRdCFNmaEYN07kXnJLHcaKw+G+iWJEx6u6dtCUwylLyPBlRPBq49eWlWODi8jRm5x8SixAU59FXnYfxXtjxblVSZWULP/Pz++dg+AKowenRXT4CyGLQVOKPVcTYBgiy3LmhMRIjrzOAqMP0KrBtjKeqD3Y//azwRXb71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=LL11ftvI; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 717688840B;
	Tue, 16 Apr 2024 15:04:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713272647;
	bh=SblT9Hg6Us3aYenhyXkE7xfTTuCdWBuQ0gQ35LqzdW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LL11ftvI7PahbwlHIJlaTXrry/T+V2II4XKnF05LaycYiqjf4FdSIV/zfESBrhxAn
	 XdFxMfLjX/5ub7EHxMVeP1bA32b8gvmme1fFScg3hiRAh/Q+Z4lh9scpNNzKzXu+8n
	 GtGYF2a+Dnug6L1YJHcTsJOdcWBAqgq3D3MAvwePRa5lMQZA/MPTUO+OjQaEen6wRX
	 yvAys1ZtfwLTYyKgsdTspLnQZfcEp1tUCXTCl0tmRFojKJ7d9Rv6OU8X2sT1YAGmuM
	 BlPgBzrk/Kgm9FnmL84tzpkoKcenr4pKQgl2RsIrtwj2pYhewbl1i3POXeiFDRb+JF
	 2l8MoWKdE4CQA==
Date: Tue, 16 Apr 2024 15:03:59 +0200
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
Message-ID: <20240416150359.7362c762@wsk>
In-Reply-To: <86mspt7glf.fsf@gmail.com>
References: <20240415124928.1263240-1-lukma@denx.de>
	<20240415124928.1263240-2-lukma@denx.de>
	<86mspt7glf.fsf@gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A+WHqGBLm_6dHzdxwFnq_a3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/A+WHqGBLm_6dHzdxwFnq_a3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Casper,

I've pasted the reply here, so we can discuss the newest patch set (v5).

> Hi,
>=20
> On 2024-04-15 14:49 +0200, Lukasz Majewski wrote:
> > - Modify frame passed Port C (Interlink) to have RedBox's source
> > address (SA) This fixes issue with connecting L2 switch to
> > Interlink Port as switches drop frames with SA other than one
> > registered in their (internal) routing tables. =20
>=20
> You never responded to my comment regarding this on v4. The same SA
> should be able to go through a whole HSR and/or PRP network without
> being replaced.
> https://lore.kernel.org/netdev/20240404125159.721fbc19@wsk/T/#m9f18ec6a8d=
e3f2608908bd181a786ea2c4fbc5e7
>=20
> BR,
> Casper

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
ksz9477 [3]).

I think that RedBox HW offloading would be difficult to achieve to
comply with standard. One "rough" idea would be to configure
aforementioned ksz9477 to pass all frames in its HW between SAN and HSR
network (but then it wouldn't filter them).

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

[****] - As I'm now "on the topic" - I can share full setup for busybox
to run tests included to v5 of this patch set.


Links:

[1] - IEC 62439-3:2021

[2] -
https://elixir.bootlin.com/linux/latest/source/net/hsr/hsr_framereg.c#L397

[3] -
https://elixir.bootlin.com/linux/latest/source/drivers/net/dsa/microchip/ks=
z9477.c#L1341


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/A+WHqGBLm_6dHzdxwFnq_a3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYedz8ACgkQAR8vZIA0
zr35uAgAwCtfMgEKKQfSUIvYDmNPdJcAri6fGbohes+LlnSPb36GLnMXOUmtYEMX
ljUgmP+20s3PM3+t79HmXL8QvU0rAPGQIcPVgZw9yHyMvO5XVf9e0hN/3+LTycTR
c0jPdgjBiWWQExpMTB3UeyKEO4sxmaWunayKZqdkTTvd6nAyS2TJyqvdDD4bUxc0
+lHSLmcq/FDl8km7JSoiovaH5T+ROhLpVSX0REnkiOlMWuZg4DwRGWwKAEZa6kgY
3zk7nY9MpTcXe9J4A+Uld6mtUZfdC3Dp9ueeARRh4oUq/RAy2TJvdkju1D5ooq69
Cm6dO8TlP3c4YkH1Hq5oiWX7ZE/q4A==
=Jbmo
-----END PGP SIGNATURE-----

--Sig_/A+WHqGBLm_6dHzdxwFnq_a3--

