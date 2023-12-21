Return-Path: <linux-kernel+bounces-9032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB281BF6F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3E31F21C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C12273191;
	Thu, 21 Dec 2023 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkMFVnWA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE1651B3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e23a4df33so1507304e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703189325; x=1703794125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CI7GB6u39MLbqZUFzJg2hzBKBi/8Q4CxwH4rHsWQ8yc=;
        b=XkMFVnWA8hmzxD3/nVeogBGCSyPvN/vERWlov+nMwjqyrQkXGO/L79t7XkSHEup4Xd
         1hgh+IlEJMg67gV8fhtCqnoqAiw2xZnoes2tLVYO7JFFnUd4QZGogmc+H88LrKDQxG5A
         YB/awJjE+rcDGvpw1sZHjtv+K/mp/FRBgzmZaibi/btawm6++kA7vuLuPHG0RvOhzm4B
         m3l3hU5KoUtXE3VfetOD0trDCcBfTDjV3xTWB+U3dHHfm1qOcVeczEZL1XreKRKv4KFP
         ViHZI8RTgMDUNGeuPR43nWisybsj0Eyx+pJO1+Gg6TdUtxfcJuKNCZYMIa9SfZzigXfe
         bcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703189325; x=1703794125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CI7GB6u39MLbqZUFzJg2hzBKBi/8Q4CxwH4rHsWQ8yc=;
        b=cWvu0iySgAHcOympG5wsIxeJCuwzaB+H9LsoztUl8SFTjtSjKwW1/aAk+nutmJBZiH
         i0Ji6IYw2KRrhmFB5o03JBeV00S1/bPVC0yWWB3/qUw+e/cWGCAL0ONPFUs7fhk2pe5z
         oQt0DSiY6JVlezx3y7GyaMq7Kk3TrcJOp+YYfvSZ5cOCbLyJwfm3PmLasEzbFOz/2+u6
         QZWies4R9LUfikIHQPsJGRkbd0yvewpM9SxesiFV7inrHZCXczMDdozkPL8cdUcdGjoO
         nuKYb4U6QmnKGr3dhLt+agrSJLMsAgty/VG/xdbsKD4JiG/8/setSUNw1XolZL+XGOyD
         QY6g==
X-Gm-Message-State: AOJu0YzyqHXTLbVAEP5wwLHh9t4NSlHrgmf0rA7YFw1Jt9xyDmp/kESb
	O6SFlwCSCtCR4aphdgDbU4g4EmRV6rH21qRTvxRFS37W6h7z
X-Google-Smtp-Source: AGHT+IHVMNGjRNQzBJfCB9njC1zr6AiSDVqSO2E/dVCp5OPxpipphQzvdXlM24MD9oYR77qHTF6nJq6wg/Lw0YQ9QKY=
X-Received: by 2002:a05:6512:23a2:b0:50e:3777:f779 with SMTP id
 c34-20020a05651223a200b0050e3777f779mr116972lfv.31.1703189325320; Thu, 21 Dec
 2023 12:08:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221183540.168428-1-andrey.konovalov@linux.dev>
In-Reply-To: <20231221183540.168428-1-andrey.konovalov@linux.dev>
From: Marco Elver <elver@google.com>
Date: Thu, 21 Dec 2023 21:08:04 +0100
Message-ID: <CANpmjNMezNWBoH8m38XO2=dP9KQk+_Vb8bo41F7ytQVdbEe-3g@mail.gmail.com>
Subject: Re: [PATCH mm 1/4] kasan: clean up kasan_cache_create
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
> Reorganize the code to avoid nested if/else checks to improve the
> readability.
>
> Also drop the confusing comments about KMALLOC_MAX_SIZE checks: they
> are relevant for both SLUB and SLAB (originally, the comments likely
> confused KMALLOC_MAX_SIZE with KMALLOC_MAX_CACHE_SIZE).
>
> Fixes: a5989d4ed40c ("kasan: improve free meta storage in Generic KASAN")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/generic.c | 67 +++++++++++++++++++++++++++-------------------
>  1 file changed, 39 insertions(+), 28 deletions(-)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 54e20b2bc3e1..769e43e05d0b 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -381,16 +381,11 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>
>         ok_size = *size;
>
> -       /* Add alloc meta into redzone. */
> +       /* Add alloc meta into the redzone. */
>         cache->kasan_info.alloc_meta_offset = *size;
>         *size += sizeof(struct kasan_alloc_meta);
>
> -       /*
> -        * If alloc meta doesn't fit, don't add it.
> -        * This can only happen with SLAB, as it has KMALLOC_MAX_SIZE equal
> -        * to KMALLOC_MAX_CACHE_SIZE and doesn't fall back to page_alloc for
> -        * larger sizes.
> -        */
> +       /* If alloc meta doesn't fit, don't add it. */
>         if (*size > KMALLOC_MAX_SIZE) {
>                 cache->kasan_info.alloc_meta_offset = 0;
>                 *size = ok_size;
> @@ -401,36 +396,52 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>         orig_alloc_meta_offset = cache->kasan_info.alloc_meta_offset;
>
>         /*
> -        * Add free meta into redzone when it's not possible to store
> +        * Store free meta in the redzone when it's not possible to store
>          * it in the object. This is the case when:
>          * 1. Object is SLAB_TYPESAFE_BY_RCU, which means that it can
>          *    be touched after it was freed, or
>          * 2. Object has a constructor, which means it's expected to
> -        *    retain its content until the next allocation, or
> -        * 3. Object is too small and SLUB DEBUG is enabled. Avoid
> -        *    free meta that exceeds the object size corrupts the
> -        *    SLUB DEBUG metadata.
> -        * Otherwise cache->kasan_info.free_meta_offset = 0 is implied.
> -        * If the object is smaller than the free meta and SLUB DEBUG
> -        * is not enabled, it is still possible to store part of the
> -        * free meta in the object.
> +        *    retain its content until the next allocation.
>          */
>         if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor) {
>                 cache->kasan_info.free_meta_offset = *size;
>                 *size += sizeof(struct kasan_free_meta);
> -       } else if (cache->object_size < sizeof(struct kasan_free_meta)) {
> -               if (__slub_debug_enabled()) {
> -                       cache->kasan_info.free_meta_offset = *size;
> -                       *size += sizeof(struct kasan_free_meta);
> -               } else {
> -                       rem_free_meta_size = sizeof(struct kasan_free_meta) -
> -                                                                       cache->object_size;
> -                       *size += rem_free_meta_size;
> -                       if (cache->kasan_info.alloc_meta_offset != 0)
> -                               cache->kasan_info.alloc_meta_offset += rem_free_meta_size;
> -               }
> +               goto free_meta_added;
> +       }
> +
> +       /*
> +        * Otherwise, if the object is large enough to contain free meta,
> +        * store it within the object.
> +        */
> +       if (sizeof(struct kasan_free_meta) <= cache->object_size) {
> +               /* cache->kasan_info.free_meta_offset = 0 is implied. */
> +               goto free_meta_added;
>         }
>
> +       /*
> +        * For smaller objects, store the beginning of free meta within the
> +        * object and the end in the redzone. And thus shift the location of
> +        * alloc meta to free up space for free meta.
> +        * This is only possible when slub_debug is disabled, as otherwise
> +        * the end of free meta will overlap with slub_debug metadata.
> +        */
> +       if (!__slub_debug_enabled()) {
> +               rem_free_meta_size = sizeof(struct kasan_free_meta) -
> +                                                       cache->object_size;
> +               *size += rem_free_meta_size;
> +               if (cache->kasan_info.alloc_meta_offset != 0)
> +                       cache->kasan_info.alloc_meta_offset += rem_free_meta_size;
> +               goto free_meta_added;
> +       }
> +
> +       /*
> +        * If the object is small and slub_debug is enabled, store free meta
> +        * in the redzone after alloc meta.
> +        */
> +       cache->kasan_info.free_meta_offset = *size;
> +       *size += sizeof(struct kasan_free_meta);
> +
> +free_meta_added:
>         /* If free meta doesn't fit, don't add it. */
>         if (*size > KMALLOC_MAX_SIZE) {
>                 cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
> @@ -440,7 +451,7 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>
>         /* Calculate size with optimal redzone. */
>         optimal_size = cache->object_size + optimal_redzone(cache->object_size);
> -       /* Limit it with KMALLOC_MAX_SIZE (relevant for SLAB only). */
> +       /* Limit it with KMALLOC_MAX_SIZE. */
>         if (optimal_size > KMALLOC_MAX_SIZE)
>                 optimal_size = KMALLOC_MAX_SIZE;
>         /* Use optimal size if the size with added metas is not large enough. */
> --
> 2.25.1
>

