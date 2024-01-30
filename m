Return-Path: <linux-kernel+bounces-45196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42477842CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CC71C244C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8597B3E9;
	Tue, 30 Jan 2024 19:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXSmQIxQ"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68C6995A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643095; cv=none; b=p7T9lfNecfugTcVm7kaitVtJZjCCysr28Cvc83Nr5XLgN9m2+aIH/FR8ur2BVrfPEYK7ZSy10KVN0t5+qQbROWqlyJ/FB31qM9Kn2rBwzB+o+s48s4Xe0w7Xkvs67UJ1YDXza/IX0Ss3nyJTHWlRxCIbpW0N7XgYV3e8KGJg3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643095; c=relaxed/simple;
	bh=9U8O+jQDV8u7vZtAiNhThu2DC9iEoF6T97QyiTcNTsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCWBAhvc08HNHB2DaqXsRZATNTDA2d7mE7hW7nDlCAgvnuJjtXxZ5XgU7uA68V7yuqICsGYCPWj6A23hxQOloueRlQ2AsUQlY0Jm6N2+wZrPjBZpBl8tL1e1UpdYcn300fow0P/zjIq8sgTmP5+r/5sJGOzeHxcY1be7PA6Bz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXSmQIxQ; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bfea28a1c9so126912339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706643093; x=1707247893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D50SSku97tf5n93HHsiV6xceSQjdNFhxdRrIRZRwebs=;
        b=XXSmQIxQYl2LnyTbE+qDNf/x0i+OWppqaQAb5fL33VlTShLGqKtIAo/mbh59ELxEfV
         SJANF9Xo2TrIa8duKFT3+Artb+579yuyCMglViWk6LLdN1t39oYL8G04Q4UlioRRISol
         lkRdmHlDstx7FcHo9UfBkH70WdNJl+TNQD802W4oU1AKZqgKOkm56rAtWHTtqFOquuar
         GYKoHduLtteEdtUHVoLvCp1utCifUHCH/p2whZnFU1eMt3UKyFZOkdYmk/USTOZAWLWE
         vVw9uo5N0nC+wLNFxG0nbO6hEksWY4+kLvdEdcvKeOjKlkpEz5dBypRU3I+NoQBp22Vi
         Aszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706643093; x=1707247893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D50SSku97tf5n93HHsiV6xceSQjdNFhxdRrIRZRwebs=;
        b=H0vY1EJoLUv3A5KvxXUSLW9EcO+Glrar2akE0Np408DkuUPcjOVl2MSHzQIwr8iTih
         7xeBLZM5HIhfaytw3y319elop9cMb6uPh8i8YlBckWFRiGRglDfiHUZD5MsE7mSkOSE8
         VyajlAF6Pmk5d9gtXgSL+33Zv4EwM5PKN+Ywc6rDAOKl4JqjEPMFq9uEeD/jixopuigl
         SiIeIW2SXOVWEItMzR8zQpySWRfL4k0UVDJNkqn2vAsJk9XYXIPfH8C2+fL6UEoXMa+z
         aG29i2U/J+b8f2Q4ABVDEoR5o72ENMxhLnZvgAtEfxkE3010ylwaz3LWO9wtbvRdY+PU
         gZYA==
X-Gm-Message-State: AOJu0YyQUTusLJELRsvP/ZaCfdcmcq+wl0hPq1jXMP4jodFfXj1/n4ya
	CT5gSZhAvRDkASpyIz9iHTZ7GDWxtV2DRnTyVBeyQxwTR85ATj03hnK0mSPn8rr6Vkg3RfA7kbc
	ux0ByHAemxTO+qzI4znd7bJ4T7sw=
X-Google-Smtp-Source: AGHT+IExsM+ZDwGpzF8Ws1I9D4t0WGkPNxR8AGQoBrfwSyCiA5HeYumW+bgx6GrNhKHsMa5RYqnDETFEdUSlRxvyVxM=
X-Received: by 2002:a92:c711:0:b0:363:7985:eee3 with SMTP id
 a17-20020a92c711000000b003637985eee3mr8118404ilp.24.1706643092652; Tue, 30
 Jan 2024 11:31:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-11-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-11-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 11:31:21 -0800
Message-ID: <CAKEwX=PWecyh4AZMUbJWMLQsxx4MTp23LuB7mOCm09DJa6W-yQ@mail.gmail.com>
Subject: Re: [PATCH 10/20] mm: zswap: function ordering: pool alloc & free
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> The function ordering in zswap.c is a little chaotic, which requires
> jumping in unexpected directions when following related code. This is
> a series of patches that brings the file into the following order:
>
> - pool functions
> - lru functions
> - rbtree functions
> - zswap entry functions
> - compression/backend functions
> - writeback & shrinking functions
> - store, load, invalidate, swapon, swapoff
> - debugfs
> - init

This ordering seems reasonable to me. Then again, we don't have any
coherent ordering of functions, so anything would be an improvement :)


>
> But it has to be split up such the moving still produces halfway
> readable diffs.
>
> In this patch, move pool allocation and freeing functions.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  mm/zswap.c | 297 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 152 insertions(+), 145 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 082d076a758d..805d9a35f633 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -320,6 +320,158 @@ static void zswap_update_total_size(void)
>         zswap_pool_total_size =3D total;
>  }
>
> +/*********************************
> +* pool functions
> +**********************************/
> +
> +static void zswap_alloc_shrinker(struct zswap_pool *pool);
> +static void shrink_worker(struct work_struct *w);
> +
> +static struct zswap_pool *zswap_pool_create(char *type, char *compressor=
)
> +{
> +       int i;
> +       struct zswap_pool *pool;
> +       char name[38]; /* 'zswap' + 32 char (max) num + \0 */
> +       gfp_t gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM=
;
> +       int ret;
> +
> +       if (!zswap_has_pool) {
> +               /* if either are unset, pool initialization failed, and w=
e
> +                * need both params to be set correctly before trying to
> +                * create a pool.
> +                */
> +               if (!strcmp(type, ZSWAP_PARAM_UNSET))
> +                       return NULL;
> +               if (!strcmp(compressor, ZSWAP_PARAM_UNSET))
> +                       return NULL;
> +       }
> +
> +       pool =3D kzalloc(sizeof(*pool), GFP_KERNEL);
> +       if (!pool)
> +               return NULL;
> +
> +       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++) {
> +               /* unique name for each pool specifically required by zsm=
alloc */
> +               snprintf(name, 38, "zswap%x",
> +                        atomic_inc_return(&zswap_pools_count));
> +
> +               pool->zpools[i] =3D zpool_create_pool(type, name, gfp);
> +               if (!pool->zpools[i]) {
> +                       pr_err("%s zpool not available\n", type);
> +                       goto error;
> +               }
> +       }
> +       pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
> +
> +       strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
> +
> +       pool->acomp_ctx =3D alloc_percpu(*pool->acomp_ctx);
> +       if (!pool->acomp_ctx) {
> +               pr_err("percpu alloc failed\n");
> +               goto error;
> +       }
> +
> +       ret =3D cpuhp_state_add_instance(CPUHP_MM_ZSWP_POOL_PREPARE,
> +                                      &pool->node);
> +       if (ret)
> +               goto error;
> +
> +       zswap_alloc_shrinker(pool);
> +       if (!pool->shrinker)
> +               goto error;
> +
> +       pr_debug("using %s compressor\n", pool->tfm_name);
> +
> +       /* being the current pool takes 1 ref; this func expects the
> +        * caller to always add the new pool as the current pool
> +        */
> +       kref_init(&pool->kref);
> +       INIT_LIST_HEAD(&pool->list);
> +       if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
> +               goto lru_fail;
> +       shrinker_register(pool->shrinker);
> +       INIT_WORK(&pool->shrink_work, shrink_worker);
> +       atomic_set(&pool->nr_stored, 0);
> +
> +       zswap_pool_debug("created", pool);
> +
> +       return pool;
> +
> +lru_fail:
> +       list_lru_destroy(&pool->list_lru);
> +       shrinker_free(pool->shrinker);
> +error:
> +       if (pool->acomp_ctx)
> +               free_percpu(pool->acomp_ctx);
> +       while (i--)
> +               zpool_destroy_pool(pool->zpools[i]);
> +       kfree(pool);
> +       return NULL;
> +}
> +
> +static struct zswap_pool *__zswap_pool_create_fallback(void)
> +{
> +       bool has_comp, has_zpool;
> +
> +       has_comp =3D crypto_has_acomp(zswap_compressor, 0, 0);
> +       if (!has_comp && strcmp(zswap_compressor,
> +                               CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
> +               pr_err("compressor %s not available, using default %s\n",
> +                      zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT)=
;
> +               param_free_charp(&zswap_compressor);
> +               zswap_compressor =3D CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
> +               has_comp =3D crypto_has_acomp(zswap_compressor, 0, 0);
> +       }
> +       if (!has_comp) {
> +               pr_err("default compressor %s not available\n",
> +                      zswap_compressor);
> +               param_free_charp(&zswap_compressor);
> +               zswap_compressor =3D ZSWAP_PARAM_UNSET;
> +       }
> +
> +       has_zpool =3D zpool_has_pool(zswap_zpool_type);
> +       if (!has_zpool && strcmp(zswap_zpool_type,
> +                                CONFIG_ZSWAP_ZPOOL_DEFAULT)) {
> +               pr_err("zpool %s not available, using default %s\n",
> +                      zswap_zpool_type, CONFIG_ZSWAP_ZPOOL_DEFAULT);
> +               param_free_charp(&zswap_zpool_type);
> +               zswap_zpool_type =3D CONFIG_ZSWAP_ZPOOL_DEFAULT;
> +               has_zpool =3D zpool_has_pool(zswap_zpool_type);
> +       }
> +       if (!has_zpool) {
> +               pr_err("default zpool %s not available\n",
> +                      zswap_zpool_type);
> +               param_free_charp(&zswap_zpool_type);
> +               zswap_zpool_type =3D ZSWAP_PARAM_UNSET;
> +       }
> +
> +       if (!has_comp || !has_zpool)
> +               return NULL;
> +
> +       return zswap_pool_create(zswap_zpool_type, zswap_compressor);
> +}
> +
> +static void zswap_pool_destroy(struct zswap_pool *pool)
> +{
> +       int i;
> +
> +       zswap_pool_debug("destroying", pool);
> +
> +       shrinker_free(pool->shrinker);
> +       cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->no=
de);
> +       free_percpu(pool->acomp_ctx);
> +       list_lru_destroy(&pool->list_lru);
> +
> +       spin_lock(&zswap_pools_lock);
> +       mem_cgroup_iter_break(NULL, pool->next_shrink);
> +       pool->next_shrink =3D NULL;
> +       spin_unlock(&zswap_pools_lock);
> +
> +       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> +               zpool_destroy_pool(pool->zpools[i]);
> +       kfree(pool);
> +}
> +
>  /* should be called under RCU */
>  #ifdef CONFIG_MEMCG
>  static inline struct mem_cgroup *mem_cgroup_from_entry(struct zswap_entr=
y *entry)
> @@ -970,151 +1122,6 @@ static void shrink_worker(struct work_struct *w)
>         zswap_pool_put(pool);
>  }
>
> -static struct zswap_pool *zswap_pool_create(char *type, char *compressor=
)
> -{
> -       int i;
> -       struct zswap_pool *pool;
> -       char name[38]; /* 'zswap' + 32 char (max) num + \0 */
> -       gfp_t gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM=
;
> -       int ret;
> -
> -       if (!zswap_has_pool) {
> -               /* if either are unset, pool initialization failed, and w=
e
> -                * need both params to be set correctly before trying to
> -                * create a pool.
> -                */
> -               if (!strcmp(type, ZSWAP_PARAM_UNSET))
> -                       return NULL;
> -               if (!strcmp(compressor, ZSWAP_PARAM_UNSET))
> -                       return NULL;
> -       }
> -
> -       pool =3D kzalloc(sizeof(*pool), GFP_KERNEL);
> -       if (!pool)
> -               return NULL;
> -
> -       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++) {
> -               /* unique name for each pool specifically required by zsm=
alloc */
> -               snprintf(name, 38, "zswap%x",
> -                        atomic_inc_return(&zswap_pools_count));
> -
> -               pool->zpools[i] =3D zpool_create_pool(type, name, gfp);
> -               if (!pool->zpools[i]) {
> -                       pr_err("%s zpool not available\n", type);
> -                       goto error;
> -               }
> -       }
> -       pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
> -
> -       strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
> -
> -       pool->acomp_ctx =3D alloc_percpu(*pool->acomp_ctx);
> -       if (!pool->acomp_ctx) {
> -               pr_err("percpu alloc failed\n");
> -               goto error;
> -       }
> -
> -       ret =3D cpuhp_state_add_instance(CPUHP_MM_ZSWP_POOL_PREPARE,
> -                                      &pool->node);
> -       if (ret)
> -               goto error;
> -
> -       zswap_alloc_shrinker(pool);
> -       if (!pool->shrinker)
> -               goto error;
> -
> -       pr_debug("using %s compressor\n", pool->tfm_name);
> -
> -       /* being the current pool takes 1 ref; this func expects the
> -        * caller to always add the new pool as the current pool
> -        */
> -       kref_init(&pool->kref);
> -       INIT_LIST_HEAD(&pool->list);
> -       if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
> -               goto lru_fail;
> -       shrinker_register(pool->shrinker);
> -       INIT_WORK(&pool->shrink_work, shrink_worker);
> -       atomic_set(&pool->nr_stored, 0);
> -
> -       zswap_pool_debug("created", pool);
> -
> -       return pool;
> -
> -lru_fail:
> -       list_lru_destroy(&pool->list_lru);
> -       shrinker_free(pool->shrinker);
> -error:
> -       if (pool->acomp_ctx)
> -               free_percpu(pool->acomp_ctx);
> -       while (i--)
> -               zpool_destroy_pool(pool->zpools[i]);
> -       kfree(pool);
> -       return NULL;
> -}
> -
> -static struct zswap_pool *__zswap_pool_create_fallback(void)
> -{
> -       bool has_comp, has_zpool;
> -
> -       has_comp =3D crypto_has_acomp(zswap_compressor, 0, 0);
> -       if (!has_comp && strcmp(zswap_compressor,
> -                               CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
> -               pr_err("compressor %s not available, using default %s\n",
> -                      zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT)=
;
> -               param_free_charp(&zswap_compressor);
> -               zswap_compressor =3D CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
> -               has_comp =3D crypto_has_acomp(zswap_compressor, 0, 0);
> -       }
> -       if (!has_comp) {
> -               pr_err("default compressor %s not available\n",
> -                      zswap_compressor);
> -               param_free_charp(&zswap_compressor);
> -               zswap_compressor =3D ZSWAP_PARAM_UNSET;
> -       }
> -
> -       has_zpool =3D zpool_has_pool(zswap_zpool_type);
> -       if (!has_zpool && strcmp(zswap_zpool_type,
> -                                CONFIG_ZSWAP_ZPOOL_DEFAULT)) {
> -               pr_err("zpool %s not available, using default %s\n",
> -                      zswap_zpool_type, CONFIG_ZSWAP_ZPOOL_DEFAULT);
> -               param_free_charp(&zswap_zpool_type);
> -               zswap_zpool_type =3D CONFIG_ZSWAP_ZPOOL_DEFAULT;
> -               has_zpool =3D zpool_has_pool(zswap_zpool_type);
> -       }
> -       if (!has_zpool) {
> -               pr_err("default zpool %s not available\n",
> -                      zswap_zpool_type);
> -               param_free_charp(&zswap_zpool_type);
> -               zswap_zpool_type =3D ZSWAP_PARAM_UNSET;
> -       }
> -
> -       if (!has_comp || !has_zpool)
> -               return NULL;
> -
> -       return zswap_pool_create(zswap_zpool_type, zswap_compressor);
> -}
> -
> -static void zswap_pool_destroy(struct zswap_pool *pool)
> -{
> -       int i;
> -
> -       zswap_pool_debug("destroying", pool);
> -
> -       shrinker_free(pool->shrinker);
> -       cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->no=
de);
> -       free_percpu(pool->acomp_ctx);
> -       list_lru_destroy(&pool->list_lru);
> -
> -       spin_lock(&zswap_pools_lock);
> -       mem_cgroup_iter_break(NULL, pool->next_shrink);
> -       pool->next_shrink =3D NULL;
> -       spin_unlock(&zswap_pools_lock);
> -
> -       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> -               zpool_destroy_pool(pool->zpools[i]);
> -       kfree(pool);
> -}
> -
>  static int __must_check zswap_pool_get(struct zswap_pool *pool)
>  {
>         if (!pool)
> --
> 2.43.0
>

