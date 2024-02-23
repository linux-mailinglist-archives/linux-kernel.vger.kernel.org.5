Return-Path: <linux-kernel+bounces-77697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED16860921
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3A81F24C13
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BBFC2C4;
	Fri, 23 Feb 2024 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IGVhEWfj"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B08BE66;
	Fri, 23 Feb 2024 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657416; cv=none; b=AtUn0NwtWkImqZanzsXbw9c5jZXN3kQbKzB78SMXxYkVs3cX/xeafxP8s1LgWzBw+HXaclMJgSZhovRRKuEiO+FFpAOdEq7BZWtDsDtu2Lz5TeVW5ipQl1/4BeBkc6PRaflcpGo7BCV/t/D6ANMwGw3yfTeBqwz9IZUkQQ4rKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657416; c=relaxed/simple;
	bh=+u2q9LTg8q2yQwkOYebvqRkTz5ifi/E94qTDt8gE0js=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lSRi0vzrfYHasRRI/19iA991QO3ZzVRkVThAe45RYvtx/ChOY7rtM533OA3XKXe5/rNLWwhvoX6KaDwWz1wS1E0wXV7yJ9Q/46Lnq6LtBtVuNcwnP9UXwx53b0RkVK4w/s1c0u1HYnNWuFKDShUSYAIff/Y9gN6ksq/I/drS/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IGVhEWfj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708657410;
	bh=aHXZ7hyWfBWjkcFvg5uVCooNUuzR8bqzQTO/wjmanjc=;
	h=Date:From:To:Cc:Subject:From;
	b=IGVhEWfjPc30DoWk5F5+009u7bo2c7A/LNkMuiQZi8DYWhr0RhakiXleTGbVYjmEe
	 Vz5fZCGT0N9/CKQk2/RC8G+OfS79F138NBMnAOGLUGR/E0ddOubiTmGgjhIaTMvgqI
	 3CIWFVxbC47BHC90qzX1ds08HYbEgxnB6uqW/yLPxeeq1sedtyNR5Tb0PCEHIBgsO2
	 873jouXPbagXWSKujQsx70i46Es3JreQIiMfp/v0O0jvuEqEDl4Edo5pXrjGQbKIwA
	 6s4vxbgT+boXCvPVnYaNiJH/gVCvbCrlKTPE7VxNsdShWJgtQim9C0Df1moLV5LCWd
	 1YBsoS8mzOVTQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgvwJ1jlSz4wc4;
	Fri, 23 Feb 2024 14:03:28 +1100 (AEDT)
Date: Fri, 23 Feb 2024 14:03:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Williamson <alex.williamson@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfio tree with the jc_docs tree
Message-ID: <20240223140325.345a9cdb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S2./Dz8CBO1pnuco5fTUJrJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/S2./Dz8CBO1pnuco5fTUJrJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfio tree got a conflict in:

  MAINTAINERS

between commit:

  27103dddc2da ("Documentation: update mailing list addresses")

from the jc_docs tree and commit:

  05f3a0bd094c ("MAINTAINERS: Re-alphabetize VFIO")

from the vfio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 818041f70659,7625911ec2f1..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -23241,6 -23118,13 +23240,13 @@@ L:	kvm@vger.kernel.or
  S:	Maintained
  F:	drivers/vfio/platform/
 =20
+ VFIO VIRTIO PCI DRIVER
+ M:	Yishai Hadas <yishaih@nvidia.com>
+ L:	kvm@vger.kernel.org
 -L:	virtualization@lists.linux-foundation.org
++L:	virtualization@lists.linux.dev
+ S:	Maintained
+ F:	drivers/vfio/pci/virtio
+=20
  VGA_SWITCHEROO
  R:	Lukas Wunner <lukas@wunner.de>
  S:	Maintained

--Sig_/S2./Dz8CBO1pnuco5fTUJrJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXYCv0ACgkQAVBC80lX
0GxtBwf+JFBx8yU68PKvfvb4Zp9ChPWvTf1/ipyKhGGNRtGV/0WxoY1Ol8De2B2+
OCCu4fUQZsjLxWqKVFwqtS0gS8/0SXXT6mbZ7Q1BSmMtVCpm13cTb69POxXp3OLD
tIbBMRo8nbHCicReAqhvpXYow/U6HOHxW5SFSl0XutYplgknIeMjppg2N/MeSJb/
5M4x+b+N5R8kRHDdUJeNwscAoaHnKsvPPTmGNL86OILbuoVY1CkPjPutRlTLBen+
+YTVtgmfy4vrvJqnDtvbgyahStW7nsdJifAWVG4nfXKbcsoYpb5O6Vdzk44lYNXb
nr34rIw76wra5V8QhwSoBWSu+kVC8w==
=ed1Q
-----END PGP SIGNATURE-----

--Sig_/S2./Dz8CBO1pnuco5fTUJrJ--

