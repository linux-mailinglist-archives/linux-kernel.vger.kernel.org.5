Return-Path: <linux-kernel+bounces-55007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F07684B630
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C111C20CD1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B0130AE1;
	Tue,  6 Feb 2024 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KGjZfM/+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KGjZfM/+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591DE12EBD6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225599; cv=none; b=gcwzkYEvA+iNG6EBT7vWo8if1tthhh4Bdl0WIuJ8mcxy90KJF42kRnSlR2rhj3a1v2A5/yro9hCvcYKn3gO6w7i5bPCEcspeMGZYtmUnAx5W9tIL17Fcq1Iy/ALTdN9fM7qq2e0/7HZxtstiVQUKtVMUh/BCjWFPHPllTORwRkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225599; c=relaxed/simple;
	bh=d6E4qoI7v5gjzR3UZHAJ1Lk7ETYM50N8rH9/3UgxbIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDdxam/05CC5WJCxl5+B27VNvS17LAMF65d7+Jv/Cp2AgPvgXNIqfiiI8ftnGSsge8KUMLe/gdMM2VWcqOBzp+Lmkv0lwmo365gDIzBI57IFSpfnij96RhPd6yUeHAPeqfpNFRxhPLM7fGjiU5jL1ReUl+0nAFrn9vdEyq0WTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KGjZfM/+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KGjZfM/+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C40F221A7;
	Tue,  6 Feb 2024 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707225594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIPgOyeIYL9r0eG/hKiBxs+y+4PiJBAJiwveUceKmG0=;
	b=KGjZfM/+UVaYOKUcTJtRkPTY5oNZNLarIiuiZWWT5saOhUjV1cmktOm5HPdcZQuiFI5czv
	hhw5u9ErWm138FhM3SGJhIqLp3i9eUZpeGlk8dRlsFUpByLYoHOTNklZ5bJvjCScEPx6Az
	x+NPmovmRfx4yckHhBy+YApP6IeOq3g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707225594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIPgOyeIYL9r0eG/hKiBxs+y+4PiJBAJiwveUceKmG0=;
	b=KGjZfM/+UVaYOKUcTJtRkPTY5oNZNLarIiuiZWWT5saOhUjV1cmktOm5HPdcZQuiFI5czv
	hhw5u9ErWm138FhM3SGJhIqLp3i9eUZpeGlk8dRlsFUpByLYoHOTNklZ5bJvjCScEPx6Az
	x+NPmovmRfx4yckHhBy+YApP6IeOq3g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94628132DD;
	Tue,  6 Feb 2024 13:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fio2JPoxwmVGOwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 06 Feb 2024 13:19:54 +0000
Date: Tue, 6 Feb 2024 14:19:54 +0100
From: Michal Hocko <mhocko@suse.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, muchun.song@linux.dev
Cc: akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: hugetlb: remove __GFP_THISNODE flag when
 dissolving the old hugetlb
Message-ID: <ZcIx-uQm5MUzzyL1@tiehlicka>
References: <Zbu4cD1XLFLfKan8@tiehlicka>
 <3f31cd89-f349-4f9e-bc29-35f29f489633@linux.alibaba.com>
 <ZbylJr_bbWCUMjMl@tiehlicka>
 <f1606912-5bcc-46be-b4f4-666149eab7bd@linux.alibaba.com>
 <Zby7-dTtPIy2k5pj@tiehlicka>
 <909cee7d-0201-4429-b85d-7d2662516e45@linux.alibaba.com>
 <ZcCnNPkNpE7KTHZu@tiehlicka>
 <2613b670-84f8-4f97-ab4e-0d480fc1a3f8@linux.alibaba.com>
 <ZcDvVA84s9-Azr33@tiehlicka>
 <67e0d81f-7125-455c-b02f-a9e675d55c6c@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e0d81f-7125-455c-b02f-a9e675d55c6c@linux.alibaba.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
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
	 BAYES_HAM(-0.00)[43.81%]
X-Spam-Flag: NO

On Tue 06-02-24 16:18:22, Baolin Wang wrote:
> 
> 
> On 2024/2/5 22:23, Michal Hocko wrote:
> > On Mon 05-02-24 21:06:17, Baolin Wang wrote:
> > [...]
> > > > It is quite possible that traditional users (like large DBs) do not use
> > > > CMA heavily so such a problem was not observed so far. That doesn't mean
> > > > those problems do not really matter.
> > > 
> > > CMA is just one case, as I mentioned before, other situations can also break
> > > the per-node hugetlb pool now.
> > 
> > Is there any other case than memory hotplug which is arguably different
> > as it is a disruptive operation already.
> 
> Yes, like I said before the longterm pinning, memory failure and the users
> of alloc_contig_pages() may also break the per-node hugetlb pool.

memory failure is similar to the memory hotplug in the sense that it is
a disruptive operation and fallback to a different node might be the
only option to handle it. On the other hand longterm pinning is similar to 
a_c_p and it should fail if it cannot be migrated within the node.

It seems that hugetlb is quite behind with many other features and I am
not really sure how to deal with that. What is your take Munchun Song?

> > > Let's focus on the main point, why we should still keep inconsistency
> > > behavior to handle free and in-use hugetlb for alloc_contig_range()? That's
> > > really confused.
> > 
> > yes, this should behave consistently. And the least surprising way to
> > handle that from the user configuration POV is to not move outside of
> > the original NUMA node.
> 
> So you mean we should also add __GFP_THISNODE flag in
> alloc_migration_target() when allocating a new hugetlb as the target for
> migration, that can unify the behavior and avoid breaking the per-node pool?

Not as simple as that, because alloc_migration_target is used also from
an user driven migration.
-- 
Michal Hocko
SUSE Labs

