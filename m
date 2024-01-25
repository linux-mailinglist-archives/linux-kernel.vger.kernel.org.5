Return-Path: <linux-kernel+bounces-37826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2976783B61F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFE21C22416
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A98ECC;
	Thu, 25 Jan 2024 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OG9odM+7"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF2662B;
	Thu, 25 Jan 2024 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706143100; cv=none; b=IoveJc+zup/lnScGkg+XSNQ8ZOUT2OCMJJ2KirCoCzV/aNtAMroAxe5FxQWXqCr84cjH1qIcetEyd1gtV7j0RQIPwxHmE3tATN0kZbK6J3UX34p+F2eqhnHzto5xABuS00MOlfbZKp3W5xGOx1p4bBf482QYGGk3u7mVrusQk4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706143100; c=relaxed/simple;
	bh=Z6Gx+1HI/cQiz1WsNvPb5BnvWUuaUrMwOZklI9se1G0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQkntV7f5F0qAjYOkYBCJ4VJ/YIgcFHPF6hW6XKvH0HjXkEJeo+4O8vJU7vydJ+ntMYHLK5zHl3EoO4ZDHn3aklTh1fzz4NHvszH4OonZkTlpTwCl2KC/3VslV2Li59ds++rESOYoWlUjJE386XW5+QINDz91yevSeMBAKbpbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=OG9odM+7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706143096;
	bh=YwXNSfbCPDAxJEf8R0beprqeBVbc89WpZb+pt8wZxhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OG9odM+70bg+i3iy3g5324JYZ/TmAC08tIF56ZIXaQls7TpQk3f+emWrHK+YnFKH2
	 aSd2+TPuI0ESsYtf3Jv3j8q4cer9Vi0UnIpboLXDa9ij+MWkjjhNnvQIMHGIliDejh
	 +bqtk2I7H63Dzp3yrNu2ftthqPPms7LAfF6ZkR8PjNiGhZN8LVbT4e3tEhh98wXC0U
	 U/FGzIIIQhIb3P42drfMxAHF0ejA3wue13Dr5/GGvFDgr3nemA3bjAb0y2Wp+vjq8n
	 UWEy2Zbvulv75HPruTenoM7s9mSRhXXN7DZoj+tBnIJF9k5DPxyYgFePUSgzmDcg2y
	 6Tbdggo1SShag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TL2481CF5z4wc8;
	Thu, 25 Jan 2024 11:38:15 +1100 (AEDT)
Date: Thu, 25 Jan 2024 11:38:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Florian Eckert <fe@dev.tdt.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Lee Jones <lee@kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the leds-lj tree
Message-ID: <20240125113814.532f1fb5@canb.auug.org.au>
In-Reply-To: <20240109222031.6ce4aecc@canb.auug.org.au>
References: <20240105173352.6ce1a546@canb.auug.org.au>
	<17b4305d9fe1fbed3e39597f0767f7bd@dev.tdt.de>
	<20240109222031.6ce4aecc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4uO6+UUiXI0D9d4GYIhnp8B";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/4uO6+UUiXI0D9d4GYIhnp8B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 9 Jan 2024 22:20:31 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Mon, 08 Jan 2024 08:47:07 +0100 Florian Eckert <fe@dev.tdt.de> wrote:
> >
> > thanks for your hint
> >=20
> > On 2024-01-05 07:33, Stephen Rothwell wrote: =20
> > > Hi all,
> > >=20
> > > After merging the leds-lj tree, today's linux-next build (htmldocs)
> > > produced this warning:
> > >=20
> > > Warning: /sys/class/leds/<led>/rx is defined 2 times: Documentation/A=
BI/testing/sysfs-class-led-trigger-tty:7 Documentation/ABI/testing/sysfs-cl=
ass-led-trigger-netdev:49
> > > Warning: /sys/class/leds/<led>/tx is defined 2 times: Documentation/A=
BI/testing/sysfs-class-led-trigger-tty:15 Documentation/ABI/testing/sysfs-c=
lass-led-trigger-netdev:34   =20
> >=20
> > The behavior of the tty trigger can be controlled via the Rx and Tx fil=
e.
> > If a value is set in Rx or Tx, the LED flashes when data is transmitted=
 in
> > this direction. The same behavior is used for the netdev trigger.
> > I have therefore used the same pattern for the new tty trigger as well.
> >=20
> > I didn't know that the names have to be unique!
> >=20
> > I'm a bit at a loss as to what to do now. Should I put a prefix "tty_"
> > in front of the names so that we have "tty_rx", "tty_tx"?
> >=20
> > If we do it this way, however, the general question arises as to whether
> > we do have to use a prefix everywhere! If new triggers are added, then =
the
> > names for a config file are already used up and anyone who then wants t=
o use
> > the same name for an other trigger with the same config file because it=
 describe
> > the same function must then work with a prefix! =20
>=20
> I think this is only a problem with the documentation system, not the
> actual sysfs file naming.  Maybe just adding a uniquifying bit to the
> "<led>" part will solve it.  Or maybe we need the tooling to be taught
> about placeholders in sysfs names (or maybe there is already a way).

I am still seeing these warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/4uO6+UUiXI0D9d4GYIhnp8B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWxrXYACgkQAVBC80lX
0GxV1Qf/bYGwt4bH5nc7W/ImRPtKuWZYgw1QJek/CY9UD4JGqOxrZqRTW4Kd/9gU
XpdsmaYOKXdOaTRvIszBMDsi2V/IBrcm0fssjicaO4N3l8iPyOJMhruTyqHzt5lH
yPm5LhxC/Pwr+IV18GONTqpR+vVKszVlqinS2CZCg34G9fUSE9SA1r8qOIg/r49I
xl2gRYcflDuEh2V+UuM0GXAZcdN/ZEviCQoAWS6IUOjgr9QBiOnYk7QEJSKs6KZ8
8bI0PQr6ijZouTAgxYfDj4vLBjmOHrzXbxjT+w51O0IlGsNYOolUyVcIjC4gN0Zw
U0x8Fw6TNCrZo8xd4Sbf6dyXKMMzHA==
=SSGo
-----END PGP SIGNATURE-----

--Sig_/4uO6+UUiXI0D9d4GYIhnp8B--

