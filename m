Return-Path: <linux-kernel+bounces-155802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4881D8AF74C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DF01F22F66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6773B1411E6;
	Tue, 23 Apr 2024 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="x/PEBGER"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B33140366;
	Tue, 23 Apr 2024 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900393; cv=none; b=lnNCRdscye8u5xd8dpxn7q431jq+triCvzS4dLBsUGZhLAlR1/22rcW79xk5m+vkdAN2IM1v2G86CH2uWEA+YsPzwOrmDXjYM/tFSl9TLDwDXXHzuJgVpnPrqwaYsBfN8di7lR+5FFVd9S7+mIqLUO4On7++kapbuPGF+HTQq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900393; c=relaxed/simple;
	bh=O2BhskUNnY43GNBMu2RcavXjFpnibECYg3uGGwSw5Ls=;
	h=Message-Id:To:Cc:From:Date:Subject; b=TXl6NYJBWbH0ZvjjsI85LKp7Sc5IHr6RT5ElgHohOzfyMZJUZW8UvQnbN+bq00qY2Wogh1c5pJqxtApAeePCiwEra6a//usYLFDLbvoOlkOsU6r0toZxPwBh+cLr/xT+gMwcwhEO6RuUvmg7YVEoMf6spwMhzUEqNmppdnoa0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=fail (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=x/PEBGER reason="signature verification failed"; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NG81KG029744;
	Tue, 23 Apr 2024 19:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	message-id:to:cc:from:date:subject:reply-to; s=DKIM202306; bh=Tj
	KYshhFgS8/6h1q9Dn2awb/N9VU51xlpX+byhETvx4=; b=x/PEBGERLdCOhYY8Zn
	2iwhC+k6ggvNXdk1OWTjdqk1cozt9KBVd5Ox5l0nBRDLq3ytsE/5IJ+y014/YIMo
	f6N40BmXjvc1laNLUSJpnCna7FpkBHMFNoZpt02C6Lh/4YchOGeJ2YYXAnnp8ztK
	fkZWxxL07UfR8g4wTq5Syz7Zm8D3I2T/5KyEAQaM61TDzEeHgj8lN/V299duyTeM
	2D4f/2XSio9kkDhDDt6S1Y4wxr7QqP8dvZcSGlGh1j+5K4Gtbe7PPTmDSjhh87Ny
	mBTJpbHijfo8LxL8dt6sMM/0mZu8tFmgcdyy8YjipSh51XNHZcKsuFYnKn0GYbJR
	bteQ==
Received: from ilclpfpp02.lenovo.com ([144.188.128.68])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3xpg860bt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 19:26:09 +0000 (GMT)
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp02.lenovo.com (Postfix) with ESMTPS id 4VPBtS1tZnzbrVX;
	Tue, 23 Apr 2024 19:26:08 +0000 (UTC)
Received: from ilclasset02.mot.com (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4VPBtS0Y7tz2WV3m;
	Tue, 23 Apr 2024 19:26:08 +0000 (UTC)
Message-Id: <20240423142307.495726312-1-mbland@motorola.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Maxwell Bland <mbland@motorola.com>
	Jonathan Corbet" <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>, Maxwell Bland <mbland@motorola.com>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
From: Maxwell Bland <mbland@motorola.com>
Date: Tue, 23 Apr 2024 14:23:07 -0500
Subject: [PATCH v2] ptdump: add non-leaf descriptor support
Reply-To: <20240423110435.c84aa2a0e4cb5a17fb1ab18d@linux-foundation.org>
X-Proofpoint-GUID: EZlciEB9WPDYgKIgV7gHNiy0fHTgQPTg
X-Proofpoint-ORIG-GUID: EZlciEB9WPDYgKIgV7gHNiy0fHTgQPTg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_16,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404230045
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add an optional note_non_leaf parameter to ptdump, causing note_page to
be called on non-leaf descriptors. Implement this functionality on arm64
by printing table descriptors along with table-specific permission sets.

For arm64, break (1) the uniform number of columns for each descriptor,
and (2) the coalescing of large PTE regions, which are now split up by
PMD. This is a "good" thing since it makes the behavior and protection
bits set on page tables, such as PXNTable, more explicit.

Examples (spaces and last attribute condensed)
Before:
0xffff008440210000-0xffff008440400000 1984K PTE ro NX SHD AF NG UXN M...
0xffff008440400000-0xffff008441c00000 24M PMD ro NX SHD AF NG BLK UXN M...
0xffff008441c00000-0xffff008441dc0000 1792K PTE ro NX SHD AF NG UXN M...
0xffff008441dc0000-0xffff00844317b000 20204K PTE RW NX SHD AF NG UXN M...

After:
0xffff0fb640200000-0xffff0fb640400000 2M PMD TBL RW x NXTbl UXNTbl M...
0xffff0fb640200000-0xffff0fb640210000 64K PTE RW NX SHD AF NG UXN M...
0xffff0fb640210000-0xffff0fb640400000 1984K PTE ro NX SHD AF NG UXN M...
0xffff0fb640400000-0xffff0fb641c00000 24M PMD BLK ro SHD AF NG NX UXN ...
0xffff0fb641c00000-0xffff0fb641e00000 2M PMD TBL RW x NXTbl UXNTbl M...
0xffff0fb641c00000-0xffff0fb641dc0000 1792K PTE ro NX SHD AF NG UXN M...
0xffff0fb641dc0000-0xffff0fb641e00000 256K PTE RW NX SHD AF NG UXN ME...

Full dumps available at
github.com/maxwell-bland/linux-patch-data/tree/main/ptdump-non-leaf

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---

Dear Andrew,

> I was going to queue this while awaiting acks from arm people, but
> there's a large reject in Documentation/arch/arm64/ptdump.rst.

Ack, thank you and apologies, if I understand correctly, you are seeing
this issue on linux-next/akpm, I was not familiar with the submission
process. I was not able to reproduce on mm-unstable, linux-next/master,
mm/master, ... This reply (v2 commit) is cherry-picked to
linux-next/akpm.

A diff with linux-next/master for my original submission only returns:

  611c611                                                   
  < base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8   
  > base-commit: 7d4768ae56014b3db93423e84f8794f173ec5c91   

Regards,
Maxwell Bland

 Documentation/arch/arm64/ptdump.rst | 125 ++++++++++++++++
 arch/arm64/mm/ptdump.c              | 224 +++++++++++++++++++++++++---
 include/linux/ptdump.h              |   1 +
 mm/ptdump.c                         |  13 ++
 4 files changed, 343 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/arch/arm64/ptdump.rst

diff --git a/Documentation/arch/arm64/ptdump.rst b/Documentation/arch/arm64/ptdump.rst
new file mode 100644
index 000000000000..0f38b92fd839
--- /dev/null
+++ b/Documentation/arch/arm64/ptdump.rst
@@ -0,0 +1,125 @@
+======================
+Kernel page table dump
+======================
+
+ptdump is a debugfs interface that provides a detailed dump of the kernel page
+tables. It offers a comprehensive overview of the kernel virtual memory layout
+as well as the attributes associated with the various regions in a
+human-readable format. It is useful to dump the kernel page tables to verify
+permissions and memory types. Examining the page table entries and permissions
+helps identify potential security vulnerabilities such as mappings with overly
+permissive access rights or improper memory protections.
+
+Memory hotplug allows dynamic expansion or contraction of available memory
+without requiring a system reboot. To maintain the consistency and integrity of
+the memory management data structures, arm64 makes use of the
+mem_hotplug_lock semaphore in write mode. Additionally, in read mode,
+mem_hotplug_lock supports an efficient implementation of
+get_online_mems() and put_online_mems(). These protect the offlining of
+memory being accessed by the ptdump code.
+
+In order to dump the kernel page tables, enable the following configurations
+and mount debugfs::
+
+ CONFIG_GENERIC_PTDUMP=y
+ CONFIG_PTDUMP_CORE=y
+ CONFIG_PTDUMP_DEBUGFS=y
+
+ mount -t debugfs nodev /sys/kernel/debug
+ cat /sys/kernel/debug/kernel_page_tables
+
+On analysing the output of cat /sys/kernel/debug/kernel_page_tables one can
+derive information about the virtual address range of a contiguous group of
+page table entries, followed by size of the memory region covered by this
+group, the hierarchical structure of the page tables and finally the attributes
+associated with each page in the group. Groups are broken up either according
+to a change in attributes or by parent descriptor, such as a PMD. Note that the
+set of attributes, and therefore formatting, is not equivalent between entry
+types. For example, PMD entries have a separate set of attributes from leaf
+level PTE entries, because they support both the UXNTable and PXNTable
+permission bits.
+
+The page attributes provide information about access permissions, execution
+capability, type of mapping such as leaf level PTE or block level PGD, PMD and
+PUD, and access status of a page within the kernel memory. Non-PTE block or
+page level entries are denoted with either "BLK" or "TBL", respectively.
+Assessing these attributes can assist in understanding the memory layout,
+access patterns and security characteristics of the kernel pages.
+
+Kernel virtual memory layout example::
+
+ start address        end address         size type  leaf    attributes
+ +-----------------------------------------------------------------------------------------------------------------+
+ | ---[ Linear Mapping start ]---                                                                                  |
+ | ...                                                                                                             |
+ | 0xffff0d02c3200000-0xffff0d02c3400000    2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL    |
+ | 0xffff0d02c3200000-0xffff0d02c3218000   96K PTE           ro NX SHD AF NG     UXN    MEM/NORMAL-TAGGED          |
+ | 0xffff0d02c3218000-0xffff0d02c3250000  224K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED          |
+ | 0xffff0d02c3250000-0xffff0d02c33b3000 1420K PTE           ro NX SHD AF NG     UXN    MEM/NORMAL-TAGGED          |
+ | 0xffff0d02c33b3000-0xffff0d02c3400000  308K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED          |
+ | 0xffff0d02c3400000-0xffff0d02c3600000    2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL    |
+ | 0xffff0d02c3400000-0xffff0d02c3600000    2M PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED          |
+ | ...                                                                                                             |
+ | 0xffff0d02c3200000-0xffff0d02c3400000    2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL    |
+ | ...                                                                                                             |
+ | ---[ Linear Mapping end ]---                                                                                    |
+ +-----------------------------------------------------------------------------------------------------------------+
+ | ---[ Modules start ]---                                                                                         |
+ | ...                                                                                                             |
+ | 0xffff800000000000-0xffff800000000080 128B PGD   TBL     RW               x     UXNTbl    MEM/NORMAL            |
+ | 0xffff800000000000-0xffff800080000000   2G PUD F BLK     RW               x               MEM/NORMAL            |
+ | ...                                                                                                             |
+ | ---[ Modules end ]---                                                                                           |
+ +-----------------------------------------------------------------------------------------------------------------+
+ | ---[ vmalloc() area ]---                                                                                        |
+ | ...                                                                                                             |
+ | 0xffff800080000000-0xffff8000c0000000   1G PUD   TBL     RW               x     UXNTbl    MEM/NORMAL            |
+ | ...                                                                                                             |
+ | 0xffff800080200000-0xffff800080400000   2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL     |
+ | 0xffff800080200000-0xffff80008022f000 188K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL                  |
+ | 0xffff80008022f000-0xffff800080230000   4K PTE F BLK     RW x                       MEM/NORMAL                  |
+ | 0xffff800080230000-0xffff800080233000  12K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL                  |
+ | 0xffff800080233000-0xffff800080234000   4K PTE F BLK     RW x                       MEM/NORMAL                  |
+ | 0xffff800080234000-0xffff800080237000  12K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL                  |
+ | ...                                                                                                             |
+ | 0xffff800080400000-0xffff800084000000  60M PMD F BLK     RW               x      x     x         MEM/NORMAL     |
+ | ...                                                                                                             |
+ | ---[ vmalloc() end ]---                                                                                         |
+ +-----------------------------------------------------------------------------------------------------------------+
+ | ---[ vmemmap start ]---                                                                                         |
+ | ...                                                                                                             |
+ | 0xfffffe33cb000000-0xfffffe33cc000000  16M PMD   BLK     RW SHD AF NG     NX UXN x     x         MEM/NORMAL     |
+ | 0xfffffe33cc000000-0xfffffe3400000000 832M PMD F BLK     RW               x      x     x         MEM/NORMAL     |
+ | ...                                                                                                             |
+ | ---[ vmemmap end ]---                                                                                           |
+ +-----------------------------------------------------------------------------------------------------------------+
+ | ---[ PCI I/O start ]---                                                                                         |
+ | ...                                                                                                             |
+ | 0xffffffffc0800000-0xffffffffc0810000 64K PTE           RW NX SHD AF NG     UXN    DEVICE/nGnRE                 |
+ | ...                                                                                                             |
+ | ---[ PCI I/O end ]---                                                                                           |
+ +-----------------------------------------------------------------------------------------------------------------+
+ | ---[ Fixmap start ]---                                                                                          |
+ | ...                                                                                                             |
+ | 0xffffffffff5f6000-0xffffffffff5f9000 12K PTE           ro x  SHD AF        UXN    MEM/NORMAL                   |
+ | 0xffffffffff5f9000-0xffffffffff5fa000  4K PTE           ro NX SHD AF NG     UXN    MEM/NORMAL                   |
+ | ...                                                                                                             |
+ | ---[ Fixmap end ]---                                                                                            |
+ +-----------------------------------------------------------------------------------------------------------------+
+
+cat /sys/kernel/debug/kernel_page_tables output::
+
+ 0xffff000000000000-0xffff0d0000000000   13T PGD F BLK     RW               x               MEM/NORMAL
+ 0xffff0d0000000000-0xffff0d0000000080  128B PGD   TBL     RW               NXTbl UXNTbl    MEM/NORMAL
+ 0xffff0d0000000000-0xffff0d02c0000000   11G PUD F BLK     RW               x               MEM/NORMAL
+ 0xffff0d02c0000000-0xffff0d0300000000    1G PUD   TBL     RW               NXTbl UXNTbl    MEM/NORMAL
+ 0xffff0d02c0000000-0xffff0d02c0200000    2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
+ 0xffff0d02c0000000-0xffff0d02c0200000    2M PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED
+ 0xffff0d02c0200000-0xffff0d02c0400000    2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
+ 0xffff0d02c0200000-0xffff0d02c0210000   64K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED
+ 0xffff0d02c0210000-0xffff0d02c0400000 1984K PTE           ro NX SHD AF NG     UXN    MEM/NORMAL
+ 0xffff0d02c0400000-0xffff0d02c1c00000   24M PMD   BLK     ro SHD AF NG     NX UXN x     x         MEM/NORMAL
+ 0xffff0d02c1c00000-0xffff0d02c1e00000    2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
+ 0xffff0d02c1c00000-0xffff0d02c1dc0000 1792K PTE           ro NX SHD AF NG     UXN    MEM/NORMAL
+ 0xffff0d02c1dc0000-0xffff0d02c1e00000  256K PTE           RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED
+
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 9bc4066c5bf3..6a8b2bcc9ac7 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -24,6 +24,7 @@
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
+#include <asm/pgalloc.h>
 
 
 enum address_markers_idx {
@@ -97,6 +98,11 @@ static const struct prot_bits pte_bits[] = {
 		.val	= PTE_VALID,
 		.set	= " ",
 		.clear	= "F",
+	}, {
+		.mask	= PTE_TABLE_BIT,
+		.val	= PTE_TABLE_BIT,
+		.set	= "   ",
+		.clear	= "BLK",
 	}, {
 		.mask	= PTE_USER,
 		.val	= PTE_USER,
@@ -132,11 +138,6 @@ static const struct prot_bits pte_bits[] = {
 		.val	= PTE_CONT,
 		.set	= "CON",
 		.clear	= "   ",
-	}, {
-		.mask	= PTE_TABLE_BIT,
-		.val	= PTE_TABLE_BIT,
-		.set	= "   ",
-		.clear	= "BLK",
 	}, {
 		.mask	= PTE_UXN,
 		.val	= PTE_UXN,
@@ -170,34 +171,206 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
+static const struct prot_bits pmd_bits[] = {
+	{
+		.mask	= PMD_SECT_VALID,
+		.val	= PMD_SECT_VALID,
+		.set	= " ",
+		.clear	= "F",
+	}, {
+		.mask	= PMD_TABLE_BIT,
+		.val	= PMD_TABLE_BIT,
+		.set	= "TBL",
+		.clear	= "BLK",
+	}, {
+		.mask	= PMD_SECT_USER,
+		.val	= PMD_SECT_USER,
+		.set	= "USR",
+		.clear	= "   ",
+	}, {
+		.mask	= PMD_SECT_RDONLY,
+		.val	= PMD_SECT_RDONLY,
+		.set	= "ro",
+		.clear	= "RW",
+	}, {
+		.mask	= PMD_SECT_S,
+		.val	= PMD_SECT_S,
+		.set	= "SHD",
+		.clear	= "   ",
+	}, {
+		.mask	= PMD_SECT_AF,
+		.val	= PMD_SECT_AF,
+		.set	= "AF",
+		.clear	= "  ",
+	}, {
+		.mask	= PMD_SECT_NG,
+		.val	= PMD_SECT_NG,
+		.set	= "NG",
+		.clear	= "  ",
+	}, {
+		.mask	= PMD_SECT_CONT,
+		.val	= PMD_SECT_CONT,
+		.set	= "CON",
+		.clear	= "   ",
+	}, {
+		.mask	= PMD_SECT_PXN,
+		.val	= PMD_SECT_PXN,
+		.set	= "NX",
+		.clear	= "x ",
+	}, {
+		.mask	= PMD_SECT_UXN,
+		.val	= PMD_SECT_UXN,
+		.set	= "UXN",
+		.clear	= "   ",
+	}, {
+		.mask	= PMD_TABLE_PXN,
+		.val	= PMD_TABLE_PXN,
+		.set	= "NXTbl",
+		.clear	= "x    ",
+	}, {
+		.mask	= PMD_TABLE_UXN,
+		.val	= PMD_TABLE_UXN,
+		.set	= "UXNTbl",
+		.clear	= "x     ",
+	}, {
+		.mask	= PTE_GP,
+		.val	= PTE_GP,
+		.set	= "GP",
+		.clear	= "  ",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_DEVICE_nGnRnE),
+		.set	= "DEVICE/nGnRnE",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_DEVICE_nGnRE),
+		.set	= "DEVICE/nGnRE",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_NORMAL_NC),
+		.set	= "MEM/NORMAL-NC",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_NORMAL),
+		.set	= "MEM/NORMAL",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_NORMAL_TAGGED),
+		.set	= "MEM/NORMAL-TAGGED",
+	}
+};
+
+static const struct prot_bits pud_bits[] = {
+	{
+		.mask	= PUD_TYPE_SECT,
+		.val	= PUD_TYPE_SECT,
+		.set	= " ",
+		.clear	= "F",
+	}, {
+		.mask	= PUD_TABLE_BIT,
+		.val	= PUD_TABLE_BIT,
+		.set	= "TBL",
+		.clear	= "BLK",
+	}, {
+		.mask	= PTE_USER,
+		.val	= PTE_USER,
+		.set	= "USR",
+		.clear	= "   ",
+	}, {
+		.mask	= PUD_SECT_RDONLY,
+		.val	= PUD_SECT_RDONLY,
+		.set	= "ro",
+		.clear	= "RW",
+	}, {
+		.mask	= PTE_SHARED,
+		.val	= PTE_SHARED,
+		.set	= "SHD",
+		.clear	= "   ",
+	}, {
+		.mask	= PTE_AF,
+		.val	= PTE_AF,
+		.set	= "AF",
+		.clear	= "  ",
+	}, {
+		.mask	= PTE_NG,
+		.val	= PTE_NG,
+		.set	= "NG",
+		.clear	= "  ",
+	}, {
+		.mask	= PTE_CONT,
+		.val	= PTE_CONT,
+		.set	= "CON",
+		.clear	= "   ",
+	}, {
+		.mask	= PUD_TABLE_PXN,
+		.val	= PUD_TABLE_PXN,
+		.set	= "NXTbl",
+		.clear	= "x    ",
+	}, {
+		.mask	= PUD_TABLE_UXN,
+		.val	= PUD_TABLE_UXN,
+		.set	= "UXNTbl",
+		.clear	= "      ",
+	}, {
+		.mask	= PTE_GP,
+		.val	= PTE_GP,
+		.set	= "GP",
+		.clear	= "  ",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_DEVICE_nGnRnE),
+		.set	= "DEVICE/nGnRnE",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_DEVICE_nGnRE),
+		.set	= "DEVICE/nGnRE",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_NORMAL_NC),
+		.set	= "MEM/NORMAL-NC",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_NORMAL),
+		.set	= "MEM/NORMAL",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_NORMAL_TAGGED),
+		.set	= "MEM/NORMAL-TAGGED",
+	}
+};
+
 struct pg_level {
 	const struct prot_bits *bits;
 	const char *name;
 	size_t num;
 	u64 mask;
+	unsigned long size;
 };
 
 static struct pg_level pg_level[] = {
 	{ /* pgd */
 		.name	= "PGD",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.bits	= pud_bits,
+		.num	= ARRAY_SIZE(pud_bits),
+		.size	= PGD_SIZE
 	}, { /* p4d */
 		.name	= "P4D",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.bits	= pud_bits,
+		.num	= ARRAY_SIZE(pud_bits),
+		.size	= P4D_SIZE
 	}, { /* pud */
 		.name	= (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.bits	= pud_bits,
+		.num	= ARRAY_SIZE(pud_bits),
 	}, { /* pmd */
 		.name	= (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.bits	= pmd_bits,
+		.num	= ARRAY_SIZE(pmd_bits),
 	}, { /* pte */
 		.name	= "PTE",
 		.bits	= pte_bits,
 		.num	= ARRAY_SIZE(pte_bits),
+		.size	= PAGE_SIZE
 	},
 };
 
@@ -252,7 +425,7 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 		      u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
-	static const char units[] = "KMGTPE";
+	static const char units[] = "BKMGTPE";
 	u64 prot = 0;
 
 	if (level >= 0)
@@ -263,8 +436,8 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 		st->current_prot = prot;
 		st->start_address = addr;
 		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
-	} else if (prot != st->current_prot || level != st->level ||
-		   addr >= st->marker[1].start_address) {
+	} else if ((prot != st->current_prot || level != st->level ||
+		   addr >= st->marker[1].start_address)) {
 		const char *unit = units;
 		unsigned long delta;
 
@@ -273,10 +446,20 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 			note_prot_wx(st, addr);
 		}
 
-		pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
-				   st->start_address, addr);
+		/*
+		 * Entries are coalesced into a single line, so non-leaf
+		 * entries have no size relative to start_address
+		 */
+		if (st->start_address != addr) {
+			pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
+					   st->start_address, addr);
+			delta = (addr - st->start_address);
+		} else {
+			pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ", addr,
+					   addr + pg_level[st->level].size);
+			delta = (pg_level[st->level].size);
+		}
 
-		delta = (addr - st->start_address) >> 10;
 		while (!(delta & 1023) && unit[1]) {
 			delta >>= 10;
 			unit++;
@@ -322,7 +505,8 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 			.range = (struct ptdump_range[]){
 				{info->base_addr, end},
 				{0, 0}
-			}
+			},
+			.note_non_leaf = true
 		}
 	};
 
diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
index 2a3a95586425..d32fa8515182 100644
--- a/include/linux/ptdump.h
+++ b/include/linux/ptdump.h
@@ -16,6 +16,7 @@ struct ptdump_state {
 			  int level, u64 val);
 	void (*effective_prot)(struct ptdump_state *st, int level, u64 val);
 	const struct ptdump_range *range;
+	bool note_non_leaf;
 };
 
 void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd);
diff --git a/mm/ptdump.c b/mm/ptdump.c
index eea3d28d173c..aacbd499ffcd 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -40,6 +40,9 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 0, pgd_val(val));
 
+	if (st->note_non_leaf && !pgd_leaf(val))
+		st->note_page(st, addr, 0, pgd_val(val));
+
 	if (pgd_leaf(val)) {
 		st->note_page(st, addr, 0, pgd_val(val));
 		walk->action = ACTION_CONTINUE;
@@ -63,6 +66,9 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 1, p4d_val(val));
 
+	if (st->note_non_leaf && !p4d_leaf(val))
+		st->note_page(st, addr, 1, p4d_val(val));
+
 	if (p4d_leaf(val)) {
 		st->note_page(st, addr, 1, p4d_val(val));
 		walk->action = ACTION_CONTINUE;
@@ -86,6 +92,9 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 2, pud_val(val));
 
+	if (st->note_non_leaf && !pud_leaf(val))
+		st->note_page(st, addr, 2, pud_val(val));
+
 	if (pud_leaf(val)) {
 		st->note_page(st, addr, 2, pud_val(val));
 		walk->action = ACTION_CONTINUE;
@@ -107,6 +116,10 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	if (st->effective_prot)
 		st->effective_prot(st, 3, pmd_val(val));
+
+	if (st->note_non_leaf && !pmd_leaf(val))
+		st->note_page(st, addr, 3, pmd_val(val));
+
 	if (pmd_leaf(val)) {
 		st->note_page(st, addr, 3, pmd_val(val));
 		walk->action = ACTION_CONTINUE;

base-commit: 5f9df76887bf8170e8844f1907c13fbbb30e9c36
-- 
2.34.1


