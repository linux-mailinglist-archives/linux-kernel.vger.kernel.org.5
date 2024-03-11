Return-Path: <linux-kernel+bounces-98420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC078779D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D23B281758
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6174310FA;
	Mon, 11 Mar 2024 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwX7zCyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D264628;
	Mon, 11 Mar 2024 02:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710124394; cv=none; b=lMjVolU0xeckHi6GLp+k7qX7BDpZv7uehOv0O2WMefbVIsnarABmYiGM3osCOp4s+mR1I31Pg7uRbUN8NHf0g6VFX9e78bzjWWge4HQP/LJE/PjlyPTKPcZzrV0D+utQQsJ2egpwvA+Wz7xB0esq+AG+6IDK8r5DMetCtaAS2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710124394; c=relaxed/simple;
	bh=3i9coLbL0xLg8P6CbihMu3LdaGv3HnasLHe1Y9tJoZY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VyvHhSiGvcjl1kHqozWokuxdSpMF1oKPU2QlhewtyHvsAt17RjBc3qVwDbfwJ4NV6S5bzYBhSS8nWx6WN0gF2Vd5IScPnY628pPuFOyZZ3cfktiMPeDa6IVbQztjyYe9LEs6SShZAkgfoErTlytdMzm1K4dNZW/GKrI7K3bk8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwX7zCyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B20BC433F1;
	Mon, 11 Mar 2024 02:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710124393;
	bh=3i9coLbL0xLg8P6CbihMu3LdaGv3HnasLHe1Y9tJoZY=;
	h=Date:From:To:Cc:Subject:From;
	b=MwX7zCyyTae4LO2IEm2At4ZoNzeucou9+nzwvdEoryvNILxNxua1dnp5pdJvLhsnd
	 HXdfHdES6+jQD/bwR759j6hFfSx/du2qK3HBGDqFZPwEP+vxFSLS1D4vsAfWTjZg0e
	 i6oNZCZ1QwI9YYFPElJIYOWINncK44WKSG5qV+Wiic+Vlc49eVvABw76403OUazAah
	 uZuKqP+UsUBHygNYB1c2xnMaBh4TYzoAIgcy3lGA0IUmJD1BVfjdv5FhgsjVmiNpRn
	 4bV7FN3YO5b/7i0iwB5vy0Lk2oOTlfNc7QXayLpKXg1uIYnq4ysXBgeGZJYe0ybE6j
	 bzd+ZpIrg8DlQ==
Date: Mon, 11 Mar 2024 10:33:10 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: briannorris@chromium.org, jwerner@chromium.org, groeck@chromium.org,
	tzungbi@kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform-firmware changes for v6.9
Message-ID: <Ze5tZoBl4glQOR6o@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DE7/ob1FZwYKsm+t"
Content-Disposition: inline


--DE7/ob1FZwYKsm+t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git=
 tags/tag-chrome-platform-firmware-for-v6.9

for you to fetch changes up to 8a0a62941a042612f7487f6c4ff291f9054ff214:

  firmware: coreboot: Replace tag with id table in driver struct (2024-02-1=
7 08:53:06 +0800)

----------------------------------------------------------------
chrome platform firmware changes for 6.9

* Improvements

  - Allow userspace to automatically load coreboot modules by adding
    modaliases and sending uevents.

* Misc

  - Make bus_type const.

----------------------------------------------------------------
N=EDcolas F. R. A. Prado (3):
      firmware: coreboot: Generate modalias uevent for devices
      firmware: coreboot: Generate aliases for coreboot modules
      firmware: coreboot: Replace tag with id table in driver struct

Ricardo B. Marliere (1):
      firmware: coreboot: make coreboot_bus_type const

 drivers/firmware/google/cbmem.c                |  8 +++++++-
 drivers/firmware/google/coreboot_table.c       | 22 ++++++++++++++++++++--
 drivers/firmware/google/coreboot_table.h       |  3 ++-
 drivers/firmware/google/framebuffer-coreboot.c |  8 +++++++-
 drivers/firmware/google/memconsole-coreboot.c  |  8 +++++++-
 drivers/firmware/google/vpd.c                  |  8 +++++++-
 include/linux/mod_devicetable.h                | 10 ++++++++++
 scripts/mod/devicetable-offsets.c              |  3 +++
 scripts/mod/file2alias.c                       | 10 ++++++++++
 9 files changed, 73 insertions(+), 7 deletions(-)

--DE7/ob1FZwYKsm+t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZe5tZQAKCRArxTEGBto8
9AsJAP4wX+mWBEfRaGPCol9VrxD5Yu4WZFTI5vzoOpJFjW5eBQEAwIhvRzvi4oVv
/DL7voP2h61oD3nn8a7XltNhKvRoKQ8=
=VW/3
-----END PGP SIGNATURE-----

--DE7/ob1FZwYKsm+t--

