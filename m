Return-Path: <linux-kernel+bounces-9035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3C581BF77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FE11F24FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C3E74087;
	Thu, 21 Dec 2023 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOVege5L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0273185
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so12059671fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703189487; x=1703794287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n71TmRIpLCKyJ+zhDPnh2JHDUhteUqmqWNotznqdT9E=;
        b=gOVege5LByP88rZ4oZAUShN+MUa+0DS02TtCVWEg2K59qr46sFVsgnZoAZQV574TRp
         g5Qedg3lOotXnu7PkUPsPSKLsi/wfYmCudWG6ELhajmE7GDjhxv+jp3S6N14UvSk30aV
         idugNf0KNwcry4vwOAK+gq1srZExpzK2g4nDzxmA4BqnznSYBG+/wUJa+xjuxXbQjjo9
         eu74xm1ouUcFvewCHNoSSg4hytrDQMOeeAYrzK5fdiF+zJVIE2Nb+klownUX+yFZy9U7
         qHAfo4Y6H8pGapr/Xkln47UefioM7mr0gbLV3DJ2U/SUZQyhgFiRp0vx+aHl/Q4n5ukI
         f4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703189487; x=1703794287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n71TmRIpLCKyJ+zhDPnh2JHDUhteUqmqWNotznqdT9E=;
        b=DbS07zNYF7tOfQ0nG2/qNW5kRz3blhybvlALdUGLNzhID8zG5ulh2GAaUU6M6Ft6EZ
         BxrMPERrtf2rZO9mZ+6l1ARJHfUZr5laoDgHpdI86NQJDaSHXEHbfgwQqnAq7LqnqEFp
         Oz1AOVhyFQIhQKOJz/mA/poF834QyF2CdLjFuq1bwTiHmaYUS698lrcQz8IZbZyRDfVk
         HBKAGyPNDo23Mgpu6JLIbftOjMAQahE4+/38ytwys6DfzJF5xzdx7yj2IrEGhDwbv8fX
         +8qdR1lwFNvvJGxiYu6sZ9BZqJkijjy5fUIYZEkXkbTVKNaTYoXmGq47Sj7FtwuNUgPg
         Z4UA==
X-Gm-Message-State: AOJu0Yy9AD1VMfpBg/XmQSU70E5L6iiljVRrSzIovVI3GvzAL6RTnwbK
	6EhOHDNWjupQ+2dGajfrUqEJe9peOJwKGKsyhWsPIvQ90ElL
X-Google-Smtp-Source: AGHT+IE59GMCd+Sp8BvDAITSutdUY75SWWv4LdP0IR0TwmnLInbBjgqesJQAX5QTIP1uIXd6tZ8Pc1llvEeXEFPlCKw=
X-Received: by 2002:a2e:b616:0:b0:2cc:8472:c97c with SMTP id
 r22-20020a2eb616000000b002cc8472c97cmr72870ljn.26.1703189487134; Thu, 21 Dec
 2023 12:11:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221183540.168428-1-andrey.konovalov@linux.dev> <20231221183540.168428-2-andrey.konovalov@linux.dev>
In-Reply-To: <20231221183540.168428-2-andrey.konovalov@linux.dev>
From: Marco Elver <elver@google.com>
Date: Thu, 21 Dec 2023 21:10:49 +0100
Message-ID: <CANpmjNPGBMD6XsPpdL-ix8VTuWAwV-jmBjLpC66Z5y543j0DuA@mail.gmail.com>
Subject: Re: [PATCH mm 2/4] kasan: reuse kasan_track in kasan_stack_ring_entry
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
> Avoid duplicating fields of kasan_track in kasan_stack_ring_entry:
> reuse the structure.

No functional change?

> Fixes: 5d4c6ac94694 ("kasan: record and report more information")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/kasan.h       |  7 +------
>  mm/kasan/report_tags.c | 12 ++++++------
>  mm/kasan/tags.c        | 12 ++++++------
>  3 files changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 5e298e3ac909..9072ce4c1263 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -279,13 +279,8 @@ struct kasan_free_meta {
>  struct kasan_stack_ring_entry {
>         void *ptr;
>         size_t size;
> -       u32 pid;
> -       depot_stack_handle_t stack;
> +       struct kasan_track track;
>         bool is_free;
> -#ifdef CONFIG_KASAN_EXTRA_INFO
> -       u64 cpu:20;
> -       u64 timestamp:44;
> -#endif /* CONFIG_KASAN_EXTRA_INFO */
>  };
>
>  struct kasan_stack_ring {
> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
> index 979f284c2497..688b9d70b04a 100644
> --- a/mm/kasan/report_tags.c
> +++ b/mm/kasan/report_tags.c
> @@ -31,8 +31,8 @@ static const char *get_common_bug_type(struct kasan_report_info *info)
>  static void kasan_complete_extra_report_info(struct kasan_track *track,
>                                          struct kasan_stack_ring_entry *entry)
>  {
> -       track->cpu = entry->cpu;
> -       track->timestamp = entry->timestamp;
> +       track->cpu = entry->track.cpu;
> +       track->timestamp = entry->track.timestamp;
>  }
>  #endif /* CONFIG_KASAN_EXTRA_INFO */
>
> @@ -80,8 +80,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>                         if (free_found)
>                                 break;
>
> -                       info->free_track.pid = entry->pid;
> -                       info->free_track.stack = entry->stack;
> +                       info->free_track.pid = entry->track.pid;
> +                       info->free_track.stack = entry->track.stack;
>  #ifdef CONFIG_KASAN_EXTRA_INFO
>                         kasan_complete_extra_report_info(&info->free_track, entry);
>  #endif /* CONFIG_KASAN_EXTRA_INFO */
> @@ -98,8 +98,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>                         if (alloc_found)
>                                 break;
>
> -                       info->alloc_track.pid = entry->pid;
> -                       info->alloc_track.stack = entry->stack;
> +                       info->alloc_track.pid = entry->track.pid;
> +                       info->alloc_track.stack = entry->track.stack;
>  #ifdef CONFIG_KASAN_EXTRA_INFO
>                         kasan_complete_extra_report_info(&info->alloc_track, entry);
>  #endif /* CONFIG_KASAN_EXTRA_INFO */
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index c13b198b8302..c4d14dbf27c0 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -100,8 +100,8 @@ static void save_extra_info(struct kasan_stack_ring_entry *entry)
>         u32 cpu = raw_smp_processor_id();
>         u64 ts_nsec = local_clock();
>
> -       entry->cpu = cpu;
> -       entry->timestamp = ts_nsec >> 3;
> +       entry->track.cpu = cpu;
> +       entry->track.timestamp = ts_nsec >> 3;
>  }
>  #endif /* CONFIG_KASAN_EXTRA_INFO */
>
> @@ -134,15 +134,15 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
>         if (!try_cmpxchg(&entry->ptr, &old_ptr, STACK_RING_BUSY_PTR))
>                 goto next; /* Busy slot. */
>
> -       old_stack = entry->stack;
> +       old_stack = entry->track.stack;
>
>         entry->size = cache->object_size;
> -       entry->pid = current->pid;
> -       entry->stack = stack;
> -       entry->is_free = is_free;
> +       entry->track.pid = current->pid;
> +       entry->track.stack = stack;
>  #ifdef CONFIG_KASAN_EXTRA_INFO
>         save_extra_info(entry);
>  #endif /* CONFIG_KASAN_EXTRA_INFO */
> +       entry->is_free = is_free;
>
>         entry->ptr = object;
>
> --
> 2.25.1
>

