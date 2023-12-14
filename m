Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C72812A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjLNIf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjLNIf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:35:26 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BA6E8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:35:32 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7c59ac49f12so217767241.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702542932; x=1703147732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=59EvNi4lROlx/uAEwIQ9N8BChY4yKEZ29O9hKyzJ3t8=;
        b=2912TzNY5qwbCH05wZsAKTMaKQr7rcoq5MyFnHbF2+TraaPe3xLcLt+wN1p80mNdnf
         Xkk2KX2zRVyS3iRCaXEUm8WiYa44DYHNUcwzzyKOFOuLk+HDMu6nTTZdfChTi4qmlBF2
         eNNFO8BeL4PVIijVE5BAvFsXDngxmqpHOTb0T94xmFsIrJaKUyi17lIyuMjuVA/f2/1m
         ZzPsrkzc7Cftrh3a0/SUFTA2BgAvA5eJXkONFEOLv/GbaRRpseo96WtGZvjxA9+1+GAg
         +GtZaG0CzBe3izfKD+BB0K30NYZp7pSUtjmtrDAjCB/V8wbZYtcGlwpazfndYUSpu3eK
         ZX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702542932; x=1703147732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59EvNi4lROlx/uAEwIQ9N8BChY4yKEZ29O9hKyzJ3t8=;
        b=QYRKHsaZ6TKNXrdJCHXStl63z1D2iQscyWVq3qXRGIyaISYrWGz9ghkLKRdP+xVIHb
         KZjGDg3/AOkg9ppKR0PwAzOmNddM8uAsNI6SILFn7N6vtEnR9XNmCh/Tr+hsSarEpSm5
         J0oQqwg8bOS9B0FHGBPFy2/F5rknE8rfeICI4sF853hNg0jAIPmZiLWEVJvGKFcNSeO6
         FNkl4QWyjYnx9AVuMaMSTVEt2+diMf6PE01XOcM/n/ubA0Hog8uFx4UA2KbzLbpmyr/p
         o262ZCu1x27PkeQcRVVeoQUU0VKX3qC8Zq9WdhQNHB9i9hLcovbWI5hWFgBwIpLFUr6T
         +itQ==
X-Gm-Message-State: AOJu0YyT71dGB1mCbBvhX5A6nmgh46pa+TPnAGtb2ZuOdQv3pWoKW4uh
        Q6g3hIvBdQNb92DL0hNFwVrlUATst8gZdYDVf8RwUQ==
X-Google-Smtp-Source: AGHT+IFjHIPGCGlzsnBtrnOvnWM1vx11pK89D8pyXHZ2WDEvqPofbyINSZK0oI29bXPM4O6KOZniRHiu5ZdLnpJuIK8=
X-Received: by 2002:a05:6102:e0e:b0:466:25f:f281 with SMTP id
 o14-20020a0561020e0e00b00466025ff281mr8702541vst.6.1702542931628; Thu, 14 Dec
 2023 00:35:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1702514411.git.andreyknvl@google.com> <88fc85e2a8cca03f2bfcae76100d1a3d54eac840.1702514411.git.andreyknvl@google.com>
In-Reply-To: <88fc85e2a8cca03f2bfcae76100d1a3d54eac840.1702514411.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 14 Dec 2023 09:34:53 +0100
Message-ID: <CANpmjNMNhPOBHr_5iyfP9Lo_tOUiG_bpVnS-RkfrP3JccW3yqg@mail.gmail.com>
Subject: Re: [PATCH -v2 mm 2/4] kasan: handle concurrent kasan_record_aux_stack
 calls
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        syzbot+186b55175d8360728234@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 at 01:48, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> kasan_record_aux_stack can be called concurrently on the same object.
> This might lead to a race condition when rotating the saved aux stack
> trace handles, which in turns leads to incorrect accounting of stack
> depot handles and refcount underflows in the stack depot code.
>
> Fix by introducing a spinlock to protect the aux stack trace handles
> in kasan_record_aux_stack.
>
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Reported-by: syzbot+186b55175d8360728234@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000784b1c060b0074a2@google.com/
> Fixes: 773688a6cb24 ("kasan: use stack_depot_put for Generic mode")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> Changes v1->v2:
> - Use per-object spinlock instead of a global one.
> ---
>  mm/kasan/generic.c | 32 +++++++++++++++++++++++++++++---
>  mm/kasan/kasan.h   |  2 ++
>  2 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 54e20b2bc3e1..b9d41d6c70fd 100644
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
> +                * spin_lock_init to access aux_lock, which resides inside of a
> +                * redzone.
> +                */
> +               kasan_disable_current();
> +               spin_lock_init(&alloc_meta->aux_lock);
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
> +       spin_lock_irqsave(&alloc_meta->aux_lock, flags);
> +       old_handle = alloc_meta->aux_stack[1];
>         alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
> -       alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
> +       alloc_meta->aux_stack[0] = new_handle;
> +       spin_unlock_irqrestore(&alloc_meta->aux_lock, flags);
> +       kasan_enable_current();
> +
> +       stack_depot_put(old_handle);
>  }
>
>  void kasan_record_aux_stack(void *addr)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 5e298e3ac909..8b4125fecdc7 100644
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
> @@ -249,6 +250,7 @@ struct kasan_global {
>  struct kasan_alloc_meta {
>         struct kasan_track alloc_track;
>         /* Free track is stored in kasan_free_meta. */
> +       spinlock_t aux_lock;

This needs to be raw_spinlock, because
kasan_record_aux_stack_noalloc() can be called from non-sleepable
contexts (otherwise lockdep will complain for RT kernels).
