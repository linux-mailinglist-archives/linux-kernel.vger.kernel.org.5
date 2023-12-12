Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAE980F6AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjLLT3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjLLT3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:29:11 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2796C9F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:29:17 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7c47dd348f2so1418134241.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702409356; x=1703014156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+rCbqARyeZId11kuEaXWxOwQK5N8S8sXeciQALfHIFM=;
        b=rK64VIrRYw/aNuCoY/RiVwJEVO96rUFzRdWCHXJ16kvyoYxbSxKV+upsIWD4rmAKUa
         8NzzHJNP4p5st29P15N0L2jECX0xuoH3k3vyGzQKf/W+VuF6aLB5zAyFdbnsobjU9WXQ
         PDjeWTGlVG9ii0cjbfcRnKB0//5K3RYbSV4XS7o1cuyLOSkZ7+9TwCdDyrPZrTvRgRet
         IjIoj0iVu8irZ14C6iEjQyab9WMJ4mJoqpECxfhdqYOUb6JhckMEaUC4zzJ4kaUTUful
         LP1YeOqDkwx5ZAGxx/2lmvZhCNr8E11gBp4qjbQ8Iyi8UohVy/v7+QMJpf7DpiTEpvvo
         oagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409356; x=1703014156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rCbqARyeZId11kuEaXWxOwQK5N8S8sXeciQALfHIFM=;
        b=FNvE8NNUmTYl8W49xhXJvJfmX5xUXn0vDL/FFQonjiCVlraQOnG3YvnzCtfCQYviJD
         nWddBPLu0ZVpbI4dTo6J6T1f18XCO1ykINTosZxyQZbOLuE0NHD6YN9XdDITdpN/pF5d
         2wevAg5mh6OrWBUIg6TBlVDmgH3Iiv0srzz6dTc607c+cIT/s5n7m9aMr8PvwVWFKzdK
         qOlsfbgdo3BO2NRuJ2rhhK+CvxP2w5hKshuUKHw+g30SyTRuPbEPVPRdjfNtyjenSoFs
         LgUmDOTYTqRJAstZToX7aVb7N/V25uRY7wzsc94q0n3uP+71LSF4AGRm/A1nhEzuTIyn
         y9+A==
X-Gm-Message-State: AOJu0Yzk2rsKCBjKNHmgQFCs7inJmyo7BNdhYnu9Xp6YwB4odvwAijqK
        HS/n4Rgwia816sAjGZH3c4SfpGXW8T0mHvJw5YKOEw==
X-Google-Smtp-Source: AGHT+IE2Gq+T080mI4W9k254GYp8ITOPgtjAZhh3RmjHvRQ2ZF9QpqQNSfW7Nkl4sinuKbhhMM63IsxN2Dmr8+nPclo=
X-Received: by 2002:a05:6102:3752:b0:464:3cdb:856c with SMTP id
 u18-20020a056102375200b004643cdb856cmr5344796vst.9.1702409356064; Tue, 12 Dec
 2023 11:29:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1702339432.git.andreyknvl@google.com> <432a89fafce11244287c8af757e73a2eb22a5354.1702339432.git.andreyknvl@google.com>
In-Reply-To: <432a89fafce11244287c8af757e73a2eb22a5354.1702339432.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Dec 2023 20:28:37 +0100
Message-ID: <CANpmjNM9Kq9C4f9AMYE9U3JrqofbsrC7cmrP28ZP4ep1CZTWaA@mail.gmail.com>
Subject: Re: [PATCH mm 2/4] kasan: handle concurrent kasan_record_aux_stack calls
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 01:14, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> kasan_record_aux_stack can be called concurrently on the same object.
> This might lead to a race condition when rotating the saved aux stack
> trace handles.
>
> Fix by introducing a spinlock to protect the aux stack trace handles
> in kasan_record_aux_stack.
>
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Reported-by: syzbot+186b55175d8360728234@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000784b1c060b0074a2@google.com/
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> This can be squashed into "kasan: use stack_depot_put for Generic mode"
> or left standalone.
> ---
>  mm/kasan/generic.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 54e20b2bc3e1..ca5c75a1866c 100644
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
> @@ -35,6 +36,8 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> +DEFINE_SPINLOCK(aux_lock);

No, please don't.

>  /*
>   * All functions below always inlined so compiler could
>   * perform better optimizations in each of __asan_loadX/__assn_storeX
> @@ -502,6 +505,8 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
>         struct kmem_cache *cache;
>         struct kasan_alloc_meta *alloc_meta;
>         void *object;
> +       depot_stack_handle_t new_handle, old_handle;
> +       unsigned long flags;
>
>         if (is_kfence_address(addr) || !slab)
>                 return;
> @@ -512,9 +517,15 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
>         if (!alloc_meta)
>                 return;
>
> -       stack_depot_put(alloc_meta->aux_stack[1]);
> +       new_handle = kasan_save_stack(0, depot_flags);
> +
> +       spin_lock_irqsave(&aux_lock, flags);

This is a unnecessary global lock. What's the problem here? As far as
I can understand a race is possible where we may end up with
duplicated or lost stack handles.

Since storing this information is best effort anyway, and bugs are
rare, a global lock protecting this is overkill.

I'd just accept the racyness and use READ_ONCE() / WRITE_ONCE() just
to make sure we don't tear any reads/writes and the depot handles are
valid. There are other more complex schemes [1], but I think they are
overkill as well.

[1]: Since a depot stack handle is just an u32, we can have a

 union {
   depot_stack_handle_t handles[2];
   atomic64_t atomic_handle;
  } aux_stack;
(BUILD_BUG_ON somewhere if sizeof handles and atomic_handle mismatch.)

Then in the code here create the same union and load atomic_handle.
Swap handle[1] into handle[0] and write the new one in handles[1].
Then do a cmpxchg loop to store the new atomic_handle.

> +       old_handle = alloc_meta->aux_stack[1];
>         alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
> -       alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
> +       alloc_meta->aux_stack[0] = new_handle;
> +       spin_unlock_irqrestore(&aux_lock, flags);
> +
> +       stack_depot_put(old_handle);
>  }
>
>  void kasan_record_aux_stack(void *addr)
> --
> 2.25.1
>
