Return-Path: <linux-kernel+bounces-81031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3CB866F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE841C21D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF011EB31;
	Mon, 26 Feb 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RtSSwxVw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+CkrWWT3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RtSSwxVw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+CkrWWT3"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC91757E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938988; cv=none; b=pqpuV8QeWSUCnuJ3N6lKUHNVsG9DtYwaDFJ1LiKvOajSy1PobJiuxzlfBorCtNf7MyMfHS35CfL+fVPguVWs/pgxz3/fv6kFI6lP2Oe7Zxog8rcVSshGhCZwumudbFfOk+zLybJDEEs3Uw7mk5XLvPvIQn8L++KOyZE43aA1nlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938988; c=relaxed/simple;
	bh=2zYY/WVbaHIyHH2hIEx+SvR4cx7GacTNvzzFkyUrw6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap11WnZ+3A/0+59mbsbrRt/EBq+zOq/mBZzlOXD3tFG5sflfvd4kqnmYonIwD4C1vgOejN1GVvdfLP0ZFPtFXUHzIVauMygZifrIf5LySC4hSfr6QtP+MMcPO2En/O58LMO7X4SSfBzk48ktY2YoiQkWYGmXRPoNe7WV40jKzUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RtSSwxVw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+CkrWWT3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RtSSwxVw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+CkrWWT3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B96D01F896;
	Mon, 26 Feb 2024 09:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708938984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01Lh/WGStHWyM7FRwsHfnleUITAEUZmUv60Cm8AllUI=;
	b=RtSSwxVwDYz+kxYq+50dqSSbJRSaBEZK45YlSaq+aAdogrZR5XF5TwOObKJzydsyaoV2tZ
	wv8isuBBcMP2m1NPNG1/vEmw04MsM5uhxn3NTw5ZUzO1sc7R6S6pKH4rrMNI8pWyfD8ouf
	r8FsJqX7ZccV5vjrV0ikd2drtlHZ2MQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708938984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01Lh/WGStHWyM7FRwsHfnleUITAEUZmUv60Cm8AllUI=;
	b=+CkrWWT3rJnr//r3RtMpbWTnO713RsysU0DlV7iovUqK2aEtfXKWJaCOBtuhCDX3xFvnup
	JhjsCaFBEhjk97Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708938984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01Lh/WGStHWyM7FRwsHfnleUITAEUZmUv60Cm8AllUI=;
	b=RtSSwxVwDYz+kxYq+50dqSSbJRSaBEZK45YlSaq+aAdogrZR5XF5TwOObKJzydsyaoV2tZ
	wv8isuBBcMP2m1NPNG1/vEmw04MsM5uhxn3NTw5ZUzO1sc7R6S6pKH4rrMNI8pWyfD8ouf
	r8FsJqX7ZccV5vjrV0ikd2drtlHZ2MQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708938984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01Lh/WGStHWyM7FRwsHfnleUITAEUZmUv60Cm8AllUI=;
	b=+CkrWWT3rJnr//r3RtMpbWTnO713RsysU0DlV7iovUqK2aEtfXKWJaCOBtuhCDX3xFvnup
	JhjsCaFBEhjk97Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 33A1613A43;
	Mon, 26 Feb 2024 09:16:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id w1mdCehW3GUpEQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Mon, 26 Feb 2024 09:16:24 +0000
Date: Mon, 26 Feb 2024 10:17:33 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] mm: hugetlb: make the hugetlb migration strategy
 consistent
Message-ID: <ZdxXLTDZn8fD3pEn@localhost.localdomain>
References: <cover.1708507022.git.baolin.wang@linux.alibaba.com>
 <0514e5139b17ecf3cd9e09d86c93e586c56688dc.1708507022.git.baolin.wang@linux.alibaba.com>
 <ZdfHi142dvQuN7B-@localhost.localdomain>
 <0a06dc7f-3a49-42ba-8221-0b4a3777ac0b@linux.alibaba.com>
 <ZdipdrJoN7LS3h9m@localhost.localdomain>
 <9b49d2c8-4ace-4095-8610-8becf96eb023@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b49d2c8-4ace-4095-8610-8becf96eb023@linux.alibaba.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Mon, Feb 26, 2024 at 11:34:51AM +0800, Baolin Wang wrote:
> IMO, I'm not sure whether it's appropriate to decouple
> dequeue_hugetlb_folio_nodemask() from alloc_hugetlb_folio_nodemask() into
> two separate functions for the users to call, because these details should
> be hidden within the hugetlb core implementation.
> 
> Instead, I can move the gfp_mask fiddling into a new helper, and move the
> helper into alloc_migrate_hugetlb_folio(). Temporary hugetlb allocation has
> its own gfp strategy seems reasonable to me.

An alternative would be to do the following, which does not futher carry
the "reason" argument into hugetlb code.
(Not even compile tested, just a PoC)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c1ee640d87b1..8a89a1007dcb 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -970,6 +970,24 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return modified_mask;
 }

+static inline bool htlb_allow_fallback(int reason)
+{
+	bool allowed_fallback = false;
+
+	switch (reason) {
+	case MR_MEMORY_HOTPLUG:
+	case MR_MEMORY_FAILURE:
+	case MR_SYSCALL:
+	case MR_MEMPOLICY_MBIND:
+		allowed_fallback = true;
+		break;
+	default:
+	        break;
+	}
+
+	return allowed_fallback;
+}
+
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
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
index cc9f2bcd73b4..8820009acadd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2016,10 +2016,13 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)

 	if (folio_test_hugetlb(src)) {
 		struct hstate *h = folio_hstate(src);
+		bool allow_fallback;

 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
+		allow_fallback = htlb_allow_fallback(mtc->reason);
 		return alloc_hugetlb_folio_nodemask(h, nid,
-						mtc->nmask, gfp_mask);
+						mtc->nmask, gfp_mask,
+						allow_fallback);
 	}

 	if (folio_test_large(src)) {


-- 
Oscar Salvador
SUSE Labs

