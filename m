Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D1D7BCFCA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 21:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344496AbjJHTSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 15:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344413AbjJHTSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 15:18:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85635AC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 12:18:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-534659061afso6381101a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696792680; x=1697397480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhLtQA4koa67HfRjuDixTQ1WX/57StJmXVEzD/AJflk=;
        b=D0evQjxOqF6FdBIwH5jzYai9YLpyrx2CbXVM50IPGeRYx+GXMZW9Z5fl8YOAgsS4Bz
         uq5sDjeXsTIR9Lq48/sV0jFO9WhxtuBUHOWbdOd7g29y4ugJdGs2ob9MFim/cSu1Lmzr
         AvmKDXC0N1+EzYSI1g19b+MMYS3qqhwEFM7DNDWOiuWdkg3J7vkIjfws9Tyvu4uB+q5+
         G2rkeTk08eYXNpNdvkDXyP1hd5a/vYPfEezNQBa5TAi5sYjxVYwBr9YYDtCyrpagNdt9
         A5jJSzkdG9ukiXkqVpsNqkJ9yWE0QS5AiVKZsSet4MFiv5HJhbTlx//+Axj96ruUM9ye
         GXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696792680; x=1697397480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhLtQA4koa67HfRjuDixTQ1WX/57StJmXVEzD/AJflk=;
        b=Un2NpRVLNweyZnDNBqV0BRF58V1Fj5JhGncBv+q8qJB+/uW8OHlEKnQDnkiYxgQPRv
         iKWa/xZM/Y4JFTHlZ/ICxN9mxJtBwrWrBJwD9g6wZ9AhjfpH5mMxjVFHnX/jVF4S9dtl
         MP815WcC80HoqEj3RuyYqN5zv1bHhUFs3D4xsMLFJkOUKfyeqZaw6ZNYFghABX7S4lLp
         S7ATg+4bQWfrBnrQJpQ8MKyVOJ9qXYKHHA1MEq/0oXq+38KiZYL3DgQuDdRTsE50mZ41
         v4ZpVsaquU1fE3peUflkV/uGDaW5ikyG/2EUr0bxq2SHsKb9XPcVbli77h7iNYugBYJ/
         mWoQ==
X-Gm-Message-State: AOJu0YyMsvAlA7RcxO9WpQLAKaY74k5f8bRASuwMWoSkNWzHXIDwsZ7s
        BrLsk97DB/o/9OFbXySZyQ7WrZkUd9uUBmq63lA=
X-Google-Smtp-Source: AGHT+IE9lyKmIRoP5cBqJbYW+Zg35ygFpGW5FBlS0TlYRU1sJN19s48Ju7RAPPxLeffhPWBrkBnYmoM5myGDOEsVFGc=
X-Received: by 2002:aa7:d699:0:b0:525:440a:616a with SMTP id
 d25-20020aa7d699000000b00525440a616amr12121644edr.20.1696792679519; Sun, 08
 Oct 2023 12:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231004145137.86537-1-ubizjak@gmail.com> <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sun, 8 Oct 2023 21:17:48 +0200
Message-ID: <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
>
> Also, I'm not sure gcc re-orders asms wrt each other - even when they
> aren't marked volatile.
>
> So it might be worth at least a trivial "make everything volatile"
> test to see if that affects anything.

I have managed to reproduce the bug, and I'm trying the following path:

Scrap the last patch and just add:

#define __raw_cpu_read_new(size, qual, pcp)                \
({                                    \
    *(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));        \
})

#define __raw_cpu_read(size, qual, _var)                \
({                                    \
    __pcpu_type_##size pfo_val__;                    \
    asm qual (__pcpu_op2_##size("mov", __percpu_arg([var]), "%[val]") \
        : [val] __pcpu_reg_##size("=3D", pfo_val__)            \
        : [var] "m" (__my_cpu_var(_var)));                \
    (typeof(_var))(unsigned long) pfo_val__;            \
})

Then changing *only*

#define raw_cpu_read_8(pcp)            __raw_cpu_read_new(8, , pcp)

brings the boot process far enough to report:

[    0.463711][    T0] Dentry cache hash table entries: 1048576
(order: 11, 8388608 bytes, linear)
[    0.465859][    T0] Inode-cache hash table entries: 524288 (order:
10, 4194304 bytes, linear)
PANIC: early exception 0x0d IP 10:ffffffff810c4cb9 error 0 cr2
0xffff8881ab1ff000
[    0.469084][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted
6.5.0-11417-gca4256348660-dirty #7
[    0.470756][    T0] RIP: 0010:cpu_init_exception_handling+0x179/0x740
[    0.472045][    T0] Code: be 0f 00 00 00 4a 03 04 ed 40 19 15 85 48
89 c7 e8 9c bb ff ff 48 c7 c0 10 73 02 00 48 ba 00 00 00 00 00 fc ff
df 48 c1 e8 03 <80> 3c 10
00 0f 85 21 05 00 00 65 48 8b 05 45 26 f6 7e 48 8d 7b 24
[    0.475784][    T0] RSP: 0000:ffffffff85207e38 EFLAGS: 00010002
ORIG_RAX: 0000000000000000
[    0.477384][    T0] RAX: 0000000000004e62 RBX: ffff88817700a000
RCX: 0000000000000010
[    0.479093][    T0] RDX: dffffc0000000000 RSI: ffffffff85207e60
RDI: ffff88817700f078
[    0.481178][    T0] RBP: 000000000000f000 R08: 0040f50000000000
R09: 0040f50000000000
[    0.482655][    T0] R10: ffff8881ab02a000 R11: 0000000000000000
R12: 1ffffffff0a40fc8
[    0.484128][    T0] R13: 0000000000000000 R14: 0000000000000000
R15: ffffffff85151940
[    0.485604][    T0] FS:  0000000000000000(0000)
GS:ffff888177000000(0000) knlGS:0000000000000000
[    0.487246][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.488515][    T0] CR2: ffff8881ab1ff000 CR3: 00000000052d7000
CR4: 00000000000000b0
[    0.490002][    T0] Call Trace:
[    0.490600][    T0]  <TASK>
[    0.491145][    T0]  ? early_fixup_exception+0x10e/0x280
[    0.492176][    T0]  ? early_idt_handler_common+0x2f/0x40
[    0.493222][    T0]  ? cpu_init_exception_handling+0x179/0x740
[    0.494348][    T0]  ? cpu_init_exception_handling+0x164/0x740
[    0.495472][    T0]  ? syscall_init+0x1c0/0x1c0
[    0.496351][    T0]  ? per_cpu_ptr_to_phys+0x1ca/0x2c0
[    0.497336][    T0]  ? setup_cpu_entry_areas+0x138/0x980
[    0.498365][    T0]  trap_init+0xa/0x40

Let me see what happens here. I have changed *only* raw_cpu_read_8,
but the GP fault is reported in cpu_init_exception_handling, which
uses this_cpu_ptr. Please note that all per-cpu initializations go
through existing {this|raw}_cpu_write.

void cpu_init_exception_handling(void)
{
struct tss_struct *tss =3D this_cpu_ptr(&cpu_tss_rw);
int cpu =3D raw_smp_processor_id();
...

I have tried the trick with all reads volatile (and writes as they
were before the patch), but it didn't make a difference. Also, the
kernel from the git/tip branch works OK for default config, so I think
there is some config option that somehow disturbs the named-as enabled
kernel.

Uros.
