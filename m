Return-Path: <linux-kernel+bounces-60960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6CA850B9D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E539283E8C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA05F479;
	Sun, 11 Feb 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dhk3tErm"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6741A84
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707686489; cv=none; b=BwIEtCVz+ZNjCryU1fOuC4dD1JBTfisl9UP+x6srxq92b8mG1/iZok7TszLdOLNUbS65r5Js6tYHmpjqbJ+Ox+s9cmx69u3Z05cGgCsCI2U8hehPM348t0as2lnvL81RhAa2z7/QhUQTUoCgagVt3po+MazNpwq5Bw0PT7tnWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707686489; c=relaxed/simple;
	bh=gHH3KFIuojHC0+xTtfSF9UEkz7o/XgwSl1wG1TF16F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkCDgXya2fVDf+IONOLVKtfQ60QNjoWLLFeCO2+y8W3JTlIZ0ejtPyqjgCAkcyZzgyHcAGRgTodzNXjmuMLGQDsf/Agmis2q1BXZsitEbHEx5KklCmuxbFkYb+eagqNx4lYe2vpnlDCizDmSyz3qakjfoigHHMNH7zIHYzVonuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dhk3tErm; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bc32b04dc9so102906439f.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707686487; x=1708291287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQUS//jNzgVNdo81DDUlsqnRmEF1KJ/9xq+TeiOeGoQ=;
        b=Dhk3tErmzQSPncQgAR0/13zpVBngQRPm2B7KJWh6AFO6UU6f5/bVnl/5dQS/EP0ueC
         YSS9oxVnEYXhix13nA8EYKKj8kBD0+QPZGYYtCheuooJmAYJBykUrUK/E2L9Cmyqs0m9
         E4McDH3EcBiblVTHLZgJHMsQpvgZ3+XQgie8l5admfH8FRZ5UtXfjESMFOTrqw7rDyfi
         d08v7ikm7wT/4DxJpVV3tI0WHeeFxE8xWgq2eaPX0BgYf0fjhTU+bFirrhaKy9fhxpJ0
         BP8bxod+VXsQSb9zutdiJDcA5Em3RP2NJ+2BkbhhShQAeklmUgg7CCwqQ66oeDFBgkp6
         rI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707686487; x=1708291287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQUS//jNzgVNdo81DDUlsqnRmEF1KJ/9xq+TeiOeGoQ=;
        b=fyvQM7EfItkD5Oeapn+no1KSiUXUGZURK59NPJC7sqas7LppLzaNMMGZhcGDZj7lTT
         ud30DlsjDBbetOOi1ZM3I4g3vI3r13vEKe1UKCLlSOQzKafqDAA4GbEvz/Af+Klz4H9K
         TIfU2X+ALKykTOBhsAaCvLMb8YodOxcOqyvipf2jKUYI3f7BV90NzNfJCnosQ7CfUKXv
         kNepBh6aDjaixkvNTRoHZ8iQ6CcFOiMMIvxhxrYQ0xALWLSfSgbgA10H/pZQxwIpGKqU
         C7jNC9MRDOgamKjbwqkJBOV0/PCAVBAt9MoN2tLaDnLWpwuMwbDFi5U0Fd3jFq2AHbTZ
         fBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8csmEy/Iqjr7Rcb3VqZ2J3dGwKg36prm5IqW/VG35HSdTbMpj3aUmhHpNsOc8knwLFDOQiEiQYyUmCyx8kPBDGqQGQZczjpF0whQ1
X-Gm-Message-State: AOJu0Yxjpwxv9+j2CFrsiYItWVWCxW0kwwO5kAhozSmEHjZCUKm7ha2Z
	4MzYAHzs43ICd1dKBR4Ug5swyi6Y/q99/UQ/c4zBraW2wTp3KuropWJV2j8Wo+lm7Xyndtr0/Ot
	O79XmCKvna6B0NhHJEc6xnBi83cqyAnS0LVmDng==
X-Google-Smtp-Source: AGHT+IEtO/VBcZaOfR4SFAmVXgxWcAixrZ9ZQ3VHLR/CaLimsilvIAh51ezi04vQ7iAabTcTPYI+c5WTYQ66/PSyLA4=
X-Received: by 2002:a05:6602:1811:b0:7c3:fc2b:9bad with SMTP id
 t17-20020a056602181100b007c3fc2b9badmr6797908ioh.20.1707686487334; Sun, 11
 Feb 2024 13:21:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com> <20240210-zswap-global-lru-v1-2-853473d7b0da@bytedance.com>
In-Reply-To: <20240210-zswap-global-lru-v1-2-853473d7b0da@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 11 Feb 2024 13:21:16 -0800
Message-ID: <CAKEwX=MCkhH2Qa2+dGErpo2e_27=HyyVeEDWVO=+O6D-7mRQ1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/zswap: change zswap_pool kref to percpu_ref
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 5:58=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> All zswap entries will take a reference of zswap_pool when
> zswap_store(), and drop it when free. Change it to use the
> percpu_ref is better for scalability performance.
>
> Testing kernel build in tmpfs with memory.max=3D2GB
> (zswap shrinker and writeback enabled with one 50GB swapfile).
>
>         mm-unstable  zswap-global-lru
> real    63.20        63.12
> user    1061.75      1062.95
> sys     268.74       264.44
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7668db8c10e3..afb31904fb08 100644
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
> @@ -303,6 +303,7 @@ static void zswap_update_total_size(void)
>  /*********************************
>  * pool functions
>  **********************************/
> +static void __zswap_pool_empty(struct percpu_ref *ref);
>
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor=
)
>  {
> @@ -356,13 +357,18 @@ static struct zswap_pool *zswap_pool_create(char *t=
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
> @@ -435,8 +441,8 @@ static void __zswap_pool_release(struct work_struct *=
work)
>
>         synchronize_rcu();
>
> -       /* nobody should have been able to get a kref... */
> -       WARN_ON(kref_get_unless_zero(&pool->kref));

Do we no longer care about this WARN? IIUC, this is to catch someone
still holding a reference to the pool at release time, which sounds
like a bug. I think we can simulate the similar behavior with:

WARN_ON(percpu_ref_tryget(&pool->ref))

no? percpu_ref_tryget() should fail when the refcnt goes back down to
0. Then we can do percpu_ref_exit() as well.

> +       /* nobody should have been able to get a ref... */
> +       percpu_ref_exit(&pool->ref);
>
>         /* pool is now off zswap_pools list and has no references. */
>         zswap_pool_destroy(pool);
> @@ -444,11 +450,11 @@ static void __zswap_pool_release(struct work_struct=
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
> @@ -467,12 +473,12 @@ static int __must_check zswap_pool_get(struct zswap=
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
> @@ -602,6 +608,12 @@ static int __zswap_param_set(const char *val, const =
struct kernel_param *kp,
>
>         if (!pool)
>                 pool =3D zswap_pool_create(type, compressor);
> +       else {
> +               /* Resurrect percpu_ref to percpu mode. */
> +               percpu_ref_resurrect(&pool->ref);
> +               /* Drop the ref from zswap_pool_find_get(). */
> +               zswap_pool_put(pool);
> +       }
>
>         if (pool)
>                 ret =3D param_set_charp(s, kp);
> @@ -640,7 +652,7 @@ static int __zswap_param_set(const char *val, const s=
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

The rest of the code looks solid to me FWIW. Number seems to indicate
this is a good idea as well.

