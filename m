Return-Path: <linux-kernel+bounces-159434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AB48B2E96
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174B5B227A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4741876;
	Fri, 26 Apr 2024 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FRT4dQh+"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631E16FA8;
	Fri, 26 Apr 2024 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714097440; cv=none; b=H/FfrpX8ejyBG+jmQvw6cnkrKAtS3MEwHpWjHxm5/b+dyLd5rJx0dL1N3aloPuCOO4CudjKLjs700yctjPWV+TRM0uD4J3WDp9WyrHaAw89DCnsBT3T7keqptzg6v2tWYZUwsh3zZga75UKi7uxhUY4x3ph+xJBHPODaFl4oEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714097440; c=relaxed/simple;
	bh=25wLHrnCq4+o10YPKDMt5BUupNlywHRUzqusiwVyA08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KIV/lk7AYKoFVY5Pyn+l4gQVrnT5fl3fTjp+nJ4Z5jf0Yn4PbQMpt9pBwX2LS2FVZ3uC/EO4fqls8gnkR4bPJlkm71MHFfBPjGxWPTJRNxsX8SlUfKQfp4eCJbUXKjWJj4ZFsUtKbK/pe3BFiGQ7mIGJLtpmV9jyTlJgAIYpoGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=FRT4dQh+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714097429;
	bh=1ojHsRPiRsoir+Q24y/ktvG1Mk3MRS2GO165P9N7x8Y=;
	h=Date:From:To:Cc:Subject:From;
	b=FRT4dQh+esGSDeX4HQBZcy8sf1DcR9wTgS+M9YzHA0H3gSIlF0aGr5VI+LxRaCZwc
	 mUPj6ZxwlTAPou1JnofUpDb5AeldQ1Etu17O3TBLPeE/6nYLDb97p3xKOMGTUqmRGa
	 sTurosRmQG733M2gXQgED4UrPVW9LNAbtyZbkZsB4Y+YFqHgXrkmOwo+sGtkFnNbxo
	 6V+G5aFqgE6q2UvABAQW/de+3rWAao83AivEec/KI4eypJ14pPzQulmud1Z7jsbRVt
	 u+yv/X6MRrnLbBRgqOViujI9tMfDtn7WXG9/IvxlaZ2169X1wafOv5YMAeZ7a5C7SA
	 hDYqpYzbvWQdA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQbm43Gzhz4wyQ;
	Fri, 26 Apr 2024 12:10:28 +1000 (AEST)
Date: Fri, 26 Apr 2024 12:10:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@intel.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failures after merge of the drm-misc tree
Message-ID: <20240426121027.2033ddd0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=Ij.CB74ner2v2IZJgS4KBc";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=Ij.CB74ner2v2IZJgS4KBc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next builds (arm
multi_v7_defconfig and x86_64 allmodconfig) failed like this:

(from the arm build)

drivers/gpu/drm/omapdrm/omap_fb.c: In function 'omap_framebuffer_describe':
drivers/gpu/drm/omapdrm/omap_fb.c:325:9: error: implicit declaration of fun=
ction 'seq_printf'; did you mean 'drm_printf'? [-Werror=3Dimplicit-function=
-declaration]
  325 |         seq_printf(m, "fb: %dx%d@%4.4s\n", fb->width, fb->height,
      |         ^~~~~~~~~~
      |         drm_printf

(from the x86_64 build)

drivers/gpu/drm/loongson/lsdc_crtc.c: In function 'lsdc_crtc_late_register':
drivers/gpu/drm/loongson/lsdc_crtc.c:692:9: error: implicit declaration of =
function 'debugfs_create_file'; did you mean 'bus_create_file'? [-Werror=3D=
implicit-function-declaration]
  692 |         debugfs_create_file("ops", 0644, crtc->debugfs_entry, lcrtc,
      |         ^~~~~~~~~~~~~~~~~~~
      |         bus_create_file

Caused by commits

  9e2b84fb6cd7 ("drm/print: drop include seq_file.h")
  33d5ae6cacf4 ("drm/print: drop include debugfs.h and include where needed=
")

I have used the drm-misc tree from next-20240423 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/=Ij.CB74ner2v2IZJgS4KBc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYrDRMACgkQAVBC80lX
0Gxm3wf+PzMwQe47NtzpGc7OV20UnbDTHUsuVa7yxfjlFoBSlXTjPSnUA6a9zmEM
AsjgmuA3Iog1k902zOmLAGzZN928mcTskkkYE3sRRZnJSK4rGOcwrTOZ8/ycq6lD
DqMLIo7SNHaRbaOGVzKhVVVhK6W2mrlohWogu5Ec8goHo1KuIDKESZywaUzmKC8i
vD6JzLAELe8U4NTAormWzo9RFKGItIJ1zks6NkdrTBA8icKkbxOFP+5A2zwnysx/
xr1dQzDX7c76toSQIjfqaY1cEcYCPQMFjcDLVpW7d09DwEEThNp3FLXu1165hh1L
hMEjYQvfxBZbD+AKY6HkanPo1y7tRQ==
=huZo
-----END PGP SIGNATURE-----

--Sig_/=Ij.CB74ner2v2IZJgS4KBc--

