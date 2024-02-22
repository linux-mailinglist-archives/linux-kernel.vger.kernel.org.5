Return-Path: <linux-kernel+bounces-75959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B0F85F128
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661C528372A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257B712B81;
	Thu, 22 Feb 2024 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XLM6TXbn"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF2FBF4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708581370; cv=none; b=fXIxqxgJ+uB4TG92fRL+pLK1a3bagmuRckQpbR+ezkXHZyKtLungUdsyTd/HRnEwuhsyJAniXXqoXN8u//UphOFszXPjKTpdcmQmx01raxcCPQ7aIuaqfnoBg8ydGjFIDrLjAcy4iZwtUn9/uleLTRz+CNrrbDllLE1zvC2z4j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708581370; c=relaxed/simple;
	bh=cH6WUIYhHOf/brVu8JhOBk7fqsYUZd7lhl+n3W5/sFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EBbcXKU7v5hsw1aHEbMg4uWLdoF2g+VeDgo/TiPURw7FLWyfZf23WPDgU0QsEnP7dGeptVXaOqYZYKewvlE6/k/5MEP3jqAAHjjSYVA1ckT28o/f8mw0IKE8UzX/cX2iFyCpNhvgWxa6RlrRcpZ0W2sNb5M21iLLsZ1XF6qfTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XLM6TXbn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ceade361so2933328276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708581368; x=1709186168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWBzNYdm8swsY3BfFe1SAI8Gh15aYs1jSIrXf1I5HWs=;
        b=XLM6TXbnZWbVM9/GbpsKAKcYXPbRDwglEAwXFU+8j/X07f9vGRT4CwL7gGoNTDTKcr
         L1yxiBuY9kD4zDPDaKd+mDMWTYViLHLTBmj2eHs/Nw2RKtO9t0wQs9EXRW+s8kGjMN8i
         5fT20bd//HM1EoC+ReSZfvpTtgfSk4sz3J9AXFQKI74m5uXM13vdc+hycE/MrNRzUW/m
         vekBeMJ0toc2FF5SRxrb1uIlr7y6hc75Ol3S3GTVgNopvTZXJDLCH4u8osafS5X1n6KN
         uafTze6/TXkFeQuQc+kgxF2yjfY+R5MqVIGagj4wYS7Y9PhEKKXpuMPMIaRjqbeNqK+Y
         33aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708581368; x=1709186168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWBzNYdm8swsY3BfFe1SAI8Gh15aYs1jSIrXf1I5HWs=;
        b=n8XEGEzNzSYKOWXe9G6jG1Q7yHbUdkhn0JEhPlgQPdsvAgjcctfvgUJEeb2MVFwD9z
         dbGUOkqo/z/cKp64okuoOVFew55K1RnTj/FwUNyJXJeHrruCb3J0SJ0KTX5wbTylA3a9
         hWqMOWwNMoi7pt1S8r2hXSTvzO6nQAxYiWW2xOv6eP0n3UFTk3bMsmkhsqe6oUwSt3I/
         njNKFVDqMSV22LkARyQd2xbAH2BUyDcCSFsgCBcQoucJB8pwv078H/+Z/FGKHkFa70Kx
         jjFH3VKGfWy22TG1O+yNYNwvs4VxvLOqOk+31gCp9ymqadMHgiIS3LemRd3rdTvfDAsk
         ZPpg==
X-Forwarded-Encrypted: i=1; AJvYcCV1uwOI6j4YNU/E1JFHzqioxHXplBeZqOcvSel5bwXNDYzy0DsIyFjg6iq1Qel7oQRVUXM0uiRAHDswrywrLwsvMhKWxbXpwIslDjE9
X-Gm-Message-State: AOJu0YxsMbJXAzecxoPZ36Pzfojh1g2dLVbTaO0S6e9esio3APbOXBiv
	5+qFBxPT5VEb5j8nBTgDLHfAp9vd19WFUWkKxQTT/R3yxo52zRbC3eSehH7Pq3dWIJcz8iFOwdG
	J2vAlYJn6Nme6rNTGPw==
X-Google-Smtp-Source: AGHT+IGx5mQfjz4YVQ2AkQXF6vcSWO5MlMlQO6LD/sJs+Z4DDuf4ESWabDpfrsFqAGKQCSx6TjYmFk8xK9910+le
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a5b:ed0:0:b0:dc6:c2e4:5126 with SMTP id
 a16-20020a5b0ed0000000b00dc6c2e45126mr424431ybs.12.1708581367904; Wed, 21 Feb
 2024 21:56:07 -0800 (PST)
Date: Thu, 22 Feb 2024 05:56:04 +0000
In-Reply-To: <ba2ec393-f484-4c69-aa45-7e9433a71d5d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com>
 <ba2ec393-f484-4c69-aa45-7e9433a71d5d@linux.dev>
Message-ID: <Zdbh9Ap8kZDszEWv@google.com>
Subject: Re: [RFC] Analyzing zpool allocators / Removing zbud and z3fold
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Linux-MM <linux-mm@kvack.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, 
	Chris Down <chris@chrisdown.name>, Seth Jennings <sjenning@redhat.com>, 
	Dan Streetman <ddstreet@ieee.org>, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 22, 2024 at 11:54:44AM +0800, Chengming Zhou wrote:
> On 2024/2/9 11:27, Yosry Ahmed wrote:
> > Hey folks,
> > 
> > This is a follow up on my previously sent RFC patch to deprecate
> > z3fold [1]. This is an RFC without code, I thought I could get some
> > discussion going before writing (or rather deleting) more code. I went
> > back to do some analysis on the 3 zpool allocators: zbud, zsmalloc,
> > and z3fold.
> 
> This is a great analysis! Sorry for being late to see it.
> 
> I want to vote for this direction, zram has been using zsmalloc directly,
> zswap can also do this, which is simpler and we can just maintain and optimize
> only one allocator. The only evident downside is dependence on MMU, right?

AFAICT, yes. I saw a lot of positive responses when I sent an RFC to
mark z3fold as deprecated, but there were some opposing opinions as
well, which is why I did this simple analysis. I was hoping we can make
forward progress with that, but was disappointed it didn't get as much
attention as the deprecation RFC :)

> 
> And I'm trying to optimize the scalability performance for zsmalloc now,
> which is bad so zswap has to use 32 pools to workaround it. (zram only use
> one pool, should also have the scalability problem on big server, maybe
> have to use many zram block devices to workaround it too.)

That's slightly orthogonal. Zsmalloc is not really showing worse
performance than other allocators, so this should be a separate effort.

> 
> But too many pools would cause more memory waste and more fragmentation,
> so the resulted compression ratio is not good enough.
> 
> As for the MMU dependence, we can actually avoid it? Maybe I missed something,
> we can get object's memory vecs from zsmalloc, then send it to decompress,
> which should support length(memory vecs) > 1?

IIUC the dependency on MMU is due to the use of kmalloc() APIs and the
fact that we may be using highmem pages. I think we may be able to work
around that dependency but I didn't look closely.  Hopefully Minchan or
Sergey could shed more light on this.

> 
> > 
> > [1]https://lore.kernel.org/linux-mm/20240112193103.3798287-1-yosryahmed@google.com/
> > 
> > In this analysis, for each of the allocators I ran a kernel build test
> > on tmpfs in a limit cgroup 5 times and captured:
> > (a) The build times.
> > (b) zswap_load() and zswap_store() latencies using bpftrace.
> > (c) The maximum size of the zswap pool from /proc/meminfo::Zswapped.
> 
> Here should use /proc/meminfo::Zswap, right?
> Zswap is the sum of pool pages size, Zswapped is the swapped/compressed pages.

Oh yes, it is /proc/meminfo::Zswap actually. I miswrote it in my email.

Thanks!

