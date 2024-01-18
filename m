Return-Path: <linux-kernel+bounces-30324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36180831D18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E331F2404C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698E28DC8;
	Thu, 18 Jan 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SWDlR3Ix";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SWDlR3Ix"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42EB29431
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593571; cv=none; b=t5yIA1Ww2hFIVadXxT8p1sxGaj0PlcMCZeIOlGUAT/yv2vnX7wGnblt/ThFcoBUq2bIiiW6wNLnIneTmzU0WxAeIDicxCOV3So1NyxIGXCcKtwtaUxb9vmmGxWxbWstnOnuOv3+iuV66XU//zYEPl5+RY02vvmWSTyOV1nJXGyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593571; c=relaxed/simple;
	bh=b3F8Pn1IX2EFCVN+dNYbhJ5u14FxiHhv1zos8u5icrI=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=b1bn0u0WP0rbt41vVWsN4miwkyYjwdbEPbp1nfYPmDP4vhiN8+VcIEXNzsDBaEGZJLAzqdVvnRSFVKcK5OiHK0fQgZw+QpzPUNroc9l6S8OAADWZEpEz87UaNpGuvPw1mvs+d64cJGOSJhac9NKa5FNSP8ijTrLXUw9QbKHhSzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SWDlR3Ix; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SWDlR3Ix; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 897801F78C;
	Thu, 18 Jan 2024 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705593567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FL1eaVL1w8UaNCASvpod4Ss19US2yAmpTSN74Ny5W+M=;
	b=SWDlR3IxAI/6JPFUk/Lb+u+Z3y7881rmXAJv+4Q0Mc8Gc5pMNFjLztkCdz8ifk5VZ6zSZe
	68VizPMymw2RW/BKU/BMeYGq2vtJVFi+5EiQ+4uuVjuzZNgt8a7asVt6YmgZXmsSqhFciQ
	CmaICoSY85/ERTJ+KtTkG2+3NxwJRk4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705593567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FL1eaVL1w8UaNCASvpod4Ss19US2yAmpTSN74Ny5W+M=;
	b=SWDlR3IxAI/6JPFUk/Lb+u+Z3y7881rmXAJv+4Q0Mc8Gc5pMNFjLztkCdz8ifk5VZ6zSZe
	68VizPMymw2RW/BKU/BMeYGq2vtJVFi+5EiQ+4uuVjuzZNgt8a7asVt6YmgZXmsSqhFciQ
	CmaICoSY85/ERTJ+KtTkG2+3NxwJRk4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7346713874;
	Thu, 18 Jan 2024 15:59:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a2YpGd9KqWXSOQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 18 Jan 2024 15:59:27 +0000
Date: Thu, 18 Jan 2024 16:59:26 +0100
From: Michal Hocko <mhocko@suse.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: memory: move mem_cgroup_charge() into
 alloc_anon_folio()
Message-ID: <ZalK3suIskEyaR7m@tiehlicka>
References: <20240117103954.2756050-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117103954.2756050-1-wangkefeng.wang@huawei.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SWDlR3Ix
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: 897801F78C
X-Spam-Flag: NO

On Wed 17-01-24 18:39:54, Kefeng Wang wrote:
> mem_cgroup_charge() uses the GFP flags in a fairly sophisticated way.
> In addition to checking gfpflags_allow_blocking(), it pays attention
> to __GFP_NORETRY and __GFP_RETRY_MAYFAIL to ensure that processes within
> this memcg do not exceed their quotas. Using the same GFP flags ensures
> that we handle large anonymous folios correctly, including falling back
> to smaller orders when there is plenty of memory available in the system
> but this memcg is close to its limits.

The changelog is not really clear in the actual problem you are trying
to fix. Is this pure consistency fix or have you actually seen any
misbehavior. From the patch I suspect you are interested in THPs much
more than regular order-0 pages because those are GFP_KERNEL like when
it comes to charging. THPs have a variety of options on how aggressive
the allocation should try. From that perspective NORETRY and
RETRY_MAYFAIL are not all that interesting because costly allocations
(which THPs are) already do imply MAYFAIL and NORETRY.

GFP_TRANSHUGE_LIGHT is more interesting though because those do not dive
into the direct reclaim at all. With the current code they will reclaim
charges to free up the space for the allocated THP page and that defeats
the light mode. I have a vague recollection of preparing a patch to
address that in the past. Let me have a look at the current code...

.. So yes, we still do THP charging the way I remember
(do_huge_pmd_anonymous_page). Your patch touches handle_pte_fault ->
do_anonymous_page path which is not THP AFAICS. Or am I missing
something?
 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2:
> - fix built when !CONFIG_TRANSPARENT_HUGEPAGE
> - update changelog suggested by Matthew Wilcox
> 
>  mm/memory.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 5e88d5379127..551f0b21bc42 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4153,8 +4153,8 @@ static bool pte_range_none(pte_t *pte, int nr_pages)
>  
>  static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  {
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	struct vm_area_struct *vma = vmf->vma;
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	unsigned long orders;
>  	struct folio *folio;
>  	unsigned long addr;
> @@ -4206,15 +4206,21 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>  		folio = vma_alloc_folio(gfp, order, vma, addr, true);
>  		if (folio) {
> +			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
> +				folio_put(folio);
> +				goto next;
> +			}
> +			folio_throttle_swaprate(folio, gfp);
>  			clear_huge_page(&folio->page, vmf->address, 1 << order);
>  			return folio;
>  		}
> +next:
>  		order = next_order(&orders, order);
>  	}
>  
>  fallback:
>  #endif
> -	return vma_alloc_zeroed_movable_folio(vmf->vma, vmf->address);
> +	return folio_prealloc(vma->vm_mm, vma, vmf->address, true);
>  }
>  
>  /*
> @@ -4281,10 +4287,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	nr_pages = folio_nr_pages(folio);
>  	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
>  
> -	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
> -		goto oom_free_page;
> -	folio_throttle_swaprate(folio, GFP_KERNEL);
> -
>  	/*
>  	 * The memory barrier inside __folio_mark_uptodate makes sure that
>  	 * preceding stores to the page contents become visible before
> @@ -4338,8 +4340,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  release:
>  	folio_put(folio);
>  	goto unlock;
> -oom_free_page:
> -	folio_put(folio);
>  oom:
>  	return VM_FAULT_OOM;
>  }
> -- 
> 2.27.0
> 

-- 
Michal Hocko
SUSE Labs

