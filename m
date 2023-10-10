Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DB07BF32F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442252AbjJJGhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377808AbjJJGhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:37:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248A297
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:37:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo267494a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 23:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696919858; x=1697524658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qEr5hJmYY1fgOy3MhtcKL7r31lsPaZ5EkwvA6BoNSY=;
        b=ZGow+nYiPWfBJDp4Oe/rOzs29QQVOmnLP4uwcS2skiyorn71+WyKXoSDunPNxMTbPA
         zPFmo4BYGRCRMxLz4zU4s7kKF+ODGiuISJJOIqwqPwBygGUbuaxDIZ4p9JsvTyAzYvN6
         7kn8xiJWx7UcayAezLSP8vBzhogtYvwhDDGdEPdnfXmdnH1/InGnKVsTeUPNyO0bPAJ1
         YJjJ1r98nJk5UfUu2OsTipRXr78gqSe4NdV7qCNb7StVcWtUnaO6l7MazE6UoAuc/qG3
         UeIGOOBu1q3kbfC7bn6wbY0Bd3gVtLuUTXhBGJF6zzHedyL/j9Ln/1gQu4gXuDPJ0oMR
         hQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696919858; x=1697524658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qEr5hJmYY1fgOy3MhtcKL7r31lsPaZ5EkwvA6BoNSY=;
        b=rZ0BdPCMGSOVsLdtFS5wJi14pYvWgPU+3SIaNIefZ486flHUe+zSwVTbQMVTfeWP2T
         8+i+CzS6kGv0aEMHMrxWNW7XVosKPjICXLcZGM8C4mDFbiAReQpAJhb1vf9qjueqyW8u
         TsyeBJtt3eGJ/9yJHdesdJw2BnJ/PxM6zpprAVDPWLKCwzJlDcNFmvnjvbfbzSVecfuR
         0R5NO8TZxBTBdS/Fs99z6nooxJwtMTt4v+ShgjJd2HMEogydvb/XQDCaUhfToQ35kjOL
         e4uam9l583mpzJbdxkCmZZPiT2KYHo6ClQfUpQ0evNwOI711+5hAH3fxLX1p6pP8vtJU
         a5IA==
X-Gm-Message-State: AOJu0Yx8g+bJtLdAYXz/Ouua4LbmsHibCRszJtZcuh6gGg/BR80ysbvJ
        9uWnBJI4Jp4CE4USMGcSEKAAZjJv9uDXTkGaiXU=
X-Google-Smtp-Source: AGHT+IFHCEd0XMMV4MqQ+7cipfm3nWaWjWubytxfnK7VubiQx/T4b72PkLIZ8DdjJI1fLQo6blq/PlCcgJL7r8Uo6P8=
X-Received: by 2002:aa7:dcd1:0:b0:537:7811:855f with SMTP id
 w17-20020aa7dcd1000000b005377811855fmr14745001edu.12.1696919858388; Mon, 09
 Oct 2023 23:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231004145137.86537-1-ubizjak@gmail.com> <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 10 Oct 2023 08:37:27 +0200
Message-ID: <CAFULd4aa+xMo57WWmEu8hh0PqPqO5hwQPaEh0w==OA_MARJbkw@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
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

On Sun, Oct 8, 2023 at 8:00=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 4 Oct 2023 at 07:51, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > The percpu code mostly uses inline assembly. Using segment qualifiers
> > allows to use C code instead, which enables the compiler to perform
> > various optimizations (e.g. propagation of memory arguments). Convert
> > percpu read and write accessors to C code, so the memory argument can
> > be propagated to the instruction that uses this argument.
>
> So apparently this causes boot failures.
>
> It might be worth testing a version where this:
>
> > +#define raw_cpu_read_1(pcp)            __raw_cpu_read(, pcp)
> > +#define raw_cpu_read_2(pcp)            __raw_cpu_read(, pcp)
> > +#define raw_cpu_read_4(pcp)            __raw_cpu_read(, pcp)
> > +#define raw_cpu_write_1(pcp, val)      __raw_cpu_write(, pcp, val)
> > +#define raw_cpu_write_2(pcp, val)      __raw_cpu_write(, pcp, val)
> > +#define raw_cpu_write_4(pcp, val)      __raw_cpu_write(, pcp, val)
>
> and this
>
> > +#ifdef CONFIG_X86_64
> > +#define raw_cpu_read_8(pcp)            __raw_cpu_read(, pcp)
> > +#define raw_cpu_write_8(pcp, val)      __raw_cpu_write(, pcp, val)
>
> was all using 'volatile' in the qualifier argument and see if that
> makes the boot failure go away.
>
> Because while the old code wasn't "asm volatile", even just a *plain*
> asm() is certainly a lot more serialized than a normal access.
>
> For example, the asm() version of raw_cpu_write() used "+m" for the
> destination modifier, which means that if you did multiple percpu
> writes to the same variable, gcc would output multiple asm calls,
> because it would see the subsequent ones as reading the old value
> (even if they don't *actually* do so).
>
> That's admittedly really just because it uses a common macro for
> raw_cpu_write() and the updates (like the percpu_add() code), so the
> fact that it uses "+m" instead of "=3Dm" is just a random odd artifact
> of the inline asm version, but maybe we have code that ends up working
> just by accident.

FYI: While the emitted asm code is correct, the program flow depends
on uninitialized value. The compiler is free to remove the whole insn
stream in this case. Admittedly, we have asm here, so the compiler is
a bit more forgiving, but it is a slippery slope nevertheless.

Uros.
