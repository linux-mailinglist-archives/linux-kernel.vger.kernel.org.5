Return-Path: <linux-kernel+bounces-134395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4AE89B0F7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8E41C20849
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454333838F;
	Sun,  7 Apr 2024 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2KO/DJmV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ftE4mxiq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="11kQdusK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b1GRYztO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6F825745;
	Sun,  7 Apr 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495158; cv=none; b=rBT0t3pLrhKM+0r/RfYwXVogu4HmCacCWKGOfm1OEqz0g3bZv3I6uM7YTzbHy2vfA9Qhi6Z2snDbGykdiUrGMSq4uut7dsMMiXm8REX4OCXF8pU6q310fQ8j7nbkZRP237TIUsG+sWbhPl8nI9VKfIPM6YByCKlLXUNNDJOs6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495158; c=relaxed/simple;
	bh=K6HcT4y4Ugz2ZCMyMPN622D3EmrRbqTPBq2b8S/ir2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fErrrSeMHyxPBmEQgcoIcvu/j6taCYh1iC85rvuSYmSy9p69DFmQKvDO6DRina9rPtdT4d+ezCQA9ZejSxIO9+v2b7/12ZgSLcIpqtt9YzoM9eYJsDS+T90fpI1NCUMfHIKqxaYcrJhjc9vBSzb3Q+TQ1AG9hGGYX3IBd26RFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2KO/DJmV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ftE4mxiq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=11kQdusK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b1GRYztO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0948321C63;
	Sun,  7 Apr 2024 13:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712495154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+qGlEDHzb7FpeLjonTz5IywzApZvF8isqA+3qX4uTqc=;
	b=2KO/DJmVlWLwlOtRKvqvGbMboDYBH7XvgAY96MSIU+p2/mcEMgqYm0zCoY0UiiYkLlmfNd
	SZYwUP2Ce7mjRwxKXi35f7R8bkOCqBn3AVRPRGLkHaeeLSbH8FGkjvzYIgb7EAZQQ2buNH
	JogiPUvA2wsBBjex3mqUshQq22DMy+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712495154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+qGlEDHzb7FpeLjonTz5IywzApZvF8isqA+3qX4uTqc=;
	b=ftE4mxiqJ9fwKCk+l8nytwyWct/mrgohQy55PbmD8Bl6Uc+14ZP1O6reM7vsTGOuxl1ThE
	wM58OqDCrh8uMIBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=11kQdusK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b1GRYztO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712495153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+qGlEDHzb7FpeLjonTz5IywzApZvF8isqA+3qX4uTqc=;
	b=11kQdusKXO52CX7ndjEh1QLOe//sOt2mH0JDv8ya7h+XOA9ACbTv8Sy0YFJTwqJzPCr43M
	Zwx/WrDA1Dh/znkMy6OPMVy4ExcYT9dXpDG5ThInHXLSi67uF0XJVZUcKLs0GG9bM9NqxT
	5lD5rxn2hRPcoktrrf8gVfPvwYgvjmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712495153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+qGlEDHzb7FpeLjonTz5IywzApZvF8isqA+3qX4uTqc=;
	b=b1GRYztO14KMD0OEKnjw5YGVMFvVdei3gUIl2Jut8bSAwUuQ6zxhjpMRzOwM2DOjpv0fdQ
	Sc9lmXdNuoil3oBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 716C7132FF;
	Sun,  7 Apr 2024 13:05:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id K/XtGDCaEmYGDQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Sun, 07 Apr 2024 13:05:52 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	stable@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] mm,swapops: Update check in is_pfn_swap_entry for hwpoison entries
Date: Sun,  7 Apr 2024 15:05:37 +0200
Message-ID: <20240407130537.16977-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0948321C63
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,intel.com:email,suse.de:dkim,suse.de:email]

Tony reported that the Machine check recovery was broken in v6.9-rc1,
as he was hitting a VM_BUG_ON when injecting uncorrectable memory errors
to DRAM.
After some more digging and debugging on his side, he realized that this
went back to v6.1, with the introduction of 'commit 0d206b5d2e0d ("mm/swap: add
swp_offset_pfn() to fetch PFN from swap entry")'.
That commit, among other things, introduced swp_offset_pfn(), replacing
hwpoison_entry_to_pfn() in its favour.

The patch also introduced a VM_BUG_ON() check for is_pfn_swap_entry(),
but is_pfn_swap_entry() never got updated to cover hwpoison entries, which
means that we would hit the VM_BUG_ON whenever we would call
swp_offset_pfn() for such entries on environments with CONFIG_DEBUG_VM set.
Fix this by updating the check to cover hwpoison entries as well, and update
the comment while we are it.

Reported-by: Tony Luck <tony.luck@intel.com>
Closes: https://lore.kernel.org/all/Zg8kLSl2yAlA3o5D@agluck-desk3/
Tested-by: Tony Luck <tony.luck@intel.com>
Fixes: 0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")
Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/swapops.h | 65 +++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 48b700ba1d18..a5c560a2f8c2 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -390,6 +390,35 @@ static inline bool is_migration_entry_dirty(swp_entry_t entry)
 }
 #endif	/* CONFIG_MIGRATION */
 
+#ifdef CONFIG_MEMORY_FAILURE
+
+/*
+ * Support for hardware poisoned pages
+ */
+static inline swp_entry_t make_hwpoison_entry(struct page *page)
+{
+	BUG_ON(!PageLocked(page));
+	return swp_entry(SWP_HWPOISON, page_to_pfn(page));
+}
+
+static inline int is_hwpoison_entry(swp_entry_t entry)
+{
+	return swp_type(entry) == SWP_HWPOISON;
+}
+
+#else
+
+static inline swp_entry_t make_hwpoison_entry(struct page *page)
+{
+	return swp_entry(0, 0);
+}
+
+static inline int is_hwpoison_entry(swp_entry_t swp)
+{
+	return 0;
+}
+#endif
+
 typedef unsigned long pte_marker;
 
 #define  PTE_MARKER_UFFD_WP			BIT(0)
@@ -483,8 +512,9 @@ static inline struct folio *pfn_swap_entry_folio(swp_entry_t entry)
 
 /*
  * A pfn swap entry is a special type of swap entry that always has a pfn stored
- * in the swap offset. They are used to represent unaddressable device memory
- * and to restrict access to a page undergoing migration.
+ * in the swap offset. They can either be used to represent unaddressable device
+ * memory, to restrict access to a page undergoing migration or to represent a
+ * pfn which has been hwpoisoned and unmapped.
  */
 static inline bool is_pfn_swap_entry(swp_entry_t entry)
 {
@@ -492,7 +522,7 @@ static inline bool is_pfn_swap_entry(swp_entry_t entry)
 	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
 
 	return is_migration_entry(entry) || is_device_private_entry(entry) ||
-	       is_device_exclusive_entry(entry);
+	       is_device_exclusive_entry(entry) || is_hwpoison_entry(entry);
 }
 
 struct page_vma_mapped_walk;
@@ -561,35 +591,6 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
 }
 #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
-#ifdef CONFIG_MEMORY_FAILURE
-
-/*
- * Support for hardware poisoned pages
- */
-static inline swp_entry_t make_hwpoison_entry(struct page *page)
-{
-	BUG_ON(!PageLocked(page));
-	return swp_entry(SWP_HWPOISON, page_to_pfn(page));
-}
-
-static inline int is_hwpoison_entry(swp_entry_t entry)
-{
-	return swp_type(entry) == SWP_HWPOISON;
-}
-
-#else
-
-static inline swp_entry_t make_hwpoison_entry(struct page *page)
-{
-	return swp_entry(0, 0);
-}
-
-static inline int is_hwpoison_entry(swp_entry_t swp)
-{
-	return 0;
-}
-#endif
-
 static inline int non_swap_entry(swp_entry_t entry)
 {
 	return swp_type(entry) >= MAX_SWAPFILES;
-- 
2.44.0


