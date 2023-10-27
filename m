Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2637D9900
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjJ0Myj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0Myi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:54:38 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DF410E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:54:35 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-45853ab5556so904536137.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698411275; x=1699016075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DwNfFFS57QhT5eEqPbXTCH8wXRCZS40xeP0h1OwCxS4=;
        b=tv1vLeGnXlb957cOI6Et6F+jXA08XWVBnR+R4+w7VdFHcj2pjUaoFlYLMrbyfe/hdt
         ElG8Esn522M/ft4KKqBmexhM1x1jbYC/zmR1DFwJ2MQxvZTcsrkPkiB/NI/pLTQFsCL7
         4BFLe4zvvorKhv3Ql5ty1u3trEyR6XL04ckqk+6S5WmBIiJUBWNsyAcHNae3++W2f6uM
         WWxqGxFuTdCONHYQ144ebauRzwDnNo8ne3YR3QFNgLybo1IjJYS+V1xdPG4MNk8BP7M0
         1eNeaM2Do+04QpVRbrPe1VBBdETlaxh148xsAQyFXoDn85AJR1CwII4XJY9CqlNC2a24
         RyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698411275; x=1699016075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwNfFFS57QhT5eEqPbXTCH8wXRCZS40xeP0h1OwCxS4=;
        b=vy/a1rbqe083GicMUG+0NnTL/eF3gijxyhHvUq4XbCf2mEZ+NHjLM/P8p3aVmN0pOM
         t6ZZE10/j7NBokHY6lfzR5nAkUCIdwqdBb+65Xvvfl3nOmMTI5nTZp7Tj2vQDtPYgn7I
         /WSYQzTHNX2MJAxXH2PZa0ooC+2yint/04MYuu+Lij1ZChyI6QmX0d9gdqvPxWa2JUD6
         lJYwEHeR6Qv8ssg7mv/nhOQomJp0Y3nvsXhV5EFrWDwL+nxcAHI14qzpQYtbm0oxIjQ1
         mcsUxkqXkqGm4CAdvLxzwd0CZ5vgmJlwizbkKiPAxptMTeg6hUESE8dO34AnJ89EhdX4
         tbTQ==
X-Gm-Message-State: AOJu0Yz+1mkjcWR5MJYoCmvN63rtlcLpAZ2ofpm/zp1ctZu+HAqNEE+Q
        0PH6yiZ1wZSGVcYkcd9eTLyLavlGD9Qr1wox7g6jRgXk7DCxr5jezL4LnQ==
X-Google-Smtp-Source: AGHT+IFJW/N/eTG3DhZ2NqbTWczs0MEgD82mmIOFNMTB4e/tuhe2d1asQ4lqR6etCsZ9wnurBGLX9/VoLXj72BpBH6Y=
X-Received: by 2002:a67:c105:0:b0:44d:4a41:893f with SMTP id
 d5-20020a67c105000000b0044d4a41893fmr2921932vsj.9.1698411274739; Fri, 27 Oct
 2023 05:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <e237a31ef7ca6213c46f87e4609bd7d3eb48fedf.1698351974.git.andreyknvl@google.com>
In-Reply-To: <e237a31ef7ca6213c46f87e4609bd7d3eb48fedf.1698351974.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 27 Oct 2023 14:53:57 +0200
Message-ID: <CANpmjNOrKpkV3aEPsTZSuL6Nb7R5NyiBh84xkbxM-802nzDtBg@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib/stackdepot: print disabled message only if truly disabled
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
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

On Thu, 26 Oct 2023 at 22:28, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Currently, if stack_depot_disable=off is passed to the kernel
> command-line after stack_depot_disable=on, stack depot prints a message
> that it is disabled, while it is actually enabled.
>
> Fix this by moving printing the disabled message to
> stack_depot_early_init. Place it before the
> __stack_depot_early_init_requested check, so that the message is printed
> even if early stack depot init has not been requested.
>
> Also drop the stack_table = NULL assignment from disable_stack_depot,
> as stack_table is NULL by default.
>
> Fixes: e1fdc403349c ("lib: stackdepot: add support to disable stack depot")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

for the change here, but there's a way to make it simpler (see below).

> ---
>  lib/stackdepot.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 2f5aa851834e..0eeaef4f2523 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -101,14 +101,7 @@ static int next_pool_required = 1;
>
>  static int __init disable_stack_depot(char *str)
>  {
> -       int ret;
> -
> -       ret = kstrtobool(str, &stack_depot_disabled);
> -       if (!ret && stack_depot_disabled) {
> -               pr_info("disabled\n");
> -               stack_table = NULL;
> -       }
> -       return 0;
> +       return kstrtobool(str, &stack_depot_disabled);
>  }
>  early_param("stack_depot_disable", disable_stack_depot);
>
> @@ -130,6 +123,15 @@ int __init stack_depot_early_init(void)
>                 return 0;
>         __stack_depot_early_init_passed = true;
>
> +       /*
> +        * Print disabled message even if early init has not been requested:
> +        * stack_depot_init() will not print one.
> +        */
> +       if (stack_depot_disabled) {
> +               pr_info("disabled\n");
> +               return 0;
> +       }
> +
>         /*
>          * If KASAN is enabled, use the maximum order: KASAN is frequently used
>          * in fuzzing scenarios, which leads to a large number of different
> @@ -138,7 +140,11 @@ int __init stack_depot_early_init(void)
>         if (kasan_enabled() && !stack_bucket_number_order)
>                 stack_bucket_number_order = STACK_BUCKET_NUMBER_ORDER_MAX;

stack_bucket_number_order seems like a redundant variable, that should
at least be __ro_after_init. All code that does "if
(stack_bucket_number_order) ..." could just do "if (kasan_enabled())
..." and use STACK_BUCKET_NUMBER_ORDER_MAX constant directly instead.

The code here could be simplified if it was removed. No idea why it
was introduced in the first place. I think f9987921cb541 introduced it
and there it said "complemented with a boot-time kernel parameter",
but that never happened.

So I'd be in favor of removing that variable, which will also simplify
this code.
