Return-Path: <linux-kernel+bounces-45330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC659842E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4702868A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60381762F9;
	Tue, 30 Jan 2024 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW/ZGpHQ"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A269156CF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649749; cv=none; b=k9ntBo7RJFyxHlxg5jsu7joW7HymS8YAmCR8Y6LgLznj7/X74zAvo/gW+4UfYcLf3jG8x32kYZbbxR32ykszwbVgC496b6JKhwKtInBQbnEl37icFDac0zasp09lMkTaxNsvFnPJYpukAdGtvypEyHsfg6BdvLMTpCc61t5gnuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649749; c=relaxed/simple;
	bh=5/aqnRASMHzu9TYG/apjUr8200FkPfDFcXd5IDMqvEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6i4LWaOI1QDQhwb9LXMPBtweoHcXzMpXB9rEgL+DwHQIi+kCOhUuNrXgK6I3K8JdJUKR6Eevsaii3D0CyIvlQIdfQ2ILnZ3DNTh11tUo45kGW+nlVtehyKSrRsqTcXrzpIk7ZYvJUid1VdFOUhPQQx1GsJyY05xp9oGc5ovPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YW/ZGpHQ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7baa8da5692so235203039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649746; x=1707254546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WCoam+eWcuEo3rvQL9b9j86p0jN159SZg1uN1/zVRQ=;
        b=YW/ZGpHQ6wzTpzUm99Ds5hJvMWaH75KjzSTd6R21yWg/boUa72Dm6lmsy5urfiv1D8
         cqMnkEcTwJNutw9u71f6T3B8+tn6rXLzpTmRHNIkHCU+FcuJv7nJjJrXKvHHW9q9Uqom
         hO14B+Mh2NHF6gjfddrp/BGVuwzM+Rx36/dGm+X7puJJOp/1a3bmpTU8MtyCBr4ER7Ti
         YotAXA/zOqw+s94GnyBGWXhD8AIh03Lhcb9h7VSlaJYgwJGF2pTQa4sb2cIxHqggS1h0
         tLFTNb/kB6u+K5+b2bKoJ+1q3qpGReiCzrDTWgxP6lrE2l2licsLOo1RdH/TLMUYNAox
         VhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649746; x=1707254546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WCoam+eWcuEo3rvQL9b9j86p0jN159SZg1uN1/zVRQ=;
        b=bvgFHxl+QERxhQ7nc2OQn2W34PjRV1B/w7lGZdMrfoS9D0d/6M0pokArU0VcrxVOV1
         HWR8bK6EuicjOECA4LXvKbfILgyxZDObTRPBsUCuP0MD8PCahIRQs1Q1Ivj637CsCi38
         nseQS9na0i1MSr88CqIy2DNclQQ4/UkrHj8pcMEOnDpRfQAaEYBSNhunDuikn5ZDzPM7
         yXNwcU4OWN+Nw4TiE1fGyU4PxTyxcdVi8ZSuIjJ2eud6ndcnjM6Y6wi986IMr+D4XuWp
         FsZbhvIeGaNwp70F0CGM4lvjtBvFa4uUy6Vw+puHxjmW/P1e5Zm8myIseh4cBPxijnNm
         yW2Q==
X-Gm-Message-State: AOJu0YyQSUB8VsOM0HnPhPzsV5CmBWl+5oPq1yWWFbMBPYQ1ytMzdxCH
	nsVgBCHTG6C2/B5tf1PysGLYhdbIKUwirExwm2tvH8UbWSlYBcFuCdr9qRwunnGIwSC7pzfR8KM
	2rsd2Qv+U7dUXsNrNjdueg6mGedt0qxUCzCA=
X-Google-Smtp-Source: AGHT+IGaCHXAkFa1W4eaibpYaduTMMpLmPqt6/2jJrm0g1pWgqdTbuzDpemAXnJhHB9Uf+ylYwwQqCVnMiE2CqYJm90=
X-Received: by 2002:a5e:cb4a:0:b0:7c0:19bc:abbe with SMTP id
 h10-20020a5ecb4a000000b007c019bcabbemr957381iok.1.1706649746657; Tue, 30 Jan
 2024 13:22:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-14-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-14-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 13:22:15 -0800
Message-ID: <CAKEwX=NgCmqpxQOENfv+8CPzQLnwv=1A38GJROSXFdC3CEOPFw@mail.gmail.com>
Subject: Re: [PATCH 13/20] mm: zswap: function ordering: pool params
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> The parameters primarily control pool attributes. Move those
> operations up to the pool section.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 312 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 156 insertions(+), 156 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 168afd6767b3..e650fc587116 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -590,6 +590,162 @@ static struct zswap_pool *zswap_pool_find_get(char =
*type, char *compressor)
>         return NULL;
>  }
>
> +/*********************************
> +* param callbacks
> +**********************************/
> +
> +static bool zswap_pool_changed(const char *s, const struct kernel_param =
*kp)
> +{
> +       /* no change required */
> +       if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
> +               return false;
> +       return true;
> +}
> +
> +/* val must be a null-terminated string */
> +static int __zswap_param_set(const char *val, const struct kernel_param =
*kp,
> +                            char *type, char *compressor)
> +{
> +       struct zswap_pool *pool, *put_pool =3D NULL;
> +       char *s =3D strstrip((char *)val);
> +       int ret =3D 0;
> +       bool new_pool =3D false;
> +
> +       mutex_lock(&zswap_init_lock);
> +       switch (zswap_init_state) {
> +       case ZSWAP_UNINIT:
> +               /* if this is load-time (pre-init) param setting,
> +                * don't create a pool; that's done during init.
> +                */
> +               ret =3D param_set_charp(s, kp);
> +               break;
> +       case ZSWAP_INIT_SUCCEED:
> +               new_pool =3D zswap_pool_changed(s, kp);
> +               break;
> +       case ZSWAP_INIT_FAILED:
> +               pr_err("can't set param, initialization failed\n");
> +               ret =3D -ENODEV;
> +       }
> +       mutex_unlock(&zswap_init_lock);
> +
> +       /* no need to create a new pool, return directly */
> +       if (!new_pool)
> +               return ret;
> +
> +       if (!type) {
> +               if (!zpool_has_pool(s)) {
> +                       pr_err("zpool %s not available\n", s);
> +                       return -ENOENT;
> +               }
> +               type =3D s;
> +       } else if (!compressor) {
> +               if (!crypto_has_acomp(s, 0, 0)) {
> +                       pr_err("compressor %s not available\n", s);
> +                       return -ENOENT;
> +               }
> +               compressor =3D s;
> +       } else {
> +               WARN_ON(1);
> +               return -EINVAL;
> +       }
> +
> +       spin_lock(&zswap_pools_lock);
> +
> +       pool =3D zswap_pool_find_get(type, compressor);
> +       if (pool) {
> +               zswap_pool_debug("using existing", pool);
> +               WARN_ON(pool =3D=3D zswap_pool_current());
> +               list_del_rcu(&pool->list);
> +       }
> +
> +       spin_unlock(&zswap_pools_lock);
> +
> +       if (!pool)
> +               pool =3D zswap_pool_create(type, compressor);
> +
> +       if (pool)
> +               ret =3D param_set_charp(s, kp);
> +       else
> +               ret =3D -EINVAL;
> +
> +       spin_lock(&zswap_pools_lock);
> +
> +       if (!ret) {
> +               put_pool =3D zswap_pool_current();
> +               list_add_rcu(&pool->list, &zswap_pools);
> +               zswap_has_pool =3D true;
> +       } else if (pool) {
> +               /* add the possibly pre-existing pool to the end of the p=
ools
> +                * list; if it's new (and empty) then it'll be removed an=
d
> +                * destroyed by the put after we drop the lock
> +                */
> +               list_add_tail_rcu(&pool->list, &zswap_pools);
> +               put_pool =3D pool;
> +       }
> +
> +       spin_unlock(&zswap_pools_lock);
> +
> +       if (!zswap_has_pool && !pool) {
> +               /* if initial pool creation failed, and this pool creatio=
n also
> +                * failed, maybe both compressor and zpool params were ba=
d.
> +                * Allow changing this param, so pool creation will succe=
ed
> +                * when the other param is changed. We already verified t=
his
> +                * param is ok in the zpool_has_pool() or crypto_has_acom=
p()
> +                * checks above.
> +                */
> +               ret =3D param_set_charp(s, kp);
> +       }
> +
> +       /* drop the ref from either the old current pool,
> +        * or the new pool we failed to add
> +        */
> +       if (put_pool)
> +               zswap_pool_put(put_pool);
> +
> +       return ret;
> +}
> +
> +static int zswap_compressor_param_set(const char *val,
> +                                     const struct kernel_param *kp)
> +{
> +       return __zswap_param_set(val, kp, zswap_zpool_type, NULL);
> +}
> +
> +static int zswap_zpool_param_set(const char *val,
> +                                const struct kernel_param *kp)
> +{
> +       return __zswap_param_set(val, kp, NULL, zswap_compressor);
> +}
> +
> +static int zswap_enabled_param_set(const char *val,
> +                                  const struct kernel_param *kp)
> +{
> +       int ret =3D -ENODEV;
> +
> +       /* if this is load-time (pre-init) param setting, only set param.=
 */
> +       if (system_state !=3D SYSTEM_RUNNING)
> +               return param_set_bool(val, kp);
> +
> +       mutex_lock(&zswap_init_lock);
> +       switch (zswap_init_state) {
> +       case ZSWAP_UNINIT:
> +               if (zswap_setup())
> +                       break;
> +               fallthrough;
> +       case ZSWAP_INIT_SUCCEED:
> +               if (!zswap_has_pool)
> +                       pr_err("can't enable, no pool configured\n");
> +               else
> +                       ret =3D param_set_bool(val, kp);
> +               break;
> +       case ZSWAP_INIT_FAILED:
> +               pr_err("can't enable, initialization failed\n");
> +       }
> +       mutex_unlock(&zswap_init_lock);
> +
> +       return ret;
> +}
> +
>  /* should be called under RCU */
>  #ifdef CONFIG_MEMCG
>  static inline struct mem_cgroup *mem_cgroup_from_entry(struct zswap_entr=
y *entry)
> @@ -1163,162 +1319,6 @@ static void shrink_worker(struct work_struct *w)
>         zswap_pool_put(pool);
>  }
>
> -/*********************************
> -* param callbacks
> -**********************************/
> -
> -static bool zswap_pool_changed(const char *s, const struct kernel_param =
*kp)
> -{
> -       /* no change required */
> -       if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
> -               return false;
> -       return true;
> -}
> -
> -/* val must be a null-terminated string */
> -static int __zswap_param_set(const char *val, const struct kernel_param =
*kp,
> -                            char *type, char *compressor)
> -{
> -       struct zswap_pool *pool, *put_pool =3D NULL;
> -       char *s =3D strstrip((char *)val);
> -       int ret =3D 0;
> -       bool new_pool =3D false;
> -
> -       mutex_lock(&zswap_init_lock);
> -       switch (zswap_init_state) {
> -       case ZSWAP_UNINIT:
> -               /* if this is load-time (pre-init) param setting,
> -                * don't create a pool; that's done during init.
> -                */
> -               ret =3D param_set_charp(s, kp);
> -               break;
> -       case ZSWAP_INIT_SUCCEED:
> -               new_pool =3D zswap_pool_changed(s, kp);
> -               break;
> -       case ZSWAP_INIT_FAILED:
> -               pr_err("can't set param, initialization failed\n");
> -               ret =3D -ENODEV;
> -       }
> -       mutex_unlock(&zswap_init_lock);
> -
> -       /* no need to create a new pool, return directly */
> -       if (!new_pool)
> -               return ret;
> -
> -       if (!type) {
> -               if (!zpool_has_pool(s)) {
> -                       pr_err("zpool %s not available\n", s);
> -                       return -ENOENT;
> -               }
> -               type =3D s;
> -       } else if (!compressor) {
> -               if (!crypto_has_acomp(s, 0, 0)) {
> -                       pr_err("compressor %s not available\n", s);
> -                       return -ENOENT;
> -               }
> -               compressor =3D s;
> -       } else {
> -               WARN_ON(1);
> -               return -EINVAL;
> -       }
> -
> -       spin_lock(&zswap_pools_lock);
> -
> -       pool =3D zswap_pool_find_get(type, compressor);
> -       if (pool) {
> -               zswap_pool_debug("using existing", pool);
> -               WARN_ON(pool =3D=3D zswap_pool_current());
> -               list_del_rcu(&pool->list);
> -       }
> -
> -       spin_unlock(&zswap_pools_lock);
> -
> -       if (!pool)
> -               pool =3D zswap_pool_create(type, compressor);
> -
> -       if (pool)
> -               ret =3D param_set_charp(s, kp);
> -       else
> -               ret =3D -EINVAL;
> -
> -       spin_lock(&zswap_pools_lock);
> -
> -       if (!ret) {
> -               put_pool =3D zswap_pool_current();
> -               list_add_rcu(&pool->list, &zswap_pools);
> -               zswap_has_pool =3D true;
> -       } else if (pool) {
> -               /* add the possibly pre-existing pool to the end of the p=
ools
> -                * list; if it's new (and empty) then it'll be removed an=
d
> -                * destroyed by the put after we drop the lock
> -                */
> -               list_add_tail_rcu(&pool->list, &zswap_pools);
> -               put_pool =3D pool;
> -       }
> -
> -       spin_unlock(&zswap_pools_lock);
> -
> -       if (!zswap_has_pool && !pool) {
> -               /* if initial pool creation failed, and this pool creatio=
n also
> -                * failed, maybe both compressor and zpool params were ba=
d.
> -                * Allow changing this param, so pool creation will succe=
ed
> -                * when the other param is changed. We already verified t=
his
> -                * param is ok in the zpool_has_pool() or crypto_has_acom=
p()
> -                * checks above.
> -                */
> -               ret =3D param_set_charp(s, kp);
> -       }
> -
> -       /* drop the ref from either the old current pool,
> -        * or the new pool we failed to add
> -        */
> -       if (put_pool)
> -               zswap_pool_put(put_pool);
> -
> -       return ret;
> -}
> -
> -static int zswap_compressor_param_set(const char *val,
> -                                     const struct kernel_param *kp)
> -{
> -       return __zswap_param_set(val, kp, zswap_zpool_type, NULL);
> -}
> -
> -static int zswap_zpool_param_set(const char *val,
> -                                const struct kernel_param *kp)
> -{
> -       return __zswap_param_set(val, kp, NULL, zswap_compressor);
> -}
> -
> -static int zswap_enabled_param_set(const char *val,
> -                                  const struct kernel_param *kp)
> -{
> -       int ret =3D -ENODEV;
> -
> -       /* if this is load-time (pre-init) param setting, only set param.=
 */
> -       if (system_state !=3D SYSTEM_RUNNING)
> -               return param_set_bool(val, kp);
> -
> -       mutex_lock(&zswap_init_lock);
> -       switch (zswap_init_state) {
> -       case ZSWAP_UNINIT:
> -               if (zswap_setup())
> -                       break;
> -               fallthrough;
> -       case ZSWAP_INIT_SUCCEED:
> -               if (!zswap_has_pool)
> -                       pr_err("can't enable, no pool configured\n");
> -               else
> -                       ret =3D param_set_bool(val, kp);
> -               break;
> -       case ZSWAP_INIT_FAILED:
> -               pr_err("can't enable, initialization failed\n");
> -       }
> -       mutex_unlock(&zswap_init_lock);
> -
> -       return ret;
> -}
> -
>  static bool zswap_compress(struct folio *folio, struct zswap_entry *entr=
y)
>  {
>         struct crypto_acomp_ctx *acomp_ctx;
> --
> 2.43.0
>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

