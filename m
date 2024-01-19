Return-Path: <linux-kernel+bounces-31147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2FF8329C0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649F21F211F6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F6951C43;
	Fri, 19 Jan 2024 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cmsk7QZg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cmsk7QZg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E551C34
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668716; cv=none; b=TzwsNkI9MgEFoGxJH1owXFcBRlsxNlWMi7Bs+3xgyVTlg5QIZcelaT2udHamPzecbvcBICc83JjFeLEMYPhAGsu24/4M/jHvBzd2RzQHC5JBv4cKWREVnMv7AdUFm3jXw7DrsHiv460s8jdVPzPPQicQWRA8nbdwANxqca0nfV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668716; c=relaxed/simple;
	bh=g8zMOzIBwQIHFfANEao9RUXtVPRvJGxDN9i+ELpGA8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvMNA4GcM8W5og853buhR0CbWc7KOP/9HNB4ehmW6gvN6uk6qMJlyF5H5yTpdGvQC2+R9XUuTNjWMipry6lzstIVsgk/2KQJ8m+B3Lh3T/Y41+FrY3Zt+rI6CEp2IN9lgwPShZC295rSKepBgiBOleVX6YE++D5aXIBwqH37kak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cmsk7QZg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cmsk7QZg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D5C31FD15;
	Fri, 19 Jan 2024 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705668712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/t7pPanzZo6yuB0Rau9uLmRftNtX/53oMyJObN2XzQ=;
	b=cmsk7QZg71qSypTUXvv6jwmfrbjRsUj9zQgIEaaZ7V5peesZqr2w22PNHdQRANDM6SIvIB
	Yqhp8Tl+Q67FtdhAJrw1f94mfePvkCyprCJa6luhWK8Dq7LuP9bDIiA/lI9wPLVmq5868x
	Pyh7towxAi6Hfz57KISvt9jSVlVgTA8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705668712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/t7pPanzZo6yuB0Rau9uLmRftNtX/53oMyJObN2XzQ=;
	b=cmsk7QZg71qSypTUXvv6jwmfrbjRsUj9zQgIEaaZ7V5peesZqr2w22PNHdQRANDM6SIvIB
	Yqhp8Tl+Q67FtdhAJrw1f94mfePvkCyprCJa6luhWK8Dq7LuP9bDIiA/lI9wPLVmq5868x
	Pyh7towxAi6Hfz57KISvt9jSVlVgTA8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 470A7136F5;
	Fri, 19 Jan 2024 12:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ovZrDmhwqmVEEgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 19 Jan 2024 12:51:52 +0000
Date: Fri, 19 Jan 2024 13:51:38 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com,
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com,
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to
 process_madvise()
Message-ID: <ZapwWuVTIDeI3W8A@tiehlicka>
References: <20240118120347.61817-1-ioworker0@gmail.com>
 <ZakqQyL9t2ffNUIf@tiehlicka>
 <CAK1f24k+=Sskotbct+yGxpDKNv=qyXPkww5i2kaqfzwaUVO_GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK1f24k+=Sskotbct+yGxpDKNv=qyXPkww5i2kaqfzwaUVO_GQ@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,google.com,redhat.com,bytedance.com,gmail.com,kernel.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Fri 19-01-24 10:03:05, Lance Yang wrote:
> Hey Michal,
> 
> Thanks for taking the time to review!
> 
> On Thu, Jan 18, 2024 at 9:40 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 18-01-24 20:03:46, Lance Yang wrote:
> > [...]
> >
> > before we discuss the semantic, let's focus on the usecase.
> >
> > > Use Cases
> > >
> > > An immediate user of this new functionality is the Go runtime heap allocator
> > > that manages memory in hugepage-sized chunks. In the past, whether it was a
> > > newly allocated chunk through mmap() or a reused chunk released by
> > > madvise(MADV_DONTNEED), the allocator attempted to eagerly back memory with
> > > huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPSE)[3]
> > > respectively. However, both approaches resulted in performance issues; for
> > > both scenarios, there could be entries into direct reclaim and/or compaction,
> > > leading to unpredictable stalls[4]. Now, the allocator can confidently use
> > > process_madvise(MADV_F_COLLAPSE_LIGHT) to attempt the allocation of huge pages.
> >
> > IIUC the primary reason is the cost of the huge page allocation which
> > can be really high if the memory is heavily fragmented and it is called
> > synchronously from the process directly, correct? Can that be worked
> 
> Yes, that's correct.
> 
> > around by process_madvise and performing the operation from a different
> > context? Are there any other reasons to have a different mode?
> 
> In latency-sensitive scenarios, some applications aim to enhance performance
> by utilizing huge pages as much as possible. At the same time, in case of
> allocation failure, they prefer a quick return without triggering direct memory
> reclamation and compaction.

Could you elaborate some more on why?

> > I mean I can think of a more relaxed (opportunistic) MADV_COLLAPSE -
> > e.g. non blocking one to make sure that the caller doesn't really block
> > on resource contention (be it locks or memory availability) because that
> > matches our non-blocking interface in other areas but having a LIGHT
> > operation sounds really vague and the exact semantic would be
> > implementation specific and might change over time. Non-blocking has a
> > clear semantic but it is not really clear whether that is what you
> > really need/want.
> 
> Could you provide me with some suggestions regarding the naming of a
> more relaxed (opportunistic) MADV_COLLAPSE?

Naming is not all that important at this stage (it could be
MADV_COLLAPSE_NOBLOCK for example). The primary question is whether
non-blocking in general is the desired behavior or the implementation
should try but not too hard.

-- 
Michal Hocko
SUSE Labs

