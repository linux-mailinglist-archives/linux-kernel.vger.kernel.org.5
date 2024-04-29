Return-Path: <linux-kernel+bounces-162019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A78368B54BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E3AB21D84
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504702C6B9;
	Mon, 29 Apr 2024 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Z7Yw9T90"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574936B08;
	Mon, 29 Apr 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385358; cv=none; b=PltI9Np5/JcQEK2+ZD4aTRNLtGUyNDIiC+3fjpUDYrQVnBuI0W1N7qwZkF+cyLGLJ+sUXmNmQenMOq8VoxK5sJL6gQYnJ8omkJ1by1MQ2Hh4gV/0JjOucZtk/9M2ek8TTPAnSeOvVlTd3d7NaKQgCB391wozqP2b/uBMMrwrcmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385358; c=relaxed/simple;
	bh=G2/+Y3GgbI8aI/B+0/EYdGDtINvqDlJjG6idi7Fd8R8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1+NAlZXtZEzCGzMNqWDGdtZMVU9zx8ls1uJyN8r0a+610YAWKpdDaW9bY7v/lYOMGaSUK3gogwiLyXUYsOyhaLl0LLy9EkGUU0YP+3SwRhoKz3d8rIfMHy8Zxsqj7treAYFx0Na8gDNDDqVzxObXPqV4iXBQBS2nNE3vKdlexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Z7Yw9T90; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B2F18888B9;
	Mon, 29 Apr 2024 12:09:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714385354;
	bh=hozHacjgRDNOnhvQH0iZPoT7EiNmXii511+IJqeqwM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z7Yw9T903myUj6aIGuaBmFOR0Nqk9IbNmQjxpp3OeoR+R9mYlduBDEPhs1JwiOqz6
	 /3Epii+HdNFysW3ZWr88FJEKessu0x3O76NkO6LLiyXU8MHYXhjTw6BnyzojhkIusZ
	 /ZOp/M9Bt6A/Z/YgJi+Z+OXhi3QbwxfPNLd+YuMhTDLLfcmBJ74tdVPlyaAAzg5HQl
	 /FA5XOBGsvnLke+08/ZSJ+yiNq7MV6QD4f5MNVmx+Wact3z5ZVnSx6rzFXsE/XBc5p
	 Hcj4WHQOw2oyk1BeKcCKt66U1Izx1kZHj4ZEkAgRqdX2KXPK1qIb87r3m+69Gxga1S
	 IiFw/ewlW3/vA==
Date: Mon, 29 Apr 2024 12:09:04 +0200
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
Message-ID: <20240429120904.2ab5248c@wsk>
In-Reply-To: <20240426173317.2f6228a0@kernel.org>
References: <20240425153958.2326772-1-lukma@denx.de>
	<20240426173317.2f6228a0@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I+vBB1VmXraGYDKfIpStYt9";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/I+vBB1VmXraGYDKfIpStYt9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Thu, 25 Apr 2024 17:39:58 +0200 Lukasz Majewski wrote:
> > Up till now the code to start HSR announce timer, which triggers
> > sending supervisory frames, was assuming that hsr_netdev_notify()
> > would be called at least twice for hsrX interface. This was
> > required to have different values for old and current values of
> > network device's operstate.
> >=20
> > This is problematic for a case where hsrX interface is already in
> > the operational state when hsr_netdev_notify() is called, so timer
> > is not configured to trigger and as a result the hsrX is not
> > sending supervisory frames to HSR ring.
> >=20
> > This error has been discovered when hsr_ping.sh script was run. To
> > be more specific - for the hsr1 and hsr2 the hsr_netdev_notify() was
> > called at least twice with different IF_OPER_{LOWERDOWN|DOWN|UP}
> > states assigned in hsr_check_carrier_and_operstate(hsr). As a
> > result there was no issue with sending supervisory frames.
> > However, with hsr3, the notify function was called only once with
> > operstate set to IF_OPER_UP and timer responsible for triggering
> > supervisory frames was not fired.
> >=20
> > The solution is to use netif_oper_up() helper function to assess if
> > network device is up and then setup timer. Otherwise the timer is
> > activated. =20
>=20
> NETDEV_CHANGE can get called for multiple trivial reasons,

I've assumed that NETDEV_CHANGE would be called when the link has
changed - i.e. it is down/up or carrier is down/up.

The timer shall be running _only_ when the hsrX port is fully
operational (i.e. at least one of 'slave' ports is up and running).

The motivation for this patch was to enable HSR announce timer not only
on state change, but also when the ethernet device is already up (as it
happens with QEMU + netns setup).
=20

> if the
> timer is already running we'll mess with the spacing of the frames,
> no?

When NETDEV_CHANGE is trigger for reason different than carrier (or
port state) change and the netif_oper_up() returns true, the period for
HSR supervisory frames (i.e. HSR_ANNOUNCE_INTEVAL) would be violated.

What are here the potential threads?

>=20
> If there is a path where the device may get activated without the
> notifier firing - maybe we can check carrier there and schedule the
> timer?

As I've stated above - IMHO the "announce" supervisory frames shall be
send only when HSR interface is up and running.

>=20
> Also sounds like a bug fix, so please add a Fixes tag.

Ok.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/I+vBB1VmXraGYDKfIpStYt9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYvccAACgkQAR8vZIA0
zr0TQwgAmiinnrEjl02V7oRVmns2RXgo0N67PHRCw/opUZQcwZmVg411wwf6q3et
ixxfTSpNU6W/lKji8tOFxTRnWKJ60ihmSPoCV35JSa6lpgLC/0GKR64S2LbSuwpT
J4t3S2//UapEMJbLBS6hMF2Pzr3DrGDqsu1Nl7GFVllbQSLkFlbzZ2gCWTArSL+l
5ZTcjVJifc6ymnYS69zlHtyzfuvpqdhSHtJZyZZsV3ovoNXpFCvJSnJ5ZgreXkf+
AMNI1L+U8dXgj43CvBJAkV9+JjUiBMdmkZE1wcXwCpgpVkGeTWXVUB3lGiyyQSk3
BUCZhX+eZl3uwotqA+FGRbfDa7GbRQ==
=DHDP
-----END PGP SIGNATURE-----

--Sig_/I+vBB1VmXraGYDKfIpStYt9--

