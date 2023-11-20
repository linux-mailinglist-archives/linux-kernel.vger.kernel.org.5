Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAD27F0B78
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjKTEpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 23:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTEpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 23:45:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EE39F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:45:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAEDC433C8;
        Mon, 20 Nov 2023 04:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700455538;
        bh=2ORYR1fAsPIpzl2loAbE5pAuaPxD6cGbpqol8Q2B9Gs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SnFL+sj6nIIeRZ6I0L67pNEO43BJAgi+2rTyLqD7JAdIzm7vCFWjyac7/IrM58s4L
         kenELyD0oQTFsCmRSTZnLOyo9oUYkIOvrS8EVzLpUukfrggU4dzgAKgcIKc9+0t9gL
         HjAPLt2HHx9GARVHx3SOsbNcjYjZuNKcjyb1drPkk3+rjSHTiT7ZGaxigHJhkOmvct
         68dIGgps4VWaiUnrJaRY2klxmT0n9b3WNfd+pMoHNulvBk14Dy96yZpvt8BzQ785we
         oC1Oni1gZjti1ThpP/HdMR/e3DSgIKv2236E05+fRFBehBimUy9EIu0tT1/urM4fhd
         tvZXcXpbYBjEA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1f5d34235dbso722818fac.0;
        Sun, 19 Nov 2023 20:45:38 -0800 (PST)
X-Gm-Message-State: AOJu0YyrFSWD7rL/zm9eOu3JDOBq7ioo+mgK+qvd+buxV1J3qEHEMtMi
        UUas8l5LCez9kW5io76TNtEQVPjRL1A5RH9MgpM=
X-Google-Smtp-Source: AGHT+IE1a+VgBCKiYcB7lbun5xEvL/Rw2dJqzYV8WF63fbxvBO66bebU9T7wXir/VxBcAdbjOXh7Ria4NxquJMOKgC4=
X-Received: by 2002:a05:6870:1d12:b0:1f5:c70c:aa78 with SMTP id
 pa18-20020a0568701d1200b001f5c70caa78mr3410814oab.24.1700455537421; Sun, 19
 Nov 2023 20:45:37 -0800 (PST)
MIME-Version: 1.0
References: <20231119053448.2367725-1-masahiroy@kernel.org>
 <CAAhV-H6Y4vqc45eaMs+wCN7Quf4e9ogp8aDA8V0sA=TUnMWd-Q@mail.gmail.com>
 <CAK7LNAR=5s0tbqvB+poMD45Oyjknx9=VpVqE+qwqZy9LfQermQ@mail.gmail.com> <CAAhV-H4w1Esxp7pE02nbeh_Wft6=a8Q8MBEr54Q5D3_g9XP1gQ@mail.gmail.com>
In-Reply-To: <CAAhV-H4w1Esxp7pE02nbeh_Wft6=a8Q8MBEr54Q5D3_g9XP1gQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 20 Nov 2023 13:45:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQi=cNK4cax76F8=f1tQC8fFRyu0SQmbiKiHTRsoat6Og@mail.gmail.com>
Message-ID: <CAK7LNAQi=cNK4cax76F8=f1tQC8fFRyu0SQmbiKiHTRsoat6Og@mail.gmail.com>
Subject: Re: [PATCH] loongarch: add dependency between vmlinuz.efi and vmlinux.efi
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:33=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Masahiro,
>
> On Sun, Nov 19, 2023 at 10:25=E2=80=AFPM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> >
> > On Sun, Nov 19, 2023 at 8:59=E2=80=AFPM Huacai Chen <chenhuacai@kernel.=
org> wrote:
> > >
> > > Hi, Masahiro,
> > >
> > > On Sun, Nov 19, 2023 at 1:35=E2=80=AFPM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > A common issue in Makefile is a race in parallel building.
> > > >
> > > > You need to be careful to prevent multiple threads from writing to =
the
> > > > same file simultaneously.
> > > >
> > > > Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to n=
ot
> > > > generate invalid images") addressed such a bad scenario.
> > > >
> > > > A similar symptom occurs with the following command:
> > > >
> > > >   $ make -j$(nproc) ARCH=3Dloongarch vmlinux.efi vmlinuz.efi
> > > >     [ snip ]
> > > >     SORTTAB vmlinux
> > > >     OBJCOPY arch/loongarch/boot/vmlinux.efi
> > > >     OBJCOPY arch/loongarch/boot/vmlinux.efi
> > > >     PAD     arch/loongarch/boot/vmlinux.bin
> > > >     GZIP    arch/loongarch/boot/vmlinuz
> > > >     OBJCOPY arch/loongarch/boot/vmlinuz.o
> > > >     LD      arch/loongarch/boot/vmlinuz.efi.elf
> > > >     OBJCOPY arch/loongarch/boot/vmlinuz.efi
> > > >
> > > > The log "OBJCOPY arch/loongarch/boot/vmlinux.efi" is displayed twic=
e.
> > > >
> > > > It indicates that two threads simultaneously enter arch/loongarch/b=
oot/
> > > > and write to arch/loongarch/boot/vmlinux.efi.
> > > >
> > > > It occasionally leads to a build failure:
> > > >
> > > >   $ make -j$(nproc) ARCH=3Dloongarch vmlinux.efi vmlinuz.efi
> > > >     [ snip ]
> > > >     SORTTAB vmlinux
> > > >     OBJCOPY arch/loongarch/boot/vmlinux.efi
> > > >     PAD     arch/loongarch/boot/vmlinux.bin
> > > >   truncate: Invalid number: =E2=80=98arch/loongarch/boot/vmlinux.bi=
n=E2=80=99
> > > >   make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13:
> > > >   arch/loongarch/boot/vmlinux.bin] Error 1
> > > >   make[2]: *** Deleting file 'arch/loongarch/boot/vmlinux.bin'
> > > >   make[1]: *** [arch/loongarch/Makefile:146: vmlinuz.efi] Error 2
> > > >   make[1]: *** Waiting for unfinished jobs....
> > > >   make: *** [Makefile:234: __sub-make] Error 2
> > > >
> > > > vmlinuz.efi depends on vmlinux.efi, but such a dependency is not
> > > > specified in arch/loongarch/Makefile.
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > > >
> > > >  arch/loongarch/Makefile | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > > > index 9eeb0c05f3f4..6022bf3d30c9 100644
> > > > --- a/arch/loongarch/Makefile
> > > > +++ b/arch/loongarch/Makefile
> > > > @@ -142,6 +142,7 @@ vdso-install-y +=3D arch/loongarch/vdso/vdso.so=
.dbg
> > > >
> > > >  all:   $(notdir $(KBUILD_IMAGE))
> > > >
> > > > +vmlinuz.efi: vmlinux.efi
> > > >  vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
> > > >         $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@
> > > It is a little strange, because
> > >
> > > in drivers/firmware/efi/libstub/Makefile.zboot:
> > > vmlinuz.efi depends on vmlinuz.efi.elf, vmlinuz.efi.elf depends on
> > > vmlinuz.o, vmlinuz.o depends on vmlinuz, vmlinuz depends on
> > > vmlinux.bin, vmlinux.bin depends on $(EFI_ZBOOT_PAYLOAD).
> > >
> > > in arch/loongarch/boot/Makefile,
> > > EFI_ZBOOT_PAYLOAD :=3D vmlinux.efi
> > >
> > > So I think vmlinuz.efi has already depend on vmlinux.efi.
> >
> >
> >
> > That is a story in arch/loongarch/boot/Makefile.
> >
> >
> > I am talking about arch/loongarch/Makefile,
> > which is included from the top Makefile.
> >
> >
> > See this code.
> >
> >
> > vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
> >         $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@
> >
> >
> >
> >
> > Only the required dependency is
> >
> >  - vmlinux.elf depends on vmlinux
> >  - vmlinuz.elf depends on vmlinux
> >
> >
> > vmlinux.elf and vmlinuz.elf are independent of each other.
> >
> >
> >
> > In parallel building, GNU Make considers that
> > vmlinux.elf and vmlinuz.elf can be built simultaneously.
> >
> >
> > GNU Make spawns two processes to execute these simultaneously:
> >
> >  $(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/vmlinux.elf
> >  $(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/vmlinuz.elf
> >
> >
> >
> > The former enters arch/loongarch/boot/Makefile to build
> > vmlinux.elf.  (A)
> >
> >
> > The latter also enters arch/loongarch/boot/Makefile to build
> > vmlinuz.elf, which depends on vmlinux.elf  (B)
> >
> >
> >
> > (A) and (B) are independent processes, hence none of them
> > know the other.
> >
> >
> > I hope it is clearer.
> Sorry, I'm not familiar with Makefile rules, so you are probably
> right, but should we do it like this (remove the direct dependency
> from vmlinuz.efi to vmlinux)?
>
> vmlinuz.efi: vmlinux.efi
> vmlinux.elf vmlinux.efi: vmlinux
>         $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@



No.

It would create only vmlinux.efi because there is
no recipe line for vmlinuz.efi




vmlinuz.efi: vmlinux.efi
        $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@
vmlinux.elf vmlinux.efi: vmlinux
        $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@


will work, but I do not want to repeat the same recipe line.
















> Huacai
>
> >
> >
> >
> >
> >
> >
> > > Huacai
> > >
> > > >
> > > > --
> > > > 2.40.1
> > > >
> > > >
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada



--=20
Best Regards
Masahiro Yamada
