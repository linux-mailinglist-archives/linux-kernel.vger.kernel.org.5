Return-Path: <linux-kernel+bounces-31988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EED58354F5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587861C21B2D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28C4364B2;
	Sun, 21 Jan 2024 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DzKYx/4F"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1669440;
	Sun, 21 Jan 2024 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705827951; cv=none; b=o8TRkOxXKPrzpsA/Z5sJ5KLwVOvMbENfjJvtryGP+FxRyN4T3LejdvzcFB1XOEhOqj8bEUVY4FNKJRWHkbvp8PUPgKgD5Ab1NKJdgUhvuorRJzVYx4p1PMmqYWTXN+1JlSZ8lZ680G6lCmZx0iGP9/RRkG59PEWnSnGbyrSnquU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705827951; c=relaxed/simple;
	bh=MKbjpU5sdimsSX7l8u2+E04IUn/Zu/+4WtarE3L5uMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hxYIZ59RlKvIX7i1S1l1p93YW/DwtJ6OOT2yDmtjO682vnjhkDbqy3J/7BE1SH/Wf+fMayTct9h7ZqstfS5S0Nza0LLPU5mlDh1xEWGoR4Wvco16Gt14p4xvTNEzC72pqGjseDZJy8NK/6zhdWeRe9dbgkUCzVVvxW7HQB7HXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=DzKYx/4F; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705827936;
	bh=5O6w/kHSzX9h+rnJrUFkMpN+hbu+Qv+XTF96t46hVUA=;
	h=Date:From:To:Cc:Subject:From;
	b=DzKYx/4FYXmn3E/yH6dj1a9DVoOaInZ2EvFbfq2030s/MOPibRmcG3zx0CHMOTJ6i
	 ojnqaBo38XqgR5pQN9n9VZNpwu1dd98hZc/rbOUTe/yEn5cub7Sh+scMCP/iA7TxZ+
	 hvgCIt/19GXxzi68KlkKgevGhqU4GMQRKMweSxC1AYyBAakCOE2eHQJGZ25kDQIxNO
	 WKXwLYCKiUU8uZugmMR4OyhYPF7hEPnJ9fgyc30heaDkySNQD2tlyo/ybJI1jN4hJX
	 4OiURIWB3bdgZ4MimUP5F/3ehjWtO7Ciq1G8uW8XIWo3y3DSD+/zjLoI3vAUn9knM0
	 QG6cT3Vl45mwg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4THnWN43hVz4wd5;
	Sun, 21 Jan 2024 20:05:35 +1100 (AEDT)
Date: Sun, 21 Jan 2024 20:05:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the i2c tree
Message-ID: <20240121200534.57bf614a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I/y17/T1OdxUPOoPS6dCHwv";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/I/y17/T1OdxUPOoPS6dCHwv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  04b5f2a48c08 ("i2c: npcm7xx: move to per-adapter debugfs directory")
  0f63441c8232 ("i2c: stm32f7: add support for stm32mp25 soc")
  15733cb95968 ("i2c: wmt: Reduce redundant: REG_CR setting")
  19e8abc96017 ("i2c: rcar: add FastMode+ support for Gen4")
  22c2e038fe7b ("i2c: i801: Add lis3lv02d for Dell Precision 3540")
  26e1e55cd48a ("i2c: s3c24xx: fix transferring more than one message in po=
lling mode")
  30e88a5fe3f3 ("drm: remove I2C_CLASS_DDC support")
  3194cc4a8949 ("i2c: mux: reg: Remove class-based device auto-detection su=
pport")
  354d55c50bd9 ("i2c: wmt: Reduce redundant: clock mode setting")
  3d59a5a02faf ("i2c: cpm: Remove linux,i2c-index conversion from be32")
  4636ca7c80f6 ("i2c: stm32f7: perform I2C_ISR read once at beginning of ev=
ent isr")
  536e5b9fd01a ("i2c: s3c24xx: add support for atomic transfers")
  6564042143c2 ("i2c: wmt: Reduce redundant: function parameter")
  733023103014 ("drm/amd/pm: Remove I2C_CLASS_SPD support")
  745b8104d2b1 ("i2c: Don't let i2c adapters declare I2C_CLASS_SPD support =
if they support I2C_CLASS_HWMON")
  7abf391269c3 ("i2c: rcar: introduce Gen4 devices")
  7d1e62185178 ("i2c: create debugfs entry per adapter")
  8a7482ee98fc ("i2c: s3c24xx: fix read transfers in polling mode")
  8e7265a61975 ("i2c: smbus: Support up to 8 SPD EEPROMs")
  963baaf5c36f ("i2c: make i2c_bus_type const")
  9a0517a25901 ("i2c: stm32f7: use dev_err_probe upon calls of devm_request=
_irq")
  9ba62215e9fc ("media: netup_unidvb: Don't let i2c adapters declare I2C_CL=
ASS_SPD support if they support I2C_CLASS_HWMON")
  a06f7ca66be6 ("i2c: gpio: move to per-adapter debugfs directory")
  a160ebf13bd4 ("i2c: rk3x: Adjust mask/value offset for i2c2 on rv1126")
  a76cf6fe8a36 ("MAINTAINERS: use proper email for my I2C work")
  aad422172b5f ("i2c: stm32f7: simplify status messages in case of errors")
  abe8bfbf44be ("i2c: stm32f7: perform most of irq job in threaded handler")
  af1d2beda215 ("i2c: wmt: Reduce redundant: bus busy check")
  b4f007117170 ("include/linux/i2c.h: remove I2C_CLASS_DDC support")
  c62966b1824a ("i2c: wmt: Reduce redundant: wait event complete")
  c692086d74a0 ("dt-bindings: at24: add ROHM BR24G04")
  dc3293b460db ("i2c: i801: Add lis3lv02d for Dell XPS 15 7590")
  dd69df0b5f5a ("dt-bindings: i2c: document st,stm32mp25-i2c compatible")
  e8e745dde833 ("i2c: imx: Make SDA actually optional for bus recovering")
  ec74a1dfcdd1 ("eeprom: at24: use of_match_ptr()")
  ef2984d633ce ("fbdev: remove I2C_CLASS_DDC support")
  f65b8f0c1650 ("staging: greybus: Don't let i2c adapters declare I2C_CLASS=
_SPD support if they support I2C_CLASS_HWMON")
  f8fa303e6824 ("i2c: stub: Don't let i2c adapters declare I2C_CLASS_SPD su=
pport if they support I2C_CLASS_HWMON")

--=20
Cheers,
Stephen Rothwell

--Sig_/I/y17/T1OdxUPOoPS6dCHwv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWs3l4ACgkQAVBC80lX
0GzL+wf/WQOpwGCIi/vp0tyDXV9INxBAmfvQYWjmV06XD1tNLx9JfOO/wIRh385I
pA+NelWWuhzIj2/SEBZUErNFGwK9ox18vlzpozqrvgl0II3wpVMK0husfTKr5roD
l2gMF3lfqkbRV120STdo1syCnR89s5+ubs0uH+LT6zOGG82UQ+8OAr5bB/n2OgM5
sN+blsLiJfJ05CFSiVmpiIaMtnbDsKCNfIKjehpPfSW0hMvPFysDhXhhxxSmSJvc
ijXsZRFraDmgV9ZN+oTyjhjucpXkCXS/fJUMlUX5bQQO/VXig22GX2ORP3YQ78aj
Dxuvihfmxaix6qM61n/39VchyRghlQ==
=BgTK
-----END PGP SIGNATURE-----

--Sig_/I/y17/T1OdxUPOoPS6dCHwv--

