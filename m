Return-Path: <linux-kernel+bounces-49927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0CA8471A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10EA1F28219
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7809B13F00D;
	Fri,  2 Feb 2024 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="LwlOtlJL"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD0260249
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883095; cv=none; b=CZ253lS9mDDQRQFLvo11Sn+LfnvqAiOhJ+J+3cNyTyNEXwo4DgGDZAJ9EfLLWCxfM3fz8gOmcCXGh0R74DrGiVvb7bAxfgAWAyyPLzvDvqeuK8zqJJkeP/7GxRbsC7oBwWdEAvSN5cI1it6o2AhY2gTGhn7VhtIYFzWztNOcIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883095; c=relaxed/simple;
	bh=wjLjnJAjbNBLCn9zKPLVKdaXKEMkZpMbB5LhcZy/RbI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=INStssRMVamt4B8T7aJNTEbaZEERiHmad+J3l/OxNSxVC81EwSA37VQl2o3qgojQV3IP9d7RxbPXKvF8EIwSsn3FqckxKl8d87NuUowKXEH+HhXg6oHMBcT7VDqXXWUE9sFeHNKDK7YNHwj9eiDgK+7xUWH++68zJUKAgNxvKas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=LwlOtlJL; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5D1431E1FDD;
	Fri,  2 Feb 2024 15:11:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1706883086;
	bh=wjLjnJAjbNBLCn9zKPLVKdaXKEMkZpMbB5LhcZy/RbI=;
	h=Date:From:To:Cc:Subject:From;
	b=LwlOtlJLDYZupoUvtA4BGF9e9WqN2ngejjHfAJyE7pK1AQrV3crlsWCXDEjRRSiD1
	 C1LzBYi0+9CEtZiIvzNpc3wWpPs4HS74edv7CNG0mTPYDlR3F4Ydi6W0rNhOI7ODzp
	 4X2FV3NNnMXkpGLwaJvmlEmrGHa57IlKym+VUYxvSmiawgI0dGKGqxw8ur66CtBR8a
	 RygOFpYyNP2wQPNcgu/WQevk8SHCpq56sPoCzPL4ZbZ1g+WYgb0RF44OKO/nupfNBo
	 09jXpbTDG5cQ7RK/sfauKgZoGGw6LDfcty8/8TBQXFZfj3qcr047y5bLwevLs+rJ2x
	 f2dlXOXSIqZ/A==
Date: Fri, 2 Feb 2024 15:11:25 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.8-rc2
Message-ID: <Zbz4DdrTl4js-w9H@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="30+K22LByfpbaTue"
Content-Disposition: inline


--30+K22LByfpbaTue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.8-rc2

for you to fetch changes up to d2d00e15808c37ec476a5c040ee2cdd23854ef18:

  powerpc: iommu: Bring back table group release_ownership() call (2024-02-02 09:26:20 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.8-rc2

Including:

	- Make iommu_ops->default_domain work without CONFIG_IOMMU_DMA to fix
	  initialization of FSL-PAMU devices

	- Fix for Tegra fbdev initialization failure

	- Fix for a VFIO device unbinding failure on PowerPC

----------------------------------------------------------------
Jason Gunthorpe (2):
      iommu: Allow ops->default_domain to work when !CONFIG_IOMMU_DMA
      drm/tegra: Do not assume that a NULL domain means no DMA IOMMU

Shivaprasad G Bhat (1):
      powerpc: iommu: Bring back table group release_ownership() call

 arch/powerpc/kernel/iommu.c | 37 ++++++++++++++++++++++++++++---------
 drivers/gpu/drm/tegra/drm.c |  3 ++-
 drivers/iommu/iommu.c       | 18 +++++++++++++-----
 3 files changed, 43 insertions(+), 15 deletions(-)

Please pull.

Thanks,

	Joerg

--30+K22LByfpbaTue
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmW8+A0ACgkQK/BELZcB
GuO8Hw/+MDm8+qaRSjySkUWpfewPcQEFbMLrcuHTsIW0WvHyvnKOCB+SZjHrWRa1
phXK27RassNVOpkCySxe+8f6qJcIuorPB/7X4XVLCntIbghp1KyoIGOiwJ8i5Etd
kjbrzIWsMw6S+g3zvM0IaVlezxWG9/cBNx1vKOrvL1RA/+BBptUfsm5KEQT1+FMa
+ZzmycC4ooM2yvEGwuVvMUTcLpp0noaeEJY0sy54udg9XE6FmONkzR0laOhagNPW
Yeu03zETVJm2Cke5PRrpDygcf58smWrk1zh/t1A4WkG/zbJF4GxoG2kKhzeHXnp3
ZvZ3GlAGs8seqh97eX1tsUGdi66J4utTg5yq+KpUvcF1HfyRe7X0iU+Zs0wgIq7e
m/Z5ZgA1XzpJiytKpcR1bMb4x/67VMyUejzrpHjtaPrJIRu0CprdiUkqWeeVNO6A
6NxbRdC+c4TwOMZ5a3oJSxNzcDuOLHh0PiDTeAz9uY5R1TVs5oI84ao9/EtGTBb1
1cbmeJv7jIDsr54v8p88njjP9iaVku3TkXm0+5RIptXrkr9DnJsxEmRgOD4PY5rv
tplEV+6Po1kkJcZZQAXbUSR22Nn3E741KvoBpTGgfrYbS1UX5kpd7TgFw+AjO6fm
RtCYWr7mlX0uEpBMDLy7C25hfUdi5UoRwx7bdTkLpLTEV1qrqS8=
=w3pA
-----END PGP SIGNATURE-----

--30+K22LByfpbaTue--

