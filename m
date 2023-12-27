Return-Path: <linux-kernel+bounces-12008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F1F81EECD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589F1282BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637ED44C87;
	Wed, 27 Dec 2023 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Bgb1x0KF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2059.outbound.protection.outlook.com [40.92.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43ABA2F;
	Wed, 27 Dec 2023 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBmr0qr+2Yaf5fUTXKFZsbo9d5vzVmoyLPdDaRFTnMGwMZ171Tksjw3W26iD7q5yecUv+oAeCfCl6VgnuazqH3DTLkxv9aOQ9Tlecr3kx3Z1+IJU9T9AQSK8uUCS1smuaXIhtCjjjvWUGOZdLeWNdvq7Ha4h2W/mt3VDgecoKJp4ToxcZ6NuydNuKkBXRSWnK4BkRxIY/dIOTX0MirPYErOwaqAkhH466XTosjW/VGSoK1zq6QdnTeLtOs2rfiyv/+iAedtcTr7Q3lp4wNCgFesP1T0+Zs9UVd5d6ZE+vQ4kKgrJle71U9V5igBXlQ7g/y1cwhhipOfD7UKmqRVyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn5aAYiWax9HqpIu7OJhOXaeUI3tW4J2QEoQBzeIQ2I=;
 b=lDHiHTzuuPD1+pQ301H+SlBp9Q94iPLNyRdZS41v3jNfTKpHXvya62U1w+g4yMDpWASJPk4ImO1D6RChhrZ5iEtNkwEFvI03sqjrtrGbXuadDxhAQLUDIvKtmahHFDbkK/2CXxcKPyBg0Z54G1Xjk4SV8QK877pdALUZmtejL8aAG0Xw8GuI1aTiNKAXeLPKvHAGta4t11YLEsZVJYUA5wCvOwr7dO7kgUpAwob2prw04uE0zEUNYAnlidwEjJaaKzJxMp1c6sULVD7KCO4ZYoYOrJRV6Uo1O4hAlVs7PspC0Uu4TSnZu4qeSjoRHDgSX7vq1pIHpj/VIWNKBqhmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn5aAYiWax9HqpIu7OJhOXaeUI3tW4J2QEoQBzeIQ2I=;
 b=Bgb1x0KF0e2IKbybBxq3lLKv4z2vw1Y320ZTQ64QiUdfSNnS10u/yLUm4kG1qLy8xeK3aY4u+7S6t0zcC1ilFxl7BzGbMTKavvNxzcxQSP9g99kPwQu64a/nQLG1DTTMDWzKLzQC31xuk0D/Pt50v1V+R2vFaLs7LAkzgreHTWntYO6LA4+TyirHGCcciRy6t6AJ8ytJ5gC5fzlvqkf/Fgr2Ncp/4Pf0vfikHiTsjTEuDVMz1crtm/fyzLgTATJTYHBF9KpVdznq5jpOXzLW7FNI/ZiWW9MMD81G68gHRv0lBZdb38/eBDeGkSFkkxk9AiF87RnaaYv9sZWemv9X0g==
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
 by SJ2PR84MB3537.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:569::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 12:31:23 +0000
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6]) by MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6%4]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 12:31:23 +0000
From: Youling Tang <youling.tang@outlook.com>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 1/2] LoongArch: use generic interface to support crashkernel=X,[high,low]
Date: Wed, 27 Dec 2023 20:24:52 +0800
Message-ID:
 <MW4PR84MB3145344537A6C6629398DF7C819FA@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [df25cKgz0g6rsxIAaxlIqDKQjFsv8oqpuePcJNjM1cE=]
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
X-Microsoft-Original-Message-ID:
 <20231227122453.8108-1-youling.tang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR84MB3145:EE_|SJ2PR84MB3537:EE_
X-MS-Office365-Filtering-Correlation-Id: 35adfb2d-bc55-4f15-335a-08dc06d7bc3b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aE+jANFExsd3cVbbeqeeJ7nwBHnYVjoCLMAeHjk9rrYdLeAgrPVEI5DoYT5X4soVmuGk5GXc+4jauyjmi+9uOyA4AM74aI4C3RbujswlY8Gbh7yoGYrtzRagFvfeyoFckKqRZsbXQYILmIJUBO+1lpHgPh3iwXcIXYh6oP4erNwo+nKhyXfmxHiaRCok2GkG2Qq1IGmpQ70+jL9vLwW+/CLdpcP56BMrx6rXmkwH5A9N7JZf9LQtb5vFO9DK/C/l0yaPqWKqCe2yrirBWUoRSXcI7lTP+3WaTz3k8DOBkwd8/ZYuHimuQAuPxPr2rOt9zH/kCJAR+UHNSE4/skLcG1qoZ/NIF5ZBdKcPuXXBts4BAKbNuH3iJV3ZarJCjsv6mEbo6SIShjNgiEceFAxjX7M/QmLELOsiN4HLC9elXsF9pdVwWm7b/Q4WUNkPTizprq4SJ0tFzxifjiQPWxP2Vh4kgURMZZg7gyN3l8RVsWfPTcfYyiM/1Q4hJmyRJeaHgzzH/sYEgGyc4o3C3MoG/izZaqe1Pt7uhgcYQquZFi6SbBwAkH1i03H72eDrYtI8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5PO5ylP8DcK71ngdAmUyG7I6qOMt/NoxFJnOAk+81SVmOPXIcne3EqbL7VnJ?=
 =?us-ascii?Q?brEQBfQ79EfQyn6+g4dvB2MrDpIStE2YqmOZ8PEW/oNFJJmt/gzP32B31WeL?=
 =?us-ascii?Q?A7PXp9O7fsFuqrIOZ5srPKxz6aO4LPjbxXX0+wDuJtyZMvlFx+UWWIuBvu8O?=
 =?us-ascii?Q?siZYvFTLrhlqE/t4cDcz0TltM7D9rsTynYm2RUMSJ4P7b54/U856yEMT/UBb?=
 =?us-ascii?Q?tkEhMLsUps8eFk02U+uOxvOlMthfak1czDZHJ6RR30U+pOeKJgL0or9Vzawl?=
 =?us-ascii?Q?wE2NgVAZypqKstJ0Uvj2PZARc/m9+xoi5yFd4YtrgGdlxTQIN8CgTtmBfPJc?=
 =?us-ascii?Q?vmseaTs06n/QJ77990WIxjWKPC9H71HOLqs44ccM9TUorEW/4zI+HqNm67s7?=
 =?us-ascii?Q?rD/D9GB1P0OrRP/wpPSrKo5/jZW8k8cAXjTUcEEXyxr8MJyOJx+brtE//oOY?=
 =?us-ascii?Q?tLJwyGg27oF30/5Zm/YpnLVYpReNU2GqfCRA8LNqiqOqao/BD76pqTDv9drn?=
 =?us-ascii?Q?uZGT8+K3ukzm5H3UoTuQb04uyrtIjNcTgVq8V35hroB48i6I4vNCBFAk4tJA?=
 =?us-ascii?Q?6BXU8KRlqgxzOYmJYdA0k4EosBSnnQM2Ie9QSjRPHR4nFjrybi2xcrk7ESur?=
 =?us-ascii?Q?vt15Dp0/KRsrex565jljVeUbhJHiicMkbVLwkRfJiBqbxjk6gH8WrPsgLm/L?=
 =?us-ascii?Q?/6ky9K9zM6FNPPj0cMD47gL0ZwMLK620ACp1xVGIAyCi0nlTe4SlZAk9z4R/?=
 =?us-ascii?Q?P/dRTREALUPJYrtXtq+wam+vh1EtslCLr+lPCmRfa2MeB8Jqu2oDpaiKG+c2?=
 =?us-ascii?Q?WScngMe/3pfOYM71K607+gYe0yl4evnoO/g94qKdfSHvPWV2ueJDl+vmR6Qb?=
 =?us-ascii?Q?v7mK+rxGEJxEi/f3nTWRiZzZwZgXdUoiWORTwD4InhbSe5P13HPyti9IxvsL?=
 =?us-ascii?Q?eUPaku1avK4SuQXIoOL8LE39hF3br6QpmOOKja8DwFrUbn5SLA/dpz4wU1dS?=
 =?us-ascii?Q?yxdY9b+RCIx4LYsAItpEOwNfG416ORWsZQUvJEcBBIhPBwtByY+TFYU8lDaA?=
 =?us-ascii?Q?pSzAC1RhvQQZikuvdgPffqI3src3c6nVVp75Cfu1MHCiggm++fW4/nrCWJ4X?=
 =?us-ascii?Q?VZN59NkLpm08lTin+ipw2a+oLlnbjeUGjM9TPmT5cNH8nb6mUS7Se9kf6G0D?=
 =?us-ascii?Q?Obwi4QfbpnY9GeYxqQ4q+ciaxE8Jn2LKO6ZEPRwr3NLW86PGwRAj2p0YCTI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35adfb2d-bc55-4f15-335a-08dc06d7bc3b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 12:31:22.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR84MB3537

From: Youling Tang <tangyouling@kylinos.cn>

LoongArch already supports two crashkernel regions in kexec-tools, so we
can directly use the common interface to support crashkernel=X,[hign,low]
after commit 0ab97169aa05("crash_core: add generic function to do reservation").

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

Recommended usage in general:
1) In the case of small memory: crashkernel=512M
2) In the case of large memory: crashkernel=1024M,high crashkernel=128M,low

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
v2:
Submit information and format adjustments.

 arch/loongarch/Kconfig                  |  3 ++
 arch/loongarch/include/asm/crash_core.h | 11 ++++++
 arch/loongarch/kernel/setup.c           | 46 ++++++-------------------
 3 files changed, 25 insertions(+), 35 deletions(-)
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
index d183a745fb85..189cd9575758 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -252,38 +252,23 @@ static void __init arch_reserve_vmcore(void)
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
+				&crash_size, &crash_base, &low_size, &high);
+	if (ret)
 		return;
-	}
 
-	crashk_res.start = crash_base;
-	crashk_res.end	 = crash_base + crash_size - 1;
-#endif
+	reserve_crashkernel_generic(cmdline, crash_size, crash_base, low_size, high);
 }
 
 static void __init fdt_setup(void)
@@ -357,7 +342,7 @@ static void __init bootcmdline_init(char **cmdline_p)
 void __init platform_init(void)
 {
 	arch_reserve_vmcore();
-	arch_parse_crashkernel();
+	arch_reserve_crashkernel();
 
 #ifdef CONFIG_ACPI_TABLE_UPGRADE
 	acpi_table_upgrade();
@@ -467,15 +452,6 @@ static void __init resource_init(void)
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


