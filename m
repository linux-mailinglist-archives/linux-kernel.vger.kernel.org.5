Return-Path: <linux-kernel+bounces-6379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 841428197FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93DC1C252BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11C410A36;
	Wed, 20 Dec 2023 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="y2Da1fa8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31116FBE1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cc63b3ed71so54729101fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1703049327; x=1703654127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rvHlCxj951YjDHsPMmawLzaHggA+zCebO+fEWpKIwSo=;
        b=y2Da1fa8xh8Oltx51xalGcoVH5Pcjlr+1KTYaBW7CWHwxQLgV0pzrMcNFrifIupCuk
         Jm5b5wExcsPCEPKwBU3+bA3Z08mIDP3CAmnsR7zxNMPtBnFndw6YVMC4Kbo62P8l/Knz
         lpnNb/+L29oN3ePdKDx89m+YTfoldgT3TSs0CADUrLuV5zLpQ2czJuokInVGKYbjo3Kk
         5TDbQ4Dbq1kCZe9HN4Q012ycevimK1DdX+v51SnE6z9JgOHGFaT3hX73nEbtbUbgpOdM
         u3cJTseeGSFqztY/dKA6851NoGf4tACG9SYiC01TnDTaew8e1aurbhOFABTmvD+ZU0O+
         W6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703049327; x=1703654127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvHlCxj951YjDHsPMmawLzaHggA+zCebO+fEWpKIwSo=;
        b=t/DLmmq121xDM4vjOHwxfrWwtXbDSrZAjlYeneFZPwgN4nSuoiYppcAzo/jjOzcw85
         KTZc49hrNgK5XXxvpCqUzykMmqt/VjUMr2XIZZiTlNQ2bNA0vdIl9tp7LPsxtypzVlZd
         iVGVoU3PhqiB9wzSygd7EgIMyMNQddGZUZ42Pgsrhjq0++QkIhTsxACHbbLpveJVZ2VL
         bpyxw9eAodPJz5oZ0E2FIJPZUb4eePkyHVwfkK3GevWs1bzZ0xm14G4349Cl/FYt5nye
         yaefX4O746QieiDg9I8MiX6K+SR9kOQU2bhplbIV5TaYVPrhnamIxVG0QDT7BHpnVfbn
         ZxRg==
X-Gm-Message-State: AOJu0Yw5iqL/WICDImnyWnrJBESqJZOIW809PWdRduFx4mXrdfEaaUJr
	HKzuaGK/GFmTS7LeZbgwB6iV1w==
X-Google-Smtp-Source: AGHT+IG9s4P1zgEh18QajBxvCQTncRFiLN4R6z6+GvId+kQRZ8914UP7UCTqigd64pASLKZgLYt9GQ==
X-Received: by 2002:a05:651c:211a:b0:2cc:8a2b:4583 with SMTP id a26-20020a05651c211a00b002cc8a2b4583mr541496ljq.90.1703049326950;
        Tue, 19 Dec 2023 21:15:26 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::4:a75b])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7db8e000000b005530cb1464bsm3921043edt.15.2023.12.19.21.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 21:15:26 -0800 (PST)
Date: Wed, 20 Dec 2023 06:15:23 +0100
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
Message-ID: <20231220051523.GB23822@cmpxchg.org>
References: <20231207192406.3809579-1-nphamcs@gmail.com>
 <CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi01_qktkitg@mail.gmail.com>
 <20231218144431.GB19167@cmpxchg.org>
 <CAJD7tkakMjE1sNfexLzooptDyQS4YZf5DmuoywnSFD7JTbh9BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkakMjE1sNfexLzooptDyQS4YZf5DmuoywnSFD7JTbh9BA@mail.gmail.com>

On Mon, Dec 18, 2023 at 01:52:23PM -0800, Yosry Ahmed wrote:
> > > Taking a step back from all the memory.swap.tiers vs.
> > > memory.zswap.writeback discussions, I think there may be a more
> > > fundamental problem here. If the zswap store failure is recurrent,
> > > pages can keep going back to the LRUs and then sent back to zswap
> > > eventually, only to be rejected again. For example, this can if zswap
> > > is above the acceptance threshold, but could be even worse if it's the
> > > allocator rejecting the page due to not compressing well enough. In
> > > the latter case, the page can keep going back and forth between zswap
> > > and LRUs indefinitely.
> > >
> > > You probably did not run into this as you're using zsmalloc, but it
> > > can happen with zbud AFAICT. Even with zsmalloc, a less problematic
> > > version can happen if zswap is above its acceptance threshold.
> > >
> > > This can cause thrashing and ineffective reclaim. We have an internal
> > > implementation where we mark incompressible pages and put them on the
> > > unevictable LRU when we don't have a backing swapfile (i.e. ghost
> > > swapfiles), and something similar may work if writeback is disabled.
> > > We need to scan such incompressible pages periodically though to
> > > remove them from the unevictable LRU if they have been dirited.
> >
> > I'm not sure this is an actual problem.
> >
> > When pages get rejected, they rotate to the furthest point from the
> > reclaimer - the head of the active list. We only get to them again
> > after we scanned everything else.
> >
> > If all that's left on the LRU is unzswappable, then you'd assume that
> > remainder isn't very large, and thus not a significant part of overall
> > scan work. Because if it is, then there is a serious problem with the
> > zswap configuration.
> >
> > There might be possible optimizations to determine how permanent a
> > rejection is, but I'm not sure the effort is called for just
> > yet. Rejections are already failure cases that screw up the LRU
> > ordering, and healthy setups shouldn't have a lot of those. I don't
> > think this patch adds any sort of new complications to this picture.
> 
> We have workloads where a significant amount (maybe 20%? 30% not sure
> tbh) of the memory is incompressible. Zswap is still a very viable
> option for those workloads once those pages are taken out of the
> picture. If those pages remain on the LRUs, they will introduce a
> regression in reclaim efficiency.
> 
> With the upstream code today, those pages go directly to the backing
> store, which isn't ideal in terms of LRU ordering, but this patch
> makes them stay on the LRUs, which can be harmful. I don't think we
> can just assume it is okay. Whether we make those pages unevictable or
> store them uncompressed in zswap, I think taking them out of the LRUs
> (until they are redirtied), is the right thing to do.

This is how it works with zram as well, though, and it has plenty of
happy users. The fact that there are antagonistic workloads doesn't
mean the feature isn't useful. This flag is optional and not enabled
by default, so nobody is forced to use it where it hurts.

I'm not saying it's not worth optimizing those cases, but it doesn't
look like a requirement in order to be useful to a variety of loads.

> Adding Wei and Yu for more data about incompressible memory in our
> fleet. Keep in mind that we have internal patches to cap the
> compression ratio (i.e. reject pages where the compressed size +
> metadata is not worth it, or where zsmalloc will store it in a full
> page anyway). But the same thing can happen upstream with zbud.

I hate to bring this up, but there has been a bit of a disturbing
trend in the zswap discussions recently.

Please do not argue with private patches. Their behavior, the usecases
they enable, and their dependencies are entirely irrelevant to patches
submitted in this forum. They do not need to cater to them or consider
the consequences for them. The only thing that matters is the upstream
codebase and the usecases enabled by it.

