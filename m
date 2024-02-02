Return-Path: <linux-kernel+bounces-49044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF55F84653C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21DA1C23885
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166EEBA25;
	Fri,  2 Feb 2024 01:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNn8rv00"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6FEAD47
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835845; cv=none; b=pyICJCFwWVuKsaPFxphveqK8Xvwr/izDSUnRPpyImJMHiHpAygwroa277WfdWov8/N890+Xc0woGmwGG5+Bxl696381xNGaBtqS3/RlsNasyNKCxtNsKWOlzi17ZSBPftXHNOwxG9J2aB5Y0u4zLFyXPKhCeSmokUbE3s5Ojmy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835845; c=relaxed/simple;
	bh=a5Nlr4RQBP77XBehSgB40yGoPgT0XBNvTDdGKSSmOJU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ThR9Ex9lMhBW0XT0QfPnCC8VEZxdlIv4NBRSg+TcflZneBCfiefE2T+L2hVwoR3RGWTKGS2WQNDVCIHvLJS5uehymv7ci+tqV58ned/YBJuPhNDsl+aRGrNlwyLu8wzLNqP6Gc2gasQDr6Kh6eOsxV15Q2RzCxPmimUqXTUvGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNn8rv00; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6de2116e7c2so1491312b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 17:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706835843; x=1707440643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XbgnQJwz1vgU0uxdyyb22RvKZPgmTtLqOjZGD/vUXYI=;
        b=KNn8rv00/YbCPMQYf8pXkiqgTRPKcza1JQrgViry+AqE6ir1VNJdZjqufV1wbQr8c4
         ZQ8lrw5u9fWcVvfoNVKXPO7dsQS3OADXZBrh1N4Umnx+xC1A3f6C2SMC5YLbghWxRfi0
         1C5Tzp8U6i5+BcZZbm8hgarbMUe2ALhi4zKkZjtYTvuxnKJpB6zPfYiKMgHHaeoqzcww
         6HOL/KT8fahJOg3DtXCYbXs71C1XRcxrclPCKw86ArlZn8YirrLT3dUBApylAlEZSqGf
         lEzVbjMoHW3Y5bvUPYYZfd9MKTRieqmn9AAUBI1Dj122uVJzXo6RbfGjFtMhY7zkEFgJ
         knvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706835843; x=1707440643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbgnQJwz1vgU0uxdyyb22RvKZPgmTtLqOjZGD/vUXYI=;
        b=CLqkaTBT3eL2LcqZ2HjmqylV+YFoNewIss/8NWz6D+n3S4ZZauT1C0QzttPiBbZKCZ
         1helowLJhmLJZ9D2Z3VdCrvFGAxqDDysijSZDfQyNBFM/Gd2GS+Ghh1D8lSvw+jEUxdD
         p3ppxUBI8j1pAefL3FU26Sz0jLmybEMSckOysZnqHLV9IWFBQedzbi9W86YWkygGFOwT
         BirwB9i6xJu7ikH806cBfqVDmrSAkzsbZUV6Kd4OeBpgH6+ZhX+Ekr4lFCLq1EMYIYw9
         csEMqKhivJD0V0O6OfEXkG0Q3Grxg530LzymeleaZNDKlQoy9eHdJTy0GhFXsImk7KeZ
         kN4Q==
X-Gm-Message-State: AOJu0YzFbiaTS1Q2eeaXYkgd2s0Pg6ZMs30xZLe/td1uwqpPCe9AOE9U
	72da16COGQsDQtlI78NCTJuglZ7f94N4lk6ttbOU3rMlrut99bdK6xMCS5CLrIUxSS+0oZV8pcb
	dkZdgeo5twl/SuV2T+g==
X-Google-Smtp-Source: AGHT+IE/JxLkSou/VDo5U1rx0tT391GDl15vJuyWnddaQq63I5wd1sjbiRacqQYzWmPRXa7XRZALYt4dElsYU/6X
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:1c9b:b0:6df:e31e:e995 with
 SMTP id y27-20020a056a001c9b00b006dfe31ee995mr274511pfw.6.1706835842950; Thu,
 01 Feb 2024 17:04:02 -0800 (PST)
Date: Fri, 2 Feb 2024 01:04:01 +0000
In-Reply-To: <20240201181240.GE321148@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-5-56ed496b6e55@bytedance.com> <20240201181240.GE321148@cmpxchg.org>
Message-ID: <Zbw_gZIyEHquaxho@google.com>
Subject: Re: [PATCH 5/6] mm/zswap: only support zswap_exclusive_loads_enabled
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 01, 2024 at 01:12:40PM -0500, Johannes Weiner wrote:
> On Thu, Feb 01, 2024 at 03:49:05PM +0000, Chengming Zhou wrote:
> > The !zswap_exclusive_loads_enabled mode will leave compressed copy in
> > the zswap tree and lru list after the folio swapin.
> > 
> > There are some disadvantages in this mode:
> > 1. It's a waste of memory since there are two copies of data, one is
> >    folio, the other one is compressed data in zswap. And it's unlikely
> >    the compressed data is useful in the near future.
> > 
> > 2. If that folio is dirtied, the compressed data must be not useful,
> >    but we don't know and don't invalidate the trashy memory in zswap.
> > 
> > 3. It's not reclaimable from zswap shrinker since zswap_writeback_entry()
> >    will always return -EEXIST and terminate the shrinking process.
> > 
> > On the other hand, the only downside of zswap_exclusive_loads_enabled
> > is a little more cpu usage/latency when compression, and the same if
> > the folio is removed from swapcache or dirtied.
> > 
> > Not sure if we should accept the above disadvantages in the case of
> > !zswap_exclusive_loads_enabled, so send this out for disscusion.
> > 
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> This is interesting.
> 
> First, I will say that I never liked this config option, because it's
> nearly impossible for a user to answer this question. Much better to
> just pick a reasonable default.
> 
> What should the default be?
> 
> Caching "swapout work" is helpful when the system is thrashing. Then
> recently swapped in pages might get swapped out again very soon. It
> certainly makes sense with conventional swap, because keeping a clean
> copy on the disk saves IO work and doesn't cost any additional memory.
> 
> But with zswap, it's different. It saves some compression work on a
> thrashing page. But the act of keeping compressed memory contributes
> to a higher rate of thrashing. And that can cause IO in other places
> like zswap writeback and file memory.

Agreed.

At Google, we have been using exclusive loads for a very long time in
production, so I have no objections to this. The user interface is also
relatively new, so I don't think it will have accumulated users.

> 
> It would be useful to have an A/B test to confirm that not caching is
> better. Can you run your test with and without keeping the cache, and
> in addition to the timings also compare the deltas for pgscan_anon,
> pgscan_file, workingset_refault_anon, workingset_refault_file?

That would be interesting :)

