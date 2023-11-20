Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5604A7F0F35
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjKTJj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:39:25 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286EBBA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:39:22 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso5921782a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700473160; x=1701077960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y3Ac6lEqMUaiGY4DCcZMXzjYxBTrAXFgt1FNVntx8s=;
        b=PWQjcyfjsNOwJynhJAabWsWgVt/ockxP2pLyKUXSccMaQLCpBmYRDQOpyA42A3DgGe
         d4DOmk32M4w+1LsnhJ6aCpVkR4NBBNZSIaY7S89FMhLj9nfEk8DjqS7QN0cmFPN3AFlH
         VD7Rc6Ce1uAAaLWTfgvH5HRB1jnzl9ip8yprTrFIryvvJzNWRCZqYpTEkfMSIX79wRCQ
         CYijZKQWEk9xBMZEyuFvCisRg5ShgVHPy3Tkrsn0GGH8ZxD7rS87jtt+oLleVl3XQ2EB
         onie3TPfDP4zM+vKErQDddvrEJRsxx0JCkxQs7edyLZcWrB3mDPyCzNiaRQjBfy8j9pw
         7NFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700473160; x=1701077960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8y3Ac6lEqMUaiGY4DCcZMXzjYxBTrAXFgt1FNVntx8s=;
        b=lkHYYbbr8b9MlSQkryFtyi90KZFs5oIB6bcvFn3FNShfkKJdpa/eCGTdLql3pmzyOL
         JpSxVVNymj5sy7Q5EbjD7mcB9tjLQh8TaryuniJ/0rDXp9p587pq3nNxIix5qVIW7eGV
         OedzZ9l7IAuE1EPqPMj1OI9Z0Bfn2T7vjz7NDIDexPhYBekvtR86WsdTEZ0LCOF2yKyE
         0SciUI1L9XFszPtGzoTiiqNIQbWHeModCRvzB0VJtA9j9Nb2Qxqf8leXvhpX7dRdpFvj
         FL0LW0F7RamSUnnDoYciWdGh+rIezVWNQkxkxFdFf62ZFpgQptDLRNvR6hfy4bAgGeuZ
         iINw==
X-Gm-Message-State: AOJu0YwvCf64vWQG6NIfLcmXCFpcWXxtkWFpxs6SMQnGbos+OP092HfH
        11OSvQbIHeKveQALTjsv1gwibU6dS27q0yj029s=
X-Google-Smtp-Source: AGHT+IF4y+2eFQ+NkzZDkF9q7V/M/6OeIakXHat+fcz+aWmPbgfYu09Tj861TlIrrHWzsmdWzwBfbDhHkJWLIbXzj+8=
X-Received: by 2002:aa7:d056:0:b0:531:2b0b:9b8 with SMTP id
 n22-20020aa7d056000000b005312b0b09b8mr5898998edo.7.1700473160385; Mon, 20 Nov
 2023 01:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zp-eDsxpStBznMHUE3OcHZ97NAZrZEjJW63oEFWtM3OQ@mail.gmail.com>
 <CAFULd4bBeMCBf5_VKWA8Ui=rhQtXf03zFUioq1DeQaYCfP8v=A@mail.gmail.com> <CAHk-=wgUwPruc3MP6=vode2SawVpNgb8-szV1HYoc6E1wAaw=w@mail.gmail.com>
In-Reply-To: <CAHk-=wgUwPruc3MP6=vode2SawVpNgb8-szV1HYoc6E1wAaw=w@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 20 Nov 2023 10:39:08 +0100
Message-ID: <CAFULd4Zn2TTPr+EMTZMLz9twwvBW7rAx+-yfe7CZQJ51fn36og@mail.gmail.com>
Subject: Use %a asm operand modifier to obtain %rip-relative addressing
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 7:10=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 12 Oct 2023 at 09:55, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > An example:
>
> Oh, I'm convinced.
>
> The fix seems to be a simple one-liner, ie just
>
> -       asm(__pcpu_op2_##size(op, __percpu_arg(P[var]), "%[val]")       \
> +       asm(__pcpu_op2_##size(op, __percpu_arg(a[var]), "%[val]")       \
>
> and it turns out that we have other places where I think we could use tha=
t '%a',
>
> For example, we have things like this:
>
>         asm ("lea sme_cmdline_arg(%%rip), %0"
>              : "=3Dr" (cmdline_arg)
>              : "p" (sme_cmdline_arg));
>
> and I think the only reason we do that ridiculous asm is that the code
> in question really does want that (%rip) encoding. It sounds like this
> could just do
>
>         asm ("lea %a1, %0"
>              : "=3Dr" (cmdline_arg)
>              : "p" (sme_cmdline_arg));
>
> instead. Once again, I claim ignorance of the operand modifiers as the
> reason for these kinds of things.

I have looked a bit in the above code. From the compiler PoV, the
above can be written as:

         asm ("lea %1, %0"
              : "=3Dr" (cmdline_arg)
              : "m" (sme_cmdline_arg));

and it will always result in %rip-relative asm address:

#APP
# 585 "arch/x86/mm/mem_encrypt_identity.c" 1
    lea sme_cmdline_arg(%rip), %rsi
# 0 "" 2
#NO_APP

Uros.
