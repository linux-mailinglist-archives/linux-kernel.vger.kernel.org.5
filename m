Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA782775441
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjHIHgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjHIHgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:36:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D1172A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:36:07 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so36253535e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 00:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691566566; x=1692171366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9g6zXd3UY6FR9mRGo0YLbshWp2Mg0VfIdE8xLRYTWgY=;
        b=P1SYKGJXzgRZvbTDBewiHnTDquAXRziX7UWB26is7h3/LiMwXhLXRCePcZ3BDl0Sdj
         fGD27F0jvYX2V3fWhgm1uCi12Ht843Bi32gcSGtXanIH5Hx5/pexhNmOSzgbpLWi4B7m
         /4hLuvXBj4TEiOHNyQZwWu/AVVFiKdfUXkSu7SNllyLWulMGPQg9OE5dIggbyXyCk09q
         bpQKrrWKWejpp32CDgXVZ7+1vppAq+IKuCSWsE+FVd61SVP0/wF9DO/zFGxrJCeBHPZF
         rKQmmGEeST4P24Ouz360dDEJmLUdlYaDL3MrtkgZfo4m7py3CJALHORTe/3Iag5hWYOg
         CbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691566566; x=1692171366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9g6zXd3UY6FR9mRGo0YLbshWp2Mg0VfIdE8xLRYTWgY=;
        b=ZetDSUVFV5Lb/6JsUQr+yfSq0Vv7PTdofIFbm6LZ0jyp9G9KazFZTvvK06U8254QkS
         jW5jUe7zp9IdYHUQMFkiGVAyP6Q42k7gpjMckDMioT2cx3J9fzrJ2faKbf+dbY7sANmU
         FZF4V480E4aNKzbUVqXfMlzxXT6z9pqEeUkfLnvS+Gy/pxVbFoA3JwcTURUVxcZZdFvk
         40S0cN7Na18MDkH6UKpZF2kobjlC81/359aSEMzQw1U9CqTbFVA9oAkAa6rS4lvsKn8v
         faPWzHKdfGVFgDfuoOQyCJvzBm2EMvqj/1RCtEVe8r5e2T+7ftXH9dD6ip7x3wzMfGFr
         GbOA==
X-Gm-Message-State: AOJu0YwIPf5G9cEp0AnDOl3iN97O5+pCaV5N0SjJ6GRVwOic+pIWjA92
        uVaQ1mOkl98mgSupGBU71XuPSOo5i3e/o0hrinth5A==
X-Google-Smtp-Source: AGHT+IFLVn1NeZhNSR4e0f4XwgaZlOp0UJWCsTWtrzAtLWAsvsgQTICHpp1h8SPYP0VKCEaRvXTAkpih5U8qZmKLx5g=
X-Received: by 2002:a05:600c:ac4:b0:3f9:c0f2:e1a4 with SMTP id
 c4-20020a05600c0ac400b003f9c0f2e1a4mr1498745wmr.34.1691566566341; Wed, 09 Aug
 2023 00:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230808102049.465864-1-elver@google.com> <20230808102049.465864-3-elver@google.com>
 <202308081424.1DC7AA4AE3@keescook>
In-Reply-To: <202308081424.1DC7AA4AE3@keescook>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Aug 2023 09:35:29 +0200
Message-ID: <CANpmjNM3rc8ih7wvFc2GLuMDLpWcdA8uWfut-5tOajqtVG952A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] list_debug: Introduce CONFIG_DEBUG_LIST_MINIMAL
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 at 23:27, Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Aug 08, 2023 at 12:17:27PM +0200, Marco Elver wrote:
> > Numerous production kernel configs (see [1, 2]) are choosing to enable
> > CONFIG_DEBUG_LIST, which is also being recommended by KSPP for hardened
> > configs [3]. The feature has never been designed with performance in
> > mind, yet common list manipulation is happening across hot paths all
> > over the kernel.
> >
> > Introduce CONFIG_DEBUG_LIST_MINIMAL, which performs list pointer
> > checking inline, and only upon list corruption delegates to the
> > reporting slow path.
>
> I'd really like to get away from calling this "DEBUG", since it's used
> more for hardening (CONFIG_LIST_HARDENED?). Will Deacon spent some time
> making this better a while back, but the series never landed. Do you
> have a bit of time to look through it?
>
> https://github.com/KSPP/linux/issues/10
> https://lore.kernel.org/lkml/20200324153643.15527-1-will@kernel.org/

I'm fine renaming this one. But there are other issues that Will's
series solves, which I don't want this series to depend on. We can try
to sort them out separately.

The main problem here is that DEBUG_LIST has been designed to be
friendly for debugging (incl. checking poison values and NULL). Some
kernel devs may still want that, but for production use is pointless
and wasteful.

So what I can propose is to introduce CONFIG_LIST_HARDENED that
doesn't depend on CONFIG_DEBUG_LIST, but instead selects it, because
we still use that code to produce a report.

If there are other list types that have similar debug checks, but
where we can optimize performance by eliding some and moving them
inline, we can do the same (CONFIG_*_HARDENED). If the checks are
already optimized, we could just rename it to CONFIG_*_HARDENED and
remove the DEBUG-name.

I'm not a big fan of the 2 modes either, but that's what we get if we
want to support the debugging and hardening usecases. Inlining the
full set of checks does not work for performance and size.
