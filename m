Return-Path: <linux-kernel+bounces-98582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B184C877C49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F881C20BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6158514010;
	Mon, 11 Mar 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="kl0pxinO"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B671400A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148282; cv=none; b=S0Kdr3/5o3fx98fygLheLPvP8KKobUo/v8jh+b/4FLWiIs8b5lEJM0jqhJWh8jOd+MVgISNFod8P/LVqzhQ2mnZLCpL3S/mnwAR23MUiv0FQwTcx1ePlmTmIxymXRxWCNz9oFiYCCAOfk2YE+4Q8gqGAro0Lf95ho9OSdfwTa6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148282; c=relaxed/simple;
	bh=miCbQdpcXs3OZwmYKJpRmifu1gWyF3jmGEJzcdzlVas=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qLJrv3s1uu8Lw9r9PYM6fO8gzl1cpZk6W2hh0rpe4w18qO+j1lj2GjF2lvMWGGQ/NarjgRQLWFsC47wwwVJpYcdP95yAnAnHC2rqYryfGJ6in8UixXzx4fSDCz1f4blOQOGWnMVbV2gevvTDQ77CHyuMTnAXPi3DqGyz9BhZV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=kl0pxinO; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B4A131C7CA4;
	Mon, 11 Mar 2024 10:11:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1710148272;
	bh=miCbQdpcXs3OZwmYKJpRmifu1gWyF3jmGEJzcdzlVas=;
	h=Date:From:To:Cc:Subject:From;
	b=kl0pxinOpkekigSgnns/xKzjeAGB2uu2AD18WeyBMFnsnKX5QEQwShVU01PoRy1ka
	 q6EPkRHWjlmwCD1km/4C0tAc9vSNrHahTbPw/I+bcz2v3HvOmlnoEvRYjcjks5Piid
	 8/27hjenRmk3oMhDj2gzGECLVnLBLWigHniyXgJmzTe5KKHDgzfg9JO/ZFMp6PEZ1L
	 YVQp/+wH54Yh9vtIPrr0wjoHrzFw0Stp8IbOZubT4lA2PTq8X0UY2+JRogHaRTWFvb
	 GwRt8e9vKbq4shmHFNoAzdOTwVmyEmhDMJDqOKThiENTBioc11PSkzfjPnRrcNIDi7
	 /XJBVRwDX8mjA==
Date: Mon, 11 Mar 2024 10:11:09 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.9
Message-ID: <Ze7KrT5is81WGTRT@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

  Linux 6.8-rc7 (2024-03-03 13:02:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.9

for you to fetch changes up to f379a7e9c3b5c325ff550e911ea42092295695de:

  Merge branches 'arm/mediatek', 'arm/renesas', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next (2024-03-08 09:05:59 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v6.9

Including:

	- Core changes:
	  - Constification of bus_type pointer
	  - Preparations for user-space page-fault delivery
	  - Use a named kmem_cache for IOVA magazines

	- Intel VT-d changes from Lu Baolu:
	  - Add RBTree to track iommu probed devices
	  - Add Intel IOMMU debugfs document
	  - Cleanup and refactoring

	- ARM-SMMU Updates from Will Deacon:
	  - Device-tree binding updates for a bunch of Qualcomm SoCs
	  - SMMUv2: Support for Qualcomm X1E80100 MDSS
	  - SMMUv3: Significant rework of the driver's STE manipulation and
	    domain handling code. This is the initial part of a larger scale
	    rework aiming to improve the driver's implementation of the
	    IOMMU-API in preparation for hooking up IOMMUFD support.

	- AMD-Vi Updates:
	  - Refactor GCR3 table support for SVA
	  - Cleanups

	- Some smaller cleanups and fixes

----------------------------------------------------------------
Abel Vesa (1):
      iommu/arm-smmu-qcom: Add X1E80100 MDSS compatible

Bert Karwatzki (1):
      iommu: Fix compilation without CONFIG_IOMMU_INTEL

Erick Archer (2):
      iommu/mtk_iommu: Use devm_kcalloc() instead of devm_kzalloc()
      iommu/vt-d: Use kcalloc() instead of kzalloc()

Ethan Zhao (3):
      PCI: Make pci_dev_is_disconnected() helper public for other drivers
      iommu/vt-d: Don't issue ATS Invalidation request when device is disconnected
      iommu/vt-d: Improve ITE fault handling if target device isn't present

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

Jingqi Liu (1):
      iommu/vt-d: Add the document for Intel IOMMU debugfs

Joerg Roedel (2):
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
      Merge branches 'arm/mediatek', 'arm/renesas', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next

Konrad Dybcio (1):
      dt-bindings: arm-smmu: Add QCM2290 GPU SMMU

Krzysztof Kozlowski (4):
      iommu: constify pointer to bus_type
      iommu: constify of_phandle_args in xlate
      iommu: constify fwnode in iommu_ops_from_fwnode()
      iommu: re-use local fwnode variable in iommu_ops_from_fwnode()

Lu Baolu (24):
      iommu: Move iommu fault data to linux/iommu.h
      iommu/arm-smmu-v3: Remove unrecoverable faults reporting
      iommu: Remove unrecoverable fault data
      iommu: Cleanup iopf data structure definitions
      iommu: Merge iopf_device_param into iommu_fault_param
      iommu: Remove iommu_[un]register_device_fault_handler()
      iommu: Merge iommu_fault_event and iopf_fault
      iommu: Prepare for separating SVA and IOPF
      iommu: Make iommu_queue_iopf() more generic
      iommu: Separate SVA and IOPF
      iommu: Refine locking for per-device fault data management
      iommu: Use refcount for fault data access
      iommu: Improve iopf_queue_remove_device()
      iommu: Track iopf group instead of last fault
      iommu: Make iopf_group_response() return void
      iommu: Make iommu_report_device_fault() return void
      iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
      iommu/vt-d: Use rbtree to track iommu probed devices
      iommu/vt-d: Use device rbtree in iopf reporting path
      iommu: Add static iommu_ops->release_domain
      iommu/vt-d: Fix NULL domain on device release
      iommu/vt-d: Setup scalable mode context entry in probe path
      iommu/vt-d: Remove scalable mode context entry setup from attach_dev
      iommu/vt-d: Remove scalabe mode in domain_context_clear_one()

Mario Limonciello (1):
      iommu/amd: Mark interrupt as managed

Neil Armstrong (2):
      dt-bindings: arm-smmu: Fix SM8[45]50 GPU SMMU 'if' condition
      dt-bindings: arm-smmu: Document SM8650 GPU SMMU

Pasha Tatashin (1):
      iommu/iova: use named kmem_cache for iova magazines

Robin Murphy (4):
      iommu/iova: Tidy up iova_cache_get() failure
      iommu/iova: Reorganise some code
      iommu/ipmmu-vmsa: Minor cleanups
      iommu/dma: Document min_align_mask assumption

Suravee Suthikulpanit (8):
      iommu/amd: Introduce get_amd_iommu_from_dev()
      iommu/amd: Introduce struct protection_domain.pd_mode
      iommu/amd: Introduce per-device GCR3 table
      iommu/amd: Refactor helper function for setting / clearing GCR3
      iommu/amd: Refactor attaching / detaching device functions
      iommu/amd: Refactor protection_domain helper functions
      iommu/amd: Refactor GCR3 table helper functions
      iommu/amd: Remove unused GCR3 table parameters from struct protection_domain

Tina Zhang (3):
      iommu/vt-d: Remove treatment for revoking PASIDs with pending page faults
      iommu/vt-d: Remove initialization for dynamically heap-allocated rcu_head
      iommu/vt-d: Merge intel_svm_bind_mm() into its caller

Vasant Hegde (16):
      iommu/amd: Remove unused PPR_* macros
      iommu/amd: Remove unused IOVA_* macro
      iommu/amd: Remove unused APERTURE_* macros
      iommu/amd: Remove duplicate function declarations from amd_iommu.h
      iommu/amd: Remove redundant error check in amd_iommu_probe_device()
      iommu/amd: Remove EXPORT_SYMBOL for perf counter related functions
      iommu/amd: Pass struct iommu_dev_data to set_dte_entry()
      iommu/amd: Enable Guest Translation before registering devices
      iommu/amd: Use protection_domain.flags to check page table mode
      iommu/amd: Add support for device based TLB invalidation
      iommu/amd: Rearrange GCR3 table setup code
      iommu: Introduce iommu_group_mutex_assert()
      iommu/amd: Remove unused flush pasid functions
      iommu/amd: Rearrange device flush code
      iommu/amd: Introduce per-device domain ID to fix potential TLB aliasing issue
      iommu/amd: Fix sleeping in atomic context

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

 Documentation/ABI/testing/debugfs-intel-iommu      | 276 +++++++
 .../devicetree/bindings/iommu/arm,smmu.yaml        |  20 +-
 MAINTAINERS                                        |   1 -
 drivers/iommu/Kconfig                              |   6 +-
 drivers/iommu/Makefile                             |   3 +-
 drivers/iommu/amd/amd_iommu.h                      |  41 +-
 drivers/iommu/amd/amd_iommu_types.h                |  34 +-
 drivers/iommu/amd/init.c                           |  12 +-
 drivers/iommu/amd/io_pgtable_v2.c                  |  21 +-
 drivers/iommu/amd/iommu.c                          | 634 ++++++++--------
 drivers/iommu/apple-dart.c                         |   3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  22 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 814 +++++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   4 -
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   1 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |   3 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   3 +-
 drivers/iommu/dma-iommu.c                          |   5 +
 drivers/iommu/exynos-iommu.c                       |   2 +-
 drivers/iommu/intel/Kconfig                        |  12 +-
 drivers/iommu/intel/Makefile                       |   2 +
 drivers/iommu/intel/dmar.c                         |  26 +-
 drivers/iommu/intel/iommu.c                        | 337 ++++-----
 drivers/iommu/intel/iommu.h                        |  14 +-
 drivers/iommu/intel/pasid.c                        | 205 ++++++
 drivers/iommu/intel/pasid.h                        |   2 +
 drivers/iommu/intel/perf.c                         |   2 +-
 drivers/iommu/intel/svm.c                          |  76 +-
 drivers/iommu/io-pgfault.c                         | 463 +++++++-----
 drivers/iommu/iommu-priv.h                         |   5 +-
 drivers/iommu/iommu-sva.c                          |  71 +-
 drivers/iommu/iommu-sva.h                          |  71 --
 drivers/iommu/iommu.c                              | 280 +------
 drivers/iommu/iova.c                               | 143 ++--
 drivers/iommu/ipmmu-vmsa.c                         |  19 +-
 drivers/iommu/irq_remapping.c                      |   3 +-
 drivers/iommu/msm_iommu.c                          |   4 +-
 drivers/iommu/mtk_iommu.c                          |   5 +-
 drivers/iommu/mtk_iommu_v1.c                       |   7 +-
 drivers/iommu/of_iommu.c                           |   2 +-
 drivers/iommu/rockchip-iommu.c                     |   2 +-
 drivers/iommu/sprd-iommu.c                         |   3 +-
 drivers/iommu/sun50i-iommu.c                       |   2 +-
 drivers/iommu/tegra-smmu.c                         |   4 +-
 drivers/iommu/virtio-iommu.c                       |   3 +-
 drivers/pci/pci.h                                  |   5 -
 include/linux/iommu.h                              | 295 ++++++--
 include/linux/pci.h                                |   5 +
 include/uapi/linux/iommu.h                         | 161 ----
 49 files changed, 2295 insertions(+), 1839 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-intel-iommu
 delete mode 100644 drivers/iommu/iommu-sva.h
 delete mode 100644 include/uapi/linux/iommu.h

Please pull.

Thanks,

	Joerg

