Return-Path: <linux-kernel+bounces-48409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4D845B8C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB471F2C02B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EF077A07;
	Thu,  1 Feb 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CD6Xr1pc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CD6Xr1pc"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945462166
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801269; cv=none; b=FpJzIqfjreWfMbIVmHAh7P13g/lZAHKSCyyZ90H3SzT3l2vM3twmWbh0aL7dZVviqPbipJ38FPcVhc1AgG3Q79JuQG1VN+VMWeYLuV1S4GF7BIDDcdfz4f3WCPhrOq9iUjCRShrmrIwofBPIJAdM0vCe6Raj0fzZi5EjBHfwAvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801269; c=relaxed/simple;
	bh=fE8MeC5OUYILXw2iVfVL7PRnwrgLXZ44twPWRJqIZzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGsJ21nRW05rR/gY7ESNjWN550KqQItIiHXACrPNBxa+ef0dntyauDUUZR16jMvzE6Q54PoT2pkLXqw7P4od4YLvfau7abPUSaXK/ypaK3IIdk72g9HZgG7rrItFFxHDezbM7jp8fWetB7aEb1JaZ6tD/csyuGwDEraxvjqCAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CD6Xr1pc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CD6Xr1pc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 387E42207F;
	Thu,  1 Feb 2024 15:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706801265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tG3CpxDS02v6gYxnYwbFaNjzAhNUjXma24vFvRO3lrE=;
	b=CD6Xr1pcp1MOpdXP7WUqj63Qf9UNGqBnq1lU3nlxRU2oiJsOqc9pjRFzb2RVBWVeuIrLvW
	MwVuRtzHVs2chgGpu8cQStRn0+VRLRR5TLvqCVNtHxCQKFQbmPBkfwTvO+z9M31GF6bktc
	zJl/v7z9EmshwiNJVehzh12S4qsUfxE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706801265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tG3CpxDS02v6gYxnYwbFaNjzAhNUjXma24vFvRO3lrE=;
	b=CD6Xr1pcp1MOpdXP7WUqj63Qf9UNGqBnq1lU3nlxRU2oiJsOqc9pjRFzb2RVBWVeuIrLvW
	MwVuRtzHVs2chgGpu8cQStRn0+VRLRR5TLvqCVNtHxCQKFQbmPBkfwTvO+z9M31GF6bktc
	zJl/v7z9EmshwiNJVehzh12S4qsUfxE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14077139AB;
	Thu,  1 Feb 2024 15:27:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id droPA3G4u2V2eQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 01 Feb 2024 15:27:45 +0000
Date: Thu, 1 Feb 2024 16:27:44 +0100
From: Michal Hocko <mhocko@suse.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: hugetlb: remove __GFP_THISNODE flag when
 dissolving the old hugetlb
Message-ID: <Zbu4cD1XLFLfKan8@tiehlicka>
References: <6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CD6Xr1pc
X-Spamd-Result: default: False [-2.81 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 387E42207F
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Thu 01-02-24 21:31:13, Baolin Wang wrote:
> Since commit 369fa227c219 ("mm: make alloc_contig_range handle free
> hugetlb pages"), the alloc_contig_range() can handle free hugetlb pages
> by allocating a new fresh hugepage, and replacing the old one in the
> free hugepage pool.
> 
> However, our customers can still see the failure of alloc_contig_range()
> when seeing a free hugetlb page. The reason is that, there are few memory
> on the old hugetlb page's node, and it can not allocate a fresh hugetlb
> page on the old hugetlb page's node in isolate_or_dissolve_huge_page() with
> setting __GFP_THISNODE flag. This makes sense to some degree.
> 
> Later, the commit ae37c7ff79f1 (" mm: make alloc_contig_range handle
> in-use hugetlb pages") handles the in-use hugetlb pages by isolating it
> and doing migration in __alloc_contig_migrate_range(), but it can allow
> fallbacking to other numa node when allocating a new hugetlb in
> alloc_migration_target().
> 
> This introduces inconsistency to handling free and in-use hugetlb.
> Considering the CMA allocation and memory hotplug relying on the
> alloc_contig_range() are important in some scenarios, as well as keeping
> the consistent hugetlb handling, we should remove the __GFP_THISNODE flag
> in isolate_or_dissolve_huge_page() to allow fallbacking to other numa node,
> which can solve the failure of alloc_contig_range() in our case.

I do agree that the inconsistency is not really good but I am not sure
dropping __GFP_THISNODE is the right way forward. Breaking pre-allocated
per-node pools might result in unexpected failures when node bound
workloads doesn't get what is asssumed available. Keep in mind that our
user APIs allow to pre-allocate per-node pools separately.

The in-use hugetlb is a very similar case. While having a temporarily
misplaced page doesn't really look terrible once that hugetlb page is
released back into the pool we are back to the case above. Either we
make sure that the node affinity is restored later on or it shouldn't be
migrated to a different node at all.

-- 
Michal Hocko
SUSE Labs

