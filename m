Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCB07F0BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 07:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjKTGNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 01:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTGN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 01:13:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C589D7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 22:13:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D608C433CB;
        Mon, 20 Nov 2023 06:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700460803;
        bh=K9MbVLMSv4EVE6SLbElz+8oAQhZAeOF2kn5isepi8y0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nUGjHdQNzq4dfzl4vf6XdZM8XVMXebiJHsDYGbSR0/rEqHa9dI3w5sRh2/quNZpxe
         RpwYDbbSYfou0vFn0Zr0pdJKKm585zHg/ZBScqqlGhie1/5BanWkA5WsLnJDuWC2xc
         LWpWF3G5QmYMs5Hqed1my8jm+cVUnSmerkHW3Euqj0DQLZ/2NqY/hc99yDo494uLXx
         dHuGeLsK+fDS40BMQ9qzTKotZRW46YhWvk/8zNPi/nS55SyvGtfHl6wg/dHcY5A23z
         WsB3W2RCp8Y9sG79+UqMHCD4P/+mvG+ujJ3PcmvwG+7COqYNFdT0nsBO+yuDikDFRz
         CdNAovp6BlMtA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-507f1c29f25so5266055e87.1;
        Sun, 19 Nov 2023 22:13:22 -0800 (PST)
X-Gm-Message-State: AOJu0Ywd4+hE7EHAfzsi45+f2Xx7FhoqxEGYdzkrC41kPs3DE7OJsD5p
        S86FHQ7OBYcRSsMyMtxHhXmBbA9DqG3aquXQLIk=
X-Google-Smtp-Source: AGHT+IHb6p9IJTFLDUf4ScBJV3BAFVXwgFeNSZ4PSi6nKS0IsX1RdQpejzvc39T/8XzH5Wb0yNeu4wFElUmVrTWqlEc=
X-Received: by 2002:a05:6512:208:b0:509:75b8:637b with SMTP id
 a8-20020a056512020800b0050975b8637bmr4758832lfo.30.1700460801187; Sun, 19 Nov
 2023 22:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20231119053448.2367725-1-masahiroy@kernel.org>
 <CAAhV-H6Y4vqc45eaMs+wCN7Quf4e9ogp8aDA8V0sA=TUnMWd-Q@mail.gmail.com>
 <CAK7LNAR=5s0tbqvB+poMD45Oyjknx9=VpVqE+qwqZy9LfQermQ@mail.gmail.com>
 <CAAhV-H4w1Esxp7pE02nbeh_Wft6=a8Q8MBEr54Q5D3_g9XP1gQ@mail.gmail.com> <CAK7LNAQi=cNK4cax76F8=f1tQC8fFRyu0SQmbiKiHTRsoat6Og@mail.gmail.com>
In-Reply-To: <CAK7LNAQi=cNK4cax76F8=f1tQC8fFRyu0SQmbiKiHTRsoat6Og@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 20 Nov 2023 14:13:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7GiQ=+kU9xH09pL89QYSKOhBEcT5L55wPhXuoDkL37Yg@mail.gmail.com>
Message-ID: <CAAhV-H7GiQ=+kU9xH09pL89QYSKOhBEcT5L55wPhXuoDkL37Yg@mail.gmail.com>
Subject: Re: [PATCH] loongarch: add dependency between vmlinuz.efi and vmlinux.efi
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 12:45=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Mon, Nov 20, 2023 at 10:33=E2=80=AFAM Huacai Chen <chenhuacai@kernel.o=
rg> wrote:
> >
> > Hi, Masahiro,
> >
> > On Sun, Nov 19, 2023 at 10:25=E2=80=AFPM Masahiro Yamada <masahiroy@ker=
nel.org> wrote:
> > >
> > > On Sun, Nov 19, 2023 at 8:59=E2=80=AFPM Huacai Chen <chenhuacai@kerne=
l.org> wrote:
> > > >
> > > > Hi, Masahiro,
> > > >
> > > > On Sun, Nov 19, 2023 at 1:35=E2=80=AFPM Masahiro Yamada <masahiroy@=
kernel.org> wrote:
> > > > >
> > > > > A common issue in Makefile is a race in parallel building.
> > > > >
> > > > > You need to be careful to prevent multiple threads from writing t=
o the
> > > > > same file simultaneously.
> > > > >
> > > > > Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to=
 not
> > > > > generate invalid images") addressed such a bad scenario.
> > > > >
> > > > > A similar symptom occurs with the following command:
> > > > >
> > > > >   $ make -j$(nproc) ARCH=3Dloongarch vmlinux.efi vmlinuz.efi
> > > > >     [ snip ]
> > > > >     SORTTAB vmlinux
> > > > >     OBJCOPY arch/loongarch/boot/vmlinux.efi
> > > > >     OBJCOPY arch/loongarch/boot/vmlinux.efi
> > > > >     PAD     arch/loongarch/boot/vmlinux.bin
> > > > >     GZIP    arch/loongarch/boot/vmlinuz
> > > > >     OBJCOPY arch/loongarch/boot/vmlinuz.o
> > > > >     LD      arch/loongarch/boot/vmlinuz.efi.elf
> > > > >     OBJCOPY arch/loongarch/boot/vmlinuz.efi
> > > > >
> > > > > The log "OBJCOPY arch/loongarch/boot/vmlinux.efi" is displayed tw=
ice.
> > > > >
> > > > > It indicates that two threads simultaneously enter arch/loongarch=
/boot/
> > > > > and write to arch/loongarch/boot/vmlinux.efi.
> > > > >
> > > > > It occasionally leads to a build failure:
> > > > >
> > > > >   $ make -j$(nproc) ARCH=3Dloongarch vmlinux.efi vmlinuz.efi
> > > > >     [ snip ]
> > > > >     SORTTAB vmlinux
> > > > >     OBJCOPY arch/loongarch/boot/vmlinux.efi
> > > > >     PAD     arch/loongarch/boot/vmlinux.bin
> > > > >   truncate: Invalid number: =E2=80=98arch/loongarch/boot/vmlinux.=
bin=E2=80=99
> > > > >   make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13:
> > > > >   arch/loongarch/boot/vmlinux.bin] Error 1
> > > > >   make[2]: *** Deleting file 'arch/loongarch/boot/vmlinux.bin'
> > > > >   make[1]: *** [arch/loongarch/Makefile:146: vmlinuz.efi] Error 2
> > > > >   make[1]: *** Waiting for unfinished jobs....
> > > > >   make: *** [Makefile:234: __sub-make] Error 2
> > > > >
> > > > > vmlinuz.efi depends on vmlinux.efi, but such a dependency is not
> > > > > specified in arch/loongarch/Makefile.
> > > > >
> > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > ---
> > > > >
> > > > >  arch/loongarch/Makefile | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > > > > index 9eeb0c05f3f4..6022bf3d30c9 100644
> > > > > --- a/arch/loongarch/Makefile
> > > > > +++ b/arch/loongarch/Makefile
> > > > > @@ -142,6 +142,7 @@ vdso-install-y +=3D arch/loongarch/vdso/vdso.=
so.dbg
> > > > >
> > > > >  all:   $(notdir $(KBUILD_IMAGE))
> > > > >
> > > > > +vmlinuz.efi: vmlinux.efi
> > > > >  vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
> > > > >         $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@
> > > > It is a little strange, because
> > > >
> > > > in drivers/firmware/efi/libstub/Makefile.zboot:
> > > > vmlinuz.efi depends on vmlinuz.efi.elf, vmlinuz.efi.elf depends on
> > > > vmlinuz.o, vmlinuz.o depends on vmlinuz, vmlinuz depends on
> > > > vmlinux.bin, vmlinux.bin depends on $(EFI_ZBOOT_PAYLOAD).
> > > >
> > > > in arch/loongarch/boot/Makefile,
> > > > EFI_ZBOOT_PAYLOAD :=3D vmlinux.efi
> > > >
> > > > So I think vmlinuz.efi has already depend on vmlinux.efi.
> > >
> > >
> > >
> > > That is a story in arch/loongarch/boot/Makefile.
> > >
> > >
> > > I am talking about arch/loongarch/Makefile,
> > > which is included from the top Makefile.
> > >
> > >
> > > See this code.
> > >
> > >
> > > vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
> > >         $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@
> > >
> > >
> > >
> > >
> > > Only the required dependency is
> > >
> > >  - vmlinux.elf depends on vmlinux
> > >  - vmlinuz.elf depends on vmlinux
> > >
> > >
> > > vmlinux.elf and vmlinuz.elf are independent of each other.
> > >
> > >
> > >
> > > In parallel building, GNU Make considers that
> > > vmlinux.elf and vmlinuz.elf can be built simultaneously.
> > >
> > >
> > > GNU Make spawns two processes to execute these simultaneously:
> > >
> > >  $(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/vmlinux.elf
> > >  $(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/vmlinuz.elf
> > >
> > >
> > >
> > > The former enters arch/loongarch/boot/Makefile to build
> > > vmlinux.elf.  (A)
> > >
> > >
> > > The latter also enters arch/loongarch/boot/Makefile to build
> > > vmlinuz.elf, which depends on vmlinux.elf  (B)
> > >
> > >
> > >
> > > (A) and (B) are independent processes, hence none of them
> > > know the other.
> > >
> > >
> > > I hope it is clearer.
> > Sorry, I'm not familiar with Makefile rules, so you are probably
> > right, but should we do it like this (remove the direct dependency
> > from vmlinuz.efi to vmlinux)?
> >
> > vmlinuz.efi: vmlinux.efi
> > vmlinux.elf vmlinux.efi: vmlinux
> >         $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@
>
>
>
> No.
>
> It would create only vmlinux.efi because there is
> no recipe line for vmlinuz.efi
>
>
>
>
> vmlinuz.efi: vmlinux.efi
>         $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@
> vmlinux.elf vmlinux.efi: vmlinux
>         $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@
>
>
> will work, but I do not want to repeat the same recipe line.
>
OK, I know, thank you very much. This patch will be applied to loongarch-fi=
xes.

Huacai

>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> > Huacai
> >
> > >
> > >
> > >
> > >
> > >
> > >
> > > > Huacai
> > > >
> > > > >
> > > > > --
> > > > > 2.40.1
> > > > >
> > > > >
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > > Masahiro Yamada
>
>
>
> --
> Best Regards
> Masahiro Yamada
