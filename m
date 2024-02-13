Return-Path: <linux-kernel+bounces-62924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 242CD8527E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBDC1C22F65
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C466DA947;
	Tue, 13 Feb 2024 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NeOlSrkf"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD5883B;
	Tue, 13 Feb 2024 04:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707796858; cv=none; b=EXKWXhjSAyJHBBmG5mG0ZeaNbBqEaMo6viZHAyvDxiCAhfA6EtM+y6kO/IaLRAEYlm2hciWSQ3AnFHx3zH8SRavaIvcQ01UFQndYssPTDE1e/rU4NKLd9qdHf4RHCN4MeaU2iAjZRouzLkqXOiwOcoiI2SrdMmaTXNsB+sIcWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707796858; c=relaxed/simple;
	bh=F4tlfjF4nqVUtVOK8guOWF4UjN0sf0A3zouGh4tn854=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lVZtu7Ygdwj0uFFme9tZQDqIP1PU+P4Mj5JeaSpa+T+yn8jYE7Jc4qt2gz3NdylclRghZFdIxj02V514yyoSCGK05YcVac3g9nPHINgPPpG0LEg/uw7FiBzzc0rQnVcs71XXetvV6B3h38SozzE+T4JKgdzKbYAwvXYMMYYJ1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=NeOlSrkf; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707796852;
	bh=U7e6bjJ4gcVV8EkDfFLIjscTqmmc5dLgCvjZq5sqAFM=;
	h=Date:From:To:Cc:Subject:From;
	b=NeOlSrkfJ3A9OaL6AYnjy72jxgeiZ+5AL5kHyNJqdsnjKI9YlhQnb4P16i+1FnZ5O
	 Iq5/ee+ArboT64J3V+MM9lRra2/GKZirfZsmZw5iDJqTlpvVaVfZ3FKI/4LBFUJLdj
	 +gBbLQVJhttexKJw5Cqagh2os4mJb3Tv+116cfBgIm2t0jGqapvXPoeNvY3+JQo/bT
	 W+QvaKzJDfkresQlWofn/P8Ko5BaULJeQ0qtrp7g+UPoBCyvKInZBM/RvHvoTs614J
	 fxcUyNHLT8eF/4PUX38Iz77JZjyKSlT88PXcCfVKRfsWxp2mRJtzl6nzPJ4mIuTxit
	 9iPIvmYgAgZTg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TYng80LGsz4wyr;
	Tue, 13 Feb 2024 15:00:52 +1100 (AEDT)
Date: Tue, 13 Feb 2024 15:00:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20240213150050.083de445@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MOmPc9q=TglKLWRudsda02a";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/MOmPc9q=TglKLWRudsda02a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (powerpc
allyesconfig) failed like this:

In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:42:
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1559:13: error: 'amdgpu_choose_low_powe=
r_state' defined but not used [-Werror=3Dunused-function]
 1559 | static void amdgpu_choose_low_power_state(struct amdgpu_device *ade=
v) { }
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

(and many, many more)

Caused by commit

  c77536b15b7a ("drm/amd: Stop evicting resources on APUs in suspend")

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 13 Feb 2024 14:41:05 +1100
Subject: [PATCH] fixup for "drm/amd: Stop evicting resources on APUs in sus=
pend"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 2a3f12bae823..2cf4fb3f7751 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1556,7 +1556,7 @@ void amdgpu_choose_low_power_state(struct amdgpu_devi=
ce *adev);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) =
{ return false; }
 static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { =
return false; }
-static void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
+static inline void amdgpu_choose_low_power_state(struct amdgpu_device *ade=
v) { }
 #endif
=20
 #if defined(CONFIG_DRM_AMD_DC)
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/MOmPc9q=TglKLWRudsda02a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXK6XIACgkQAVBC80lX
0Gz27Af9GKFbo49BCEVcMbpoXnxgMkA/RSlgK8EkkNHKK6lIBzhWN6dZ0+rQvl5T
X9+97+fmSs091No5Cb4yckl21u+epKx2c+8sKBM28Rj5lWCw7t0yJsQNJDJQrXh7
DUweeOImeO7HDPQq8ir0xveIDO0fwppSNpB7QIWjrgB4l22tNsAIfB23jiITbQ+i
Wp63/t/7l6bsZXT1A822oIHHi3UXLGDOlCuJBWH6pKUpAmUk4ZetYSWkOtRLnPBp
Ht9DLMUR25YTUExN3xHpfaGDNvMqnhZaUvBpTp6A8fAIkxR0EEVPlyp0Eb3Fzk0S
3NmVhFgLjt12UsmzxWvm7xIm+GBKxg==
=CSBD
-----END PGP SIGNATURE-----

--Sig_/MOmPc9q=TglKLWRudsda02a--

