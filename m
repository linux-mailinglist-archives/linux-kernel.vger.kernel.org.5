Return-Path: <linux-kernel+bounces-22157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED229829A36
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774FE1F28AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B300481DD;
	Wed, 10 Jan 2024 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="wvc0Ko2P"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F859481AF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B271E1C2401;
	Wed, 10 Jan 2024 13:10:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1704888632;
	bh=eiIMRO6s3nuoZfWxzArwHzBSXPm/tcbpKWjkUndEsx4=;
	h=Date:From:To:Cc:Subject:From;
	b=wvc0Ko2PT5JdmQlnb/42gBpilLyKA7TCOEcVWD4B8UoA/bcaiGqDcf0ODCcZRBQwt
	 H1APnvEzr8R/AKjM8LwBvwwcPC+5qK2EUlDv9eDe0PXS6eTrwh3lKdpLcAULgxO6Ba
	 NPHcB0MyrS1/OXMeRynSvHkp222MTUMAICIDrSk/q/DFDRtx/JQQEwaIgRop6aoQgF
	 6vGp+5ybWxxBiYCuTGd+TmDxJNjpLKEXacWfK1H+8Wi9NqoqXuLdV1WA0kZmZL7Qjk
	 C++C2UVQt3JiYOPQ7AuFlvHyD3+BH1maYVZlwRyWHQFREpS9Lp6b0Et53tDA0thPTD
	 74K9K6ytFAf6w==
Date: Wed, 10 Jan 2024 13:10:31 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.8
Message-ID: <ZZ6JNzDHy8-i0-VU@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="31rTxEYU3rb+agmb"
Content-Disposition: inline


--31rTxEYU3rb+agmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

There is a small merge conflict with your tree, this time in
arch/Kconfig. My resolution is attached. With that in mind, please
consider:

The following changes since commit 610a9b8f49fbcf1100716370d3b5f6f884a2835a:

  Linux 6.7-rc8 (2023-12-31 12:51:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-u=
pdates-v6.8

for you to fetch changes up to 75f74f85a42eb294b657f847c33e1bb7921dbec9:

  Merge branches 'apple/dart', 'arm/rockchip', 'arm/smmu', 'virtio', 'x86/v=
t-d', 'x86/amd' and 'core' into next (2024-01-03 09:59:32 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v6.8

Including:

	- Core changes:
	  - Fix race conditions in device probe path
	  - Retire IOMMU bus_ops
	  - Support for passing custom allocators to page table drivers
	  - Clean up Kconfig around IOMMU_SVA
	  - Support for sharing SVA domains with all devices bound to
	    a mm
	  - Firmware data parsing cleanup
	  - Tracing improvements for iommu-dma code
	  - Some smaller fixes and cleanups

	- ARM-SMMU drivers:
	  - Device-tree binding updates:
	     - Add additional compatible strings for Qualcomm SoCs
	     - Document Adreno clocks for Qualcomm's SM8350 SoC
	  - SMMUv2:
	    - Implement support for the ->domain_alloc_paging() callback
	    - Ensure Secure context is restored following suspend of Qualcomm SMMU
	      implementation
	  - SMMUv3:
	    - Disable stalling mode for the "quiet" context descriptor
	    - Minor refactoring and driver cleanups

	 - Intel VT-d driver:
	   - Cleanup and refactoring

	 - AMD IOMMU driver:
	   - Improve IO TLB invalidation logic
	   - Small cleanups and improvements

	 - Rockchip IOMMU driver:
	   - DT binding update to add Rockchip RK3588

	 - Apple DART driver:
	   - Apple M1 USB4/Thunderbolt DART support
	   - Cleanups

	 - Virtio IOMMU driver:
	   - Add support for iotlb_sync_map
	   - Enable deferred IO TLB flushes

----------------------------------------------------------------
Andy Yan (1):
      dt-bindings: iommu: rockchip: Add Rockchip RK3588

Ashish Mhetre (1):
      iommu: Don't reserve 0-length IOVA region

Boris Brezillon (2):
      iommu: Allow passing custom allocators to pgtable drivers
      iommu: Extend LPAE page table format to support custom allocators

Colin Ian King (1):
      iommu/apple-dart: Fix spelling mistake "grups" -> "groups"

Harshit Mogalapalli (1):
      iommu/sva: Fix memory leak in iommu_sva_bind_device()

Isaac J. Manjarres (1):
      iommu/dma: Trace bounce buffer usage when mapping buffers

Jason Gunthorpe (16):
      iommu: Change kconfig around IOMMU_SVA
      iommu: Remove struct iommu_ops *iommu from arch_setup_dma_ops()
      iommmu/of: Do not return struct iommu_ops from of_iommu_configure()
      iommu/of: Use -ENODEV consistently in of_iommu_configure()
      iommu: Mark dev_iommu_get() with lockdep
      iommu: Mark dev_iommu_priv_set() with a lockdep
      acpi: Do not return struct iommu_ops from acpi_iommu_configure_id()
      iommu/tegra: Use tegra_dev_iommu_get_stream_id() in the remaining pla=
ces
      iommu/arm-smmu-v3: Add a type for the STE
      iommu/arm-smmu-v3: Master cannot be NULL in arm_smmu_write_strtab_ent=
()
      iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
      iommu/arm-smmu: Reorganize arm_smmu_domain_add_master()
      iommu/arm-smmu: Convert to a global static identity domain
      iommu/arm-smmu: Implement IOMMU_DOMAIN_BLOCKED
      iommu/arm-smmu: Pass arm_smmu_domain to internal functions
      iommu/arm-smmu: Convert to domain_alloc_paging()

Joerg Roedel (3):
      Merge branch 'iommu/fixes' into core
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/will/linux into arm/smmu
      Merge branches 'apple/dart', 'arm/rockchip', 'arm/smmu', 'virtio', 'x=
86/vt-d', 'x86/amd' and 'core' into next

Konrad Dybcio (2):
      dt-bindings: arm-smmu: Document SM8[45]50 GPU SMMU
      iommu/arm-smmu-qcom: Add QCM2290 MDSS compatible

Krzysztof Kozlowski (1):
      dt-bindings: iommu: arm,smmu: document clocks for the SM8350 GPU SMMU

Kunwu Chan (1):
      iommu/amd: Set variable amd_dirty_ops to static

Laurentiu Tudor (1):
      iommu: Map reserved memory as cacheable if device is coherent

Lu Baolu (5):
      iommu: Set owner token to SVA domain
      iommu/vt-d: Refactor device_to_iommu() to retrieve iommu directly
      iommu/vt-d: Remove unused parameter of intel_pasid_setup_pass_through=
()
      iommu/vt-d: Remove unused vcmd interfaces
      iommu/vt-d: Move inline helpers to header files

Neil Armstrong (1):
      dt-bindings: iommu: arm,smmu: document the SM8650 System MMU

Niklas Schnelle (2):
      iommu/virtio: Make use of ops->iotlb_sync_map
      iommu/virtio: Add ops->flush_iotlb_all and enable deferred flush

Rajendra Nayak (1):
      dt-bindings: arm-smmu: Add compatible for X1E80100 SoC

Rob Clark (1):
      iommu/arm-smmu-qcom: Add missing GMU entry to match table

Robin Murphy (7):
      iommu: Factor out some helpers
      iommu: Decouple iommu_present() from bus ops
      iommu: Validate that devices match domains
      iommu: Decouple iommu_domain_alloc() from bus ops
      iommu/arm-smmu: Don't register fwnode for legacy binding
      iommu: Retire bus ops
      iommu: Clean up open-coded ownership checks

Suravee Suthikulpanit (1):
      iommu/amd: Do not flush IRTE when only updating isRun and destination=
 fields

Sven Peter (4):
      dt-bindings: iommu: dart: Add t8103-usb4-dart compatible
      iommu/apple-dart: Write to all DART_T8020_STREAM_SELECT
      iommu/apple-dart: Add support for t8103 USB4 DART
      iommu/apple-dart: Use readl instead of readl_relaxed for consistency

Tina Zhang (5):
      iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
      iommu: Add mm_get_enqcmd_pasid() helper function
      mm: Add structure to keep sva information
      iommu: Support mm PASID 1:n with sva domains
      mm: Deprecate pasid field

Vasant Hegde (9):
      iommu/amd: Rename iommu_flush_all_caches() -> amd_iommu_flush_all_cac=
hes()
      iommu/amd: Remove redundant domain flush from attach_device()
      iommu/amd: Remove redundant passing of PDE bit
      iommu/amd: Add support to invalidate multiple guest pages
      iommu/amd: Refactor IOMMU tlb invalidation code
      iommu/amd: Refactor device iotlb invalidation code
      iommu/amd: Consolidate amd_iommu_domain_flush_complete() call
      iommu/amd: Make domain_flush_pages as global function
      iommu/amd/pgtbl_v2: Invalidate updated page ranges only

Vladimir Lypak (1):
      iommu/qcom: restore IOMMU state if needed

Wenkai Lin (1):
      iommu/arm-smmu-v3: disable stall for quiet_cd

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/up=
dates

 .../devicetree/bindings/iommu/apple,dart.yaml      |   1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |  77 +++++-
 .../devicetree/bindings/iommu/rockchip,iommu.yaml  |  11 +-
 arch/Kconfig                                       |   5 +
 arch/arc/mm/dma.c                                  |   2 +-
 arch/arm/mm/dma-mapping-nommu.c                    |   2 +-
 arch/arm/mm/dma-mapping.c                          |  10 +-
 arch/arm64/mm/dma-mapping.c                        |   4 +-
 arch/mips/mm/dma-noncoherent.c                     |   2 +-
 arch/riscv/mm/dma-noncoherent.c                    |   2 +-
 arch/x86/Kconfig                                   |   1 +
 arch/x86/kernel/traps.c                            |   4 +-
 drivers/acpi/scan.c                                |  32 +--
 drivers/dma/tegra186-gpc-dma.c                     |   8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp10b.c    |   9 +-
 drivers/hv/hv_common.c                             |   2 +-
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/amd/amd_iommu.h                      |   8 +-
 drivers/iommu/amd/amd_iommu_types.h                |   6 -
 drivers/iommu/amd/init.c                           |   8 +-
 drivers/iommu/amd/io_pgtable.c                     |   5 +-
 drivers/iommu/amd/io_pgtable_v2.c                  |  10 +-
 drivers/iommu/amd/iommu.c                          | 189 +++++++-------
 drivers/iommu/apple-dart.c                         |  40 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  23 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  79 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   8 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              | 166 ++++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   1 -
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  26 +-
 drivers/iommu/dma-iommu.c                          |   3 +
 drivers/iommu/intel/debugfs.c                      |   3 -
 drivers/iommu/intel/iommu.c                        | 241 ++----------------
 drivers/iommu/intel/iommu.h                        | 179 +++++++++++++-
 drivers/iommu/intel/pasid.c                        | 274 +----------------=
----
 drivers/iommu/intel/pasid.h                        | 223 ++++++++++++++++-
 drivers/iommu/intel/svm.c                          |  34 +--
 drivers/iommu/io-pgtable-arm.c                     |  55 +++--
 drivers/iommu/io-pgtable.c                         |  23 ++
 drivers/iommu/iommu-sva.c                          |  97 +++++---
 drivers/iommu/iommu.c                              | 154 ++++++++----
 drivers/iommu/iommufd/hw_pagetable.c               |   2 +
 drivers/iommu/mtk_iommu.c                          |   7 +-
 drivers/iommu/mtk_iommu_v1.c                       |   3 -
 drivers/iommu/of_iommu.c                           |  73 +++---
 drivers/iommu/omap-iommu.c                         |   1 -
 drivers/iommu/sprd-iommu.c                         |   8 +-
 drivers/iommu/virtio-iommu.c                       |  36 ++-
 drivers/memory/tegra/tegra186.c                    |  14 +-
 drivers/of/device.c                                |  24 +-
 include/acpi/acpi_bus.h                            |   2 +
 include/linux/device.h                             |   1 -
 include/linux/device/bus.h                         |   5 -
 include/linux/dma-map-ops.h                        |   5 +-
 include/linux/io-pgtable.h                         |  34 +++
 include/linux/iommu.h                              |  47 +++-
 include/linux/mm_types.h                           |   5 +-
 include/linux/of_iommu.h                           |  13 +-
 include/linux/sched.h                              |   2 +-
 kernel/fork.c                                      |   2 +-
 mm/Kconfig                                         |   3 +
 mm/init-mm.c                                       |   3 -
 63 files changed, 1278 insertions(+), 1042 deletions(-)

Please pull.

Thanks,

	Joerg

diff --cc arch/Kconfig
index 5ca66aad0d08,3e49f862670e..c91917b50873
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@@ -301,8 -301,22 +301,13 @@@ config ARCH_HAS_DMA_CLEAR_UNCACHE
  config ARCH_HAS_CPU_FINALIZE_INIT
  	bool
 =20
+ # The architecture has a per-task state that includes the mm's PASID
+ config ARCH_HAS_CPU_PASID
+ 	bool
+ 	select IOMMU_MM_DATA
+=20
 -# Select if arch init_task must go in the __init_task_data section
 -config ARCH_TASK_STRUCT_ON_STACK
 -	bool
 -
 -# Select if arch has its private alloc_task_struct() function
 -config ARCH_TASK_STRUCT_ALLOCATOR
 -	bool
 -
  config HAVE_ARCH_THREAD_STRUCT_WHITELIST
  	bool
 -	depends on !ARCH_TASK_STRUCT_ALLOCATOR
  	help
  	  An architecture should select this to provide hardened usercopy
  	  knowledge about what region of the thread_struct should be

--31rTxEYU3rb+agmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmWeiTIACgkQK/BELZcB
GuNpiw/+KsHN78wp921ytBoo7bkPxuFpcDxN2T63LWjG/PjyTmHgMBpo5Vt6/33Q
zDKYAuFheGhD1dOtTjQNAoRTG/HD1xUeCiUv/345Iu2doTe3lG4IixJ0e0d+3r08
iRbZcSvhyj6OZM9LYcDIruKs9sLP23mf5w0Lxbcx//4qcAiQRgnvqiXYluwt3WcZ
3daTd/hKh2RkYxIUytgwjzmLhXnet1W5ykqSQxVnOU7yqlwEiC0d7uqv2wHQldUJ
OQwU5nl2afK0wawpbgWt/v24dQtFVAXUccMLo24KufObwTfCbFpMGhFjmHf5tYMb
yMjrcSgebBv/2i3zmH+mCUw7h3LAvOS8g932QOTexfat0huHfNaLrDR1gVJnpctB
roDT0Q0MIQA6+4vdPb1NDSv2tI6NtltGcdYVDNWUo8CnBxB82IzCsEmvIL0VVq93
byyBqawEgxTfTQXv3QdFT5FCP23QY27JTaNv+hZnM3b61hucwOcyZ9sGY88Yr6xQ
TgpJs8jSc2AyA1SgzM8JTF1gwmbYAwmqjyJMED5QNfGxDiCfRURvJPouJcl3+iGa
8ln0IP5jYY29fvX9zZlAB66W2E6pvIU07UJ9AmgU53rF/dgF+KAnmMR2K1kmvQb+
pWkqisSHi64wyAudQa8OOjxOxss5nRFtZScfoGBBvryQBsMAdUk=
=KdJA
-----END PGP SIGNATURE-----

--31rTxEYU3rb+agmb--

