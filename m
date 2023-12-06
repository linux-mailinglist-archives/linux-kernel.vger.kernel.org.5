Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B276806882
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjLFHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:37:03 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86287D40
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:08 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b5155e154so71127725e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 23:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701848227; x=1702453027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Isn26eYQ7Abxs6xHNfpvbrXVMUNZJcXSAjCQgZHcKYQ=;
        b=ZlDbIHvKC241BSdnp1tWnowsWQb4XzbxxfZnm32/HBDiXXX739JZr0s+4Km7RyIWPw
         KEZlA5MrLate2bpCQL3EyoRiwmmZyX3DFt46HbBGTtmQrcBdQ7XWunacS3GcCK8suhFV
         J4VOVKq/LH3CD/iqqmh1MXmJg+RH4T+sr4TcIsHUUyDkoIR0L1IM+oYDSh0RQLwuCa5P
         RkeEnldmvU7GOaNC8DuY1OEFJM3z0s2mmZvvd4jItnQV61LokCwi+2EmfVbMYjgVcv5I
         6hzIyeBl2/bKhDz8c/7pG77gGnvvSWl9jllVgwdXDiDUdHISvaKWmviW8r7VQcjcGS1p
         maag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701848227; x=1702453027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Isn26eYQ7Abxs6xHNfpvbrXVMUNZJcXSAjCQgZHcKYQ=;
        b=Qil+hF3Hgsi1COSWabyRFhbOWWjowhDdEdoRY/On/klYqosoXUJJkmByecosjTblq6
         ufwus61sdINKCNbKeuzcfyVLQViTLiFAorewxGGv4ZWEaxo0qtxtytUd6uEFWXrMj4m2
         m/agDCohZWj7xi2UFi1auz6DDhp2eFVJdkdq6F/cxehb1TZvZyT/SnuEa6llPK7TrY7W
         /WQhluUsHfoRuc/HK6LucDYMWKqmoSdEqVrv6jdSl5auyMDIh3f9KTth9ihXIbWvYnYM
         kedSqVy9EV799RchA8Z5qLupFIM6ZjIDce7tnh4z+UfRZtqlfd3cY9OEvy8SNTkXugFI
         xS/Q==
X-Gm-Message-State: AOJu0YxtHZxvHBnYBqzo/fqMwJtZoNAj7iOuPIOZWskeXPdaHTDHjIsd
        pFANv7cfLXE1luxJH79uKbx3G/13WUscHHvho1xWEA==
X-Google-Smtp-Source: AGHT+IHMFcve1d/1bLnN0dRZq51LAGCmSPmZ64T49E0eQxLrv4N0iurlN0xX+BnnKoG17JilTXJsE1CRujLhaKDLhZ0=
X-Received: by 2002:a05:600c:3155:b0:40b:4c39:b4b with SMTP id
 h21-20020a05600c315500b0040b4c390b4bmr308415wmo.0.1701848226590; Tue, 05 Dec
 2023 23:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-7-nphamcs@gmail.com>
 <ed2792de-24cc-4037-9ee1-966cc07df57a@linux.dev> <CAJD7tkbiWqXs1PEZjMHO0gj5uSaaB-KNUNCiUz25MuPvzeb=wg@mail.gmail.com>
 <e55f5841-9b6e-47a1-9f68-3907ab0190e0@linux.dev>
In-Reply-To: <e55f5841-9b6e-47a1-9f68-3907ab0190e0@linux.dev>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 5 Dec 2023 23:36:27 -0800
Message-ID: <CAJD7tkYkgRxDgZzCs2su7e4ocr5=zz2fjjr81+t35d_sp0E0gQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 10:43=E2=80=AFPM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> On 2023/12/6 13:59, Yosry Ahmed wrote:
> > [..]
> >>> @@ -526,6 +582,102 @@ static struct zswap_entry *zswap_entry_find_get=
(struct rb_root *root,
> >>>       return entry;
> >>>  }
> >>>
> >>> +/*********************************
> >>> +* shrinker functions
> >>> +**********************************/
> >>> +static enum lru_status shrink_memcg_cb(struct list_head *item, struc=
t list_lru_one *l,
> >>> +                                    spinlock_t *lock, void *arg);
> >>> +
> >>> +static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
> >>> +             struct shrink_control *sc)
> >>> +{
> >>> +     struct lruvec *lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DAT=
A(sc->nid));
> >>> +     unsigned long shrink_ret, nr_protected, lru_size;
> >>> +     struct zswap_pool *pool =3D shrinker->private_data;
> >>> +     bool encountered_page_in_swapcache =3D false;
> >>> +
> >>> +     nr_protected =3D
> >>> +             atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_p=
rotected);
> >>> +     lru_size =3D list_lru_shrink_count(&pool->list_lru, sc);
> >>> +
> >>> +     /*
> >>> +      * Abort if the shrinker is disabled or if we are shrinking int=
o the
> >>> +      * protected region.
> >>> +      *
> >>> +      * This short-circuiting is necessary because if we have too ma=
ny multiple
> >>> +      * concurrent reclaimers getting the freeable zswap object coun=
ts at the
> >>> +      * same time (before any of them made reasonable progress), the=
 total
> >>> +      * number of reclaimed objects might be more than the number of=
 unprotected
> >>> +      * objects (i.e the reclaimers will reclaim into the protected =
area of the
> >>> +      * zswap LRU).
> >>> +      */
> >>> +     if (!zswap_shrinker_enabled || nr_protected >=3D lru_size - sc-=
>nr_to_scan) {
> >>> +             sc->nr_scanned =3D 0;
> >>> +             return SHRINK_STOP;
> >>> +     }
> >>> +
> >>> +     shrink_ret =3D list_lru_shrink_walk(&pool->list_lru, sc, &shrin=
k_memcg_cb,
> >>> +             &encountered_page_in_swapcache);
> >>> +
> >>> +     if (encountered_page_in_swapcache)
> >>> +             return SHRINK_STOP;
> >>> +
> >>> +     return shrink_ret ? shrink_ret : SHRINK_STOP;
> >>> +}
> >>> +
> >>> +static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
> >>> +             struct shrink_control *sc)
> >>> +{
> >>> +     struct zswap_pool *pool =3D shrinker->private_data;
> >>> +     struct mem_cgroup *memcg =3D sc->memcg;
> >>> +     struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(sc=
->nid));
> >>> +     unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
> >>> +
> >>> +#ifdef CONFIG_MEMCG_KMEM
> >>> +     cgroup_rstat_flush(memcg->css.cgroup);
> >>> +     nr_backing =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_S=
HIFT;
> >>> +     nr_stored =3D memcg_page_state(memcg, MEMCG_ZSWAPPED);
> >>> +#else
> >>> +     /* use pool stats instead of memcg stats */
> >>> +     nr_backing =3D get_zswap_pool_size(pool) >> PAGE_SHIFT;
> >>> +     nr_stored =3D atomic_read(&pool->nr_stored);
> >>> +#endif
> >>> +
> >>> +     if (!zswap_shrinker_enabled || !nr_stored)
> >> When I tested with this series, with !zswap_shrinker_enabled in the de=
fault case,
> >> I found the performance is much worse than that without this patch.
> >>
> >> Testcase: memory.max=3D2G, zswap enabled, kernel build -j32 in a tmpfs=
 directory.
> >>
> >> The reason seems the above cgroup_rstat_flush(), caused much rstat loc=
k contention
> >> to the zswap_store() path. And if I put the "zswap_shrinker_enabled" c=
heck above
> >> the cgroup_rstat_flush(), the performance become much better.
> >>
> >> Maybe we can put the "zswap_shrinker_enabled" check above cgroup_rstat=
_flush()?
> >
> > Yes, we should do nothing if !zswap_shrinker_enabled. We should also
> > use mem_cgroup_flush_stats() here like other places unless accuracy is
> > crucial, which I doubt given that reclaim uses
> > mem_cgroup_flush_stats().
> >
>
> Yes. After changing to use mem_cgroup_flush_stats() here, the performance
> become much better.
>
> > mem_cgroup_flush_stats() has some thresholding to make sure we don't
> > do flushes unnecessarily, and I have a pending series in mm-unstable
> > that makes that thresholding per-memcg. Keep in mind that adding a
> > call to mem_cgroup_flush_stats() will cause a conflict in mm-unstable,
>
> My test branch is linux-next 20231205, and it's all good after changing
> to use mem_cgroup_flush_stats(memcg).

Thanks for reporting back. We should still move the
zswap_shrinker_enabled check ahead, no need to even call
mem_cgroup_flush_stats() if we will do nothing anyway.

>
> > because the series there adds a memcg argument to
> > mem_cgroup_flush_stats(). That should be easily amenable though, I can
> > post a fixlet for my series to add the memcg argument there on top of
> > users if needed.
> >
>
> It's great. Thanks!
>
