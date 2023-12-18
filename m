Return-Path: <linux-kernel+bounces-4427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2011B817CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FA11C2183F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1F5740B2;
	Mon, 18 Dec 2023 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xda6bzNz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0FA740A2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7c5cb5eeab1so1097644241.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702936381; x=1703541181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qL6Hfk+uqwtN0FGrPdWYTs1ebhUVgd8KgkwFHPg64Lk=;
        b=xda6bzNzzW4pHjiWl2cr4q27zwriv7Lk7nh0aRxd0rBKE6kbj+ahAU7eSpMapWCQF0
         7RnsjZzc7lG1v/hifT3VQfRBPSZrIRmogtNSPrXr+Pb95V5SVH6gAx9MFKj0jWGghwBz
         vNhy1UtOBO6flGlVW1dtKYYB5mEMAfpvXKMvF/tMRQVMmWVbeclg7UWpxT1nVXVriO/4
         aOczS8ov4WkjwAbSbcAfR2LUtguNo89UQbpUoX8O+rJ/c5mJxGnxmtpdAfZ0j5RK1Jh/
         01m62CuQz1hm1gFHaWO1Oj5nrsJQDWy88Hbu0+lZR+aX6+ll3isofKkrFcRti7UQjtQk
         rkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702936381; x=1703541181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qL6Hfk+uqwtN0FGrPdWYTs1ebhUVgd8KgkwFHPg64Lk=;
        b=l6nFSVHZhBtajMPhOhR1rYNWYcj0WrmK8sHhg9S5As7v6/YwADBZF+hjJXIPnSy/w+
         LBqTCm9iZw509TFXNVimNuWqMqZ9qtwkqbbPHGfDLRYkA71gxLBs11d9JEOWTHaM3Omz
         UYZ6lx4TzVTc+/ispFNOmhrQ6U3luf3SAF6UISBLK3mkZiRGGV0nL3Yhj+77HaBst1ga
         TnHkSJ3/PwuUv+1MbgOmbUgfsiay/AJY4oyE7t6ZhQXovG1MfqiUnByAo5MJeXb8qucW
         xf1nPm5R7skf67M2tUIc61YRTFkR4SwWuZIfpsHE0PyA2DcGnVMLGHFYpDu/cqDrpIm0
         M8lg==
X-Gm-Message-State: AOJu0YyERM/0x4hdMF0y6C/ix/ubg4sYfDZb/RB3YSg+SkzGxjA6z1fe
	w/mNDbN0yR4P+H+HqWJdWibx2WkPFNTx1PA3ft27BA==
X-Google-Smtp-Source: AGHT+IGcfs4lSTJfkLGXzFhIGnzieJHv5rnAJxXnS53tFTrXJm63SMA3fMbE6syGwJ8lzSzgsSoOhpYioFVHH40cxnc=
X-Received: by 2002:a05:6122:4e90:b0:4b6:bb4c:ce57 with SMTP id
 gf16-20020a0561224e9000b004b6bb4cce57mr1756085vkb.6.1702936381100; Mon, 18
 Dec 2023 13:53:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi01_qktkitg@mail.gmail.com>
 <20231218144431.GB19167@cmpxchg.org>
In-Reply-To: <20231218144431.GB19167@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 18 Dec 2023 13:52:23 -0800
Message-ID: <CAJD7tkakMjE1sNfexLzooptDyQS4YZf5DmuoywnSFD7JTbh9BA@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, tj@kernel.org, 
	lizefan.x@bytedance.com, cerasuolodomenico@gmail.com, sjenning@redhat.com, 
	ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeelb@google.com, muchun.song@linux.dev, 
	hughd@google.com, corbet@lwn.net, konrad.wilk@oracle.com, 
	senozhatsky@chromium.org, rppt@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	david@ixit.cz, chrisl@kernel.org, Wei Xu <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

> > Taking a step back from all the memory.swap.tiers vs.
> > memory.zswap.writeback discussions, I think there may be a more
> > fundamental problem here. If the zswap store failure is recurrent,
> > pages can keep going back to the LRUs and then sent back to zswap
> > eventually, only to be rejected again. For example, this can if zswap
> > is above the acceptance threshold, but could be even worse if it's the
> > allocator rejecting the page due to not compressing well enough. In
> > the latter case, the page can keep going back and forth between zswap
> > and LRUs indefinitely.
> >
> > You probably did not run into this as you're using zsmalloc, but it
> > can happen with zbud AFAICT. Even with zsmalloc, a less problematic
> > version can happen if zswap is above its acceptance threshold.
> >
> > This can cause thrashing and ineffective reclaim. We have an internal
> > implementation where we mark incompressible pages and put them on the
> > unevictable LRU when we don't have a backing swapfile (i.e. ghost
> > swapfiles), and something similar may work if writeback is disabled.
> > We need to scan such incompressible pages periodically though to
> > remove them from the unevictable LRU if they have been dirited.
>
> I'm not sure this is an actual problem.
>
> When pages get rejected, they rotate to the furthest point from the
> reclaimer - the head of the active list. We only get to them again
> after we scanned everything else.
>
> If all that's left on the LRU is unzswappable, then you'd assume that
> remainder isn't very large, and thus not a significant part of overall
> scan work. Because if it is, then there is a serious problem with the
> zswap configuration.
>
> There might be possible optimizations to determine how permanent a
> rejection is, but I'm not sure the effort is called for just
> yet. Rejections are already failure cases that screw up the LRU
> ordering, and healthy setups shouldn't have a lot of those. I don't
> think this patch adds any sort of new complications to this picture.

We have workloads where a significant amount (maybe 20%? 30% not sure
tbh) of the memory is incompressible. Zswap is still a very viable
option for those workloads once those pages are taken out of the
picture. If those pages remain on the LRUs, they will introduce a
regression in reclaim efficiency.

With the upstream code today, those pages go directly to the backing
store, which isn't ideal in terms of LRU ordering, but this patch
makes them stay on the LRUs, which can be harmful. I don't think we
can just assume it is okay. Whether we make those pages unevictable or
store them uncompressed in zswap, I think taking them out of the LRUs
(until they are redirtied), is the right thing to do.

Adding Wei and Yu for more data about incompressible memory in our
fleet. Keep in mind that we have internal patches to cap the
compression ratio (i.e. reject pages where the compressed size +
metadata is not worth it, or where zsmalloc will store it in a full
page anyway). But the same thing can happen upstream with zbud.

