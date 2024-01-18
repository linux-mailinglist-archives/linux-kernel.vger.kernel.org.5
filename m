Return-Path: <linux-kernel+bounces-30163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13327831AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 853C6B20C98
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF6025569;
	Thu, 18 Jan 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CmN1miDM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CmN1miDM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E824A0B;
	Thu, 18 Jan 2024 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585408; cv=none; b=s/Lc/I9jvQm1oP19Qybc0gf7K1b1fXSqcfeRG4/XkyVgYGmV82F9DqUsUPfS9UfuKUoBfe4Jf6R3YYuGMXG7nMA2qLNmvHpsPRLlQARuS4qw1wHp5pomj3ymoXAkyylgn5raUMu7eBm1EK1wpD7AIrVNHujkWa81UV0gdWxaDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585408; c=relaxed/simple;
	bh=CInZu229v+p6ubCNxyxTiYzu7fJFZZzOi8CMGdGohes=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Spam-Score:
	 X-Spamd-Result:X-Spam-Flag; b=gBRjejJzY3LRqj1TNccTUJCxeGakeglAqD7pZLUMUq60OVXxdmS8wkvODKKyKIWzQQLHjK7+wxtYv6orgkK+XlZ/qKxkhzQ0YSts8h7obVNwbvxe3NYJuo3NFKQm5lp3gHdJv/VstdUcQUB8tEVM+mSzY0Q4mtV+SaxZoUNFG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CmN1miDM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CmN1miDM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F6071FCF4;
	Thu, 18 Jan 2024 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705585403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NAWBeypBvGFM6Xet4cmHeLDFXwdHP1NsXHe8czK2YMg=;
	b=CmN1miDMCWoPZDcJl9YS1hNtPAeMclubrDcIqROVR76CBjuXXcFa4wfjjq0sICX54wZX+6
	Fz3a491/y9KDfEH5an44nGnbdES5Gc4UJr+TtZNGb0eDXerVeGho1gqbjjl5BET50a0ojt
	WZX38fDrUgiiLC096IEsXyEcq/E1pco=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705585403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NAWBeypBvGFM6Xet4cmHeLDFXwdHP1NsXHe8czK2YMg=;
	b=CmN1miDMCWoPZDcJl9YS1hNtPAeMclubrDcIqROVR76CBjuXXcFa4wfjjq0sICX54wZX+6
	Fz3a491/y9KDfEH5an44nGnbdES5Gc4UJr+TtZNGb0eDXerVeGho1gqbjjl5BET50a0ojt
	WZX38fDrUgiiLC096IEsXyEcq/E1pco=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86CB813874;
	Thu, 18 Jan 2024 13:43:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bfnRHvsqqWUHDAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 18 Jan 2024 13:43:23 +0000
Date: Thu, 18 Jan 2024 14:43:23 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com,
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com,
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to
 process_madvise()
Message-ID: <Zakq-54DFdPu0c2U@tiehlicka>
References: <20240118120347.61817-1-ioworker0@gmail.com>
 <ZakqQyL9t2ffNUIf@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZakqQyL9t2ffNUIf@tiehlicka>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,google.com,redhat.com,bytedance.com,gmail.com,kernel.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Dang, forgot to cc linux-api...

On Thu 18-01-24 14:40:19, Michal Hocko wrote:
> On Thu 18-01-24 20:03:46, Lance Yang wrote:
> [...]
> 
> before we discuss the semantic, let's focus on the usecase.
> 
> > Use Cases
> > 
> > An immediate user of this new functionality is the Go runtime heap allocator
> > that manages memory in hugepage-sized chunks. In the past, whether it was a
> > newly allocated chunk through mmap() or a reused chunk released by
> > madvise(MADV_DONTNEED), the allocator attempted to eagerly back memory with
> > huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPSE)[3]
> > respectively. However, both approaches resulted in performance issues; for
> > both scenarios, there could be entries into direct reclaim and/or compaction,
> > leading to unpredictable stalls[4]. Now, the allocator can confidently use
> > process_madvise(MADV_F_COLLAPSE_LIGHT) to attempt the allocation of huge pages.
> 
> IIUC the primary reason is the cost of the huge page allocation which
> can be really high if the memory is heavily fragmented and it is called
> synchronously from the process directly, correct? Can that be worked
> around by process_madvise and performing the operation from a different
> context? Are there any other reasons to have a different mode?
> 
> I mean I can think of a more relaxed (opportunistic) MADV_COLLAPSE -
> e.g. non blocking one to make sure that the caller doesn't really block
> on resource contention (be it locks or memory availability) because that
> matches our non-blocking interface in other areas but having a LIGHT
> operation sounds really vague and the exact semantic would be
> implementation specific and might change over time. Non-blocking has a
> clear semantic but it is not really clear whether that is what you
> really need/want.
> 
> > [1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec56404faca29a82689c77
> > [2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa7333740996181268b60a3a
> > [3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca3be4b3a9bd2af
> > [4] https://github.com/golang/go/issues/63334
> > 
> > [v1] https://lore.kernel.org/lkml/20240117050217.43610-1-ioworker0@gmail.com/
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs

