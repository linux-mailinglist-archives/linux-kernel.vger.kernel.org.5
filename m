Return-Path: <linux-kernel+bounces-122575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6948A88F9EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9E01C223ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9825854672;
	Thu, 28 Mar 2024 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="IG34/QgP"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EB351C45
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613903; cv=none; b=sv8cPy1YvE+KZPBHnWQKRGexi2IzZgBslPf5FNw/hBYsNtWqQuh6LwfYdHgxaHb4OtzAGf3Bs9++smqSdggOYTRs/db0D/WmxaJTunXLvhYjHZptFWqV1PlrG3MlGQ+2SCLyNScbX1j5KQgxeWqXomG0AfGw5G/If0zSnxojBHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613903; c=relaxed/simple;
	bh=E4W+r8TfulGjSmOA1LdOpEM8S3uPAlvCQu3lib2TuNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=okxpuwazWv57B+5IB9zLLaGYT8LbY8AwWDYgnbTdlBPKUTeqdNqrtMd8GFYlOJ/WzGwYb9Lz/K3qA5CxtOtO0TcrhcGSj3tH7nguJQBg+GChSPzLyIioP2yBSIFQzS/V5hXA+Ci1soNrW2BTJ9iMrdFmZCxUP9anZKcCFCr1eTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=IG34/QgP; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1eea.dip0.t-ipconnect.de [79.254.30.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 72C052810A1;
	Thu, 28 Mar 2024 09:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1711613900;
	bh=E4W+r8TfulGjSmOA1LdOpEM8S3uPAlvCQu3lib2TuNg=;
	h=Date:From:To:Cc:Subject:From;
	b=IG34/QgPa0IP27cm2dZWuDmVArq8mQEmiYfzGlXQSoE7lXXjo0DbqMEt6I7ehsHTD
	 OGFwyrG/zwdXb0hjZF7LaiAVJ8wnJt+hMHF4bx4zGuUwWL33m/3Rg9e48Put9IMxXA
	 wsuSJyr3lxUfFX/gLJ5njoD7FlvvBkqZslYCH1CI1HkKyWJdubvX8egmW4UhAPl+mY
	 kHuhb/A08lp61uK69qzR/WNwyd0vt3HEqivK07uS8C3pE3w0PuDvZFPbXsQuIHWXSS
	 x+IWE9E5d45p/BVid6sq+C1vMTEsINWLuWl/xzvn7mfsfcHLI+TbUtoRPDi6n+ZXWt
	 TbvONu6RgVXdQ==
Date: Thu, 28 Mar 2024 09:18:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.9-rc1
Message-ID: <ZgUnyqosVrEtULhz@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.9-rc1

for you to fetch changes up to c404f55c26fc23c70a9f2262f3f36a69fc46289b:

  iommu: Validate the PASID in iommu_attach_device_pasid() (2024-03-28 06:38:40 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.9-rc1:

Including:

	- ARM SMMU fixes:

	  - Fix swabbing of the STE fields in the unlikely event of
	    running on a big-endian machine.
	  - Fix setting of STE.SHCFG on hardware that doesn't implement
	    support for attribute overrides.

	- IOMMU core:

	  - PASID validation fix in device attach path

----------------------------------------------------------------
Jason Gunthorpe (2):
      iommu/arm-smmu-v3: Add cpu_to_le64() around STRTAB_STE_0_V
      iommu: Validate the PASID in iommu_attach_device_pasid()

Joerg Roedel (1):
      Merge tag 'arm-smmu-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into iommu/fixes

Mostafa Saleh (1):
      iommu/arm-smmu-v3: Fix access for STE.SHCFG

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 38 +++++++++++++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 drivers/iommu/iommu.c                       | 11 ++++++++-
 3 files changed, 37 insertions(+), 14 deletions(-)

Please pull.

Thanks,

	Joerg

