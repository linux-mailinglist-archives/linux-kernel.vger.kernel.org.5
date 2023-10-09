Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C57BD863
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345575AbjJIKTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345536AbjJIIn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:43:58 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3FFE4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:43:55 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7b2ca45d5cfso1713649241.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696841035; x=1697445835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YuCgwwEHpzwhAs2/TQufmyBSZG1iz25UrBV2AHFZCKg=;
        b=IRcfAvXbq24V5KADR048bUkbkiZU1mEF9sS6YiXhpOyXJPydmMOHGD+KbQF+7AX5Rz
         8jfyDJhsfHbVwshRDR2l+rmiPSKXCeTCPvQBgFc98DEptalNmxDLBhj6ecOaXHZSstz0
         n6ZY8KUT7n2sa/SzWzXYA+JQThIkUrWi4nzSsPBU2z+HmRHxRJNwRxT1SWFm1ivmQ+G1
         xOv3eBSPPEm6LGVwzgcK2IuZfgs6tpkrK6ksKNzj0fZXDjkMTaicPvLRdwQwfih2PwU1
         oHzp/HqGutaXAc2GLaDAHdkfblHKa9Wam4ZBQ0+njtL2w7IHeBBQF0To3nO+0YQgmSOP
         Ufvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841035; x=1697445835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuCgwwEHpzwhAs2/TQufmyBSZG1iz25UrBV2AHFZCKg=;
        b=A4NT7iYIJCOkkTUIIA1Rwpa0Fi5xgsMXfTeTLkiClPlxyBO9AyxfRgwbelWnCDLkTX
         UrDmV4RJOW8JSmJ3EqL2zzcMasGsS2FKc/2pqwPex0O7wfANamSY5yxAdLhVlWwd9TQf
         iOckz0oClT5/DN/ksSd3ZrcdfoMq+q0Q0aqY+Vv9VrdagBqHoehyIGcp+r02rAiO5NYT
         rh1ht9m6bTpko1UryRtBJaA4xG2dx8sS5j91PCCK102MQ/1kHeMqqvguEIw2Lq9mRLqX
         RLB4Lnq4zmZ4IH5+gV89zJAZ96BeVeIz7eN+8g8V4WA1GVHNSYfbCwoiBLj94yARofYZ
         5q/g==
X-Gm-Message-State: AOJu0YzaVdelEXunhbSV4ARizbAvoqABpWU4kYHnKXCoa5tGkRrLZhEa
        HuRY/DpwOhDBFY0Xctp1YfVMsZaJx6VGAibqqvYA1Q==
X-Google-Smtp-Source: AGHT+IHM7SP0zXEDBJvuPJxJH+KCedulcWHo9b2X9XUybVvm+FLB8ZQG9IZy91mYRfD3JgNwE/1zaT/d/VOUk3UI2Rc=
X-Received: by 2002:a05:6102:8c:b0:44d:453c:a838 with SMTP id
 t12-20020a056102008c00b0044d453ca838mr10464598vsp.5.1696841034758; Mon, 09
 Oct 2023 01:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696605143.git.andreyknvl@google.com> <35589629806cf0840e5f01ec9d8011a7bad648df.1696605143.git.andreyknvl@google.com>
In-Reply-To: <35589629806cf0840e5f01ec9d8011a7bad648df.1696605143.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 9 Oct 2023 10:43:18 +0200
Message-ID: <CANpmjNOWirLmtSrNOOfs8Lm0c+uUkfdh0Zf5OcmDfdfNk2W2dg@mail.gmail.com>
Subject: Re: [PATCH 2/5] kasan: unify printk prefixes
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
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

On Fri, 6 Oct 2023 at 17:18, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Unify prefixes for printk messages in mm/kasan/.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/kasan_test.c        | 2 +-
>  mm/kasan/kasan_test_module.c | 2 +-
>  mm/kasan/quarantine.c        | 4 +++-
>  mm/kasan/report_generic.c    | 6 +++---
>  4 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index b61cc6a42541..c707d6c6e019 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -5,7 +5,7 @@
>   * Author: Andrey Ryabinin <a.ryabinin@samsung.com>
>   */
>
> -#define pr_fmt(fmt) "kasan_test: " fmt
> +#define pr_fmt(fmt) "kasan: test: " fmt
>
>  #include <kunit/test.h>
>  #include <linux/bitops.h>
> diff --git a/mm/kasan/kasan_test_module.c b/mm/kasan/kasan_test_module.c
> index 7be7bed456ef..8b7b3ea2c74e 100644
> --- a/mm/kasan/kasan_test_module.c
> +++ b/mm/kasan/kasan_test_module.c
> @@ -5,7 +5,7 @@
>   * Author: Andrey Ryabinin <a.ryabinin@samsung.com>
>   */
>
> -#define pr_fmt(fmt) "kasan test: %s " fmt, __func__
> +#define pr_fmt(fmt) "kasan: test: " fmt
>
>  #include <linux/mman.h>
>  #include <linux/module.h>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 152dca73f398..ca4529156735 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -8,6 +8,8 @@
>   * Based on code by Dmitry Chernenkov.
>   */
>
> +#define pr_fmt(fmt) "kasan: " fmt
> +
>  #include <linux/gfp.h>
>  #include <linux/hash.h>
>  #include <linux/kernel.h>
> @@ -414,7 +416,7 @@ static int __init kasan_cpu_quarantine_init(void)
>         ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mm/kasan:online",
>                                 kasan_cpu_online, kasan_cpu_offline);
>         if (ret < 0)
> -               pr_err("kasan cpu quarantine register failed [%d]\n", ret);
> +               pr_err("cpu quarantine register failed [%d]\n", ret);
>         return ret;
>  }
>  late_initcall(kasan_cpu_quarantine_init);
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index 51a1e8a8877f..99cbcd73cff7 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -220,7 +220,7 @@ static bool __must_check tokenize_frame_descr(const char **frame_descr,
>                 const size_t tok_len = sep - *frame_descr;
>
>                 if (tok_len + 1 > max_tok_len) {
> -                       pr_err("KASAN internal error: frame description too long: %s\n",
> +                       pr_err("internal error: frame description too long: %s\n",
>                                *frame_descr);
>                         return false;
>                 }
> @@ -233,7 +233,7 @@ static bool __must_check tokenize_frame_descr(const char **frame_descr,
>         *frame_descr = sep + 1;
>
>         if (value != NULL && kstrtoul(token, 10, value)) {
> -               pr_err("KASAN internal error: not a valid number: %s\n", token);
> +               pr_err("internal error: not a valid number: %s\n", token);
>                 return false;
>         }
>
> @@ -323,7 +323,7 @@ static bool __must_check get_address_stack_frame_info(const void *addr,
>
>         frame = (const unsigned long *)(mem_ptr + KASAN_GRANULE_SIZE);
>         if (frame[0] != KASAN_CURRENT_STACK_FRAME_MAGIC) {
> -               pr_err("KASAN internal error: frame info validation failed; invalid marker: %lu\n",
> +               pr_err("internal error: frame has invalid marker: %lu\n",
>                        frame[0]);
>                 return false;
>         }
> --
> 2.25.1
>
