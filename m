Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B33B788FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjHYUnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjHYUnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:43:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7E82136
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:43:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so2033496e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692996213; x=1693601013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7bN2O17WORYrV504APBBhTykVIUp9W/DM+54sJbYAys=;
        b=ETxlxicvLn4b89xwS4rs1FD//LtZq5Osa0qtpVJ9VxL9Y1M2Mhy65aEtPZfoirtWlw
         HHMpi5o4n61+xrV8n/rj/w3J0Qy3hpOz2PyWbuad/3OlOzGvE1dgjjOTqI23Tnc6xO9w
         odGJI1VsYl+rveRharik5ZOJCasNQOzmTOUPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692996213; x=1693601013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bN2O17WORYrV504APBBhTykVIUp9W/DM+54sJbYAys=;
        b=dQxSX0vOTd8ib5IWkZ3t3gy5iPUfhIBJoB1ZZI9UnNbKvM48GcLVEj6CrviwnrJkKz
         pzWpWPmvXFtEKsaGpfZy56gp1b2/IotbRHvTS7EFkTyji1ZR7dIV3WX6ORw7Cz9DeIAu
         u+j0C6NiYGpwuxtWLr25ASPeJbQc5DkeWNwjuBY0NMD0foGdIswDWmJ/urB4txG0MRac
         6SxgDEfR8CDdHxksGQlcKOyQRM2g1WMdgZbM1l1qpnIZMLzRdld6r4xtMTmxFuJYW+/c
         jwfdUfsHhfOMZP2AwY7mSGHjLW59oa/e5aGrEGp+cmU04RLeMFdKIteMIbAFn//yQ0hI
         Su2A==
X-Gm-Message-State: AOJu0Yzt5krxZ5dGjp4eEhAt3AF+V5WFb7n1nrKFHMQpR3CfqRukNKcm
        sYHstTASkRvfg4y4dc8SPsYfzj87WFEMt/PAvS7TVA==
X-Google-Smtp-Source: AGHT+IHfhweMe9FGK8Ggj1WUoPFSj0zWiER2GVx7Dc+MOolb3D53j9/vY1H4T93f4/DuLC8GjOB5sg==
X-Received: by 2002:a05:6512:1590:b0:4ff:ae42:19e2 with SMTP id bp16-20020a056512159000b004ffae4219e2mr2653511lfb.58.1692996213114;
        Fri, 25 Aug 2023 13:43:33 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id q18-20020aa7da92000000b0052a19a75372sm1341538eds.90.2023.08.25.13.43.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 13:43:32 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99d937b83efso168250466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:43:32 -0700 (PDT)
X-Received: by 2002:a17:906:10dc:b0:9a1:c352:b6a2 with SMTP id
 v28-20020a17090610dc00b009a1c352b6a2mr9485343ejv.52.1692996212086; Fri, 25
 Aug 2023 13:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100> <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
In-Reply-To: <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Aug 2023 13:43:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
Message-ID: <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Unrelated to this patch, except it made me look, adding clang build
people to cc ]

On Fri, 25 Aug 2023 at 13:25, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 25 Aug 2023 at 12:50, Helge Deller <deller@gmx.de> wrote:
> >
> > This patch fixes the in-kernel functions __clzdi2() and __ctzdi2() [..]
>
> Applied,

Bah. Still applied,  but actually building this (on 64-bit, so kind of
pointless) I note that clang completely messes up this function on
x86.

Clang turns this:

        return __ffs64(val);

into this horror:

        pushq   %rax
        movq    %rdi, (%rsp)
        #APP
        rep
        bsfq    (%rsp), %rax
        #NO_APP
        popq    %rcx

which is just incredibly broken on so many levels. It *should* be a
single instruction, like gcc does:

        rep; bsf %rdi,%rax      # tmp87, word

but clang decides that it really wants to put the argument on the
stack, and apparently also wants to do that nonsensical stack
alignment thing to make things even worse.

We use this:

  static __always_inline unsigned long variable__ffs(unsigned long word)
  {
        asm("rep; bsf %1,%0"
                : "=r" (word)
                : "rm" (word));
        return word;
  }

for the definition, and it looks like clang royally just screws up
here. Yes, "m" is _allowed_ in that input set, but it damn well
shouldn't be used for something that is already in a register, since
"r" is also allowed, and is the first choice.

I think it's this clang bug:

    https://github.com/llvm/llvm-project/issues/20571
    https://github.com/llvm/llvm-project/issues/30873
    https://github.com/llvm/llvm-project/issues/34837

and it doesn't matter for *this* case (since I don't think this
library function is ever used on x86), but it looks like a generic
clang issue.

                 Linus
