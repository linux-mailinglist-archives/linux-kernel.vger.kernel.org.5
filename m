Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F8D79D2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjILNwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjILNwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:52:36 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3725810D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:52:32 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7a84609acc6so258706241.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694526751; x=1695131551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzhOpAWh1roWufQ3LpAtbJqxibdBhs/iHC4UgrfWeT4=;
        b=VccrmyI1xf34qkfvxBK0LfyYMZYJdIOrb4bubu4NV4y1WmAL3UH2Rdix7Z6PKjcpcG
         riRx7cez6GiPk+KHXGsh/6EQRuThL9Wq4g0igT/RdDiDUhj6KRLmL45iu/YA0Beh/y/I
         HQawdOps/1/RY7ls0LsalOvRo9XPKp/2+woMKCplaVUNlE1J91ZTt5W2qNVzNV095djL
         AKInKbpU+2bMl6wjb1waK+AWuear0z2W8rAAS9lfqnq4v8d2fLmNkAX6I8JSA8UyTXgG
         D6d3KLqdcRSky1rYtk8KxAs0LLXq5WGK/nLPjl+TT7cDSxXXt8U7rsTN7gLtMwbB0eAv
         pEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526751; x=1695131551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzhOpAWh1roWufQ3LpAtbJqxibdBhs/iHC4UgrfWeT4=;
        b=FYw3yZSpdenLSQ5Q6qEu2DJodufi18XRLgbujGt0iugpjoBar2YL2fehpMpcS9TmsH
         WMNkTY4JPJ3C5UTHtpKnclk9HT6owH2ArOwrBKtJA8DWxhAq+xMEm/hC8FG8PvCyqK5u
         CMjkZmujNqeV6vHuCwis3Zn4zbtb2Mvj+s9Ys6yX4rKORHpMAekNf0Vm1rOUlcbH3PWc
         0HkS0HI9zAbDdpue6sAYQjUioYqDWbcRiRM/FF1QL20Ou9x/RzkqtBdHSF9lcb92NUuT
         +dAWGBO4PTwhBUd29v1hq/t02qvH35I5dLbWrWAjNo0+Gv8pC34Pmn2nBHTlh36Yc89y
         7b8A==
X-Gm-Message-State: AOJu0YyInFJ9Z0ScVLf29Ymgsxq1KPBGRb4Pdwz2rgxaD762eAjh+scO
        oFMYLjJTGqK4KX6FpzJEKaI/9nv3lAxRolZK9sg=
X-Google-Smtp-Source: AGHT+IHxd3rp8UROjoeMiC42smp2+6ErUpiQMfAvfKvtLedzaIU2SlbFQE9r/OH0JyAhv6hTEcAOymkLAHmS7ib5jjQ=
X-Received: by 2002:a67:fd19:0:b0:44d:5a92:ec40 with SMTP id
 f25-20020a67fd19000000b0044d5a92ec40mr10615940vsr.24.1694526750968; Tue, 12
 Sep 2023 06:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230905141348.32946-1-feng.tang@intel.com> <20230905141348.32946-2-feng.tang@intel.com>
In-Reply-To: <20230905141348.32946-2-feng.tang@intel.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Tue, 12 Sep 2023 13:52:19 +0900
Message-ID: <CAB=+i9SP2j=VEDi52ga0WgPWSeDzdmTYisA4PAnR26Natp3swA@mail.gmail.com>
Subject: Re: [RFC Patch 1/3] mm/slub: increase the maximum slab order to 4 for
 big systems
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 11:07=E2=80=AFPM Feng Tang <feng.tang@intel.com> wro=
te:
>
> There are reports about severe lock contention for slub's per-node
> 'list_lock' in 'hackbench' test, [1][2], on server systems. And
> similar contention is also seen when running 'mmap1' case of
> will-it-scale on big systems. As the trend is one processor (socket)
> will have more and more CPUs (100+, 200+), the contention could be
> much more severe and becomes a scalability issue.
>
> One way to help reducing the contention is to increase the maximum
> slab order from 3 to 4, for big systems.

Hello Feng,

Increasing order with a higher number of CPUs (and so with more
memory) makes sense to me.
IIUC the contention here becomes worse when the number of slabs
increases, so it makes sense to
decrease the number of slabs by increasing order.

By the way, my silly question here is:
In the first place, is it worth taking 1/2 of s->cpu_partial_slabs in
the slowpath when slab is frequently used?
wouldn't the cpu partial slab list be re-filled again by free if free
operations are frequently performed?

> Unconditionally increasing the order could  bring trouble to client
> devices with very limited size of memory, which may care more about
> memory footprint, also allocating order 4 page could be harder under
> memory pressure. So the increase will only be done for big systems
> like servers, which usually are equipped with plenty of memory and
> easier to hit lock contention issues.

Also, does it make sense not to increase the order when PAGE_SIZE > 4096?

> Following is some performance data:
>
> will-it-scale/mmap1
> -------------------
> Run will-it-scale benchmark's 'mmap1' test case on a 2 socket Sapphire
> Rapids server (112 cores / 224 threads) with 256 GB DRAM, run 3
> configurations with parallel test threads of 25%, 50% and 100% of
> number of CPUs, and the data is (base is vanilla v6.5 kernel):
>
>                      base                      base+patch
> wis-mmap1-25%       223670           +33.3%     298205        per_process=
_ops
> wis-mmap1-50%       186020           +51.8%     282383        per_process=
_ops
> wis-mmap1-100%       89200           +65.0%     147139        per_process=
_ops
>
> Take the perf-profile comparasion of 50% test case, the lock contention
> is greatly reduced:
>
>       43.80           -30.8       13.04       pp.self.native_queued_spin_=
lock_slowpath
>       0.85            -0.2        0.65        pp.self.___slab_alloc
>       0.41            -0.1        0.27        pp.self.__unfreeze_partials
>       0.20 =C2=B1  2%      -0.1        0.12 =C2=B1  4%  pp.self.get_any_p=
artial
>
> hackbench
> ---------
>
> Run same hackbench testcase  mentioned in [1], use same HW/SW as will-it-=
scale:
>
>                      base                      base+patch
> hackbench           759951           +10.5%     839601        hackbench.t=
hroughput
>
> perf-profile diff:
>      22.20 =C2=B1  3%     -15.2        7.05        pp.self.native_queued_=
spin_lock_slowpath
>       0.82            -0.2        0.59        pp.self.___slab_alloc
>       0.33            -0.2        0.13        pp.self.__unfreeze_partials
>
> [1]. https://lore.kernel.org/all/202307172140.3b34825a-oliver.sang@intel.=
com/
> [2]. ttps://lore.kernel.org/lkml/ZORaUsd+So+tnyMV@chenyu5-mobl2/
> Signed-off-by: Feng Tang <feng.tang@intel.com>

> ---
>  mm/slub.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 38 insertions(+), 13 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index f7940048138c..09ae1ed642b7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4081,7 +4081,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_bulk);
>   */
>  static unsigned int slub_min_order;
>  static unsigned int slub_max_order =3D
> -       IS_ENABLED(CONFIG_SLUB_TINY) ? 1 : PAGE_ALLOC_COSTLY_ORDER;
> +       IS_ENABLED(CONFIG_SLUB_TINY) ? 1 : 4;
>  static unsigned int slub_min_objects;
>
>  /*
> @@ -4134,6 +4134,26 @@ static inline unsigned int calc_slab_order(unsigne=
d int size,
>         return order;
>  }
