Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716027B8DD3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjJDUIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjJDUIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:08:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2030EA6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:08:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53636f98538so297840a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696450085; x=1697054885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/tay9zf//BMum0yM5t4mIrr75LHD8bJi7uhv5K0kX4=;
        b=NCraYok0e7CNiINlHkEPHXuZiyGAFUiNiDcZ14yP3YeFZrPEVho/KSbJp9tkB7heXR
         K+hlIbpp0whrEVtbJzWy6ZVlIgJ1YQ9DLbHQgtw7ViKisDhQjyZ9/+vfXs7B43FAu5QX
         zFJcQsdL+QQr4bICKMqC9dGjCVt6MXU6xkpBZv8YC5cYCnskwGfoxZZEGJ9EGAmyUfnL
         NdUkr1R3rKLoWAv0ARIIQ7O5VJj035v7oWMOUAKsUzfDcgndqteKbsGl0gV6xiQouZ6b
         AkjA4EEpAp1JJ6+pb5CpO+TcbjUbDDBZaIPtXB6RBoUXpEeeGhLPg0NA7t/nMAfQ2qiA
         dv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696450085; x=1697054885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/tay9zf//BMum0yM5t4mIrr75LHD8bJi7uhv5K0kX4=;
        b=NNI3f6dDBqbTAZO/RAOTHzoeEmjN0pOGwbwXf2Ke7OBBkgyy0oALQJeZiU01JVg/MK
         62JqvfJvSUtYnmjn/ctp+NbzK2Knm0GsVA3Htg1JfKsJ7g6rfJxKtJODbmEsdS9tQYWi
         YPcXt5QfMNIoRaT+/WHBYX8/zIpmKUEyez7HCsw2btzTk0hFf4fUhRLjJtsQVsS9WLqK
         oRsmQzYxQq3mWa6noI8uZpVkJ7WHaOm/jhilQ74XQSZSL1vahqsBq5Z6zJh1Ka8fp8rN
         Yceygzg8N4gZ0z122ZhMTZeTyc7QhTreS7uROfHVvyG0FFrVTVS0016wPkC/3HrLOGYF
         9x6g==
X-Gm-Message-State: AOJu0Yw0uUyR/w8kZORHGLLCNbc4uEqKIVVm94SKuhP8arwTsO1wwgWA
        /9LYPDvasnNAtE4ld47Ai5kkQnhO7Lhv9dwLVJ8=
X-Google-Smtp-Source: AGHT+IExuDhaKdvryChrlmnF4niFCaEt81sQTXJvXV++Ku1XBst7PHQ46tJPzBD/o1N1Z4h91l0WrAXUETErWNYQyO8=
X-Received: by 2002:aa7:c711:0:b0:534:2e79:6b04 with SMTP id
 i17-20020aa7c711000000b005342e796b04mr2945648edq.14.1696450085292; Wed, 04
 Oct 2023 13:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <ZR2U4DLycLT5xFH6@gmail.com> <20231004192404.31733-1-ubizjak@gmail.com>
 <CAHk-=wjuRGzhuETLYDoi4hM6RAxHVL0ptuRb3TH-od+348Y8zA@mail.gmail.com>
In-Reply-To: <CAHk-=wjuRGzhuETLYDoi4hM6RAxHVL0ptuRb3TH-od+348Y8zA@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 4 Oct 2023 22:07:54 +0200
Message-ID: <CAFULd4YRHmQVnwaORm7=7kUs7DYG7SfwdTXAitDt=bxiMU5AoQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/percpu: Use C for percpu read/write accessors
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 9:42=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Unrelated reaction..
>
> On Wed, 4 Oct 2023 at 12:24, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > the code improves from:
> >
> >  65 8b 05 00 00 00 00    mov    %gs:0x0(%rip),%eax
> >  a9 00 00 0f 00          test   $0xf0000,%eax
> >
> > to:
> >
> >  65 f7 05 00 00 00 00    testl  $0xf0000,%gs:0x0(%rip)
> >  00 00 0f 00
>
> Funky.
>
> Why does gcc generate that full-width load from memory, and not demote
> it to a byte test?

It does when LSB is accessed at the same address. For example:

int m;
_Bool foo (void) { return m & 0x0f; }

compiles to:

  0:   f6 05 00 00 00 00 0f    testb  $0xf,0x0(%rip)        # 7 <foo+0x7>

>
> IOW, it should not be
>
>   65 f7 05 00 00 00 00 testl  $0xf0000,%gs:0x0(%rip)
>   00 00 0f 00
>
> after optimizing it, it should be three bytes shorter at
>
>   65 f6 05 00 00 00 00 testb  $0xf,%gs:0x0(%rip)
>   0f
>
> instead (this is "objdump", so it doesn't show that the relocation
> entry has changed by +2 to compensate).
>
> Now, doing the access narrowing is a bad idea for stores (because it
> can cause subsequent loads to have conflicts in the store buffer), but
> for loads it should always be a win to narrow the access.
>
> I wonder why gcc doesn't do it. This is not related to __seg_gs - I
> tried it with regular memory accesses too, and gcc kept those as
> 32-bit accesses too.
>
> And no, the assembler can't optimize that operation either, since I
> think changing the testl to a testb would change the 'P' bit in the
> resulting eflags, so this is a "the compiler could pick a better
> instruction choice" thing.
>
> I'm probably missing some reason why gcc wouldn't do this. But clang
> does seem to do this obvious optimization.

You get a store forwarding stall when you write a bigger operand to
memory and then read part of it, if the smaller part doesn't start at
the same
address.

Uros.
