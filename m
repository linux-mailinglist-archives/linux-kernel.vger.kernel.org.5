Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86627C785B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442853AbjJLVF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442824AbjJLVFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:05:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B051D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:05:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so2447799a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697144750; x=1697749550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmYbDLi462mhz/h94tn+FuQJl/K+QQJOfQDRUT1QidM=;
        b=OVUXOr0F2uGMn9oksBEf2FT9+qY/TU8TbF46gD/7Ofpyx0Q++TKLen2zGXl7gypCzQ
         KZcYHuSY3EMNtHD6p9KwfggxyP9laui5lF0WQGvXDZGY/cFhbIyUHg3uMUK++VzaSk/I
         J1ni/jC12dH5IBBhZFNgeN6lBK2B0LW4ei+rhkhqd7yoFBT1mmLgwtfTeoxKjf2IEmxz
         jeJRw2o4Q7kNiauHS68qzA0vxFgrTVK+B3X7DmrxP9HnPrOooonv9USLfyk/3xYdUMEA
         wNEykMTjAHFoma/Ne5XEW25z5leU3mZRP9PhLuNC5cE6z1gmwW22MrraDkGOyLnXFrPf
         qQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697144750; x=1697749550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmYbDLi462mhz/h94tn+FuQJl/K+QQJOfQDRUT1QidM=;
        b=HPA79VTsa3/DiTvIxsO5GCAjkEnt0mQa4sNfEgL/P9VUuYkqhT+fOu0L04s7m6mhZ7
         GP6ps4PLeAumR+tRTjAiGJ59D20j1mddo5QF+SwSwmVQQG+IEEMAerzYCvM48AnDvmAQ
         +MmWkivtQZmEC7Wh0X6hA74ZzD11EqtN49bkrOMn9dn4EyCtPPLFlrSmha2HbaBCJque
         MK5/9UKT8xeFiZew1Sd5yh9sv/Q7ampNKXcJ/t30YyJxffI5rcrGV7uRpYa/Yg4/fb10
         SPtld+qF7QTAwrNwgFnHybxUnrCItPp+TByd8X8Ep1E2dN3UoOkLDhBsx0NLnNnwNcdt
         /qXw==
X-Gm-Message-State: AOJu0Yw3BzxOdJFL1nIxyt2ApBnbsEcFvU+E0pqSHCLYy0e/V60Wbsmf
        jaSk/LTig8VuGkwgzTmRpeAAHvYr0W6sGOC+zV0=
X-Google-Smtp-Source: AGHT+IEt2n0n2zZH9B3GUR1cImxXZzuqugVwxdUIpE6C3qgF95LQqZgOxgXHebB4KGlgQKyBRgxQUDBeeZp+2AHZaZw=
X-Received: by 2002:a05:6402:2314:b0:53e:1741:d76b with SMTP id
 l20-20020a056402231400b0053e1741d76bmr1943019eda.39.1697144750412; Thu, 12
 Oct 2023 14:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231012161237.114733-1-ubizjak@gmail.com> <20231012161237.114733-2-ubizjak@gmail.com>
 <E2A4E3BD-10C1-43F7-AD6D-1037C7106F8B@zytor.com>
In-Reply-To: <E2A4E3BD-10C1-43F7-AD6D-1037C7106F8B@zytor.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 12 Oct 2023 23:05:39 +0200
Message-ID: <CAFULd4brKzOJCU7Koc7gyMt5QNAznRr=a-TwP7k+gXT2B2S7=g@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/percpu: Use explicit segment registers in lib/cmpxchg{8,16}b_emu.S
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
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

On Thu, Oct 12, 2023 at 11:02=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On October 12, 2023 9:10:36 AM PDT, Uros Bizjak <ubizjak@gmail.com> wrote=
:
> >PER_CPU_VAR macro is intended to be applied to a symbol, it is not
> >intended to be used as a selector between %fs and %gs segment
> >registers for general operands.
> >
> >The address to these emulation functions is passed in a register, so
> >use explicit segment registers to access percpu variable instead.
> >
> >Also add a missing function comment to this_cpu_cmpxchg8b_emu.
> >
> >No functional changes intended.
> >
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@redhat.com>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >Cc: Peter Zijlstra <peterz@infradead.org>
> >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >---
> > arch/x86/lib/cmpxchg16b_emu.S | 12 ++++++------
> > arch/x86/lib/cmpxchg8b_emu.S  | 30 +++++++++++++++++++++---------
> > 2 files changed, 27 insertions(+), 15 deletions(-)
> >
> >diff --git a/arch/x86/lib/cmpxchg16b_emu.S b/arch/x86/lib/cmpxchg16b_emu=
.S
> >index 6962df315793..2bd8b89bce75 100644
> >--- a/arch/x86/lib/cmpxchg16b_emu.S
> >+++ b/arch/x86/lib/cmpxchg16b_emu.S
> >@@ -23,14 +23,14 @@ SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
> >       cli
> >
> >       /* if (*ptr =3D=3D old) */
> >-      cmpq    PER_CPU_VAR(0(%rsi)), %rax
> >+      cmpq    %gs:(%rsi), %rax
> >       jne     .Lnot_same
> >-      cmpq    PER_CPU_VAR(8(%rsi)), %rdx
> >+      cmpq    %gs:8(%rsi), %rdx
> >       jne     .Lnot_same
> >
> >       /* *ptr =3D new */
> >-      movq    %rbx, PER_CPU_VAR(0(%rsi))
> >-      movq    %rcx, PER_CPU_VAR(8(%rsi))
> >+      movq    %rbx, %gs:(%rsi)
> >+      movq    %rcx, %gs:8(%rsi)
> >
> >       /* set ZF in EFLAGS to indicate success */
> >       orl     $X86_EFLAGS_ZF, (%rsp)
> >@@ -42,8 +42,8 @@ SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
> >       /* *ptr !=3D old */
> >
> >       /* old =3D *ptr */
> >-      movq    PER_CPU_VAR(0(%rsi)), %rax
> >-      movq    PER_CPU_VAR(8(%rsi)), %rdx
> >+      movq    %gs:(%rsi), %rax
> >+      movq    %gs:8(%rsi), %rdx
> >
> >       /* clear ZF in EFLAGS to indicate failure */
> >       andl    $(~X86_EFLAGS_ZF), (%rsp)
> >diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
> >index 49805257b125..b7d68d5e2d31 100644
> >--- a/arch/x86/lib/cmpxchg8b_emu.S
> >+++ b/arch/x86/lib/cmpxchg8b_emu.S
> >@@ -24,12 +24,12 @@ SYM_FUNC_START(cmpxchg8b_emu)
> >       pushfl
> >       cli
> >
> >-      cmpl    0(%esi), %eax
> >+      cmpl    (%esi), %eax
> >       jne     .Lnot_same
> >       cmpl    4(%esi), %edx
> >       jne     .Lnot_same
> >
> >-      movl    %ebx, 0(%esi)
> >+      movl    %ebx, (%esi)
> >       movl    %ecx, 4(%esi)
> >
> >       orl     $X86_EFLAGS_ZF, (%esp)
> >@@ -38,7 +38,7 @@ SYM_FUNC_START(cmpxchg8b_emu)
> >       RET
> >
> > .Lnot_same:
> >-      movl    0(%esi), %eax
> >+      movl    (%esi), %eax
> >       movl    4(%esi), %edx
> >
> >       andl    $(~X86_EFLAGS_ZF), (%esp)
> >@@ -53,18 +53,30 @@ EXPORT_SYMBOL(cmpxchg8b_emu)
> >
> > #ifndef CONFIG_UML
> >
> >+/*
> >+ * Emulate 'cmpxchg8b %fs:(%esi)'
> >+ *
> >+ * Inputs:
> >+ * %esi : memory location to compare
> >+ * %eax : low 32 bits of old value
> >+ * %edx : high 32 bits of old value
> >+ * %ebx : low 32 bits of new value
> >+ * %ecx : high 32 bits of new value
> >+ *
> >+ * Notably this is not LOCK prefixed and is not safe against NMIs
> >+ */
> > SYM_FUNC_START(this_cpu_cmpxchg8b_emu)
> >
> >       pushfl
> >       cli
> >
> >-      cmpl    PER_CPU_VAR(0(%esi)), %eax
> >+      cmpl    %fs:(%esi), %eax
> >       jne     .Lnot_same2
> >-      cmpl    PER_CPU_VAR(4(%esi)), %edx
> >+      cmpl    %fs:4(%esi), %edx
> >       jne     .Lnot_same2
> >
> >-      movl    %ebx, PER_CPU_VAR(0(%esi))
> >-      movl    %ecx, PER_CPU_VAR(4(%esi))
> >+      movl    %ebx, %fs:(%esi)
> >+      movl    %ecx, %fs:4(%esi)
> >
> >       orl     $X86_EFLAGS_ZF, (%esp)
> >
> >@@ -72,8 +84,8 @@ SYM_FUNC_START(this_cpu_cmpxchg8b_emu)
> >       RET
> >
> > .Lnot_same2:
> >-      movl    PER_CPU_VAR(0(%esi)), %eax
> >-      movl    PER_CPU_VAR(4(%esi)), %edx
> >+      movl    %fs:(%esi), %eax
> >+      movl    %fs:4(%esi), %edx
> >
> >       andl    $(~X86_EFLAGS_ZF), (%esp)
> >
>
> %fs??

Yes, 32-bit targets default to %fs. Please also note a new version
(v2) of the patch that reimplements this part.

Uros.
