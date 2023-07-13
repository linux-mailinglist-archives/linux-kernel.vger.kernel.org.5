Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383A4751EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjGMKg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGMKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:36:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3128119
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:36:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9923833737eso77499066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689244584; x=1691836584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jd1121X7hsRvwiEJeJMLPNg8mwgNjy602P1L116XEcs=;
        b=HaEMQlr7i8zLaHQPhT6SIWg7l0Vnd9Hm/q/EpxhxzG3pGYe8fmNTs3yfziEnx54L8X
         BBeGvNXzdMkVJLTVkJP7xyLqt8BctjGgAqtiozXpNuBVSIstjta5KQs9YrLoCRjFW4Yt
         PET2vnT4WsmIuE9P53P913Po4NP4x5EexljWVAu4gjmh7+zZouy64E4EdP2uoZcHpy9A
         2CjtwfORSBjquw8IarxbGW0E1goiHQS8kXeUfkdtGOWWcXczjm79nbR1n2dTdtZoEyMV
         n0q84qM0DqIGN4AMXK7l0H6K7p4gG5Nsykp/sw2hFcip8Eas0+eLSztN07ntxBwbpmQp
         caBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689244584; x=1691836584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jd1121X7hsRvwiEJeJMLPNg8mwgNjy602P1L116XEcs=;
        b=KBonCB8fbjRO8fvaSdGsT49ecQp1kULUHHELdyh0AfTFMIzOHLvDt1HC2nl1oTQvef
         nsxhUdSODdRUedAm2IO8iOgoRR2SFREyrHvW4fjdHhrvN4GjvHEnIA4dLHUhLl2aRnnm
         jUxEzH6/ZSLpWE3n4xY5/nQ9pkodaLFMaRN9EDx54nNeo42Cu+McymYfDtKY77bqFdjj
         CNnthiqEylVovNiXG11AvSjsRkIE0hYHM6BFTiLpvBaHVgbfEc/vRhHXyKGAltLvwqie
         FfPXlHnVcKll9tIc17wndEva3dbv8O5jejSdAH9Wjt9WVeF9IAzqhaJaApyt70YPoaf8
         +fyg==
X-Gm-Message-State: ABy/qLYD4k7f6t+LidXW/PyJzRjzHX5jp+JAUWoLjPQ0YIngUs4kRSKk
        uJ6EAzv89TtSU6pWXBNi6m9BeF+Wk5mAUb5wKjpR+rRlUgk1iAGOx5OAJQ==
X-Google-Smtp-Source: APBJJlEMePIAUiTiUCnDu4vL3G3jnPFL6cjAEPuLEumvIqDGIZSdlywlZU46R7j9giw2uti/vuMTQB912NMqbx4ezwc=
X-Received: by 2002:a17:906:210:b0:993:d117:e3b9 with SMTP id
 16-20020a170906021000b00993d117e3b9mr1190491ejd.20.1689244583819; Thu, 13 Jul
 2023 03:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230620194644.3142384-1-yosryahmed@google.com> <CAKEwX=OLR02MazB31wR-nphjZJvBHrm5Zy7hLPByZ3ubgO8mjw@mail.gmail.com>
In-Reply-To: <CAKEwX=OLR02MazB31wR-nphjZJvBHrm5Zy7hLPByZ3ubgO8mjw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 13 Jul 2023 03:35:25 -0700
Message-ID: <CAJD7tkZ7dLwny7-CX7qCywZPtki+fDuESGfv+B9QG87cSsrHVQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: zswap: multiple zpools support
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Jul 9, 2023 at 4:12=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Tue, Jun 20, 2023 at 12:46=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > Support using multiple zpools of the same type in zswap, for concurrenc=
y
> > purposes. A fixed number of 32 zpools is suggested by this commit, whic=
h
> > was determined empirically. It can be later changed or made into a
> > config option if needed.
> >
> > On a setup with zswap and zsmalloc, comparing a single zpool to 32
> > zpools shows improvements in the zsmalloc lock contention, especially o=
n
> > the swap out path.
> >
> > The following shows the perf analysis of the swapout path when 10
> > workloads are simultaneously reclaiming and refaulting tmpfs pages.
> > There are some improvements on the swap in path as well, but less
> > significant.
> >
> > 1 zpool:
> >
> >  |--28.99%--zswap_frontswap_store
> >        |
> >        <snip>
> >        |
> >        |--8.98%--zpool_map_handle
> >        |     |
> >        |      --8.98%--zs_zpool_map
> >        |           |
> >        |            --8.95%--zs_map_object
> >        |                 |
> >        |                  --8.38%--_raw_spin_lock
> >        |                       |
> >        |                        --7.39%--queued_spin_lock_slowpath
> >        |
> >        |--8.82%--zpool_malloc
> >        |     |
> >        |      --8.82%--zs_zpool_malloc
> >        |           |
> >        |            --8.80%--zs_malloc
> >        |                 |
> >        |                 |--7.21%--_raw_spin_lock
> >        |                 |     |
> >        |                 |      --6.81%--queued_spin_lock_slowpath
> >        <snip>
> >
> > 32 zpools:
> >
> >  |--16.73%--zswap_frontswap_store
> >        |
> >        <snip>
> >        |
> >        |--1.81%--zpool_malloc
> >        |     |
> >        |      --1.81%--zs_zpool_malloc
> >        |           |
> >        |            --1.79%--zs_malloc
> >        |                 |
> >        |                  --0.73%--obj_malloc
> >        |
> >        |--1.06%--zswap_update_total_size
> >        |
> >        |--0.59%--zpool_map_handle
> >        |     |
> >        |      --0.59%--zs_zpool_map
> >        |           |
> >        |            --0.57%--zs_map_object
> >        |                 |
> >        |                  --0.51%--_raw_spin_lock
> >        <snip>
> >
> > Suggested-by: Yu Zhao <yuzhao@google.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >
> > v2 -> v3:
> > - Removed config option (Johannes Weiner). Now it's a constant.
> > - Fixed spelling typos (Yu Zhao).
> >
> > v1 -> v2:
> > - Prettified perf graph in commit log.
> > - Changed zswap_nr_zpools to a macro, changed zswap_pool->zpools to a
> >   fixed size array instead of a flex array.
> > - Removed stale comment.
> >
> > ---
> >  mm/zswap.c | 81 ++++++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 54 insertions(+), 27 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 87b204233115..6ee7028497b8 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -142,6 +142,9 @@ static bool zswap_exclusive_loads_enabled =3D IS_EN=
ABLED(
> >                 CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON);
> >  module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, boo=
l, 0644);
> >
> > +/* Number of zpools in zswap_pool (empirically determined for scalabil=
ity) */
> > +#define ZSWAP_NR_ZPOOLS 32
> > +
> >  /*********************************
> >  * data structures
> >  **********************************/
> > @@ -161,7 +164,7 @@ struct crypto_acomp_ctx {
> >   * needs to be verified that it's still valid in the tree.
> >   */
> >  struct zswap_pool {
> > -       struct zpool *zpool;
> > +       struct zpool *zpools[ZSWAP_NR_ZPOOLS];
> >         struct crypto_acomp_ctx __percpu *acomp_ctx;
> >         struct kref kref;
> >         struct list_head list;
> > @@ -248,7 +251,7 @@ static bool zswap_has_pool;
> >
> >  #define zswap_pool_debug(msg, p)                               \
> >         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
> > -                zpool_get_type((p)->zpool))
> > +                zpool_get_type((p)->zpools[0]))
> >
> >  static int zswap_writeback_entry(struct zswap_entry *entry,
> >                                  struct zswap_tree *tree);
> > @@ -272,11 +275,13 @@ static void zswap_update_total_size(void)
> >  {
> >         struct zswap_pool *pool;
> >         u64 total =3D 0;
> > +       int i;
> >
> >         rcu_read_lock();
> >
> >         list_for_each_entry_rcu(pool, &zswap_pools, list)
> > -               total +=3D zpool_get_total_size(pool->zpool);
> > +               for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> > +                       total +=3D zpool_get_total_size(pool->zpools[i]=
);
> >
> >         rcu_read_unlock();
> >
> > @@ -363,6 +368,16 @@ static void zswap_rb_erase(struct rb_root *root, s=
truct zswap_entry *entry)
> >         }
> >  }
> >
> > +static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
> > +{
> > +       int i =3D 0;
> > +
> > +       if (ZSWAP_NR_ZPOOLS > 1)
> > +               i =3D hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS));
> > +
> > +       return entry->pool->zpools[i];
> > +}
> > +
> >  /*
> >   * Carries out the common pattern of freeing and entry's zpool allocat=
ion,
> >   * freeing the entry itself, and decrementing the number of stored pag=
es.
> > @@ -379,7 +394,7 @@ static void zswap_free_entry(struct zswap_entry *en=
try)
> >                 spin_lock(&entry->pool->lru_lock);
> >                 list_del(&entry->lru);
> >                 spin_unlock(&entry->pool->lru_lock);
> > -               zpool_free(entry->pool->zpool, entry->handle);
> > +               zpool_free(zswap_find_zpool(entry), entry->handle);
> >                 zswap_pool_put(entry->pool);
> >         }
> >         zswap_entry_cache_free(entry);
> > @@ -588,7 +603,8 @@ static struct zswap_pool *zswap_pool_find_get(char =
*type, char *compressor)
> >         list_for_each_entry_rcu(pool, &zswap_pools, list) {
> >                 if (strcmp(pool->tfm_name, compressor))
> >                         continue;
> > -               if (strcmp(zpool_get_type(pool->zpool), type))
> > +               /* all zpools share the same type */
> > +               if (strcmp(zpool_get_type(pool->zpools[0]), type))
> >                         continue;
> >                 /* if we can't get it, it's about to be destroyed */
> >                 if (!zswap_pool_get(pool))
> > @@ -692,6 +708,7 @@ static void shrink_worker(struct work_struct *w)
> >
> >  static struct zswap_pool *zswap_pool_create(char *type, char *compress=
or)
> >  {
> > +       int i;
> >         struct zswap_pool *pool;
> >         char name[38]; /* 'zswap' + 32 char (max) num + \0 */
> >         gfp_t gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLA=
IM;
> > @@ -712,15 +729,18 @@ static struct zswap_pool *zswap_pool_create(char =
*type, char *compressor)
> >         if (!pool)
> >                 return NULL;
> >
> > -       /* unique name for each pool specifically required by zsmalloc =
*/
> > -       snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_co=
unt));
> > +       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++) {
> > +               /* unique name for each pool specifically required by z=
smalloc */
> > +               snprintf(name, 38, "zswap%x",
> > +                        atomic_inc_return(&zswap_pools_count));
> >
> > -       pool->zpool =3D zpool_create_pool(type, name, gfp);
> > -       if (!pool->zpool) {
> > -               pr_err("%s zpool not available\n", type);
> > -               goto error;
> > +               pool->zpools[i] =3D zpool_create_pool(type, name, gfp);
> > +               if (!pool->zpools[i]) {
> > +                       pr_err("%s zpool not available\n", type);
> > +                       goto error;
> > +               }
> >         }
> > -       pr_debug("using %s zpool\n", zpool_get_type(pool->zpool));
> > +       pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
> >
> >         strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
> >
> > @@ -752,8 +772,8 @@ static struct zswap_pool *zswap_pool_create(char *t=
ype, char *compressor)
> >  error:
> >         if (pool->acomp_ctx)
> >                 free_percpu(pool->acomp_ctx);
> > -       if (pool->zpool)
> > -               zpool_destroy_pool(pool->zpool);
> > +       while (i--)
> > +               zpool_destroy_pool(pool->zpools[i]);
> >         kfree(pool);
> >         return NULL;
> >  }
> > @@ -802,11 +822,14 @@ static struct zswap_pool *__zswap_pool_create_fal=
lback(void)
> >
> >  static void zswap_pool_destroy(struct zswap_pool *pool)
> >  {
> > +       int i;
> > +
> >         zswap_pool_debug("destroying", pool);
> >
> >         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->=
node);
> >         free_percpu(pool->acomp_ctx);
> > -       zpool_destroy_pool(pool->zpool);
> > +       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> > +               zpool_destroy_pool(pool->zpools[i]);
> >         kfree(pool);
> >  }
> >
> > @@ -1070,7 +1093,7 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
> >         struct page *page;
> >         struct scatterlist input, output;
> >         struct crypto_acomp_ctx *acomp_ctx;
> > -       struct zpool *pool =3D entry->pool->zpool;
> > +       struct zpool *pool =3D zswap_find_zpool(entry);
> >
> >         u8 *src, *tmp =3D NULL;
> >         unsigned int dlen;
> > @@ -1211,6 +1234,7 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
> >         struct crypto_acomp_ctx *acomp_ctx;
> >         struct obj_cgroup *objcg =3D NULL;
> >         struct zswap_pool *pool;
> > +       struct zpool *zpool;
> >         int ret;
> >         unsigned int dlen =3D PAGE_SIZE;
> >         unsigned long handle, value;
> > @@ -1321,10 +1345,11 @@ static int zswap_frontswap_store(unsigned type,=
 pgoff_t offset,
> >         }
> >
> >         /* store */
> > +       zpool =3D zswap_find_zpool(entry);
> >         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> > -       if (zpool_malloc_support_movable(entry->pool->zpool))
> > +       if (zpool_malloc_support_movable(zpool))
> >                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> > -       ret =3D zpool_malloc(entry->pool->zpool, dlen, gfp, &handle);
> > +       ret =3D zpool_malloc(zpool, dlen, gfp, &handle);
> >         if (ret =3D=3D -ENOSPC) {
> >                 zswap_reject_compress_poor++;
> >                 goto put_dstmem;
> > @@ -1333,9 +1358,9 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
> >                 zswap_reject_alloc_fail++;
> >                 goto put_dstmem;
> >         }
> > -       buf =3D zpool_map_handle(entry->pool->zpool, handle, ZPOOL_MM_W=
O);
> > +       buf =3D zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
> >         memcpy(buf, dst, dlen);
> > -       zpool_unmap_handle(entry->pool->zpool, handle);
> > +       zpool_unmap_handle(zpool, handle);
> >         mutex_unlock(acomp_ctx->mutex);
> >
> >         /* populate entry */
> > @@ -1406,6 +1431,7 @@ static int zswap_frontswap_load(unsigned type, pg=
off_t offset,
> >         struct scatterlist input, output;
> >         struct crypto_acomp_ctx *acomp_ctx;
> >         u8 *src, *dst, *tmp;
> > +       struct zpool *zpool;
> >         unsigned int dlen;
> >         int ret;
> >
> > @@ -1427,7 +1453,8 @@ static int zswap_frontswap_load(unsigned type, pg=
off_t offset,
> >                 goto stats;
> >         }
> >
> > -       if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> > +       zpool =3D zswap_find_zpool(entry);
> > +       if (!zpool_can_sleep_mapped(zpool)) {
> >                 tmp =3D kmalloc(entry->length, GFP_KERNEL);
> >                 if (!tmp) {
> >                         ret =3D -ENOMEM;
> > @@ -1437,12 +1464,12 @@ static int zswap_frontswap_load(unsigned type, =
pgoff_t offset,
> >
> >         /* decompress */
> >         dlen =3D PAGE_SIZE;
> > -       src =3D zpool_map_handle(entry->pool->zpool, entry->handle, ZPO=
OL_MM_RO);
> > +       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> >
> > -       if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> > +       if (!zpool_can_sleep_mapped(zpool)) {
> >                 memcpy(tmp, src, entry->length);
> >                 src =3D tmp;
> > -               zpool_unmap_handle(entry->pool->zpool, entry->handle);
> > +               zpool_unmap_handle(zpool, entry->handle);
> >         }
> >
> >         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > @@ -1454,8 +1481,8 @@ static int zswap_frontswap_load(unsigned type, pg=
off_t offset,
> >         ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req)=
, &acomp_ctx->wait);
> >         mutex_unlock(acomp_ctx->mutex);
> >
> > -       if (zpool_can_sleep_mapped(entry->pool->zpool))
> > -               zpool_unmap_handle(entry->pool->zpool, entry->handle);
> > +       if (zpool_can_sleep_mapped(zpool))
> > +               zpool_unmap_handle(zpool, entry->handle);
> >         else
> >                 kfree(tmp);
> >
> > @@ -1616,7 +1643,7 @@ static int zswap_setup(void)
> >         pool =3D __zswap_pool_create_fallback();
> >         if (pool) {
> >                 pr_info("loaded using pool %s/%s\n", pool->tfm_name,
> > -                       zpool_get_type(pool->zpool));
> > +                       zpool_get_type(pool->zpools[0]));
> >                 list_add(&pool->list, &zswap_pools);
> >                 zswap_has_pool =3D true;
> >         } else {
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
>
> In terms of correctness, the code LGTM.
> However, I do share Johannes' concern about this change.
>
> May I ask how sensitive is the system performance to the number of pools?
> i.e during the tuning process, did you see lots of performance
> variability as you vary the number of pools? Is 32 a number that
> works well across workloads, hardware, etc?

I did not tune this myself, it has been used in our fleet for many
years now, and honestly I am not sure what range of values was tried
out. For us, 32 is a number that works well across our entire fleet
(that uses zswap ofc).

>
> Personally, I prefer the per-CPU pool idea - or some way to automatically
> determine the number of pools that are more generic than this 32 value
> (what if we have new hardware with more CPUs? Would 32 still be valid,
> or do we have to change it?).

Ideally, we would have the number of zpools be a function of the
system specs, or even autotune based on the workload. However, I don't
think we have a clear idea about what this should look like. While a
constant value is suboptimal, we have multiple constants in MM that
seem to be working relatively well across different machines and
workloads (e.g. SWAP_CLUSTER_MAX) -- so it's not unheard of.

We have been using 32 zpools across different machines and workloads
for years now. I would be hesitant to throw away years of production
testing right away, without data to back that something else is
better. I would prefer to start with something that (at least in our
fleet) is proven to be good, and we can easily extend it later to
replace 32 with a more sophisticated formula or something that is
calculated at boot or even tuned by userspace. Having the support in
the code to have multiple zpools is valuable as-is imo.

>
> I'm experimenting with some other zswap changes - if I have
> extra cycles and resources I'll try to apply this patch and see how the
> numbers play out.

That would be amazing. Looking forward to any numbers you can dig :)

>
> I'll defer to Johannes and other reviewers for further comments.
