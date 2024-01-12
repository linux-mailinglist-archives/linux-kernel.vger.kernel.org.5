Return-Path: <linux-kernel+bounces-24273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7F382BA1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2A01F25F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0091E1B284;
	Fri, 12 Jan 2024 03:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l/og3Mku"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC151A73C;
	Fri, 12 Jan 2024 03:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705031328;
	bh=vOyFXKkwchtgJ0ImOnmWdboCyhvPRseqpjfIMKUiPtM=;
	h=Date:From:To:Cc:Subject:From;
	b=l/og3MkuZ7cHzp5MjaSifoHebyZWPBMx4w5b+cMppz9W4lTmL/jQvdfnVEEH9khfb
	 dM9iI+fl48GWvHKGHYdkJQ8YPV3tQO77ur2ao9m7XI6UZTNLGMCyFL8MhXGyg8HFDB
	 Y5MbPP0xY3ci0Ml4Vo37OugCX+TybWY9GrBhoyF7LKEJoc+4HwJvx8O2gkUGXkyKj5
	 JXTEFXN9R9vOLrK0gPLXZ1NptcD/4SsR+2SPRD67oxY8P9kC0EZyPxUSgPggnMlnYT
	 eK7FtWqAaf4mkMUtBUCb3RabxzF7cX0q/mPk/yYxi6kPlITYQBZ4YhFt14wWfDfxOV
	 eLPlvKSAsawfQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TB6w057fPz4wnv;
	Fri, 12 Jan 2024 14:48:48 +1100 (AEDT)
Date: Fri, 12 Jan 2024 14:48:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tags needs some work in the mm-unstable branch of
 the mm tree
Message-ID: <20240112144846.7d619a45@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MpnNr3EeXGFl/OcyGbL45S9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/MpnNr3EeXGFl/OcyGbL45S9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e8ff43feb436 ("mm: vmalloc: Fix a warning in the crash_save_vmcoreinfo_in=
it()")

Fixes tag

  Fixes: 9bdb180b2d ("mm/vmalloc: remove vmap_area_list")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

In commit

  49d7473a6c07 ("mm: vmalloc: mark vmap_init_free_space() with __init tag")

Fixes tag

  Fixes: 86817057732 ("mm: vmalloc: remove global vmap_area_root rb-tree")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/MpnNr3EeXGFl/OcyGbL45S9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWgtp4ACgkQAVBC80lX
0GyKmAf/bRZAsaglOYAzRSt63DjfXHopB00T8GJA179Eoe6fsSA03oD1yEJ3Nynv
pkkyeGIZClsmL83woJill1fkKDcm7dAL4KprcpMteRPIZQ1d/e1RqJL6euqbLBvS
wKGOdEw6XKTe3FxucOOwko+RBcvdiKoDZgNmfO8n2B1xTnTnUvRfmXUm18XSVRPO
rHA1x/o3BEVzEPedSLzI9iKXYqfLK3LCFepT3c8UL4swpeXug8833o1CeYb7qmum
qkp+ksBMVy0SwMyPj9BXBLthBoP4zsm3GXfOH/SQ43khqRYure13BEXdltfSf6j4
lFwkqWLIYEF0L6sbq/vmrpWwjo6xOA==
=T1xf
-----END PGP SIGNATURE-----

--Sig_/MpnNr3EeXGFl/OcyGbL45S9--

