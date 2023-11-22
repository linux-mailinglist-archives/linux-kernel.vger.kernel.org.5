Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2F7F5168
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjKVUTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjKVUTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:19:03 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C47BD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:18:59 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-548d4fc9579so389781a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700684335; x=1701289135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjdwjoxEyUek2qg08QWlnX78It6WvNJ/gExSp2uXTbQ=;
        b=PkSwCImTvgLJLactlqt+KqcTPwAH0yA6RolxtJ6dtM2gVG0E+oHyJZ2Rr74+aj9R+X
         Li5Al9NqyStiDO3L0uHJU6xcPE/hnQaYUZYGbV40WtnbtcuXayX9MFhqHTNYoiZ2UGp1
         M5/BYKmAjG1h7VFT+4DqxEQRpw2qgcQ/NKYPYuUH4bzyTxdY7RySYGQNeYRJMdHE5Ist
         VHUm38EQ+OusyZR7yGt4jopnVdWcB44ZP0rzynAHi9WacwHrrlZejRyB1awqO/YleViN
         sm2JEylH6vP+fxPH1opcsTcR/Pd2ooy8r+bxwFQWLsSLl47O6rvLlkdchdyJt7dKPM2j
         FPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700684335; x=1701289135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjdwjoxEyUek2qg08QWlnX78It6WvNJ/gExSp2uXTbQ=;
        b=clHu/Cm+FWTFE+Y0Kn8A8mC1tZODqhymK40J6hVu5AOdKEN9GBSGwm1UOqz1S5e2IN
         QDrGRYLnXg8L8dTZEt8/+8CR0UnvYjezFy6aCq0g9MVaaZh/kVVSGPK5sVmKeUBs3TBE
         BYKz3nPqPdqkPFC/esGXsLuqA+JZx9g7AbfqIcrt4jUjgo2k1H6s8zGifzB/+EhipvDI
         xTBAX54e/LW1XX0IWFeMeFbe5QvEEg8J0gr9z1cy6xWIzsaemSMumV2Scowv+ISQR+hu
         31K4dPIr7KlnpzUGx7mJyfLhee4yTqzTieY47jxGsz5+XgJRy4Exr0yFtWhIXgW22c8k
         CZcg==
X-Gm-Message-State: AOJu0YwB3XfnAQHZkWl9WkQfiDO71viQBiqB5BaPLt+MLBysZ06o+umy
        Avi8VrnS1ruXSbmqZu8Ppr2oHyn8/vHZtCVHwNg=
X-Google-Smtp-Source: AGHT+IGx2mBDhDnB4nAPDKMBSu/u6Z0FuXZSjyG7p6aud1XyQ1jL3pkSb1dO2aKgBTXDYc1w7h1RfBcdyVUnfSE/Sdg=
X-Received: by 2002:aa7:c499:0:b0:543:5dd9:a72 with SMTP id
 m25-20020aa7c499000000b005435dd90a72mr528030edq.1.1700684334438; Wed, 22 Nov
 2023 12:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20231114164416.208285-1-ubizjak@gmail.com> <367bc727-3f26-4e78-8e58-af959760b3fc@intel.com>
 <CAFULd4ZA2w+rz==cw1e18yJ9sdLpAi8XLZ7JU104yyD0Maspdw@mail.gmail.com> <cabe5db0-5690-430a-bcf9-6c853bf00228@intel.com>
In-Reply-To: <cabe5db0-5690-430a-bcf9-6c853bf00228@intel.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 22 Nov 2023 21:18:26 +0100
Message-ID: <CAFULd4bZPgY5Tw++UikUUF2fjL8teXRC3vfq=7hLeaDRDMgKBA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 6:23=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 11/17/23 08:37, Uros Bizjak wrote:
> > On Fri, Nov 17, 2023 at 5:18=E2=80=AFPM Dave Hansen <dave.hansen@intel.=
com> wrote:
> >> Is there some other side benefit that I'm missing here?  Applying this
> >> patch doesn't seem to have a great risk/reward ratio.
> >
> > Yes, in addition to better asm code, I think that the use of magic
> > constant (-1) is not descriptive at all. I tried to make this code
> > look like nmi_panic() from kernel/panic.c, which has similar
> > functionality, and describe that this constant belongs to old_cpu
> > (same as in nmi_panic() ).
>
> I guess it's a step in the direction of nmi_panic().  But honestly, it
> doesn't go far enough for me at least.  The nice part about nmi_panic()
> is that it gives -1 nice symbolic name and uses that name in the
> definition of the atomic_t.
>
> > Also, from converting many cmpxchg to try_cmpxchg, it becomes evident
> > that in cases like this (usage in "if" clauses) the correct locking
> > primitive is try_cmpxchg. Additionally, in this particular case, it
> > is not the speed, but a little code save that can be achieved with
> > the same functionality.
>
> I think I understand what you're trying to say: using try_cmpxchg can
> result in better code generation in general than plain cmpxchg.  Thus,
> it's more "correct" to use try_cmpxchg in any case where plain cmpxchg
> is in use.  Right?

Yes, when we have the condition "cmpxchg(*ptr, old, new) =3D=3D old", then
using try_cmpxchg not only generates better code (note also how the
compiler creates fast path through the code due to likely/unlikely
annotations), but is also *less* error prone. E.g., there were a
couple of instances where the result of cmpxchg was compared to the
wrong variable.

> I honestly don't think cmpxchg is more or less "correct" than
> try_cmpxchg.  If you're going to be sending patches like these, I'd
> remove this kind of language from your changelogs and discussions
> because it holds zero weight.
>
> Here's what I'm afraid of: this patch is not tested enough.  We apply it
> and then start getting reports of reboot breaking on some server.
> Someone spends two hours bisecting to this patch.  We'll wonder after
> the fact: Was this patch worth it?

Let me just say that after some 50 conversions of code of various
complexity to try_cmpxchg, fixing inconsistencies and plain logic bugs
on the way, removing superfluous memory reads form the loops,
eyeballing generated asm code and persuading relevant maintainers
about the benefit of the conversion, I can confidently say that this
particular conversion won't make troubles.

Even without the proposed conversion, the call to smp_processor_id()
should be put after early exit where reboot_force is checked.

> I don't think what you have here is more descriptive than what was there
> before.  It still has a -1 and still doesn't logically connect it to the
> 'stopping_cpu' definition.  I have no idea how much this was tested.  It
> doesn't _clearly_ move the needle enough on making the code better to
> apply it.

I should state that I test my patches by bootstrapping the image in
qemu, and from time to time put together a bunch of patches and build
a real Fedora kernel rpm and run it for some time as my main kernel.
This last part gives me much confidence when the patch is discussed
with the maintainer. In this particular case, I didn't put much
attention on reboot functionality, but the patched kernel definitely
reboots without problems.

Regarding "-1", I was thinking of introducing a CPU_INVALID #define
instead of -1, but at the end, this #define should be eventually
introduced as a target-independent patch that puts the new define into
the generic part of the kernel source, since it looks like other
targets could use this define as well.

> We shouldn't be blindly converting cmpxchg=3D>try_cmpxchg, and then tryin=
g
> to justify it after the fact.  I _do_ agree that try_cmpxchg() leads to
> better looking C code *AND* generated code.  So, for new x86 code, it
> seems like the best thing to do.  But for old (working) code, I think it
> should mostly be left alone.

I'm not here to discuss policies, but the "don't fix it if it ain't
broke" policy is a slippery slope, as it can lead to stagnation in the
long term. Please read what happened here [1].

[1] https://lwn.net/Articles/488847/

> Maybe you could keep an eye on:
>
> > https://lore.kernel.org/lkml/?q=3Ddfb%3Aatomic_cmpxchg+-dfb%3Aatomic_tr=
y_cmpxchg
>
> and remind folks what they should be using, rather than expending
> efforts on trying to move existing code over.

Yes, I'm doing my best to point out optimization opportunities
involving try_cmpxchg when I come across one. But this one slipped
below my radar...

Thanks and BR,
Uros.
