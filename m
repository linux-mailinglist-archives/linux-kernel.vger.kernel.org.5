Return-Path: <linux-kernel+bounces-65140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ADA854882
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F01C229C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74001A58B;
	Wed, 14 Feb 2024 11:36:41 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAE1947D;
	Wed, 14 Feb 2024 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910601; cv=none; b=fljmPV3xI5SNNLgR8/Y8lLh4kH78J99sICC3+5vUSQDgdesVgiBuiKySkG1hA2lzrNh5KSpnr1qDjJuO9xqPlhsEEY/C5DfPyoPLGf3/o0LENN2vI9QTkdkjnMVK7zSsqfPB13H+zO9ZOHpqXJBLOWYW7N/ZGIdZWPThg2mgAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910601; c=relaxed/simple;
	bh=XX4ZJh1efWO1B3rAxShAcHfODcw783OuO5HzO8Mr6W0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qcY6syD3Vex2ffc1j1zVH7wfAsoZUbENiGnI3tOxk0Ono7z6pwGuDQ9aA+8tL3twnka6hm0bmsVsLWt2a71C5JK/4oau2xOOHZ/LLAyvEdj0pMjrixkF/gTtqhJPFoM6ZUj63aUXmvYIBU8VAoxMWYAVP/qwAOaqGtTHTWJo8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TZbNw1Yybz9xrtH;
	Wed, 14 Feb 2024 19:21:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B516014066B;
	Wed, 14 Feb 2024 19:36:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAHshp7pcxlDJx9Ag--.51624S5;
	Wed, 14 Feb 2024 12:36:25 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Xin Li <xin3.li@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ze Gao <zegao2021@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <jroedel@suse.de>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH v1 3/8] sbm: x86: map system data structures into the sandbox
Date: Wed, 14 Feb 2024 12:35:11 +0100
Message-Id: <20240214113516.2307-4-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHshp7pcxlDJx9Ag--.51624S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWDtrykCFy7Cr43Ar4Utwb_yoWrGr47pF
	nxCF1kKFW7K343uwn3Cr40yr15Zws2k3W7Kry2kryrZF17t3W5Ars2g3yDtFW8GFWvga4F
	qFW3tF4rGa1DZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjfUnPEfUUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Map CPU system data structures (GDT, TSS, IDT) read-only into every sandbox
instance. Map interrupt stacks read-write.

The TSS mappings may look confusing. The trick is that TSS pages are mapped
twice in the kernel address space: once read-only and once read-write. The
GDT entry for the TR register uses the read-only address, but since __pa()
does not work for virtual addresses in this range (cpu_entry_area), use the
read-write mapping to get TSS physical address.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 arch/x86/include/asm/page_64_types.h |  1 +
 arch/x86/kernel/sbm/core.c           | 74 ++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 06ef25411d62..62f6e40b3361 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -29,6 +29,7 @@
 #define	IST_INDEX_DB		2
 #define	IST_INDEX_MCE		3
 #define	IST_INDEX_VC		4
+#define	IST_INDEX_NUM		7
 
 /*
  * Set __PAGE_OFFSET to the most negative possible address +
diff --git a/arch/x86/kernel/sbm/core.c b/arch/x86/kernel/sbm/core.c
index de6986801148..f3a123d64afc 100644
--- a/arch/x86/kernel/sbm/core.c
+++ b/arch/x86/kernel/sbm/core.c
@@ -7,9 +7,13 @@
  * SandBox Mode (SBM) implementation for the x86 architecture.
  */
 
+#include <asm/cpu_entry_area.h>
+#include <asm/desc.h>
 #include <asm/pgtable.h>
+#include <asm/page.h>
 #include <asm/sbm.h>
 #include <asm/sections.h>
+#include <linux/cpumask.h>
 #include <linux/mm.h>
 #include <linux/sbm.h>
 #include <linux/sched/task_stack.h>
@@ -155,6 +159,72 @@ static int map_kernel(struct x86_sbm_state *state)
 	return 0;
 }
 
+/** map_cpu_data() - map CPU system data structures into a sandbox instance
+ * @sbm:  Target sandbox instance.
+ *
+ * Create sandbox page tables for:
+ * * Global Descriptor Table (GDT)
+ * * Task State Segment (TSS)
+ * * Interrupt Descriptor Table (IDT).
+ *
+ * Return: Zero on success, negative error code on failure.
+ */
+static int map_cpu_data(struct x86_sbm_state *state)
+{
+	unsigned long off;
+	phys_addr_t paddr;
+	unsigned int ist;
+	void *vaddr;
+	int cpu;
+	int err;
+
+	for_each_possible_cpu(cpu) {
+		struct cpu_entry_area *cea;
+		struct tss_struct *tss;
+
+		err = map_page(state, (unsigned long)get_cpu_gdt_ro(cpu),
+			       PHYS_PFN(get_cpu_gdt_paddr(cpu)),
+			       PAGE_KERNEL_RO);
+		if (err)
+			return err;
+
+		cea = get_cpu_entry_area(cpu);
+
+		tss = &cea->tss;
+		paddr = __pa(&per_cpu(cpu_tss_rw, cpu));
+		for (off = 0; off < sizeof(cpu_tss_rw); off += PAGE_SIZE) {
+			err = map_page(state, (unsigned long)tss + off,
+				       PHYS_PFN(paddr + off), PAGE_KERNEL_RO);
+			if (err)
+				return err;
+		}
+
+		paddr = slow_virt_to_phys(&cea->entry_stack_page);
+		err = map_page(state, (unsigned long)&cea->entry_stack_page,
+			       PHYS_PFN(paddr), PAGE_KERNEL);
+		if (err)
+			return err;
+
+		for (ist = 0; ist < IST_INDEX_NUM; ++ist) {
+			vaddr = (void *)tss->x86_tss.ist[ist];
+			if (!vaddr)
+				continue;
+
+			for (off = EXCEPTION_STKSZ; off; off -= PAGE_SIZE) {
+				paddr = slow_virt_to_phys(vaddr - off);
+				err = map_page(state, (unsigned long)vaddr - off,
+					       PHYS_PFN(paddr), PAGE_KERNEL);
+				if (err)
+					return err;
+			}
+		}
+	}
+
+	paddr = slow_virt_to_phys((void *)CPU_ENTRY_AREA_RO_IDT);
+	return map_page(state, CPU_ENTRY_AREA_RO_IDT, PHYS_PFN(paddr),
+			PAGE_KERNEL_RO);
+}
+
 int arch_sbm_init(struct sbm *sbm)
 {
 	struct x86_sbm_state *state;
@@ -194,6 +264,10 @@ int arch_sbm_init(struct sbm *sbm)
 	if (err)
 		return err;
 
+	err = map_cpu_data(state);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.34.1


