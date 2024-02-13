Return-Path: <linux-kernel+bounces-63543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC05853104
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4482328A35C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1643ADC;
	Tue, 13 Feb 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDEXEzVG"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9739FF0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829067; cv=none; b=pm+ikB+ucVXrHgDXUKM/+YtoCckYHfJnUUenWIqaZw0hHWZB8OvWVBPPIsUml7cUiHb5HyivE7xVOY9yuWtpTzVutEZ61rloPLcOhhGtD6cmljB+fiJ0IPOt1jHEvOu0cKTEdAkh7ZGF4eVDQ2XrcKAwEwY5//F1HxFLkdPD60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829067; c=relaxed/simple;
	bh=Ho1Qa1Jy8ZOgz+lsF+HOczsTKU1zq5l3pgHCZ0HnWV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q61xPbvnGaVdLh+32ij8fpx09CQ51231plu3PzJk6ukMihFkUwQjgqyQt0x2wkP+WTNwxpwdEgmFtQ6WzfXw4MSPEdhso5uMu/NFZJJreQWLsq8KNGnIqacTvOZ+ONdJXGEc7IykWf7kgCMNGL+uCDglS8dRm4WOD6oJ9Sbdnpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDEXEzVG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso465525276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707829064; x=1708433864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Umi4A1gRJfLDzJlbzZAb6wHjrA4iMhaSTJrxE4a8GCU=;
        b=nDEXEzVG2Ne+OwtGylcp16O3Qb0hJawaEPQvD3ERepDtGZnaubEs++n1uG4INlTERi
         FSgl6njEbxrqQS0IUBeBJRTpiaRNG/HPgioUtNMsZRVJz+BMYe++QOOOshVqska7NPee
         TYJGidz99IEWY6tHHDV+yqltCPsk/vGj/mh7OJZxOtXlgKWGwkmgSG6C1MHklQkNmCd+
         bQHe+mb0Ffq4oUqDfF+I9PqdLsbGRIdAg+W/RLsmnRAjwt1QRanyCUyKUWAChpKcUpta
         kl5xj2xQKTfAYw9QK7UTOaMj84rXT3L4vG5RSSdNMOr0Lz+FDYuxGCE5CKN/Gutv3/r3
         7AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707829064; x=1708433864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Umi4A1gRJfLDzJlbzZAb6wHjrA4iMhaSTJrxE4a8GCU=;
        b=iEX99hojcCCwLYE4YMyZ99CwOXau06KlSSCSIq0MGjd1f2er8QpuNXFrWDB51k9MTk
         cH43y43XHGGcll5iwu4fqNN3OUJ8G+s53m3TWGrQIX6+8hBnvVDNnKbbH8jvkTfinyDY
         W36eCBBScTKt5bi0sc0wUKQlYFuC74Dt0djsd84Zwun+nqyb5SF41h+EwdSSqMvWOpRv
         OJ7V+WNSWTIBDXom66O9SrM+ANTI7u/6QyxP8+Wretat1v/xtTx+od2Kve/qY3Eu7m0V
         pIIB2gpbTUspcH5oDN50800oCwJHZLv2wlEkH5aI7LjpndftGVjrHkgjl34P6TVUtdy6
         tVaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSvueHc5t+h83s80Me+H2OF8/HTryehOAhYpvdIUF3x8mOGHIETMoxJDAWD+tb9clXMTvKAypqqmD2Bq9X1ClqWksNi/qP//91GBru
X-Gm-Message-State: AOJu0Yx4t/COVKbtdxes/ejIe4zQmmF/hRlXhoah0hFav8FUJxg5Y9ro
	y+6ZxSPsmwt5tCTP/4QFktZ3Ip0XVmXvZ3V6uXpjcfvhnXJHHL3RW8Er6tCsZZGjBeiky5IFAN6
	2HwYxyNLd7AELBET95A==
X-Google-Smtp-Source: AGHT+IFMfKkTkzGgWixRu1kUKYdF5213MuinjX0UAfDLUTqb0In8qLrCEBA7jEhX6iMEAmRyWv8ldqsacZuywuXq
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1106:b0:dc7:9218:df47 with
 SMTP id o6-20020a056902110600b00dc79218df47mr1645904ybu.5.1707829064544; Tue,
 13 Feb 2024 04:57:44 -0800 (PST)
Date: Tue, 13 Feb 2024 12:57:42 +0000
In-Reply-To: <20240210-zswap-global-lru-v1-1-853473d7b0da@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com> <20240210-zswap-global-lru-v1-1-853473d7b0da@bytedance.com>
Message-ID: <ZctnRnNMOwQNn_3j@google.com>
Subject: Re: [PATCH 1/2] mm/zswap: global lru and shrinker shared by all zswap_pools
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, Feb 11, 2024 at 01:57:04PM +0000, Chengming Zhou wrote:
> Dynamic zswap_pool creation may create/reuse to have multiple
> zswap_pools in a list, only the first will be current used.
> 
> Each zswap_pool has its own lru and shrinker, which is not
> necessary and has its problem:
> 
> 1. When memory has pressure, all shrinker of zswap_pools will
>    try to shrink its own lru, there is no order between them.
> 
> 2. When zswap limit hit, only the last zswap_pool's shrink_work
>    will try to shrink its lru, which is inefficient.
> 
> Anyway, having a global lru and shrinker shared by all zswap_pools
> is better and efficient.

It is also a great simplification.

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 153 ++++++++++++++++++++++---------------------------------------
>  1 file changed, 55 insertions(+), 98 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 62fe307521c9..7668db8c10e3 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -176,14 +176,17 @@ struct zswap_pool {
>  	struct kref kref;
>  	struct list_head list;
>  	struct work_struct release_work;
> -	struct work_struct shrink_work;
>  	struct hlist_node node;
>  	char tfm_name[CRYPTO_MAX_ALG_NAME];
> +};
> +
> +struct {

static?

>  	struct list_lru list_lru;
> -	struct mem_cgroup *next_shrink;
> -	struct shrinker *shrinker;

Just curious, any reason to change the relative ordering of members
here? It produces a couple more lines of diff :)

>  	atomic_t nr_stored;
> -};
> +	struct shrinker *shrinker;
> +	struct work_struct shrink_work;
> +	struct mem_cgroup *next_shrink;
> +} zswap;
>  
>  /*
>   * struct zswap_entry
> @@ -301,9 +304,6 @@ static void zswap_update_total_size(void)
>  * pool functions
>  **********************************/
>  
> -static void zswap_alloc_shrinker(struct zswap_pool *pool);
> -static void shrink_worker(struct work_struct *w);
> -
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>  {
>  	int i;
> @@ -353,30 +353,16 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>  	if (ret)
>  		goto error;
>  
> -	zswap_alloc_shrinker(pool);
> -	if (!pool->shrinker)
> -		goto error;
> -
> -	pr_debug("using %s compressor\n", pool->tfm_name);
> -

Why are we removing this debug print?

>  	/* being the current pool takes 1 ref; this func expects the
>  	 * caller to always add the new pool as the current pool
>  	 */
>  	kref_init(&pool->kref);
>  	INIT_LIST_HEAD(&pool->list);
> -	if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
> -		goto lru_fail;
> -	shrinker_register(pool->shrinker);
> -	INIT_WORK(&pool->shrink_work, shrink_worker);
> -	atomic_set(&pool->nr_stored, 0);
>  
>  	zswap_pool_debug("created", pool);
>  
>  	return pool;
>  
> -lru_fail:
> -	list_lru_destroy(&pool->list_lru);
> -	shrinker_free(pool->shrinker);
>  error:
>  	if (pool->acomp_ctx)
>  		free_percpu(pool->acomp_ctx);
[..]
> @@ -816,14 +777,10 @@ void zswap_folio_swapin(struct folio *folio)
>  
>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
>  {
> -	struct zswap_pool *pool;
> -
> -	/* lock out zswap pools list modification */
> +	/* lock out zswap shrinker walking memcg tree */
>  	spin_lock(&zswap_pools_lock);
> -	list_for_each_entry(pool, &zswap_pools, list) {
> -		if (pool->next_shrink == memcg)
> -			pool->next_shrink = mem_cgroup_iter(NULL, pool->next_shrink, NULL);
> -	}
> +	if (zswap.next_shrink == memcg)
> +		zswap.next_shrink = mem_cgroup_iter(NULL, zswap.next_shrink, NULL);

Now that next_shrink has nothing to do with zswap pools, it feels weird
that we are using zswap_pools_lock for its synchronization. Does it make
sense to have a separate lock for it just for semantic purposes?

>  	spin_unlock(&zswap_pools_lock);
>  }
>  
[..]
> @@ -1328,7 +1284,6 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
>  static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
>  		struct shrink_control *sc)
>  {
> -	struct zswap_pool *pool = shrinker->private_data;
>  	struct mem_cgroup *memcg = sc->memcg;
>  	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
>  	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
> @@ -1343,7 +1298,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
>  #else
>  	/* use pool stats instead of memcg stats */
>  	nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;

"pool" is still being used here.

> -	nr_stored = atomic_read(&pool->nr_stored);
> +	nr_stored = atomic_read(&zswap.nr_stored);
>  #endif
>  
>  	if (!nr_stored)
[..]  
> @@ -1804,6 +1749,21 @@ static int zswap_setup(void)
>  	if (ret)
>  		goto hp_fail;
>  
> +	shrink_wq = alloc_workqueue("zswap-shrink",
> +			WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
> +	if (!shrink_wq)
> +		goto hp_fail;

I think we need a new label here to call cpuhp_remove_multi_state(), but
apparently this is missing from the current code for some reason.

> +
> +	zswap.shrinker = zswap_alloc_shrinker();
> +	if (!zswap.shrinker)
> +		goto shrinker_fail;
> +	if (list_lru_init_memcg(&zswap.list_lru, zswap.shrinker))
> +		goto lru_fail;
> +	shrinker_register(zswap.shrinker);
> +
> +	INIT_WORK(&zswap.shrink_work, shrink_worker);
> +	atomic_set(&zswap.nr_stored, 0);
> +
>  	pool = __zswap_pool_create_fallback();
>  	if (pool) {
>  		pr_info("loaded using pool %s/%s\n", pool->tfm_name,
> @@ -1815,19 +1775,16 @@ static int zswap_setup(void)
>  		zswap_enabled = false;
>  	}
>  
> -	shrink_wq = alloc_workqueue("zswap-shrink",
> -			WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
> -	if (!shrink_wq)
> -		goto fallback_fail;
> -
>  	if (zswap_debugfs_init())
>  		pr_warn("debugfs initialization failed\n");
>  	zswap_init_state = ZSWAP_INIT_SUCCEED;
>  	return 0;
>  
> -fallback_fail:
> -	if (pool)
> -		zswap_pool_destroy(pool);
> +lru_fail:
> +	list_lru_destroy(&zswap.list_lru);

Do we need to call list_lru_destroy() here? I know it is currently being
called if list_lru_init_memcg() fails, but I fail to understand why. It
seems like list_lru_destroy() will do nothing anyway.

> +	shrinker_free(zswap.shrinker);
> +shrinker_fail:
> +	destroy_workqueue(shrink_wq);
>  hp_fail:
>  	kmem_cache_destroy(zswap_entry_cache);
>  cache_fail:
> 
> -- 
> b4 0.10.1

