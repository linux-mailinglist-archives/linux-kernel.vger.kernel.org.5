Return-Path: <linux-kernel+bounces-131413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E18AF89877E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6E11C21088
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952B7128398;
	Thu,  4 Apr 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qofd5n/t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="axmGiTcH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qofd5n/t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="axmGiTcH"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA037127B6A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233581; cv=none; b=u+DMrmbK4ClRg4XCXTocaia0MsuJrFSmTF7ZsTmFSnmbfUJjUxDlDIRJShRvv37l9p9Gf/RDBPUdZdWkTlcjNDeziOgC0HupUcSrDbfqQhxU6TdBKyV1gb3y/wsheaAkSlZJ4CmLVma2ZhVBeLr7sPyMtKHWJCyp0F8JqW8gsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233581; c=relaxed/simple;
	bh=YLTKhOijlN00zs6uhZzcSfA/PrpGaDrjnPnIf5l8Vd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbTfcrkOBmq8pt3Xkz8eLuCvNIRRhpUHHmmLRDH/SlKfYW0XaSbnHnKGANxp/3VOfdQBAeCgYoUVbVpyh5lsVBt2h3XVUbrqdsdE58skoQTTMIzQijvXR1hb8CAa+iO1gAKg3ZyUPV24BmfUHXotU7euR+4Ry5s9gt7vz9mllsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qofd5n/t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=axmGiTcH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qofd5n/t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=axmGiTcH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E40225D942;
	Thu,  4 Apr 2024 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712233577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kaNBuiDg+Yyb0ktBS/Z1u/Z6C+/cWf4P8ez4emkur5c=;
	b=qofd5n/tkDGjc5eFhdijwPecpVxKwVFrwnJo0HHEfIYVm4D1KQeCM629Q5yYPYYxD1j1lY
	g5eThqmJ3r9lW7YEz1zrQQKcO2c8jUHTYdaK4Zh33fSw3bq1068Fn+qHBKWeQaAb6353uO
	V6wlUdL4fSyy0zkjLdxKtKj1G7qe1Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712233577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kaNBuiDg+Yyb0ktBS/Z1u/Z6C+/cWf4P8ez4emkur5c=;
	b=axmGiTcH8F+XOxRTFHuKUxRS/ZYSLNUgepiydq7vuOUX86gOCJJCN9fh2biAwvkUcdCLqp
	+gr/R2Avugsx4gAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="qofd5n/t";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=axmGiTcH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712233577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kaNBuiDg+Yyb0ktBS/Z1u/Z6C+/cWf4P8ez4emkur5c=;
	b=qofd5n/tkDGjc5eFhdijwPecpVxKwVFrwnJo0HHEfIYVm4D1KQeCM629Q5yYPYYxD1j1lY
	g5eThqmJ3r9lW7YEz1zrQQKcO2c8jUHTYdaK4Zh33fSw3bq1068Fn+qHBKWeQaAb6353uO
	V6wlUdL4fSyy0zkjLdxKtKj1G7qe1Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712233577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kaNBuiDg+Yyb0ktBS/Z1u/Z6C+/cWf4P8ez4emkur5c=;
	b=axmGiTcH8F+XOxRTFHuKUxRS/ZYSLNUgepiydq7vuOUX86gOCJJCN9fh2biAwvkUcdCLqp
	+gr/R2Avugsx4gAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 82C1113AA3;
	Thu,  4 Apr 2024 12:26:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pYszHWmcDmaSXwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 04 Apr 2024 12:26:17 +0000
Date: Thu, 4 Apr 2024 14:27:37 +0200
From: Oscar Salvador <osalvador@suse.de>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, muchun.song@linux.dev,
	willy@infradead.org
Subject: Re: [PATCH v2 1/3] hugetlb: Convert hugetlb_fault() to use struct
 vm_fault
Message-ID: <Zg6cualUqcsZYZxf@localhost.localdomain>
References: <20240401202651.31440-1-vishal.moola@gmail.com>
 <20240401202651.31440-2-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401202651.31440-2-vishal.moola@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.96 / 50.00];
	BAYES_HAM(-1.95)[94.77%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E40225D942
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.96

On Mon, Apr 01, 2024 at 01:26:49PM -0700, Vishal Moola (Oracle) wrote:
> Now that hugetlb_fault() has a vm_fault available for fault tracking, use
> it throughout. This cleans up the code by removing 2 variables, and
> prepares hugetlb_fault() to take in a struct vm_fault argument.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

A question below:

>  mm/hugetlb.c | 84 +++++++++++++++++++++++++---------------------------
>  1 file changed, 41 insertions(+), 43 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8267e221ca5d..360b82374a89 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
..  
>  	/*
> -	 * entry could be a migration/hwpoison entry at this point, so this
> -	 * check prevents the kernel from going below assuming that we have
> -	 * an active hugepage in pagecache. This goto expects the 2nd page
> -	 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
> -	 * properly handle it.
> +	 * vmf.orig_pte could be a migration/hwpoison vmf.orig_pte at this

"vmf.orig_pte could be a migration/hwpoison entry at ..."

> -	entry = pte_mkyoung(entry);
> -	if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
> +	vmf.orig_pte = pte_mkyoung(vmf.orig_pte);
> +	if (huge_ptep_set_access_flags(vma, vmf.address, vmf.pte, vmf.orig_pte,
>  						flags & FAULT_FLAG_WRITE))

Would it make sense to teach huge_ptep_set_access_flags/set_huge_pte_at() to use
vm_fault struct as well? All info we are passing is stored there.
Maybe it is not worth the trouble though, just asking.


-- 
Oscar Salvador
SUSE Labs

