Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6227ED4F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344893AbjKOU7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344916AbjKOU7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:59:20 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A9C2695;
        Wed, 15 Nov 2023 12:58:43 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so190980a12.0;
        Wed, 15 Nov 2023 12:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700081921; x=1700686721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r4jyRcgvxW7jDaR+TEUfRnfk5XkJd3nDCtIC2+1lJY=;
        b=lnTIHydBjIpQB0yRTHmqnNU3HpT0Z31fDGXbWyzbXG2IQMpiZZa4wnWMk7phFNRhGY
         1ltcX43V3GLZHIyBeLNvqzansf6qxAP98UYm01ZfJGxzWCljLqpOwYboLujsOIzldoAU
         3JVWwZwyQ4pbEqX1qy7nJXNhguVVkEwgv6jpM5w2omTOEmJivofuuvOrccqoiAgCT0Ko
         jVrv97Tz3+SwchhLQ+XIf/w3UmMfkbQknr+holL3tr1sEfq6Ph4emradcDBbg86m2vPf
         /Y57bGRbfdf2r4VmgUID8dw5SitGXnTgHxuBrTcT7cNQWV2TMDh7bUi6NZfK7E5p/aVv
         ymFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700081921; x=1700686721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/r4jyRcgvxW7jDaR+TEUfRnfk5XkJd3nDCtIC2+1lJY=;
        b=I/k2XZKKavm4KLLa2P/AfPZif91cIiiQVAj10zs8MCS5zjGI0QPf163LEIZHiJ+03+
         B8m+AlG/iRuacM99FJqEKquzweXrzeDJ2owV6zb2K3AbMNXx/sOhKja/nAkY1keZQALS
         AYISE9MUXlhnGJaM7vRWk0AlERFOdspfCQozY8k//4lk8bi30bhkvi7t/3Z24PcUw/c1
         sJzCVhTWi1op58r3tK1wNOam5A4TjxGF9Chf1T3RZpsx1p9WxO+lA0Cw2qo4b54UIKaZ
         7Zw0vAqLhWj11U27XyyAJKu3+rz35ZrR1LiHDt7iFMsTK5sgzIWCG3IS09IhlZeBsHu/
         sj+Q==
X-Gm-Message-State: AOJu0YyLNI7fgRBGw5gg4RrgUNi+ojkSMTfa+d5prNX5lfXPmGiad1LU
        g8oJ15L5u89Q4es7+jMDLGGKa1gCg8ZLvwAi8c1MgBQMgEI=
X-Google-Smtp-Source: AGHT+IGbGdg/XrAaoTrtTipKL3GPylRfg1cxuAm0xJ3+qT6MMFV2Na+2kP8t//9D3vZEQTaI7Baedcg5Zcj48B95TNQ=
X-Received: by 2002:a05:6402:1859:b0:53e:1f7d:10f2 with SMTP id
 v25-20020a056402185900b0053e1f7d10f2mr11582797edy.10.1700081921281; Wed, 15
 Nov 2023 12:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20231114170038.381634-1-ubizjak@gmail.com> <SN6PR02MB41570168279C428D385ADCB0D4B1A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41570168279C428D385ADCB0D4B1A@SN6PR02MB4157.namprd02.prod.outlook.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 15 Nov 2023 21:58:29 +0100
Message-ID: <CAFULd4Z3DZh0SoEyNHfz3=DM2CkDGtNP_f1gVx64NJkzmWp-Pw@mail.gmail.com>
Subject: Re: [PATCH] x86/hyperv: Use atomic_try_cmpxchg() to micro-optimize hv_nmi_unknown()
To:     Michael Kelley <mhklinux@outlook.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
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

On Wed, Nov 15, 2023 at 6:19=E2=80=AFPM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Uros Bizjak <ubizjak@gmail.com> Sent: Tuesday, November 14, 2023 8:=
59 AM
> >
> > Use atomic_try_cmpxchg() instead of atomic_cmpxchg(*ptr, old, new) =3D=
=3D old
> > in hv_nmi_unknown(). On x86 the CMPXCHG instruction returns success in
> > the ZF flag, so this change saves a compare after CMPXCHG. The generate=
d
> > asm code improves from:
> >
> >   3e: 65 8b 15 00 00 00 00    mov    %gs:0x0(%rip),%edx
> >   45: b8 ff ff ff ff          mov    $0xffffffff,%eax
> >   4a: f0 0f b1 15 00 00 00    lock cmpxchg %edx,0x0(%rip)
> >   51: 00
> >   52: 83 f8 ff                cmp    $0xffffffff,%eax
> >   55: 0f 95 c0                setne  %al
> >
> > to:
> >
> >   3e: 65 8b 15 00 00 00 00    mov    %gs:0x0(%rip),%edx
> >   45: b8 ff ff ff ff          mov    $0xffffffff,%eax
> >   4a: f0 0f b1 15 00 00 00    lock cmpxchg %edx,0x0(%rip)
> >   51: 00
> >   52: 0f 95 c0                setne  %al
> >
> > No functional change intended.
> >
> > Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Wei Liu <wei.liu@kernel.org>
> > Cc: Dexuan Cui <decui@microsoft.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c
> > b/arch/x86/kernel/cpu/mshyperv.c index e6bba12c759c..01fa06dd06b6
> > 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -262,11 +262,14 @@ static uint32_t  __init ms_hyperv_platform(void)
> > static int hv_nmi_unknown(unsigned int val, struct pt_regs *regs)  {
> >       static atomic_t nmi_cpu =3D ATOMIC_INIT(-1);
> > +     unsigned int old_cpu, this_cpu;
> >
> >       if (!unknown_nmi_panic)
> >               return NMI_DONE;
> >
> > -     if (atomic_cmpxchg(&nmi_cpu, -1, raw_smp_processor_id()) !=3D -1)
> > +     old_cpu =3D -1;
> > +     this_cpu =3D raw_smp_processor_id();
> > +     if (!atomic_try_cmpxchg(&nmi_cpu, &old_cpu, this_cpu))
> >               return NMI_HANDLED;
> >
> >       return NMI_DONE;
> > --
> > 2.41.0
>
> The change looks correct to me.  But is there any motivation other
> than saving 3 bytes of generated code?  This is not a performance
> sensitive path.  And the change adds 3 lines of source code.  So
> I wonder if the change is worth the churn.

Yes, I was trying to make the function more easy to understand and
similar to nmi_panic() from kernel/panic.c. I had also the idea of
using CPU_INVALID #define instead of -1, but IMO, the above works as
well.

> In any case,
>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Thanks,
Uros.
