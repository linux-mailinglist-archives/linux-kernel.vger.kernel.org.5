Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657D87C5FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjJKVzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJKVzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:55:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E65AF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:55:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso46983866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697061304; x=1697666104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qkNPkWU4uC8r9HLUSAcPYPPySazCPD04LYjtxitM3AU=;
        b=FlP0H/nWVdlvjxh9oY3YSZzd+laBO4kZmClgwd+BuPeHAArmtk4xilz4RsUtpXjYov
         dTY5zb1xMA12AD9CsUqgmnaoj9KW7khUWiUBFfXMUNe3ujb9G8Q/ZtLOD66ebtDBROUN
         dAzbsMjKPMd2r4GqLfeKLiESRYpQmlkU9PlO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697061304; x=1697666104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkNPkWU4uC8r9HLUSAcPYPPySazCPD04LYjtxitM3AU=;
        b=Bd2yWjn+LA+gNPdq+E0gVZYETH4GAj2VzUi4nvWIFdYLSrE8iI8hVKDA2yGaDK/yia
         hEb/1Mh3PMe9UFZFYaNO3thCGsGIslcf3jyqkifMH1hPkp/Oh4nO4W89yncZ3yS+FyhQ
         41OFzritGEWXNkqoyeohIJCyW820Jg3/AUxoX5lpQ+18TQDWX4GizzhF/70HNSlI1jG0
         sDQOZnsIi41k2fpcRIbB2+/nX809lu0zxWQOgyxB6cDDG9LU9J8U4KQl4MDnVcIlOqfo
         TKdU166BDQbPTJIsTAB8YxiSlpuXTDfnKx/ge3Cjr7uPbuoAlMNmjVdoAVTJCBTurNcK
         yRow==
X-Gm-Message-State: AOJu0YzGQ3UClvDMP/NSDlf54Kzq5kE8TsKfH6dTBURAhzUNmkoIUO8z
        GHpmyNt00cr6+LuOCBg/aKcDmtjPoeAqnT8gWeQ9Dd9W
X-Google-Smtp-Source: AGHT+IGoGfN0btRhX9r/M5Z8jnMzyamMI/uZcqKGUIKzPfXc3VKH3qlHzFNptjI8NqcRPdq1Y5PBjw==
X-Received: by 2002:a17:906:186:b0:9ba:dcbf:6f53 with SMTP id 6-20020a170906018600b009badcbf6f53mr4504411ejb.35.1697061304651;
        Wed, 11 Oct 2023 14:55:04 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id m15-20020a1709066d0f00b00982a352f078sm10093832ejr.124.2023.10.11.14.55.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 14:55:03 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso669359a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:55:03 -0700 (PDT)
X-Received: by 2002:a05:6402:35cb:b0:53d:fe98:fd48 with SMTP id
 z11-20020a05640235cb00b0053dfe98fd48mr745022edc.3.1697061303242; Wed, 11 Oct
 2023 14:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
In-Reply-To: <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Oct 2023 14:54:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
Message-ID: <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 14:33, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Reading the above, it looks to me that we don't want to play games
> with "const aliased" versions of current_task [1], as proposed by
> Nadav in his patch series.

Well, maybe I'd like it if I saw what the effect of it was, but that
patch mentions "sync_mm_rss()" which doesn't actually exist
(SPLIT_RSS_COUNTING is never defined, the split version is gone and
hasn't existed since commit f1a7941243c1 "mm: convert mm's rss stats
into percpu_counter")

I'm not sure why gcc used to get code generation wrong there, and I
don't see what could be improved in the current implementation of
'current_task', but I guess there could be things that could be done
to make gcc more likely to CSE the cases..

IOW, I don't understand why Navad's patch would improve gcc code gen.
It presumably depends on some gcc internal issue (ie "gcc just happens
to be better at optimization X").

Which is obviously a valid thing in general.

              Linus
