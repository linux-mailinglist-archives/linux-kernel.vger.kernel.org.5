Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060297DA81E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 18:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjJ1Qq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 12:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJ1Qq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 12:46:26 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49779CE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 09:46:24 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77891f362cfso251076685a.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698511583; x=1699116383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22XGan4HKJtU6FcQC1HdHff0Q2Vo7FU6YgwNH6XLufw=;
        b=HiZqnueRo10w0v1X9KZHx5eUa7GYrfxQYl0H7otVWW8HIjalanJFp/cx6bfv/HOimr
         oXK655ybk/XoIE9Jb1R03xsqk9aoMLV+yV4RJTQBFU+aDx9WR9NnL8524WRnbO5NVDA/
         xI66w3xujljJqlY+Dq2RuwiT+KtUqW+E5/0+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698511583; x=1699116383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22XGan4HKJtU6FcQC1HdHff0Q2Vo7FU6YgwNH6XLufw=;
        b=F4QZYJlXPPP/9plNozhVAGmO3EWcW3YVTS9PQjHcynZX0EZnYBpbPpu40N0u6omwhn
         LJPCrGMEYheN83ZEaYPrAryafjE83XPxa/+nJ9K1O7JuBvL8nrFVxaf5D/F2ilEZFhPw
         rX4cPShgmPuRsC/gYZx6xUE0O/hyhsFH9d9AcbEZEYkwzslrLukLGaRLqidaFkI9hBo7
         zQQ/fZ4R7PBTFHkoC9GGQ/F58Se0mM18vT6B4vedqtjrLIkIPHED5WHkIHltBltjixgz
         XxMFVqsvGF5BzD4lHp/l4TBqEwXnH4iLyrRG+D7pYtJLkMULaDROkCnQ5mOKhq8CmxB4
         p+TA==
X-Gm-Message-State: AOJu0Yy+T9RZFsVjXf3n2rYo8hp8LRU84+8JmoIL9BDkj+qC7bvwNQhr
        aFFfS/8DooER+sg4eH+DgE7lno+/sg6AA5NIdecqoA==
X-Google-Smtp-Source: AGHT+IH3Pt+k7jTL8TTDfWmz7Fcz3LXohWw4MApDqxDc7JZby7kT5wcsfygwJ20CX9fAK4x1A6xUCPUDD3JGmwMTf+c=
X-Received: by 2002:a05:620a:471e:b0:775:c2a1:1821 with SMTP id
 bs30-20020a05620a471e00b00775c2a11821mr10997395qkb.26.1698511583333; Sat, 28
 Oct 2023 09:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231026072628.4115527-1-sjg@chromium.org> <20231026072628.4115527-4-sjg@chromium.org>
 <CAK7LNASATGRaS-6QxzqTEq7qNVkZPXOBE8pfRBg=2bQGyy3=yw@mail.gmail.com>
In-Reply-To: <CAK7LNASATGRaS-6QxzqTEq7qNVkZPXOBE8pfRBg=2bQGyy3=yw@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Sun, 29 Oct 2023 05:46:12 +1300
Message-ID: <CAFLszThguWT0u0R0EHfpBro0f-pWDwLOGk+5pQZEVhFYNKH8fQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: boot: Support Flat Image Tree
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Fri, Oct 27, 2023 at 2:25=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Oct 26, 2023 at 4:28=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Add a script which produces a Flat Image Tree (FIT), a single file
> > containing the built kernel and associated devicetree files.
> > Compression defaults to gzip which gives a good balance of size and
> > performance.
> >
> > The files compress from about 85MB to 24MB using this approach.
> >
> > The FIT can be used by bootloaders which support it, such as U-Boot
> > and Linuxboot. It permits automatic selection of the correct
> > devicetree, matching the compatible string of the running board with
> > the closest compatible string in the FIT. There is no need for
> > filenames or other workarounds.
> >
> > Add a 'make image.fit' build target for arm64, as well.
> >
> > The FIT can be examined using 'dumpimage -l'.
> >
> > This features requires pylibfdt (use 'pip install libfdt'). It also
> > requires compression utilities for the algorithm being used. Supported
> > compression options are the same as the Image.xxx files. For now there
> > is no way to change the compression other than by editing the rule for
> > $(obj)/image.fit
> >
> > While FIT supports a ramdisk / initrd, no attempt is made to support
> > this here, since it must be built separately from the Linux build.
>
>
> Is this useful?
> For arm64, initrd is likely used.

It depends on your kernel configuration, though. I have found it
convenient to enable the drivers necessary to boot.

>
> FIT should be created in unbrellea projects
> such as OpenEmbedded,  Buildroot, etc.

Sure, but that is a separate issue, isn't it? We already support
various boot targets in arm64 but not one that includes the DTs, so
far as I can see. The old arm 'uImage' target is pretty out-of-date
now.

>
>
>
>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  MAINTAINERS              |   7 +
> >  arch/arm64/Makefile      |   3 +-
> >  arch/arm64/boot/Makefile |   8 +-
> >  scripts/Makefile.lib     |  16 ++-
> >  scripts/make_fit.py      | 285 +++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 315 insertions(+), 4 deletions(-)
> >  create mode 100755 scripts/make_fit.py
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2d13bbd69adb..d6955ebc3c24 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1575,6 +1575,13 @@ F:       Documentation/process/maintainer-soc*.r=
st
> >  F:     arch/arm/boot/dts/Makefile
> >  F:     arch/arm64/boot/dts/Makefile
> >
> > +ARM64 FIT SUPPORT
> > +M:     Simon Glass <sjg@chromium.org>
> > +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscri=
bers)
> > +S:     Maintained
> > +F:     arch/arm64/boot/Makefile
> > +F:     scripts/make_fit.py
> > +
> >  ARM ARCHITECTED TIMER DRIVER
> >  M:     Mark Rutland <mark.rutland@arm.com>
> >  M:     Marc Zyngier <maz@kernel.org>
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 7b77b63e978f..d8290dcab6b6 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -150,7 +150,7 @@ libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/fir=
mware/efi/libstub/lib.a
> >  # Default target when executing plain make
> >  boot           :=3D arch/arm64/boot
> >
> > -BOOT_TARGETS   :=3D Image.gz vmlinuz.efi
> > +BOOT_TARGETS   :=3D Image.gz vmlinuz.efi image.fit
> >
> >  PHONY +=3D $(BOOT_TARGETS)
> >
> > @@ -215,6 +215,7 @@ virtconfig:
> >  define archhelp
> >    echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/=
Image.gz)'
> >    echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boo=
t/Image)'
> > +$(if $(CONFIG_EFI_ZBOOT),,echo  '  image.fit     - Flat Image Tree (ar=
ch/$(ARCH)/boot/image.fit)')
> >    echo  '  install       - Install uncompressed kernel'
> >    echo  '  zinstall      - Install compressed kernel'
> >    echo  '                  Install using (your) ~/bin/installkernel or=
'
> > diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> > index 1761f5972443..a6e5b20b22bd 100644
> > --- a/arch/arm64/boot/Makefile
> > +++ b/arch/arm64/boot/Makefile
> > @@ -16,7 +16,8 @@
> >
> >  OBJCOPYFLAGS_Image :=3D-O binary -R .note -R .note.gnu.build-id -R .co=
mment -S
> >
> > -targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo I=
mage.zst
> > +targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo \
> > +       Image.zst image.fit
> >
> >  $(obj)/Image: vmlinux FORCE
> >         $(call if_changed,objcopy)
> > @@ -39,6 +40,11 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
> >  $(obj)/Image.zst: $(obj)/Image FORCE
> >         $(call if_changed,zstd)
> >
> > +ifndef CONFIG_EFI_ZBOOT
> > +$(obj)/image.fit: $(obj)/Image $(obj)/dts FORCE
>
>
>
> This is wrong.
>
> $(obj)/dts is a directory.
>
> There is no point for comparing timestamps
> between $(obj)/image.fit and $(obj)/dts.
>
> Updates of *.dtb do not result in the
> update of the $(obj)/dts timestamp.
>
>
> if_changed never works correctly.

Yes I am aware that this doesn't actually deal with changes. I'll see
if I can figure out another way.

>
>
>
>
>
>
>
>
> > +       $(call if_changed,fit,gzip)
> > +endif
> > +
> >  EFI_ZBOOT_PAYLOAD      :=3D Image
> >  EFI_ZBOOT_BFD_TARGET   :=3D elf64-littleaarch64
> >  EFI_ZBOOT_MACH_TYPE    :=3D ARM64
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 68d0134bdbf9..4e4364ad641a 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -487,14 +487,26 @@ UIMAGE_OPTS-y ?=3D
> >  UIMAGE_TYPE ?=3D kernel
> >  UIMAGE_LOADADDR ?=3D arch_must_set_this
> >  UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
> > -UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> > +UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
>
>
> Unneeded noise change.

I'll move that to a separate patch. We don't want the single quotes in the =
name.

Regards,
Simon
