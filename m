Return-Path: <linux-kernel+bounces-80013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF9D8629AB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 09:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7562820C9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 08:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAAFDDD5;
	Sun, 25 Feb 2024 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwQmkF1w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A9DDAE;
	Sun, 25 Feb 2024 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708849296; cv=none; b=Vy66miI864OtuL4f6nKodbHmRNalNZ31yZfLcrG/2gv1VBqvNMQ+SZVA9Kl7YHz0eH8XbYe4H8+9AGj3/e05Y8sa4fWukNUiYS3aO75wre1u4gPV3I0U6OvDF2kXnwqKzYC36BF8GocCwgUKGaWHjP7+PIZUfdKp3rh7S45MCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708849296; c=relaxed/simple;
	bh=xB3wW4g4SuZMpzFlMa/SwsWelkeb4wiDp7ll1UWoUiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6nF5Gml+Sn9ABWzzBKZSBape4a9efzgjrRBaQvR2nUnxSpiuRT5mXRjYVgR/nL32MeFrjgMGedu9i0O5XWFzOcrHpecHeE4g8u3oYWlcom5oLgGZK8syU9F3nzjeXBRGXyvnund/1KxLFBcfgVzogp4c6u6sxV0gEnxj2IEDnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwQmkF1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F478C43390;
	Sun, 25 Feb 2024 08:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708849296;
	bh=xB3wW4g4SuZMpzFlMa/SwsWelkeb4wiDp7ll1UWoUiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bwQmkF1wVgj66V8tbSyNFes2Wag6iOaOksgjfovbafDOBl5sku3BQ71CQC8t6LsZU
	 X9ljVkdXXhsXouPc0gV1cCnOgqpQBp1KmHDelhzPlJPH0J4ijwx6m++FBvNJ+9wZbb
	 FffJhkHtgQ4IK28jR6O2GN3E6sVjZzGhzoQmxt1f0jiV5cxq0QMrDf8jXrpOU4UhgZ
	 j1mYHTnnG8yWkFQ9SsPgp/dQu0IJ1oXpvsUyiqWR5uqFLh/fCQQnacZoNkfypVAKVI
	 yXQrtwCU93/+ueOGfMQhhw///YXovZacZ01BzOJ9LtabtQuHmQrDOrLnsHOZWpxAPD
	 XjborlfVKOOZg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5101cd91017so3220181e87.2;
        Sun, 25 Feb 2024 00:21:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhPBX8hy2pI/NPZf/Be9nbCxMGchDmmHqLFbs9k4i0k3Uh4M6tUXTC0abGS3+TX0vg0R9IvILbCB8+SmLnk3wWbTsamvAmfEb+UL2Di8UMn3RcGpT6D9OQLoBvIh11Va5LPYyOQE/t5P2G
X-Gm-Message-State: AOJu0YwcXh1iNTYHKfiOTQsoIyp/qkLyP+5lXEI3AtF7W8oqkzpDAQVZ
	bizOA9oPimLZNcfQWSjTpW2FMF4Utjkk8kisMdCqxetYk19azFwmnI9h6YmR9R4+x/VDsZ+wjeW
	TyezFe5x52gzy7F7ACjsAAJlq4Mc=
X-Google-Smtp-Source: AGHT+IGsp2RFyqcVBz55gW3+2+bqaWiWNHzdDEF7DtFTWtGw9z814ip1hsMXcQoQCHYcN/NCC4H3OSzY+3KbZUw/Y0k=
X-Received: by 2002:a05:6512:203c:b0:512:a009:6e21 with SMTP id
 s28-20020a056512203c00b00512a0096e21mr2081170lfs.31.1708849294822; Sun, 25
 Feb 2024 00:21:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223092338.2433632-1-wenst@chromium.org>
In-Reply-To: <20240223092338.2433632-1-wenst@chromium.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 25 Feb 2024 17:20:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQmvyftnFJaByyjH+f4nxcNUKpjkDXwebEH5AhMF6U0Kw@mail.gmail.com>
Message-ID: <CAK7LNAQmvyftnFJaByyjH+f4nxcNUKpjkDXwebEH5AhMF6U0Kw@mail.gmail.com>
Subject: Re: [PATCH RFC] kbuild: create a list of all built DTB files
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 6:23=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> It is useful to have a list of all composite *.dtb files, along with
> their individual components, generated from the current build.
>
> With this commit, 'make dtbs' creates arch/*/boot/dts/dtbs-components,
> which lists the composite dtb files created in the current build. It
> maintains the order of the dtb-y additions in Makefiles although the
> order is not important for DTBs.
>
> This compliments the list of all *.dtb and *.dtbo files in dtbs-list,
> which only includes the files directly added to dtb-y.
>
> For example, consider this case:
>
>     foo-dtbs :=3D foo_base.dtb foo_overlay.dtbo
>     dtb-y :=3D bar.dtb foo.dtb
>
> In this example, the new list will include foo.dtb with foo_base.dtb and
> foo_overlay.dtbo on the same line, but not bar.dtb.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Hi,
>
> I hacked up this new thing to list out the individual components of each
> composite dtb. I think this information would be useful for FIT image
> generation or other toolchains to consume. For example, instead of
> including each dtb, a toolchain could realize that some are put together
> using others, and if the bootloader supports it, put together commands
> to reassemble the end result from the original parts.
>
> This is based on and complements Masahiro-san's recent dtbs-list work.



This is another format of my previous per-dtb "*.dtlst"
(but I did not pick up 3/4, 4/4 because I did not know what we need after a=
ll).

This should be discussed together with how Simon's script will look like.

I can understand your Makefile code, but I still do not know
how the entire overlay stuff will work in a big picture.





>
>  .gitignore             |  1 +
>  scripts/Makefile.build | 16 ++++++++++++++++
>  scripts/Makefile.lib   |  8 ++++++--
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index c59dc60ba62e..bb5b3bbca4ef 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -52,6 +52,7 @@
>  *.xz
>  *.zst
>  Module.symvers
> +dtbs-components
>  dtbs-list
>  modules.order
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 4971f54c855e..ba85c2385c9e 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -72,6 +72,7 @@ endif
>  subdir-builtin :=3D $(sort $(filter %/built-in.a, $(real-obj-y)))
>  subdir-modorder :=3D $(sort $(filter %/modules.order, $(obj-m)))
>  subdir-dtbslist :=3D $(sort $(filter %/dtbs-list, $(dtb-y)))
> +subdir-dtbscomp :=3D $(sort $(filter %/dtbs-components, $(multi-dtb-y)))
>
>  targets-for-builtin :=3D $(extra-y)
>
> @@ -390,6 +391,7 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objt=
ree)/scripts/asn1_compiler
>  $(subdir-builtin): $(obj)/%/built-in.a: $(obj)/% ;
>  $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
>  $(subdir-dtbslist): $(obj)/%/dtbs-list: $(obj)/% ;
> +$(subdir-dtbscomp): $(obj)/%/dtbs-components: $(obj)/% ;
>
>  #
>  # Rule to compile a set of .o files into one .a file (without symbol tab=
le)
> @@ -422,6 +424,20 @@ $(obj)/modules.order: $(obj-m) FORCE
>  $(obj)/dtbs-list: $(dtb-y) FORCE
>         $(call if_changed,gen_order)
>
> +#
> +# Rule to create dtbs-components
> +#
> +# This is a list of composite dtb(s), along with each dtb's components,
> +# from the current Makefile and its sub-directories.
> +
> +cmd_gen_dtb_components =3D { $(foreach m, $(real-prereqs), \
> +               $(if $(filter %/$(notdir $@), $m), cat $m, \
> +                       echo $m: $(addprefix $(obj)/,$($(notdir $(m:%.dtb=
=3D%-dtbs))))); \
> +       ) :; } > $@
> +
> +$(obj)/dtbs-components: $(multi-dtb-y) FORCE
> +       $(call if_changed,gen_dtb_components)
> +
>  #
>  # Rule to compile a set of .o files into one .a file (with symbol table)
>  #
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index dbcac396329e..7c2127a84ac2 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -61,7 +61,6 @@ real-search =3D $(foreach m, $1, $(if $(call suffix-sea=
rch, $m, $2, $3 -), $(call
>  multi-obj-y :=3D $(call multi-search, $(obj-y), .o, -objs -y)
>  multi-obj-m :=3D $(call multi-search, $(obj-m), .o, -objs -y -m)
>  multi-obj-ym :=3D $(multi-obj-y) $(multi-obj-m)
> -
>  # Replace multi-part objects by their individual parts,
>  # including built-in.a from subdirectories
>  real-obj-y :=3D $(call real-search, $(obj-y), .o, -objs -y)
> @@ -91,6 +90,11 @@ real-dtb-y :=3D $(call real-search, $(dtb-y), .dtb, -d=
tbs)
>  # Base DTB that overlay is applied onto
>  base-dtb-y :=3D $(filter %.dtb, $(call real-search, $(multi-dtb-y), .dtb=
, -dtbs))
>
> +ifdef need-dtbslist
> +multi-dtb-y    +=3D $(addsuffix /dtbs-components, $(subdir-ym))
> +always-y       +=3D dtbs-components
> +endif
> +
>  always-y                       +=3D $(dtb-y)
>
>  # Add subdir path
> @@ -406,7 +410,7 @@ cmd_dtc =3D $(HOSTCC) -E $(dtc_cpp_flags) -x assemble=
r-with-cpp -o $(dtc-tmp) $< ;
>  quiet_cmd_fdtoverlay =3D DTOVL   $@
>        cmd_fdtoverlay =3D $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(re=
al-prereqs)
>
> -$(multi-dtb-y): FORCE
> +$(filter-out %/dtbs-components, multi-dtb-y): FORCE
>         $(call if_changed,fdtoverlay)
>  $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
>
> --
> 2.44.0.rc0.258.g7320e95886-goog
>


--
Best Regards
Masahiro Yamada

