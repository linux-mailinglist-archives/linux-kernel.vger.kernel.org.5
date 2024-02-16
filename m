Return-Path: <linux-kernel+bounces-68462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F50857A84
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D16F1C21B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99735524C0;
	Fri, 16 Feb 2024 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhUMIeDo"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41533249F7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080115; cv=none; b=SXIuvarIeMIQGJcNvMCZ/uA11QHsX+AjFmNsVYKlZRimzN9/KtHNIqyKFfdg9k7TZgR4EVL1Pm0AE1prUIlVXc/W/koHnkYF16hJob3e7+7ejHyd5cdO5IoCk2w8LMjsHT/dHBDdt9lgLlV1Rzb3peMG2VNNC3yH5lF7XYJwN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080115; c=relaxed/simple;
	bh=JG7epGr1OLTAzJ3lroC2pStM0pw4uB/zq8g78Pdr2xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAh/T305QY6H7TwuufXIO2buiX8O53mXwHB5cFlIttH0jlDOI2LwJZ2f4/vPK2Q8XlfSDYgoKBpCQxTpM6Zt98EhD/koWptk7dI3d0JUbtccnzAMODrdgic4B8cOw+1Dicg83upIm04dcsq8PRgK4PDSkR2H4YiUQ16qdAKNw0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhUMIeDo; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bed9f5d35dso32511939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708080113; x=1708684913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83MFj85Jw6q6w+0p9hI3fU9QbFllJZZhmeN4SqwEUMA=;
        b=NhUMIeDoSANe03ig4s8bdUVhFGihMFdR8z8+MUrb9Kmqtk06R8cdV0atCm9nzKjJqr
         XGI6WObsnBXwpUTRPUdO8qRi7yMYjhXIovyTyXOlqxtyLku0dheM64Wbxkeg7UgJYqZI
         cW8S/vM7aVHBfRT8RYXjHQ9aSIj2O4kceDNXNSTq8CBCHd3PjBthuGG1mf7cX18SaLv5
         Ik+tvz8Ieq9IUCxU0GYmJF4eiZ3QgXBbwvSvVGfwXnn8myeH4OrI+9ipkuviZad/d6ut
         5UIQ0LBBPYp2ccWlXPF697BgMTuuyKgs5/+ACsPc5f3co1Qu22kudPJCMUXwWpg9Nqlg
         mqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708080113; x=1708684913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83MFj85Jw6q6w+0p9hI3fU9QbFllJZZhmeN4SqwEUMA=;
        b=O3ib9B3M2m9g8ahlqwyNXeM7Sh88DGrGn7Rv273nHozs+GoLJBjGb9ToRUpT0rB27s
         uEbRvPiV9SUO9LJMcMR2j/Qsy7m4lBnmdXNuXzzc3e5FtuoCxIOAX9012pFiwT8mqn/y
         wtiPglBIZ6dVpApCr1Z7GlG+3+0yqJVXWp9KtPd6CjlNieU9oV9dKaS4G6pHQUzWeUjG
         Y7Zw5/Z4cB1gfoohw5BZx/PDCUx9o1+0UD4R+7l+82TBytgufeJfCpOXK5AczNQLMjzM
         9VKD+6DN0YUZJyBU0OG/JlXJWequ2B6sv9GpucKdRS9uMwfmf/Ggd8vYRKEFo4KJ17GV
         B6yw==
X-Forwarded-Encrypted: i=1; AJvYcCWEZyiRviuAL2M2sBl1xR8Wt81OJvLVPa7SPYQbJnMUkiTtTA9+FayBsl9bv2sdAPPlFNsPuQ3GvbUg2KwdUy7x8gC8cGeS79ziN2+s
X-Gm-Message-State: AOJu0Yw1D4li3Gn2MtX1xe3r7GEg+3BZIK2IAUvKFHnuwB/7TiCsRok9
	hRkeOKlKu8DHZSFQXsHMCA5N5hPLhEKf0IAK3VV86g7XS/gX8IrNrTl2XymANEpoPOkbPGAigml
	SPeRgnCMeHcEJhEpR+Vmsr1TfFWQKrPRuCFgGjg==
X-Google-Smtp-Source: AGHT+IHohGyM7aqhsbOgrJGONi+DTcnydQ/SQ/7ZiCjHTxzt7rc6dyqTE2f0MbPjJAFGOYqpnap/L8iU4kZOMkST50k=
X-Received: by 2002:a6b:1547:0:b0:7c4:3218:c767 with SMTP id
 68-20020a6b1547000000b007c43218c767mr5045416iov.11.1708080113226; Fri, 16 Feb
 2024 02:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210-zswap-global-lru-v3-0-200495333595@bytedance.com> <20240210-zswap-global-lru-v3-2-200495333595@bytedance.com>
In-Reply-To: <20240210-zswap-global-lru-v3-2-200495333595@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 16 Feb 2024 02:41:41 -0800
Message-ID: <CAKEwX=Mfyr0G_doA0HUR4JAaRe95BDDCmjejckt0YyqP0CFvJA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm/zswap: change zswap_pool kref to percpu_ref
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 12:55=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> All zswap entries will take a reference of zswap_pool when
> zswap_store(), and drop it when free. Change it to use the
> percpu_ref is better for scalability performance.
>
> Although percpu_ref use a bit more memory which should be ok
> for our use case, since we almost have only one zswap_pool to
> be using. The performance gain is for zswap_store/load hotpath.
>
> Testing kernel build (32 threads) in tmpfs with memory.max=3D2GB.
> (zswap shrinker and writeback enabled with one 50GB swapfile,
> on a 128 CPUs x86-64 machine, below is the average of 5 runs)
>
>         mm-unstable  zswap-global-lru
> real    63.20        63.12
> user    1061.75      1062.95
> sys     268.74       264.44

Idea is straightforward + code looks solid to me FWIW, so:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index d275eb523fc4..961349162997 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -173,7 +173,7 @@ struct crypto_acomp_ctx {
>  struct zswap_pool {
>         struct zpool *zpools[ZSWAP_NR_ZPOOLS];
>         struct crypto_acomp_ctx __percpu *acomp_ctx;
> -       struct kref kref;
> +       struct percpu_ref ref;
>         struct list_head list;
>         struct work_struct release_work;
>         struct hlist_node node;
> @@ -305,6 +305,7 @@ static void zswap_update_total_size(void)
>  /*********************************
>  * pool functions
>  **********************************/
> +static void __zswap_pool_empty(struct percpu_ref *ref);
>
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor=
)
>  {
> @@ -358,13 +359,18 @@ static struct zswap_pool *zswap_pool_create(char *t=
ype, char *compressor)
>         /* being the current pool takes 1 ref; this func expects the
>          * caller to always add the new pool as the current pool
>          */
> -       kref_init(&pool->kref);
> +       ret =3D percpu_ref_init(&pool->ref, __zswap_pool_empty,
> +                             PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
> +       if (ret)
> +               goto ref_fail;
>         INIT_LIST_HEAD(&pool->list);
>
>         zswap_pool_debug("created", pool);
>
>         return pool;
>
> +ref_fail:
> +       cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->no=
de);
>  error:
>         if (pool->acomp_ctx)
>                 free_percpu(pool->acomp_ctx);
> @@ -437,8 +443,9 @@ static void __zswap_pool_release(struct work_struct *=
work)
>
>         synchronize_rcu();
>
> -       /* nobody should have been able to get a kref... */
> -       WARN_ON(kref_get_unless_zero(&pool->kref));
> +       /* nobody should have been able to get a ref... */
> +       WARN_ON(!percpu_ref_is_zero(&pool->ref));

Ah nice - this is actually even clearer :) For some reason I missed
it, my apologies.

> +       percpu_ref_exit(&pool->ref);
>
>         /* pool is now off zswap_pools list and has no references. */
>         zswap_pool_destroy(pool);
> @@ -446,11 +453,11 @@ static void __zswap_pool_release(struct work_struct=
 *work)
>
>  static struct zswap_pool *zswap_pool_current(void);
>
> -static void __zswap_pool_empty(struct kref *kref)
> +static void __zswap_pool_empty(struct percpu_ref *ref)
>  {
>         struct zswap_pool *pool;
>
> -       pool =3D container_of(kref, typeof(*pool), kref);
> +       pool =3D container_of(ref, typeof(*pool), ref);
>
>         spin_lock(&zswap_pools_lock);
>
> @@ -469,12 +476,12 @@ static int __must_check zswap_pool_get(struct zswap=
_pool *pool)
>         if (!pool)
>                 return 0;
>
> -       return kref_get_unless_zero(&pool->kref);
> +       return percpu_ref_tryget(&pool->ref);
>  }
>
>  static void zswap_pool_put(struct zswap_pool *pool)
>  {
> -       kref_put(&pool->kref, __zswap_pool_empty);
> +       percpu_ref_put(&pool->ref);
>  }
>
>  static struct zswap_pool *__zswap_pool_current(void)
> @@ -604,6 +611,17 @@ static int __zswap_param_set(const char *val, const =
struct kernel_param *kp,
>
>         if (!pool)
>                 pool =3D zswap_pool_create(type, compressor);
> +       else {
> +               /*
> +                * Restore the initial ref dropped by percpu_ref_kill()
> +                * when the pool was decommissioned and switch it again
> +                * to percpu mode.
> +                */
> +               percpu_ref_resurrect(&pool->ref);
> +
> +               /* Drop the ref from zswap_pool_find_get(). */
> +               zswap_pool_put(pool);
> +       }
>
>         if (pool)
>                 ret =3D param_set_charp(s, kp);
> @@ -642,7 +660,7 @@ static int __zswap_param_set(const char *val, const s=
truct kernel_param *kp,
>          * or the new pool we failed to add
>          */
>         if (put_pool)
> -               zswap_pool_put(put_pool);
> +               percpu_ref_kill(&put_pool->ref);
>
>         return ret;
>  }
>
> --
> b4 0.10.1

