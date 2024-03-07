Return-Path: <linux-kernel+bounces-95144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E496D8749B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B75BB23393
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0A082D6D;
	Thu,  7 Mar 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4ID3A6Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4DE82864;
	Thu,  7 Mar 2024 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800506; cv=none; b=jf0iNH1b6WuS2NJ55vIIJuP7pSLwlaz7sysWE7r3ID34S12MvSCZbDmDAIlRq+b3CgxHpnWRWjI67t2tQ8gJz/Pp9CfYWi16AuB9yRUEI3uTe924H+5py7xWZmQmTjKNNn26AUbTptd/p1gYU/7PhpjOVCOfuxVGn2IFJPIYS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800506; c=relaxed/simple;
	bh=g4tiDkkSZnXc0ReWfyPmSD14iq7asegAk7ookJoxuww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xu0g/TX5Stm3Z6V5tz0hsdGUQIWfR7n+zf9zUaqWhQe28VwJZMhoERTeW8VVCzuhF4CETn0M23TqdrDwV/wEg95BU75u6ev/QxXD+locbKJFBirBfTYjGGSXfHM7W5zHnUOs4BiKp7hnsZa9z5eBGlJC8PrFD72aieyC0FUUeOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4ID3A6Q; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709800504; x=1741336504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g4tiDkkSZnXc0ReWfyPmSD14iq7asegAk7ookJoxuww=;
  b=Z4ID3A6QnkCPwWLRcVLweLoc9i6xrNttPVafCpLq+PVwxlWngGz6hdXf
   Xaq4PEZloeVIhoeqJ5nQQ4/ui4vuuC1Iepv9Fw+DJ8WUQQnf7uGUGvxVy
   vr8KRO5RKW/abcU0cv2VSQdZYJvguAczNYy/vqNXFz7qNMW4bdgT8gYta
   gZq+O6c1usnxf4IVlRGKu/GeERZGiHpaxCYvFZV3ABlM/eM3PTAM3OMOw
   Nm78UiUSFw/cvllJCfVK577FoWIaICMFj8Z3VN5WsimssS+gzEmmj/NED
   bnk9hg+jllpb0ydcaEg9ndAW07gVAjRNO0IZJtH0endJbtbcyhWCf8k71
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4600361"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="4600361"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 00:35:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="14699636"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orviesa004.jf.intel.com with ESMTP; 07 Mar 2024 00:34:54 -0800
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
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Marc Zyngier <maz@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2 2/6] ACPI: RISCV: Add NUMA support based on SRAT and SLIT
Date: Thu,  7 Mar 2024 16:47:54 +0800
Message-Id: <7ca110c59cbb2fb358304a9ba4f9c7cbeb191345.1709780590.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709780590.git.haibo1.xu@intel.com>
References: <cover.1709780590.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add acpi_numa.c file to enable parse NUMA information from
ACPI SRAT and SLIT tables. SRAT table provide CPUs(Hart) and
memory nodes to proximity domain mapping, while SLIT table
provide the distance metrics between proximity domains.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 arch/riscv/include/asm/acpi.h |  15 +++-
 arch/riscv/kernel/Makefile    |   1 +
 arch/riscv/kernel/acpi.c      |   5 --
 arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c     |   4 +-
 arch/riscv/kernel/smpboot.c   |   2 -
 include/linux/acpi.h          |   6 ++
 7 files changed, 154 insertions(+), 10 deletions(-)
 create mode 100644 arch/riscv/kernel/acpi_numa.c

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 7dad0cf9d701..e0a1f84404f3 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -61,11 +61,14 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
 void acpi_init_rintc_map(void);
 struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
-u32 get_acpi_id_for_cpu(int cpu);
+static inline u32 get_acpi_id_for_cpu(int cpu)
+{
+	return acpi_cpu_get_madt_rintc(cpu)->uid;
+}
+
 int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
 
-static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
 void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
 			     u32 *cboz_size, u32 *cbop_size);
 #else
@@ -87,4 +90,12 @@ static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
 
 #endif /* CONFIG_ACPI */
 
+#ifdef CONFIG_ACPI_NUMA
+int acpi_numa_get_nid(unsigned int cpu);
+void acpi_map_cpus_to_nodes(void);
+#else
+static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
+static inline void acpi_map_cpus_to_nodes(void) { }
+#endif /* CONFIG_ACPI_NUMA */
+
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f71910718053..5d3e9cf89b76 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -105,3 +105,4 @@ obj-$(CONFIG_COMPAT)		+= compat_vdso/
 
 obj-$(CONFIG_64BIT)		+= pi/
 obj-$(CONFIG_ACPI)		+= acpi.o
+obj-$(CONFIG_ACPI_NUMA)	+= acpi_numa.o
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index e619edc8b0cc..040bdbfea2b4 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -191,11 +191,6 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
 	return &cpu_madt_rintc[cpu];
 }
 
-u32 get_acpi_id_for_cpu(int cpu)
-{
-	return acpi_cpu_get_madt_rintc(cpu)->uid;
-}
-
 /*
  * __acpi_map_table() will be called before paging_init(), so early_ioremap()
  * or early_memremap() should be called here to for ACPI table mapping.
diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
new file mode 100644
index 000000000000..0231482d6946
--- /dev/null
+++ b/arch/riscv/kernel/acpi_numa.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACPI 6.6 based NUMA setup for RISCV
+ * Lots of code was borrowed from arch/arm64/kernel/acpi_numa.c
+ *
+ * Copyright 2004 Andi Kleen, SuSE Labs.
+ * Copyright (C) 2013-2016, Linaro Ltd.
+ *		Author: Hanjun Guo <hanjun.guo@linaro.org>
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Reads the ACPI SRAT table to figure out what memory belongs to which CPUs.
+ *
+ * Called from acpi_numa_init while reading the SRAT and SLIT tables.
+ * Assumes all memory regions belonging to a single proximity domain
+ * are in one chunk. Holes between them will be included in the node.
+ */
+
+#define pr_fmt(fmt) "ACPI: NUMA: " fmt
+
+#include <linux/acpi.h>
+#include <linux/bitmap.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/memblock.h>
+#include <linux/mmzone.h>
+#include <linux/module.h>
+#include <linux/topology.h>
+
+#include <asm/numa.h>
+
+static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
+
+int __init acpi_numa_get_nid(unsigned int cpu)
+{
+	return acpi_early_node_map[cpu];
+}
+
+static inline int get_cpu_for_acpi_id(u32 uid)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+		if (uid == get_acpi_id_for_cpu(cpu))
+			return cpu;
+
+	return -EINVAL;
+}
+
+static int __init acpi_parse_rintc_pxm(union acpi_subtable_headers *header,
+				       const unsigned long end)
+{
+	struct acpi_srat_rintc_affinity *pa;
+	int cpu, pxm, node;
+
+	if (srat_disabled())
+		return -EINVAL;
+
+	pa = (struct acpi_srat_rintc_affinity *)header;
+	if (!pa)
+		return -EINVAL;
+
+	if (!(pa->flags & ACPI_SRAT_RINTC_ENABLED))
+		return 0;
+
+	pxm = pa->proximity_domain;
+	node = pxm_to_node(pxm);
+
+	/*
+	 * If we can't map the UID to a logical cpu this
+	 * means that the UID is not part of possible cpus
+	 * so we do not need a NUMA mapping for it, skip
+	 * the SRAT entry and keep parsing.
+	 */
+	cpu = get_cpu_for_acpi_id(pa->acpi_processor_uid);
+	if (cpu < 0)
+		return 0;
+
+	acpi_early_node_map[cpu] = node;
+	pr_info("SRAT: PXM %d -> HARTID 0x%lx -> Node %d\n", pxm,
+		cpuid_to_hartid_map(cpu), node);
+
+	return 0;
+}
+
+void __init acpi_map_cpus_to_nodes(void)
+{
+	int i;
+
+	/*
+	 * In ACPI, SMP and CPU NUMA information is provided in separate
+	 * static tables, namely the MADT and the SRAT.
+	 *
+	 * Thus, it is simpler to first create the cpu logical map through
+	 * an MADT walk and then map the logical cpus to their node ids
+	 * as separate steps.
+	 */
+	acpi_table_parse_entries(ACPI_SIG_SRAT, sizeof(struct acpi_table_srat),
+				 ACPI_SRAT_TYPE_RINTC_AFFINITY, acpi_parse_rintc_pxm, 0);
+
+	for (i = 0; i < nr_cpu_ids; i++)
+		early_map_cpu_to_node(i, acpi_numa_get_nid(i));
+}
+
+/* Callback for Proximity Domain -> logical node ID mapping */
+void __init acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa)
+{
+	int pxm, node;
+
+	if (srat_disabled())
+		return;
+
+	if (pa->header.length < sizeof(struct acpi_srat_rintc_affinity)) {
+		pr_err("SRAT: Invalid SRAT header length: %d\n", pa->header.length);
+		bad_srat();
+		return;
+	}
+
+	if (!(pa->flags & ACPI_SRAT_RINTC_ENABLED))
+		return;
+
+	pxm = pa->proximity_domain;
+	node = acpi_map_pxm_to_node(pxm);
+
+	if (node == NUMA_NO_NODE) {
+		pr_err("SRAT: Too many proximity domains %d\n", pxm);
+		bad_srat();
+		return;
+	}
+
+	node_set(node, numa_nodes_parsed);
+}
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 4f73c0ae44b2..a2cde65b69e9 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -281,8 +281,10 @@ void __init setup_arch(char **cmdline_p)
 	setup_smp();
 #endif
 
-	if (!acpi_disabled)
+	if (!acpi_disabled) {
 		acpi_init_rintc_map();
+		acpi_map_cpus_to_nodes();
+	}
 
 	riscv_init_cbo_blocksizes();
 	riscv_fill_hwcap();
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index cfbe4b840d42..81a2aa77680c 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -100,7 +100,6 @@ static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const un
 	if (hart == cpuid_to_hartid_map(0)) {
 		BUG_ON(found_boot_cpu);
 		found_boot_cpu = true;
-		early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
 		return 0;
 	}
 
@@ -110,7 +109,6 @@ static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const un
 	}
 
 	cpuid_to_hartid_map(cpu_count) = hart;
-	early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count));
 	cpu_count++;
 
 	return 0;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b7165e52b3c6..f74c62956e07 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -269,6 +269,12 @@ acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
 
 int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
 
+#ifdef CONFIG_RISCV
+void acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa);
+#else
+static inline void acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa) { }
+#endif
+
 #ifndef PHYS_CPUID_INVALID
 typedef u32 phys_cpuid_t;
 #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
-- 
2.34.1


