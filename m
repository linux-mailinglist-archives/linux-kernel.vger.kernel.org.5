Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993A17B6A69
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjJCNXl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 09:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjJCNXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:23:39 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3E5A1;
        Tue,  3 Oct 2023 06:23:36 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a22eaafd72so11219977b3.3;
        Tue, 03 Oct 2023 06:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696339415; x=1696944215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyqO5Si8x9tH0yrrGtUM2VgzCztD//mXgGUJcJBODIM=;
        b=a7vcZ9tiYUhbWGbLRzuEPbyxTT93C8FXysXVB4bAtaldp0D5/VtQR06OqRGMW40Twl
         oKV5tbTFweAs15zo/XospIWSqCZb7jA5tcLqotTkz4CXpl1uAQn8qQIt7f4ZuXIsy7pR
         PyZ0peXBHIctqpGNzjAZ9hgLA7BT/3FgR8Hee3/jOeIajNYEXODjMGfVkpcIenrLXUXj
         qKdiOwOM3HMeAl78kJrponz48R4dn9nUknOoqvSKyZoeqSfZK3QCvyxzwRcrLxqNo2hb
         WiO1wDKbhsBaMMLP1tiWJV8FjJQXpzPaaC4btiWb111RUTf3ftFfSVuHYi1IAWVkDJ6L
         rpGg==
X-Gm-Message-State: AOJu0YyP2hgQNRdagr89U6xVBubNOMbc2TxL8h+l1vly+geGMdCntv1f
        aUVZtd6dijEw0uaEVKuoGF4DnbIeg1HhPA==
X-Google-Smtp-Source: AGHT+IFU8dFMsoL99k55rFKjS/yIgR33TCJviv7HWMdQfJry+Qoxbwlp3gGKuVh8MnaTpRTsccW0aA==
X-Received: by 2002:a81:6c88:0:b0:5a1:c610:1154 with SMTP id h130-20020a816c88000000b005a1c6101154mr14046953ywc.10.1696339415219;
        Tue, 03 Oct 2023 06:23:35 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id j13-20020a81920d000000b0059f61be458esm367746ywg.82.2023.10.03.06.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 06:23:35 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a200028437so11327487b3.1;
        Tue, 03 Oct 2023 06:23:35 -0700 (PDT)
X-Received: by 2002:a81:a0d2:0:b0:57a:9b2c:51f1 with SMTP id
 x201-20020a81a0d2000000b0057a9b2c51f1mr14931488ywg.1.1696339414847; Tue, 03
 Oct 2023 06:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231003142737.381e7dcb@canb.auug.org.au> <20230920092641.832134-12-konstantin.meskhidze@huawei.com>
 <20231003.ahPha5bengee@digikod.net>
In-Reply-To: <20231003.ahPha5bengee@digikod.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Oct 2023 15:23:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVZsA4H47od6FV9+OzgWB2hnTQGr8YOcAL3yyURdm1AoA@mail.gmail.com>
Message-ID: <CAMuHMdVZsA4H47od6FV9+OzgWB2hnTQGr8YOcAL3yyURdm1AoA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the landlock tree
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yusongping@huawei.com,
        artem.kuzin@huawei.com, Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mickaël,

On Tue, Oct 3, 2023 at 3:15 PM Mickaël Salaün <mic@digikod.net> wrote:
> On Tue, Oct 03, 2023 at 02:27:37PM +1100, Stephen Rothwell wrote:
> > After merging the landlock tree, today's linux-next build (powerpc
> > allyesconfig) produced this warning:
> >
> > samples/landlock/sandboxer.c: In function 'populate_ruleset_net':
> > samples/landlock/sandboxer.c:170:78: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type '__u64' {aka 'long unsigned int'} [-Wformat=]
> >   170 |                                 "Failed to update the ruleset with port \"%llu\": %s\n",
> >       |                                                                           ~~~^
> >       |                                                                              |
> >       |                                                                              long long unsigned int
> >       |                                                                           %lu
> >   171 |                                 net_port.port, strerror(errno));
> >       |                                 ~~~~~~~~~~~~~
> >       |                                         |
> >       |                                         __u64 {aka long unsigned int}
> >
> > Introduced by commit
> >
> >   24889e7a2079 ("samples/landlock: Add network demo")
>
> PowerPC-64 follows the LP64 data model and then uses int-l64.h (instead of
> int-ll64.h like most architectures) for user space code.
>
> Here is the same code with the (suggested) "%lu" token on x86_86:
>
>   samples/landlock/sandboxer.c: In function ‘populate_ruleset_net’:
>   samples/landlock/sandboxer.c:170:77: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘__u64’ {aka ‘long long unsigned int’} [-Werror=format=]
>     170 |                                 "Failed to update the ruleset with port \"%lu\": %s\n",
>         |                                                                           ~~^
>         |                                                                             |
>         |                                                                             long unsigned int
>         |                                                                           %llu
>     171 |                                 net_port.port, strerror(errno));
>         |                                 ~~~~~~~~~~~~~
>         |                                         |
>         |                                         __u64 {aka long long unsigned int}
>
>
> We would then need to cast __u64 to unsigned long long to avoid this warning,
> which may look useless, of even buggy, for people taking a look at this sample.

In userspace code, you are supposed to #include <inttypes.h>
and use PRIu64.

> Anyway, it makes more sense to cast it to __u16 because it is the
> expected type for a TCP port. I'm updating the patch with that.
> Konstantin, please take this fix for the next series:
> https://git.kernel.org/mic/c/fc9de206a61a

Until someone passes a too large number, and it becomes truncated...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
