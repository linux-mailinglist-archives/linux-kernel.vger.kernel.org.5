Return-Path: <linux-kernel+bounces-133791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1408589A8BC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1861F219DC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E4218029;
	Sat,  6 Apr 2024 03:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bZiu7LxW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wbOp1VyJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bZiu7LxW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wbOp1VyJ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32D4C9F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 03:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712375693; cv=none; b=LtrvW/s7G6i34XA98zQNVsh13Iw/bfNVKwu0kKCJuWW/jr6PiPARj6bC5BDHcr+4PHhxxAdFTG05p4+7JW3DQRLpAN1Jvrm04MYpwmjvKiu5VrMXz+C79SzTCvygy2DK5s6rIHQKdsWpZidVYS1c4vtcbtMhAz3XeIaj/L2LbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712375693; c=relaxed/simple;
	bh=yQB8TknNTFS3oz/usbHkiqYo4G8G3dR150QFCJqkROE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFMb3Dn8Ei4Ck4cmjbTw0TSZh+QaFhnovdQy4p8inMfJuPZShndfqOZSU/d2ePIRKEXssPWkNwuGcEChE5DAIb/+9Mg3UYBb8QOCJuceBfLZVaNUB9J181PXGzPQeQ13NJ3H1bHanXO0UJQWSCkbwK9uNoHbVr39/VE86aaX92k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bZiu7LxW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wbOp1VyJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bZiu7LxW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wbOp1VyJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 328D51F808;
	Sat,  6 Apr 2024 03:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712375689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wmAoTNWRoS2R2PrY9I6OGgAdt7uEnRmkelnWDdBbXlw=;
	b=bZiu7LxWDg9lyKYHV4RxTbmBCiQ1KPgvYhU50rb3FI2SO0GweWldqPo4vs3/kfelefGw48
	zHianIU2T2rM4WYqymLc/dCBfPgsCp2fq4iU491iaKEC+9Mxyip6fivgzUs32y5Fg4Gqd0
	F0dSZNIGx3mYclZCt40ahFFNPh/o4n0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712375689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wmAoTNWRoS2R2PrY9I6OGgAdt7uEnRmkelnWDdBbXlw=;
	b=wbOp1VyJ61hBy0dpxpT9RYlsc8qPH2dFcWgcGBCFdOlN2LM/Kc2CGCAZgPp0tzjO7JJgWq
	EvCil9xr7/01YeDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712375689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wmAoTNWRoS2R2PrY9I6OGgAdt7uEnRmkelnWDdBbXlw=;
	b=bZiu7LxWDg9lyKYHV4RxTbmBCiQ1KPgvYhU50rb3FI2SO0GweWldqPo4vs3/kfelefGw48
	zHianIU2T2rM4WYqymLc/dCBfPgsCp2fq4iU491iaKEC+9Mxyip6fivgzUs32y5Fg4Gqd0
	F0dSZNIGx3mYclZCt40ahFFNPh/o4n0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712375689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wmAoTNWRoS2R2PrY9I6OGgAdt7uEnRmkelnWDdBbXlw=;
	b=wbOp1VyJ61hBy0dpxpT9RYlsc8qPH2dFcWgcGBCFdOlN2LM/Kc2CGCAZgPp0tzjO7JJgWq
	EvCil9xr7/01YeDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A43BA138E7;
	Sat,  6 Apr 2024 03:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4fVcJYjHEGZcJQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Sat, 06 Apr 2024 03:54:48 +0000
Date: Sat, 6 Apr 2024 05:54:47 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Tony Luck <tony.luck@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Machine check recovery broken in v6.9-rc1
Message-ID: <ZhDHh_W1WZuFhsfg@localhost.localdomain>
References: <Zg8kLSl2yAlA3o5D@agluck-desk3>
 <1e943439-6044-4aa4-8c41-747e9e4dca27@redhat.com>
 <SJ1PR11MB6083AB3E55B7DE0D3FBE185EFC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZhCQPwgMWo9w3LlO@agluck-desk3>
 <ZhCxAZy-Iuz2XR7A@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhCxAZy-Iuz2XR7A@localhost.localdomain>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sat, Apr 06, 2024 at 04:18:41AM +0200, Oscar Salvador wrote:
> Tony, could you try the following patch, to see if that goes away?
> It is against 6.1, but current kernel has the same problem AFAICS.
> 
> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 578212fbf2be..575d428393c0 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -416,7 +416,7 @@ static inline bool is_pfn_swap_entry(swp_entry_t entry)
>  	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
> 
>  	return is_migration_entry(entry) || is_device_private_entry(entry) ||
> -	       is_device_exclusive_entry(entry);
> +	       is_device_exclusive_entry(entry) || is_hwpsoion_entry(entry);
>  }
> 
>  struct page_vma_mapped_walk;

Sorry, I was still sleepy and I made a typo.
Plus I realized we need to move some definitions to make them available.

This should have been (compile tested only):

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 48b700ba1d18..201efbf441d6 100644
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
+        BUG_ON(!PageLocked(page));
+        return swp_entry(SWP_HWPOISON, page_to_pfn(page));
+}
+
+static inline int is_hwpoison_entry(swp_entry_t entry)
+{
+        return swp_type(entry) == SWP_HWPOISON;
+}
+
+#else
+
+static inline swp_entry_t make_hwpoison_entry(struct page *page)
+{
+        return swp_entry(0, 0);
+}
+
+static inline int is_hwpoison_entry(swp_entry_t swp)
+{
+        return 0;
+}
+#endif
+
 typedef unsigned long pte_marker;

 #define  PTE_MARKER_UFFD_WP			BIT(0)
@@ -492,7 +521,7 @@ static inline bool is_pfn_swap_entry(swp_entry_t entry)
 	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);

 	return is_migration_entry(entry) || is_device_private_entry(entry) ||
-	       is_device_exclusive_entry(entry);
+	       is_device_exclusive_entry(entry) || is_hwpoison_entry(entry);
 }

 struct page_vma_mapped_walk;
@@ -561,35 +590,6 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
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
Oscar Salvador
SUSE Labs

