Return-Path: <linux-kernel+bounces-139733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D88A06F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D95285F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2706C13BC0F;
	Thu, 11 Apr 2024 03:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rR89jJi+"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D2513BAF6;
	Thu, 11 Apr 2024 03:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712807866; cv=none; b=Itc1Ok18by/jyAVn1Pp/+hmTIIOHJFMHt7jPPAxBFhr4e6O9XZ4fcDfnWQpNqC/74bKEUQkOaJvGVZWiaGxZeql7wsBQM+Zng43gRCs2uiH1E54aW3+dDkT9UI7YCh8Jlyp/QMbUsJcNBY4bw73BianWak+QTgNZHdLUgISal8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712807866; c=relaxed/simple;
	bh=8Mb6POUwv9w7aVdlQwqiua0jQekhZyZpeL5O1GgkLZc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=guPaywmtcI3MeMkk33DgEMx79UoBlhRmebHpLu3jVOBIUIbxImszT07dTg/9vXRy9bfE13sVH3nbhGoySSI8+0c6/CegWZwGU9nVAIAUjQeb+Qk/7faThBHK8GLxrTvJS4fODatbpS88oUBZ4lNVjlo8vSufWWMwl+lrtpIyDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rR89jJi+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712807857;
	bh=lPDwBKRCubIX0F6/ZowgP9Duhxz7KKg+aC1/9vnrLrE=;
	h=Date:From:To:Cc:Subject:From;
	b=rR89jJi+FFG7lWdPTnIvxvI9Xm085OEqRoA+Ya5oE7Nt5iYcYrog4sN7J/MkxeS/y
	 2nGgjS0CaZ4lFabM90p1PVzZ5a71CbAbXiiKft+Kv3yOYmFntdmnsbZj1hmgOHQkBd
	 SB30xWSlfMtXKm462I+jpWjLZLKIJFtu41xD6c1cbjYwqm0yOpaV3TI+QFmmpKRIrb
	 pjjMAKU0lNonPLcTLh79vKPAhLn2HZHpPtVtRLP7ABqgZN64Psc0/UHle91/x+5Swr
	 QmjalxEvNAVt/tGsDaaa+5OasHDoNGM2kIrn5ULp4AsLbFWL+bywwJfwQzQG9XxRDG
	 WJ6gnOd9lRtkw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFQrc483tz4wqM;
	Thu, 11 Apr 2024 13:57:36 +1000 (AEST)
Date: Thu, 11 Apr 2024 13:57:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tty tree with the tty.current tree
Message-ID: <20240411135735.58de7090@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KBcu2OnPzWfoG+guo3smTg.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/KBcu2OnPzWfoG+guo3smTg.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tty tree got a conflict in:

  drivers/tty/serial/serial_core.c

between commit:

  9cf7ea2eeb74 ("serial: core: Clearing the circular buffer before NULLifyi=
ng it")

from the tty.current tree and commit:

  1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")

from the tty tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/tty/serial/serial_core.c
index 2247efe97250,a78ded8c60b5..000000000000
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@@ -1788,9 -1773,9 +1773,10 @@@ static void uart_tty_port_shutdown(stru
  	 * Free the transmit buffer.
  	 */
  	uart_port_lock_irq(uport);
 +	uart_circ_clear(&state->xmit);
- 	buf =3D state->xmit.buf;
- 	state->xmit.buf =3D NULL;
+ 	buf =3D port->xmit_buf;
+ 	port->xmit_buf =3D NULL;
+ 	INIT_KFIFO(port->xmit_fifo);
  	uart_port_unlock_irq(uport);
 =20
  	free_page((unsigned long)buf);

--Sig_/KBcu2OnPzWfoG+guo3smTg.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXX68ACgkQAVBC80lX
0Gw33Qf9GVGrFAJTvDWhp1iY7lUIi8ItgiP23HhhrEktUeWw6KxFsmZdXDElZu+J
VprYg+B4FYl/iQmtvIF5dZP/9f/4QeGNwGoVpDGWXzYr5OOjZwQ/vjINgASSmuyw
GIzK2vHvg2d/FAS+FsG4ATEXbL1TH3DH89y3QEnNtrJj8oX+rmAYae/etvjjrYo4
ZxkFy6df/sQG9wLwuIHFHnImiriMZCLvXTHa+8g7ZEvcx3Fs72aya6JqzGWp8uCT
GuRhT6wf8JQFIDTYWlO12YTP6mqbxVWwVzZb/NYVD8LIydt42gpPbSTnQDjwLKpU
iGzi2bbZRGF7qdndNz7qmB2l7PVcwg==
=SwEf
-----END PGP SIGNATURE-----

--Sig_/KBcu2OnPzWfoG+guo3smTg.--

