Return-Path: <linux-kernel+bounces-30777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A1B832440
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752CD1C224EF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E3F4A3C;
	Fri, 19 Jan 2024 05:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym0SRi9b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B24D33E8;
	Fri, 19 Jan 2024 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705642284; cv=none; b=PslY5hAbWMdn4uaOxMWI8nnBGCIHbGCga6YfsW9uvc92vpBT0li20GoU84j7cgbfH4zNH7xrjn9MSvr1A/GC72oe1CwYc8EAgsg5xWU3Rg1B56dG6jshJZtXHHKMnwyPQbtbsuqxTheoq2PoWtdXWCxpOhA0Q4D78sswU3BFseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705642284; c=relaxed/simple;
	bh=VHGkACZlwq00PJqJZlvL7qdl0HgNxOydalnwk1CkmpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDGFWEWkyn2fVZrNBmpGq45BKgAC4UNm3d68+7vlALh2ptvziH6qOZ7t9D0abdDLVR77YA8YaMCh4KDtukHpZ8t+4ggN/bY1YAE7b+20P1AL+gt7MCf+JPmKvCsHaHQbQdUZCoGZlX/LirvaJVK5OC9DT+ZhnUYidQ89KAfHYx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym0SRi9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB15C433C7;
	Fri, 19 Jan 2024 05:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705642283;
	bh=VHGkACZlwq00PJqJZlvL7qdl0HgNxOydalnwk1CkmpM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ym0SRi9bpZGYF9ZwJwS6elsuvnuMCmLUz6vSw49/A3+dYVndBQbajVqkTR/linNSB
	 bv1Lij+x8i5xDR74H91ma/WrQPSwQjdXxYyXf6A77TqswnH7cuK6WvgVrosCeJS8lX
	 YT8JVAHNCP+zRKQv8CdmL3cp/8dBIX1XpU3HIRtqvYAQaNKXlqHmUp0RbMPMT2V4TL
	 0OnnumdhfmGXE051ctQd/fMKWMpPTr/bpZPuZJO7CW4XP8+6OTq8o6lBDrNzGdFJDD
	 QwpNiX/LkcGTD+ECx7A9XzRaXnruKcvqcM+RjNv1EZusNCFvB1bPP+wT+bUikTddX8
	 5ZaF1yMaAAl9w==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dde173384aso283658a34.1;
        Thu, 18 Jan 2024 21:31:23 -0800 (PST)
X-Gm-Message-State: AOJu0YyddSyJ9jm4yk1wy1Ib8IJvxjiW2MoSGiUv6au7aa68UH3s3c3V
	hIdyP7sXD35W7BBFiL1wbi/8ExZ9VgJnFJgAD4gepYaKBmlXQK6IgazVSMF1mokaKww+e4Bt2XZ
	uQbjqNbLa68PhGzy6zZ/9+5XPkiM=
X-Google-Smtp-Source: AGHT+IE2ZQgCxYssk5elr40472Msh5T70My4sP5XlHue3f7m0F5jAC1SL9WeR84fJBN+0PAFcmsBVveUS2BSNK24dq8=
X-Received: by 2002:a05:6871:3743:b0:210:8fee:d921 with SMTP id
 np3-20020a056871374300b002108feed921mr2228969oac.116.1705642283212; Thu, 18
 Jan 2024 21:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109120738.346061-1-masahiroy@kernel.org> <20240109120738.346061-3-masahiroy@kernel.org>
 <20240117145216.GA2296118-robh@kernel.org>
In-Reply-To: <20240117145216.GA2296118-robh@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 19 Jan 2024 14:30:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS3nQjQ8-4HEGfnRbgWSmLrT5EHFzXs-YXjfB7LRHO8ZA@mail.gmail.com>
Message-ID: <CAK7LNAS3nQjQ8-4HEGfnRbgWSmLrT5EHFzXs-YXjfB7LRHO8ZA@mail.gmail.com>
Subject: Re: [PATCH 2/4] kbuild: simplify dtbs_install by reading the list of
 compiled DTBs
To: Rob Herring <robh@kernel.org>
Cc: linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org, 
	Simon Glass <sjg@chromium.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:52=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Tue, Jan 09, 2024 at 09:07:35PM +0900, Masahiro Yamada wrote:
> > Retrieve the list of *.dtb(o) files from arch/*/boot/dts/dtbs-list
> > instead of traversing the directory tree again.
>
> Don't you need dtbs-list in .gitignore?


Yes.


1/4 added it.












> >
> > Please note that 'make dtbs_install' installs *.dtb(o) files directly
> > added to dtb-y because scripts/Makefile.dtbinst installs $(dtb-y)
> > without expanding the -dtbs suffix.
> >
> > This commit preserves this behavior.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile                 |  2 +-
> >  scripts/Kbuild.include   |  6 ------
> >  scripts/Makefile.dtbinst | 32 ++++++++++++++++++--------------
> >  3 files changed, 19 insertions(+), 21 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index db7f9e34a24e..dae6825b8082 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1407,7 +1407,7 @@ endif
> >  dtbs_check: dtbs
> >
> >  dtbs_install:
> > -     $(Q)$(MAKE) $(dtbinst)=3D$(dtstree) dst=3D$(INSTALL_DTBS_PATH)
> > +     $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.dtbinst obj=3D$(dtstre=
e)
> >
> >  ifdef CONFIG_OF_EARLY_FLATTREE
> >  all: dtbs
> > diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> > index 7778cc97a4e0..2f331879816b 100644
> > --- a/scripts/Kbuild.include
> > +++ b/scripts/Kbuild.include
> > @@ -113,12 +113,6 @@ endef
> >  # $(Q)$(MAKE) $(build)=3Ddir
> >  build :=3D -f $(srctree)/scripts/Makefile.build obj
> >
> > -###
> > -# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=3D
> > -# Usage:
> > -# $(Q)$(MAKE) $(dtbinst)=3Ddir
> > -dtbinst :=3D -f $(srctree)/scripts/Makefile.dtbinst obj
> > -
> >  ###
> >  # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.clean obj=3D
> >  # Usage:
> > diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
> > index 4405d5b67578..67956f6496a5 100644
> > --- a/scripts/Makefile.dtbinst
> > +++ b/scripts/Makefile.dtbinst
> > @@ -8,32 +8,36 @@
> >  #   $INSTALL_PATH/dtbs/$KERNELRELEASE
> >  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > -src :=3D $(obj)
> > -
> >  PHONY :=3D __dtbs_install
> >  __dtbs_install:
> >
> >  include include/config/auto.conf
> >  include $(srctree)/scripts/Kbuild.include
> > -include $(kbuild-file)
> >
> > -dtbs    :=3D $(addprefix $(dst)/, $(dtb-y) $(if $(CONFIG_OF_ALL_DTBS),=
$(dtb-)))
> > -subdirs :=3D $(addprefix $(obj)/, $(subdir-y) $(subdir-m))
> > -
> > -__dtbs_install: $(dtbs) $(subdirs)
> > -     @:
> > +dst :=3D $(INSTALL_DTBS_PATH)
> >
> >  quiet_cmd_dtb_install =3D INSTALL $@
> >        cmd_dtb_install =3D install -D $< $@
> >
> > -$(dst)/%.dtb: $(obj)/%.dtb
> > +$(dst)/%: $(obj)/%
> >       $(call cmd,dtb_install)
> >
> > -$(dst)/%.dtbo: $(obj)/%.dtbo
> > -     $(call cmd,dtb_install)
> > +dtbs :=3D $(patsubst $(obj)/%,%,$(call read-file, $(obj)/dtbs-list))
> >
> > -PHONY +=3D $(subdirs)
> > -$(subdirs):
> > -     $(Q)$(MAKE) $(dtbinst)=3D$@ dst=3D$(if $(CONFIG_ARCH_WANT_FLAT_DT=
B_INSTALL),$(dst),$(patsubst $(obj)/%,$(dst)/%,$@))
> > +ifdef CONFIG_ARCH_WANT_FLAT_DTB_INSTALL
> > +
> > +define gen_install_rules
> > +$(dst)/%: $(obj)/$(1)%
> > +     $$(call cmd,dtb_install)
> > +endef
> > +
> > +$(foreach d, $(sort $(dir $(dtbs))), $(eval $(call gen_install_rules,$=
(d))))
> > +
> > +dtbs :=3D $(notdir $(dtbs))
> > +
> > +endif # CONFIG_ARCH_WANT_FLAT_DTB_INSTALL
> > +
> > +__dtbs_install: $(addprefix $(dst)/, $(dtbs))
> > +     @:
> >
> >  .PHONY: $(PHONY)
> > --
> > 2.40.1
> >



--=20
Best Regards
Masahiro Yamada

