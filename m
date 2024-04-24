Return-Path: <linux-kernel+bounces-156301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830EA8B0101
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE67F1F2391D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE00155356;
	Wed, 24 Apr 2024 05:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CANq3iYR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46DC154BF3;
	Wed, 24 Apr 2024 05:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936567; cv=none; b=Lctv+A8QrZrl/gStt9Do045ABEjAO3uqsMpMguQFbFZGFWlt6pUvVgr24Qrj3eyIiXXad07vOegVEqSTZwNQQIuL/WlFWy4X+M0QDf4388u0RkZM02y+3CTgiTWGPI4o49hye8R3g+bFUfxDTtHYuPITovNx2RbeeMg/byDxMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936567; c=relaxed/simple;
	bh=1/iIct8UGpDmuG/5bl7oWPxGoo+moxuqtVa10nZ/dok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c4eLw4pC+u7CZnmrsGfMKrP6UiJDd04k7oXqsnBs2448BgkWrd9IUEcjSvl3DECRR5ieUrZm5Ta8QvFHCEId+EyeTML8xwTMdupzXEu6HhPU10VCJ0PiEM7dQAcf9XSelaRPzklEGf4Rm5SvTh2LSNTVNfrkK8JDetoIlH3OLnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CANq3iYR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713936565; x=1745472565;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1/iIct8UGpDmuG/5bl7oWPxGoo+moxuqtVa10nZ/dok=;
  b=CANq3iYRgtTv+PuBlF267u695Z6FsiYQjbf7KyP+yWkbLFEgWNw3JUF9
   d/EIxrJzUxsxw554sFDHSBSkGdBw4tY5STtDr2UTiTiGlTj9b403zhPvY
   PkV4+xXIL8f2FVLWlYBF5rpD/vmYrg4B8VOZ0v9Ugc457lKmcUdhfcRmQ
   y7DKAxbFmDTweI5kyePhVUj952WttElG/jAeik2rZpDKIxfbOiKPxttF2
   FQltoVXFzI2HERc+c/xO3Zki/+BmZtDsG3B1kclIftXGp7vyrXxBBiAd1
   oQeUXF1MydvEZ107YF9XTVLWvW8wZlTlXh2wnKxpYX+/m0fEUNbjvAdmc
   Q==;
X-CSE-ConnectionGUID: xedQgt2PQR+pLavKxP9YEw==
X-CSE-MsgGUID: ffORWlt2QmWxopnkfei0gA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27004146"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27004146"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 22:29:25 -0700
X-CSE-ConnectionGUID: TZUdjSLNSc++1OEGH/Lb4Q==
X-CSE-MsgGUID: 4RHRlqHiSi+Bn+7xBiL3uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="62049672"
Received: from unknown (HELO haibo-OptiPlex-7090.sh.intel.com) ([10.239.159.132])
  by orviesa001.jf.intel.com with ESMTP; 23 Apr 2024 22:29:14 -0700
From: Haibo Xu <haibo1.xu@intel.com>
To: sunilvl@ventanamicro.com,
	arnd@arndb.de
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Baoquan He <bhe@redhat.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v3 0/6] Add ACPI NUMA support for RISC-V
Date: Wed, 24 Apr 2024 13:46:20 +0800
Message-Id: <cover.1713778236.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series enable RISC-V ACPI NUMA support which was based on
the recently approved ACPI ECR[1].

Patch 1/6 is generated from the acpica PR[2] and should be merged through
the acpica project. Due to this dependency, other 5 patches can only be
merged after the corresponding ACPICA patch was pulled into linux.

Patch 2/6 add RISC-V specific acpi_numa.c file to parse NUMA information
from SRAT and SLIT ACPI tables.
Patch 3/6 add the common SRAT RINTC affinity structure handler.
Patch 4/6 remove the '#if defined(CONFIG_ARCH)' condition to make some NUMA
related parse functions common for all current architectures that support
ACPI_NUMA.
Patch 5/6 change the ACPI_NUMA to a hidden option since it would be selected
by default on all supported platform. 
Patch 6/6 replace pr_info with pr_debug in arch_acpi_numa_init() to avoid
potential boot noise on ACPI platforms that are not NUMA.  

Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next

[1] https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08tX/view?usp=sharing
[2] https://github.com/acpica/acpica/pull/926

Testing:
Since the ACPI AIA/PLIC support patch set is still under upstream review,
hence it is tested using the poll based HVC SBI console and RAM disk.
1) Build latest Qemu with the following patch backported
   https://github.com/vlsunil/qemu/commit/42bd4eeefd5d4410a68f02d54fee406d8a1269b0

2) Build latest EDK-II
   https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md

3) Build Linux with the following configs enabled
   CONFIG_RISCV_SBI_V01=y
   CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
   CONFIG_NONPORTABLE=y
   CONFIG_HVC_RISCV_SBI=y
   CONFIG_NUMA=y
   CONFIG_ACPI_NUMA=y

4) Build buildroot rootfs.cpio

5) Launch the Qemu machine
   qemu-system-riscv64 -nographic \
   -machine virt,pflash0=pflash0,pflash1=pflash1 -smp 4 -m 8G \
   -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
   -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
   -object memory-backend-ram,size=4G,id=m0 \
   -object memory-backend-ram,size=4G,id=m1 \
   -numa node,memdev=m0,cpus=0-1,nodeid=0 \
   -numa node,memdev=m1,cpus=2-3,nodeid=1 \
   -numa dist,src=0,dst=1,val=30 \
   -kernel linux/arch/riscv/boot/Image \
   -initrd buildroot/output/images/rootfs.cpio \
   -append "root=/dev/ram ro console=hvc0 earlycon=sbi"

[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0x17fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x180000000-0x27fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x17fe3bc40-0x17fe3cfff]
[    0.000000] NUMA: NODE_DATA [mem 0x27fff4c40-0x27fff5fff]
..
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x0 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x1 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x2 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x3 -> Node 1

---
Changes since v2
  - Rebase to Linux 6.9-rc1
  - changed ACPI_NUMA to a hidden option in patch 5/6 per Arnd's suggestion
  - Removed original 6/6 which was not needed with changes in patch 5/6
  - Added a new patch 6/6 to replace pr_info to pr_debug in arch_acpi_numa_init

Haibo Xu (6):
  ACPICA: SRAT: Add RISC-V RINTC affinity structure
  ACPI: RISCV: Add NUMA support based on SRAT and SLIT
  ACPI: NUMA: Add handler for SRAT RINTC affinity structure
  ACPI: NUMA: Make some NUMA related parse functions common
  ACPI: NUMA: change the ACPI_NUMA to a hidden option
  ACPI: NUMA: replace pr_info with pr_debug in arch_acpi_numa_init

 arch/arm64/Kconfig            |   1 -
 arch/loongarch/Kconfig        |   1 -
 arch/riscv/include/asm/acpi.h |  15 +++-
 arch/riscv/kernel/Makefile    |   1 +
 arch/riscv/kernel/acpi.c      |   5 --
 arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c     |   4 +-
 arch/riscv/kernel/smpboot.c   |   2 -
 drivers/acpi/numa/Kconfig     |   5 +-
 drivers/acpi/numa/srat.c      |  40 ++++++++---
 drivers/base/arch_numa.c      |   2 +-
 include/acpi/actbl3.h         |  18 ++++-
 include/linux/acpi.h          |   6 ++
 13 files changed, 204 insertions(+), 27 deletions(-)
 create mode 100644 arch/riscv/kernel/acpi_numa.c

-- 
2.34.1


