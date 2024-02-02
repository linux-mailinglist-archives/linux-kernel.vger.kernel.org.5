Return-Path: <linux-kernel+bounces-49458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8397846A93
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2439A1F23C26
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A38F1A5BA;
	Fri,  2 Feb 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RWbrFHaE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RWbrFHaE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7CF19478
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861875; cv=none; b=K+kgcV768tARX+u1/IqctmeSex/j8zH2XS29N8OTl4u0+1EJDqqs3tXeSoSyjWR4Vra0ZUY9EruR3epeqdmfBI15N/Oyo9cxeKe91yLc7TEAGfBHLUjdgD5D3m2Jf+dVv4ftoV/MEeInINEYO9wXn8xgEgQq16HGUaA7JWrJlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861875; c=relaxed/simple;
	bh=w/TEL2v8ZoBb+9GzGVcplqqi0ckDuH2vh3rwpzZDkkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tdrfbfk2eNZh27leO/Ic0nfAsLLWxX90JOVOwrKVTe2tWKxTqUsleTm9S4RHkzyXqONLYcyfNmDl7UifWRAJ+3yYYvCRDp9/34AEuzwkjyHXm/F6hqs4NesRHR4HdD4FgrJ6ozfEUkhcU2ASxWPDSx4Ktb0swhvOAubmJIkHu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RWbrFHaE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RWbrFHaE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EDDD1F6E6;
	Fri,  2 Feb 2024 08:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706861871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeDY4msC87J87omZPSEn3RtAr9us8DFHZOwa+nJG8Dk=;
	b=RWbrFHaEjt7bJJ3ikVASgmv/k7Zh7ZxKlGoAn4Jy7agFJSw5bkBpA/rI8XtUejWKKz3qBg
	uOCd2tzbg/ZaMCK9C9iLk2WlXcqKpIBMvOwt9/a8CMp+60d4hu2LqEP2mm6ypzNYijie91
	oWlfNWGHwnFpdUjtXDEUdO1gKf9lPZ8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706861871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeDY4msC87J87omZPSEn3RtAr9us8DFHZOwa+nJG8Dk=;
	b=RWbrFHaEjt7bJJ3ikVASgmv/k7Zh7ZxKlGoAn4Jy7agFJSw5bkBpA/rI8XtUejWKKz3qBg
	uOCd2tzbg/ZaMCK9C9iLk2WlXcqKpIBMvOwt9/a8CMp+60d4hu2LqEP2mm6ypzNYijie91
	oWlfNWGHwnFpdUjtXDEUdO1gKf9lPZ8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5131913A58;
	Fri,  2 Feb 2024 08:17:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tRH2ES+lvGVAPAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 02 Feb 2024 08:17:51 +0000
Date: Fri, 2 Feb 2024 09:17:42 +0100
From: Michal Hocko <mhocko@suse.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: hugetlb: remove __GFP_THISNODE flag when
 dissolving the old hugetlb
Message-ID: <ZbylJr_bbWCUMjMl@tiehlicka>
References: <6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com>
 <Zbu4cD1XLFLfKan8@tiehlicka>
 <3f31cd89-f349-4f9e-bc29-35f29f489633@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f31cd89-f349-4f9e-bc29-35f29f489633@linux.alibaba.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri 02-02-24 09:35:58, Baolin Wang wrote:
> 
> 
> On 2/1/2024 11:27 PM, Michal Hocko wrote:
> > On Thu 01-02-24 21:31:13, Baolin Wang wrote:
> > > Since commit 369fa227c219 ("mm: make alloc_contig_range handle free
> > > hugetlb pages"), the alloc_contig_range() can handle free hugetlb pages
> > > by allocating a new fresh hugepage, and replacing the old one in the
> > > free hugepage pool.
> > > 
> > > However, our customers can still see the failure of alloc_contig_range()
> > > when seeing a free hugetlb page. The reason is that, there are few memory
> > > on the old hugetlb page's node, and it can not allocate a fresh hugetlb
> > > page on the old hugetlb page's node in isolate_or_dissolve_huge_page() with
> > > setting __GFP_THISNODE flag. This makes sense to some degree.
> > > 
> > > Later, the commit ae37c7ff79f1 (" mm: make alloc_contig_range handle
> > > in-use hugetlb pages") handles the in-use hugetlb pages by isolating it
> > > and doing migration in __alloc_contig_migrate_range(), but it can allow
> > > fallbacking to other numa node when allocating a new hugetlb in
> > > alloc_migration_target().
> > > 
> > > This introduces inconsistency to handling free and in-use hugetlb.
> > > Considering the CMA allocation and memory hotplug relying on the
> > > alloc_contig_range() are important in some scenarios, as well as keeping
> > > the consistent hugetlb handling, we should remove the __GFP_THISNODE flag
> > > in isolate_or_dissolve_huge_page() to allow fallbacking to other numa node,
> > > which can solve the failure of alloc_contig_range() in our case.
> > 
> > I do agree that the inconsistency is not really good but I am not sure
> > dropping __GFP_THISNODE is the right way forward. Breaking pre-allocated
> > per-node pools might result in unexpected failures when node bound
> > workloads doesn't get what is asssumed available. Keep in mind that our
> > user APIs allow to pre-allocate per-node pools separately.
> 
> Yes, I agree, that is also what I concered. But sometimes users don't care
> about the distribution of per-node hugetlb, instead they are more concerned
> about the success of cma allocation or memory hotplug.

Yes, sometimes the exact per-node distribution is not really important.
But the kernel has no way of knowing that right now. And we have to make
a conservative guess here.
 
> > The in-use hugetlb is a very similar case. While having a temporarily
> > misplaced page doesn't really look terrible once that hugetlb page is
> > released back into the pool we are back to the case above. Either we
> > make sure that the node affinity is restored later on or it shouldn't be
> > migrated to a different node at all.
> 
> Agree. So how about below changing?
> (1) disallow fallbacking to other nodes when handing in-use hugetlb, which
> can ensure consistent behavior in handling hugetlb.

I can see two cases here. alloc_contig_range which is an internal kernel
user and then we have memory offlining. The former shouldn't break the
per-node hugetlb pool reservations, the latter might not have any other
choice (the whole node could get offline and that resembles breaking cpu
affininty if the cpu is gone).

Now I can see how a hugetlb page sitting inside a CMA region breaks CMA
users expectations but hugetlb migration already tries hard to allocate
a replacement hugetlb so the system must be under a heavy memory
pressure if that fails, right? Is it possible that the hugetlb
reservation is just overshooted here? Maybe the memory is just terribly
fragmented though?

Could you be more specific about numbers in your failure case?

> (2) introduce a new sysctl (may be named as "hugetlb_allow_fallback_nodes")
> for users to control to allow fallbacking, that can solve the CMA or memory
> hotplug failures that users are more concerned about.

I do not think this is a good idea. The policy might be different on
each node and this would get messy pretty quickly. If anything we could
try to detect a dedicated per node pool allocation instead. It is quite
likely that if admin preallocates pool without any memory policy then
the exact distribution of pages doesn't play a huge role.

-- 
Michal Hocko
SUSE Labs

