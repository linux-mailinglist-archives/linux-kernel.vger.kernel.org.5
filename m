Return-Path: <linux-kernel+bounces-142903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4D58A31DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6451C21F38
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EC4147C8F;
	Fri, 12 Apr 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZjRsN9RL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZjRsN9RL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85B1474C0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934793; cv=none; b=TjEKFIBhuVlj9TnJLnVEeLOB1p3MOMBgt6BTT1Y7an79Eraf/fDoCDXXxdj3KFl6iDsao0dXm8RXz+JHVsXwXWU6ZZNknIMkSFGb7sTSOWXRh7HDNaxWw6B4gjEWjXBzbYPbTVGtB9lnKS+38E7FhkHBV8K1OfVZ2oqylCSWbpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934793; c=relaxed/simple;
	bh=2KZ+Kxd87q0yfIkZmp+1x2DgvHUNsAD7/J2Zjtf9r4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rawdZooDTl1J8AgfmWbUBJ82cl5NRSteiUNaU+sLqnJYhXjO3SbTLmLKpEryf0mU0olTXb++1K+jN/Oywd2nS6DuFshvPukNbi6XRuXqyxKrraY2NsvcO/Xlh9sTH+7yccpoEy8XcvZamCisujnt0CktOxEoo/3nU6Og2hvcOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZjRsN9RL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZjRsN9RL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F1505FE6D;
	Fri, 12 Apr 2024 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712934790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOjZMMxtEm2r83ujlyaCMb78G694svVceNS313rwkn0=;
	b=ZjRsN9RLAq9Dr+MmClgjBktyCfMTrOM69fFLgYIRmmFF8AyK/zaEzjLnmSF72VjkI3DXlV
	mw5yYZZedYVNuhpZRLRRYlagazGeO/3gpzK1i7bcXLMyn6iFirFnKT3Hbs7orU/jw9BBpG
	mfqCtDD6R3S4m/lkxObeovxNDe4OzpM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712934790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOjZMMxtEm2r83ujlyaCMb78G694svVceNS313rwkn0=;
	b=ZjRsN9RLAq9Dr+MmClgjBktyCfMTrOM69fFLgYIRmmFF8AyK/zaEzjLnmSF72VjkI3DXlV
	mw5yYZZedYVNuhpZRLRRYlagazGeO/3gpzK1i7bcXLMyn6iFirFnKT3Hbs7orU/jw9BBpG
	mfqCtDD6R3S4m/lkxObeovxNDe4OzpM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BE251368B;
	Fri, 12 Apr 2024 15:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sbSSH4VPGWaiAQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 12 Apr 2024 15:13:09 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 1/4] x86/pat: introduce lookup_address_in_pgd_attr()
Date: Fri, 12 Apr 2024 17:12:55 +0200
Message-Id: <20240412151258.9171-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240412151258.9171-1-jgross@suse.com>
References: <20240412151258.9171-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Add lookup_address_in_pgd_attr() doing the same as the already
existing lookup_address_in_pgd(), but returning the effective settings
of the NX and RW bits of all walked page table levels, too.

This will be needed in order to match hardware behavior when looking
for effective access rights, especially for detecting writable code
pages.

In order to avoid code duplication, let lookup_address_in_pgd() call
lookup_address_in_pgd_attr() with dummy parameters.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- split off from V1 patch (Ingo Molnar)
- introduced new function (Ingo Molnar)
---
 arch/x86/include/asm/pgtable_types.h |  2 ++
 arch/x86/mm/pat/set_memory.c         | 33 +++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 0b748ee16b3d..dd05caeeeeaf 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -566,6 +566,8 @@ static inline void update_page_count(int level, unsigned long pages) { }
 extern pte_t *lookup_address(unsigned long address, unsigned int *level);
 extern pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 				    unsigned int *level);
+pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
+				  unsigned int *level, bool *nx, bool *rw);
 extern pmd_t *lookup_pmd_address(unsigned long address);
 extern phys_addr_t slow_virt_to_phys(void *__address);
 extern int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn,
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 80c9037ffadf..bfa0aae45d48 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -657,20 +657,26 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 
 /*
  * Lookup the page table entry for a virtual address in a specific pgd.
- * Return a pointer to the entry and the level of the mapping.
+ * Return a pointer to the entry, the level of the mapping, and the effective
+ * NX and RW bits of all page table levels.
  */
-pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
-			     unsigned int *level)
+pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
+				  unsigned int *level, bool *nx, bool *rw)
 {
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 
 	*level = PG_LEVEL_NONE;
+	*nx = false;
+	*rw = true;
 
 	if (pgd_none(*pgd))
 		return NULL;
 
+	*nx |= pgd_flags(*pgd) & _PAGE_NX;
+	*rw &= pgd_flags(*pgd) & _PAGE_RW;
+
 	p4d = p4d_offset(pgd, address);
 	if (p4d_none(*p4d))
 		return NULL;
@@ -679,6 +685,9 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 	if (p4d_leaf(*p4d) || !p4d_present(*p4d))
 		return (pte_t *)p4d;
 
+	*nx |= p4d_flags(*p4d) & _PAGE_NX;
+	*rw &= p4d_flags(*p4d) & _PAGE_RW;
+
 	pud = pud_offset(p4d, address);
 	if (pud_none(*pud))
 		return NULL;
@@ -687,6 +696,9 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 	if (pud_leaf(*pud) || !pud_present(*pud))
 		return (pte_t *)pud;
 
+	*nx |= pud_flags(*pud) & _PAGE_NX;
+	*rw &= pud_flags(*pud) & _PAGE_RW;
+
 	pmd = pmd_offset(pud, address);
 	if (pmd_none(*pmd))
 		return NULL;
@@ -695,11 +707,26 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 	if (pmd_leaf(*pmd) || !pmd_present(*pmd))
 		return (pte_t *)pmd;
 
+	*nx |= pmd_flags(*pmd) & _PAGE_NX;
+	*rw &= pmd_flags(*pmd) & _PAGE_RW;
+
 	*level = PG_LEVEL_4K;
 
 	return pte_offset_kernel(pmd, address);
 }
 
+/*
+ * Lookup the page table entry for a virtual address in a specific pgd.
+ * Return a pointer to the entry and the level of the mapping.
+ */
+pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
+			     unsigned int *level)
+{
+	bool nx, rw;
+
+	return lookup_address_in_pgd_attr(pgd, address, level, &nx, &rw);
+}
+
 /*
  * Lookup the page table entry for a virtual address. Return a pointer
  * to the entry and the level of the mapping.
-- 
2.35.3


