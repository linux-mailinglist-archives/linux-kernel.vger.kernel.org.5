Return-Path: <linux-kernel+bounces-72276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2E285B186
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E18F1F21B97
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB66482D0;
	Tue, 20 Feb 2024 03:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZY0niVGy"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09833CF1;
	Tue, 20 Feb 2024 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400364; cv=none; b=h9j1fy+RV+74ayz2YWP5oPXXz8MUNDw5Ovyp98xLR49RM7FQoiBQWTpHzdTLtqfxWONLJNtImA6HhMvJpJVu2j0B5rwG+5caEwtRFAOKNpUnxmLqN10NMNbBLS658Q8PfmBHND2BMoDxe9FzaQ8c2k4jb/lJND+Qb5vWKjluwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400364; c=relaxed/simple;
	bh=7Y2sELjhel+6UxDpWMq0yReaC59tBmcYHAmG1877bbU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=E8ICyvuzEBjtVt+DmMzMm1hfsSHYCjJVLvP71Pb70yUk6REjOPYqczSrDgD9FnPjpVVDjN9/WoOD465zisX/9PxT/tVHia4W6SdvWYklC2Wegfc3xb0Y49OLJIDSp32vHN3XcsVdcAWyU/i5CMWjVonTbeqdA6/ViZWUegBc3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ZY0niVGy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708400360;
	bh=pcOAcbKO6ZfnI423BMyfLs6/TkEfSl8q4nsCTKKF2sk=;
	h=Date:From:To:Cc:Subject:From;
	b=ZY0niVGyjPW6TKiUMTjTm6asv4znW2vuz0lGHcu7cEZWkbYNj3x7QGOXZ+IIwhtul
	 6D+w8H9TFo7q7zjE6XvGAq1nc3pWN0AtNfHpQM+lXaBlWrFA2cZR7U24z3cj39R8K+
	 rzPU4U6QFv9famAKXky293jt3ZKDerlHgYKgFRGx/IfVGICjuN2Z9cV+/3OGE8HvwW
	 4QZOWAOg8Se17tNfIOjvjIP3+u6/IAz1ssY32W4sJRB6JEdPgINAq4/nRYnN5l2zzQ
	 broXmxyuBZS9Bbvm2WKnwuxeUIrj8SV536xL9YlrIjt6GNhzaGTzUB1r+kjm5TYCd8
	 6oM4US9o//DXQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tf4s36R6jz4wc1;
	Tue, 20 Feb 2024 14:39:19 +1100 (AEDT)
Date: Tue, 20 Feb 2024 14:39:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Xu Yang <xu.yang_2@nxp.com>
Subject: linux-next: manual merge of the usb tree with the usb.current tree
Message-ID: <20240220143919.40257e7b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vjSNruKW=5aAeRpaXByyGmo";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/vjSNruKW=5aAeRpaXByyGmo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  drivers/usb/roles/class.c

between commit:

  b787a3e78175 ("usb: roles: don't get/set_role() when usb_role_switch is u=
nregistered")

from the usb.current tree and commit:

  9a270ec7bfb0 ("usb: roles: Link the switch to its connector")

from the usb tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/usb/roles/class.c
index 70165dd86b5d,4ad03c93c17f..000000000000
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@@ -361,8 -379,12 +388,14 @@@ usb_role_switch_register(struct device=20
  		return ERR_PTR(ret);
  	}
 =20
+ 	if (dev_fwnode(&sw->dev)) {
+ 		ret =3D component_add(&sw->dev, &connector_ops);
+ 		if (ret)
+ 			dev_warn(&sw->dev, "failed to add component\n");
+ 	}
+=20
 +	sw->registered =3D true;
 +
  	/* TODO: Symlinks for the host port and the device controller. */
 =20
  	return sw;
@@@ -377,10 -399,11 +410,12 @@@ EXPORT_SYMBOL_GPL(usb_role_switch_regis
   */
  void usb_role_switch_unregister(struct usb_role_switch *sw)
  {
- 	if (!IS_ERR_OR_NULL(sw)) {
- 		sw->registered =3D false;
- 		device_unregister(&sw->dev);
- 	}
+ 	if (IS_ERR_OR_NULL(sw))
+ 		return;
++	sw->registered =3D false;
+ 	if (dev_fwnode(&sw->dev))
+ 		component_del(&sw->dev, &connector_ops);
+ 	device_unregister(&sw->dev);
  }
  EXPORT_SYMBOL_GPL(usb_role_switch_unregister);
 =20

--Sig_/vjSNruKW=5aAeRpaXByyGmo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXUHucACgkQAVBC80lX
0GynJggAgp2c1SBbsndc4wTiwdd2na4docb9SNOcYSCZaHqGzrUtJEVqhvBF0G7M
O11/zmiEjFRFluIRCuFKWvdijXPBTgjHuRf6ulLz7wYNEu/3jUmLN9RH7f30U6EI
HEqEuNF2tsZygAZC0+lVJqDqh0z1EAZnk/i3Bq5NzjmjIt9IXdurpQsyNX4iWpjD
RatLKmYTq7iSQaxQF4Jg1uvqpYUn/GExpah0wXsgWMPcvPI7/T3gsij1LlG5Vg1n
mVV939/96K5ztHkPFHtLOmvILkMJYB2LcAVNwlko3f2Tfx7VUqxu8BlpetAZw28C
Pdpe1KtKTapHMMC+g+3Qmac5cvpqFg==
=dl5s
-----END PGP SIGNATURE-----

--Sig_/vjSNruKW=5aAeRpaXByyGmo--

