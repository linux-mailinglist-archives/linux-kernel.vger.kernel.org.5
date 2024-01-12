Return-Path: <linux-kernel+bounces-24433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8AD82BC7D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DEB1C24D09
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F3E53E23;
	Fri, 12 Jan 2024 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a2slaEPw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a2slaEPw"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF7F4F60B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B6DDB1FC0D;
	Fri, 12 Jan 2024 08:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705049349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6sXPhHbdfaX/RtWLihGxAHTWJmXovJjXqKxXGD3VnTs=;
	b=a2slaEPwGq+FKw7AfG2vIle1EKtT8s404qlxEQBjQfvL3gHZEcaeghnerLKg5x8AkU3rJz
	Vm1PyHkL9g2HHo+8iiw2cvx6h5qazEm6plHwqCq8vzu1qW1kXtMGA6iUbjAkAKVuy7Fx1h
	RuHH8PSvsino0JhCIaRPD5G7En4OJgY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705049349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6sXPhHbdfaX/RtWLihGxAHTWJmXovJjXqKxXGD3VnTs=;
	b=a2slaEPwGq+FKw7AfG2vIle1EKtT8s404qlxEQBjQfvL3gHZEcaeghnerLKg5x8AkU3rJz
	Vm1PyHkL9g2HHo+8iiw2cvx6h5qazEm6plHwqCq8vzu1qW1kXtMGA6iUbjAkAKVuy7Fx1h
	RuHH8PSvsino0JhCIaRPD5G7En4OJgY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92EFB13782;
	Fri, 12 Jan 2024 08:49:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +bTaIAX9oGXLKQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 12 Jan 2024 08:49:09 +0000
Date: Fri, 12 Jan 2024 09:49:08 +0100
From: Michal Hocko <mhocko@suse.com>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [External] : Re: [PATCH] mm, oom: Add lru_add_drain() in
 __oom_reap_task_mm()
Message-ID: <ZaD9BNtXZfY2UtVI@tiehlicka>
References: <20240109091511.8299-1-jianfeng.w.wang@oracle.com>
 <ZZ5Zb3FYqY8FZgB3@tiehlicka>
 <1d866f1b-94b3-43ec-8f4c-2de31b82d3d1@oracle.com>
 <ZZ-q0PZ-XCDwA4oG@tiehlicka>
 <b2096bcb-bda6-4831-85a2-67759e783e4d@oracle.com>
 <20240111135404.609af4a26d0118c0d290f11c@linux-foundation.org>
 <897538a0-5ce6-484e-a9bc-4e61b3be2265@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <897538a0-5ce6-484e-a9bc-4e61b3be2265@oracle.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=a2slaEPw
X-Spamd-Result: default: False [-4.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B6DDB1FC0D
X-Spam-Level: 
X-Spam-Score: -4.81
X-Spam-Flag: NO

On Thu 11-01-24 16:08:57, Jianfeng Wang wrote:
> 
> 
> On 1/11/24 1:54 PM, Andrew Morton wrote:
> > On Thu, 11 Jan 2024 10:54:45 -0800 Jianfeng Wang <jianfeng.w.wang@oracle.com> wrote:
> > 
> >>
> >>> Unless you can show any actual runtime effect of this patch then I think
> >>> it shouldn't be merged.
> >>>
> >>
> >> Thanks for raising your concern.
> >> I'd call it a trade-off rather than "not really correct". Look at
> >> unmap_region() / free_pages_and_swap_cache() written by Linus. These are in
> >> favor of this pattern, which indicates that the trade-off (i.e. draining
> >> local CPU or draining all CPUs or no draining at all) had been made in the
> >> same way in the past. I don't have a specific runtime effect to provide,
> >> except that it will free 10s kB pages immediately during OOM.

You are missing an important point. Those two calls are quite different.
oom_reaper unmaps memory after all the reclaim attempts have failed.
That includes draining all sorts of caches on the way. Including
draining LRU pcp cache (look for lru_add_drain_all in the reclaim path). 
 
> > I don't think it's necessary to run lru_add_drain() for each vma.  Once
> > we've done it it once, it can be skipped for additional vmas.
> > 
> Agreed.
> 
> > That's pretty minor because the second and successive calls will be
> > cheap.  But it becomes much more significant if we switch to
> > lru_add_drain_all(), which sounds like what we should be doing here. 
> > Is it possible?
> >
> What do you both think of adding lru_add_drain_all() prior to the for loop?

lru_add_drain_all relies on WQs. And we absolutely do not want to get
oom_reaper stuck just because all the WQ is jammed. So no, this is
actually actively harmful!

All that being said I stand by my previous statement that this patch is
not doing anything measurably useful. Prove me wrong otherwise I am
against merging "just for consistency patch". Really, we should go and
re-evaluate existing local lru draining callers. I wouldn't be surprised
if we removed some of them.

-- 
Michal Hocko
SUSE Labs

