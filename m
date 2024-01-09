Return-Path: <linux-kernel+bounces-20755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A068284AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B11C23E70
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5055D36B0E;
	Tue,  9 Jan 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oNyW75Ym"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601EF29431;
	Tue,  9 Jan 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704799233;
	bh=g2o0sp+obm3C+i8AIlUzPBvR52lZ5IozrJgX9L/WxhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oNyW75YmpuFGiq59LWtxmS1dA8SsLNiAYNJQm3byQaXQE1EoSjhbFUK/tPdAaS6PZ
	 7qJtU5Nduzh/1BFxhLw/vzCavq5AnWcF5IwUxwRB31LtDAopvhkh0xXvrXgwmeCriK
	 YvIgK9cfW2kBMUP3CKgB2FeBS6hs8b3+Wi7oqEnaZiZ5DihumRZovLLtze+OKAyoJS
	 LPhVy36grcfuB9h1pBMTLjbOu/afqhkv6Iqs7PYOXjPAvhraZNfRSiT9QSyxxJ5RRU
	 4tRNxIkrBCn1Vb9+BugsGNaubPiCOl5DdmxrI6fmgaAROta4SmveO5pQ8Wuenl4V38
	 WYsFXOT6BLzsQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8T4d1LQyz4wch;
	Tue,  9 Jan 2024 22:20:32 +1100 (AEDT)
Date: Tue, 9 Jan 2024 22:20:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Florian Eckert <fe@dev.tdt.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Lee Jones <lee@kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the leds-lj tree
Message-ID: <20240109222031.6ce4aecc@canb.auug.org.au>
In-Reply-To: <17b4305d9fe1fbed3e39597f0767f7bd@dev.tdt.de>
References: <20240105173352.6ce1a546@canb.auug.org.au>
	<17b4305d9fe1fbed3e39597f0767f7bd@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rRe=mVmiiNQBI0gO1M.LNlk";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rRe=mVmiiNQBI0gO1M.LNlk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Mon, 08 Jan 2024 08:47:07 +0100 Florian Eckert <fe@dev.tdt.de> wrote:
>
> Hello Stephen,
>=20
> thanks for your hint
>=20
> On 2024-01-05 07:33, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the leds-lj tree, today's linux-next build (htmldocs)
> > produced this warning:
> >=20
> > Warning: /sys/class/leds/<led>/rx is defined 2 times:
> > Documentation/ABI/testing/sysfs-class-led-trigger-tty:7
> > Documentation/ABI/testing/sysfs-class-led-trigger-netdev:49
> > Warning: /sys/class/leds/<led>/tx is defined 2 times:
> > Documentation/ABI/testing/sysfs-class-led-trigger-tty:15
> > Documentation/ABI/testing/sysfs-class-led-trigger-netdev:34 =20
>=20
> The behavior of the tty trigger can be controlled via the Rx and Tx file.
> If a value is set in Rx or Tx, the LED flashes when data is transmitted in
> this direction. The same behavior is used for the netdev trigger.
> I have therefore used the same pattern for the new tty trigger as well.
>=20
> I didn't know that the names have to be unique!
>=20
> I'm a bit at a loss as to what to do now. Should I put a prefix "tty_"
> in front of the names so that we have "tty_rx", "tty_tx"?
>=20
> If we do it this way, however, the general question arises as to whether
> we do have to use a prefix everywhere! If new triggers are added, then the
> names for a config file are already used up and anyone who then wants to =
use
> the same name for an other trigger with the same config file because it d=
escribe
> the same function must then work with a prefix!

I think this is only a problem with the documentation system, not the
actual sysfs file naming.  Maybe just adding a uniquifying bit to the
"<led>" part will solve it.  Or maybe we need the tooling to be taught
about placeholders in sysfs names (or maybe there is already a way).

--=20
Cheers,
Stephen Rothwell

--Sig_/rRe=mVmiiNQBI0gO1M.LNlk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWdK/8ACgkQAVBC80lX
0GxeGwf8Cas2QEbX8fm38wekU0LqoDRU6qxknQtt+cshSeZbdyJu3lSQ+Q2c7wwg
TOi1CrkXg9KRBeJ02Sp/yQEL/BwYRTJUx+CeGcuzxDILYMLcjyL1uJnOa3xRwq54
ZpUE8ZRLZO9EHG6NZYLPud1CdPTN1Dxzh6vr3HRA+qQLF6PIpZdC4NIr0mRcrO0r
e+VEcgP2v8J0oONHCZbTAMm18AQepYuQ4RTsa8TVz/mFz8WA7u1Y9JaHGRATaZ1L
HoMCgCOMdf9qbNNdUkkPCENM0qrLWQdwfJk4GiXBM/htea/G/115rgq7MpqhU9jz
Nz36yUpHUgp0Gb8OWx5YrGbsC9FBPg==
=YQkM
-----END PGP SIGNATURE-----

--Sig_/rRe=mVmiiNQBI0gO1M.LNlk--

