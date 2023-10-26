Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7136C7D8378
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345052AbjJZNZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjJZNZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:25:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3EA1AC;
        Thu, 26 Oct 2023 06:25:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0AAC43391;
        Thu, 26 Oct 2023 13:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698326736;
        bh=+MGS8U/sxZlsxu4uEJYmz/grwvCB1tyBhQ2V6if8vDU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d+q+v+URG2CAoqmpWSGxTp4m/ieTAsMH5DFWBk88VtiSzOB0cGuwKqLC3kE4CgCKy
         TFTBGiJ4tTwKLz2HXyIrY0IOLDhqy3hZ+eT9I6M+7TBKB27Mo99VYBwk3JG07RJdpB
         Qw0P/l5dnu+bFiqARsgdbv4bWjqQn5EvpQv0xkVQL0nmOlU1otXGhh3OvDDWX4xDer
         ehkBO9Kr6uE8wsL9oWsX4R8Wt6K+bbXz40QVgRuXOhZmhKezkwduYn62R+gqwImHNp
         t64i0y25Vg5JANYJEv5Rd+tYHQH6QHKKYyvdqxN2vlE3st3V8vjiOhHVwpr105iMni
         mmmYRlatzvs/w==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ce2fc858feso537519a34.3;
        Thu, 26 Oct 2023 06:25:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YyP03TgowI5Or1mu9llt+EgJB9iIBrNFq6upRy6nOyNU/5I7B+x
        Qt5PQBTpbNoqUvRc8fLANrnsjAhwvWkL5QShL/4=
X-Google-Smtp-Source: AGHT+IGdtQL/B8ljcZzRnKA+sQcP1SIV6LlHI28WnG2FGPinA1/vPJbXdnJFSpA8NDpJ7neQfY2r6PAloUbbG0gqrYs=
X-Received: by 2002:a05:6871:4f13:b0:1e9:8782:f948 with SMTP id
 zu19-20020a0568714f1300b001e98782f948mr14353560oab.58.1698326736164; Thu, 26
 Oct 2023 06:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231026072628.4115527-1-sjg@chromium.org> <20231026072628.4115527-4-sjg@chromium.org>
In-Reply-To: <20231026072628.4115527-4-sjg@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 26 Oct 2023 22:24:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNASATGRaS-6QxzqTEq7qNVkZPXOBE8pfRBg=2bQGyy3=yw@mail.gmail.com>
Message-ID: <CAK7LNASATGRaS-6QxzqTEq7qNVkZPXOBE8pfRBg=2bQGyy3=yw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: boot: Support Flat Image Tree
To:     Simon Glass <sjg@chromium.org>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 4:28=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Add a script which produces a Flat Image Tree (FIT), a single file
> containing the built kernel and associated devicetree files.
> Compression defaults to gzip which gives a good balance of size and
> performance.
>
> The files compress from about 85MB to 24MB using this approach.
>
> The FIT can be used by bootloaders which support it, such as U-Boot
> and Linuxboot. It permits automatic selection of the correct
> devicetree, matching the compatible string of the running board with
> the closest compatible string in the FIT. There is no need for
> filenames or other workarounds.
>
> Add a 'make image.fit' build target for arm64, as well.
>
> The FIT can be examined using 'dumpimage -l'.
>
> This features requires pylibfdt (use 'pip install libfdt'). It also
> requires compression utilities for the algorithm being used. Supported
> compression options are the same as the Image.xxx files. For now there
> is no way to change the compression other than by editing the rule for
> $(obj)/image.fit
>
> While FIT supports a ramdisk / initrd, no attempt is made to support
> this here, since it must be built separately from the Linux build.


Is this useful?
For arm64, initrd is likely used.

FIT should be created in unbrellea projects
such as OpenEmbedded,  Buildroot, etc.




> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  MAINTAINERS              |   7 +
>  arch/arm64/Makefile      |   3 +-
>  arch/arm64/boot/Makefile |   8 +-
>  scripts/Makefile.lib     |  16 ++-
>  scripts/make_fit.py      | 285 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 315 insertions(+), 4 deletions(-)
>  create mode 100755 scripts/make_fit.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d13bbd69adb..d6955ebc3c24 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1575,6 +1575,13 @@ F:       Documentation/process/maintainer-soc*.rst
>  F:     arch/arm/boot/dts/Makefile
>  F:     arch/arm64/boot/dts/Makefile
>
> +ARM64 FIT SUPPORT
> +M:     Simon Glass <sjg@chromium.org>
> +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
> +S:     Maintained
> +F:     arch/arm64/boot/Makefile
> +F:     scripts/make_fit.py
> +
>  ARM ARCHITECTED TIMER DRIVER
>  M:     Mark Rutland <mark.rutland@arm.com>
>  M:     Marc Zyngier <maz@kernel.org>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 7b77b63e978f..d8290dcab6b6 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -150,7 +150,7 @@ libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmw=
are/efi/libstub/lib.a
>  # Default target when executing plain make
>  boot           :=3D arch/arm64/boot
>
> -BOOT_TARGETS   :=3D Image.gz vmlinuz.efi
> +BOOT_TARGETS   :=3D Image.gz vmlinuz.efi image.fit
>
>  PHONY +=3D $(BOOT_TARGETS)
>
> @@ -215,6 +215,7 @@ virtconfig:
>  define archhelp
>    echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Im=
age.gz)'
>    echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/=
Image)'
> +$(if $(CONFIG_EFI_ZBOOT),,echo  '  image.fit     - Flat Image Tree (arch=
/$(ARCH)/boot/image.fit)')
>    echo  '  install       - Install uncompressed kernel'
>    echo  '  zinstall      - Install compressed kernel'
>    echo  '                  Install using (your) ~/bin/installkernel or'
> diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> index 1761f5972443..a6e5b20b22bd 100644
> --- a/arch/arm64/boot/Makefile
> +++ b/arch/arm64/boot/Makefile
> @@ -16,7 +16,8 @@
>
>  OBJCOPYFLAGS_Image :=3D-O binary -R .note -R .note.gnu.build-id -R .comm=
ent -S
>
> -targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo Ima=
ge.zst
> +targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo \
> +       Image.zst image.fit
>
>  $(obj)/Image: vmlinux FORCE
>         $(call if_changed,objcopy)
> @@ -39,6 +40,11 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>  $(obj)/Image.zst: $(obj)/Image FORCE
>         $(call if_changed,zstd)
>
> +ifndef CONFIG_EFI_ZBOOT
> +$(obj)/image.fit: $(obj)/Image $(obj)/dts FORCE



This is wrong.

$(obj)/dts is a directory.

There is no point for comparing timestamps
between $(obj)/image.fit and $(obj)/dts.

Updates of *.dtb do not result in the
update of the $(obj)/dts timestamp.


if_changed never works correctly.








> +       $(call if_changed,fit,gzip)
> +endif
> +
>  EFI_ZBOOT_PAYLOAD      :=3D Image
>  EFI_ZBOOT_BFD_TARGET   :=3D elf64-littleaarch64
>  EFI_ZBOOT_MACH_TYPE    :=3D ARM64
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 68d0134bdbf9..4e4364ad641a 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -487,14 +487,26 @@ UIMAGE_OPTS-y ?=3D
>  UIMAGE_TYPE ?=3D kernel
>  UIMAGE_LOADADDR ?=3D arch_must_set_this
>  UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
> -UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> +UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"


Unneeded noise change.







--
Best Regards

Masahiro Yamada
