Return-Path: <linux-kernel+bounces-155663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC0B8AF552
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E30B26213
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D7313D8BB;
	Tue, 23 Apr 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="n0FYux0a"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249F208A9;
	Tue, 23 Apr 2024 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892824; cv=none; b=sOFZKsjIAzdJbXFI0fZ+2Abeei1pmgi8INo9uKJLPlu5TXSeajRO4FTLb0JwakSj8rrFtbguhItsSrRo6NskonZLDCi8hys5iKNSVDHmecNxHs6pJgvQI2iIeNo7FSUCmOPdYdaSlCUgEyRbAjmbXvRLh2QIbqic1NREimvhqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892824; c=relaxed/simple;
	bh=bhaoMdqp2VU4qCFjkuQfL4m9NZniKQUzcmP/BVHU0Hw=;
	h=Message-Id:To:Cc:From:Date:Subject; b=EX4FLA0Wcio9SGxrpQm0knWmYJT8iyGaOkCLa/cSZJXSXcJpXqtNrma4gist8pA+YUp5zh/EL0rhvwKSwDZScSDjK8gW+mgNR18pfQMscbK+5p+lDr2r9OguB7vFwrvmgIpSRkmsz+HTt28ruzam6pLzuUZwuStP2aH2O7PnRfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=fail (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=n0FYux0a reason="signature verification failed"; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 43NFvVqF023694;
	Tue, 23 Apr 2024 17:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	message-id:to:cc:from:date:subject; s=DKIM202306; bh=zeEoU7dkwCo
	IiIBp8pJxTA1FJWukJR0hjPW2h/Mabqc=; b=n0FYux0aPq9+q7qBtfOYgWv3cRc
	mOiBKGypFk6wxiYV5RgUdw0t6t6pNdsYE7k3WFBmF1pKmAaBaBaiJ6EvR6vq96/w
	7g4B4vHAELTAdxh4cN67AmZ89bd0evkU4cHbeS2e28J8Wv3LJnSD9WS0ivF9l92d
	cUVqEr6xa1pKg1SJ14+XONZ/Q4wEe7ye5h96sZkDvVLuFLVLKO1n3UgcjvAGBooP
	ppcFQrdh2BCdg9jdTqTXBjEJDuCVSPzWtO6MI1IlGvh/kzYNb7Oxy4OZLY4AVi/V
	n74jJZ4R5/xCK2VCUq/yBhnn1e3pWdlJCqn1ful0dW+SXAdGALVXHJw6saw==
Received: from ilclpfpp01.lenovo.com ([144.188.128.67])
	by m0355088.ppops.net (PPS) with ESMTPS id 3xnvc2jksv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 17:19:50 +0000 (GMT)
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4VP84j6djSzcxpp;
	Tue, 23 Apr 2024 17:19:49 +0000 (UTC)
Received: from ilclasset02.mot.com (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4VP84j6MPSz3n3fr;
	Tue, 23 Apr 2024 17:19:49 +0000 (UTC)
Message-Id: <20240423121820.874441838-1-mbland@motorola.com>
To: linux-mm@kvack.org
Cc: "Maxwell Bland <mbland@motorola.com>
	Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Maxwell Bland <mbland@motorola.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Maxwell Bland <mbland@motorola.com>
Date: Tue, 23 Apr 2024 12:18:20 -0500
Subject: [PATCH] ptdump: add non-leaf descriptor support
X-Proofpoint-GUID: 5dMlSk_-_7UdZApIcbzoFqYjyX64TIwW
X-Proofpoint-ORIG-GUID: 5dMlSk_-_7UdZApIcbzoFqYjyX64TIwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_14,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230039
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

Examples (spaces condensed and partially truncated)
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
Hi,

Thank you for taking the time to review this patch.

I made these changes in order to compliment testing
20240220203256.31153-1-mbland@motorola.com
and
20240423095843.446565600-1-mbland@motorola.com

and figured they might be useful to others.

BRs,
Maxwell Bland

 Documentation/arch/arm64/ptdump.rst | 181 ++++++++++++----------
 arch/arm64/mm/ptdump.c              | 226 +++++++++++++++++++++++++---
 include/linux/ptdump.h              |   1 +
 mm/ptdump.c                         |  13 ++
 4 files changed, 325 insertions(+), 96 deletions(-)

diff --git a/Documentation/arch/arm64/ptdump.rst b/Documentation/arch/arm64/ptdump.rst
index 5dcfc5d7cddf..0f38b92fd839 100644
--- a/Documentation/arch/arm64/ptdump.rst
+++ b/Documentation/arch/arm64/ptdump.rst
@@ -2,25 +2,24 @@
 Kernel page table dump
 ======================
 
-ptdump is a debugfs interface that provides a detailed dump of the
-kernel page tables. It offers a comprehensive overview of the kernel
-virtual memory layout as well as the attributes associated with the
-various regions in a human-readable format. It is useful to dump the
-kernel page tables to verify permissions and memory types. Examining the
-page table entries and permissions helps identify potential security
-vulnerabilities such as mappings with overly permissive access rights or
-improper memory protections.
+ptdump is a debugfs interface that provides a detailed dump of the kernel page
+tables. It offers a comprehensive overview of the kernel virtual memory layout
+as well as the attributes associated with the various regions in a
+human-readable format. It is useful to dump the kernel page tables to verify
+permissions and memory types. Examining the page table entries and permissions
+helps identify potential security vulnerabilities such as mappings with overly
+permissive access rights or improper memory protections.
 
-Memory hotplug allows dynamic expansion or contraction of available
-memory without requiring a system reboot. To maintain the consistency
-and integrity of the memory management data structures, arm64 makes use
-of the mem_hotplug_lock semaphore in write mode. Additionally, in
-read mode, mem_hotplug_lock supports an efficient implementation of
-get_online_mems() and put_online_mems(). These protect the
-offlining of memory being accessed by the ptdump code.
+Memory hotplug allows dynamic expansion or contraction of available memory
+without requiring a system reboot. To maintain the consistency and integrity of
+the memory management data structures, arm64 makes use of the
+mem_hotplug_lock semaphore in write mode. Additionally, in read mode,
+mem_hotplug_lock supports an efficient implementation of
+get_online_mems() and put_online_mems(). These protect the offlining of
+memory being accessed by the ptdump code.
 
-In order to dump the kernel page tables, enable the following
-configurations and mount debugfs::
+In order to dump the kernel page tables, enable the following configurations
+and mount debugfs::
 
  CONFIG_GENERIC_PTDUMP=y
  CONFIG_PTDUMP_CORE=y
@@ -29,68 +28,98 @@ configurations and mount debugfs::
  mount -t debugfs nodev /sys/kernel/debug
  cat /sys/kernel/debug/kernel_page_tables
 
-On analysing the output of cat /sys/kernel/debug/kernel_page_tables
-one can derive information about the virtual address range of the entry,
-followed by size of the memory region covered by this entry, the
-hierarchical structure of the page tables and finally the attributes
-associated with each page. The page attributes provide information about
-access permissions, execution capability, type of mapping such as leaf
-level PTE or block level PGD, PMD and PUD, and access status of a page
-within the kernel memory. Assessing these attributes can assist in
-understanding the memory layout, access patterns and security
-characteristics of the kernel pages.
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
 
 Kernel virtual memory layout example::
 
- start address        end address         size             attributes
- +---------------------------------------------------------------------------------------+
- | ---[ Linear Mapping start ]---------------------------------------------------------- |
- | ..................                                                                    |
- | 0xfff0000000000000-0xfff0000000210000  2112K PTE RW NX SHD AF  UXN  MEM/NORMAL-TAGGED |
- | 0xfff0000000210000-0xfff0000001c00000 26560K PTE ro NX SHD AF  UXN  MEM/NORMAL        |
- | ..................                                                                    |
- | ---[ Linear Mapping end ]------------------------------------------------------------ |
- +---------------------------------------------------------------------------------------+
- | ---[ Modules start ]----------------------------------------------------------------- |
- | ..................                                                                    |
- | 0xffff800000000000-0xffff800008000000   128M PTE                                      |
- | ..................                                                                    |
- | ---[ Modules end ]------------------------------------------------------------------- |
- +---------------------------------------------------------------------------------------+
- | ---[ vmalloc() area ]---------------------------------------------------------------- |
- | ..................                                                                    |
- | 0xffff800008010000-0xffff800008200000  1984K PTE ro x  SHD AF       UXN  MEM/NORMAL   |
- | 0xffff800008200000-0xffff800008e00000    12M PTE ro x  SHD AF  CON  UXN  MEM/NORMAL   |
- | ..................                                                                    |
- | ---[ vmalloc() end ]----------------------------------------------------------------- |
- +---------------------------------------------------------------------------------------+
- | ---[ Fixmap start ]------------------------------------------------------------------ |
- | ..................                                                                    |
- | 0xfffffbfffdb80000-0xfffffbfffdb90000    64K PTE ro x  SHD AF  UXN  MEM/NORMAL        |
- | 0xfffffbfffdb90000-0xfffffbfffdba0000    64K PTE ro NX SHD AF  UXN  MEM/NORMAL        |
- | ..................                                                                    |
- | ---[ Fixmap end ]-------------------------------------------------------------------- |
- +---------------------------------------------------------------------------------------+
- | ---[ PCI I/O start ]----------------------------------------------------------------- |
- | ..................                                                                    |
- | 0xfffffbfffe800000-0xfffffbffff800000    16M PTE                                      |
- | ..................                                                                    |
- | ---[ PCI I/O end ]------------------------------------------------------------------- |
- +---------------------------------------------------------------------------------------+
- | ---[ vmemmap start ]----------------------------------------------------------------- |
- | ..................                                                                    |
- | 0xfffffc0002000000-0xfffffc0002200000     2M PTE RW NX SHD AF  UXN  MEM/NORMAL        |
- | 0xfffffc0002200000-0xfffffc0020000000   478M PTE                                      |
- | ..................                                                                    |
- | ---[ vmemmap end ]------------------------------------------------------------------- |
- +---------------------------------------------------------------------------------------+
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
 
 cat /sys/kernel/debug/kernel_page_tables output::
 
- 0xfff0000001c00000-0xfff0000080000000     2020M PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
- 0xfff0000080000000-0xfff0000800000000       30G PMD
- 0xfff0000800000000-0xfff0000800700000        7M PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
- 0xfff0000800700000-0xfff0000800710000       64K PTE  ro NX SHD AF   UXN    MEM/NORMAL-TAGGED
- 0xfff0000800710000-0xfff0000880000000  2089920K PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
- 0xfff0000880000000-0xfff0040000000000     4062G PMD
- 0xfff0040000000000-0xffff800000000000     3964T PGD
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
index 6986827e0d64..362f3c95d59b 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -24,6 +24,7 @@
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
+#include <asm/pgalloc.h>
 
 
 #define pt_dump_seq_printf(m, fmt, args...)	@@ -70,6 +71,11 @@ static const struct prot_bits pte_bits[] = {
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
@@ -105,11 +111,6 @@ static const struct prot_bits pte_bits[] = {
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
@@ -143,34 +144,208 @@ static const struct prot_bits pte_bits[] = {
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
 	char name[4];
 	int num;
 	u64 mask;
+	unsigned long size;
 };
 
 static struct pg_level pg_level[] __ro_after_init = {
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
 		.name	= "PUD",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.bits	= pud_bits,
+		.num	= ARRAY_SIZE(pud_bits),
+		.size	= PUD_SIZE
 	}, { /* pmd */
 		.name	= "PMD",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.bits	= pmd_bits,
+		.num	= ARRAY_SIZE(pmd_bits),
+		.size	= PMD_SIZE
 	}, { /* pte */
 		.name	= "PTE",
 		.bits	= pte_bits,
 		.num	= ARRAY_SIZE(pte_bits),
+		.size	= PAGE_SIZE
 	},
 };
 
@@ -225,7 +400,7 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 		      u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
-	static const char units[] = "KMGTPE";
+	static const char units[] = "BKMGTPE";
 	u64 prot = 0;
 
 	/* check if the current level has been folded dynamically */
@@ -241,8 +416,8 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 		st->current_prot = prot;
 		st->start_address = addr;
 		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
-	} else if (prot != st->current_prot || level != st->level ||
-		   addr >= st->marker[1].start_address) {
+	} else if ((prot != st->current_prot || level != st->level ||
+		   addr >= st->marker[1].start_address)) {
 		const char *unit = units;
 		unsigned long delta;
 
@@ -251,10 +426,20 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
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
@@ -301,7 +486,8 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 			.range = (struct ptdump_range[]){
 				{info->base_addr, end},
 				{0, 0}
-			}
+			},
+			.note_non_leaf = true
 		}
 	};
 
diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
index 8dbd51ea8626..b3e793a5c77f 100644
--- a/include/linux/ptdump.h
+++ b/include/linux/ptdump.h
@@ -16,6 +16,7 @@ struct ptdump_state {
 			  int level, u64 val);
 	void (*effective_prot)(struct ptdump_state *st, int level, u64 val);
 	const struct ptdump_range *range;
+	bool note_non_leaf;
 };
 
 bool ptdump_walk_pgd_level_core(struct seq_file *m,
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 106e1d66e9f9..97da7a765b22 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -41,6 +41,9 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 0, pgd_val(val));
 
+	if (st->note_non_leaf && !pgd_leaf(val))
+		st->note_page(st, addr, 0, pgd_val(val));
+
 	if (pgd_leaf(val)) {
 		st->note_page(st, addr, 0, pgd_val(val));
 		walk->action = ACTION_CONTINUE;
@@ -64,6 +67,9 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 1, p4d_val(val));
 
+	if (st->note_non_leaf && !p4d_leaf(val))
+		st->note_page(st, addr, 1, p4d_val(val));
+
 	if (p4d_leaf(val)) {
 		st->note_page(st, addr, 1, p4d_val(val));
 		walk->action = ACTION_CONTINUE;
@@ -87,6 +93,9 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 2, pud_val(val));
 
+	if (st->note_non_leaf && !pud_leaf(val))
+		st->note_page(st, addr, 2, pud_val(val));
+
 	if (pud_leaf(val)) {
 		st->note_page(st, addr, 2, pud_val(val));
 		walk->action = ACTION_CONTINUE;
@@ -108,6 +117,10 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	if (st->effective_prot)
 		st->effective_prot(st, 3, pmd_val(val));
+
+	if (st->note_non_leaf && !pmd_leaf(val))
+		st->note_page(st, addr, 3, pmd_val(val));
+
 	if (pmd_leaf(val)) {
 		st->note_page(st, addr, 3, pmd_val(val));
 		walk->action = ACTION_CONTINUE;

base-commit: 71b1543c83d65af8215d7558d70fc2ecbee77dcf
-- 
2.34.1


