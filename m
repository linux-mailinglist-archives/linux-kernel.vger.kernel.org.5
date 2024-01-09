Return-Path: <linux-kernel+bounces-20583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37138281DF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483291F23454
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAF33608B;
	Tue,  9 Jan 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdPYuaV8"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49B24B58
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e7467eb93aso19206077b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 00:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704788851; x=1705393651; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYff+zAnCSNvGI3liPh8jRaRnowWqx5CBrSfiqrAYz0=;
        b=VdPYuaV8Dx4nE/qzAIWl+KRST3gwZ+4gwweoxoCqNBJ/Kq2YbF/l0AlQQXRy7J7JO3
         IQZ7TgvoHpSvyY+NmnyaNAAzo1V4SUpCKy4KJWVTUepAzTM0GSqVqcSkuWgoptHBNT5L
         4wR9nu3t2lYxhIZm6b0FZZo3TL28rJ6fbckzATb+JRX+PsoYaAgquMKIXLUJsXgxaS/0
         5ViEMMJzpsXOxTytyIktB5VRC2ZPXGJXiLjWHGYVBmO+tSNOqYTegJrUxQPSut93xyfS
         GjmEesszRfy53QWfLmIdX3MPo6gmNJ/3JxEQC8frKkRo1E1at7W0FWDTu1dnyEyS9tTt
         e1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704788851; x=1705393651;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYff+zAnCSNvGI3liPh8jRaRnowWqx5CBrSfiqrAYz0=;
        b=viYTbRO6GkFMpBYoxhGAeAsf1aXIGWR5xKtI/wn9OXBN+0k7JldhgxSNU+8hagRAci
         +WX7vuxNFcX+f3AYNVdEwtGfnHmBCR+zK79qZongZVJK6pNjmN6DqgFwFgL0nrDbXZGa
         zs05a6Cbjx8gB+reSBuUdvFxAyLWybWo0bPfcvgsi4rUujjUPOHrKZeY4nzGFGpiNcYO
         ZVQ4PMRBfIcgJeK2KjJEg15PS+hpBTuKFzkQMI2A2rxJnUhV3+sy7NvtGAfXbdusfSWj
         8eH2NC+awJGEJz/SV50hEQ2953xPT0jEG92OtqnLW+Id/lhL8Hrk2SiYV8oqvqdzc05w
         6ybQ==
X-Gm-Message-State: AOJu0YxKSxhria6cR/JuZwOEQtegwDO2PJ7ZzCcOa6m3LGAbPA9/2aOd
	cSG4LSNmyHh4a63INbHS7gg=
X-Google-Smtp-Source: AGHT+IGZxlNrTIdlvOOD7AC/Jq4gveJC0lJZKtgGRFv9RGEWAN0tJimM0UtM9GreGLBLmfXrhF0H9w==
X-Received: by 2002:a0d:ead7:0:b0:5f0:437d:706f with SMTP id t206-20020a0dead7000000b005f0437d706fmr2259790ywe.12.1704788851143;
        Tue, 09 Jan 2024 00:27:31 -0800 (PST)
Received: from [10.8.1.7] ([185.215.181.31])
        by smtp.gmail.com with ESMTPSA id a184-20020a0df1c1000000b005d3b4fce438sm589005ywf.65.2024.01.09.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 00:27:30 -0800 (PST)
Date: Tue, 9 Jan 2024 03:27:08 -0500 (EST)
From: Kevin Martin <kevinmbecause@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>
cc: Kevin Martin <kevinmbecause@gmail.com>, 
    Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] firmware_loader: Enable compressed files with
 EXTRA_FIRMWARE
In-Reply-To: <CAK7LNARwQwE7=xUjE9HSzTYujWHWFGSu48xBg56pfBE+0uv6_g@mail.gmail.com>
Message-ID: <9edb98fa-9ddd-2179-af59-3519cf2dbf0b@gmail.com>
References: <cover.1704353568.git.kevinmbecause@gmail.com> <cd370037f8c21dc851a2a33a07250459c9c98708.1704353568.git.kevinmbecause@gmail.com> <CAK7LNARwQwE7=xUjE9HSzTYujWHWFGSu48xBg56pfBE+0uv6_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463794175-775061374-1704788829=:23655"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794175-775061374-1704788829=:23655
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 7 Jan 2024, Masahiro Yamada wrote:

> On Fri, Jan 5, 2024 at 3:11 PM Kevin Martin <kevinmbecause@gmail.com> wrote:
> >
> > The linux-firmware packages on Gentoo, Fedora, Arch, and others
> > compress the firmware files. This works well with
> > CONFIG_FW_LOADER_COMPRESS but does not work with CONFIG_EXTRA_FIRMWARE.
> > This patch allows the build system to decompress firmware files
> > specified by CONFIG_EXTRA_FIRMWARE. Uncompressed files are used first,
> > then the compressed files are used.
> >
> > The patch works by copying or decompressing the specified firmware files
> > into the build directory, then compiling them in from there. I would
> > prefer to not copy any uncompressed files, but I have not found a clean
> > way to do that.
> >
> > Signed-off-by: Kevin Martin <kevinmbecause@gmail.com>
> > ---
> > Changes in v2:
> > - Changed .gitignore to ignore all firmware files copied into the
> > directory.
> > - Fixed a tab.
> >
> >  drivers/base/firmware_loader/Kconfig            |  5 ++++-
> >  drivers/base/firmware_loader/builtin/.gitignore |  5 ++++-
> >  drivers/base/firmware_loader/builtin/Makefile   | 16 ++++++++++++----
> >  3 files changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
> > index 5ca00e02f..b7a908bff 100644
> > --- a/drivers/base/firmware_loader/Kconfig
> > +++ b/drivers/base/firmware_loader/Kconfig
> > @@ -76,7 +76,10 @@ config EXTRA_FIRMWARE
> >           image since it combines both GPL and non-GPL work. You should
> >           consult a lawyer of your own before distributing such an image.
> >
> > -         NOTE: Compressed files are not supported in EXTRA_FIRMWARE.
> > +         NOTE: Compressed files are supported by EXTRA_FIRMWARE. The build
> > +         system will look for uncompressed files first then fall back to
> > +         searching for compressed files in a similar way to
> > +         CONFIG_FW_LOADER_COMPRESS.
> >
> >  config EXTRA_FIRMWARE_DIR
> >         string "Firmware blobs root directory"
> > diff --git a/drivers/base/firmware_loader/builtin/.gitignore b/drivers/base/firmware_loader/builtin/.gitignore
> > index 166f76b43..b3124ee78 100644
> > --- a/drivers/base/firmware_loader/builtin/.gitignore
> > +++ b/drivers/base/firmware_loader/builtin/.gitignore
> > @@ -1,2 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -*.gen.S
> > +*
> > +!.gitignore
> > +!Makefile
> > +!main.c
> > diff --git a/drivers/base/firmware_loader/builtin/Makefile b/drivers/base/firmware_loader/builtin/Makefile
> > index 6c067dedc..cc60eb441 100644
> > --- a/drivers/base/firmware_loader/builtin/Makefile
> > +++ b/drivers/base/firmware_loader/builtin/Makefile
> > @@ -20,7 +20,7 @@ filechk_fwbin = \
> >         echo "    .section .rodata"                             ;\
> >         echo "    .p2align 4"                                   ;\
> >         echo "_fw_$(FWSTR)_bin:"                                ;\
> > -       echo "    .incbin \"$(fwdir)/$(FWNAME)\""               ;\
> > +       echo "    .incbin \"$(obj)/$(FWNAME)\""                 ;\
> >         echo "_fw_end:"                                         ;\
> >         echo "    .section .rodata.str,\"aMS\",$(PROGBITS),1"   ;\
> >         echo "    .p2align $(ASM_ALIGN)"                        ;\
> > @@ -36,7 +36,15 @@ $(obj)/%.gen.S: FORCE
> >         $(call filechk,fwbin)
> >
> >  # The .o files depend on the binaries directly; the .S files don't.
> > -$(addprefix $(obj)/, $(firmware)): $(obj)/%.gen.o: $(fwdir)/%
> > +$(addprefix $(obj)/, $(firmware)): $(obj)/%.gen.o: $(obj)/%
> >
> > -targets := $(patsubst $(obj)/%,%, \
> > -                                $(shell find $(obj) -name \*.gen.S 2>/dev/null))
> > +$(obj)/% : $(fwdir)/% FORCE
> > +       $(call if_changed,copy)
> > +
> > +$(obj)/% : $(fwdir)/%.xz FORCE
> > +       $(call if_changed,xzdec)
> > +
> > +$(obj)/% : $(fwdir)/%.zst FORCE
> > +       $(call if_changed,zstddec)
> > +
> > +targets := $(patsubst %.gen.o, %.gen.S, $(firmware)) $(CONFIG_EXTRA_FIRMWARE)
> 
> 
> I noticed that "make clean" leaves copied firmware files
> in drivers/base/firmware_loader/builtin/.
> 
> 
> You need to clean up all files in
> drivers/base/firmware_loader/builtin/
> except Makefile, main.c.
> 
> The following worked for me.
> 
> 
> diff --git a/drivers/base/firmware_loader/builtin/Makefile
> b/drivers/base/firmware_loader/builtin/Makefile
> index bcac1723dc32..4d62ee9f06f6 100644
> --- a/drivers/base/firmware_loader/builtin/Makefile
> +++ b/drivers/base/firmware_loader/builtin/Makefile
> @@ -48,3 +48,5 @@ $(obj)/% : $(fwdir)/%.zst FORCE
>         $(call if_changed,zstddec)
> 
>  targets := $(patsubst %.gen.o, %.gen.S, $(firmware)) $(CONFIG_EXTRA_FIRMWARE)
> +
> +clean-files := $(filter-out Makefile main.c, $(patsubst $(obj)/%,%,
> $(wildcard $(obj)/*)))
> 

This explains why the "shell find" command was used. I was attempting to 
generate the list from $(CONFIG_EXTRA_FIRMWARE), but that is not defined 
during "make clean" as I am just now learning. While I would prefer to use 
a whitelist instead of a blacklist, I do not know a way to accomplish 
that. If everyone is ok with wiping out all files other than Makefile and 
main.c, then I will add the wildcard to "targets" and submit a new 
patch revision.

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
> -- 
> Best Regards
> Masahiro Yamada
> 
---1463794175-775061374-1704788829=:23655--

