Return-Path: <linux-kernel+bounces-52275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C98C849623
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DAB1F20FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34779125B6;
	Mon,  5 Feb 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qKTU9ewp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qKTU9ewp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151E711CB9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124537; cv=none; b=IAwZm2BxcdPhinT1IXgslLbMt+dQ+dZB649vCCHaZShWio9ok7I8qJCiQxvBkkQQa+zseXhQsQQp8M7LxSqxwbIC5cr1s/Rple/oH7H0w4u47vYuswUxDsvEXoojkcpCUAcc6f3DsVbmtFvIubc2nSe+c5N1xoF8ZmWbRZrB1Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124537; c=relaxed/simple;
	bh=a6ZgGQTGAxJ/Z5KViZ0alVaxiSsTOqe+sXqKm6bvGRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOM4DuzgPC25/r2OWifurbIwGl6gvBXlCgKH5tHiGYTdLaRXWE9l5DILP6gxBZlYNtJlvlhPhDzehL9P7KnDKJCO93wMjpdXmAbm650SwyHyzgBDzhNMuBODHZ7YrXsU7+CmfmFnc/XZBCOUn3IVULWBWFrr/ERFJ8cS6H4Fe0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qKTU9ewp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qKTU9ewp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E5DB21FFA;
	Mon,  5 Feb 2024 09:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707124533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/F0fcF3Z96Q/6k6w7oh+pw21yZT+nD+ErdnBcIl+JiM=;
	b=qKTU9ewp7/YqdPnZQqHeI2LP1zp8Jc7w6pZDu57zvVDrll3GI9A2xtGvf3U4LLrZ/gPlx/
	fl6TT3bN7C8Z+lzHcoj6JBph6AAioBuhvffcso/s8CnhwIYH/J+8HDylc69vC467yX1gnH
	N/djW0rwcD/BwFz8WNFrfN0YlAtx+Oc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707124533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/F0fcF3Z96Q/6k6w7oh+pw21yZT+nD+ErdnBcIl+JiM=;
	b=qKTU9ewp7/YqdPnZQqHeI2LP1zp8Jc7w6pZDu57zvVDrll3GI9A2xtGvf3U4LLrZ/gPlx/
	fl6TT3bN7C8Z+lzHcoj6JBph6AAioBuhvffcso/s8CnhwIYH/J+8HDylc69vC467yX1gnH
	N/djW0rwcD/BwFz8WNFrfN0YlAtx+Oc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30161132DD;
	Mon,  5 Feb 2024 09:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rv+3CDWnwGU0GwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 05 Feb 2024 09:15:33 +0000
Date: Mon, 5 Feb 2024 10:15:32 +0100
From: Michal Hocko <mhocko@suse.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: hugetlb: remove __GFP_THISNODE flag when
 dissolving the old hugetlb
Message-ID: <ZcCnNPkNpE7KTHZu@tiehlicka>
References: <6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com>
 <Zbu4cD1XLFLfKan8@tiehlicka>
 <3f31cd89-f349-4f9e-bc29-35f29f489633@linux.alibaba.com>
 <ZbylJr_bbWCUMjMl@tiehlicka>
 <f1606912-5bcc-46be-b4f4-666149eab7bd@linux.alibaba.com>
 <Zby7-dTtPIy2k5pj@tiehlicka>
 <909cee7d-0201-4429-b85d-7d2662516e45@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <909cee7d-0201-4429-b85d-7d2662516e45@linux.alibaba.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Mon 05-02-24 10:50:32, Baolin Wang wrote:
> 
> 
> On 2/2/2024 5:55 PM, Michal Hocko wrote:
> > On Fri 02-02-24 17:29:02, Baolin Wang wrote:
> > > On 2/2/2024 4:17 PM, Michal Hocko wrote:
> > [...]
> > > > > Agree. So how about below changing?
> > > > > (1) disallow fallbacking to other nodes when handing in-use hugetlb, which
> > > > > can ensure consistent behavior in handling hugetlb.
> > > > 
> > > > I can see two cases here. alloc_contig_range which is an internal kernel
> > > > user and then we have memory offlining. The former shouldn't break the
> > > > per-node hugetlb pool reservations, the latter might not have any other
> > > > choice (the whole node could get offline and that resembles breaking cpu
> > > > affininty if the cpu is gone).
> > > 
> > > IMO, not always true for memory offlining, when handling a free hugetlb, it
> > > disallows fallbacking, which is inconsistent.
> > 
> > It's been some time I've looked into that code so I am not 100% sure how
> > the free pool is currently handled. The above is the way I _think_ it
> > should work from the usability POV.
> 
> Please see alloc_and_dissolve_hugetlb_folio().

This is the alloc_contig_range rather than offlining path. Page
offlining migrates in-use pages to a _different_ node (as long as there is one
available) via do_migrate_range and it disolves free hugetlb pages via
dissolve_free_huge_pages. So the node's pool is altered but as this is
an explicit offling operation I think there is not choice to go
differently.
 
> > > Not only memory offlining, but also the longterm pinning (in
> > > migrate_longterm_unpinnable_pages()) and memory failure (in
> > > soft_offline_in_use_page()) can also break the per-node hugetlb pool
> > > reservations.
> > 
> > Bad
> > 
> > > > Now I can see how a hugetlb page sitting inside a CMA region breaks CMA
> > > > users expectations but hugetlb migration already tries hard to allocate
> > > > a replacement hugetlb so the system must be under a heavy memory
> > > > pressure if that fails, right? Is it possible that the hugetlb
> > > > reservation is just overshooted here? Maybe the memory is just terribly
> > > > fragmented though?
> > > > 
> > > > Could you be more specific about numbers in your failure case?
> > > 
> > > Sure. Our customer's machine contains serveral numa nodes, and the system
> > > reserves a large number of CMA memory occupied 50% of the total memory which
> > > is used for the virtual machine, meanwhile it also reserves lots of hugetlb
> > > which can occupy 50% of the CMA. So before starting the virtual machine, the
> > > hugetlb can use 50% of the CMA, but when starting the virtual machine, the
> > > CMA will be used by the virtual machine and the hugetlb should be migrated
> > > from CMA.
> > 
> > Would it make more sense for hugetlb pages to _not_ use CMA in this
> > case? I mean would be better off overall if the hugetlb pool was
> > preallocated before the CMA is reserved? I do realize this is just
> > working around the current limitations but it could be better than
> > nothing.
> 
> In this case, the CMA area is large and occupies 50% of the total memory.
> The purpose is that, if no virtual machines are launched, then CMA memory
> can be used by hugetlb as much as possible. Once the virtual machines need
> to be launched, it is necessary to allocate CMA memory as much as possible,
> such as migrating hugetlb from CMA memory.

I am afraid that your assumption doesn't correspond to the existing
implemntation. hugetlb allocations are movable but they are certainly
not as movable as regular pages. So you have to consider a bigger
margin and spare memory to achieve a more reliable movability.

Have you tried to handle this from the userspace. It seems that you know
when there is the CMA demand to you could rebalance hugetlb pools at
that moment, no?
 
> After more thinking, I think we should still drop the __GFP_THISNODE flag in
> alloc_and_dissolve_hugetlb_folio(). Firstly, not only it potentially cause
> CMA allocation to fail, but it might also cause memory offline to fail like
> I said in the commit message. Secondly, there have been no user reports
> complaining about breaking the per-node hugetlb pool, although longterm
> pinning, memory failure, and memory offline can potentially break the
> per-node hugetlb pool.

It is quite possible that traditional users (like large DBs) do not use
CMA heavily so such a problem was not observed so far. That doesn't mean
those problems do not really matter.

-- 
Michal Hocko
SUSE Labs

