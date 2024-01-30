Return-Path: <linux-kernel+bounces-45247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B318842D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B79B233B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A3071B4C;
	Tue, 30 Jan 2024 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ59O48E"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDAB71B44
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645624; cv=none; b=pCtmfA/rlyxAOAX4rc2pmbTF/5BzoB0dZn6xvpCTAzKfFVtuHwbcvjv1UFNdoeKLnFoeTNoQC5qHVfe9/2twq1MQwXnS/tj32snyl8+Dy4uONVYZyZiV1ojWisOQKGHjexmVkJWbC7W7n9DMb1xAHllKH/BAWbXMGVbjNx6sFVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645624; c=relaxed/simple;
	bh=toM/VtCPpkQmWhjulrQ4Gj029AN9H7cV7ZWGQAWuRE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URV2TtrGGjr6r6kEJ3cNgW/ixVtRbqP5chhK/j85X+C2CIRKNlkdKeu4unj+Bs/fiwrr6V4ugckeP1hqN1cvlsP5etAqTd7YBJhL9zW4pHqfCc/QJ1EIQWLi28oEivH+51fIb8zzahmoCKdknXQFuTFF97X2htlBenGLfo4PfVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ59O48E; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3638d572811so4400465ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706645621; x=1707250421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=murDIWEfCo9QZrXW4m/LQRV4x+SlYtEqXTSBad8rO5w=;
        b=jZ59O48E4C0YOdSerVSZ3OUBoPFn7lOvuNkUPl883PsQr9bgTN2Yk1eG863qWDn6pP
         4ofT5dprXkiIUehWO6LcXfwc5nMQJVCDrpUqh4Yinalx0IE7ZREEqzYisaEUi03KjpaJ
         Invsqq1pLipNInBDVl0Re7jh0FXSmFUa9C3fo3tUdm+76LI7NmSc8f1B0isJ8tsTzL6f
         H6QgNRKh//lxGCln7HEKAwxDLhhvC0keb0w9ozz/NCTcp6PXeIrarWoqC4H0mA+U/UnC
         mSIkHTIBUTcQkuRLiDnNAU9t3WHNUpM5IUQhAUogf9YZOjEAMAXmABDJMOa3GTssVAMX
         d4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706645621; x=1707250421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=murDIWEfCo9QZrXW4m/LQRV4x+SlYtEqXTSBad8rO5w=;
        b=eB0A1TVBR560kY+a33lmQFqHWtxSVwnBGipXRNlbQdvA4vmIQC5tUcamfriLbO68Xe
         9i/fxioQzJZWV9n/fLFEczTOZiRJI6ik2bgb0vw3uf3OroGp3FXvU3WaYWw42i+FqraV
         0njzjoqAS4RHjKJ/+YCoEPGND3V56S6TORlzMnQ2aGAPW0M6bKPzIdhaYdQaPQpwE4gy
         TLL3B87Bc6m0P17p2aMPi7DxxSqFHfUaaG9prbEgiXz3zWo80RG4b64Mjm/WtlwGI+pg
         QH0h8D6+PY22gJiacEj+0FVqCgnvOufgoJBKQR8kDaZfsAlfBwu/Dzij5dl14p7+FpOA
         by2Q==
X-Gm-Message-State: AOJu0Yz0bmyWqI1mnxTNNwRhgZMuspWpm+pA3PlgkXTasz7vwlX7RkM1
	a0mLHZpCHG/x+oSUVwrG/TFxs8O194XIqsCV5jmMEKM6kXSdmJq35s14kmUOkpNhnxSh+myB1fO
	/iXRV3QZ5efU7yiAmeXbEyeFd3N8=
X-Google-Smtp-Source: AGHT+IF+1pNKvoyrCfmz2jzRqvEDj0SFxKd3dTixSNzUx3YTLsSFIVYKknwsA4bXHwqHWByXlew0hlnnQJnamdvX4dc=
X-Received: by 2002:a92:ce4b:0:b0:363:8263:6a9a with SMTP id
 a11-20020a92ce4b000000b0036382636a9amr5278441ilr.12.1706645621443; Tue, 30
 Jan 2024 12:13:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-12-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-12-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 12:13:30 -0800
Message-ID: <CAKEwX=PN3vFZO1VkFVoRJGOnwgRdfuyOrFPA6DvfkM761o1B9g@mail.gmail.com>
Subject: Re: [PATCH 11/20] mm: zswap: function ordering: pool refcounting
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Move pool refcounting functions into the pool section. First the
> destroy functions, then the get and put which uses them.
>
> __zswap_pool_empty() has an upward reference to the global
> zswap_pools, to sanity check it's not the currently active pool that's
> being freed. That gets the forward decl for zswap_pool_cuyrrent().

nit: zswap_pool_cuyrrent() -> zswap_pool_current() :-)

Also, would it make sense to move zswap_pool_current() above
__zswap_pool_empty() to get rid of the forward declaration? I guess
it's now grouped with current_get() etc. - those don't seem to use the
empty check, so maybe they can also go above __zswap_pool_empty()?


>
> This puts the get and put function above all callers, so kill the
> forward decls as well.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 94 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 47 insertions(+), 47 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 805d9a35f633..33775f2224b7 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -278,8 +278,6 @@ static inline struct zswap_tree *swap_zswap_tree(swp_=
entry_t swp)
>
>  static int zswap_writeback_entry(struct zswap_entry *entry,
>                                  swp_entry_t swpentry);
> -static int zswap_pool_get(struct zswap_pool *pool);
> -static void zswap_pool_put(struct zswap_pool *pool);
>
>  static bool zswap_is_full(void)
>  {
> @@ -472,6 +470,53 @@ static void zswap_pool_destroy(struct zswap_pool *po=
ol)
>         kfree(pool);
>  }
>
> +static void __zswap_pool_release(struct work_struct *work)
> +{
> +       struct zswap_pool *pool =3D container_of(work, typeof(*pool),
> +                                               release_work);
> +
> +       synchronize_rcu();
> +
> +       /* nobody should have been able to get a kref... */
> +       WARN_ON(kref_get_unless_zero(&pool->kref));
> +
> +       /* pool is now off zswap_pools list and has no references. */
> +       zswap_pool_destroy(pool);
> +}
> +
> +static struct zswap_pool *zswap_pool_current(void);
> +
> +static void __zswap_pool_empty(struct kref *kref)
> +{
> +       struct zswap_pool *pool;
> +
> +       pool =3D container_of(kref, typeof(*pool), kref);
> +
> +       spin_lock(&zswap_pools_lock);
> +
> +       WARN_ON(pool =3D=3D zswap_pool_current());
> +
> +       list_del_rcu(&pool->list);
> +
> +       INIT_WORK(&pool->release_work, __zswap_pool_release);
> +       schedule_work(&pool->release_work);
> +
> +       spin_unlock(&zswap_pools_lock);
> +}
> +
> +static int __must_check zswap_pool_get(struct zswap_pool *pool)
> +{
> +       if (!pool)
> +               return 0;
> +
> +       return kref_get_unless_zero(&pool->kref);
> +}
> +
> +static void zswap_pool_put(struct zswap_pool *pool)
> +{
> +       kref_put(&pool->kref, __zswap_pool_empty);
> +}
> +
>  /* should be called under RCU */
>  #ifdef CONFIG_MEMCG
>  static inline struct mem_cgroup *mem_cgroup_from_entry(struct zswap_entr=
y *entry)
> @@ -1122,51 +1167,6 @@ static void shrink_worker(struct work_struct *w)
>         zswap_pool_put(pool);
>  }
>
> -static int __must_check zswap_pool_get(struct zswap_pool *pool)
> -{
> -       if (!pool)
> -               return 0;
> -
> -       return kref_get_unless_zero(&pool->kref);
> -}
> -
> -static void __zswap_pool_release(struct work_struct *work)
> -{
> -       struct zswap_pool *pool =3D container_of(work, typeof(*pool),
> -                                               release_work);
> -
> -       synchronize_rcu();
> -
> -       /* nobody should have been able to get a kref... */
> -       WARN_ON(kref_get_unless_zero(&pool->kref));
> -
> -       /* pool is now off zswap_pools list and has no references. */
> -       zswap_pool_destroy(pool);
> -}
> -
> -static void __zswap_pool_empty(struct kref *kref)
> -{
> -       struct zswap_pool *pool;
> -
> -       pool =3D container_of(kref, typeof(*pool), kref);
> -
> -       spin_lock(&zswap_pools_lock);
> -
> -       WARN_ON(pool =3D=3D zswap_pool_current());
> -
> -       list_del_rcu(&pool->list);
> -
> -       INIT_WORK(&pool->release_work, __zswap_pool_release);
> -       schedule_work(&pool->release_work);
> -
> -       spin_unlock(&zswap_pools_lock);
> -}
> -
> -static void zswap_pool_put(struct zswap_pool *pool)
> -{
> -       kref_put(&pool->kref, __zswap_pool_empty);
> -}
> -
>  /*********************************
>  * param callbacks
>  **********************************/
> --
> 2.43.0
>

