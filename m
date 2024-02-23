Return-Path: <linux-kernel+bounces-77718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB15286096D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D401F25889
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3360DF4A;
	Fri, 23 Feb 2024 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZMOtw45n"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE06B67F;
	Fri, 23 Feb 2024 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659195; cv=none; b=mKB5EjrpYGNunUD8HhpobvXkBo7I+lJlqB7uGckSDSIjJJEQ0neRZBAEn/v+nJxv2VU4hs0lYbYbJsYxkAXK54Ni5yWLAVNEr6deKgQ8lggc3MOIFmDR4zJochsbss/4nOs4KahHCXFcKweKmcg/Py34qn2Whw7kg+o0dbtefSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659195; c=relaxed/simple;
	bh=tWAGTc1sj+bW1+gUOMYV4gIl1YOcRggBiI0zrK948KI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=iDEzzaFnqDXyORQqwaxt6Rv20FAQTqInp9onIM458NbYXg5clraPLT4V47aGbaTgdJBxOndVT7C9ju5MLsl7z373YMfDt4PYSscLmZgdUsIyNnjBnMXAW1X297Uu6FSNRAv3HW6Vb6vQS7s55aDV3Y/wEIeMqmm4zMBhsgerTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ZMOtw45n; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708659190;
	bh=KP/g7IExG+k7npC9abXBrLdnTrONXf2kd6NHpXGDeIk=;
	h=Date:From:To:Cc:Subject:From;
	b=ZMOtw45nuKFODK9Z4xgCY6GB3xtHBia3yl6zx22YyIlNsVjok8bJh2e1t4CdrzJF5
	 I/40wAAt4oty//Lh03SDsPHTpV3YDhuqvFu+yJNEkOCT1w9UFVKlhnFVoYORTIBWvk
	 /MRn/CllZnPr1BQRoNJW+RblNzJSxTlWjM9MsIHJ6AX51AoYtUf0SjzGkPp1bscKKF
	 mHtQuBQDNHJFONYn7j46BbDVbeaCrvQ7EHZ0fJihm0MKy4a5ds/6toqtvGURwdxnRG
	 rYStWz9yLiTU0qOAbIJOESumfmLmH0++dFjHdEMjBgntAXWkgtjSDXxT9jc7489HEW
	 zbk7p5TBTGIBA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgwZZ47RNz4wcR;
	Fri, 23 Feb 2024 14:33:10 +1100 (AEDT)
Date: Fri, 23 Feb 2024 14:33:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the gpio-brgl tree
Message-ID: <20240223143309.5ec298ec@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LkkLNsTm9d9nf/G44sbL.jR";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/LkkLNsTm9d9nf/G44sbL.jR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the gpio-brgl tree, today's linux-next build (x86_64
allmodconfig) failed like this:

x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_write64':
gpio-mmio.c:(.text+0x1489427): undefined reference to `iowrite64'
x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_read64':
gpio-mmio.c:(.text+0x14894a0): undefined reference to `ioread64'
x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_write64be':
gpio-mmio.c:(.text+0x1489527): undefined reference to `iowrite64be'
x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_read64be':
gpio-mmio.c:(.text+0x14895a0): undefined reference to `ioread64be'

Caused by commit

  36e44186e0ba ("gpio: mmio: Support 64-bit BE access")

I have used the gpio-brgl from next-20240222 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/LkkLNsTm9d9nf/G44sbL.jR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXYEfUACgkQAVBC80lX
0GwTxgf+Nuao5gGjnI8ON0FpdBxPtzJ88ezlJiWLmSMopEQoQWIUpZvtxTMuk2kK
kLTcDbQVWyUXU52bxC/28RwWUP9MGl2Obtf8hdMGapaPqV4OeVvHAZUclEGt3GDg
7iC8dDlsWFarsATu9ufbky21rN3KbBQbEF+mepTnPnh10ZOAeEasmcxuLtR6/SLf
pbJpVHvOtfwX54HmIt96E640xoKUCnEusLgOjS9/dqjEHHUUxmxMF9dO0xUVtL6Y
R2AJCojKJPhZXDHIjvwVe8ejq9sXQbk9DgBClb+B0mE0hX3y9Ov59DIw/8azrEVQ
DCDXHTulV/K4hkmrgMaGbAnOM2GVVQ==
=h4mh
-----END PGP SIGNATURE-----

--Sig_/LkkLNsTm9d9nf/G44sbL.jR--

