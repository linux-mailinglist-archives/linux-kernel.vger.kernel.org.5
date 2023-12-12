Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3462480F5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376939AbjLLTAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376732AbjLLTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:00:02 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3705DE3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:00:08 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-4b2c0ba26f1so3412857e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702407607; x=1703012407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PUFl67MNvz50LEEW65eGueVacBRt36aAKgnhCxXMoqo=;
        b=f787ME0TYjObhj+FBeqSwTVofC+oliM0hTzmnOYlN2jMh4zwvmcnIhPUkcCykpS0ua
         bPKRGxVTg0IrhG6HNULF4ETKu4sGVpZ8gWGMZepM9FTssjdo12zcHgwBK96QBd5+tUqO
         YOuZz0cprlncyTBNfKQTO2crifYOOunrSclLXb1VxJX8hqhLwYJ4Q/p58jRNXir6TU8L
         91CE6j7q+UhkffAANFaqvvAMiVrdEBm8lKBLAbHPK8PUt8q0zOiocpJqzsEgBez6arIk
         SICqoITaK1PYqLBGFgjxfipO0zNQ3NI6e33MeTC5WH7IaIOkuKpZ3n8Ajy2nkZiNYbbR
         ykgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702407607; x=1703012407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUFl67MNvz50LEEW65eGueVacBRt36aAKgnhCxXMoqo=;
        b=jg4nPxm2HyQss53Qmei/YjmV9bnxyTQBZIKoClvyq873rtRlWsFKUT1Y34YDVhfZ+L
         OKuo7PlryxCKjCxs/JuGrCPCYPcHhVhsA2ho05z1hRCIG/eB8XkjzDvM0jYCe7uAKT/J
         zAKCiHtw1bFA/vkcLd4mAt/TGzsJbgr6NxtMZBpcWT0P/Vf7FMJPST3JodwJg5Q/d8Sh
         zY7YpnueuNWb568yUYgjH42qStT9fVqhylPH/dLoJzph+2vmwlHt7Dt2OMCId3QH9oSt
         aI2QdZr966FFUo0yIbNHj6n/sZ0f8QdXPp7hx1V4HeEkabN2TJedxo/a9ZCb3NMzxEdw
         JnBQ==
X-Gm-Message-State: AOJu0YyWdfPSkfz6HGhxmHWtSuHYIBBuyiRV6AF5taZIv+24IHA1HOHz
        C55x4I24Gr85yBTSAplHWwfNJ/4W2sEL0KypsykYcw==
X-Google-Smtp-Source: AGHT+IFwfFUD5xDW+nellxT/wG8zZ3XYuOklQ97v3lghqt/znfv3lvokSkHIfLKDJCHHwN/Mo75efcUAVXZwbMmfm/s=
X-Received: by 2002:a05:6122:4b:b0:48d:5be:2868 with SMTP id
 q11-20020a056122004b00b0048d05be2868mr5216760vkn.0.1702407607079; Tue, 12 Dec
 2023 11:00:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1702339432.git.andreyknvl@google.com> <6c38c31e304a55449f76f60b6f72e35f992cad99.1702339432.git.andreyknvl@google.com>
In-Reply-To: <6c38c31e304a55449f76f60b6f72e35f992cad99.1702339432.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Dec 2023 19:59:29 +0100
Message-ID: <CANpmjNNXiRxwTk4wGHL3pXmXo5YUY=VNLCf+g+kB6inXJnC2YA@mail.gmail.com>
Subject: Re: [PATCH mm 1/4] lib/stackdepot: add printk_deferred_enter/exit guards
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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
> Stack depot functions can be called from various contexts that do
> allocations, including with console locks taken. At the same time, stack
> depot functions might print WARNING's or refcount-related failures.
>
> This can cause a deadlock on console locks.
>
> Add printk_deferred_enter/exit guards to stack depot to avoid this.
>
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Closes: https://lore.kernel.org/all/000000000000f56750060b9ad216@google.com/
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Doesn't need Fixes, because the series is not yet in mainline, right?

> ---
>  lib/stackdepot.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 870cce2f4cbd..a0be5d05c7f0 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -506,12 +506,14 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
>         bucket = &stack_table[hash & stack_hash_mask];
>
>         read_lock_irqsave(&pool_rwlock, flags);
> +       printk_deferred_enter();
>
>         /* Fast path: look the stack trace up without full locking. */
>         found = find_stack(bucket, entries, nr_entries, hash);
>         if (found) {
>                 if (depot_flags & STACK_DEPOT_FLAG_GET)
>                         refcount_inc(&found->count);
> +               printk_deferred_exit();
>                 read_unlock_irqrestore(&pool_rwlock, flags);
>                 goto exit;
>         }
> @@ -520,6 +522,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
>         if (new_pool_required)
>                 need_alloc = true;
>
> +       printk_deferred_exit();
>         read_unlock_irqrestore(&pool_rwlock, flags);
>
>         /*
> @@ -541,6 +544,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
>         }
>
>         write_lock_irqsave(&pool_rwlock, flags);
> +       printk_deferred_enter();
>
>         found = find_stack(bucket, entries, nr_entries, hash);
>         if (!found) {
> @@ -562,6 +566,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
>                         depot_keep_new_pool(&prealloc);
>         }
>
> +       printk_deferred_exit();
>         write_unlock_irqrestore(&pool_rwlock, flags);
>  exit:
>         if (prealloc) {
> @@ -600,9 +605,11 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>                 return 0;
>
>         read_lock_irqsave(&pool_rwlock, flags);
> +       printk_deferred_enter();
>
>         stack = depot_fetch_stack(handle);
>
> +       printk_deferred_exit();
>         read_unlock_irqrestore(&pool_rwlock, flags);
>
>         *entries = stack->entries;
> @@ -619,6 +626,7 @@ void stack_depot_put(depot_stack_handle_t handle)
>                 return;
>
>         write_lock_irqsave(&pool_rwlock, flags);
> +       printk_deferred_enter();
>
>         stack = depot_fetch_stack(handle);
>         if (WARN_ON(!stack))
> @@ -633,6 +641,7 @@ void stack_depot_put(depot_stack_handle_t handle)
>         }
>
>  out:
> +       printk_deferred_exit();
>         write_unlock_irqrestore(&pool_rwlock, flags);
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_put);
> --
> 2.25.1
>
