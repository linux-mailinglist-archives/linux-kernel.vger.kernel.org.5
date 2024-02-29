Return-Path: <linux-kernel+bounces-87262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC3E86D1D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1618B2877A0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64EB78287;
	Thu, 29 Feb 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx4eeOWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0107F78295;
	Thu, 29 Feb 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230539; cv=none; b=KWXllLjBq+6OvxXxKn2xBaerBEUQs+w2MEdj5KLy+pCSzkNZfsorWrHkPydFSwoOqu5CH+XbEytXIM9g1FNHi4cT/uKa4JDBI8J08Eu5rnH8MxMxGCdhjAReRr5AjAF+g3lq1RD3EQXefaE8g36VstxrILI5PYl6ITrOtVmBOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230539; c=relaxed/simple;
	bh=jfp9NM/oduYBlfC4B2HixtczjJ4MUMSRLdM3FJ9Nqzs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F+sAprn/c1WurKVC6MM/L6EN2z65Xl1Nn9/exRNWXKE2JkwdBIxeN6+LN6TZgFd7rm0+uKnS3g5ok9BrIaKtBZupVlv1aEY5JJcp/+cyObF22QUzV5NReGHlxT7wIiHIXCMFbdEXluPqqXjU4ELsBovI2LWipfrREfKPv49INOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tx4eeOWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B092C433F1;
	Thu, 29 Feb 2024 18:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709230538;
	bh=jfp9NM/oduYBlfC4B2HixtczjJ4MUMSRLdM3FJ9Nqzs=;
	h=Date:From:To:Cc:Subject:From;
	b=Tx4eeOWrXzfFXq6toThB8Vyuwvfmd+EM9PCvpnRMW5eO1/JDZpz6XJLoWCKiClBNM
	 Iduyzi4Gi0oEhNWB/+DUVfQbEwS8TKh/A7tqCQZAe5w6UUUq/+xBKMh0fxqGsFJ9Lo
	 77QGOlMJNbP35VyTp3Yw+V5/UQelXGiIQDtVs2aDlVhbAxsSzLthUztuYKURDFRwdP
	 oQZ0ShPAOoyVPeLXLVETnRx1gOQ1RV/pIXWazGywROnHx9eo8/rKVzDggKfvfPb6/H
	 acmjNawC8+koALPgkE4Rz5rkuF16irQ7GJHQNQ4S8UI7UxFlNMsyEIg0LNSBYGjR3I
	 C+GaefOSe+2BQ==
Date: Thu, 29 Feb 2024 18:15:33 +0000
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 6.9
Message-ID: <20240229181533.GA16854@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Joerg,

Please pull these Arm SMMU updates for 6.9. There's the usual crop of
device-tree changes, but the meat of the work is part one of the SMMUv3
IOMMUFD-enabling work from Jason.

The branch is based on the fixes tag I sent you before and there's the
usual brief summary in the tag.

Cheers,

Will

--->8

The following changes since commit b5bf7778b722105d7a04b1d51e884497b542638b:

  iommu/arm-smmu-v3: Do not use GFP_KERNEL under as spinlock (2024-02-22 12:34:11 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 327e10b47ae99f76ac53f0b8b73a0539f390d2d2:

  iommu/arm-smmu-v3: Convert to domain_alloc_paging() (2024-02-29 15:12:23 +0000)

----------------------------------------------------------------
Arm SMMU updates for 6.9

- Device-tree binding updates for a bunch of Qualcomm SoCs

- SMMUv2:
  * Support for Qualcomm X1E80100 MDSS

- SMMUv3:
  * Significant rework of the driver's STE manipulation and domain
    handling code. This is the initial part of a larger scale rework
    aiming to improve the driver's implementation of the IOMMU API
    in preparation for hooking up IOMMUFD support.

----------------------------------------------------------------
Abel Vesa (1):
      iommu/arm-smmu-qcom: Add X1E80100 MDSS compatible

Jason Gunthorpe (16):
      iommu/arm-smmu-v3: Make STE programming independent of the callers
      iommu/arm-smmu-v3: Consolidate the STE generation for abort/bypass
      iommu/arm-smmu-v3: Move the STE generation for S1 and S2 domains into functions
      iommu/arm-smmu-v3: Build the whole STE in arm_smmu_make_s2_domain_ste()
      iommu/arm-smmu-v3: Hold arm_smmu_asid_lock during all of attach_dev
      iommu/arm-smmu-v3: Compute the STE only once for each master
      iommu/arm-smmu-v3: Do not change the STE twice during arm_smmu_attach_dev()
      iommu/arm-smmu-v3: Put writing the context descriptor in the right order
      iommu/arm-smmu-v3: Pass smmu_domain to arm_enable/disable_ats()
      iommu/arm-smmu-v3: Remove arm_smmu_master->domain
      iommu/arm-smmu-v3: Check that the RID domain is S1 in SVA
      iommu/arm-smmu-v3: Add a global static IDENTITY domain
      iommu/arm-smmu-v3: Add a global static BLOCKED domain
      iommu/arm-smmu-v3: Use the identity/blocked domain during release
      iommu/arm-smmu-v3: Pass arm_smmu_domain and arm_smmu_device to finalize
      iommu/arm-smmu-v3: Convert to domain_alloc_paging()

Konrad Dybcio (1):
      dt-bindings: arm-smmu: Add QCM2290 GPU SMMU

Neil Armstrong (2):
      dt-bindings: arm-smmu: Fix SM8[45]50 GPU SMMU 'if' condition
      dt-bindings: arm-smmu: Document SM8650 GPU SMMU

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

 .../devicetree/bindings/iommu/arm,smmu.yaml        |  20 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   8 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 730 ++++++++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   4 -
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   1 +
 5 files changed, 515 insertions(+), 248 deletions(-)

