Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A54A7EF652
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346086AbjKQQiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQQiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:38:00 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20DD196
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:37:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so4191763a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239075; x=1700843875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxwrR6Bt0E1+oJZAVCUeFTOBfuZBCQ6JEnD8LDGAX94=;
        b=MKyB3mRVpjZ8Y/emNgPb6FuVppYOzJxhIqNc0cpBc4c3JKcRiULms9WEDcMH8YUorV
         SJonmIOwVrtmBABPgwk58YIfN6upCT6CwTN0Yy2gi/OimoZxzlsTefpTCYvIlex9Muun
         dV4iD9wlCx34WyC1/BdXv9Zz9hpleKRf6ASqjtud3K6vEtKnP3N9pdD4KZXmOtgIf13q
         xkREuHBtRF7ObxPHm5RpVg2VNrcT2Uetpbi0wMZMBSpXcDSzEIRyDkhg4mc5yQkmCkyb
         Xyu+HupKVkY8bmQPDLM0eXYFdXZJNUJ/nn1HOuZJj5gtNVMlKJ5p+7q0h8wZedaMvmQ9
         +wGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239075; x=1700843875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxwrR6Bt0E1+oJZAVCUeFTOBfuZBCQ6JEnD8LDGAX94=;
        b=s9a2LHhhWyqtA56AN0jOCaykox956L7BhUWjBSG3pQbvAgssmGcATFTxVH5+C18XY9
         gQOvXICXZcj/vGr8PMEWSRc0Ch8wNajEXToLbxoY9Tp1WGzIRDhThlmWaOqyHRygfjQ0
         wyv7U+kLTfTXnAT06lnLCQY1I/twkF2Zw+e6URJjXvC4q2S6vXyQXb1sWNWI+5ZD+uwQ
         oORzoeSL761vHNwjFbUN6TXCW8Aj99TLVuTWCiyqRzaE73PYe5RewA5hIen4LjNdPwbz
         pFmUPfQuf3aA8rmckmlNAAvChSSzwxz7E1FjALN1CG6kMw1/hakzzitFJ0GpCg5aE8Dx
         hLzw==
X-Gm-Message-State: AOJu0YxXYhy/Qup5yEdaiawZjHbYlGipSmzVsDg0Bx0aJUa150RD3NaQ
        cf5SdXEwyDr3383LP5NhLZBWBW5oCV7XTknTV7k=
X-Google-Smtp-Source: AGHT+IGf88LLbMh8P2+vx9kIW5PPdybb3r8AoRn3Cpsm5tr8sIb+Y5yuCKbhHpDlmMNE7NE/BuxtNuL7CUogvjQopG0=
X-Received: by 2002:a05:6402:26cd:b0:540:16be:6562 with SMTP id
 x13-20020a05640226cd00b0054016be6562mr6601215edd.15.1700239074915; Fri, 17
 Nov 2023 08:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20231114164416.208285-1-ubizjak@gmail.com> <367bc727-3f26-4e78-8e58-af959760b3fc@intel.com>
In-Reply-To: <367bc727-3f26-4e78-8e58-af959760b3fc@intel.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 17 Nov 2023 17:37:43 +0100
Message-ID: <CAFULd4ZA2w+rz==cw1e18yJ9sdLpAi8XLZ7JU104yyD0Maspdw@mail.gmail.com>
Subject: Re: [PATCH] x86/smp: Use atomic_try_cmpxchg() to micro-optimize native_stop_other_cpus()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
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

On Fri, Nov 17, 2023 at 5:18=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 11/14/23 08:43, Uros Bizjak wrote:
> > Use atomic_try_cmpxchg() instead of atomic_cmpxchg(*ptr, old, new) =3D=
=3D old
> > in native_stop_other_cpus(). On x86 the CMPXCHG instruction returns suc=
cess
> > in the ZF flag, so this change saves a compare after CMPXCHG. Together
> > with a small code reorder, the generated asm code improves from:
> >
> >   74: 8b 05 00 00 00 00       mov    0x0(%rip),%eax
> >   7a: 41 54                   push   %r12
> >   7c: 55                      push   %rbp
> >   7d: 65 8b 2d 00 00 00 00    mov    %gs:0x0(%rip),%ebp
> >   84: 53                      push   %rbx
> >   85: 85 c0                   test   %eax,%eax
> >   87: 75 71                   jne    fa <native_stop_other_cpus+0x8a>
> >   89: b8 ff ff ff ff          mov    $0xffffffff,%eax
> >   8e: f0 0f b1 2d 00 00 00    lock cmpxchg %ebp,0x0(%rip)
> >   95: 00
> >   96: 83 f8 ff                cmp    $0xffffffff,%eax
> >   99: 75 5f                   jne    fa <native_stop_other_cpus+0x8a>
> >
> > to:
> >
> >   74: 8b 05 00 00 00 00       mov    0x0(%rip),%eax
> >   7a: 85 c0                   test   %eax,%eax
> >   7c: 0f 85 84 00 00 00       jne    106 <native_stop_other_cpus+0x96>
> >   82: 41 54                   push   %r12
> >   84: b8 ff ff ff ff          mov    $0xffffffff,%eax
> >   89: 55                      push   %rbp
> >   8a: 53                      push   %rbx
> >   8b: 65 8b 1d 00 00 00 00    mov    %gs:0x0(%rip),%ebx
> >   92: f0 0f b1 1d 00 00 00    lock cmpxchg %ebx,0x0(%rip)
> >   99: 00
> >   9a: 75 5e                   jne    fa <native_stop_other_cpus+0x8a>
> >
> > Please note early exit and lack of CMP after CMPXCHG.
>
> Uros, I really do appreciate that you are trying to optimize these
> paths.  But the thing we have to balance is the _need_ for optimization
> with the chance that this will break something.
>
> This is about as much of a slow path as we have in the kernel.  It's
> only used at shutdown, right?  That means this is one of the places in
> the kernel that least needs optimization.  It can only possibly get run
> once per boot.
>
> So, the benefit is that it might make this code a few cycles faster.  In
> practice, it might not even be measurably faster.
>
> On the other hand, this is relatively untested and also makes the C code
> more complicated.
>
> Is there some other side benefit that I'm missing here?  Applying this
> patch doesn't seem to have a great risk/reward ratio.

Yes, in addition to better asm code, I think that the use of magic
constant (-1) is not descriptive at all. I tried to make this code
look like nmi_panic() from kernel/panic.c, which has similar
functionality, and describe that this constant belongs to old_cpu
(same as in nmi_panic() ). Also, from converting many cmpxchg to
try_cmpxchg, it becomes evident that in cases like this (usage in "if"
clauses) the correct locking primitive is try_cmpxchg. Additionally,
in this particular case, it is not the speed, but a little code save
that can be achieved with the same functionality.

Thanks,
Uros.
