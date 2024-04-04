Return-Path: <linux-kernel+bounces-131467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB9C89883A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17391F2309C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BAA8613E;
	Thu,  4 Apr 2024 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ISdw1Kg1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IGW5qOax";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ISdw1Kg1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IGW5qOax"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B486E613
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234950; cv=none; b=eW+M+eq9ws/k3L5nmNwdgv2kaTchhzBYsmefB0NMhOprr4TwfgifWLO2w9fUdGEZwsCjg1hh7/X9YRFU0u6KNmNnq6Cl1c+VS58fzfJ+NFfUwdLtpgYcqmAU/makTpzvFttXNQVxZjIbGRs8pVWrApKGe7GrvXbXikQUUhLSBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234950; c=relaxed/simple;
	bh=QyZhfVCs+m1G4gOeHX67Ge1/BAXef3MBHMSS+UUONXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEzb90NvNepYJyahCZllD3pXXTau3ybbQgFbBShoMq5Z/KVldTMrS+UJ0CxGS+6IzQDTZTomeDpkULfrBFjmmryy0M9+XDfv32m50oyL2nl0CAeDQua6d3QDXbYabQE4aWxTOrfsf7NbWp2DDiU1n4PgtvEGsDMTO68RCSBUd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ISdw1Kg1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IGW5qOax; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ISdw1Kg1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IGW5qOax; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D14A5D96E;
	Thu,  4 Apr 2024 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712234947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+/HnAezjLRt9n4+iHb7cFTsC2LplwLc1xaDDtuWmYQ=;
	b=ISdw1Kg1i/QVu6zSkWOMz9Jh/1suGDLE1PYIDN9nIEk+7ZBzZvDTr0z0zCzuD2dt9/T395
	0xE9NEJ9JYInCD6F4e8ZEa0P8tkZpcIMHEqgwkTkNU3Fut/+n29AeQLkOARGAsekwco5SW
	txWqINeYZf7BLMfPSePGFMQ5SxT9p+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712234947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+/HnAezjLRt9n4+iHb7cFTsC2LplwLc1xaDDtuWmYQ=;
	b=IGW5qOaxj28jRVQFpkY2likrWYQdrhvkzIEs8EBHjYEgt/b4Y6mf5Mvfht7Ro+yvLAXbld
	xuXOuA6HBxBCglDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712234947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+/HnAezjLRt9n4+iHb7cFTsC2LplwLc1xaDDtuWmYQ=;
	b=ISdw1Kg1i/QVu6zSkWOMz9Jh/1suGDLE1PYIDN9nIEk+7ZBzZvDTr0z0zCzuD2dt9/T395
	0xE9NEJ9JYInCD6F4e8ZEa0P8tkZpcIMHEqgwkTkNU3Fut/+n29AeQLkOARGAsekwco5SW
	txWqINeYZf7BLMfPSePGFMQ5SxT9p+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712234947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+/HnAezjLRt9n4+iHb7cFTsC2LplwLc1xaDDtuWmYQ=;
	b=IGW5qOaxj28jRVQFpkY2likrWYQdrhvkzIEs8EBHjYEgt/b4Y6mf5Mvfht7Ro+yvLAXbld
	xuXOuA6HBxBCglDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E996139E8;
	Thu,  4 Apr 2024 12:49:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mzMBAcOhDmYNZwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 04 Apr 2024 12:49:07 +0000
Date: Thu, 4 Apr 2024 14:50:35 +0200
From: Oscar Salvador <osalvador@suse.de>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, muchun.song@linux.dev,
	willy@infradead.org
Subject: Re: [PATCH v2 2/3] hugetlb: Convert hugetlb_no_page() to use struct
 vm_fault
Message-ID: <Zg6iG8cxpopXuFCo@localhost.localdomain>
References: <20240401202651.31440-1-vishal.moola@gmail.com>
 <20240401202651.31440-3-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401202651.31440-3-vishal.moola@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -0.06
X-Spam-Level: 
X-Spamd-Result: default: False [-0.06 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.26)[73.53%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]

On Mon, Apr 01, 2024 at 01:26:50PM -0700, Vishal Moola (Oracle) wrote:
> hugetlb_no_page() can use the struct vm_fault passed in from
> hugetlb_fault(). This alleviates the stack by consolidating 7
> variables into a single struct.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  mm/hugetlb.c | 59 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 29 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 360b82374a89..aca2f11b4138 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6189,9 +6189,7 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
>  
>  static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  			struct vm_area_struct *vma,
> -			struct address_space *mapping, pgoff_t idx,
> -			unsigned long address, pte_t *ptep,
> -			pte_t old_pte, unsigned int flags,
> +			struct address_space *mapping,

AFAICS all this can be self-contained in vm_fault struct.
vmf->vma->mm and vmf->vma.
I mean, if we want to convert this interface, why not going all the way?

Looks a bit odd some fields yes while some others remain.

Or am I missing something?

-- 
Oscar Salvador
SUSE Labs

