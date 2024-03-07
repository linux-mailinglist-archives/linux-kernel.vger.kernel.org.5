Return-Path: <linux-kernel+bounces-95141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC1E8749B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7BD1F24216
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2365182871;
	Thu,  7 Mar 2024 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/shuUL/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925074262;
	Thu,  7 Mar 2024 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800470; cv=none; b=g4ibSAvVrLdCjc7XBkVBwiYNSisduH7UFDwDtINrVmH26TK3YLfNjyal7LqgT3pHmsJdhTRjCiCMNNeIPn5oaRlyDZyEUjkGro60fX+7B2aO4RbY76C8zI74eENBLRXHn12KFu/iFX0vdWE87EVhqrtxIblzuTS+SaEZuJgG6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800470; c=relaxed/simple;
	bh=xxeOUPpVmvNkXIEHbrtGfOjB9ivL0JFCLXLAfH8o+c4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JMBFQhDSokTAStJ4oP6jHZZNfvjhxyIRrO0eG3GzPVZjeqX9oF9naquLgBT0inSAOiQN9PGjJJEfoL7CYg9nbWqttWE/rmnZg8FQqclBJs5b7c5Is2V1/ZBaT63EmKUDMdP4dpg+tpCLri4x4yxdI365+ax+EUdbwnz2YJGprX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/shuUL/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709800468; x=1741336468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xxeOUPpVmvNkXIEHbrtGfOjB9ivL0JFCLXLAfH8o+c4=;
  b=m/shuUL/Tw1OkGP496tfpiF5EkzXaoKBu53H89R835rtG1HpBA2UzAv0
   mG3MRhGsX9/GlEJTWSG3h9EYPtfDrPswKu8Z+eBeT36fgONH9x0HXWa8K
   +EqI+GgyQBrJ3xhCCXcn8bkWkMrpks/+TGbkay2sHRHdXG7r1hvOSLB3L
   O29lmE0E4E/LJubnc4GjxYupmcryDa4TtSje7xE1KGlePHxD8xEe+00b/
   Q3nBRlXnB2J4Uc3UJPou6bAILWuPs7nYUy0hBp5LvZERqDf5h+uQDdkYX
   uZ9akC8sIQgDyQU1VFSVbu22PdFygAE8jUhaxGS78OE2nssIkO280y7jN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4600264"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="4600264"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 00:34:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="14699530"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orviesa004.jf.intel.com with ESMTP; 07 Mar 2024 00:34:17 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	sunilvl@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Baoquan He <bhe@redhat.com>,
	Evan Green <evan@rivosinc.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	James Morse <james.morse@arm.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2 0/6] Add ACPI NUMA support for RISC-V
Date: Thu,  7 Mar 2024 16:47:52 +0800
Message-Id: <cover.1709780590.git.haibo1.xu@intel.com>
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
ACPI_NUMA
Patch 5/6 remove ARCH depends option in ACPI_NUMA Kconfig which was no
longer needed since all the current architectures that support ACPI would
select ACPI_NUMA by default.
Patch 6/6 add corresponding ACPI_NUMA config for RISC-V Kconfig.

Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next

[1] https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08tX/view?usp=sharing
[2] https://github.com/acpica/acpica/pull/926

Testing:
Since the ACPI AIA/PLIC support patch set is still under upstream review,
hence it is tested using the poll based HVC SBI console and RAM disk.
1) Build latest Qemu with the following patch backported
   https://lore.kernel.org/all/20240129094200.3581037-1-haibo1.xu@intel.com/
   https://github.com/vlsunil/qemu/commit/42bd4eeefd5d4410a68f02d54fee406d8a1269b0

2) Build latest EDK-II
   https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md

3) Build Linux with the following configs enabled
   CONFIG_RISCV_SBI_V01=y
   CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
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
Changes since v1
  - Switch the order of patch 2/4 and 3/4 - Per Sunil's suggestion
  - Add a new patch 4/6 to make some NUMA related parse functions common
    for all the architectures that support ACPI NUMA - Per Sunil's suggestion
  - Add a new patch 5/6 to remove ARCH depends option in ACPI_NUMA
    Kconfig since all the current architectures that support ACPI
    would select ACPI_NUMA by default - Per Arnd and Sunil's suggestion
  - Other minor fix for code format - Per Sunil's comments

Haibo Xu (6):
  ACPICA: SRAT: Add RISC-V RINTC affinity structure
  ACPI: RISCV: Add NUMA support based on SRAT and SLIT
  ACPI: NUMA: Add handler for SRAT RINTC affinity structure
  ACPI: NUMA: Make some NUMA related parse functions common
  ACPI: NUMA: Remove ARCH depends option in ACPI_NUMA Kconfig
  ACPI: RISCV: Enable ACPI based NUMA

 arch/riscv/Kconfig            |   1 +
 arch/riscv/include/asm/acpi.h |  15 +++-
 arch/riscv/kernel/Makefile    |   1 +
 arch/riscv/kernel/acpi.c      |   5 --
 arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c     |   4 +-
 arch/riscv/kernel/smpboot.c   |   2 -
 drivers/acpi/numa/Kconfig     |   1 -
 drivers/acpi/numa/srat.c      |  40 ++++++++---
 include/acpi/actbl3.h         |  18 ++++-
 include/linux/acpi.h          |   6 ++
 11 files changed, 203 insertions(+), 21 deletions(-)
 create mode 100644 arch/riscv/kernel/acpi_numa.c

-- 
2.34.1


