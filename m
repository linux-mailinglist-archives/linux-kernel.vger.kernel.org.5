Return-Path: <linux-kernel+bounces-70734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890FC859BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404EC1F2236C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9C5200BE;
	Mon, 19 Feb 2024 05:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pljFNpgM"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D561CF81;
	Mon, 19 Feb 2024 05:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708320069; cv=none; b=dEwwjG4MWuRJnX/pa41FQPEpl4JpfIL387B8HZPedkFozHhPVtzYLTi8YGhutNg1sPJol1XaX0iMnXkC4dJUz/3BAj/3DKqWRnOQt6GBWkPulriWrMyyOA2rhSh+ouKHtLxEZjflMXIWqKZdAH/GAHaeL5Yaw58HjXSEVjMj+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708320069; c=relaxed/simple;
	bh=v6rgCR5FUDWrDZQzDM6cxs71HwlhdWum72ccKXMLvmU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FOfewOzW9+7YYKJwtPKLMMCCikzWsoA54zWUWcqb5Gkcif2GzWrOw9GzTy9FiEBiNo1dozdkKkr1u3QeVRSBfjesS1UXKh9Sp1/LOS2aEFgzeNQuw95d+aBWSYS+I0dL+/CEltFIFzNKcaSnmwje+fpL5PN7oH3fB/bLtcP4nuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pljFNpgM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708320065;
	bh=hEt04/AGgzHfD+OrrEUUfWR48HIiav/LUTl3/xa9n2A=;
	h=Date:From:To:Cc:Subject:From;
	b=pljFNpgMtV+I9v7Jb5MTM0XeS9Evqpp2kL/IULJ8FBAiglQBbD5R1bFaBlHP0UZas
	 81OcQMTEy4zB5U6G0dwyWsjPxbV/W0qa082GU6p72pDx5XNXztNSr/2+nNzUuf5azP
	 aKq3+AaV6Tn3QqwDfk10hTJ7aTu0gZIVr6gCsJra9PD2/l5mhMSgrcbHtdtc0Y5thg
	 O6Z7X3nnXPZLxeDHNWtSSlYmMf1zLlDM5DZhDhjvJfY1nLl0XloASjes0VKWBnME8u
	 I9gYK87BBf8MC4WHfgTHQp/dLswcSfb1HMcL1Er+5/nky942NdLdmwqXYMfWpemjLp
	 zKonUi6Asn8Jg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TdW8x4LNHz4wxX;
	Mon, 19 Feb 2024 16:21:05 +1100 (AEDT)
Date: Mon, 19 Feb 2024 16:21:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@redhat.com>
Cc: =?UTF-8?B?Sm9zw6k=?= Roberto de Souza <jose.souza@intel.com>, Tvrtko
 Ursulin <tvrtko.ursulin@intel.com>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the drm tree
Message-ID: <20240219162104.2843ada2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MaLoh=z.sCLpfxsbm+jRki6";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/MaLoh=z.sCLpfxsbm+jRki6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (htmldocs) produced
these warnings:

include/uapi/drm/i915_drm.h:3579: warning: Function parameter or struct mem=
ber 'branch' not described in 'drm_i915_query_guc_submission_version'
include/uapi/drm/i915_drm.h:3579: warning: Function parameter or struct mem=
ber 'major' not described in 'drm_i915_query_guc_submission_version'
include/uapi/drm/i915_drm.h:3579: warning: Function parameter or struct mem=
ber 'minor' not described in 'drm_i915_query_guc_submission_version'
include/uapi/drm/i915_drm.h:3579: warning: Function parameter or struct mem=
ber 'patch' not described in 'drm_i915_query_guc_submission_version'

Introduced by commit

  b11236486749 ("drm/i915: Add GuC submission interface version query")

--=20
Cheers,
Stephen Rothwell

--Sig_/MaLoh=z.sCLpfxsbm+jRki6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXS5UAACgkQAVBC80lX
0GzO7AgAh5fGgDN0GGr12V5wLM+o7TyWaLvajulU+jT9kdGhJluiag8ubMpCo160
Q7cX6kNVi6IdAw1AJs9PYbxMg/UHKm4P+5sJNArei8lzUNBD6PvudraZDGFIgtli
6MgetDGkdbuYB7j/CuyG7KfMeBnIMbncTK5n3SQgPyX/aCXlA2bmLEPpk2poGhuT
KWeNv7DoEJwWc+A32AdG+AJvmC9S3AolykBhuBFgymHWAxb9UpdM8TzK4pYE3p4W
/X13PjlcJfplMq/SEObBhmTZoRenUc4yuh96dJHjp/RxPz1jHn4y0f+AlZWS3/jA
PDMFPwAmwboaAwCzhAC3/smXuMEgfg==
=2cZx
-----END PGP SIGNATURE-----

--Sig_/MaLoh=z.sCLpfxsbm+jRki6--

