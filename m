Return-Path: <linux-kernel+bounces-5968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8BA819239
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74632877D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6FB3D0A3;
	Tue, 19 Dec 2023 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BLfKU/60"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082853D0A5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7cbf6ce782dso488738241.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703020923; x=1703625723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8LGegP+G5PWWJJoK9xgDRxY4ivR1WBT3Si9rlrLcuhs=;
        b=BLfKU/60GmFLDOteu0Ir3XZ0xybACjQKaidD+D+jP1bqZNQUfCIk3r8uDRf4Dppvnt
         MtYrnma6B7L77EcdPiVc/fjJyXodvQ0+WCBFfkqlJgK7iR5BtbSy9YfRPZkQXEKMgiiV
         IWWed5SI/cH64/t4BPN6/y+/YjQ+gJllt24xPChwxMfMrfl5tkfLxcSQt90ebyD5z1aH
         3NWivXCMUEUbONIrZzOwZsBYZ31GumyDjHpuSfMSiuKtQ1unaBcaFmjJTmal+FPHMTFv
         pVlWfsjSwLJIzEincycUbb5x0hQb8EjrurMJmtXmNvajEMjV+vYZ3SFbKM/c2D+vJapj
         dLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703020923; x=1703625723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LGegP+G5PWWJJoK9xgDRxY4ivR1WBT3Si9rlrLcuhs=;
        b=qT3VhtmFZ4BsEo8zhEp4+bAk4hqjN4NW+ab9eJ7Q20bRtW0ki9Vzo7KIqN3e21fHqm
         NvOOsVh/DhLOZ+pfToOpYw5Aonu35C1TBjC913Bge39UxJpIzOzMFhU6Xqju2I8tcDc5
         ztuAUraWRUEjI1BwrSlzHQ/uVcIvxgJITzIZIOLxEkg0JlOi0wa6ONmoNdVZezXv6A4I
         bWLGztoJZcP63g4bM01PGLSmZPCcgj6HjO/7RnClA6V74Fi4PsUBMHc8RuG0faiDwsdJ
         TO9dJsXyN5rvewHdGZx4xYVrMAbKtdpneGaoSv7ozG7rO3Q6kfy4kElofRJaV+deHiRa
         J4PA==
X-Gm-Message-State: AOJu0Yw9jZtdUnO0NUKo9Dsy6kNOvb8tZ0bREU2c1MoLPlcoTTj9/72+
	ZOzuM7WoJII09xY4skCFHFq2G20ZnCR2S0Ha7Z0rbw==
X-Google-Smtp-Source: AGHT+IHWRL7HUoJ48zzjc4DtaZvkU/8q41KHmjYkBneQNQbK6qR6g17/1aTX9jjBAw67Ydn0aFF+kLsNpG0V0YW1W58=
X-Received: by 2002:a05:6102:559e:b0:466:9bec:ae53 with SMTP id
 dc30-20020a056102559e00b004669becae53mr2855956vsb.25.1703020922750; Tue, 19
 Dec 2023 13:22:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703020707.git.andreyknvl@google.com> <1606b960e2f746862d1f459515972f9695bf448a.1703020707.git.andreyknvl@google.com>
In-Reply-To: <1606b960e2f746862d1f459515972f9695bf448a.1703020707.git.andreyknvl@google.com>
From: Marco Elver <elver@google.com>
Date: Tue, 19 Dec 2023 22:21:25 +0100
Message-ID: <CANpmjNMAL0FRdewOfEpTZWBTLquJ_k0L4QdCd_Uau6ewg2hAxQ@mail.gmail.com>
Subject: Re: [PATCH v3 mm 2/4] kasan: handle concurrent kasan_record_aux_stack calls
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>, 
	syzbot+186b55175d8360728234@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 22:19, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> kasan_record_aux_stack can be called concurrently on the same object.
> This might lead to a race condition when rotating the saved aux stack
> trace handles, which in turns leads to incorrect accounting of stack
> depot handles and refcount underflows in the stack depot code.
>
> Fix by introducing a raw spinlock to protect the aux stack trace handles
> in kasan_record_aux_stack.
>
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Reported-by: syzbot+186b55175d8360728234@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000784b1c060b0074a2@google.com/
> Fixes: 773688a6cb24 ("kasan: use stack_depot_put for Generic mode")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>
> Changes v2->v3:
> - Use raw spinlock to avoid lockdep complaints on RT kernels.
>
> Changes v1->v2:
> - Use per-object spinlock instead of a global one.
> ---
>  mm/kasan/generic.c | 32 +++++++++++++++++++++++++++++---
>  mm/kasan/kasan.h   |  8 ++++++++
>  2 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 54e20b2bc3e1..55e6b5db2cae 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -25,6 +25,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>  #include <linux/stackdepot.h>
>  #include <linux/stacktrace.h>
>  #include <linux/string.h>
> @@ -471,8 +472,18 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
>         struct kasan_free_meta *free_meta;
>
>         alloc_meta = kasan_get_alloc_meta(cache, object);
> -       if (alloc_meta)
> +       if (alloc_meta) {
>                 __memset(alloc_meta, 0, sizeof(*alloc_meta));
> +
> +               /*
> +                * Temporarily disable KASAN bug reporting to allow instrumented
> +                * raw_spin_lock_init to access aux_lock, which resides inside
> +                * of a redzone.
> +                */
> +               kasan_disable_current();
> +               raw_spin_lock_init(&alloc_meta->aux_lock);
> +               kasan_enable_current();
> +       }
>         free_meta = kasan_get_free_meta(cache, object);
>         if (free_meta)
>                 __memset(free_meta, 0, sizeof(*free_meta));
> @@ -502,6 +513,8 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
>         struct kmem_cache *cache;
>         struct kasan_alloc_meta *alloc_meta;
>         void *object;
> +       depot_stack_handle_t new_handle, old_handle;
> +       unsigned long flags;
>
>         if (is_kfence_address(addr) || !slab)
>                 return;
> @@ -512,9 +525,22 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
>         if (!alloc_meta)
>                 return;
>
> -       stack_depot_put(alloc_meta->aux_stack[1]);
> +       new_handle = kasan_save_stack(0, depot_flags);
> +
> +       /*
> +        * Temporarily disable KASAN bug reporting to allow instrumented
> +        * spinlock functions to access aux_lock, which resides inside of a
> +        * redzone.
> +        */
> +       kasan_disable_current();
> +       raw_spin_lock_irqsave(&alloc_meta->aux_lock, flags);
> +       old_handle = alloc_meta->aux_stack[1];
>         alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
> -       alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
> +       alloc_meta->aux_stack[0] = new_handle;
> +       raw_spin_unlock_irqrestore(&alloc_meta->aux_lock, flags);
> +       kasan_enable_current();
> +
> +       stack_depot_put(old_handle);
>  }
>
>  void kasan_record_aux_stack(void *addr)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 5e298e3ac909..69e4f5e58e33 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -6,6 +6,7 @@
>  #include <linux/kasan.h>
>  #include <linux/kasan-tags.h>
>  #include <linux/kfence.h>
> +#include <linux/spinlock.h>
>  #include <linux/stackdepot.h>
>
>  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> @@ -249,6 +250,13 @@ struct kasan_global {
>  struct kasan_alloc_meta {
>         struct kasan_track alloc_track;
>         /* Free track is stored in kasan_free_meta. */
> +       /*
> +        * aux_lock protects aux_stack from accesses from concurrent
> +        * kasan_record_aux_stack calls. It is a raw spinlock to avoid sleeping
> +        * on RT kernels, as kasan_record_aux_stack_noalloc can be called from
> +        * non-sleepable contexts.
> +        */
> +       raw_spinlock_t aux_lock;
>         depot_stack_handle_t aux_stack[2];
>  };
>
> --
> 2.25.1
>

