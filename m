Return-Path: <linux-kernel+bounces-148679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5798A85FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C3C1C215D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774C0132807;
	Wed, 17 Apr 2024 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="dwoT+s1O"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6E53801
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364416; cv=none; b=c7Mmnof6y7EtDFtOWy9ZuNxUnAN9qJcumMMg6JU3SD8ki937RvkNhvhWCN4cjsRy7osSe6vvjf4lz1U4zM71IrBIWHVossNhLEUrkwnhCAVv+mFWbvEb/RuKYNPvOn7gsiwMcBbE/qpNR3xkjlOOJB2hiDFbb9pNXi+gO4UBREI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364416; c=relaxed/simple;
	bh=cF+RwtuyJsFL9waz9uZnB88UGKVak7U7/jR80I6v9Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubV894nIoV0MctDzQ5cXJonyoN/Mygx6jAjmvVv2kfTtXOYX4IMSCgOQGbIzI59CvM+cDvO4s4Y4I2kgFF9Z4/Ql88ktKhPSNdhcWTHwdIGitAY4D3AC+rx29+idFaYCG+Ivgx1dO/jUt0r8CqFr4Keq16YMUdvD3mqJ4QubMEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=dwoT+s1O; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78f02c96c52so30691085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1713364411; x=1713969211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fYjWrnxXzVPnBVhxJlTn/8OmhjvM1CO6cGLjT7MOA9I=;
        b=dwoT+s1OfVGZgGvQYrhOxCZAKBQoGI0r3eUtu7UHUF08mrXRcVXrNux9CCS3IlBF+w
         gTPAvkQCF2sU4sJTq5Bt8vnuM9ywVT6WGqRWv5cCCFiPrQWISDVTfnJj07AWxFa3Lqpr
         ofnLC+LZxYOXm8uIMyK04vcMtmO4i0O3Z4kaIb2t/CGHkWcHj43rbzUr0MLFSD0NIBE4
         8GVEjIVW31pQqVOSE850fDyjwnil/xsSTtxPKkVphxT5Y6C5a9EaXJQ064FmRtm51lWj
         olfVcQ+Hf/z4VoFceIcLUvDx78MXBe6EehhY3AYkkcFhhxkpLJ5ODn3bM6JhJgkU5w1j
         xmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364411; x=1713969211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYjWrnxXzVPnBVhxJlTn/8OmhjvM1CO6cGLjT7MOA9I=;
        b=QRC59F/tXK+s7DJWvIQv/JtyvStJVBSNXxt4eHqlf6NJpcGpcf5i6pW5enwlL4bOXv
         7sW391dU4dA1NMFJDXO7O0cP8tUOX9/SUCPYgpNJVl21nkoosZQ2zYyzeJUBLZfv6Q6d
         noZruj/crK4jrSrB5L47bsXD/KE/e2GNN7cWP98BQPFmXS9XrexCWVIO//FD2RPHEnVZ
         iw54un2rdr+/psSogelSbGnNViQZnUQaVmX2CQ3I2pFu6eMz4dvMrlTbnWNM201oL930
         VjVsZt8qxKRPbAEulKfA+4a/IguESCT+qSBu4gxNTe5KMiIE+bEXjewTbx7PpNG4sYiN
         t77g==
X-Forwarded-Encrypted: i=1; AJvYcCVcSMKroAxZ4uOZg3xd7Vei7HUSxgeNVpoH/+lhjR1tkV0e0qehSNnulTraQX29zX5YajO+8gqj/fIWqfIkZMCLQ8nMelCkd11tvSJB
X-Gm-Message-State: AOJu0YyNJmAfJSFUrVr75l2DA+z89J3AVz8uGFgWWJLxyAn26bqnCWQG
	UbwQyg/OKgOSlEWTV6ShMPnDpQ89ZzQ/DM01BotliAVTwjHch9xtp2KdpuNuKuY=
X-Google-Smtp-Source: AGHT+IGMO064THKZbI3D+TjKDUvnCQ9eceCJdFB3I+efweCrewGFx2TWhVjKd7pJ/Unkt/w7tOJsaw==
X-Received: by 2002:a0c:dc8f:0:b0:69b:71f8:b3fe with SMTP id n15-20020a0cdc8f000000b0069b71f8b3femr10445124qvk.42.1713364411072;
        Wed, 17 Apr 2024 07:33:31 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id gv5-20020a056214262500b0069b58f8c33dsm6787082qvb.45.2024.04.17.07.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:33:30 -0700 (PDT)
Date: Wed, 17 Apr 2024 10:33:24 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, Christian Heusel <christian@heusel.eu>,
	Seth Jennings <sjenning@redhat.com>,
	Dan Streetman <ddstreet@ieee.org>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Runge <dave@sleepmap.de>,
	"Richard W.M. Jones" <rjones@redhat.com>,
	Mark W <instruform@gmail.com>, regressions@lists.linux.dev,
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [REGRESSION] Null pointer dereference while shrinking zswap
Message-ID: <20240417143324.GA1055428@cmpxchg.org>
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
 <CAKEwX=MZ3jTVpN4g-qrhTn2b0i0C6_M=8BtKt9KEPyFHb+4W2w@mail.gmail.com>
 <CAKEwX=NM1y-K1-Yw=CH3cM-8odER1PZBVoWo-rs7_OdjFG_puw@mail.gmail.com>
 <CAKEwX=MWPUf1NMGdn+1AkRdOUf25ifAbPyoP9zppPTx3U3Tv2Q@mail.gmail.com>
 <246c1f4d-af13-40fa-b968-fbaf36b8f91f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <246c1f4d-af13-40fa-b968-fbaf36b8f91f@linux.dev>

On Wed, Apr 17, 2024 at 11:44:45AM +0800, Chengming Zhou wrote:
> On 2024/4/17 08:22, Nhat Pham wrote:
> > On Tue, Apr 16, 2024 at 4:29 PM Nhat Pham <nphamcs@gmail.com> wrote:
> >>
> >> On Tue, Apr 16, 2024 at 3:14 PM Nhat Pham <nphamcs@gmail.com> wrote:
> >>>
> >>> On Tue, Apr 16, 2024 at 5:19 AM Christian Heusel <christian@heusel.eu> wrote:
> >>>>
> >>>> Hello everyone,
> >>>
> >>> Thanks for the report, Christian! Looking at it now.
> >>>
> >>>>
> >>>> while rebuilding a few packages in Arch Linux we have recently come
> >>>> across a regression in the linux kernel which was made visible by a test
> >>>> failure in libguestfs[0], where the booted kernel showed a Call Trace
> >>>> like the following one:
> >>>>
> >>>> [  218.738568] CPU: 0 PID: 167 Comm: guestfsd Not tainted 6.7.0-rc4-1-mainline-00158-gb5ba474f3f51 #1 bf39861cf50acae7a79c534e25532f28afe4e593^M
> >>>
> >>> Is this one of the kernel versions that was broken? That looks a bit
> >>> odd, as zswap shrinker landed on 6.8...
> >>
> >> Ah ignore this - I understand the versioning now...
> >>
> >>>
> >>>> [  218.739007] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.16.3-1-1 04/01/2014^M
> >>>> [  218.739787] RIP: 0010:memcg_page_state+0x9/0x30^M
> >>>> [  218.740299] Code: 0d b8 ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 <48> 8b 87 00 06 00 00 48 63 f6 31 d2 48 8b 04 f0 48 85 c0 48 0f 48^M
> >>>> [  218.740727] RSP: 0018:ffffb5fa808dfc10 EFLAGS: 00000202^M
> >>>> [  218.740862] RAX: 0000000000000000 RBX: ffffb5fa808dfce0 RCX: 0000000000000002^M
> >>>> [  218.741016] RDX: 0000000000000001 RSI: 0000000000000033 RDI: 0000000000000000^M
> >>>> [  218.741168] RBP: 0000000000000000 R08: ffff976681ff8000 R09: 0000000000000000^M
> >>>> [  218.741322] R10: 0000000000000001 R11: ffff9766833f9d00 R12: ffff9766ffffe780^M
> >>>> [  218.742167] R13: 0000000000000000 R14: ffff976680cc1800 R15: ffff976682204d80^M
> >>>> [  218.742376] FS:  00007f1479d9f540(0000) GS:ffff9766fbc00000(0000) knlGS:0000000000000000^M
> >>>> [  218.742569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> >>>> [  218.743256] CR2: 0000000000000600 CR3: 0000000103606000 CR4: 0000000000750ef0^M
> >>>> [  218.743494] PKRU: 55555554^M
> >>>> [  218.743593] Call Trace:^M
> >>>> [  218.743733]  <TASK>^M
> >>>> [  218.743847]  ? __die+0x23/0x70^M
> >>>> [  218.743957]  ? page_fault_oops+0x171/0x4e0^M
> >>>> [  218.744056]  ? free_unref_page+0xf6/0x180^M
> >>>> [  218.744458]  ? exc_page_fault+0x7f/0x180^M
> >>>> [  218.744551]  ? asm_exc_page_fault+0x26/0x30^M
> >>>> [  218.744684]  ? memcg_page_state+0x9/0x30^M
> >>>> [  218.744779]  zswap_shrinker_count+0x9d/0x110^M
> >>>> [  218.744896]  do_shrink_slab+0x3a/0x360^M
> >>>> [  218.744990]  shrink_slab+0xc7/0x3c0^M
> >>>> [  218.745609]  drop_slab+0x85/0x140^M
> >>>> [  218.745691]  drop_caches_sysctl_handler+0x7e/0xd0^M
> >>>> [  218.745799]  proc_sys_call_handler+0x1c0/0x2e0^M
> >>>> [  218.745912]  vfs_write+0x23d/0x400^M
> >>>> [  218.745998]  ksys_write+0x6f/0xf0^M
> >>>> [  218.746080]  do_syscall_64+0x64/0xe0^M
> >>>> [  218.746169]  ? exit_to_user_mode_prepare+0x132/0x1f0^M
> >>>> [  218.746873]  entry_SYSCALL_64_after_hwframe+0x6e/0x76^M
> >>>>
> > 
> > Actually, inspecting the code a bit more - can memcg be null here?
> > 
> > Specifically, if mem_cgroup_disabled() is true, can we see null memcg
> > here? Looks like in this case, mem_cgroup_iter() can return null, and
> > the first iteration of drop_slab_node() can have null memcg if it's
> > returned by mem_cgroup_iter().
> > 
> > shrink_slab() will still proceed and call do_shrink_slab() if the
> > memcg is null - provided that mem_cgroup_disabled() holds:
> > 
> > if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
> >       return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
> > 
> 
> Ah, I think your analysis is very right, here memcg is NULL but memcg_page_state
> won't check.

+1.

I could reproduce the NULL crash locally with cgroup_disable=memory,
the shrinker enabled, and echo 3 >/proc/sys/vm/drop_caches.

> > Inside zswap_shrink_count(), all the memcg accessors in this area seem
> > to always check for null memcg (mem_cgroup_lruvec,
> > mem_cgroup_zswap_writeback_enabled), *except* memcg_page_state, which
> > is the one line that fail.
> > 
> > If this is all to it, we can simply add a null check or
> > mem_cgroup_disabled() check here, and use pool stats instead?
> 
> Both look ok to me. The VM could only set sc->memcg to NULL when memcg
> disabled, right?

Christian, can you please test the below patch on top of current
upstream?

diff --git a/mm/zswap.c b/mm/zswap.c
index caed028945b0..6f8850c44b61 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1331,15 +1331,22 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	if (!gfp_has_io_fs(sc->gfp_mask))
 		return 0;
 
-#ifdef CONFIG_MEMCG_KMEM
-	mem_cgroup_flush_stats(memcg);
-	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
-	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
-#else
-	/* use pool stats instead of memcg stats */
-	nr_backing = zswap_pool_total_size >> PAGE_SHIFT;
-	nr_stored = atomic_read(&zswap_nr_stored);
-#endif
+	/*
+	 * For memcg, use the cgroup-wide ZSWAP stats since we don't
+	 * have them per-node and thus per-lruvec. Careful if memcg is
+	 * runtime-disabled: we can get sc->memcg == NULL, which is ok
+	 * for the lruvec, but not for memcg_page_state().
+	 *
+	 * Without memcg, use the zswap pool-wide metrics.
+	 */
+	if (!mem_cgroup_disabled()) {
+		mem_cgroup_flush_stats(memcg);
+		nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
+		nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
+	} else {
+		nr_backing = zswap_pool_total_size >> PAGE_SHIFT;
+		nr_stored = atomic_read(&zswap_nr_stored);
+	}
 
 	if (!nr_stored)
 		return 0;

