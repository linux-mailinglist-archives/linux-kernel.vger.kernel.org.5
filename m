Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB7A7F06D5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 15:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjKSOZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 09:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKSOZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 09:25:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FCFBA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 06:25:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AC8C433CA;
        Sun, 19 Nov 2023 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700403915;
        bh=0dtY30CPhZvn8O3z06NpRjrEuqxkR7+uYsOGb9dcdao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X6CvpV61YxVyRWd6/vtT+AoaD9pZ0tj3uNT7niektNZOuOBPq9FijgTIDSuKq9qTh
         Y/EJ8XnpTLJbrG/43spnOC9yPoGR3DI1CN3txOTfgS67g6m5J1bUqfqmwYWHS17/Ri
         tUedtEvN/I84NPcWt61kY3kdXNiZFgQ2RN8pckRIg6ewg8IBkJKBGmxutEsWs/qsJw
         oa2+ffB//dBMhhgbezkRUo2P6Us9rd5kKGBfXXkV5ZLpyVrjV+UqgNSuWk2ufgg+lk
         JGWB+brPzLT3Qk49pZXjQ6iCUYJIOEL/NXnrlooMrJZTGDkcsknNpqqeoRiVfwHbDB
         wA7o8aXf+RrVg==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1f03d9ad89fso2046732fac.1;
        Sun, 19 Nov 2023 06:25:15 -0800 (PST)
X-Gm-Message-State: AOJu0YyQuh7l3zhEIuRPqOnz85GmeddD7AtZqRK/dlHB4WGsiTBRdfmB
        JSjkJdIlxd/FpdXNglSxIvQTNVbyj82t1MIjs9o=
X-Google-Smtp-Source: AGHT+IHJpfIjTfreDOkdOpR6jVoSn28hEJNeNmNeVKncjPpKurUL2SYs2KUq63HLBYgxqyBXs5/CPxxExorqXjiUkXk=
X-Received: by 2002:a05:6870:e09:b0:1e9:9aa5:997b with SMTP id
 mp9-20020a0568700e0900b001e99aa5997bmr5841334oab.20.1700403915009; Sun, 19
 Nov 2023 06:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20231119053448.2367725-1-masahiroy@kernel.org> <CAAhV-H6Y4vqc45eaMs+wCN7Quf4e9ogp8aDA8V0sA=TUnMWd-Q@mail.gmail.com>
In-Reply-To: <CAAhV-H6Y4vqc45eaMs+wCN7Quf4e9ogp8aDA8V0sA=TUnMWd-Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Nov 2023 23:24:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR=5s0tbqvB+poMD45Oyjknx9=VpVqE+qwqZy9LfQermQ@mail.gmail.com>
Message-ID: <CAK7LNAR=5s0tbqvB+poMD45Oyjknx9=VpVqE+qwqZy9LfQermQ@mail.gmail.com>
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

On Sun, Nov 19, 2023 at 8:59=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Masahiro,
>
> On Sun, Nov 19, 2023 at 1:35=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > A common issue in Makefile is a race in parallel building.
> >
> > You need to be careful to prevent multiple threads from writing to the
> > same file simultaneously.
> >
> > Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
> > generate invalid images") addressed such a bad scenario.
> >
> > A similar symptom occurs with the following command:
> >
> >   $ make -j$(nproc) ARCH=3Dloongarch vmlinux.efi vmlinuz.efi
> >     [ snip ]
> >     SORTTAB vmlinux
> >     OBJCOPY arch/loongarch/boot/vmlinux.efi
> >     OBJCOPY arch/loongarch/boot/vmlinux.efi
> >     PAD     arch/loongarch/boot/vmlinux.bin
> >     GZIP    arch/loongarch/boot/vmlinuz
> >     OBJCOPY arch/loongarch/boot/vmlinuz.o
> >     LD      arch/loongarch/boot/vmlinuz.efi.elf
> >     OBJCOPY arch/loongarch/boot/vmlinuz.efi
> >
> > The log "OBJCOPY arch/loongarch/boot/vmlinux.efi" is displayed twice.
> >
> > It indicates that two threads simultaneously enter arch/loongarch/boot/
> > and write to arch/loongarch/boot/vmlinux.efi.
> >
> > It occasionally leads to a build failure:
> >
> >   $ make -j$(nproc) ARCH=3Dloongarch vmlinux.efi vmlinuz.efi
> >     [ snip ]
> >     SORTTAB vmlinux
> >     OBJCOPY arch/loongarch/boot/vmlinux.efi
> >     PAD     arch/loongarch/boot/vmlinux.bin
> >   truncate: Invalid number: =E2=80=98arch/loongarch/boot/vmlinux.bin=E2=
=80=99
> >   make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13:
> >   arch/loongarch/boot/vmlinux.bin] Error 1
> >   make[2]: *** Deleting file 'arch/loongarch/boot/vmlinux.bin'
> >   make[1]: *** [arch/loongarch/Makefile:146: vmlinuz.efi] Error 2
> >   make[1]: *** Waiting for unfinished jobs....
> >   make: *** [Makefile:234: __sub-make] Error 2
> >
> > vmlinuz.efi depends on vmlinux.efi, but such a dependency is not
> > specified in arch/loongarch/Makefile.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/loongarch/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index 9eeb0c05f3f4..6022bf3d30c9 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -142,6 +142,7 @@ vdso-install-y +=3D arch/loongarch/vdso/vdso.so.dbg
> >
> >  all:   $(notdir $(KBUILD_IMAGE))
> >
> > +vmlinuz.efi: vmlinux.efi
> >  vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
> >         $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@
> It is a little strange, because
>
> in drivers/firmware/efi/libstub/Makefile.zboot:
> vmlinuz.efi depends on vmlinuz.efi.elf, vmlinuz.efi.elf depends on
> vmlinuz.o, vmlinuz.o depends on vmlinuz, vmlinuz depends on
> vmlinux.bin, vmlinux.bin depends on $(EFI_ZBOOT_PAYLOAD).
>
> in arch/loongarch/boot/Makefile,
> EFI_ZBOOT_PAYLOAD :=3D vmlinux.efi
>
> So I think vmlinuz.efi has already depend on vmlinux.efi.



That is a story in arch/loongarch/boot/Makefile.


I am talking about arch/loongarch/Makefile,
which is included from the top Makefile.


See this code.


vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
        $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@




Only the required dependency is

 - vmlinux.elf depends on vmlinux
 - vmlinuz.elf depends on vmlinux


vmlinux.elf and vmlinuz.elf are independent of each other.



In parallel building, GNU Make considers that
vmlinux.elf and vmlinuz.elf can be built simultaneously.


GNU Make spawns two processes to execute these simultaneously:

 $(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/vmlinux.elf
 $(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/vmlinuz.elf



The former enters arch/loongarch/boot/Makefile to build
vmlinux.elf.  (A)


The latter also enters arch/loongarch/boot/Makefile to build
vmlinuz.elf, which depends on vmlinux.elf  (B)



(A) and (B) are independent processes, hence none of them
know the other.


I hope it is clearer.






> Huacai
>
> >
> > --
> > 2.40.1
> >
> >
>


--=20
Best Regards
Masahiro Yamada
