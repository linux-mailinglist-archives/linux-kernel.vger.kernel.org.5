Return-Path: <linux-kernel+bounces-133798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D0D89A8D4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391BA1F230C1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197AA18C36;
	Sat,  6 Apr 2024 04:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jzq400Hd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5uM0TCDJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Owkz9dMb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GpPWaHH6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946DF4C9F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 04:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712376849; cv=none; b=aFDJi9jL8BI2o8c4nR0KVKo2kWSdTjdBseur7Qcmea9q44sT2wIDqqs0Oxxf6BwnXQ8/V61MRdCTs6xKw/5YZHTmuo1Eq8JbX+JuzHJsYCQnvLx44vA54FVd5O2kh0jOmipo2osZLaeeRqQol6nF1MBesY8ZsFA1+Z75GOi1WL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712376849; c=relaxed/simple;
	bh=bJt5pstXR1S0wQ8PBizh43eS9g5D561sQLCLL0Lewl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DE7n2Q50Dan9C71XGhjpXn0xPVE0SlXzQFA9q0u/OSmsPox1LI/Nb7tQRBTkxo6+4vY7MrqL2YWtt/BCilteOXoa5GlxvjmR4lP+AMhlSqhUT8DzuLH5qae+yD2YytUFjsH2ND6JNFFMffMCocOmhmZwUkM41DiYwcm+EzG08EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jzq400Hd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5uM0TCDJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Owkz9dMb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GpPWaHH6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5AF0F21A21;
	Sat,  6 Apr 2024 04:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712376845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cjtIACdf56lsb48fPgau7QTbXRv0Znpoydy6nd1VoMo=;
	b=Jzq400HdO1lh6eLtb3HFEmm2ldMFdul5W3C+ve64sAgbU9KKYB0avkWEm9VcE7nyrRwCCu
	Na62CKz4d34TP6CC7JL7kSzpjSp6CcR0iyi9ncMrj9ISJs3GKaKcV4MD3v3y9ATJLO9A5O
	blFYrOcHFFg8roV/Cr/yYcpjMrhqwN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712376845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cjtIACdf56lsb48fPgau7QTbXRv0Znpoydy6nd1VoMo=;
	b=5uM0TCDJ3/pMCt6fnWLMvo7M4k7W6LXlA9krE9FCzB2Xay6yxrtnRXt8INXD1HQG+OfBtX
	/lqe86F8WBL5a6CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Owkz9dMb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GpPWaHH6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712376844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cjtIACdf56lsb48fPgau7QTbXRv0Znpoydy6nd1VoMo=;
	b=Owkz9dMb4lgQB0r6905QUzm1E6Ob1JFFYjSq1Mk6jFuKpGUIMi/qnVXSeKPZEp0SN7WHp/
	0ZKHp1PtqNa2izbzDQTa4k2gE0FbHQw31gqojdbzBteJuEFNlxZE0DYJpHyURhJ2SUJfJq
	PduY8DYapBi8HD5pDs0xrXCdO1G8vbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712376844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cjtIACdf56lsb48fPgau7QTbXRv0Znpoydy6nd1VoMo=;
	b=GpPWaHH6BlWM/r90C+svB74j6kyEMIdhu1zxya72DoVX6QQHgX0Yt/N6gwAA42WVqmMZvV
	Bzu4RcXyLdw/C3AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D93DB138E7;
	Sat,  6 Apr 2024 04:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id l6AKMgvMEGbTKQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Sat, 06 Apr 2024 04:14:03 +0000
Date: Sat, 6 Apr 2024 06:13:57 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Tony Luck <tony.luck@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Machine check recovery broken in v6.9-rc1
Message-ID: <ZhDMBZ2I9M72D87F@localhost.localdomain>
References: <Zg8kLSl2yAlA3o5D@agluck-desk3>
 <1e943439-6044-4aa4-8c41-747e9e4dca27@redhat.com>
 <SJ1PR11MB6083AB3E55B7DE0D3FBE185EFC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZhCQPwgMWo9w3LlO@agluck-desk3>
 <ZhCxAZy-Iuz2XR7A@localhost.localdomain>
 <ZhDHh_W1WZuFhsfg@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhDHh_W1WZuFhsfg@localhost.localdomain>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5AF0F21A21
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Sat, Apr 06, 2024 at 05:54:47AM +0200, Oscar Salvador wrote:
> Sorry, I was still sleepy and I made a typo.
> Plus I realized we need to move some definitions to make them available.
> 
> This should have been (compile tested only):

This one is against 6.1 (previous one was against v6.9-rc2):
Again, compile tested only

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 578212fbf2be..5d720f15e811 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -313,6 +313,55 @@ static inline int is_readable_migration_entry(swp_entry_t entry)

 #endif	/* CONFIG_MIGRATION */

+#ifdef CONFIG_MEMORY_FAILURE
+
+extern atomic_long_t num_poisoned_pages __read_mostly;
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
+static inline void num_poisoned_pages_inc(void)
+{
+	atomic_long_inc(&num_poisoned_pages);
+}
+
+static inline void num_poisoned_pages_sub(long i)
+{
+	atomic_long_sub(i, &num_poisoned_pages);
+}
+
+#else  /* CONFIG_MEMORY_FAILURE */
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
+
+static inline void num_poisoned_pages_inc(void)
+{
+}
+
+static inline void num_poisoned_pages_sub(long i)
+{
+}
+#endif  /* CONFIG_MEMORY_FAILURE */
+
 typedef unsigned long pte_marker;

 #define  PTE_MARKER_UFFD_WP  BIT(0)
@@ -416,7 +465,7 @@ static inline bool is_pfn_swap_entry(swp_entry_t entry)
 	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);

 	return is_migration_entry(entry) || is_device_private_entry(entry) ||
-	       is_device_exclusive_entry(entry);
+	       is_device_exclusive_entry(entry) || is_hwpoison_entry(entry);
 }

 struct page_vma_mapped_walk;
@@ -485,55 +534,6 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
 }
 #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */

-#ifdef CONFIG_MEMORY_FAILURE
-
-extern atomic_long_t num_poisoned_pages __read_mostly;
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
-static inline void num_poisoned_pages_inc(void)
-{
-	atomic_long_inc(&num_poisoned_pages);
-}
-
-static inline void num_poisoned_pages_sub(long i)
-{
-	atomic_long_sub(i, &num_poisoned_pages);
-}
-
-#else  /* CONFIG_MEMORY_FAILURE */
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
-
-static inline void num_poisoned_pages_inc(void)
-{
-}
-
-static inline void num_poisoned_pages_sub(long i)
-{
-}
-#endif  /* CONFIG_MEMORY_FAILURE */
-
 static inline int non_swap_entry(swp_entry_t entry)
 {
 	return swp_type(entry) >= MAX_SWAPFILES;


-- 
Oscar Salvador
SUSE Labs

