Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6B77A19D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjIOI7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjIOI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:59:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DC73A92
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:56:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-404773f2501so10754505e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694768186; x=1695372986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BYq8Jh7JCWPHoRmWNIAaNE/xDHzvR7ZVrfUseotBNcQ=;
        b=S1hgihVF3JBK++hGlWw0SGfcpf0mFDpjflu91XBiJyfrLxemIhxHg+PiYAMT2oC0K0
         IaHJN9/xdBpek/uX67FnwBp5nCkNMlU1Vwkn8Tr/bjwaONiIPQ7T0NKw3yZEmEbQUKjT
         4VePX5zzg9p818knI/p5i4CoVQOkQhH7tvi+N6ygrE20Zwr6g8V1XLbVtXERb/4mmiP2
         oBIWZBwfCeAzIv2tuPzIASVxehrEWmjlzPtevfEJhZItXkMdRK6vuh+vpneomguDCI59
         9FW4Ch9hOEnmgusqvWppo6SFIFLYTQAV/jTR4pWndQ0xi3/78N9VZltR9AkoOvgDofYJ
         FPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694768186; x=1695372986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYq8Jh7JCWPHoRmWNIAaNE/xDHzvR7ZVrfUseotBNcQ=;
        b=EostqdNwSz1hMz3BPd2SHRmhjcTM+DffBUsZ30SwR1QecSEDoRhqI9aojlmnWP8hvO
         KT9Q6p/uY6VbXHQXSIdwrWVesJ7AW5uFhZalTpMjMADUAEo9I7enWbkYh3Xw5G8rdumJ
         dWDYmF7WYj6vEyVnrj/4+nBTtAHpAj8knFNlI4NzTrANeaK1dUpDqgZZ0gGcVnzLVn+H
         2TcvDb6qrDzxLWlzYDQdHrVtT4FLsm87USMjMkkf5Uq8HG6/BZJEMsSlRsNcQPxC5agq
         vHxiC6AoEEXWsdkVUkUjhlgieTRQnaGaqkBVBAwJr8at/SsfYhpohm0M5bpCoeelcj8j
         V1jw==
X-Gm-Message-State: AOJu0YxZo9ePaYTqOQQd0DMqndgjds1viungGWoX5KpwAOJfIbDs2FXy
        RAZVMzRRdexgltxNjkshbQA5pRWjXxzoY28RzHeYrA==
X-Google-Smtp-Source: AGHT+IGbfpMkKPbUanIk3MYDbQUP2Ou7ijo8dtheffnqw8FJQZjnwqfkkUu4a0i6bQ1W7s9Ku25jxkWhIJC7hOWss8Y=
X-Received: by 2002:a1c:6a0e:0:b0:402:f536:41c5 with SMTP id
 f14-20020a1c6a0e000000b00402f53641c5mr1263710wmc.3.1694768186136; Fri, 15 Sep
 2023 01:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <658f5f34d4f94721844ad8ba41452d54b4f8ace5.1694625260.git.andreyknvl@google.com>
In-Reply-To: <658f5f34d4f94721844ad8ba41452d54b4f8ace5.1694625260.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 15 Sep 2023 10:55:47 +0200
Message-ID: <CANpmjNP8O-GLQ9m06riX+kjbPSD9sBo+XGtTE2xW=pq9uJFGAg@mail.gmail.com>
Subject: Re: [PATCH v2 05/19] lib/stackdepot: use fixed-sized slots for stack records
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sept 2023 at 19:14, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Instead of storing stack records in stack depot pools one right after
> another, use fixed-sized slots.
>
> Add a new Kconfig option STACKDEPOT_MAX_FRAMES that allows to select
> the size of the slot in frames. Use 64 as the default value, which is
> the maximum stack trace size both KASAN and KMSAN use right now.
>
> Also add descriptions for other stack depot Kconfig options.
>
> This is preparatory patch for implementing the eviction of stack records
> from the stack depot.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> Changes v1->v2:
> - Add and use STACKDEPOT_MAX_FRAMES Kconfig option.
> ---
>  lib/Kconfig      | 10 ++++++++--
>  lib/stackdepot.c | 13 +++++++++----
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index c686f4adc124..7c32f424a6f3 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -708,13 +708,19 @@ config ARCH_STACKWALK
>         bool
>
>  config STACKDEPOT
> -       bool
> +       bool "Stack depot: stack trace storage that avoids duplication"
>         select STACKTRACE
>
>  config STACKDEPOT_ALWAYS_INIT
> -       bool
> +       bool "Always initialize stack depot during early boot"
>         select STACKDEPOT

This makes both STACKDEPOT and STACKDEPOT_ALWAYS_INIT configurable by
users: https://www.kernel.org/doc/html/next/kbuild/kconfig-language.html#menu-attributes

Usually the way to add documentation for non-user-configurable options
is to add text in the "help" section of the config.

I think the change here is not what was intended.

> +config STACKDEPOT_MAX_FRAMES
> +       int "Maximum number of frames in trace saved in stack depot"
> +       range 1 256
> +       default 64
> +       depends on STACKDEPOT
> +
>  config REF_TRACKER
>         bool
>         depends on STACKTRACE_SUPPORT
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 9a004f15f59d..128ece21afe9 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -58,9 +58,12 @@ struct stack_record {
>         u32 hash;                       /* Hash in the hash table */
>         u32 size;                       /* Number of stored frames */
>         union handle_parts handle;
> -       unsigned long entries[];        /* Variable-sized array of frames */
> +       unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];    /* Frames */
>  };
>
> +#define DEPOT_STACK_RECORD_SIZE \
> +       ALIGN(sizeof(struct stack_record), 1 << DEPOT_STACK_ALIGN)
> +
>  static bool stack_depot_disabled;
>  static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
>  static bool __stack_depot_early_init_passed __initdata;
> @@ -258,9 +261,7 @@ static struct stack_record *
>  depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>  {
>         struct stack_record *stack;
> -       size_t required_size = struct_size(stack, entries, size);
> -
> -       required_size = ALIGN(required_size, 1 << DEPOT_STACK_ALIGN);
> +       size_t required_size = DEPOT_STACK_RECORD_SIZE;
>
>         /* Check if there is not enough space in the current pool. */
>         if (unlikely(pool_offset + required_size > DEPOT_POOL_SIZE)) {
> @@ -295,6 +296,10 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>         if (stack_pools[pool_index] == NULL)
>                 return NULL;
>
> +       /* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. */
> +       if (size > CONFIG_STACKDEPOT_MAX_FRAMES)
> +               size = CONFIG_STACKDEPOT_MAX_FRAMES;
> +
>         /* Save the stack trace. */
>         stack = stack_pools[pool_index] + pool_offset;
>         stack->hash = hash;
> --
> 2.25.1
>
