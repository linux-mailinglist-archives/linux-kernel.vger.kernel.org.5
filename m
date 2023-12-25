Return-Path: <linux-kernel+bounces-11081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2834C81E117
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E51B2173C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C22F524CC;
	Mon, 25 Dec 2023 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="V/4nuWjW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2104.outbound.protection.outlook.com [40.92.40.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF62524C6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwDH4XadHdrZXZqYUP6oFK1/zVhMNHzdToyvL/W8Cl011mb2wzaJsBXP+BgAB5+hlG45MruALP3OqCd8VtHE3uCAXSYfVDVwoEMgb1zU5+jW1VBI9mDeu8DwaqJOiYCMlwoh7csXVM5kfgOeTjkIpgz+qM78AFDBN5M0QH04yAFvm+1qUHqhEcr0cUFQkp6g2+ERZ0r357G7BLXaQjzc7039opUAhj/HDwtmI0PKAjhWhJTCuTdtTjLCE1lyvC5y0cFrSEJnMXH0EMu5qCtg2+BbWrHLP+yFSIhOoYNwO5W+WotSXGvPz0u0doaXA5SZDdc3EKkhFsvbbygnwsNddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgwvmDzP4UrEXUl9Pcfk1MlYDgLCd1p7r75WcLtWmE8=;
 b=dmX/p7XnogihuoByFW5lGr65dPOz/Yccmg/XVj3U7sxyqmwxT5SJcJIB8jShUyOihDcw/tkE3IF04xXL7I4+15VskQfwW4ZIQJoKYU9V7ctVT9RSeNRFbo1E39jtnEslisAsZMwwQ8isk5a8qbR99RqTZ0OwtcokPBiauOe3scWAbUTxgkqE9oKPP7Ng7X3iyxFV8V6XSPvNWqTziOxZaa1tqys/NWsNbLwyP0SlvTLqE3FeeznDgNyuuhDMs2Klj1R01+ktMy2045Lrv7MKbsV2vuBzcj3rLsxCN2wZgctkVBDsgLGuwlWb5urRlPkw+hG1tiGqqAQTdgM0Za77wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgwvmDzP4UrEXUl9Pcfk1MlYDgLCd1p7r75WcLtWmE8=;
 b=V/4nuWjWRxPIZH/Ri039BFTmlW+K686kkwlH4wlLfLEDB22ktOjk0DudYoFtNanEzNoFbHVW+6BZi9ZiZJ9IpxmgjJRySxaWVhTSE3DwYN850MCsI2wZ9vgLz3VVe/uzBhfmk+p0sYE2t+GfaK9UpIWi8t1r4R3vy6NBSD+rmHc+WTby8TMgqoTgA1eWx4+OAkD7aMB3HQH4I/khzxdI3vsm5Kv1/Kfy+SV2mcedldNCdiufSudDB70GMukhfpsThCl0xYhVpZMsDkDxf3iTSlKABGcc8Bz7IsGFJAoVzFhovVqwTV2zRw4Mi4YieCnlhFleCq5E6nrtJOZQ3l9ozQ==
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
 by MW4PR84MB1683.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 14:18:08 +0000
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6]) by MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6%4]) with mapi id 15.20.7113.027; Mon, 25 Dec 2023
 14:18:08 +0000
From: Youling Tang <youling.tang@outlook.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] LoongArch: use generic interface to support crashkernel=X,[high,low]
Date: Mon, 25 Dec 2023 22:11:46 +0800
Message-ID:
 <MW4PR84MB3145311E8DE893E89119FAFA8199A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [wPex+47fhw5IOJ8aI89/apjnYoOCM6Htndg2mcIMJ8Y=]
X-ClientProxiedBy: SG2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:54::19) To MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:303:1e1::10)
X-Microsoft-Original-Message-ID:
 <20231225141146.219263-1-youling.tang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR84MB3145:EE_|MW4PR84MB1683:EE_
X-MS-Office365-Filtering-Correlation-Id: 5784b78c-8b3c-47b7-a968-08dc05545164
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iPYqP4Kv93t+XEuEHFs2OkCf2J0MIaD5ebbqaXl4moLdSnhGwKyxWVxmSaJXDpM+t+NAphv1WOfFMvI3M/uUWc4a2uCZdAFI6Yyp7Y2o7ZoYwtnc8F8WuUA+ugfF31WxB+EHiJD6vDKKLh2f3QZkCiGi1NnxMYn6AUwm+1ReWM1jVXv2TRm+/8hMRqlEV/uzMaATmVQdUaFtEMxhbyifYlTj+T5rD4trOrEJDR9Mb/Eu7DzjPXpOVp2KtMY6ImVoL9Qf98G4hR7/6FFSjIPlZOSYumOdzs+rauPzMXgoXaqzgi55TCRhDvmLYaIJFt6ZqGjzHqOhJ6QFJ/mrdwpEkdI3qUzmk7nujXEaYYsVUDSiCaljhw32RH4fxbkLVAJRLehjuNURLgQkZgNnmJwmLhwoCkMr8YfdS2QiDauQkHzeXLBkvPCAHu1n+mHtlStsWlGLKhuIkrh6y/Ry392sc9VW3VlUxLvL5QEuWu8y0q4xa3Z3+vjo7Gdy6X9VGRkALJN/u94b/Tcr+In/CJfuzLGeSiaYSVr8ZEWE68DP2muo6ZZRR9vC9PexL5UV7j7W
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4WucMQcoXa3lj80kebNkYf6Mp8ICtooAjdetEqFu1pPqzBiez4bc9v5XBP6l?=
 =?us-ascii?Q?gKHsIeAOA1msRP1G7vS/Jwg0HA4IWMnLgsdj+yV6p+/aZFqXDssNE5TlsUyB?=
 =?us-ascii?Q?UdTNhDF3XMMrJJcojmT1KSeY5CIEv14rqr6n5m4agBmux5h8QSIKuvPL38bB?=
 =?us-ascii?Q?IJOsOq/r2YTbopZARC7q2V5xdY69Ma4n2pZ+TvzlF6Mpy0QAkfF+PbFKpb3c?=
 =?us-ascii?Q?1T98LJjqTBI8wAYeGQA3TT71rjAClCeRyCXpIWGlKxI33NRT8+zpHE8p6rV6?=
 =?us-ascii?Q?7R9/9th9CgptQnzflIlqPNQrG+Yg0Wu5myKoi8q8LlaCDxZQgvT/Tea/RQXa?=
 =?us-ascii?Q?c72fPJ0rAHAZs0vYZYR4VmqHFCxwGpZXNUbhSeeQNOGCLpDS+azL+Ip1KMA0?=
 =?us-ascii?Q?9Jo8xWKqzoDBMLPLUchWuXgtEMTehDcRX9UJide+7vNnb7wAgmSakdeGbBRq?=
 =?us-ascii?Q?ASzSD8CDFvEjmsVVp8jqZbU1oLTISuP6bge011hXpI2e+FuS9tM14UsOJQQk?=
 =?us-ascii?Q?2CGCBRT8kvPWAVHqbl81KICM4OwOqwQDX29RfTkVMhfN4MjcuTAItsRDWbOb?=
 =?us-ascii?Q?cMZ8qlgfCNF0P1vP0yROOUkYA3A2zG1anoLKS8/KBCTWOQE5ovonDAXMOgAv?=
 =?us-ascii?Q?hAnj8kY4SWuj99vDZ9o7AbAmIMIKv/vsfXX/rdldFB7WEqF8dby9TUWV5G07?=
 =?us-ascii?Q?cmJi5lQiqWGz7ZKvKDO0TPMir/qx7oktXszrSS5FWKAiDKyEPUei1dx3A08v?=
 =?us-ascii?Q?OpUPXAC5eWZL7iXzYpTyBC6NjDUI2YQtK0FZLVrbL3FV7UoNMgiw9s0x7mEf?=
 =?us-ascii?Q?CahXYxFMwzPnpMf6L4+4Q0TFCIFtVCzcz3Fg4K7qrZTPb2eYNa3e1MnqScQ0?=
 =?us-ascii?Q?cD+GrbZ2HvPQgYOS2S5VSyCPXO6reLsAyh49mWaIooAI56vImWOQW0ib5vle?=
 =?us-ascii?Q?NOHG7CtYq4yZCkbrJDNmIY8Rzw3qZChsmNvf3hmw+RrSivfm+63QLLy2of2n?=
 =?us-ascii?Q?sPJFN6o/QbImyhHSJkqPrIHv1Q6fEVZBbMZQ0FeEs7NGv72G7r69C/WPaSf4?=
 =?us-ascii?Q?gzzgTUg4fcnLfEsYrRjcn2TKKRhaXZoy2LdZmSIseHPXpOxsbLGlMpmhyw0+?=
 =?us-ascii?Q?3h6qH9Gaqb3i00PddIMundL1E2B2bPFUxVjKAofH95VykH/zLpkqDltvZzVA?=
 =?us-ascii?Q?aLT5Zto/aOafspUBhCXwu+RrLCAx+dqYcq3II7JzYkn/ZC2TOLsxMAktBf4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5784b78c-8b3c-47b7-a968-08dc05545164
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 14:18:08.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1683

From: Youling Tang <tangyouling@kylinos.cn>

LoongArch already supports two crashkernel regions in kexec-tools, so we
can directly use the common interface to support crashkernel=X,[hign,low].

With the help of newly changed function parse_crashkernel() and generic
reserve_crashkernel_generic(), crashkernel reservation can be simplified
by steps:

1) Add a new header file <asm/crash_core.h>, and define CRASH_ALIGN,
   CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX and
   DEFAULT_CRASH_KERNEL_LOW_SIZE in <asm/crash_core.h>;

2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
   reserve_crashkernel_generic();

3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
   arch/loongarch/Kconfig.

One can reserve the crash kernel from high memory above DMA zone range
by explicitly passing "crashkernel=X,high"; or reserve a memory range
below 4G with "crashkernel=X,low". Besides, there are few rules need
to take notice:

1) "crashkernel=X,[high,low]" will be ignored if "crashkernel=size"
   is specified.
2) "crashkernel=X,low" is valid only when "crashkernel=X,high" is passed
   and there is enough memory to be allocated under 4G.
3) When allocating crashkernel above 4G and no "crashkernel=X,low" is
   specified, a 128M low memory will be allocated automatically for
   swiotlb bounce buffer.
See Documentation/admin-guide/kernel-parameters.txt for more information.

Following test cases have been performed as expected:
1) crashkernel=256M                          //low=256M
2) crashkernel=1G                            //low=1G
3) crashkernel=4G                            //high=4G, low=128M(default)
4) crashkernel=4G crashkernel=256M,high      //high=4G, low=128M(default), high is ignored
5) crashkernel=4G crashkernel=256M,low       //high=4G, low=128M(default), low is ignored
6) crashkernel=4G,high                       //high=4G, low=128M(default)
7) crashkernel=256M,low                      //low=0M, invalid
8) crashkernel=4G,high crashkernel=256M,low  //high=4G, low=256M
9) crashkernel=4G,high crashkernel=4G,low    //high=0M, low=0M, invalid
10) crashkernel=512M@2560M                   //low=512M
11) crashkernel=1G,high crashkernel=0M,low   //high=1G, low=0M

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/Kconfig                  |  3 ++
 arch/loongarch/include/asm/crash_core.h | 11 ++++++
 arch/loongarch/kernel/setup.c           | 48 +++++++------------------
 3 files changed, 27 insertions(+), 35 deletions(-)
 create mode 100644 arch/loongarch/include/asm/crash_core.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ee123820a476..02060b2ac3f2 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -575,6 +575,9 @@ config ARCH_SELECTS_CRASH_DUMP
 	depends on CRASH_DUMP
 	select RELOCATABLE
 
+config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	def_bool CRASH_CORE
+
 config RELOCATABLE
 	bool "Relocatable kernel"
 	help
diff --git a/arch/loongarch/include/asm/crash_core.h b/arch/loongarch/include/asm/crash_core.h
new file mode 100644
index 000000000000..1f7040d8ed0f
--- /dev/null
+++ b/arch/loongarch/include/asm/crash_core.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LOONGARCH_CRASH_CORE_H
+#define _LOONGARCH_CRASH_CORE_H
+
+#define CRASH_ALIGN			SZ_2M
+
+#define CRASH_ADDR_LOW_MAX		SZ_4G
+#define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
+
+extern phys_addr_t memblock_end_of_DRAM(void);
+#endif
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index d183a745fb85..2a69a36419da 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -252,38 +252,25 @@ static void __init arch_reserve_vmcore(void)
 #endif
 }
 
-/* 2MB alignment for crash kernel regions */
-#define CRASH_ALIGN	SZ_2M
-#define CRASH_ADDR_MAX	SZ_4G
-
-static void __init arch_parse_crashkernel(void)
+static void __init arch_reserve_crashkernel(void)
 {
-#ifdef CONFIG_KEXEC
-	int ret;
-	unsigned long long total_mem;
+	unsigned long long low_size = 0;
 	unsigned long long crash_base, crash_size;
+	char *cmdline = boot_command_line;
+	bool high = false;
+	int ret;
 
-	total_mem = memblock_phys_mem_size();
-	ret = parse_crashkernel(boot_command_line, total_mem,
-				&crash_size, &crash_base,
-				NULL, NULL);
-	if (ret < 0 || crash_size <= 0)
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
-	if (crash_base <= 0) {
-		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, CRASH_ALIGN, CRASH_ADDR_MAX);
-		if (!crash_base) {
-			pr_warn("crashkernel reservation failed - No suitable area found.\n");
-			return;
-		}
-	} else if (!memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base, crash_base + crash_size)) {
-		pr_warn("Invalid memory region reserved for crash kernel\n");
+	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
+				&crash_size, &crash_base,
+				&low_size, &high);
+	if (ret)
 		return;
-	}
 
-	crashk_res.start = crash_base;
-	crashk_res.end	 = crash_base + crash_size - 1;
-#endif
+	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
+				    low_size, high);
 }
 
 static void __init fdt_setup(void)
@@ -357,7 +344,7 @@ static void __init bootcmdline_init(char **cmdline_p)
 void __init platform_init(void)
 {
 	arch_reserve_vmcore();
-	arch_parse_crashkernel();
+	arch_reserve_crashkernel();
 
 #ifdef CONFIG_ACPI_TABLE_UPGRADE
 	acpi_table_upgrade();
@@ -467,15 +454,6 @@ static void __init resource_init(void)
 		request_resource(res, &data_resource);
 		request_resource(res, &bss_resource);
 	}
-
-#ifdef CONFIG_KEXEC
-	if (crashk_res.start < crashk_res.end) {
-		insert_resource(&iomem_resource, &crashk_res);
-		pr_info("Reserving %ldMB of memory at %ldMB for crashkernel\n",
-			(unsigned long)((crashk_res.end - crashk_res.start + 1) >> 20),
-			(unsigned long)(crashk_res.start  >> 20));
-	}
-#endif
 }
 
 static int __init add_legacy_isa_io(struct fwnode_handle *fwnode,
-- 
2.40.0


