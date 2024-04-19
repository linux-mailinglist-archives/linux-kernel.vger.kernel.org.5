Return-Path: <linux-kernel+bounces-151543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B438AB049
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD481F23487
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049031304AF;
	Fri, 19 Apr 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XNKn9MzX"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798468565D;
	Fri, 19 Apr 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535535; cv=none; b=mt7ftrnoBAGgfk8M3AU5NdThWUTornJzzRllkpT62E9J5BrxUh32yAFDoi8DkaATLfMFdN7tCowRsyT/uT5lxddzrQvZNwY1T021mnHW+FcWjs+Zi5JYiLTg+9wUu1ncDGB3OESAd2r4ioz2m69dfXIDoRphBQQ+eSyJB9VlxwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535535; c=relaxed/simple;
	bh=f5NvPYvWSkOfW7nqTrzZAUGvlR2y3BQphtON8UO3/cE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=remcOjubjoXiPq6yFBOYW/DPWCtRDYKe4HZSzF72OsLlRJThqLU7DZt7fRHzrkMFnExWQ6r9pLOEpoHhTvkdbkGf3bbTLiT9w750Rn1PH3JeoAswy2Gf+/dvjPh/DbBWJolJ7pZjo36xWiEVbMHMJTu5EOCWSxpifb6sg3Ul9lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XNKn9MzX; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 49E79885FA;
	Fri, 19 Apr 2024 16:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713535525;
	bh=43SEtoRInOLXOPUiy3bMiJsEFmAQ9z9IlWRqSgyxzTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XNKn9MzXJRlQ4rZpIvVasXfQT0g/k279x9N9tKEU+n3hrMDGxor9ujH81QqWNpaKz
	 pnzpXvZfe/LI+PR1hnwnay6MZjo9k7W0p5i9gpK1rSo/fWLBNq70y01l53nAU96Ops
	 Pkh6E0W4C1+5ecung8Ui9XzODXf3rGtVffImIYEEVz242u7gnuvuEktMqxzYdAJ81n
	 pzd5QZd5+s327m3tVuCHKkBkPZXpDUYjaPf0cd4FvbZ1UTSKiJPnYm6+I7bNHnlosT
	 YFkbI6lLaQc00k28Wpts5GlNX/pOhj48t2rh3qtgQsp83QzDk2SFqir2Tn7SA9XHv7
	 qYjZHjDR/zLng==
Date: Fri, 19 Apr 2024 16:05:15 +0200
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
Message-ID: <20240419160515.7bc88a9a@wsk>
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
Content-Type: multipart/signed; boundary="Sig_/LL=n12_LCt5cezsdP0qZhW3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/LL=n12_LCt5cezsdP0qZhW3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Casper,

> On 2024-04-19 12:42 +0200, Lukasz Majewski wrote:
> > Hi Casper,
> > =20
> >> On 2024-04-18 17:37 +0200, Lukasz Majewski wrote:
> >> Hi Lukasz,
> >>  =20
> >> > Hi Casper,
> >> >   =20
> >> >> Hi,
> >> >>=20
> >> >> Sorry for the late reply, I was awaiting confirmation on what I
> >> >> can say about the hardware I have access to. They won't let me
> >> >> say the name :( but I can give some details.   =20
> >> >
> >> > Ok, good :-)
> >> >
> >> > At least I'm not alone and there is another person who can
> >> > validate the code (or behaviour) on another HSR HW.
> >> >
> >> > (Some parts of the specification could be double checked on
> >> > another HW as well).
> >> >   =20
> >> >>=20
> >> >> On 2024-04-16 15:03 +0200, Lukasz Majewski wrote:   =20
> >> >> >> On 2024-04-02 10:58 +0200, Lukasz Majewski wrote:     =20
> >> >> >> > Changes for v3:
> >> >> >> >
> >> >> >> > - Modify frame passed Port C (Interlink) to have RedBox's
> >> >> >> > source address (SA) This fixes issue with connecting L2
> >> >> >> > switch to Interlink Port as switches drop frames with SA
> >> >> >> > other than one registered in their (internal) routing
> >> >> >> > tables.=20
> >> >> >>      =20
> >> >> >> > +	/* When HSR node is used as RedBox - the frame
> >> >> >> > received from HSR ring
> >> >> >> > +	 * requires source MAC address (SA) replacement to
> >> >> >> > one which can be
> >> >> >> > +	 * recognized by SAN devices (otherwise, frames
> >> >> >> > are dropped by switch)
> >> >> >> > +	 */
> >> >> >> > +	if (port->type =3D=3D HSR_PT_INTERLINK)
> >> >> >> > +		ether_addr_copy(eth_hdr(skb)->h_source,
> >> >> >> > +
> >> >> >> > port->hsr->macaddress_redbox);  =20
> >> >> >>=20
> >> >> >> I'm not really understanding the reason for this change. Can
> >> >> >> you explain it in more detail?     =20
> >> >> >
> >> >> > According to the HSR standard [1] the RedBox device shall work
> >> >> > as a "proxy" [*] between HSR network and SAN (i.e. "normal"
> >> >> > ethernet) devices.
> >> >> >
> >> >> > This particular snippet handles the situation when frame from
> >> >> > HSR node is supposed to be sent to SAN network. In that case
> >> >> > the SA of HSR (SA_A) is replaced with SA of RedBox (SA_RB) as
> >> >> > the MAC address of RedBox is known and used by SAN devices.
> >> >> >
> >> >> >
> >> >> > Node A  hsr1  |=3D=3D=3D=3D=3D=3D| hsr1 Node Redbox |   |
> >> >> > (SA_A) [**]   |	     |           eth3   |---| ethX SAN
> >> >> > 	      |      |        	 (SA_RB)|   |  (e.g
> >> >> > switch)
> >> >> >
> >> >> >
> >> >> > (the =3D=3D=3D=3D=3D=3D represents duplicate link - like lan1,lan=
2)
> >> >> >
> >> >> > If the SA_A would be passed to SAN (e.g. switch) the switch
> >> >> > could get confused as also RedBox MAC address would be used.
> >> >> > Hence, all the frames going out from "Node Redbox" have SA
> >> >> > set to SA_RB.
> >> >> >
> >> >> > According to [1] - RedBox shall have the MAC address.
> >> >> > This is similar to problem from [2].     =20
> >> >>=20
> >> >> Thanks for the explanation, but I still don't quite follow in
> >> >> what way the SAN gets confused. "also RedBox MAC address would
> >> >> be used", when does this happen? Do you mean that some frames
> >> >> from Node A end up using the RedBox MAC address so it's best if
> >> >> they all do?   =20
> >> >
> >> > The SAN (let's say it is a switch) can communicate with RedBox or
> >> > Node A. In that way the DA is different for both (so SA on reply
> >> > is also different). On my setup I've observed frames drop (caused
> >> > probably by switch filtering of incoming traffic not matching the
> >> > outgoing one).
> >> >
> >> > When I only use SA of RedBox on traffic going to SAN, the
> >> > problem is gone.
> >> >
> >> > IMHO, such separation (i.e. to use only RedBox's SA on traffic
> >> > going to SAN) is the "proxy" mentioned in the standard.
> >> >   =20
> >> >>=20
> >> >> I see there is already some address replacement going on in the
> >> >> HSR interface, as you pointed out in [2]. And I get your idea
> >> >> of being a proxy. If no one else is opposed to this then I'm
> >> >> fine with it too.  =20
> >> >
> >> > Ok.
> >> >   =20
> >> >> >> The standard does not say to modify the
> >> >> >> SA. However, it also does not say to *not* modify it in
> >> >> >> HSR-SAN mode like it does in other places. In HSR-HSR and
> >> >> >> HSR-PRP mode modifying SA breaks the duplicate discard.     =20
> >> >> >
> >> >> > IMHO, the HSR-SAN shall be regarded as a "proxy" [*] between
> >> >> > two types (and not fully compatible) networks.
> >> >> >     =20
> >> >> >> So keeping the same behavior for all
> >> >> >> modes would be ideal.
> >> >> >>=20
> >> >> >> I imagine any HW offloaded solutions will not modify the SA,
> >> >> >> so if possible the SW should also behave as such.     =20
> >> >> >
> >> >> > The HW offloading in most cases works with HSR-HSR setup
> >> >> > (i.e. it duplicates frames automatically or discards them
> >> >> > when recived - like ksz9477 [3]).
> >> >> >
> >> >> > I think that RedBox HW offloading would be difficult to
> >> >> > achieve to comply with standard. One "rough" idea would be to
> >> >> > configure aforementioned ksz9477 to pass all frames in its HW
> >> >> > between SAN and HSR network (but then it wouldn't filter
> >> >> > them).     =20
> >> >>=20
> >> >> I don't know anything about ksz9477. The hardware I have access
> >> >> to is supposed to be compliant with 2016 version in an offloaded
> >> >> situation for all modes (HSR-SAN, PRP-SAN, HSR-PRP, HSR-HSR).
> >> >> =20
> >> >
> >> > Hmm... Interesting.
> >> >
> >> > As fair as I know - the ksz9477 driver from Microchip for RedBox
> >> > sets internal (i.e. in chip) vlan for Node_A, Node_B and
> >> > Interlink, so _all_ packets are flowing back and forth between
> >> > HSR and SAN networks ....  =20
> >> >> Though, I haven't
> >> >> verified if the operation is fully according to standard.   =20
> >> >
> >> > You may use wireshark on device connected as SAN to redbox and
> >> > then see if there are any frames (especially supervisory ones)
> >> > passed from HSR network.   =20
> >>=20
> >> I realized I should clarify, what I'm running is non-upstream
> >> software. =20
> >
> > Ok.
> > =20
> >> And by offloaded I mean the redbox forwarding is
> >> offloaded. Supervision frames are still handled in SW and only
> >> sent on HSR/PRP ports, and doesn't reach any SAN nodes. Basic
> >> operation works as it should. =20
> >
> > Ok.
> > =20
> >>  =20
> >> >> It does not
> >> >> modify any addresses in HW.   =20
> >> >
> >> > By address - you mean the MAC addresses of nodes?   =20
> >>=20
> >> I mean that it forwards all frames without modification (except
> >> HSR/PRP and VLAN tags). It does not update SMAC with the proxy MAC
> >> like your implementation does. =20
> >
> > Hmm... I'm wondering how "proxy" is implemented then.
> > Also, what is the purpose of ProxyNodeTable in that case? =20
>=20
> The ProxyNodeTable becomes the same as the MAC table for the interlink
> port. I.e. normal MAC learning, when a frame is sent by a SAN and
> received on interlink the HW learns that that SMAC is on the interlink
> port (until it ages out). This table can be read out and used for
> supervision frames.

Yes, this is how this patch handles it.

>=20
> Though, the NodesTable I don't think is used in HW. As I understand
> it's an optional feature.

Yes.

>=20
> >>  =20
> >> >> Does it call
> >> >> port_hsr_join and try to join as an HSR port?    =20
> >> >
> >> > No, not yet.
> >> >
> >> > The community (IIRC Vladimir Oltean) suggested to first implement
> >> > the RedBox Interlink (HSR-SAN) in SW. Then, we may think about
> >> > adding offloading support for it.
> >> >   =20
> >> >> Do we maybe need a
> >> >> separate path or setting for configuring the interlink in the
> >> >> different modes (SAN, HSR, PRP interlink)?   =20
> >> >
> >> > I think that it shall be handled as an extra parameter (like we
> >> > do have now with 'supervision' or 'version') in ip link add.
> >> >
> >> > However, first I would like to have the "interlink" parameter
> >> > added to iproute2 and then we can extend it to other modes if
> >> > requred.   =20
> >>=20
> >> Alright, doing SW implementation first sounds good. From userspace
> >> it can probably be an extra parameter. But for the driver
> >> configuration maybe we want a port_interlink_join? (when it comes
> >> to implementing that). =20
> >
> > IMHO, having port_interlink_join() may be useful in the future to
> > provide offloading support.
> > =20
> >>=20
> >>=20
> >> I did some testing with veth interfaces (everything in SW) with
> >> your patches. I tried to do a setup like yours
> >>                =20
> >>                   +-vethA---vethB-+
> >>                   |               |
> >> vethF---vethE---hsr0             hsr1
> >>                   |               |
> >>                   +-vethC---vethD-+
> >>=20
> >> Sending traffic from vethF results in 3 copies being seen on the
> >> ring ports. One of which ends up being forwarded back to vethF
> >> (with SMAC updated to the proxy address). I assume this is not
> >> intended behavior. =20
> >
> > I've reported this [2] (i.e. duplicated packets on HSR network with
> > veth) when I was checking hsr_ping.sh [1] script for regression.
> >
> > (However, I don't see the DUP pings on my KSZ9477 setup).
> >
> >  =20
> >>=20
> >> Setup:
> >> ip link add dev vethA type veth peer name vethB
> >> ip link add dev vethC type veth peer name vethD
> >> ip link add dev vethE type veth peer name vethF
> >> ip link set up dev vethA
> >> ip link set up dev vethB
> >> ip link set up dev vethC
> >> ip link set up dev vethD
> >> ip link set up dev vethE
> >> ip link set up dev vethF
> >>=20
> >> ip link add name hsr0 type hsr slave1 vethA slave2 vethC interlink
> >> vethE supervision 45 version 1 ip link add name hsr1 type hsr
> >> slave1 vethB slave2 vethD supervision 45 version 1 ip link set dev
> >> hsr0 up ip link set dev hsr1 up
> >>=20
> >> I used Nemesis to send random UDP broadcast packets but you could
> >> use whatever: nemesis udp -d vethF -c 10000 -i 1  =20
> >
> > Ok, I will check nemesis load as well. =20
>=20
> Nemesis doesn't do anything specific, just generates packets. The
> command above sends a packet at 1 second intervals.
>=20
> > Can you check the hsr_redbox.sh (from this patch set) and
> > hsr_ping.sh ? =20
>=20
> Running in SW I get the same results as you, hsr_redbox.sh passes and
> hsr_ping.sh fails.

Ok.

>=20
> I haven't tried on HW. I'll see if I can find some time for it but it
> might take more time to prepare.

Ok. Thanks for help.

>=20
> BR,
> Casper


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/LL=n12_LCt5cezsdP0qZhW3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYiehsACgkQAR8vZIA0
zr16vAf/dadYUJk2OFHTR2s0U/JdMS4zN4xiENOCGD3kLqVthY8FhIP4Bj92+HQe
toLREfcNZ0lJWUz9IvYba3DnMdjyoBaAzvTuz7BRuDYqkreeoJZsk5aPCaAAHrYw
Jps2C+0ezx++Ft5VN+7EeG3OIVDIDoHCA4xl+EAFpLNgrIVd5ABRGPcuUmM+zdT6
KxVhxkqgtTiBto7wNQR9PsPjgMWqAeGzWlvSDCCqu+6Twk4VJ6wOBcYXFQYYSo3R
f7fYrPVx3meV+lfvMFbb/ChLym0xOEqOMc+iZqRgNGPUTW5UAYdQPBHzTNvmZPT/
tL82QeCRJRxYxqj8e2+7LSn3sGm3tg==
=IlLu
-----END PGP SIGNATURE-----

--Sig_/LL=n12_LCt5cezsdP0qZhW3--

