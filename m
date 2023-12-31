Return-Path: <linux-kernel+bounces-13665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06248820AC0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224461C213A6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9F623D0;
	Sun, 31 Dec 2023 09:33:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6FE184C;
	Sun, 31 Dec 2023 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rJsC1-0006qn-2M;
	Sun, 31 Dec 2023 10:33:12 +0100
Date: Sun, 31 Dec 2023 10:33:02 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless 3/5] wifi: b43: Stop/wake correct queue in PIO
 Tx path when QoS is disabled
Message-ID: <20231231103302.04cc37ae@barney>
In-Reply-To: <874jfzutm5.fsf@protonmail.com>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com>
 <20231230045105.91351-4-sergeantsagara@protonmail.com>
 <cb9dcb49-ad94-40df-9f01-a28df3daf6c3@lwfinger.net>
 <877ckvwk5v.fsf@protonmail.com>
 <ca357d13-7da9-490f-9e69-4674c6ede057@lwfinger.net>
 <874jfzutm5.fsf@protonmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r=5bS5OUpR0X2s9laKNCGGE";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/r=5bS5OUpR0X2s9laKNCGGE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Dec 2023 00:02:32 +0000
Rahul Rameshbabu <sergeantsagara@protonmail.com> wrote:

> > Unfortunately, it is very difficult to get the parameters for fwcutter =
from an
> > x86 binary. Some of the other architectures are easier. =20
>=20
> Just tried this with the x86 binary just because and ran into extraction
> issues as expected. I could not find other architecture options from
> Broadcom's download page, but I may not have been looking well enough...
>=20
>   =E2=9D=AF b43-fwcutter ./wlc_hybrid.o_shipped
>   Sorry, the input file is either wrong or not supported by b43-fwcutter.
>   This file has an unknown MD5sum 6889dbd24abf8006de5cc6eddd138518.

b43-fwcutter works only on known files. It has a table of hashes of these f=
iles.

But there is a script that can be used to create a hash table entry for a .=
o file:
https://bues.ch/cgit/b43-tools.git/plain/fwcutter/mklist.py

This probably doesn't work on x86 binaries, though.
But maybe by reading the script you can get an idea how this works.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/r=5bS5OUpR0X2s9laKNCGGE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmWRNU4ACgkQ9TK+HZCN
iw6dXxAAjoFT8JXQctX2icj9/t4AVoMQ9kgs5Y6Ki2W1B1tiVD/Pdee1QRb2lKiB
zueFBGt7BCJ2jAD29LbgxUYb8BK2KVooAowFKG+m45bsB04PNccp0egbJ5hc62rz
aAV2+4sag0EhAWtEExBt+POZKoRg2f7E7mLsEoe74e4oD+KNxhPy3vgzKOcctWxr
Hecjv6VoDjDlPi5jMZ593tKUk1n9Tvel4zcSb/ThG/bInX9ZuqUCNBFwV9sRCLVH
V4//tDqiBLOLDdJwU0NmEX72t0yiOeIohFvmThVJvEzxx0VKXZgjVuzsjjMQABNg
1Hy1ITPhWcxkztIJGkSUaHBP7bZ+vzNg3PsE8MJ3gVhWa737UlQQNHg9oHO42xJ0
Tlg3Ay5qQpZEI/d5F9RKij7/TJhUBQfTrhsCUFxBg95bPGZmpJBdSdOzo8GY1mo+
5Kh2LTyoWID7X8rObDsoDyx8x2XIIVq0iwMQWyndaA0xC6ga5aIRkl+I3QMhN59z
o35QAviJrpoRSoJZKWM7DuwENnvlCTSmHs1Qe8MLc8eHnoDrkAbacCftdpgjH5ds
Q1kRhI7MLOB5KWBxoBIZD5crVUEBfWBW9uAk6elSA/W3FUoJLvbJqGDeXybu5hSy
fJYSkbGNowtEJVGTeCVCgs9nvy/YZXU0tx0l4nxZ8epZMU1iAx4=
=EDd5
-----END PGP SIGNATURE-----

--Sig_/r=5bS5OUpR0X2s9laKNCGGE--

