Return-Path: <linux-kernel+bounces-146479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 992E88A65CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514E02810B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8721804A;
	Tue, 16 Apr 2024 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MstkI6ty";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PzknxHhZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MstkI6ty";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PzknxHhZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24884FCC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255221; cv=none; b=RI6YGZcsFAzZWI3gn9NB9HGShiHZE5H2i5rdwPBmWCy+AOPzzCSPL1D7e55iTUrn5xIVJnKgCgv9gnjuz6mdDc37hWTvXfiw0dVWqAFgbPBxCTkPpmh1xnEzQ9aJKuK/xazZcTLaA2mrXQuPS/ZkR1zqUwR+5Nnxxw+5P1W+lEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255221; c=relaxed/simple;
	bh=uWXAzlEKUW0DSKPuIlLC12afwjSHTXTCPpPjjqBTW+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqQHsjW6Y5FwcmJY8/ZkS3DP1U2+gBfkB/SVdrSPt29w0Tpc5fDySIZLjgF+kshbMD6NdczBDMAtrBdYHZ/y6I1kLNAat7JmRnlCb/FYpEaKUpBgWZyYkZ/KcacVK5VGqq3Wjy2jXCNJrtu5pHLLd7P0IcWXzya2veKNXa03nbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MstkI6ty; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PzknxHhZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MstkI6ty; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PzknxHhZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33AAA37974;
	Tue, 16 Apr 2024 08:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713255217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSsAJ0gSvxccqjp8rLcQxKaSqVsIpKD8OJPWNVMymHY=;
	b=MstkI6tyg/UOxpd2f3JPoXc/6slqx01nWhbOxaxAmf2I3WgX3DnuyiZ5Dy62fgpddhZjic
	JRTLPSS58dYmt78FwqnjfEWxTbC0s+sf8alinqriTdSaP3wTUEHgbB/iA3onbrE8dCIUgs
	jWEjKty4Wk3g51Vyc8xDe6HZoWOnkB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713255217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSsAJ0gSvxccqjp8rLcQxKaSqVsIpKD8OJPWNVMymHY=;
	b=PzknxHhZKyOPn/VKIR+Wcyne1YjdjyUPCnZOnFPMvjJ1D4YqlGblLz/7X8x4um1XC0cujq
	392jdD1992iKsIBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MstkI6ty;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PzknxHhZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713255217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSsAJ0gSvxccqjp8rLcQxKaSqVsIpKD8OJPWNVMymHY=;
	b=MstkI6tyg/UOxpd2f3JPoXc/6slqx01nWhbOxaxAmf2I3WgX3DnuyiZ5Dy62fgpddhZjic
	JRTLPSS58dYmt78FwqnjfEWxTbC0s+sf8alinqriTdSaP3wTUEHgbB/iA3onbrE8dCIUgs
	jWEjKty4Wk3g51Vyc8xDe6HZoWOnkB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713255217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSsAJ0gSvxccqjp8rLcQxKaSqVsIpKD8OJPWNVMymHY=;
	b=PzknxHhZKyOPn/VKIR+Wcyne1YjdjyUPCnZOnFPMvjJ1D4YqlGblLz/7X8x4um1XC0cujq
	392jdD1992iKsIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD63713432;
	Tue, 16 Apr 2024 08:13:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6b+NJzAzHma/ZAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 16 Apr 2024 08:13:36 +0000
Date: Tue, 16 Apr 2024 10:13:31 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Vishal Moola <vishal.moola@gmail.com>,
	syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in
 __vma_reservation_common
Message-ID: <Zh4zKy-4Wv5bbR5n@localhost.localdomain>
References: <000000000000daf1e10615e64dcb@google.com>
 <000000000000ae5d410615fea3bf@google.com>
 <Zh2kuFX9BWOGN1Mo@fedora>
 <Zh2m5_MfZ45Uk-vD@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh2m5_MfZ45Uk-vD@casper.infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 33AAA37974
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,linux-foundation.org,vger.kernel.org,kvack.org,linux.dev,googlegroups.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[ad1b592fc4483655438b];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]

On Mon, Apr 15, 2024 at 11:15:03PM +0100, Matthew Wilcox wrote:
> On Mon, Apr 15, 2024 at 03:05:44PM -0700, Vishal Moola wrote:
> > Commit 9acad7ba3e25 ("hugetlb: use vmf_anon_prepare() instead of
> > anon_vma_prepare()") may bailout after allocating a folio if we do not
> > hold the mmap lock. When this occurs, vmf_anon_prepare() will release the
> > vma lock. Hugetlb then attempts to call restore_reserve_on_error(),
> > which depends on the vma lock being held.
> > 
> > We can move vmf_anon_prepare() prior to the folio allocation in order to
> > avoid calling restore_reserve_on_error() without the vma lock.
> 
> But now you're calling vmf_anon_prepare() in the wrong place -- before
> we've determined that we need an anon folio.  So we'll create an
> anon_vma even when we don't need one for this vma.
> 
> This is definitely a pre-existing bug which you've exposed by making it
> happen more easily.  Needs a different fix though.

I do not think this is a pre-existing bug.
Prior to 'commit: 7c43a553792a ("hugetlb: allow faults to be handled under
the VMA lock"), we would just bail out if we had FAULT_FLAG_VMA_LOCK.
So there was no danger in calling functions that fiddle with vmas like
restore_reserve_on_error() does.
After that, we allow it but vmf_anon_prepare() releases the lock and returns
VM_FAULT_RETRY if we really need to allocate an anon_vma.
The problem is that now restore_reserve_on_error() will re-adjust the
reservations without the vma lock, completely unsafe.

I think the safest way to tackle this is just as Vishal did, call
vmf_anon_prepare() upfront only for non VM_MAYSHARE faults.


-- 
Oscar Salvador
SUSE Labs

