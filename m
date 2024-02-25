Return-Path: <linux-kernel+bounces-80318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E03EB862D4F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A11FB20E00
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6861B96E;
	Sun, 25 Feb 2024 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cvKnt5wQ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE618EA2;
	Sun, 25 Feb 2024 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708898666; cv=none; b=uk4h+jcn2vAggF1phIpblZkheAQHUy5KlUnx2hL96b071DnK2+hMsQB22XLO4iqb7P9Uvt+k/8ENUCQ9v9fwAr9CgPtcFVZExqZJRAsA7SLom1VjPsnb6SzvumJzNbAtR7J6BVJbJYlZyxwbi06CbFyC7S5NarHRDc8eM9cCs2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708898666; c=relaxed/simple;
	bh=jMSB9n5rNOnYKK+WQa5X9u1cXO2yqWDIBliiljSKQS0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=genDPddJprkWLN9cOLKco2OOIgNcCSg3eAXA6PAY3qsi1STQgay5g0OHwnmgA+kpStttND99RzEpQeUEwqOn5NfkMZ2xrOlfSstLEnVapbK+P0eSMU2/Do70P/ARxkrJUMUhhuJx96Z7I+V5B9+D4QFtHgeUVC1wafaUAlIC4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=cvKnt5wQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708898659;
	bh=ws54nDW9nBKD3dTHZg5N8Q01mibm+V4MiaOOYBRnt9Q=;
	h=Date:From:To:Cc:Subject:From;
	b=cvKnt5wQ2FWyJEhqMs05SnFWR7V54KHYDvxQDAtFkf1YdObaWDpg7U+mB83FSOVN9
	 sg8poXXL6ratsa7VH2mfZOrYher4eLUrhwCW9tqt68wssKxmpjr2QF6n/fBNCCpokD
	 d/uKP+qcBDHZJV9f1ATyZU/4Ljd6ubghjlupDtxm0+A+ikYJezMkhUdqQp9P78o4ct
	 ok3h5mzmbuE1WZ6uKr3LKVC+mwyoPLfH+3PDa2PR3daChWUWLaO31pKGz60HjO7J8n
	 NVqRmcYgmxEbbfQxhlQKDuoUD6GrdusNXVnoYCVK4nKjoGRnmrp/dE4GHpWefG05k+
	 OVn8ZzC0+QoLQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tjd7k6mYnz4wcN;
	Mon, 26 Feb 2024 09:04:18 +1100 (AEDT)
Date: Mon, 26 Feb 2024 09:04:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the cxl-fixes tree with Linus' tree
Message-ID: <20240226090417.65ba3c4b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_zV/7yWXYQCfVMrnrilPOhr";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/_zV/7yWXYQCfVMrnrilPOhr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cxl-fixes tree got a conflict in:

  drivers/cxl/acpi.c

between commit:

  5c6224bfabbf ("cxl/acpi: Fix load failures due to single window creation =
failure")

from Linus' tree and commit:

  5141fa1ec23f ("cxl/acpi: Fix load failures due to single window creation =
failure")

from the cxl-fixes tree.

I fixed it up (I just used the version from Linus' tree) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/_zV/7yWXYQCfVMrnrilPOhr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXbuWEACgkQAVBC80lX
0GxdtAf/YV4AiLZWVUTO6vn3B+f4CsEMcGUnTCUcc1rb3tYhpklkCdy1NdtL3H9r
Snk9mWt88B7e9diCsh7W4sgsnFqKV56K69oElv8zaTXM9kfZaT+hA7ig06Be3Bwv
0saz9a+igXV+Hm0KSbck8flsuTHf78wtOQ9td8y9qNyCjynrdx71r1MVtxp+lbQO
9D1hMw7XnQshX/ILLN6I0oFb4kHKQq3zhsTGaQbd34nw0VDjDVPqcxeK8RyrxtK7
bMNp9lQYEwDKXU+ZTS+7W5x60OUpmoD4ScMg3FkzN1+44db5E1x6zWgi/ADb0ooZ
K2JnMju6kiz9qLg1bEDo8M97OjtTEg==
=IIgF
-----END PGP SIGNATURE-----

--Sig_/_zV/7yWXYQCfVMrnrilPOhr--

