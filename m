Return-Path: <linux-kernel+bounces-6637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481C8819B54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048C8288425
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6B21F611;
	Wed, 20 Dec 2023 09:24:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6ED1F5E4;
	Wed, 20 Dec 2023 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rFsoJ-0001dV-37;
	Wed, 20 Dec 2023 10:24:15 +0100
Date: Wed, 20 Dec 2023 10:23:07 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: Larry.Finger@lwfinger.net, kvalo@kernel.org,
 linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH net-next] wifi: b43legacy: clean up some inconsistent
 indentings
Message-ID: <20231220102307.7dd1f187@barney>
In-Reply-To: <20231220011209.127586-1-yang.lee@linux.alibaba.com>
References: <20231220011209.127586-1-yang.lee@linux.alibaba.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/y4FaB=q8xjAQErvJOYfvURh";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/y4FaB=q8xjAQErvJOYfvURh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Dec 2023 09:12:09 +0800
Yang Li <yang.lee@linux.alibaba.com> wrote:

> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D7783

This link is not publicly accessible.

> a/drivers/net/wireless/broadcom/b43legacy/dma.c +++
> b/drivers/net/wireless/broadcom/b43legacy/dma.c @@ -174,8 +174,8 @@
> static struct b43legacy_dmaring *priority_to_txring( {
>  	struct b43legacy_dmaring *ring;
> =20
> -/*FIXME: For now we always run on TX-ring-1 */
> -return dev->dma.tx_ring1;
> +	/*FIXME: For now we always run on TX-ring-1 */
> +	return dev->dma.tx_ring1;
> =20
>  	/* 0 =3D highest priority */
>  	switch (queue_priority) {

Thanks for your patch.

But actually, I am kind of annoyed by the constant stream of whitespace
fixing and dead code removal and other trivial changes to this legacy
driver.

It does not improve the code to add two tabs to this _ancient_ code.

And I can already see the next patch coming that removes the dead code
after this FIXME return. And then the next patch will come to remove
this function altogether, and so on and so on.

This driver has a _lot_ of such code, because it is based on reverse
engineered knowledge with many many unknowns.

IMO this just creates additional maintenance work and pressure on our
maintainers for no good reason.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/y4FaB=q8xjAQErvJOYfvURh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmWCsnsACgkQ9TK+HZCN
iw4Obw/8CbjI5T2OUyKj3zauqWP5vWhCTIrGTywS57QuhuSpqOqr8Tg6AGyyMNQO
PUpdDFtUku5QZP/Wpv32SMdS2DX+HL0tStHSFOifCBpeErcryBhh6O0fe9uiY9cU
Pbp4PWbE7wVYRckm6N+swumi6VXS17Sh1695W3WYUwoknGRJJO31bn7q1AS2pwat
vUbKDSXwA0qYSnk6OPyH86V+xPW4FPpNmjMos4H4H5iVob5ACLDdQoPlL+8UCtDX
orc8l50tqiPWxtBHTUh98E0OPLqFIsANfqgNoEmMFEwOQ2+40bttUQ51YnLeW1Xd
dZpZORtqNyiB/GWGXiAnzLB2hBaMhNLokV02lpntqFHykTitdcSZafQRNAHQPhMU
NFucT+Ydg1qr1QCcFmIOhwHsz5rdQ64PKPTM1+ikwz/P4wmMGHE9KZJeOUr/iXbj
FFr75+FzzQCfgziuA9fazuiqyec2rdvJHu83ytcVKhH8/lUv+SQoNmUyIk7aAT1t
WVmD6ipunBLQkZKUa2ZiifvyKkuXmf7K1mmiqPB/rfNjuy1gVuNMvIxhAkZwapoz
7PkUrg6BDeWZsLF9P8AAq9ZbvNvrULE7e3HR2XPHX3vSfkDP7b+ttK3TaUJfS0N+
HRxy1L5xBuMO1krzfl7SFoLy9QiuWYChUqj8eIKx0TC501yHslU=
=wt9n
-----END PGP SIGNATURE-----

--Sig_/y4FaB=q8xjAQErvJOYfvURh--

