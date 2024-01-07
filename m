Return-Path: <linux-kernel+bounces-18776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAC68262E2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 05:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14361C212EE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 04:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825A11CB7;
	Sun,  7 Jan 2024 04:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xIgRREzT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706FE111BC
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 04:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704601838; bh=IJGKj9mfA5WhofwmTYCnpKSFdiMXh3Sw5ca58b3wD1E=;
	h=From:To:Cc:Subject:Date;
	b=xIgRREzTJDXucRuHWurufWRSbHaaEuzKK54GLbrnvk+dHuBaytqYJsQBUINQFQXb0
	 mO9pVSrGqH9GxS1I4CdZj3Htotr6ETOZ+A8223OZVMXBbvfv5dTOJ3tQsoAIS1ArXy
	 FVGPILibNAKpGLicJCzoN2Q2acQCp7KC103SS8Zg=
Received: from HPPC.. ([2409:8a28:c9b:6ef0:9265:b624:43f3:c76f])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 60E93E27; Sun, 07 Jan 2024 12:24:14 +0800
X-QQ-mid: xmsmtpt1704601454tbnnxegdp
Message-ID: <tencent_16DE28073E2F2BF284331B21ADFA58AB2907@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtP+89TQtWJ5Yf27A2P5X2kTLccbrUFtAfVUf8iYHVJSOLSk97Lz
	 zXHPc1BzuluGHrHq8H1eUiisPOnGO9XcJP4KwmHKYpbRqyMpawuJupmX44QzHpR/tEKDIG4IvGHO
	 rQA65PuRQd13/vWoQcHyCrLCujU3QF6xG1wG1hhsNHL11Zf/YhtLoqhVxKNwIV5Ye+dGkObhDE1m
	 vwrT9cJ3aNeGdUo/mcq0vUvi56LeKmdMJCoZBgKFvXHIZLvM1qBRcdEFm8irKQmEYU4fNTs97tny
	 GSQkgRMaZQfIHUBAooAY03fn+dpaHnNtQVd8YJWFhFemslbzju79rCI6klBAg14T6syQFjRhv5YD
	 3fd+0zv87YACUDYxr9EX6bULUuvcw9miNLPBY5y3EwsSjv+PvHMotKyy6cTybo19sqPaceYtZGL+
	 wQNAw+C1zrM/usq3T7aD+Tu4D0keGTt/YDVk/x21Tqrb5+lun1iUEge44l3J3EAm5jngXOl2xWWj
	 UCLfdyLgx0LX62TcQtF55wnaRB7fgCU8AByRegm2yvyRmZ5LZKO85b/AaqPQfemhN78fKKTusKU5
	 Lm4px0I+KKfpodsyGfypkCp5YNo+7jTplOeF5AW/kykNDuwCmq9bDJrp6h9rCQVRNcZtu7Q0hbi2
	 4G4odty8yTYiZdjcih1kPYQ3OLJYLK6pvNLRvRM4j33AX3OJf08E1eghbV8ZpErrAEKKs7KIP5vU
	 +OSj30rkIPC+8QtOiB3x7SdQfBeA3bSmim4uKNZMdUY0SHO1Cq4fFKub7LpGvwo7Mdb+h+PJjqRr
	 fhqdHVum4/y8VAS0M5A+GRgk/xNetMI18HNjdamxiu2CTEVAr1jxAqVeZBwM5sZRVJK+i94xG395
	 RgoMkSUom68sUiWgZn+TBoIAsdtv6UlwbPHWP2vKznAR1Gs70EJNvVgGLh++3Uk+kh1eZTCgcKCv
	 81cywi/VZ+4dMmudSq6uc9p0aNQhqFdcAWfqYoSEibJ/QU+P6PSf9Mb4rMJEIz6ScEHgB3xc2pWo
	 EVZtE8n7fXhaox0eoqxCnUQNdA0IV7nqUgZdmQVNBD2jidAhMbsKEc2AL7mDIC45OZk7ecAA7rDR
	 Ez7GgV
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yukai Wu <wuyukai0403@qq.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Yukai Wu <wuyukai0403@qq.com>
Subject: [PATCH] x86/mm: Remove unnecessary casts in init_64.c
Date: Sun,  7 Jan 2024 12:24:14 +0800
X-OQ-MSGID: <20240107042414.13348-1-wuyukai0403@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some pointers in init_64.c do not need to cast the type.

Signed-off-by: Yukai Wu <wuyukai0403@qq.com>
---
 arch/x86/mm/init_64.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a190aae8c..f5bbac54b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -150,7 +150,7 @@ static void sync_global_pgds_l5(unsigned long start, unsigned long end)
 			pgd_t *pgd;
 			spinlock_t *pgt_lock;
 
-			pgd = (pgd_t *)page_address(page) + pgd_index(addr);
+			pgd = page_address(page) + pgd_index(addr);
 			/* the pgt_lock only for Xen */
 			pgt_lock = &pgd_page_get_mm(page)->page_table_lock;
 			spin_lock(pgt_lock);
@@ -192,7 +192,7 @@ static void sync_global_pgds_l4(unsigned long start, unsigned long end)
 			p4d_t *p4d;
 			spinlock_t *pgt_lock;
 
-			pgd = (pgd_t *)page_address(page) + pgd_index(addr);
+			pgd = page_address(page) + pgd_index(addr);
 			p4d = p4d_offset(pgd, addr);
 			/* the pgt_lock only for Xen */
 			pgt_lock = &pgd_page_get_mm(page)->page_table_lock;
@@ -249,7 +249,7 @@ static __ref void *spp_getpage(void)
 static p4d_t *fill_p4d(pgd_t *pgd, unsigned long vaddr)
 {
 	if (pgd_none(*pgd)) {
-		p4d_t *p4d = (p4d_t *)spp_getpage();
+		p4d_t *p4d = spp_getpage();
 		pgd_populate(&init_mm, pgd, p4d);
 		if (p4d != p4d_offset(pgd, 0))
 			printk(KERN_ERR "PAGETABLE BUG #00! %p <-> %p\n",
@@ -261,7 +261,7 @@ static p4d_t *fill_p4d(pgd_t *pgd, unsigned long vaddr)
 static pud_t *fill_pud(p4d_t *p4d, unsigned long vaddr)
 {
 	if (p4d_none(*p4d)) {
-		pud_t *pud = (pud_t *)spp_getpage();
+		pud_t *pud = spp_getpage();
 		p4d_populate(&init_mm, p4d, pud);
 		if (pud != pud_offset(p4d, 0))
 			printk(KERN_ERR "PAGETABLE BUG #01! %p <-> %p\n",
@@ -273,7 +273,7 @@ static pud_t *fill_pud(p4d_t *p4d, unsigned long vaddr)
 static pmd_t *fill_pmd(pud_t *pud, unsigned long vaddr)
 {
 	if (pud_none(*pud)) {
-		pmd_t *pmd = (pmd_t *) spp_getpage();
+		pmd_t *pmd = spp_getpage();
 		pud_populate(&init_mm, pud, pmd);
 		if (pmd != pmd_offset(pud, 0))
 			printk(KERN_ERR "PAGETABLE BUG #02! %p <-> %p\n",
@@ -285,7 +285,7 @@ static pmd_t *fill_pmd(pud_t *pud, unsigned long vaddr)
 static pte_t *fill_pte(pmd_t *pmd, unsigned long vaddr)
 {
 	if (pmd_none(*pmd)) {
-		pte_t *pte = (pte_t *) spp_getpage();
+		pte_t *pte = spp_getpage();
 		pmd_populate_kernel(&init_mm, pmd, pte);
 		if (pte != pte_offset_kernel(pmd, 0))
 			printk(KERN_ERR "PAGETABLE BUG #03!\n");
@@ -378,19 +378,19 @@ static void __init __init_extra_mapping(unsigned long phys, unsigned long size,
 	for (; size; phys += PMD_SIZE, size -= PMD_SIZE) {
 		pgd = pgd_offset_k((unsigned long)__va(phys));
 		if (pgd_none(*pgd)) {
-			p4d = (p4d_t *) spp_getpage();
+			p4d = spp_getpage();
 			set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE |
 						_PAGE_USER));
 		}
 		p4d = p4d_offset(pgd, (unsigned long)__va(phys));
 		if (p4d_none(*p4d)) {
-			pud = (pud_t *) spp_getpage();
+			pud = spp_getpage();
 			set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE |
 						_PAGE_USER));
 		}
 		pud = pud_offset(p4d, (unsigned long)__va(phys));
 		if (pud_none(*pud)) {
-			pmd = (pmd_t *) spp_getpage();
+			pmd = spp_getpage();
 			set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE |
 						_PAGE_USER));
 		}
-- 
2.34.1


