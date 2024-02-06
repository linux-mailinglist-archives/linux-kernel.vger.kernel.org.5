Return-Path: <linux-kernel+bounces-54652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D549484B20C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381F8B214A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46A512D17A;
	Tue,  6 Feb 2024 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S9luWhIu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RWRxrMyN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C3A12D74F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214167; cv=none; b=nBAtxcdt0n1GbQC4F2VmQqfoGlIPB9fuXO43OCZB232WFHzW8i4SLCvS1oWIMcUYawX85HSLnK7bJKtiQ158h20zc5XNCYW5DSFppfNY4NUM2sBg7a6vio5zRM9h3LifeS9V/e0DTT48ZRK5ZvWt2Ag5uUKk6M7LIk5H+EucaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214167; c=relaxed/simple;
	bh=6LFp5U27NfxLRXdMn0u8CmFGxJPFXl9ATDKfDRjMdcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBFtVuBwCPKB6lAc0PV4jcbsV/pJKWcGdFzWvCbqScSMr2KWX08BKH8lpv8mp/AlYlTdT1NmutElpBi5pFwmux4AwGjCQulW6thuDVudUCDz4XysIEAQATpI1AI8TNTpj/OxKnQTbfJoQx6uNTlvulc47V4Garm61a4bhe9LDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S9luWhIu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RWRxrMyN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E460B220ED;
	Tue,  6 Feb 2024 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707214163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bojZVVLtPOGoLK1sA3uiRrSi5nB3wv52+1HQCOxhP3Y=;
	b=S9luWhIutniTZeTnBsvdZxTF/1ej85F6mm/2EOH0VjIDB9S6YYXW5geqAiM5Q2kCbXvj0H
	LJoGW5qlpMy2z4P9BE6+7GJskE2ULtXV9TLlgGfD6fMU5osa+OXoltXBonc55QIdZJbssy
	RfHrSb+QpBYpWtdlVr1c/cuEDfslpEI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707214162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bojZVVLtPOGoLK1sA3uiRrSi5nB3wv52+1HQCOxhP3Y=;
	b=RWRxrMyNzr3byS4rlwEO8LJn6UETXGxPPqKPvoSPZF1KHNW0kjUu0X2n9BcXUZiRNtHnol
	htT+K0ej1Dbwn/mMc4Y+gdBq4A5gRrQR/0Lx6S+W7y6yzWRDjZClkgyrWBbapp7w+O/V3J
	2D/94a+C2RiWfa/xvPnhPMfSoZ0uXgU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD240139D8;
	Tue,  6 Feb 2024 10:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G274NVIFwmV8egAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 06 Feb 2024 10:09:22 +0000
Date: Tue, 6 Feb 2024 11:09:18 +0100
From: Michal Hocko <mhocko@suse.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: hugetlb: improve the handling of hugetlb
 allocation failure for freed or in-use hugetlb
Message-ID: <ZcIFTqgQThcSdOHl@tiehlicka>
References: <62890fd60b1ecd5bf1cdc476c973f60fe37aa0cb.1707181934.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62890fd60b1ecd5bf1cdc476c973f60fe37aa0cb.1707181934.git.baolin.wang@linux.alibaba.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=RWRxrMyN
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -6.01
X-Rspamd-Queue-Id: E460B220ED
X-Spam-Flag: NO

On Tue 06-02-24 11:08:11, Baolin Wang wrote:
> alloc_and_dissolve_hugetlb_folio() preallocates a new hugetlb page before
> it takes hugetlb_lock. In 3 out of 4 cases the page is not really used and
> therefore the newly allocated page is just freed right away. This is
> wasteful and it might cause pre-mature failures in those cases.
> 
> Address that by moving the allocation down to the only case (hugetlb
> page is really in the free pages pool). We need to drop hugetlb_lock
> to do so and therefore need to recheck the page state after regaining
> it.
> 
> The patch is more of a cleanup than an actual fix to an existing
> problem. There are no known reports about pre-mature failures.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
> Changes from v2；
>  - Update the commit message suggested by Michal.
>  - Remove unnecessary comments.
> Changes from v1:
>  - Update the suject line per Muchun.
>  - Move the allocation into the free hugetlb handling branch per Michal.
> ---
>  mm/hugetlb.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9d996fe4ecd9..a05507a2143f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3031,21 +3031,9 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>  {
>  	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>  	int nid = folio_nid(old_folio);
> -	struct folio *new_folio;
> +	struct folio *new_folio = NULL;
>  	int ret = 0;
>  
> -	/*
> -	 * Before dissolving the folio, we need to allocate a new one for the
> -	 * pool to remain stable.  Here, we allocate the folio and 'prep' it
> -	 * by doing everything but actually updating counters and adding to
> -	 * the pool.  This simplifies and let us do most of the processing
> -	 * under the lock.
> -	 */
> -	new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, NULL, NULL);
> -	if (!new_folio)
> -		return -ENOMEM;
> -	__prep_new_hugetlb_folio(h, new_folio);
> -
>  retry:
>  	spin_lock_irq(&hugetlb_lock);
>  	if (!folio_test_hugetlb(old_folio)) {
> @@ -3075,6 +3063,16 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>  		cond_resched();
>  		goto retry;
>  	} else {
> +		if (!new_folio) {
> +			spin_unlock_irq(&hugetlb_lock);
> +			new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid,
> +							      NULL, NULL);
> +			if (!new_folio)
> +				return -ENOMEM;
> +			__prep_new_hugetlb_folio(h, new_folio);
> +			goto retry;
> +		}
> +
>  		/*
>  		 * Ok, old_folio is still a genuine free hugepage. Remove it from
>  		 * the freelist and decrease the counters. These will be
> @@ -3102,9 +3100,11 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>  
>  free_new:
>  	spin_unlock_irq(&hugetlb_lock);
> -	/* Folio has a zero ref count, but needs a ref to be freed */
> -	folio_ref_unfreeze(new_folio, 1);
> -	update_and_free_hugetlb_folio(h, new_folio, false);
> +	if (new_folio) {
> +		/* Folio has a zero ref count, but needs a ref to be freed */
> +		folio_ref_unfreeze(new_folio, 1);
> +		update_and_free_hugetlb_folio(h, new_folio, false);
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.39.3
> 

-- 
Michal Hocko
SUSE Labs

