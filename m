Return-Path: <linux-kernel+bounces-79884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0178627E6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8260DB2150E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7434D59E;
	Sat, 24 Feb 2024 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ROllbFbJ"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6B84CDFB
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708812397; cv=none; b=ghfPqA8kZor5z1zlx1LQexJgIov/BlxZ9yVsHydsW8BsoqJpQTYvqa2yTUuugjUHHG1BiiaexXYRQRtdjh1eeT4l+yXAcFP79aEOZdr55y56qdnNTl77dGzGJUGBpxJ4WmXWljyj4SHssP8b7drTwK2IT13MDpAxQLcZNhEglDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708812397; c=relaxed/simple;
	bh=ieBA33WGs4Kt+fmMNbz2jVA32D/Ax2LrmYRtNByr9rc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NFz/wzCEwZ5XxFmXC8OJ1F1LvAvwXW3daHwVW61m8DB+UXS/YlnvOuxibjWXeRYhduGFr1pwESiV+9XPL754mqrsykMyM5WtwWOvM9O9s3wD9uH21OB9w2ZLCuuQiTnuFQscb6hhtf2XlLSF5zXXzrffxSmqNc1hl/zf8iiuZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=ROllbFbJ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 829C61C62A2;
	Sat, 24 Feb 2024 23:06:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1708812387;
	bh=ieBA33WGs4Kt+fmMNbz2jVA32D/Ax2LrmYRtNByr9rc=;
	h=Date:From:To:Cc:Subject:From;
	b=ROllbFbJ35aqzbPD3ZW7uSn6QnQ1C1I5d8buXPTOJjwFspYZXSWcIVeMKI61xbj+8
	 aik7e6UclKzAJ64zFvsnN2Ul7BGwO5v4LEkaikSky3rQolXn6s8JOAH4mo41Q2JN8q
	 lx7/4yky/uDPoA6Uc9oRTTr24qkyJOOMs/nE7/IYTBnKnaaS8HxKHG1aEmyaOCiPty
	 xfpJXbVIkLKnAunZUzoKt7Wyk2YcqSxwO0+9O0W/FhPSdLde6g/jRCRa77d2/kLaTp
	 GDY2N3Y3O6uOk0YsYb1oH+089a/859Mhs82UC3BZXU+JT1xeiJPw//DiU9gABN90pm
	 AqmtI4UaBEFEQ==
Date: Sat, 24 Feb 2024 23:06:26 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.8-rc5
Message-ID: <ZdpoYsivgpf_zdax@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8udg5sVDv6UBipkG"
Content-Disposition: inline


--8udg5sVDv6UBipkG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.8-rc5

for you to fetch changes up to 65d4418c5002ec5b0e529455bf4152fd43459079:

  iommu/sva: Restore SVA handle sharing (2024-02-23 16:45:05 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.8-rc5

Including:

	- Intel VT-d fixes for nested domain handling:
	  - Cache invalidation for changes in a parent domain
	  - Dirty tracking setting for parent and nested domains
	  - Fix a constant-out-of-range warning

	- ARM SMMU fixes:
	  - Fix CD allocation from atomic context when using SVA with SMMUv3
	  - Revert the conversion of SMMUv2 to domain_alloc_paging(), as it
	    breaks the boot for Qualcomm MSM8996 devices

	- Restore SVA handle sharing in core code as it turned out there are
	  still drivers relying on it

----------------------------------------------------------------
Arnd Bergmann (1):
      iommu/vt-d: Fix constant-out-of-range warning

Dmitry Baryshkov (1):
      Revert "iommu/arm-smmu: Convert to domain_alloc_paging()"

Jason Gunthorpe (2):
      iommu/arm-smmu-v3: Do not use GFP_KERNEL under as spinlock
      iommu/sva: Restore SVA handle sharing

Joerg Roedel (1):
      Merge tag 'arm-smmu-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into iommu/fixes

Yi Liu (9):
      iommu/vt-d: Track nested domains in parent
      iommu/vt-d: Add __iommu_flush_iotlb_psi()
      iommu/vt-d: Add missing iotlb flush for parent domain
      iommu/vt-d: Update iotlb in nested domain attach
      iommu/vt-d: Add missing device iotlb flush for parent domain
      iommu/vt-d: Remove domain parameter for intel_pasid_setup_dirty_tracking()
      iommu/vt-d: Wrap the dirty tracking loop to be a helper
      iommu/vt-d: Add missing dirty tracking set for parent domain
      iommu/vt-d: Set SSADE when attaching to a parent with dirty tracking

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  38 ++---
 drivers/iommu/arm/arm-smmu/arm-smmu.c           |  17 +-
 drivers/iommu/intel/iommu.c                     | 214 ++++++++++++++++++------
 drivers/iommu/intel/iommu.h                     |   7 +
 drivers/iommu/intel/nested.c                    |  16 +-
 drivers/iommu/intel/pasid.c                     |   5 +-
 drivers/iommu/intel/pasid.h                     |   1 -
 drivers/iommu/iommu-sva.c                       |  17 ++
 include/linux/iommu.h                           |   3 +
 9 files changed, 225 insertions(+), 93 deletions(-)

Please pull.

Thanks,

	Joerg

--8udg5sVDv6UBipkG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmXaaGIACgkQK/BELZcB
GuN9fBAAjszaR5P6P941H8PXC1JOUMDQVdFK3kuxrS9+t0KL1C6NbyalkkYkVV8x
TbQ8dh0R8ZxVoM5E+vFYM6QlE1DPsUw9a3K6h4JGZJwfOqHCGncK8rAWa+30/MtM
Tam+gaHy4TvSwRwHXe0oY2s0L03ETyLTGoa5SumHL69vaWSQM6GGOvC/CzHcoTTX
LhZwsajEzwDVenqCnEdCdxKqhVVQoLwpvudmXuEIUkk8BEJ4/OgZMm+hQlAE6MTB
9He43DzzIgb5ikLHNV1E0ReERNyK+jUKgdgVfp4Fi5Gyfap7qMPycPCOD/CdPf2u
sJYrZyYLjWXJXwbt6+Iz0tZ0duPnEx89NdtR75P4tRssrxSdCmwauKdEd9CvYjCO
frTNBpftVlhosapkdBCPtN+BMPIFRCpgALCxxfbzeegD7KN4KAIh03CUbM2mWU07
Ok80Wm94RzphE/ObmvNH53mhz2QBUrsfLiBX02mdjwGz3sJ/ZgLg4E9NQn+KIAMr
lNsxkGTSlMuNkPqS3XCMDQLUpiZRdmD7rOX72dvz6RGmKnU0X9X2EIDjPZF4P/cO
aQVquRnmFS+55B0+AokqODlwqmhYTsMd440EeyaIfxAIz7rNUgFENiPvatqkV1+l
7UWkcw72I5t2hw7wQ1mo9OVXOXRWLaxoxyudEtNQwj1yEJor8P4=
=3AY4
-----END PGP SIGNATURE-----

--8udg5sVDv6UBipkG--

