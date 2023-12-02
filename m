Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E6D801BB7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjLBJky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjLBJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:40:39 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040DC134;
        Sat,  2 Dec 2023 01:40:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso3848415a12.1;
        Sat, 02 Dec 2023 01:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701510043; x=1702114843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hajekK+SOQiGQ9uZZ8YHa+HzqrgJESSVZKl+dIi99I=;
        b=NF9Uz6WDOEPoAZZlR6+xe4pP44XK/3Mxg8LPP5bldZhpENFG+z1nz+3Dya4+CcQNRY
         IqWMTz843nzinlrQxkHFCVqrNY/jCUYNSOW+kUanIwFiae9dcS64TTb71i23yxnDnokI
         7tf5MvJx5kkXdBzlbi+l1l0lQlxykvnLO/tjZWpfQAFRMpXBPrORQYMRzTjzrUViJUoi
         pUZwA3Wr25qI+HzxV3qLv7VoZK2Fpo5T+/TGMs7xPHaAeKu8/vfFGoiJ2xlekDdb1V1U
         4lm63dwTzqeYcLLXrkjlmxA0Y4wGpHFBa36BGotgEp8u9xoj9gsBqWms018kpSatLLAN
         WDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701510043; x=1702114843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hajekK+SOQiGQ9uZZ8YHa+HzqrgJESSVZKl+dIi99I=;
        b=mFC8KKHvV+SEgUKt1lpTWKyjYLccGhL+YGQpsqOqJanokZ1P2IzboHy51vGr01C8Cr
         WtCtkVlVec4WTNm9UOSG+m1m4dNxmnLkTI7ccM+E1A7+FJUCd+lbp54CB1uZKtQ3mMFZ
         nHC109FLOVZYQaLMn6x+/OX6tg5lPfp6+VLy8WKS93nzMThhGmNcBYDbH4vSl13fV14/
         eF8xaZGqQpwTPxpvCqo1Wep+w/d4AAyxg4U+2JyM0N+e9pXv2SEbhjlkdlNK/Xq9gvJ6
         wQtqjWyjmgRyqm6HAzxxwnRR6b8q/gWM32zMbplPqRxkuD+Vs98khRxOH8szPozvrg9O
         plhA==
X-Gm-Message-State: AOJu0Yx8lhF5tnHUhtnwzXUYAY2wR6elW2R3SplR3jy+/4H4P9RMYimR
        JLNIMHbnM4DXmmy+JO4411eennLpZfNXdDYwPMsrfwjaKeOwAA==
X-Google-Smtp-Source: AGHT+IHmzQ+daA9HXEZZf23GwwkJShG/irBHvC2KBndddSqTSL5B8fQKClEKFwkdLrh5YS36S9R9JA8dJu7A+X49x+U=
X-Received: by 2002:a50:f68f:0:b0:54c:79cc:dad1 with SMTP id
 d15-20020a50f68f000000b0054c79ccdad1mr282348edn.54.1701510043069; Sat, 02 Dec
 2023 01:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20231130162949.83518-1-ubizjak@gmail.com> <170137899052.398.2740335306554226817.tip-bot2@tip-bot2>
 <20231201124608.GAZWnVkA03ZrnMJgVs@fat_crate.local> <CAFULd4Y=9kBdtzry+o080fbOk90Faq9WZEOMCh_TQ84iNS4f7w@mail.gmail.com>
In-Reply-To: <CAFULd4Y=9kBdtzry+o080fbOk90Faq9WZEOMCh_TQ84iNS4f7w@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sat, 2 Dec 2023 10:40:28 +0100
Message-ID: <CAFULd4afu_N9=ZhE1jdq2uLisTvgZp+3=djRFtgD3=8VddhpcQ@mail.gmail.com>
Subject: Re: [tip: x86/percpu] x86/percpu: Declare const_pcpu_hot as extern
 const variable
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
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

On Fri, Dec 1, 2023 at 5:41=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Fri, Dec 1, 2023 at 5:25=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
> >
> > On Thu, Nov 30, 2023 at 09:16:30PM -0000, tip-bot2 for Uros Bizjak wrot=
e:
> > > The following commit has been merged into the x86/percpu branch of ti=
p:
> > >
> > > Commit-ID:     4604c052b84d66407f5e68045a1939685eac401e
> > > Gitweb:        https://git.kernel.org/tip/4604c052b84d66407f5e68045a1=
939685eac401e
> > > Author:        Uros Bizjak <ubizjak@gmail.com>
> > > AuthorDate:    Thu, 30 Nov 2023 17:27:35 +01:00
> > > Committer:     Ingo Molnar <mingo@kernel.org>
> > > CommitterDate: Thu, 30 Nov 2023 20:19:33 +01:00
> > >
> > > x86/percpu: Declare const_pcpu_hot as extern const variable
> > >
> > > const_pcpu_hot is aliased by linker to pcpu_hot, so there is no need
> > > to use the DECLARE_PER_CPU_ALIGNED() macro. Also, declare const_pcpu_=
hot
> > > as extern to avoid allocating storage space for the aliased structure=
.
> > >
> > > Fixes: ed2f752e0e0a ("x86/percpu: Introduce const-qualified const_pcp=
u_hot to micro-optimize code generation")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > > Link: https://lore.kernel.org/r/20231130162949.83518-1-ubizjak@gmail.=
com
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202311302257.tSFtZnly-l=
kp@intel.com/
> > > ---
> > >  arch/x86/include/asm/current.h | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/cu=
rrent.h
> > > index 0538d24..9fbd7cb 100644
> > > --- a/arch/x86/include/asm/current.h
> > > +++ b/arch/x86/include/asm/current.h
> > > @@ -37,8 +37,7 @@ static_assert(sizeof(struct pcpu_hot) =3D=3D 64);
> > >  DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
> > >
> > >  /* const-qualified alias to pcpu_hot, aliased by linker. */
> > > -DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
> > > -                     const_pcpu_hot);
> > > +extern const struct pcpu_hot __percpu_seg_override const_pcpu_hot;
> > >
> > >  static __always_inline struct task_struct *get_current(void)
> > >  {
> >
> > WARNING: modpost: EXPORT symbol "const_pcpu_hot" [vmlinux] version gene=
ration failed, symbol will not be versioned.
> > Is "const_pcpu_hot" prototyped in <asm/asm-prototypes.h>?
> > WARNING: modpost: "const_pcpu_hot" [arch/x86/kvm/kvm.ko] has no CRC!
> > WARNING: modpost: "const_pcpu_hot" [arch/x86/kvm/kvm-intel.ko] has no C=
RC!
> > WARNING: modpost: "const_pcpu_hot" [kernel/trace/preemptirq_delay_test.=
ko] has no CRC!
> > WARNING: modpost: "const_pcpu_hot" [fs/exfat/exfat.ko] has no CRC!
> > WARNING: modpost: "const_pcpu_hot" [fs/ntfs/ntfs.ko] has no CRC!
> > WARNING: modpost: "const_pcpu_hot" [fs/xfs/xfs.ko] has no CRC!
> > WARNING: modpost: "const_pcpu_hot" [fs/btrfs/btrfs.ko] has no CRC!
> > WARNING: modpost: "const_pcpu_hot" [drivers/acpi/acpi_pad.ko] has no CR=
C!
> > WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/display/drm_display=
_helper.ko] has no CRC!
> > WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/drm.ko] has no CRC!
> > WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/ttm/ttm.ko] has no =
CRC!
> > WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/i915/i915.ko] has n=
o CRC!
> > WARNING: modpost: "const_pcpu_hot" [drivers/misc/mei/mei.ko] has no CRC=
!
> > WARNING: modpost: "const_pcpu_hot" [drivers/usb/core/usbcore.ko] has no=
 CRC!
> > WARNING: modpost: "const_pcpu_hot" [drivers/usb/class/cdc-acm.ko] has n=
o CRC!
> > WARNING: modpost: "const_pcpu_hot" [drivers/usb/class/usblp.ko] has no =
CRC!
> > WARNING: modpost: "const_pcpu_hot" [drivers/usb/storage/usb-storage.ko]=
 has no CRC!
> >
> > And the usual fix for those things:
> >
> > diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/a=
sm/asm-prototypes.h
> > index b1a98fa38828..7e6440bae63d 100644
> > --- a/arch/x86/include/asm/asm-prototypes.h
> > +++ b/arch/x86/include/asm/asm-prototypes.h
> > @@ -13,6 +13,7 @@
> >  #include <asm/preempt.h>
> >  #include <asm/asm.h>
> >  #include <asm/gsseg.h>
> > +#include <asm/current.h>
> >
> >  #ifndef CONFIG_X86_CMPXCHG64
> >  extern void cmpxchg8b_emu(void);
> >
> > does NOT fix it.
>
> I looked into this problem a bit, it is triggered by CONFIG_MODVERSIONS=
=3Dy
>
> The problem is, that genksyms does not know the __seg_gs keyword and
> simply ignores the symbol.
>
> Running:
>
> make V=3D1 arch/x86/kernel/cpu/common.symtypes
>
> There is NOTHING regarding const_pcpu_hot in the resulting common.symtype=
s file.
>
> The unpatched source should also fail here due to __seg_gs keyword,
> but it magically didn't.
>
> I don't know what to do here.

I have a solution for both problems, genksyms and sparse issue. The
exported declaration should be in generic named address space and the
symbol casted to __seg_gs address space at usage site.

Let me polish and test the patch a bit, I'll post the finished patch tomorr=
ow.

Uros.
