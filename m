Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E34779BC9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 02:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbjHLALF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 20:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjHLALD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:11:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83196120
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:11:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbc64f9a91so21966345ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691799063; x=1692403863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dg9MiA7nh5SOz3FJ153pjnwpbojphQ/hF61TcQ6uRwc=;
        b=S6+flAYWqNzg6adtztUPHDJ9i9nuahBpvcDNYgVPYTz1wiAeiy7lVjHpTZ+wuGeG1a
         CVsZ6hP+CpAhVJNJ+jwh1XaYcv64PhTbeMTMwbcUujIWkemOFWm7xf3xalUMhZMMiHM8
         PeF6FguNeeU3up5PyW1TgEk++XSuaZrg7B7yno+VRXY69egGKs69vhz9HHZT/vrrW3wh
         gWsVEuqAibSVWHgA3oVHyIyaayeZ/0/e9CMCUM0YcARXbDYGg1Lcm7/9n3fsFjKNQVtq
         RcUmiMI3zEL7WaWS11svlhjIVAvPSP3OuBJs/Br28Pnxk1QOt6uEKHfv/miFJcuG6bIE
         iO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691799063; x=1692403863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dg9MiA7nh5SOz3FJ153pjnwpbojphQ/hF61TcQ6uRwc=;
        b=MQD/A3fwnrgPHjvjN8lcCJDQJsLpHO7u6AT75u7m8zWH/E+PAluu4Ci7ttZOOq214J
         JpxsoNLoyfbHheqQMrspswUoF2s+z72fm++UfSCTiD1/DwZ2ZPOjj8hwtPK9+2kh6M2Y
         CgfXgJ7TYUzXApySjqrfvGmK0tsrqYLeW3ni05QvMtahHBr6EBignlRRnheA8bLKH0WG
         KAxxG3l8GxXW12sisyRL4cALj+C3CQbqQBCrRcNT6h2B2JNSwSkE/PgiRRb7cyxz+5wd
         mjL7FxvamDs5YNEUo/D/oHYqy5n8ErKHn/rKAJL0CPRKMAbKuxZCENOglwW0weauXnQ8
         PHVg==
X-Gm-Message-State: AOJu0YzdpyKg+cOD7/AppMr1hnrIZ0SYlEWyufRsVU6Wd6RO840FRmjb
        KaX5CETEHEtqtBl9AOTJgFDqbH7yaK4IMY9jhBMDBkLH
X-Google-Smtp-Source: AGHT+IFPvhT5mgN480GmRvvCA/vtmypk/K94+9U3emqTDW4fhA12XdVhr7X0CrZ4B148NShHx87AN/KBOBt13usIY2E=
X-Received: by 2002:a17:902:bb8c:b0:1b8:aee8:a21c with SMTP id
 m12-20020a170902bb8c00b001b8aee8a21cmr2923450pls.31.1691799062915; Fri, 11
 Aug 2023 17:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+rFky5xK35402EGQ-6VqxT-arR7SWLAcp2PyB1xK9ZGRqhs2A@mail.gmail.com>
 <be96aa3f-f7df-8fa9-02d6-fe26cc01d555@infradead.org> <CA+rFky49=Cj1MaQszHuyYMnuNA0UTBNoVNN4xfjHWujzfkKO8g@mail.gmail.com>
 <ec85db91-39e2-72c4-0b43-f28c0ed3a24a@infradead.org>
In-Reply-To: <ec85db91-39e2-72c4-0b43-f28c0ed3a24a@infradead.org>
From:   Andrew Randrianasulu <randrianasulu@gmail.com>
Date:   Sat, 12 Aug 2023 03:02:29 +0300
Message-ID: <CA+rFky5pDYNciGi4Ri0Ki6Gr4V+aib2wEdagrTk2h_EppHFgqA@mail.gmail.com>
Subject: Re: Build failure in 6.5-rcX ?
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
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

On Sat, Aug 12, 2023 at 3:04=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 8/11/23 16:46, Andrew Randrianasulu wrote:
> >
> >
> > =D1=81=D0=B1, 12 =D0=B0=D0=B2=D0=B3. 2023 =D0=B3., 02:16 Randy Dunlap <=
rdunlap@infradead.org <mailto:rdunlap@infradead.org>>:
> >
> >     Hi,
> >
> >     On 8/11/23 13:39, Andrew Randrianasulu wrote:
> >     > I was trying to crosscompile linux git
> >     >
> >     > 9106536c1aa37bcf60202ad93bb8b94bcd29f3f0
> >     >
> >     > Unfortunately I got this error:
> >     >
> >     > =3D=3D=3D=3D
> >     > bash-5.1$ make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-unknown-linux=
-gnu-
> >     >   CALL    scripts/checksyscalls.sh
> >     >   DESCEND objtool
> >     >   INSTALL libsubcmd_headers
> >     >   CHK     kernel/kheaders_data.tar.xz
> >     >   UPD     include/generated/utsversion.h
> >     >   CC      init/version-timestamp.o
> >     >   LD      .tmp_vmlinux.kallsyms1
> >     > arch/x86/kernel/irq.o: In function `__common_interrupt':
> >     > irq.c:(.text+0x1727): undefined reference to `irq_regs'
> >     > irq.c:(.text+0x172f): undefined reference to `irq_regs'
> >     > irq.c:(.text+0x179a): undefined reference to `irq_regs'
> >     > arch/x86/kernel/irq.o: In function `__sysvec_x86_platform_ipi':
> >     > irq.c:(.text+0x1897): undefined reference to `irq_regs'
> >     > irq.c:(.text+0x189f): undefined reference to `irq_regs'
> >     > arch/x86/kernel/irq.o:irq.c:(.text+0x194a): more undefined refere=
nces
> >     > to `irq_regs' follow
> >     > make[2]: *** [scripts/Makefile.vmlinux:36: vmlinux] =D0=9E=D1=88=
=D0=B8=D0=B1=D0=BA=D0=B0 1
> >     > make[1]: *** [/dev/shm/linux-2.6/Makefile:1250: vmlinux] =D0=9E=
=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 2
> >     > make: *** [Makefile:234: __sub-make] =D0=9E=D1=88=D0=B8=D0=B1=D0=
=BA=D0=B0 2
> >     >
> >
> >     This probably isn't going to help much, but I can't reproduce this =
build error.
> >     I tried native x86_64 build, LLVM build, and command-wise, an x86_6=
4 cross build,
> >     all with no problems.
> >
> >
> > Thanks, I guess this means crosscompiler rebuild for me :)
> >
>
> JFYI, your reply was in HTML, which is not accepted by the vger
> mailing lists, so it won't show up in mailing list archives.

Yeah, mobile gmail client does  this ( and I can't see way to disable that =
).

at least initial email from desktop web gmail interface worked :)

>
> >
> >     > =3D=3D=3D=3D
> >     >
> >     > config attached.
> >     >
> >     > I use binutils 2.25.1 and gcc 7.5.0 targeting x86_64-unknown-linu=
x-gnu-
> >     >
> >     > so my compile line was
> >     >
> >     >  make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-unknown-linux-gnu- -j8
> >     >
> >     > after adding crosscompiler into PATH
> >     >
> >     > I tried to rebuild with make clean, but issue still here.
> >     >
> >     > I am not subscribed to LKML, so please CC me if you have any idea=
 what
> >     > I did wrong ...
> >     > (I try to avoid recompiling whole of gcc over new binutils going =
from
> >     > 2.24-something to 2.25.1, may be my fault lies here ..? I hoped t=
hose
> >     > two versions of binutils close enough for just replacing binutils=
)
> >
> >     --
> >     ~Randy
> >
>
> --
> ~Randy
