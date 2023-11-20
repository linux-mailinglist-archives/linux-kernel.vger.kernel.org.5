Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE287F0A59
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 02:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjKTBdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 20:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTBde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 20:33:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96C7E6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 17:33:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6630CC433CB;
        Mon, 20 Nov 2023 01:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700444010;
        bh=4aKRWnXGFRDigBEXfTlhbvkBAJbCco+oZ5t5OlcFpdI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EtiCTtkLuYGV9apkfKPyVjisq7pLPUQCAVx9uPT1A+TpwmIA9JStslFknSmJUOmRg
         wBTXIkLVq0fhmHAL2MFQyNGKm3UuY02ywI6pVwH6nW5SJPOjDYzT6siuRmX+vOOSB+
         1qztC63+AZZgDuIpT5mrUb3SOjNgz2RhiXoyFiYRO3n1TnZX3K6l5B1f1cq8QUAE9q
         1l2vLfC0O1u7KT9cKosNQMllTTqQD//jNy1mvXE/65w288vZ7kpOvS/h3y/QT2J/pG
         4xSFCRFRt2iKUV3Uo1JDu4SjUxdNZUtHnj2m6j0PHsA1sOoQr6oP2zIKcaujKkQYop
         TMpu/7CvJ5KCg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so172528a12.2;
        Sun, 19 Nov 2023 17:33:30 -0800 (PST)
X-Gm-Message-State: AOJu0YxNv6nS+m9HKaFpgHlFfKK+IeM4uh+eDdGw0d4/NzygfHH9LRAR
        b3uoi47TuBylOwfyjVh7Udi/peKbFqkWbv4vC1w=
X-Google-Smtp-Source: AGHT+IHQzhTmN1WGQSpS+/Xj3MkxDDNblmBut8i5DlGRtpthh7co7vJFFWfx5mrkhW6l4tNHTclwObeILVuMcrSkC5Q=
X-Received: by 2002:aa7:d491:0:b0:542:eb1f:c70a with SMTP id
 b17-20020aa7d491000000b00542eb1fc70amr4398062edr.29.1700444008824; Sun, 19
 Nov 2023 17:33:28 -0800 (PST)
MIME-Version: 1.0
References: <20231119053448.2367725-1-masahiroy@kernel.org>
 <CAAhV-H6Y4vqc45eaMs+wCN7Quf4e9ogp8aDA8V0sA=TUnMWd-Q@mail.gmail.com> <CAK7LNAR=5s0tbqvB+poMD45Oyjknx9=VpVqE+qwqZy9LfQermQ@mail.gmail.com>
In-Reply-To: <CAK7LNAR=5s0tbqvB+poMD45Oyjknx9=VpVqE+qwqZy9LfQermQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 20 Nov 2023 09:33:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4w1Esxp7pE02nbeh_Wft6=a8Q8MBEr54Q5D3_g9XP1gQ@mail.gmail.com>
Message-ID: <CAAhV-H4w1Esxp7pE02nbeh_Wft6=a8Q8MBEr54Q5D3_g9XP1gQ@mail.gmail.com>
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

Hi, Masahiro,

On Sun, Nov 19, 2023 at 10:25=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Sun, Nov 19, 2023 at 8:59=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Hi, Masahiro,
> >
> > On Sun, Nov 19, 2023 at 1:35=E2=80=AFPM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > A common issue in Makefile is a race in parallel building.
> > >
> > > You need to be careful to prevent multiple threads from writing to th=
e
> > > same file simultaneously.
> > >
> > > Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
> > > generate invalid images") addressed such a bad scenario.
> > >
> > > A similar symptom occurs with the following command:
> > >
> > >   $ make -j$(nproc) ARCH=3Dloongarch vmlinux.efi vmlinuz.efi
> > >     [ snip ]
> > >     SORTTAB vmlinux
> > >     OBJCOPY arch/loongarch/boot/vmlinux.efi
> > >     OBJCOPY arch/loongarch/boot/vmlinux.efi
> > >     PAD     arch/loongarch/boot/vmlinux.bin
> > >     GZIP    arch/loongarch/boot/vmlinuz
> > >     OBJCOPY arch/loongarch/boot/vmlinuz.o
> > >     LD      arch/loongarch/boot/vmlinuz.efi.elf
> > >     OBJCOPY arch/loongarch/boot/vmlinuz.efi
> > >
> > > The log "OBJCOPY arch/loongarch/boot/vmlinux.efi" is displayed twice.
> > >
> > > It indicates that two threads simultaneously enter arch/loongarch/boo=
t/
> > > and write to arch/loongarch/boot/vmlinux.efi.
> > >
> > > It occasionally leads to a build failure:
> > >
> > >   $ make -j$(nproc) ARCH=3Dloongarch vmlinux.efi vmlinuz.efi
> > >     [ snip ]
> > >     SORTTAB vmlinux
> > >     OBJCOPY arch/loongarch/boot/vmlinux.efi
> > >     PAD     arch/loongarch/boot/vmlinux.bin
> > >   truncate: Invalid number: =E2=80=98arch/loongarch/boot/vmlinux.bin=
=E2=80=99
> > >   make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13:
> > >   arch/loongarch/boot/vmlinux.bin] Error 1
> > >   make[2]: *** Deleting file 'arch/loongarch/boot/vmlinux.bin'
> > >   make[1]: *** [arch/loongarch/Makefile:146: vmlinuz.efi] Error 2
> > >   make[1]: *** Waiting for unfinished jobs....
> > >   make: *** [Makefile:234: __sub-make] Error 2
> > >
> > > vmlinuz.efi depends on vmlinux.efi, but such a dependency is not
> > > specified in arch/loongarch/Makefile.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  arch/loongarch/Makefile | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > > index 9eeb0c05f3f4..6022bf3d30c9 100644
> > > --- a/arch/loongarch/Makefile
> > > +++ b/arch/loongarch/Makefile
> > > @@ -142,6 +142,7 @@ vdso-install-y +=3D arch/loongarch/vdso/vdso.so.d=
bg
> > >
> > >  all:   $(notdir $(KBUILD_IMAGE))
> > >
> > > +vmlinuz.efi: vmlinux.efi
> > >  vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
> > >         $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@
> > It is a little strange, because
> >
> > in drivers/firmware/efi/libstub/Makefile.zboot:
> > vmlinuz.efi depends on vmlinuz.efi.elf, vmlinuz.efi.elf depends on
> > vmlinuz.o, vmlinuz.o depends on vmlinuz, vmlinuz depends on
> > vmlinux.bin, vmlinux.bin depends on $(EFI_ZBOOT_PAYLOAD).
> >
> > in arch/loongarch/boot/Makefile,
> > EFI_ZBOOT_PAYLOAD :=3D vmlinux.efi
> >
> > So I think vmlinuz.efi has already depend on vmlinux.efi.
>
>
>
> That is a story in arch/loongarch/boot/Makefile.
>
>
> I am talking about arch/loongarch/Makefile,
> which is included from the top Makefile.
>
>
> See this code.
>
>
> vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
>         $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@
>
>
>
>
> Only the required dependency is
>
>  - vmlinux.elf depends on vmlinux
>  - vmlinuz.elf depends on vmlinux
>
>
> vmlinux.elf and vmlinuz.elf are independent of each other.
>
>
>
> In parallel building, GNU Make considers that
> vmlinux.elf and vmlinuz.elf can be built simultaneously.
>
>
> GNU Make spawns two processes to execute these simultaneously:
>
>  $(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/vmlinux.elf
>  $(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/vmlinuz.elf
>
>
>
> The former enters arch/loongarch/boot/Makefile to build
> vmlinux.elf.  (A)
>
>
> The latter also enters arch/loongarch/boot/Makefile to build
> vmlinuz.elf, which depends on vmlinux.elf  (B)
>
>
>
> (A) and (B) are independent processes, hence none of them
> know the other.
>
>
> I hope it is clearer.
Sorry, I'm not familiar with Makefile rules, so you are probably
right, but should we do it like this (remove the direct dependency
from vmlinuz.efi to vmlinux)?

vmlinuz.efi: vmlinux.efi
vmlinux.elf vmlinux.efi: vmlinux
        $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@

Huacai

>
>
>
>
>
>
> > Huacai
> >
> > >
> > > --
> > > 2.40.1
> > >
> > >
> >
>
>
> --
> Best Regards
> Masahiro Yamada
