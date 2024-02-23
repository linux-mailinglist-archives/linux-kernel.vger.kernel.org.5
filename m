Return-Path: <linux-kernel+bounces-78469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA028613D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA54E1F24521
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189E9823A8;
	Fri, 23 Feb 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pp0fSthx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z4J5cJgn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pp0fSthx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z4J5cJgn"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208C81ACE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697907; cv=none; b=ZRKfQ+tIYnoI0Fz6ujTo2BZekMfMXKy7lb39LqKT3tgBppaa5ReckJMi9ro6o5JzjGFX7AZluvnlojBJ5pHzrtgIIIIhfDBU5HL8gfozsVBRZBNUCuhArLLsdcg2/Z9KUCnKDPg8VAoQ0kSwbzycfsyKKg1GzYdYkE8IhT72cCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697907; c=relaxed/simple;
	bh=X3OwZlDhSXnIj5p2Ug690icelgyl5ae7KWaWNgRWoYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJb8XjWcc8HZV0H2dzEiTkhT5f8YDGefsyHdSFzP846+s6qO3k98Y78X3ZhGy6yL6iykWepX9ZasV/u+FdepxMvxQYWMFpamTvpO74pKhQWtxOc/K+rZw1IfY9+S7fRfUX6B8tP3h7V5LP2zpHPjUG+rVcw/xHSiTPhhHCK7zrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pp0fSthx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z4J5cJgn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pp0fSthx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z4J5cJgn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9D6501F79C;
	Fri, 23 Feb 2024 14:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708697901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VyCyrehk3lZ9bYzoHMAHHn/3gFCXmGPk7/GfakXrfk=;
	b=pp0fSthx28CEEOlMVmHMrQR13brqM8WV1Bm5aD7XEDMR9l7qMVw74RcgVJxosTUJLDKY6j
	3dmjZzwqoqNvfwENlk0X9pfI9yp7itbZq37v3nHlCGScDyPBE3UXHbEyRzdlEJrcnZd96M
	uGrTEbTpTk02S8q3fAoaXWQsZmEAI8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708697901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VyCyrehk3lZ9bYzoHMAHHn/3gFCXmGPk7/GfakXrfk=;
	b=Z4J5cJgngz/PvFk5fbZFgoByw40vPGoW6iRmdkRtoJCpOQk0p/j157qqKMdB5XhuFvSPRC
	ZyaXVXE15yXBfhAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708697901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VyCyrehk3lZ9bYzoHMAHHn/3gFCXmGPk7/GfakXrfk=;
	b=pp0fSthx28CEEOlMVmHMrQR13brqM8WV1Bm5aD7XEDMR9l7qMVw74RcgVJxosTUJLDKY6j
	3dmjZzwqoqNvfwENlk0X9pfI9yp7itbZq37v3nHlCGScDyPBE3UXHbEyRzdlEJrcnZd96M
	uGrTEbTpTk02S8q3fAoaXWQsZmEAI8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708697901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VyCyrehk3lZ9bYzoHMAHHn/3gFCXmGPk7/GfakXrfk=;
	b=Z4J5cJgngz/PvFk5fbZFgoByw40vPGoW6iRmdkRtoJCpOQk0p/j157qqKMdB5XhuFvSPRC
	ZyaXVXE15yXBfhAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 11E8613419;
	Fri, 23 Feb 2024 14:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GifuAC2p2GXwAwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Fri, 23 Feb 2024 14:18:21 +0000
Date: Fri, 23 Feb 2024 15:19:34 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] mm: hugetlb: make the hugetlb migration strategy
 consistent
Message-ID: <ZdipdrJoN7LS3h9m@localhost.localdomain>
References: <cover.1708507022.git.baolin.wang@linux.alibaba.com>
 <0514e5139b17ecf3cd9e09d86c93e586c56688dc.1708507022.git.baolin.wang@linux.alibaba.com>
 <ZdfHi142dvQuN7B-@localhost.localdomain>
 <0a06dc7f-3a49-42ba-8221-0b4a3777ac0b@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a06dc7f-3a49-42ba-8221-0b4a3777ac0b@linux.alibaba.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pp0fSthx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z4J5cJgn
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9D6501F79C
X-Spam-Level: 
X-Spam-Score: -4.31
X-Spam-Flag: NO

On Fri, Feb 23, 2024 at 10:56:48AM +0800, Baolin Wang wrote:
 
> I previously considered passing the MR_reason argument to the
> htlb_modify_alloc_mask(), which is only used by hugetlb migration.
> But in alloc_hugetlb_folio_nodemask(), if there are available hugetlb on
> other nodes, we should allow migrating, that will not break the per-node
> hugetlb pool.
> 
> That's why I just change the gfp_mask for allocating a new hguetlb when
> migration, that can break the pool.

Code-wise I think this is good, but I'm having some feelings
about where filter out the mask.
Ok, I'm trying to get my head around this.
It's been a while since I looked into hugetlb code, so here we go.

You mentioned that the only reason not to fiddle with gfp_mask before calling
in alloc_hugetlb_folio_nodemask(), was that we might be able to find a hugetlb
page in another node, and that that's ok because since all nodes remain with
the same number of hugetlb pages, per-node pool doesn't get broken.

Now, I see that dequeue_hugetlb_folio_nodemask() first tries to get the zonelist
of the preferred node, and AFAICS, if it has !GFP_THISNODE, it should also
get the zonelists of all other nodes, so we might fallback.

In the hope of finding a way to be able to filter out in htlb_modify_alloc_mask(),
I was trying to see whether we could skip GFP_THISNODE in
dequeue_hugetlb_folio_nodemask() but no because we might end up dequeueing
a hugetlb which sits in another node, while we really specified __GFP_THISNODE.

The only way might be to somehow decouple dequeue_hugetlb_folio_nodemask()
from alloc_hugetlb_folio_nodemask() and do some kind of gfp modification
between the two calls.

Another thing I dislike is the "-1" in alloc_hugetlb_folio_vma().
I think at least it deserves a comment like "Passing -1 will make us stick
to GFP_THISNODE".
Although that is another thing, we will pass "-1" which forces GFP_THISNODE
when allocating a newly fresh hugetlb page, but in dequeue_hugetlb_folio_nodemask()
we might get a page from a different node.
That doesn't break per-node pool, but it is somehow odd?
 

-- 
Oscar Salvador
SUSE Labs

