Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBC17C73BC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbjJLRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347311AbjJLRKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:10:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4A3CC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:10:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c1c66876aso197882466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697130627; x=1697735427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EkHDmoyh6OIiX8/lityBIO7Wg/uX4JOtiNj2ag3Lok4=;
        b=FIlldSbUyv5zdwSXLu3TSyCJVrRIJTrTBt+0bUloReizcuHtQXPIKWWmzaerfEHDUh
         qskyLRrNO2HZF2CqkYffCo/hiRv7TFZ/e3H9MRTBY6XKEqUmUroxL5wQ2pqVVkXmJfCQ
         bBLHAwrJu3ojRdNxetXBKq9w6+RcFxFWxa+6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697130627; x=1697735427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkHDmoyh6OIiX8/lityBIO7Wg/uX4JOtiNj2ag3Lok4=;
        b=R1XOTqEkSwQI9gDTJz1mswOK/DJIWRN4OgQt2rUKhIe4C3+IU7dMSaoA2MXwoNWZY8
         EUA4YDD7R6J32lV7dtAKe8gbfrk3kGU7P6JRttpizJN9nXVOOse5uahG1N2rg7GBU08o
         QjoDvCF6pnCKSse5r9D4Cr3cP+JYWM2cU0fTZbEaBmiGpGnq1XX28OTV+pY7KMBdEKUB
         8rbdBF2syE+jsnMQHkIxCa6VRMaqX7K+mYageOJN4lSC/gxYaEGs61kEsZ7ndVPGVMWK
         5UK9OU6g1s1RsLfnVZxKFPHzllQmqo1tJWYZH1ngeX0chUuCpcBbtwVgfcUqrs7yFnuq
         mTEQ==
X-Gm-Message-State: AOJu0YwK2iiT4kw08RWYuyBQG7FbGoteWrh31Mv2rRRAb/sLmWFM2Qe5
        Srj7aQ4bONdm6obJirXtF1QlEsRkj2UmPeRzZwrBM6Gs
X-Google-Smtp-Source: AGHT+IGpJwT2SOoKfBsJP+Dz+aLikztSWeXUaacqagbXLw7NadRk22rEeErWLVAyv+EEuQK7OenJxg==
X-Received: by 2002:a17:906:74db:b0:9b2:78bf:d8d4 with SMTP id z27-20020a17090674db00b009b278bfd8d4mr23333476ejl.5.1697130626989;
        Thu, 12 Oct 2023 10:10:26 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a24-20020a170906685800b009828e26e519sm11239581ejs.122.2023.10.12.10.10.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 10:10:26 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9ad8a822508so201976566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:10:26 -0700 (PDT)
X-Received: by 2002:a17:906:73d4:b0:9b8:df8e:cbdd with SMTP id
 n20-20020a17090673d400b009b8df8ecbddmr20214962ejl.38.1697130625765; Thu, 12
 Oct 2023 10:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zp-eDsxpStBznMHUE3OcHZ97NAZrZEjJW63oEFWtM3OQ@mail.gmail.com>
 <CAFULd4bBeMCBf5_VKWA8Ui=rhQtXf03zFUioq1DeQaYCfP8v=A@mail.gmail.com>
In-Reply-To: <CAFULd4bBeMCBf5_VKWA8Ui=rhQtXf03zFUioq1DeQaYCfP8v=A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Oct 2023 10:10:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUwPruc3MP6=vode2SawVpNgb8-szV1HYoc6E1wAaw=w@mail.gmail.com>
Message-ID: <CAHk-=wgUwPruc3MP6=vode2SawVpNgb8-szV1HYoc6E1wAaw=w@mail.gmail.com>
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 at 09:55, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> An example:

Oh, I'm convinced.

The fix seems to be a simple one-liner, ie just

-       asm(__pcpu_op2_##size(op, __percpu_arg(P[var]), "%[val]")       \
+       asm(__pcpu_op2_##size(op, __percpu_arg(a[var]), "%[val]")       \

and it turns out that we have other places where I think we could use that '%a',

For example, we have things like this:

        asm ("lea sme_cmdline_arg(%%rip), %0"
             : "=r" (cmdline_arg)
             : "p" (sme_cmdline_arg));

and I think the only reason we do that ridiculous asm is that the code
in question really does want that (%rip) encoding. It sounds like this
could just do

        asm ("lea %a1, %0"
             : "=r" (cmdline_arg)
             : "p" (sme_cmdline_arg));

instead. Once again, I claim ignorance of the operand modifiers as the
reason for these kinds of things.

But coming back to the stable op thing, I do wonder if there is some
way we could avoid the unnecessary reload.

I don't hate Nadav's patch, so that part is fine, but I'd like to
understand what it is that makes gcc think it needs to reload. We have
other cases (like the ALTERNATIVE() uses) where we *have* to use
inline asm, so it would be good to know...

Is it just that "p" (in the constraint, not "P" in the modifier) ends
up always being seen as a memory access, even when we only use the
address?

That part has never really been something we've been entirely clear
on. We *are* passing in just the address, so the hope in *that* place
is that it's only an address dependency, not a memory one.

(Of course, we use 'p' constraints in other places, and may
expect/assume that those have memory dependency. Again - this has
never been entirely clear)

              Linus
