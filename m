Return-Path: <linux-kernel+bounces-52299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2495E84967C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C4B1C22132
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7680212B87;
	Mon,  5 Feb 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A+FdiCLx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A+FdiCLx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7B12B7A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125493; cv=none; b=lA+ASeY6f+Qd8CdHDmuOXYDQUp6rLdQmjpUD7sQn3fERPLmtEBtTjQsY1SzE3Dgn5hVohucppf59uFga7wdXlqgsTzhzL9RCe8hpoQnzMjjjR/XLMHD3DlJ7VuSOzfgJS1e1lMkMhy31lT4NVtCH6ZBwTwDj5PaEgyXv8CUpshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125493; c=relaxed/simple;
	bh=UL684BaIf4kAVL5h6wHa3zxyK/nhEa4FuC7tBtpI68I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+nWTrvINfItdTE3sbT/+QQwxVBqH9W4pdmsJ97Yt15L2CFGNJaBGDxPggieKdSv1phaHkbbci7KkvYaXvNNC+9f0WDFatWyJk2RIpwgV9UiE6xgdFmqnLUUCQHsTNsRx6fvnBVLPlQdrAAohmdzUR3Sd3Crw5VLjl1GG5wbZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A+FdiCLx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A+FdiCLx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8DCAE22105;
	Mon,  5 Feb 2024 09:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707125489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHKojVI/8ySxfySQRj9+91SsbIPCFSWZG8hNQz2bKC0=;
	b=A+FdiCLxQ2gODITcsJtDVVKXcIr3wUKZ04FqK+ifSv1l7tHErcPUwO34233AP4xq58mKRw
	3GbgrTC4uxYzFDoTnI0vYfdDuwPjhbOUbMKgxIYJ5xOEfm4Aij8+sbkfG471b7N1zExYC6
	Q7UtS8ZFnOYQZLYzExEQ8sS7ysUCNQg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707125489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHKojVI/8ySxfySQRj9+91SsbIPCFSWZG8hNQz2bKC0=;
	b=A+FdiCLxQ2gODITcsJtDVVKXcIr3wUKZ04FqK+ifSv1l7tHErcPUwO34233AP4xq58mKRw
	3GbgrTC4uxYzFDoTnI0vYfdDuwPjhbOUbMKgxIYJ5xOEfm4Aij8+sbkfG471b7N1zExYC6
	Q7UtS8ZFnOYQZLYzExEQ8sS7ysUCNQg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60C98136F5;
	Mon,  5 Feb 2024 09:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ky2fFPGqwGWiHwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 05 Feb 2024 09:31:29 +0000
Date: Mon, 5 Feb 2024 10:31:28 +0100
From: Michal Hocko <mhocko@suse.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: fix hugetlb allocation failure when
 handling freed or in-use hugetlb
Message-ID: <ZcCq8L6KpmAs11py@tiehlicka>
References: <b2e6ce111400670d8021baf4d7ac524ae78a40d5.1707105047.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e6ce111400670d8021baf4d7ac524ae78a40d5.1707105047.git.baolin.wang@linux.alibaba.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=A+FdiCLx
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 8DCAE22105
X-Spam-Flag: NO

On Mon 05-02-24 11:54:17, Baolin Wang wrote:
> When handling the freed hugetlb or in-use hugetlb, we should ignore the
> failure of alloc_buddy_hugetlb_folio() to dissolve the old hugetlb successfully,
> since we did not use the new allocated hugetlb in this 2 cases.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9d996fe4ecd9..212ab331d355 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3042,9 +3042,8 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>  	 * under the lock.
>  	 */
>  	new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, NULL, NULL);
> -	if (!new_folio)
> -		return -ENOMEM;
> -	__prep_new_hugetlb_folio(h, new_folio);
> +	if (new_folio)
> +		__prep_new_hugetlb_folio(h, new_folio);

Is there any reason why you haven't moved the allocation to the only
branch that actually needs it? I know that we hold hugetlb lock but you
could have easily dropped the lock, allocate a page and then goto retry.
This would actually save an allocation.

Something like this:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ed1581b670d4..db5f72b94422 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3029,21 +3029,9 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 	int nid = folio_nid(old_folio);
-	struct folio *new_folio;
+	struct folio *new_folio = NULL;
 	int ret = 0;
 
-	/*
-	 * Before dissolving the folio, we need to allocate a new one for the
-	 * pool to remain stable.  Here, we allocate the folio and 'prep' it
-	 * by doing everything but actually updating counters and adding to
-	 * the pool.  This simplifies and let us do most of the processing
-	 * under the lock.
-	 */
-	new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, NULL, NULL);
-	if (!new_folio)
-		return -ENOMEM;
-	__prep_new_hugetlb_folio(h, new_folio);
-
 retry:
 	spin_lock_irq(&hugetlb_lock);
 	if (!folio_test_hugetlb(old_folio)) {
@@ -3073,6 +3061,15 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		cond_resched();
 		goto retry;
 	} else {
+
+		if (!new_folio) {
+			spin_unlock_irq(&hugetlb_lock);
+			new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, NULL, NULL);
+			if (!new_folio)
+				return -ENOMEM;
+			__prep_new_hugetlb_folio(h, new_folio);
+			goto retry;
+		}
 		/*
 		 * Ok, old_folio is still a genuine free hugepage. Remove it from
 		 * the freelist and decrease the counters. These will be
@@ -3100,9 +3097,11 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 
 free_new:
 	spin_unlock_irq(&hugetlb_lock);
-	/* Folio has a zero ref count, but needs a ref to be freed */
-	folio_ref_unfreeze(new_folio, 1);
-	update_and_free_hugetlb_folio(h, new_folio, false);
+	if (new_folio) {
+		/* Folio has a zero ref count, but needs a ref to be freed */
+		folio_ref_unfreeze(new_folio, 1);
+		update_and_free_hugetlb_folio(h, new_folio, false);
+	}
 
 	return ret;
 }
-- 
Michal Hocko
SUSE Labs

