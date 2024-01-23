Return-Path: <linux-kernel+bounces-35710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07209839570
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27671F307BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63E88612D;
	Tue, 23 Jan 2024 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="PA70v2ZZ"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8F85C7F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028508; cv=none; b=oVihGXr91ehcaZ26aN/1E5rGIZqL78kYtAB3v7WPJQYUzhY8dQ0ec/WozF45tnqDqoCZ5SryGKDwju2NR9pAHa3A72HOTFqLfMySmqOl1bSGlnv7/N95en1VZ+fJ4PGIShUoOMhK2hx5bbPGcBRZRzAcnq0u7vFxXibWyOomrGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028508; c=relaxed/simple;
	bh=K+Id2pHFvW1zQtjRoC+3WBupoAqObAViI/JK0/PN30A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3YgbMMEMiiQy1KM+LhcqF92bBxby6SApg435+hzrcJcbaWziw+NdUMEoueGH3k7RJ+4zwHk3tGaQfbPAcaAvhIix7ZxMxJoh8I/ejClZXq1+GJXHYZ9P6kaA9NGIoCDM5hc2wrZ3euhAWZthOh1Iq+igMFLS/ns66fNBFS5pFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=PA70v2ZZ; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bdc2759468so655406b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706028504; x=1706633304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbO1hM7Gq1MMQFtxk3PHCAqmC2ittFH3Mus5UZlycCs=;
        b=PA70v2ZZHYuoAZqpmB7fz+85LCW0+TO6VG2b4x3NOu0ussKVZ4AXHelDYjuLQ2G1jC
         1+VLfSTrXGHXIKxA/A+fzbkiRAk8ItEk7xbiJKsy0Ei+8mPYiRYRoKB17IJRNwUy9U9M
         EB/1kzw4McDl34441AI1fwHHwVRpgwBTtyF+joV/UYlD9lNX06WQ50QSnLqXmRdxu9/I
         kmpIjyOCbOmpdmzyg+KtLo2NQDbI7A8bAn+n4buF7qNXa/k8S1nDEADjIMVUhNHu7iyH
         ejaJ8EVtQLPtZGMFbwVn9VPUtKaLtNMpTIc8Q8bHs0XFv48IQ18LTm4UwqXNNkgxYbNs
         taIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028504; x=1706633304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbO1hM7Gq1MMQFtxk3PHCAqmC2ittFH3Mus5UZlycCs=;
        b=Or2zGkGjYRa/qKLO6jjBjUQLOqnjewcUS5Pkw9T+dxcaV4Mvoa6ZPFmcTk4jWqxd+Z
         ICxCCQ3i3udrAKVHGFxrUfGbxXjmTwa6BlqG7hK9FqQMXSg9FSTquks/n20T9CLD90d7
         RivRk9M17QUthTKKamUJzM+R+9m21pAOWYDYdgB/roK30zYuLolKo2NW1Zr5qY9eAfKi
         e7uch2x4xUQW1fZtGtdL9yTU/R2mAnZBkkKyeRmyqzrEL5mXLT/GaY2ljYRJVQZy1XEK
         CGnSb6E9uLUfmNe6ZOJbDbdrO+c3g+Q7WpeO0P1gZhVIn05sFORbwDOUoLzBL8XBe5+w
         sDrQ==
X-Gm-Message-State: AOJu0YyIroeCXJ6wF2JFotMxP+9V2aKsw0Mcg++dewhoSrfpP/O3ugQh
	Jw8s6W6LEUO1ubQEnds7xcJuSj4NuQt14qSaFSgvV6h8UiCZEiO1oH6GnGSjgO4=
X-Google-Smtp-Source: AGHT+IHUG7S/rv/R7wA+Z9UIIztYDf0v6Sh7d9fO6fdN0c9sFxPRFzPESC1XVa3Mb1iV3eCC4V2oUg==
X-Received: by 2002:a05:6808:399a:b0:3bd:cbb2:4614 with SMTP id gq26-20020a056808399a00b003bdcbb24614mr185240oib.68.1706028504592;
        Tue, 23 Jan 2024 08:48:24 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-97cf-7b55-44af-acd6.res6.spectrum.com. [2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id bk21-20020a05620a1a1500b0078353f07523sm3256413qkb.1.2024.01.23.08.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:48:24 -0800 (PST)
Date: Tue, 23 Jan 2024 11:48:19 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com,
	yuzhao@google.com, yangyifei03@kuaishou.com,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mm:vmscan: fix inaccurate reclaim during
 proactive reclaim"
Message-ID: <20240123164819.GB1745986@cmpxchg.org>
References: <20240121214413.833776-1-tjmercier@google.com>
 <Za-H8NNW9bL-I4gj@tiehlicka>
 <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com>

The revert isn't a straight-forward solution.

The patch you're reverting fixed conventional reclaim and broke
MGLRU. Your revert fixes MGLRU and breaks conventional reclaim.

On Tue, Jan 23, 2024 at 05:58:05AM -0800, T.J. Mercier wrote:
> They both are able to make progress. The main difference is that a
> single iteration of try_to_free_mem_cgroup_pages with MGLRU ends soon
> after it reclaims nr_to_reclaim, and before it touches all memcgs. So
> a single iteration really will reclaim only about SWAP_CLUSTER_MAX-ish
> pages with MGLRU. WIthout MGLRU the memcg walk is not aborted
> immediately after nr_to_reclaim is reached, so a single call to
> try_to_free_mem_cgroup_pages can actually reclaim thousands of pages
> even when sc->nr_to_reclaim is 32. (I.E. MGLRU overreclaims less.)
> https://lore.kernel.org/lkml/20221201223923.873696-1-yuzhao@google.com/

Is that a feature or a bug?

 * 1. Memcg LRU only applies to global reclaim, and the round-robin incrementing
 *    of their max_seq counters ensures the eventual fairness to all eligible
 *    memcgs. For memcg reclaim, it still relies on mem_cgroup_iter().

If it bails out exactly after nr_to_reclaim, it'll overreclaim
less. But with steady reclaim in a complex subtree, it will always hit
the first cgroup returned by mem_cgroup_iter() and then bail. This
seems like a fairness issue.

We should figure out what the right method for balancing fairness with
overreclaim is, regardless of reclaim implementation. Because having
two different approaches and reverting dependent things back and forth
doesn't make sense.

Using an LRU to rotate through memcgs over multiple reclaim cycles
seems like a good idea. Why is this specific to MGLRU? Shouldn't this
be a generic piece of memcg infrastructure?

Then there is the question of why there is an LRU for global reclaim,
but not for subtree reclaim. Reclaiming a container with multiple
subtrees would benefit from the fairness provided by a container-level
LRU order just as much; having fairness for root but not for subtrees
would produce different reclaim and pressure behavior, and can cause
regressions when moving a service from bare-metal into a container.

Figuring out these differences and converging on a method for cgroup
fairness would be the better way of fixing this. Because of the
regression risk to the default reclaim implementation, I'm inclined to
NAK this revert.

