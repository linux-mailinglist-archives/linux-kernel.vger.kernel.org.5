Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA3801107
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378534AbjLAQlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378387AbjLAQlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:41:21 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69110A6;
        Fri,  1 Dec 2023 08:41:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54b7ef7f4d5so2843944a12.1;
        Fri, 01 Dec 2023 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701448884; x=1702053684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBCoe9P68J1BvUD57j5ybWcS/HGlu3WqKGKnKAvWToI=;
        b=Z5YE00/HCdBGEFoH6gNcxshazPnGTOQO3tsbHbFTFPf5CS55vffFW9K3MVhbn5A1xj
         JiqgCobedGen+IoeFrpnKAXmjMoR78Cc2OKVSzZTgUxUMybfUEqd0cxvSd2ChI5eNhd9
         b6Yw8PvmTqdfnD1CeCEJAOg5a9dhndgJcilrR3HOXCOwdNoGEJdiWfDnweA5qaV8u6xt
         2blvpaA67oIpKXDVPZTROZOXC7ZMcD5pmKPuhvXPpEIRrg8WoskChWJopsDQuV/AIPam
         cOWnq5cMrLAmbLRkARNj2mmiWsMknck+0g3inrjtOLmg/3xOT3kbCiLNPwEFEAfK9q0x
         pu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701448884; x=1702053684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBCoe9P68J1BvUD57j5ybWcS/HGlu3WqKGKnKAvWToI=;
        b=SE2nOaezG0L59a3S5blRkAlNGy2mu3c3JR7JB6EGMiBhjNHeVPxpS8BnQzI/i74N52
         sfXFrdCQYCokfJMaqAm3rUKRATfiRW7N7RbVFnlWZn3zHypmrSLgV7cX6ZSy5aB8edUa
         NUGSW7+RdW0Szq60+5KoeVRUOirbzOYUtHGQzPIiX3r6Ox231KBT7rMuv/LN9nfJKMwr
         UcZPND+FG3gy6zI3rc+/BBFRIRbeYWk0LyudVuLuGgKIYZInK/S6KkwBx+EkM2y0F7dL
         ZBCm5+4Wxorw8L9zteKfSByO6Ns2y8Rq8zcCeypzDWKHMmy7of1AGD32yk3G5UqlF1Lz
         63xA==
X-Gm-Message-State: AOJu0Yyzm13FWLwj5M1m2OZ10DXPmnKgU6xhXqMrRuKLvN0tpDZc2E5I
        aB7NAXhTPrjbsE6O5fi//KMlrsK2Pz+MjvVw1CE=
X-Google-Smtp-Source: AGHT+IF1tFyDg4QXb8YNuwsvQWvWh5qawucE6c94eA7uFz9H0jYeD62SfhVQANBg3dPZ5YqE08h3ewwMv+V5dL+rOsk=
X-Received: by 2002:a50:aa88:0:b0:54b:29f4:e22c with SMTP id
 q8-20020a50aa88000000b0054b29f4e22cmr1046858edc.20.1701448883536; Fri, 01 Dec
 2023 08:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20231130162949.83518-1-ubizjak@gmail.com> <170137899052.398.2740335306554226817.tip-bot2@tip-bot2>
 <20231201124608.GAZWnVkA03ZrnMJgVs@fat_crate.local>
In-Reply-To: <20231201124608.GAZWnVkA03ZrnMJgVs@fat_crate.local>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 1 Dec 2023 17:41:12 +0100
Message-ID: <CAFULd4Y=9kBdtzry+o080fbOk90Faq9WZEOMCh_TQ84iNS4f7w@mail.gmail.com>
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

On Fri, Dec 1, 2023 at 5:25=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Thu, Nov 30, 2023 at 09:16:30PM -0000, tip-bot2 for Uros Bizjak wrote:
> > The following commit has been merged into the x86/percpu branch of tip:
> >
> > Commit-ID:     4604c052b84d66407f5e68045a1939685eac401e
> > Gitweb:        https://git.kernel.org/tip/4604c052b84d66407f5e68045a193=
9685eac401e
> > Author:        Uros Bizjak <ubizjak@gmail.com>
> > AuthorDate:    Thu, 30 Nov 2023 17:27:35 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Thu, 30 Nov 2023 20:19:33 +01:00
> >
> > x86/percpu: Declare const_pcpu_hot as extern const variable
> >
> > const_pcpu_hot is aliased by linker to pcpu_hot, so there is no need
> > to use the DECLARE_PER_CPU_ALIGNED() macro. Also, declare const_pcpu_ho=
t
> > as extern to avoid allocating storage space for the aliased structure.
> >
> > Fixes: ed2f752e0e0a ("x86/percpu: Introduce const-qualified const_pcpu_=
hot to micro-optimize code generation")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Link: https://lore.kernel.org/r/20231130162949.83518-1-ubizjak@gmail.co=
m
> > Closes: https://lore.kernel.org/oe-kbuild-all/202311302257.tSFtZnly-lkp=
@intel.com/
> > ---
> >  arch/x86/include/asm/current.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/curr=
ent.h
> > index 0538d24..9fbd7cb 100644
> > --- a/arch/x86/include/asm/current.h
> > +++ b/arch/x86/include/asm/current.h
> > @@ -37,8 +37,7 @@ static_assert(sizeof(struct pcpu_hot) =3D=3D 64);
> >  DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
> >
> >  /* const-qualified alias to pcpu_hot, aliased by linker. */
> > -DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
> > -                     const_pcpu_hot);
> > +extern const struct pcpu_hot __percpu_seg_override const_pcpu_hot;
> >
> >  static __always_inline struct task_struct *get_current(void)
> >  {
>
> WARNING: modpost: EXPORT symbol "const_pcpu_hot" [vmlinux] version genera=
tion failed, symbol will not be versioned.
> Is "const_pcpu_hot" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: "const_pcpu_hot" [arch/x86/kvm/kvm.ko] has no CRC!
> WARNING: modpost: "const_pcpu_hot" [arch/x86/kvm/kvm-intel.ko] has no CRC=
!
> WARNING: modpost: "const_pcpu_hot" [kernel/trace/preemptirq_delay_test.ko=
] has no CRC!
> WARNING: modpost: "const_pcpu_hot" [fs/exfat/exfat.ko] has no CRC!
> WARNING: modpost: "const_pcpu_hot" [fs/ntfs/ntfs.ko] has no CRC!
> WARNING: modpost: "const_pcpu_hot" [fs/xfs/xfs.ko] has no CRC!
> WARNING: modpost: "const_pcpu_hot" [fs/btrfs/btrfs.ko] has no CRC!
> WARNING: modpost: "const_pcpu_hot" [drivers/acpi/acpi_pad.ko] has no CRC!
> WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/display/drm_display_h=
elper.ko] has no CRC!
> WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/drm.ko] has no CRC!
> WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/ttm/ttm.ko] has no CR=
C!
> WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/i915/i915.ko] has no =
CRC!
> WARNING: modpost: "const_pcpu_hot" [drivers/misc/mei/mei.ko] has no CRC!
> WARNING: modpost: "const_pcpu_hot" [drivers/usb/core/usbcore.ko] has no C=
RC!
> WARNING: modpost: "const_pcpu_hot" [drivers/usb/class/cdc-acm.ko] has no =
CRC!
> WARNING: modpost: "const_pcpu_hot" [drivers/usb/class/usblp.ko] has no CR=
C!
> WARNING: modpost: "const_pcpu_hot" [drivers/usb/storage/usb-storage.ko] h=
as no CRC!
>
> And the usual fix for those things:
>
> diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm=
/asm-prototypes.h
> index b1a98fa38828..7e6440bae63d 100644
> --- a/arch/x86/include/asm/asm-prototypes.h
> +++ b/arch/x86/include/asm/asm-prototypes.h
> @@ -13,6 +13,7 @@
>  #include <asm/preempt.h>
>  #include <asm/asm.h>
>  #include <asm/gsseg.h>
> +#include <asm/current.h>
>
>  #ifndef CONFIG_X86_CMPXCHG64
>  extern void cmpxchg8b_emu(void);
>
> does NOT fix it.

I looked into this problem a bit, it is triggered by CONFIG_MODVERSIONS=3Dy

The problem is, that genksyms does not know the __seg_gs keyword and
simply ignores the symbol.

Running:

make V=3D1 arch/x86/kernel/cpu/common.symtypes

There is NOTHING regarding const_pcpu_hot in the resulting common.symtypes =
file.

The unpatched source should also fail here due to __seg_gs keyword,
but it magically didn't.

I don't know what to do here.

Uros.
