Return-Path: <linux-kernel+bounces-30464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BE3831F03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6BF1C21570
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC682D61C;
	Thu, 18 Jan 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBc+i5H0"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DCD2D603
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601812; cv=none; b=ue4XoCmyz0pjkImZjwSXVXJ0YiY0Sjb3VuQ23gfQMZAT/nI4ReCnsjlZdEJrkcaa0mWhjz7QPeN+HgOVIy3pYOT+0OGcoxzOSB/Ue1JflpoP2Ix6VVMqDiuYs5Y+saBzcgJs+n2XLCYCiyMbEBvcBD+05TerBtHpQ+tQeS8vIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601812; c=relaxed/simple;
	bh=5/4og5glP9zdLy7I7d5oxsFz5APYY0CQD4pK7aB5GXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4XPyYOfGzjh1oJgh4fVYTDi2niYLlpb0ztXzPn+Tr1zB27wdi7Gx6BefSjji6xvPf+VA2la51LyDr89MDOJrH/NWBznaMsNHliRoowkqwhu8BanoSWl/R7AB0R0Fiqic9v8LMs04F67MHnWgQrhheFqlTpePbAgtWa7B5+jR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBc+i5H0; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bb5fda069bso517519139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705601810; x=1706206610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h1yBz/J7E0Ht6qB3EEpyUc4skdwfMJw+NDm6XA4Q44=;
        b=dBc+i5H0L3D2x1PzjM3z1xYPGdSztjpLJd9TeM96FFnYwwBUDAIMVl/QAEMCwRy902
         A1BBswRjormpGCObuLDcPDFXs7UtoSwIcqDs8UWlrQHAGCJBRyO6Ig01IxUdN3pAdBw9
         dgeSuXPkv3fiRa70aaqDqYGrbdG+S8YLF+G03pl0bjxGRlOa6OFCQklwCmt4xapS8zPx
         XVuTV9do02fO4+JyTb+8lBEiSW9WVsm21icrQUctJRGPGf60H3o99HHHF2oJUg3RzXZF
         s9hYf18heMDhUFSiITGTKoZkT5KLyP9Z5CozJHZ9e1RVL7/UIFhMJy3PEYxeDd9RlJ1m
         fEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601810; x=1706206610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8h1yBz/J7E0Ht6qB3EEpyUc4skdwfMJw+NDm6XA4Q44=;
        b=naWewsmey4RFlt02pQ2f3OhgW2h/pU1FRfggd6L3B8/DtgdY7bAMANKrDi03gsTc4L
         RL+ZUrvcOypULpeOqVlPHFU8/P3ztB4Qt7txKejJB52yrkOrFKPxwC5AcVSBlmZKaAZW
         s6ZIYLGuiJahJ4f1itQdw+HEK3B+xi6R8H6pP61kZjt4hnhmafL6OCEsDUg1MStqgVus
         ukerYPb750gpe/ij99WJPhg8YlfRelWd8ZC67HmB1A4KdcVcKXlPgz+46c8jd7edNS8Q
         QW25SK60R/szbNPpKis2+k6uCKzfcRg3mhTlv5UM9ftdoZxXmFjBN7k9QPc3qxxXTe7B
         dGrA==
X-Gm-Message-State: AOJu0Yw+JCUZQM4/yTdGCz+Pmlo573IqHx+nHUYY02MyDAT+IBHfREiw
	p5b56/3V8XMaeJGFUE5Mr+U/cHcEudoYvosbbtdkFDlQm8xYy95pIXYv/a8Fzb7u+jj8zPDrFAS
	Zkr5ZRkordtVvjA91O5Agwl2f2vk=
X-Google-Smtp-Source: AGHT+IF4ac27YHrVkcC7cplUn0qBT5WLu6b/s4Z+TAj7QYcFXrWFEosv+9IOrBbhUqVNXgro3OsJqjySMhRjv7WeDr0=
X-Received: by 2002:a6b:6f18:0:b0:7bf:4f28:11a1 with SMTP id
 k24-20020a6b6f18000000b007bf4f2811a1mr1471678ioc.11.1705601810023; Thu, 18
 Jan 2024 10:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com> <20240117-b4-zswap-lock-optimize-v1-1-23f6effe5775@bytedance.com>
In-Reply-To: <20240117-b4-zswap-lock-optimize-v1-1-23f6effe5775@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 18 Jan 2024 10:16:39 -0800
Message-ID: <CAKEwX=Oj+Vb1d8aahBJ6=51XZY0rG-G06CnQeqiD8=M7KbjtZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/zswap: make sure each swapfile always have zswap rb-tree
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	Chris Li <chriscli@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 1:23=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Not all zswap interfaces can handle the absence of the zswap rb-tree,
> actually only zswap_store() has handled it for now.
>
> To make things simple, we make sure each swapfile always have the
> zswap rb-tree prepared before being enabled and used. The preparation
> is unlikely to fail in practice, this patch just make it explicit.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

This seems fine to me. IIUC, zswap_swapon() only fails when the rbtree
allocation fails, and the tree's memory footprint is small so that's
unlikely anyway.

Acked-by: Nhat Pham <nphamcs@gmail.com>



> ---
>  include/linux/zswap.h |  7 +++++--
>  mm/swapfile.c         | 10 +++++++---
>  mm/zswap.c            |  7 ++++---
>  3 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 0b709f5bc65f..eca388229d9a 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -30,7 +30,7 @@ struct zswap_lruvec_state {
>  bool zswap_store(struct folio *folio);
>  bool zswap_load(struct folio *folio);
>  void zswap_invalidate(int type, pgoff_t offset);
> -void zswap_swapon(int type);
> +int zswap_swapon(int type);
>  void zswap_swapoff(int type);
>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
>  void zswap_lruvec_state_init(struct lruvec *lruvec);
> @@ -51,7 +51,10 @@ static inline bool zswap_load(struct folio *folio)
>  }
>
>  static inline void zswap_invalidate(int type, pgoff_t offset) {}
> -static inline void zswap_swapon(int type) {}
> +static inline int zswap_swapon(int type)
> +{
> +       return 0;
> +}
>  static inline void zswap_swapoff(int type) {}
>  static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)=
 {}
>  static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 3eec686484ef..6c53ea06626b 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2347,8 +2347,6 @@ static void enable_swap_info(struct swap_info_struc=
t *p, int prio,
>                                 unsigned char *swap_map,
>                                 struct swap_cluster_info *cluster_info)
>  {
> -       zswap_swapon(p->type);
> -
>         spin_lock(&swap_lock);
>         spin_lock(&p->lock);
>         setup_swap_info(p, prio, swap_map, cluster_info);
> @@ -3166,6 +3164,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, speci=
alfile, int, swap_flags)
>         if (error)
>                 goto bad_swap_unlock_inode;
>
> +       error =3D zswap_swapon(p->type);
> +       if (error)
> +               goto free_swap_address_space;
> +
>         /*
>          * Flush any pending IO and dirty mappings before we start using =
this
>          * swap device.
> @@ -3174,7 +3176,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specia=
lfile, int, swap_flags)
>         error =3D inode_drain_writes(inode);
>         if (error) {
>                 inode->i_flags &=3D ~S_SWAPFILE;
> -               goto free_swap_address_space;
> +               goto free_swap_zswap;
>         }
>
>         mutex_lock(&swapon_mutex);
> @@ -3198,6 +3200,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specia=
lfile, int, swap_flags)
>
>         error =3D 0;
>         goto out;
> +free_swap_zswap:
> +       zswap_swapoff(p->type);
>  free_swap_address_space:
>         exit_swap_address_space(p->type);
>  bad_swap_unlock_inode:
> diff --git a/mm/zswap.c b/mm/zswap.c
> index ca25b676048e..d88faea85978 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1519,7 +1519,7 @@ bool zswap_store(struct folio *folio)
>         if (folio_test_large(folio))
>                 return false;
>
> -       if (!zswap_enabled || !tree)
> +       if (!zswap_enabled)
>                 return false;
>
>         /*
> @@ -1772,19 +1772,20 @@ void zswap_invalidate(int type, pgoff_t offset)
>         spin_unlock(&tree->lock);
>  }
>
> -void zswap_swapon(int type)
> +int zswap_swapon(int type)
>  {
>         struct zswap_tree *tree;
>
>         tree =3D kzalloc(sizeof(*tree), GFP_KERNEL);
>         if (!tree) {
>                 pr_err("alloc failed, zswap disabled for swap type %d\n",=
 type);
> -               return;
> +               return -ENOMEM;
>         }
>
>         tree->rbroot =3D RB_ROOT;
>         spin_lock_init(&tree->lock);
>         zswap_trees[type] =3D tree;
> +       return 0;
>  }
>
>  void zswap_swapoff(int type)
>
> --
> b4 0.10.1

