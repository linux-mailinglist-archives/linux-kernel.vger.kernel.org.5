Return-Path: <linux-kernel+bounces-96244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F934875928
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861D91C20C09
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92D213B78E;
	Thu,  7 Mar 2024 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MCY6Diep"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BDB13AA2D;
	Thu,  7 Mar 2024 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846445; cv=none; b=G4t/t/bwkFp0CMmSaG/5obHEqBDhHaGoj8MCOkeErHiZRP2/UVdAYanHAo/f/nBX5gmt9MoLsiWVjf9mRwtUaS4zihDNyCu5yQCmLqvDDWuVXGeJYn2YP713AcsMACtBLjwiuUKuIc08lC8mqoSN/70F9BUNH6Q3GdyTfMx1Tfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846445; c=relaxed/simple;
	bh=kHhUaCuQDQ0HVnUZKb7McIbvw01f5NCS/4BCYUMhPyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bXGXqTIufYJrTVYNpCRowag2BUeevzCSjAb9op+UNHcrv3lRToqoS4Uk9/9swwXe6rOj4VK9GkmTmPc41QeEoii9P+3Ve52uBdvJqzmU0+++F3WUsmq/kKQ7iQGh/ucONffe6QWkZksItSaeEwp9rcMWAGCJYfopISYCPW8z7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MCY6Diep; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709846440;
	bh=NsaL0BMV+ATbjn7BDSkYB8arL1fvLfUoraJdyzlzm8A=;
	h=Date:From:To:Cc:Subject:From;
	b=MCY6Diepri5lS4hPIh2/gLZdBUPv5b/ruauabk7gl0owg3QlQ/LnKmE4Gbo7eaNLT
	 vfkeCgJeSgkS+fI3HBvW2AdX6S9HgW8tpFF8Xfd710+lci5pEXhX/JM/Mj0bUtDeMu
	 OSlahLTiYjdm8KDOpuVn+bGWVMtpcBmXmFTdJ0ZbOkZz7wWle7MaAeornA8plvetOl
	 83kRTSH3x21tIEDVgmddhkIOnkX4O3A9AWjSYjYnl2dOcpQIP8fTZCdcc1hTFxo/h8
	 JaqUOL0pVFKjQh68vx5IKZDPQtVyeNSnMZvGc0jH2fXWofOxkkKEVXXHpoOTVuETKF
	 tbW4UtLVdITFw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TrMfJ3VYGz4wbh;
	Fri,  8 Mar 2024 08:20:40 +1100 (AEDT)
Date: Fri, 8 Mar 2024 08:20:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the pinctrl tree
Message-ID: <20240308082039.600be106@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rjjg1DiV_EK1K5gMqINuCBH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rjjg1DiV_EK1K5gMqINuCBH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b3811cdff104 ("pinctrl: aw9523: Make the driver tristate")

Fixes tag

  Fixes: a4f15a8d4c82 ("pinctrl: Add driver for Awinic AW9523/B I2C GPIO Ex=
pander")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 576623d70661 ("pinctrl: Add driver for Awinic AW9523/B I2C GPIO Expa=
nder")

--=20
Cheers,
Stephen Rothwell

--Sig_/rjjg1DiV_EK1K5gMqINuCBH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXqL6cACgkQAVBC80lX
0Gy0Qwf+IhYSDUNOsojrfQ0kzDR1ctU23JcFQaJW28gdCma7iXa+sWpv47Of1jHS
RXH1pnwN4hRqPwGnJb5BQT2ys5JzYQ2NQYuMK22QbZ6FJhDihr75DLgTW1zfVwLN
T6xk5+y5w/U3BxAHCaN3RvzEqMgRG/8+/lnys4FbtKF5oWSM+Nqwj4dd697le0Tj
l0Ni+2yZmfQ+R4uc+Y0Lxuc+dUCvweau9VQvVmYlmJNkYfKMm0gzY5txFZW44RQw
VYp2sWnXjB3dZoUrWwDnt1IKmCs1av6HFTLyYPAkgAhHAUkL5e9tL45mZL6wNQkK
Jn4sTxnELWnYlnat/xjVHSm2fhyvcw==
=Yd+d
-----END PGP SIGNATURE-----

--Sig_/rjjg1DiV_EK1K5gMqINuCBH--

