Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214BC76FC1A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjHDIjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjHDIjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:39:02 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EA1127
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:39:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe4b95c402so1233475e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691138340; x=1691743140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jQoJf42Fd/g+GKy4ubOkk+li/mbuiTLSPOgxMQ9ZBj4=;
        b=4wbtWBqYa9d46u042FMjLzzWiutHrAZHd+XdXgXZjL82Jn/OyVyM4qeu1rVnJxxYLO
         qgg+RpIX8KWR3ksW3YgJLxBdrzT4k0FfVYpETBhJ2htvevZnWgZ06vuGgKafDjY79pND
         g+eHyq/xOfGYqmAXRHGHQ7deki96r49afuzFDCtQo/1ar+sHkaEa8fozsFmfaQOL4sEZ
         hiob2uogFDqFrlApdRnCwtoGoN0+l/i4hBndBzTJvKPh0ivS4jzROganDwrCfRBJNZ7d
         iVuQc+baW0nn/4I6zEA9+IP8g1VdFjTN4P/kv12EbZNHByvSINTX8DRg46NCdKgk/EGw
         4Rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138340; x=1691743140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQoJf42Fd/g+GKy4ubOkk+li/mbuiTLSPOgxMQ9ZBj4=;
        b=B1e5EXXG5gARAOiYbpsQj4OhWW5HrG/Ahk1CR8AhwzFFJJ033Bi5oHE4faL2TfOK4c
         n0UpowhgZh+wg0jlOlTGZA6XhuPUsOcEGGmXrNdAv6qoxDEuE4TymxpfZGFMna4k78zg
         vdmxAbwQfispa7hZLDESM/OhEnF3RZyjSfIf5qzCtmYW0swZLrrU9ksxGchIqz86ttRw
         5WPyHeGIJ4iKLuW4MWrS9xx33LOPh/gBB7buqahWT6eV0hOv8LDwsx6ImDlg+5zpgbZ+
         YKT9HmjQLkHmbhz0QQqoKrCRvl/5pdvGUt06ooKhHY/7wjtdRmp4s2q542Wph1Lp2z9h
         sq8A==
X-Gm-Message-State: AOJu0YyHm7Hqbk+dVjm5GGrlfl6RD/z9yQEax1j0VGDQRp/OJIZNpOLJ
        Nmnxkrgl++z06g+dhZ141N8tj9z1V0S9Nq44tSQapQ==
X-Google-Smtp-Source: AGHT+IEkpSwsCCculoDUh7U7kxEZUNr0bPhh+2T8rUewy+rf6a9Uskt25TFrovjrcD2Ept4C8udzGv7nn2FeMRHLdaY=
X-Received: by 2002:a1c:4c13:0:b0:3fe:485f:ed1b with SMTP id
 z19-20020a1c4c13000000b003fe485fed1bmr897546wmf.28.1691138339742; Fri, 04 Aug
 2023 01:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com> <20230804082619.61833-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230804082619.61833-2-andriy.shevchenko@linux.intel.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Aug 2023 10:38:22 +0200
Message-ID: <CANpmjNO5p5shpVoo1BLi9QzBc0Q0TSdfz-tUCrtgQj_ogHKx5w@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] lib/vsprintf: Declare no_hash_pointers in a local header
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
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

On Fri, 4 Aug 2023 at 10:26, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Sparse is not happy to see non-static variable without declaration:
> lib/vsprintf.c:61:6: warning: symbol 'no_hash_pointers' was not declared. Should it be static?
>
> Declare respective variable in the local header.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/test_printf.c  | 4 ++--
>  lib/vsprintf.c     | 1 +
>  lib/vsprintf.h     | 7 +++++++
>  mm/kfence/report.c | 3 +--
>  4 files changed, 11 insertions(+), 4 deletions(-)
>  create mode 100644 lib/vsprintf.h
>
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 7677ebccf3c3..9e04b5f7244a 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -24,6 +24,8 @@
>
>  #include <linux/property.h>
>
> +#include "vsprintf.h"
> +
>  #include "../tools/testing/selftests/kselftest_module.h"
>
>  #define BUF_SIZE 256
> @@ -41,8 +43,6 @@ KSTM_MODULE_GLOBALS();
>  static char *test_buffer __initdata;
>  static char *alloced_buffer __initdata;
>
> -extern bool no_hash_pointers;
> -
>  static int __printf(4, 0) __init
>  do_test(int bufsize, const char *expect, int elen,
>         const char *fmt, va_list ap)
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 40f560959b16..6774cf84e623 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -54,6 +54,7 @@
>
>  #include <linux/string_helpers.h>
>  #include "kstrtox.h"
> +#include "vsprintf.h"
>
>  /* Disable pointer hashing if requested */
>  bool no_hash_pointers __ro_after_init;
> diff --git a/lib/vsprintf.h b/lib/vsprintf.h
> new file mode 100644
> index 000000000000..ddffde905824
> --- /dev/null
> +++ b/lib/vsprintf.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LIB_VSPRINTF_H
> +#define _LIB_VSPRINTF_H
> +
> +extern bool no_hash_pointers;
> +
> +#endif

It seems odd to create such a local header and then refer to it from
other subsystems.

What's the downside of just putting this into the new
include/linux/sprintf.h? If someone wants to access this variable,
they will one way or another.
