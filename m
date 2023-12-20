Return-Path: <linux-kernel+bounces-7086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E0181A177
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107422872A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811003D971;
	Wed, 20 Dec 2023 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="AlUdvvtT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC0F3D967
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2331caab22so497554766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1703083828; x=1703688628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z24VtdqHHTiY12h8DIjtzTUlmR3aKpU/E8WkTXbkbWo=;
        b=AlUdvvtT95EYs0DfyEBAPRYUsfQzHT82b3sBDVAjJqcXcDNjyC/aB99bvq/eY/x2pG
         D5tD2iJg4l+aNQt1W2l60/TRjiqJrmeWaQobcUXC2xV70zamYcXBooJ2vJc9fso9Leot
         wSAuEoTx1QXqT05dL49yU1yDHjyMQ5GOH+TyLBt8/zySRRkTb+LpqGzbwQdbhJ4CRJmU
         B0RqJZ5gewE/umZQYudPl9xt+zwwC4Ngxl7vW2OK/nsK7HJMyw4mBKzUy68o7/HdEs3b
         mr0yL7TxeWiVbV7HKwU88r34gKmUmaKtxFP785USAJLhA2Y56ZFj1WrnOuevhW+AriAx
         m0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703083828; x=1703688628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z24VtdqHHTiY12h8DIjtzTUlmR3aKpU/E8WkTXbkbWo=;
        b=GoBoMYCsKSoFfVm5HBx0NVM4efJvimxSr+6UUKW1AhH2xdqYfMfV/CZnS8DU84+5JI
         xA9zgdGLQWN5GEVPAVQkzqTUlRSccMoQRIhFi7As5Q1AU7KstPT8dkebxNSgVWMEHsvc
         pUiGdMSP02+6WPrNgLdiKR7qvq0pu97VFX/atVeG37K7Yz/utlDpDTG5gujteupYtwwM
         bmFdf4nlQYAx9xs1YB/iVA1Y9W5I2XRQNRmpPONZDJerFDdNCh2dm5xwP6Q435EGU2yW
         N4WIY8wVoPGLLfief4HnW3aTWswDx+5OngMh58brqPns2Hsi/cNLGWBv7lfj9nQ7KMpS
         gPvQ==
X-Gm-Message-State: AOJu0YxvAw/WXmvLyBwn+/KTjHo/v/KGQlgD+BD2ATO7X2wjzqNdDVnT
	r/KeYxUb0ZgHTOxVtsYz3ofJMPsy7RfNpDfdWSa3i9MawRY=
X-Google-Smtp-Source: AGHT+IFSd6R4MolrVxLZOeFPXKF/fkA1R3XqYnZaTri+l+ALtA2Sg/P9TVp4FuzHLLl9ftft3R5ibA==
X-Received: by 2002:a17:906:4cd0:b0:a19:a19a:ea9f with SMTP id q16-20020a1709064cd000b00a19a19aea9fmr8060458ejt.88.1703083828084;
        Wed, 20 Dec 2023 06:50:28 -0800 (PST)
Received: from localhost ([2a02:8071:6401:180:f8f5:527f:9670:eba8])
        by smtp.gmail.com with ESMTPSA id vs6-20020a170907a58600b00a1f99e749dasm13936441ejc.210.2023.12.20.06.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 06:50:27 -0800 (PST)
Date: Wed, 20 Dec 2023 15:50:25 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, tj@kernel.org,
	lizefan.x@bytedance.com, cerasuolodomenico@gmail.com,
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
	konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	david@ixit.cz, chrisl@kernel.org, Wei Xu <weixugc@google.com>,
	Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
Message-ID: <20231220145025.GC23822@cmpxchg.org>
References: <20231207192406.3809579-1-nphamcs@gmail.com>
 <CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi01_qktkitg@mail.gmail.com>
 <20231218144431.GB19167@cmpxchg.org>
 <CAJD7tkakMjE1sNfexLzooptDyQS4YZf5DmuoywnSFD7JTbh9BA@mail.gmail.com>
 <20231220051523.GB23822@cmpxchg.org>
 <CAJD7tkbzVjYxykracNW729xKTqFdpk5Hw5k94Epc_uSvUP1g=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbzVjYxykracNW729xKTqFdpk5Hw5k94Epc_uSvUP1g=g@mail.gmail.com>

On Wed, Dec 20, 2023 at 12:59:15AM -0800, Yosry Ahmed wrote:
> On Tue, Dec 19, 2023 at 9:15 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Dec 18, 2023 at 01:52:23PM -0800, Yosry Ahmed wrote:
> > > > > Taking a step back from all the memory.swap.tiers vs.
> > > > > memory.zswap.writeback discussions, I think there may be a more
> > > > > fundamental problem here. If the zswap store failure is recurrent,
> > > > > pages can keep going back to the LRUs and then sent back to zswap
> > > > > eventually, only to be rejected again. For example, this can if zswap
> > > > > is above the acceptance threshold, but could be even worse if it's the
> > > > > allocator rejecting the page due to not compressing well enough. In
> > > > > the latter case, the page can keep going back and forth between zswap
> > > > > and LRUs indefinitely.
> > > > >
> > > > > You probably did not run into this as you're using zsmalloc, but it
> > > > > can happen with zbud AFAICT. Even with zsmalloc, a less problematic
> > > > > version can happen if zswap is above its acceptance threshold.
> > > > >
> > > > > This can cause thrashing and ineffective reclaim. We have an internal
> > > > > implementation where we mark incompressible pages and put them on the
> > > > > unevictable LRU when we don't have a backing swapfile (i.e. ghost
> > > > > swapfiles), and something similar may work if writeback is disabled.
> > > > > We need to scan such incompressible pages periodically though to
> > > > > remove them from the unevictable LRU if they have been dirited.
> > > >
> > > > I'm not sure this is an actual problem.
> > > >
> > > > When pages get rejected, they rotate to the furthest point from the
> > > > reclaimer - the head of the active list. We only get to them again
> > > > after we scanned everything else.
> > > >
> > > > If all that's left on the LRU is unzswappable, then you'd assume that
> > > > remainder isn't very large, and thus not a significant part of overall
> > > > scan work. Because if it is, then there is a serious problem with the
> > > > zswap configuration.
> > > >
> > > > There might be possible optimizations to determine how permanent a
> > > > rejection is, but I'm not sure the effort is called for just
> > > > yet. Rejections are already failure cases that screw up the LRU
> > > > ordering, and healthy setups shouldn't have a lot of those. I don't
> > > > think this patch adds any sort of new complications to this picture.
> > >
> > > We have workloads where a significant amount (maybe 20%? 30% not sure
> > > tbh) of the memory is incompressible. Zswap is still a very viable
> > > option for those workloads once those pages are taken out of the
> > > picture. If those pages remain on the LRUs, they will introduce a
> > > regression in reclaim efficiency.
> > >
> > > With the upstream code today, those pages go directly to the backing
> > > store, which isn't ideal in terms of LRU ordering, but this patch
> > > makes them stay on the LRUs, which can be harmful. I don't think we
> > > can just assume it is okay. Whether we make those pages unevictable or
> > > store them uncompressed in zswap, I think taking them out of the LRUs
> > > (until they are redirtied), is the right thing to do.
> >
> > This is how it works with zram as well, though, and it has plenty of
> > happy users.
> 
> I am not sure I understand. Zram does not reject pages that do not
> compress well, right? IIUC it acts as a block device so it cannot
> reject pages. I feel like I am missing something.

zram_write_page() can fail for various reasons - compression failure,
zsmalloc failure, the memory limit. This results in !!bio->bi_status,
__end_swap_bio_write redirtying the page, and vmscan rotating it.

The effect is actually more pronounced with zram, because the pages
don't get activated and thus cycle faster.

What you're raising doesn't seem to be a dealbreaker in practice.

> If we already want to support taking pages away from the LRUs when
> rejected by zswap (e.g. Nhat's proposal earlier), doesn't it make
> sense to do that first so that this patch can be useful for all
> workloads?

No.

Why should users who can benefit now wait for a hypothetical future
optimization that isn't relevant to them? And by the looks of it, is
only relevant to a small set of specialized cases?

And the optimization - should anybody actually care to write it - can
be transparently done on top later, so that's no reason to change
merge order, either.

