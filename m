Return-Path: <linux-kernel+bounces-9036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4738681BF79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C976B24251
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4691745C5;
	Thu, 21 Dec 2023 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yWNwy6u1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989357318F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e55f97606so1841683e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703189544; x=1703794344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AOUuUpeABJU7I8+1+Vm/xHhOxyiEVjsNYRzmTn6EesE=;
        b=yWNwy6u1GsZUXnfByRMYZOWxBhFeNon3LhNrjD4osCecN4KHaVt+pV3Kk+Pow/qNqM
         ZK5sXSthWMZfyWStoih39LjUSxRxVfxHDe8B9RiEDz6IPthfMfnzWvuvuHVZc6Jt3Lud
         z7sjq/fYf3dBIz/f6NI0+IKmOmriI5/jcroli4W4Y3TPaRkhYHQSZZv16mfhDeDdtx4e
         axwyUFM1KQBA4uhybMOdLBrxqZiKHf9xN9IER4vPNUqGS/CpwkjzLHkHzUxinXi9/tH9
         AhmPBMCyuw4EjXPhxTuApvpB7HHxAajAUrIpjePioYRJwLyWXTUQuTM8eYtfjuo4+8ux
         Yr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703189544; x=1703794344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOUuUpeABJU7I8+1+Vm/xHhOxyiEVjsNYRzmTn6EesE=;
        b=dqSe0Er5yS4Yayella0Gti3dbvnFqvVKKeWFL6a1NUjLApdp53z7/m/JmW2dMFcEoc
         5DWqy6a3m+VnB7Ng4THlYSe/9Utb+JbCGa1bMNH9yDKbzutD/AfUIuToIGCF0IQOuDGw
         v8Q8xC6kBI4C/JTrIVv90BjDerDU8xOsfL9e9QKdeWSR53YzcYflYZeKAiQYzviCWJLH
         7tGUOiqeT/uE8IbLQP+6JEQU9atdTSGB8lejt4EOSbzeJ7ihlKMeYQha0DY5ySMQmd9e
         6vxhPHZYWDm+3aLtf5ZWiXkEMjyxhKeWuYPghiq5YXVbTyeat+oMzIOLYYKIFVxDy77U
         ERaQ==
X-Gm-Message-State: AOJu0YxomRzJkMkPdhmS2emhlJnAVEgA+l342lIrEgLickGtQpNdtwf9
	tYmaO3LtrUMMx7yfIwdcGgNwCjJfhkmrMuNEmB5xY4ZDe05Z
X-Google-Smtp-Source: AGHT+IFHsLrgMmxgusbKxty3aCTo9lH7GTmEHwygh6oBvU3CIsm6/vZDcPyPR2xhRuMIDYGDXqeGFnKIvl3cPp5VJUA=
X-Received: by 2002:ac2:5f81:0:b0:50e:5898:7572 with SMTP id
 r1-20020ac25f81000000b0050e58987572mr92458lfe.20.1703189543635; Thu, 21 Dec
 2023 12:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221183540.168428-1-andrey.konovalov@linux.dev> <20231221183540.168428-3-andrey.konovalov@linux.dev>
In-Reply-To: <20231221183540.168428-3-andrey.konovalov@linux.dev>
From: Marco Elver <elver@google.com>
Date: Thu, 21 Dec 2023 21:11:46 +0100
Message-ID: <CANpmjNNkgRbj4jgAGHtKTBB0Qj_u+KmFnBS5699zjL7-p1eV+Q@mail.gmail.com>
Subject: Re: [PATCH mm 3/4] kasan: simplify saving extra info into tracks
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>, Juntong Deng <juntong.deng@outlook.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 19:35, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Avoid duplicating code for saving extra info into tracks: reuse the
> common function for this.
>
> Fixes: 5d4c6ac94694 ("kasan: record and report more information")

Looking at this patch and the previous ones, is this Fixes really
needed? I.e. was the previous patch broken?

> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/common.c  | 12 ++++++++++--
>  mm/kasan/generic.c |  4 ++--
>  mm/kasan/kasan.h   |  3 ++-
>  mm/kasan/tags.c    | 17 +----------------
>  4 files changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index fe6c4b43ad9f..d004a0f4406c 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -48,7 +48,7 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags)
>         return stack_depot_save_flags(entries, nr_entries, flags, depot_flags);
>  }
>
> -void kasan_set_track(struct kasan_track *track, gfp_t flags)
> +void kasan_set_track(struct kasan_track *track, depot_stack_handle_t stack)
>  {
>  #ifdef CONFIG_KASAN_EXTRA_INFO
>         u32 cpu = raw_smp_processor_id();
> @@ -58,8 +58,16 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags)
>         track->timestamp = ts_nsec >> 3;
>  #endif /* CONFIG_KASAN_EXTRA_INFO */
>         track->pid = current->pid;
> -       track->stack = kasan_save_stack(flags,
> +       track->stack = stack;
> +}
> +
> +void kasan_save_track(struct kasan_track *track, gfp_t flags)
> +{
> +       depot_stack_handle_t stack;
> +
> +       stack = kasan_save_stack(flags,
>                         STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
> +       kasan_set_track(track, stack);
>  }
>
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 769e43e05d0b..11b575707b05 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -553,7 +553,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>         stack_depot_put(alloc_meta->aux_stack[1]);
>         __memset(alloc_meta, 0, sizeof(*alloc_meta));
>
> -       kasan_set_track(&alloc_meta->alloc_track, flags);
> +       kasan_save_track(&alloc_meta->alloc_track, flags);
>  }
>
>  void kasan_save_free_info(struct kmem_cache *cache, void *object)
> @@ -564,7 +564,7 @@ void kasan_save_free_info(struct kmem_cache *cache, void *object)
>         if (!free_meta)
>                 return;
>
> -       kasan_set_track(&free_meta->free_track, 0);
> +       kasan_save_track(&free_meta->free_track, 0);
>         /* The object was freed and has free track set. */
>         *(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREETRACK;
>  }
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 9072ce4c1263..31fb6bb26fed 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -372,7 +372,8 @@ static inline void kasan_init_object_meta(struct kmem_cache *cache, const void *
>  #endif
>
>  depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags);
> -void kasan_set_track(struct kasan_track *track, gfp_t flags);
> +void kasan_set_track(struct kasan_track *track, depot_stack_handle_t stack);
> +void kasan_save_track(struct kasan_track *track, gfp_t flags);
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
>  void kasan_save_free_info(struct kmem_cache *cache, void *object);
>
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index c4d14dbf27c0..d65d48b85f90 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -94,17 +94,6 @@ void __init kasan_init_tags(void)
>         }
>  }
>
> -#ifdef CONFIG_KASAN_EXTRA_INFO
> -static void save_extra_info(struct kasan_stack_ring_entry *entry)
> -{
> -       u32 cpu = raw_smp_processor_id();
> -       u64 ts_nsec = local_clock();
> -
> -       entry->track.cpu = cpu;
> -       entry->track.timestamp = ts_nsec >> 3;
> -}
> -#endif /* CONFIG_KASAN_EXTRA_INFO */
> -
>  static void save_stack_info(struct kmem_cache *cache, void *object,
>                         gfp_t gfp_flags, bool is_free)
>  {
> @@ -137,11 +126,7 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
>         old_stack = entry->track.stack;
>
>         entry->size = cache->object_size;
> -       entry->track.pid = current->pid;
> -       entry->track.stack = stack;
> -#ifdef CONFIG_KASAN_EXTRA_INFO
> -       save_extra_info(entry);
> -#endif /* CONFIG_KASAN_EXTRA_INFO */
> +       kasan_set_track(&entry->track, stack);
>         entry->is_free = is_free;
>
>         entry->ptr = object;
> --
> 2.25.1
>

