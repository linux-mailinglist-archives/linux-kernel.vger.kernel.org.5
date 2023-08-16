Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC87877D929
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbjHPDjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241628AbjHPDer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:34:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD37268D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:34:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bdfb11ea2aso8490925ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692156851; x=1692761651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s57ez6jEsS1mlXueYnpRtikOhhkUWf1Plgf3F/uPYKw=;
        b=D3kY5c7otB48URI4L91Oi1dh1YNd/PvrKaLQK3ZBbo2d4jxndXRJYz+bkr8DM9jEDW
         MqZVu09I82vC0OxYD7givnW+RSBMc1PRdbKCfiXtlxbVgsCclf8C4zhESk2SFVHMk4VY
         31XaENrZekDvtQbUfl8AF6XypVEmocH2DdNdD93FTBytbrK13qyNA0ShDTOEC12HtVZ1
         loBC368GnqzaYdVgrxDrxBeSQcv1Nst25WKpWE0GE7OQOzSA9obqxfzq+8SRRr8AHwl1
         B0/3jP9lW7ReFjpfgZ1i0aDSeCnDgKwtlP2XkA7TjaQdV5oArEqyOQPYbQLLmd+cXuWN
         Bsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692156851; x=1692761651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s57ez6jEsS1mlXueYnpRtikOhhkUWf1Plgf3F/uPYKw=;
        b=HpxgWfrfMiV2Cn5Gq0pv8GR6mLDeR4278gwMSpZ09nHcr7KE77qxMTSsIny5r1yuzg
         jUzj//odUKm3EteOi/24+2+rw+OEW7AkYZFxZ5sOuAls9RsU09z6kLN1pIEcifQvNnhl
         GP7xVkxV49jFVOzhueixpllVbaLPlozYIVoIBE92qMvgZVfmj66Ks0GN39CnuNj4xZqV
         p3g8FwSM9jTvrQKrABYHsrVJ80JkU4Y50HeVaIdmTHGFKUiXXItO87iy7CPFxuyMbsd+
         HuSVdpEt1451DgW0h/VQDfXGtplkihEUni/GgcdmZJGgfctG1LFKLL2CeeE95MXD1krb
         QvAA==
X-Gm-Message-State: AOJu0Yzrah4865N60qn8U7HmoyN7mgCaWZsWuipbO7E0o/Ao268GUKsH
        KPDFIA3GEFJRraew1wqE9GhZAe8DL3VORntzcck=
X-Google-Smtp-Source: AGHT+IFVs4DfoRLLymO44q7IYSnDSlSmssmrPpqcFvhtmRoQ23syYZ7AX2MuDNOSP8auiwpB44pNin2tgTvIUbNE7wQ=
X-Received: by 2002:a17:903:284:b0:1b5:edd:e3c7 with SMTP id
 j4-20020a170903028400b001b50edde3c7mr676746plr.16.1692156851194; Tue, 15 Aug
 2023 20:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <CA+rFky5xK35402EGQ-6VqxT-arR7SWLAcp2PyB1xK9ZGRqhs2A@mail.gmail.com>
 <ZNxCNRzvDN87_MIf@debian.me>
In-Reply-To: <ZNxCNRzvDN87_MIf@debian.me>
From:   Andrew Randrianasulu <randrianasulu@gmail.com>
Date:   Wed, 16 Aug 2023 06:25:30 +0300
Message-ID: <CA+rFky7hhP+=CVrxKArgrjrC6C+8=irLbNEm0PxaiidR8bvFaA@mail.gmail.com>
Subject: Re: Build failure in 6.5-rcX ?
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 6:27=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Fri, Aug 11, 2023 at 11:39:06PM +0300, Andrew Randrianasulu wrote:
> > I was trying to crosscompile linux git
> >
> > 9106536c1aa37bcf60202ad93bb8b94bcd29f3f0
> >
> > Unfortunately I got this error:
> >
> > =3D=3D=3D=3D
> > bash-5.1$ make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-unknown-linux-gnu-
> >   CALL    scripts/checksyscalls.sh
> >   DESCEND objtool
> >   INSTALL libsubcmd_headers
> >   CHK     kernel/kheaders_data.tar.xz
> >   UPD     include/generated/utsversion.h
> >   CC      init/version-timestamp.o
> >   LD      .tmp_vmlinux.kallsyms1
> > arch/x86/kernel/irq.o: In function `__common_interrupt':
> > irq.c:(.text+0x1727): undefined reference to `irq_regs'
> > irq.c:(.text+0x172f): undefined reference to `irq_regs'
> > irq.c:(.text+0x179a): undefined reference to `irq_regs'
> > arch/x86/kernel/irq.o: In function `__sysvec_x86_platform_ipi':
> > irq.c:(.text+0x1897): undefined reference to `irq_regs'
> > irq.c:(.text+0x189f): undefined reference to `irq_regs'
> > arch/x86/kernel/irq.o:irq.c:(.text+0x194a): more undefined references
> > to `irq_regs' follow
> > make[2]: *** [scripts/Makefile.vmlinux:36: vmlinux] =D0=9E=D1=88=D0=B8=
=D0=B1=D0=BA=D0=B0 1
> > make[1]: *** [/dev/shm/linux-2.6/Makefile:1250: vmlinux] =D0=9E=D1=88=
=D0=B8=D0=B1=D0=BA=D0=B0 2
> > make: *** [Makefile:234: __sub-make] =D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=
=B0 2
> >
> > =3D=3D=3D=3D
> >
> > config attached.
> >
> > I use binutils 2.25.1 and gcc 7.5.0 targeting x86_64-unknown-linux-gnu-
> >
> > so my compile line was
> >
> >  make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-unknown-linux-gnu- -j8
> >
> > after adding crosscompiler into PATH
> >
> > I tried to rebuild with make clean, but issue still here.
> >
>
> What system are you running your kernel builds?
>
> And in the future, please run make with V=3D1. Also, try prepending it wi=
th
> LC_ALL=3Den_US.UTF-8 to set compilation messages to English instead of yo=
ur
> language, as people here can understand what's going wrong.

This is Slackware 15.0 i586 (mostly), but I keep kernel as 64-bit.
(so, cross-compiler done by just installing binutils + gcc into /opt/
folder).

This particular failure was fixed by just deleting everything but .git
folder and re-checkout all files.

Thanks for help!

PS: gcc 7.5.0 Line I used with gcc 11.4.0:

setarch i686 .././configure --prefix=3D/opt/kgcc64
--target=3Dx86_64-unknown-linux-gnu --enable-languages=3Dc,c++
--without-headers --with-gnu-ld --with-gnu-as --disable-shared
--disable-threads --disable-libmudflap --disable-libgomp
--disable-libssp --disable-libquadmath --disable-libatomic
--disable-decimal-float --disable-libsanitizer --disable-libvtv
--disable-libitm --disable-libcilkrts  --disable-multilib
--disable-libmpx --disable-libstdcxx

same --target and --prefix was used for binutils.

>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara
