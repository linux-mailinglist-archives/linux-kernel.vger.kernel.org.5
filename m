Return-Path: <linux-kernel+bounces-84691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAB186AA32
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40911C210DE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D0B2C860;
	Wed, 28 Feb 2024 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xf0qsAU1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9rw8ia/v";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xf0qsAU1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9rw8ia/v"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A425778
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109595; cv=none; b=C96DXMx7mZnwkkJ+ojVI/QQ/NKErNyai7K+eGpaQZNtRWJUGswd53Ykjd5Ayvfe/lOFQPBR7mFlkJGax17Pfz0BARyUkwSHAHk8oZlPVk2IRGLuhqYKpTQy84ew71xnHPxr1TtXETXJBXVe9mWwcmWuCxj8UhVSqNnQrjRenNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109595; c=relaxed/simple;
	bh=zk2BKpstAg/8JIm2t8EM3S/e6qgBg8z0AtzDWzXVKAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY5Z0UFgKZRI4N91iU0J+O8hBPq2pSPlOyhL0Z+cawOf1MawLTRVWDbCrOCVA+zwtsrSPRAO3/21CIzOZEKHc4DANVq2jKx2FsCdxeQDakvmbHNfF6pvjRyqauQLIk7gVdPJNi8jZQdT/Ku4kMgI+qSuJfQh7zRWKqP581t0PNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xf0qsAU1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9rw8ia/v; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xf0qsAU1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9rw8ia/v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CDA1226B4;
	Wed, 28 Feb 2024 08:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709109590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyQQpRkr/dgNcbsO1eOjVkFSW+jjxrbD60UrCSG6L7A=;
	b=xf0qsAU1igRFXb9tEENxIyAjwHPec+aS+fIcinAzSwIoDlTMt16ZSbPZU+4PdTKWUV5sZj
	6cvnHDR5nZKIG2bIUEbDTr5JnhCafEYUef60DyQs2dR9QBrzTp2okoCyyPALYkVwBJye7k
	DORULyfPeTy7461r9CmH5bLRg9+Q22g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709109590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyQQpRkr/dgNcbsO1eOjVkFSW+jjxrbD60UrCSG6L7A=;
	b=9rw8ia/vXSxgrWnVtJr62ecULnaSFnU67U76L5iLr/T22hwwhy6PetNREl91eVn5L0CsVi
	aPah4C2nzab1upDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709109590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyQQpRkr/dgNcbsO1eOjVkFSW+jjxrbD60UrCSG6L7A=;
	b=xf0qsAU1igRFXb9tEENxIyAjwHPec+aS+fIcinAzSwIoDlTMt16ZSbPZU+4PdTKWUV5sZj
	6cvnHDR5nZKIG2bIUEbDTr5JnhCafEYUef60DyQs2dR9QBrzTp2okoCyyPALYkVwBJye7k
	DORULyfPeTy7461r9CmH5bLRg9+Q22g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709109590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyQQpRkr/dgNcbsO1eOjVkFSW+jjxrbD60UrCSG6L7A=;
	b=9rw8ia/vXSxgrWnVtJr62ecULnaSFnU67U76L5iLr/T22hwwhy6PetNREl91eVn5L0CsVi
	aPah4C2nzab1upDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C65B513A42;
	Wed, 28 Feb 2024 08:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id C7eKLVXx3mXSRAAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 28 Feb 2024 08:39:49 +0000
Date: Wed, 28 Feb 2024 09:41:02 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: hugetlb: make the hugetlb migration strategy
 consistent
Message-ID: <Zd7xnrzGb_8QiqcE@localhost.localdomain>
References: <cover.1709041586.git.baolin.wang@linux.alibaba.com>
 <bdca97e6c59f1b58f09e18defac0c47d1e38f44b.1709041586.git.baolin.wang@linux.alibaba.com>
 <Zd38_AYtr9QKp-F6@localhost.localdomain>
 <8d35b8ae-b8d8-4237-bfcf-ed63c0bb4223@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d35b8ae-b8d8-4237-bfcf-ed63c0bb4223@linux.alibaba.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xf0qsAU1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="9rw8ia/v"
X-Spamd-Result: default: False [-6.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6CDA1226B4
X-Spam-Level: 
X-Spam-Score: -6.81
X-Spam-Flag: NO

On Wed, Feb 28, 2024 at 03:40:08PM +0800, Baolin Wang wrote:
> 
> 
> On 2024/2/27 23:17, Oscar Salvador wrote:
> > On Tue, Feb 27, 2024 at 09:52:26PM +0800, Baolin Wang wrote:
> > 
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -2567,13 +2567,38 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
> > >   }
> > >   static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mask,
> > > -				     int nid, nodemask_t *nmask)
> > > +				     int nid, nodemask_t *nmask, int reason)
> > 
> > I still dislike taking the reason argument this far, and I'd rather have
> > this as a boolean specifing whether we allow fallback on other nodes.
> > That would mean parsing the reason in alloc_migration_target().
> > If we don't add a new helper e.g: gfp_allow_fallback(), we can just do
> > it right there an opencode it with a e.g: macro etc.
> > 
> > Although doing it in an inline helper might help hiding these details.
> > 
> > That's my take on this, but let's see what others have to say.
> 
> Sure. I also expressed my preference for hiding these details within the
> hugetlb core as much as possible.
> 
> Muchun, what do you think? Thanks.

JFTR: I'm talking about https://lore.kernel.org/linux-mm/ZdxXLTDZn8fD3pEn@localhost.localdomain/
or maybe something cleaner which doesn't need a new helper (we could if
we want though):

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c1ee640d87b1..ddd794e861e6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -73,6 +73,16 @@ struct resv_map {
 #endif
 };

+#define MIGRATE_MEMORY_HOTPLUG	1UL << MR_MEMORY_HOTPLUG
+#define MIGRATE_MEMORY_FAILURE	1UL << MR_MEMORY_FAILURE
+#define MIGRATE_SYSCALL		1UL << MR_SYSCALL
+#define MIGRATE_MBIND		1UL << MR_MEMPOLICY_MBIND
+#define HTLB_ALLOW_FALLBACK	(MIGRATE_MEMORY_HOTPLUG| \
+				 MIGRATE_MEMORY_FAILURE| \
+				 MIGRATE_SYSCALL| \
+				 MIGRATE_MBIND)
+
+
 /*
  * Region tracking -- allows tracking of reservations and instantiated pages
  *                    across the pages in a mapping.
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ed1581b670d4..7e8d6b5885d6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2619,7 +2619,7 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,

 /* folio migration callback function */
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask, gfp_t gfp_mask)
+		nodemask_t *nmask, gfp_t gfp_mask, bool allow_fallback)
 {
 	spin_lock_irq(&hugetlb_lock);
 	if (available_huge_pages(h)) {
@@ -2634,6 +2634,12 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 	}
 	spin_unlock_irq(&hugetlb_lock);

+	/*
+	 * We cannot fallback to other nodes, as we could break the per-node pool
+	 */
+	if (!allow_fallback)
+		gfp_mask |= GFP_THISNODE;
+
 	return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, nmask);
 }

diff --git a/mm/migrate.c b/mm/migrate.c
index cc9f2bcd73b4..c1f1d011629d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2016,10 +2016,15 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)

 	if (folio_test_hugetlb(src)) {
 		struct hstate *h = folio_hstate(src);
+		bool allow_fallback = false;
+
+		if ((1UL << reason) & HTLB_ALLOW_FALLBACK)
+			allow_fallback = true;

 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
 		return alloc_hugetlb_folio_nodemask(h, nid,
-						mtc->nmask, gfp_mask);
+						mtc->nmask, gfp_mask,
+						allow_fallback);
 	}

 	if (folio_test_large(src)) {

-- 
Oscar Salvador
SUSE Labs

