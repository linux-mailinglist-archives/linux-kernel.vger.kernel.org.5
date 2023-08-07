Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5987719D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjHGGAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjHGGAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:00:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1279A10F6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 23:00:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso35033385e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 23:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691388014; x=1691992814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vBFHuRwuyk/hnPCEfjgfoHOKPA/ytrkp+MGxY8mmrKo=;
        b=ing8uEaEI6AyFRCS86oxZCzrhNFZrz8eWqmEwOAVETm0oEwqoMzRaZXtrUhyLmH3Ue
         g432XZJQAydL1L9hVsnpW3b/J1BEyU/z9K248mkSwpWkY1OTTS/k4ELkhyxrwu6vD65X
         f3ppPjIGcQq4lsq4p65kMnKCSLTsj24SMvEW06akzsasr1T2i6xPCOiV0vobRAon5XcF
         YAI1Ze+ANA8HZegTTarYMIwxlK2j3hTsPYgnSX3AFQ2Qo3TVh5tPWJDH2tA9MbW+eCnW
         7HtnLl43Ld40ka3QcPe+iqMI9sA79z4emvVMdYCsMhPKb7BQDMFRlTpL2oL4q7lFc71+
         kU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691388014; x=1691992814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBFHuRwuyk/hnPCEfjgfoHOKPA/ytrkp+MGxY8mmrKo=;
        b=NBgZ8xK9C0fV3U0WeqkPY0zv+QoWSRMdNy7jMXTVXbPRndAO9WlwWA6IdvgQxB5PEh
         gY1CKN/pHM9p6HijU5gs34o7evDC66G6dUB+oDmJE1hpqZzeXsLSmUTTVrq6x0Dn1xqH
         v/bkriaHdOmeUPjic6qMl3Zs0OgGff0S6F34ofkYDmrErwX9ylhhoMJeP1i7WKVDXX66
         5EF9V9HuxJzlLk95nQb3cEOVgVfCnndgscbozVTQC9EvU8PHZ2rV+zQwh8Vhy35AcjQ6
         Q8jg3ESGoXHCbelLpF+PKzXfOCYTk+ChWPLEEfFo550ijAbuca/CWRyAypOrUVvp6zrY
         QN2w==
X-Gm-Message-State: AOJu0YwbLumD+EHAd7PdixfBDtg2qCUjqhwtSIZAH/QSeS6vQqLyZyCs
        U/mzCimrHWbBHCVXRLrTmWUIUeJsU8DXt7GcfqUsMw==
X-Google-Smtp-Source: AGHT+IHDpKikMK162S/f6hlLKBlIolxb1nyfPLWImrljpKPeBJjZEK+kRSf/yDbSwFjsCHJRe15fR+4BgfkRl3Gf0qM=
X-Received: by 2002:a1c:ed03:0:b0:3fb:a102:6d7a with SMTP id
 l3-20020a1ced03000000b003fba1026d7amr4975049wmh.28.1691388014380; Sun, 06 Aug
 2023 23:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com> <20230805175027.50029-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230805175027.50029-4-andriy.shevchenko@linux.intel.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Aug 2023 08:00:00 +0200
Message-ID: <CANpmjNPN9JTc9WBSSPTCSmc2FphJ2FK7=x7wkwh3hv+X+E_C8A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lib/vsprintf: Declare no_hash_pointers in sprintf.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Sat, 5 Aug 2023 at 19:49, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Sparse is not happy to see non-static variable without declaration:
> lib/vsprintf.c:61:6: warning: symbol 'no_hash_pointers' was not declared. Should it be static?
>
> Declare respective variable in the sprintf.h. With this, add a comment
> to discourage its use if no real need.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Marco Elver <elver@google.com>

> ---
>  include/linux/sprintf.h | 2 ++
>  lib/test_printf.c       | 2 --
>  mm/kfence/report.c      | 3 +--
>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
> index 9ca23bcf9f42..33dcbec71925 100644
> --- a/include/linux/sprintf.h
> +++ b/include/linux/sprintf.h
> @@ -20,6 +20,8 @@ __printf(2, 0) const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list
>  __scanf(2, 3) int sscanf(const char *, const char *, ...);
>  __scanf(2, 0) int vsscanf(const char *, const char *, va_list);
>
> +/* These are for specific cases, do not use without real need */
> +extern bool no_hash_pointers;
>  int no_hash_pointers_enable(char *str);
>
>  #endif /* _LINUX_KERNEL_SPRINTF_H */
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 5adca19d34e2..cf861dc22169 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -39,8 +39,6 @@ KSTM_MODULE_GLOBALS();
>  static char *test_buffer __initdata;
>  static char *alloced_buffer __initdata;
>
> -extern bool no_hash_pointers;
> -
>  static int __printf(4, 0) __init
>  do_test(int bufsize, const char *expect, int elen,
>         const char *fmt, va_list ap)
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index 197430a5be4a..c509aed326ce 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -13,6 +13,7 @@
>  #include <linux/printk.h>
>  #include <linux/sched/debug.h>
>  #include <linux/seq_file.h>
> +#include <linux/sprintf.h>
>  #include <linux/stacktrace.h>
>  #include <linux/string.h>
>  #include <trace/events/error_report.h>
> @@ -26,8 +27,6 @@
>  #define ARCH_FUNC_PREFIX ""
>  #endif
>
> -extern bool no_hash_pointers;
> -
>  /* Helper function to either print to a seq_file or to console. */
>  __printf(2, 3)
>  static void seq_con_printf(struct seq_file *seq, const char *fmt, ...)
> --
> 2.40.0.1.gaa8946217a0b
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20230805175027.50029-4-andriy.shevchenko%40linux.intel.com.
