Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A708066E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376881AbjLFGA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376768AbjLFGA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:00:26 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1157218F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:00:32 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ca1e6a94a4so7906241fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 22:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701842430; x=1702447230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pYq7dca+Gj7nooc7F/6CDn/Z/YkbYvbbjyp+G0CHbFs=;
        b=q8/JA6e8J2GfDlvAF0MP1P3w481K0P2Nf6S4PQcV1k/ioS66LU7FHv/2dz5JR4RcwI
         Hl3x81fUSCcn4zvWZhgq6kGkJjjwJcY5O14EEUQaorbU59hk9iPaD7DRt1Ot3SwPz4/2
         HCGbIhB8I+ka/a8MPpYVYmhIhxy5stP5II+KIRPZcQdU89anGB7fd/dVfIXPNqZp1xD0
         5xZn5m4C7VMoZ0A8+oU3M2eD2rUNjKVSkOyvFTC77HslFPp7uLfwmguTbulF+KsXhnS1
         yqtEFl4fOaoA5Xd8Zz5Vb9HZf1niS0gkqbtWJeIlzt8W5DWR96R/7bijY2TICAk5kaRH
         19ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701842430; x=1702447230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYq7dca+Gj7nooc7F/6CDn/Z/YkbYvbbjyp+G0CHbFs=;
        b=HLoloEaGZi/cHaiPjkTZipXBjH/IUpSVSGYJjfNXo3qGAYs2AYD2lTzH6FIJeLc6bz
         aoaaKZExFxn+q9GtCQOjnQ9LaJVU4F31rn/Jf8aH9/4aZmTP8GmJnmObt6L4xrmO1KAN
         qjweRpasPmktN9MOqCJtxC4cvxgocvHBwVZ4/k2+9TrZ7CfV2u4Uzk3HDR/+re2lss2U
         N85XC2BOlVEaCgsx/BFZKp9myYf+6hUTy/dmaexAr5QeRxKPDqWZ3hKhj+cyHg5GQX2r
         gc116+RabP3bajZytwMDWgfhnK0QqczOgt2n5fWj0fNnh5V2UYd6nphWUsrMjV7PfNM+
         R3wA==
X-Gm-Message-State: AOJu0YxnU9Sfrj/7iwXMffOBb8BMwgvRuQQqfBDJJ1kxEnBjbK6IsczT
        sBqoiFe2wgYuOfxYk8F/HOzXhx3nsCMifAGAEI6z2Q==
X-Google-Smtp-Source: AGHT+IFXAeoJL6ZSpivoVRoRx5sclW/hkOTwH9MNxBDf0+k3EyWFJczCRuAq+UUItgKlQjTWq1Kko/YxHxXsgyIZ2LI=
X-Received: by 2002:a2e:87d7:0:b0:2ca:ac6:9f94 with SMTP id
 v23-20020a2e87d7000000b002ca0ac69f94mr178430ljj.86.1701842430004; Tue, 05 Dec
 2023 22:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-7-nphamcs@gmail.com>
 <ed2792de-24cc-4037-9ee1-966cc07df57a@linux.dev>
In-Reply-To: <ed2792de-24cc-4037-9ee1-966cc07df57a@linux.dev>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 5 Dec 2023 21:59:50 -0800
Message-ID: <CAJD7tkbiWqXs1PEZjMHO0gj5uSaaB-KNUNCiUz25MuPvzeb=wg@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] zswap: shrinks zswap pool based on memory pressure
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[..]
> > @@ -526,6 +582,102 @@ static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
> >       return entry;
> >  }
> >
> > +/*********************************
> > +* shrinker functions
> > +**********************************/
> > +static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
> > +                                    spinlock_t *lock, void *arg);
> > +
> > +static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
> > +             struct shrink_control *sc)
> > +{
> > +     struct lruvec *lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
> > +     unsigned long shrink_ret, nr_protected, lru_size;
> > +     struct zswap_pool *pool = shrinker->private_data;
> > +     bool encountered_page_in_swapcache = false;
> > +
> > +     nr_protected =
> > +             atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
> > +     lru_size = list_lru_shrink_count(&pool->list_lru, sc);
> > +
> > +     /*
> > +      * Abort if the shrinker is disabled or if we are shrinking into the
> > +      * protected region.
> > +      *
> > +      * This short-circuiting is necessary because if we have too many multiple
> > +      * concurrent reclaimers getting the freeable zswap object counts at the
> > +      * same time (before any of them made reasonable progress), the total
> > +      * number of reclaimed objects might be more than the number of unprotected
> > +      * objects (i.e the reclaimers will reclaim into the protected area of the
> > +      * zswap LRU).
> > +      */
> > +     if (!zswap_shrinker_enabled || nr_protected >= lru_size - sc->nr_to_scan) {
> > +             sc->nr_scanned = 0;
> > +             return SHRINK_STOP;
> > +     }
> > +
> > +     shrink_ret = list_lru_shrink_walk(&pool->list_lru, sc, &shrink_memcg_cb,
> > +             &encountered_page_in_swapcache);
> > +
> > +     if (encountered_page_in_swapcache)
> > +             return SHRINK_STOP;
> > +
> > +     return shrink_ret ? shrink_ret : SHRINK_STOP;
> > +}
> > +
> > +static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
> > +             struct shrink_control *sc)
> > +{
> > +     struct zswap_pool *pool = shrinker->private_data;
> > +     struct mem_cgroup *memcg = sc->memcg;
> > +     struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
> > +     unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
> > +
> > +#ifdef CONFIG_MEMCG_KMEM
> > +     cgroup_rstat_flush(memcg->css.cgroup);
> > +     nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
> > +     nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
> > +#else
> > +     /* use pool stats instead of memcg stats */
> > +     nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;
> > +     nr_stored = atomic_read(&pool->nr_stored);
> > +#endif
> > +
> > +     if (!zswap_shrinker_enabled || !nr_stored)
> When I tested with this series, with !zswap_shrinker_enabled in the default case,
> I found the performance is much worse than that without this patch.
>
> Testcase: memory.max=2G, zswap enabled, kernel build -j32 in a tmpfs directory.
>
> The reason seems the above cgroup_rstat_flush(), caused much rstat lock contention
> to the zswap_store() path. And if I put the "zswap_shrinker_enabled" check above
> the cgroup_rstat_flush(), the performance become much better.
>
> Maybe we can put the "zswap_shrinker_enabled" check above cgroup_rstat_flush()?

Yes, we should do nothing if !zswap_shrinker_enabled. We should also
use mem_cgroup_flush_stats() here like other places unless accuracy is
crucial, which I doubt given that reclaim uses
mem_cgroup_flush_stats().

mem_cgroup_flush_stats() has some thresholding to make sure we don't
do flushes unnecessarily, and I have a pending series in mm-unstable
that makes that thresholding per-memcg. Keep in mind that adding a
call to mem_cgroup_flush_stats() will cause a conflict in mm-unstable,
because the series there adds a memcg argument to
mem_cgroup_flush_stats(). That should be easily amenable though, I can
post a fixlet for my series to add the memcg argument there on top of
users if needed.

>
> Thanks!
>
> > +             return 0;
> > +
> > +     nr_protected =
> > +             atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
> > +     nr_freeable = list_lru_shrink_count(&pool->list_lru, sc);
> > +     /*
> > +      * Subtract the lru size by an estimate of the number of pages
> > +      * that should be protected.
> > +      */
> > +     nr_freeable = nr_freeable > nr_protected ? nr_freeable - nr_protected : 0;
> > +
> > +     /*
> > +      * Scale the number of freeable pages by the memory saving factor.
> > +      * This ensures that the better zswap compresses memory, the fewer
> > +      * pages we will evict to swap (as it will otherwise incur IO for
> > +      * relatively small memory saving).
> > +      */
> > +     return mult_frac(nr_freeable, nr_backing, nr_stored);
> > +}
> > +
> > +static void zswap_alloc_shrinker(struct zswap_pool *pool)
> > +{
> > +     pool->shrinker =
> > +             shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE, "mm-zswap");
> > +     if (!pool->shrinker)
> > +             return;
> > +
> > +     pool->shrinker->private_data = pool;
> > +     pool->shrinker->scan_objects = zswap_shrinker_scan;
> > +     pool->shrinker->count_objects = zswap_shrinker_count;
> > +     pool->shrinker->batch = 0;
> > +     pool->shrinker->seeks = DEFAULT_SEEKS;
> > +}
> > +
> >  /*********************************
> >  * per-cpu code
> >  **********************************/
[..]
