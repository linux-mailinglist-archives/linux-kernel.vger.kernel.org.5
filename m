Return-Path: <linux-kernel+bounces-137804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDBA89E7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8E81F22DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20134C6B;
	Wed, 10 Apr 2024 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j9Wil4H9"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B11FAA;
	Wed, 10 Apr 2024 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712713046; cv=none; b=inzrepvl6gUJ/4fx0nAVj7EBGIzohaAYNE9QM+MFCSF8pKHx+jDafxXxCxFYpt3njuRxbp7QBzF6mS++RIjXY0I03B8Hfw/gDrkiTRcTWgQ8VkmFfRW9hA0RUKs8widlKISL9NlZlkTuQFz1eusmVa6p6OBBRUtCgEFfalSxbj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712713046; c=relaxed/simple;
	bh=109X4ODkF1551qkhBxOoPEwPnuqiPXourDQ5O4+ZumM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tNYTDic9b0YeNBH2rx3BBwpbJzL/6exfmrn7hA1GDyWvRjPaw3Izcj35evce+FoXUeH4KHO1GWjQvsPlNuilbpulPk+g9phpeGHQZkAP/RFWx1bHvluNqADFKWluB0CskeQts+Pa03TMyC3pHmZFT7blwUpwUZG9f4aEwbSnxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=j9Wil4H9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712713039;
	bh=GI7EAQKn4mkpeL+X3OogK5qZCQ71oAAkd8XB13Tuen0=;
	h=Date:From:To:Cc:Subject:From;
	b=j9Wil4H9LNL8UJyr3T63NHluVVfTiqoN8de1yTiku4zP7ftlb5hkKE/J2CEQXRIDb
	 vqNtG4VGKwFwBl8A+QrGqUbdvHJFB0g9bOn9+JDNPXFi+XZwuOFiqHljSc57WR415y
	 72eTN1RAPcGiwQ3wgsiHTq3Gvbf1lsl2s5bdsv9KS2ipTUxDkwlM5b9l/+QC0GGslj
	 tG766qd9LPeT+Rw1XAU23sH7QOEZSWMpdOIFpH9w+etz5qyu+98dIp9XXv4P45Yh8H
	 eVPSgo6qjyqM0Ixk0Lp186egmQGJ8lJcF+tFJzgQAIwY0r3E1BCkFHk0rsaiubwpQc
	 XNWJ3HOCoYqoA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VDlnB5KPLz4wcn;
	Wed, 10 Apr 2024 11:37:18 +1000 (AEST)
Date: Wed, 10 Apr 2024 11:37:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lucas De Marchi <lucas.demarchi@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: DRM XE List <intel-xe@lists.freedesktop.org>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm-xe tree with the drm-intel tree
Message-ID: <20240410113714.10cf2daf@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_tLqiJw.fJVFx5Ol4OO8Ixk";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/_tLqiJw.fJVFx5Ol4OO8Ixk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-xe tree got a conflict in:

  drivers/gpu/drm/xe/xe_device_types.h

between commits:

  ded402c7a044 ("drm/i915: move skl_preferred_vco_freq to display substruct=
")
  8219ab6d6f0d ("drm/i915: move max_dotclk_freq to display substruct")
  9aad73290686 ("drm/i915: move display_irqs_enabled to display substruct")
  f25ae90ff9c6 ("drm/i915: move de_irq_mask to display substruct")
  860cefce5ebe ("drm/i915: move pipestat_irq_mask to display substruct")

from the drm-intel tree and commit:

  070f8fd6c654 ("drm/xe: remove unused struct xe_device members")

from the drm-xe tree.

I fixed it up (I used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/_tLqiJw.fJVFx5Ol4OO8Ixk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYV7UoACgkQAVBC80lX
0GwV7ggAkFJQho0n2tfMCEk3bAN32r3eqfGbV7AnV1JLHHSqh3S8+zWIFQRuS8Y5
lGr1IuQSux5N6uc4lvj6P66m/4Rh7tZLd6acSKi95wal5f7vT3juIrW2hlRWoZsN
VfhIwYsYF1xR25p8mxYo9vboVqOypaQGl46pudHYUZZHcJ/6YEDPF9BR1nSTon7g
zmSPYr2mwICy8DjStGEUHJukOlPY26kE/vvoH9qQgplQ+YVTL3THdoTHCuLsc7+F
/OWnMqfofImsDvwTQZTvtNpkc6cPWH0l/IzQdCgtSw8heJTakv42VKYPu2+kljft
a4F4NQdL+iJtGnWjcE29C8tk19DleQ==
=a8Jn
-----END PGP SIGNATURE-----

--Sig_/_tLqiJw.fJVFx5Ol4OO8Ixk--

