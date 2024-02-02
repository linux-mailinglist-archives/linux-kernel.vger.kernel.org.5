Return-Path: <linux-kernel+bounces-49620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0164846D0B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7BB284981
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0F7C096;
	Fri,  2 Feb 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GwFtaS+x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GwFtaS+x"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34F17764D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867713; cv=none; b=Pet3osu5sQsEt3LGdbQIYnOozwOnX78gOefiD8cbAt0qH3Edd8p7PpZIqWJLTN+RZ4JU4LVnRNbVo6v8nQmIzA7Ywveswou/FmLjfUSVUGiBnFBSiB8FKZUoR+jxThXqeVF1yLyHoEgl2VPjn3JFJRpG7Hlggoq01BEHMcB84rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867713; c=relaxed/simple;
	bh=QLRB0PaAmnEX3W8FypagsmNAUsegkBLeZ5VlOg6SBmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+jQNyRCdVch2yLxqxHVKSrPV5hoVIx+nnss3GhVw19h0Fsi1Xb53+wFvfsvycB1BZv656/BiLt17LvJ899hOvqOkslAVhfofESaOe2sWOtKthKRJlA3yoM8FHIv+xDGcsp8r+b8RrS3SeChen+SsVOcjZRw2y01vXwybkS9elc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GwFtaS+x; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GwFtaS+x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24F771F461;
	Fri,  2 Feb 2024 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706867710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s5p422fiooc4HHA5bCEKx8N+v4UtxVyax3SvdbSiWfE=;
	b=GwFtaS+xtSIK/VzRoDiKVLKHt54EWngxyEg2tyTVUVDIo1CAhGQ27AT/HgX3MSkv0RAAIc
	vqR1SmmCwWR9hp8kuzOaF3qfLAu8/77iKUNuUsuPeZt0uFNZDXLQF409p3bu+eq5x4w4Bp
	wvf2b45/lw6qwWd3pDAB3uv270x9ZkA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706867710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s5p422fiooc4HHA5bCEKx8N+v4UtxVyax3SvdbSiWfE=;
	b=GwFtaS+xtSIK/VzRoDiKVLKHt54EWngxyEg2tyTVUVDIo1CAhGQ27AT/HgX3MSkv0RAAIc
	vqR1SmmCwWR9hp8kuzOaF3qfLAu8/77iKUNuUsuPeZt0uFNZDXLQF409p3bu+eq5x4w4Bp
	wvf2b45/lw6qwWd3pDAB3uv270x9ZkA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CDB8139AB;
	Fri,  2 Feb 2024 09:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +76rAP67vGWkVQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 02 Feb 2024 09:55:10 +0000
Date: Fri, 2 Feb 2024 10:55:05 +0100
From: Michal Hocko <mhocko@suse.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: hugetlb: remove __GFP_THISNODE flag when
 dissolving the old hugetlb
Message-ID: <Zby7-dTtPIy2k5pj@tiehlicka>
References: <6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com>
 <Zbu4cD1XLFLfKan8@tiehlicka>
 <3f31cd89-f349-4f9e-bc29-35f29f489633@linux.alibaba.com>
 <ZbylJr_bbWCUMjMl@tiehlicka>
 <f1606912-5bcc-46be-b4f4-666149eab7bd@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1606912-5bcc-46be-b4f4-666149eab7bd@linux.alibaba.com>
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

On Fri 02-02-24 17:29:02, Baolin Wang wrote:
> On 2/2/2024 4:17 PM, Michal Hocko wrote:
[...]
> > > Agree. So how about below changing?
> > > (1) disallow fallbacking to other nodes when handing in-use hugetlb, which
> > > can ensure consistent behavior in handling hugetlb.
> > 
> > I can see two cases here. alloc_contig_range which is an internal kernel
> > user and then we have memory offlining. The former shouldn't break the
> > per-node hugetlb pool reservations, the latter might not have any other
> > choice (the whole node could get offline and that resembles breaking cpu
> > affininty if the cpu is gone).
> 
> IMO, not always true for memory offlining, when handling a free hugetlb, it
> disallows fallbacking, which is inconsistent.

It's been some time I've looked into that code so I am not 100% sure how
the free pool is currently handled. The above is the way I _think_ it
should work from the usability POV.

> Not only memory offlining, but also the longterm pinning (in
> migrate_longterm_unpinnable_pages()) and memory failure (in
> soft_offline_in_use_page()) can also break the per-node hugetlb pool
> reservations.

Bad

> > Now I can see how a hugetlb page sitting inside a CMA region breaks CMA
> > users expectations but hugetlb migration already tries hard to allocate
> > a replacement hugetlb so the system must be under a heavy memory
> > pressure if that fails, right? Is it possible that the hugetlb
> > reservation is just overshooted here? Maybe the memory is just terribly
> > fragmented though?
> > 
> > Could you be more specific about numbers in your failure case?
> 
> Sure. Our customer's machine contains serveral numa nodes, and the system
> reserves a large number of CMA memory occupied 50% of the total memory which
> is used for the virtual machine, meanwhile it also reserves lots of hugetlb
> which can occupy 50% of the CMA. So before starting the virtual machine, the
> hugetlb can use 50% of the CMA, but when starting the virtual machine, the
> CMA will be used by the virtual machine and the hugetlb should be migrated
> from CMA.

Would it make more sense for hugetlb pages to _not_ use CMA in this
case? I mean would be better off overall if the hugetlb pool was
preallocated before the CMA is reserved? I do realize this is just
working around the current limitations but it could be better than
nothing.

> Due to several nodes in the system, one node's memory can be exhausted,
> which will fail the hugetlb migration with __GFP_THISNODE flag.

Is the workload NUMA aware? I.e. do you bind virtual machines to
specific nodes?

-- 
Michal Hocko
SUSE Labs

