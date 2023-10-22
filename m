Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6227D2473
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjJVQWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjJVQWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:22:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E2619BD;
        Sun, 22 Oct 2023 09:22:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4424EC433BA;
        Sun, 22 Oct 2023 16:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697991722;
        bh=EyY6Liyok0DHui9C4VISkQux2t3R8fPcaQ5dO9dxwAA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bGb3uP9OsVIlN+2R/fc6MSBPofWuRac66dz91Yx3zTQFh+IUTKsVw5UGuXQjcs1aN
         OgWOMmUKOOYWAB0dOKYg8vOi+8ZMy2XjFXCfDfEEVXy+1kuOe7gpQM8TqaD1soOFjT
         yHgFPWXqR//yjQPszWFoWZGn+sSOwA4mu6F5UmVZ3Crece0ABuhaWC/KMdiZIvW8/L
         opZ9cK0w7+/ngO47KWnoZtg+nOOIbcTxZWY3fU3tY3+DehuQOevaV3SsLFu+2EGlyd
         iTvPIcC4Fcj/vrpLeNZH44fgseOfKRyvoZ3qHVjH8D+9+MSHS9/DVGMOSS0PYHbv5y
         bsG2PS2GYi8fQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ce2bcb131fso1758265a34.1;
        Sun, 22 Oct 2023 09:22:02 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyd8RgSN20gqYuRU25l1VcaiwT+xLLU04mpVqKKYgWGG9QrYikz
        Qom+MmGWSvt3E7QOzFqZDs7m1NxgyfoiJd53xT8=
X-Google-Smtp-Source: AGHT+IFh2YRM97VqXOgn/xklDlMPFIckjOiqRen7B0reeS6WVLTJ4bVAnrYlwn54DePl+G4BKhCeBd0qthDgq+1bb8g=
X-Received: by 2002:a05:6870:f212:b0:1e9:e975:4418 with SMTP id
 t18-20020a056870f21200b001e9e9754418mr9011025oao.53.1697991721487; Sun, 22
 Oct 2023 09:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231006155739.246381-1-yakoyoku@gmail.com> <20231006155739.246381-2-yakoyoku@gmail.com>
In-Reply-To: <20231006155739.246381-2-yakoyoku@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 23 Oct 2023 01:21:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQhPRkSpBQcn44dPMmnBVR=aTxMpG3vS4-=FkgQ5T2PVQ@mail.gmail.com>
Message-ID: <CAK7LNAQhPRkSpBQcn44dPMmnBVR=aTxMpG3vS4-=FkgQ5T2PVQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] scripts: Build per module Rust crates
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 12:57=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Enables compiling Rust crates as dependencies of kernel modules.
>
> When a composite object depends on an `.rlib` file, which by the way is
> a current ar archive, Kbuild will compile it from its base Rust source
> and link it.
>
> This makes possible to have Rust bindings for a subsystem that is
> compiled as a module.
>
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>


I could not understand how this will work because
there is no explanation how to use *.rlib in the later
build steps.

If I understand correctly, does this intend to link *.rlib
as a part of modules?

In C, there was a discussion about
"that would be nice to be able to link static libraries",
but we do not do it any more. [1]

Following that discussion, linking libraries does not
seem what we want to do.


[1]: https://lore.kernel.org/lkml/20200106032324.3147-1-masahiroy@kernel.or=
g/




> ---
>  Makefile               |  4 ++--
>  scripts/Makefile.build | 10 +++++++++-
>  scripts/Makefile.lib   | 19 +++++++++++++------
>  3 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 7d6be12e4c3e..7774c97e8aa0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -283,7 +283,7 @@ no-compiler-targets :=3D $(no-dot-config-targets) ins=
tall dtbs_install \
>                         headers_install modules_install modules_sign kern=
elrelease image_name
>  no-sync-config-targets :=3D $(no-dot-config-targets) %install modules_si=
gn kernelrelease \
>                           image_name
> -single-targets :=3D %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.=
symtypes %/
> +single-targets :=3D %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rlib %.rsi=
 %.s %.symtypes %/
>
>  config-build   :=3D
>  mixed-build    :=3D
> @@ -1919,7 +1919,7 @@ $(clean-dirs):
>  clean: $(clean-dirs)
>         $(call cmd,rmfiles)
>         @find $(or $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
> -               \( -name '*.[aios]' -o -name '*.rsi' -o -name '*.ko' -o -=
name '.*.cmd' \
> +               \( -name '*.[aios]' -o -name '*.rlib' -o -name '*.rsi' -o=
 -name '*.ko' -o -name '.*.cmd' \
>                 -o -name '*.ko.*' \
>                 -o -name '*.dtb' -o -name '*.dtbo' \
>                 -o -name '*.dtb.S' -o -name '*.dtbo.S' \
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index da37bfa97211..627010518b27 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -246,7 +246,9 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
>  # To make this rule robust against "Argument list too long" error,
>  # ensure to add $(obj)/ prefix by a shell command.
>  cmd_mod =3D printf '%s\n' $(call real-search, $*.o, .o, -objs -y -m) | \
> -       $(AWK) '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
> +       $(AWK) '!x[$$0]++ { print("$(obj)/"$$0) }' > $@ && \
> +       printf '%s\n' $(call real-search, $*.rlib, .rlib, -objs -y -m) | =
\
> +       $(AWK) '!x[$$0]++ { print("--library=3D$(obj)/"$$0) }' >> $@
>
>  $(obj)/%.mod: FORCE
>         $(call if_changed,mod)
> @@ -291,6 +293,12 @@ quiet_cmd_rustc_o_rs =3D $(RUSTC_OR_CLIPPY_QUIET) $(=
quiet_modtag) $@
>  $(obj)/%.o: $(src)/%.rs FORCE
>         $(call if_changed_dep,rustc_o_rs)
>
> +quiet_cmd_rustc_rlib_rs =3D $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
> +      cmd_rustc_rlib_rs =3D $(rust_common_cmd) -Ccodegen-units=3D1 --emi=
t=3Dlink=3D$@ $<
> +
> +$(obj)/%.rlib: $(src)/%.rs FORCE
> +       $(call if_changed_dep,rustc_rlib_rs)
> +
>  quiet_cmd_rustc_rsi_rs =3D $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
>        cmd_rustc_rsi_rs =3D \
>         $(rust_common_cmd) -Zunpretty=3Dexpanded $< >$@; \
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 68d0134bdbf9..6e8cfbad015d 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -53,14 +53,18 @@ multi-search =3D $(sort $(foreach m, $1, $(if $(call =
suffix-search, $m, $2, $3 -),
>  real-search =3D $(foreach m, $1, $(if $(call suffix-search, $m, $2, $3 -=
), $(call suffix-search, $m, $2, $3), $m))
>
>  # If $(foo-objs), $(foo-y), $(foo-m), or $(foo-) exists, foo.o is a comp=
osite object
> -multi-obj-y :=3D $(call multi-search, $(obj-y), .o, -objs -y)
> -multi-obj-m :=3D $(call multi-search, $(obj-m), .o, -objs -y -m)
> +multi-obj-y :=3D $(call multi-search, $(obj-y), .o, -objs -y) \
> +       $(call multi-search, $(obj-y), .rlib, -objs -y)
> +multi-obj-m :=3D $(call multi-search, $(obj-m), .o, -objs -y -m) \
> +       $(call multi-search, $(obj-m), .rlib, -objs -y -m)
>  multi-obj-ym :=3D $(multi-obj-y) $(multi-obj-m)
>
>  # Replace multi-part objects by their individual parts,
>  # including built-in.a from subdirectories
> -real-obj-y :=3D $(call real-search, $(obj-y), .o, -objs -y)
> -real-obj-m :=3D $(call real-search, $(obj-m), .o, -objs -y -m)
> +real-obj-y :=3D $(call real-search, $(obj-y), .o, -objs -y) \
> +       $(call real-search, $(obj-y), .rlib, -objs -y)
> +real-obj-m :=3D $(call real-search, $(obj-m), .o, -objs -y -m) \
> +       $(call real-search, $(obj-m), .rlib, -objs -y -m)
>
>  always-y +=3D $(always-m)
>
> @@ -107,7 +111,8 @@ endif
>  # Finds the multi-part object the current object will be linked into.
>  # If the object belongs to two or more multi-part objects, list them all=
.
>  modname-multi =3D $(sort $(foreach m,$(multi-obj-ym),\
> -               $(if $(filter $*.o, $(call suffix-search, $m, .o, -objs -=
y -m)),$(m:.o=3D))))
> +               $(if $(filter $*.o, $(call suffix-search, $m, .o, -objs -=
y -m)),$(m:.o=3D)) \
> +               $(if $(filter $*.rlib, $(call suffix-search, $m, .rlib, -=
objs -y -m)),$(m:.rlib=3D))))
>
>  __modname =3D $(or $(modname-multi),$(basetarget))
>
> @@ -210,7 +215,9 @@ _cpp_flags +=3D -I $(srctree)/$(src) -I $(objtree)/$(=
obj)
>  endif
>  endif
>
> -part-of-module =3D $(if $(filter $(basename $@).o, $(real-obj-m)),y)
> +part-of-module =3D                                             \
> +       $(if $(or $(filter $(basename $@).o, $(real-obj-m)), \
> +               $(filter $(basename $@).rlib, $(real-obj-m))),y)
>  quiet_modtag =3D $(if $(part-of-module),[M],   )
>
>  modkern_cflags =3D                                          \
> --
> 2.42.0
>


--
Best Regards
Masahiro Yamada
