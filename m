Return-Path: <linux-kernel+bounces-60576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56247850745
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48B11F24491
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014B5FEF3;
	Sat, 10 Feb 2024 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3HS4gjj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B447F4B;
	Sat, 10 Feb 2024 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707607529; cv=none; b=eZs0KfvTPCUa68+VGQgi92SahBJHhE2nRzlD6I7kM5c1qAHc5JF6uf6SBRekjQuFAx60kFedsOdSTCJu1IhRt5EHADB4TO71p0OfBDJEF1vCHExB2+/nANwYRSj9KLKs7HSGmrkJ/gd6GLK5XNUVET5iHiR3LQaDEcc1OfdTeVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707607529; c=relaxed/simple;
	bh=hHrH7ONm5hLvZSf99CN4UEHSezRXejAosEIyaVObVRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3sF6W/PJywq9PIKcGmxJrgB/E0USUOyNuO4tr4tjxrAGyeL/MlU4vsiE2zTek+z39SlRGnpIc8fRkIS8w4hjrb4ob05H+2LidhNgdCHgaD3OmrBcFw+FoxXIlGgnAHp8Wn8ulH79S+VVGrOs/5lw11Y2OExKkuLILMpOcMnngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3HS4gjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09E5C433C7;
	Sat, 10 Feb 2024 23:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707607528;
	bh=hHrH7ONm5hLvZSf99CN4UEHSezRXejAosEIyaVObVRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l3HS4gjjvmKBDFICblYdf/mCDKd2B6n23QNBS31VJ4psrlIcyluRH9pJs6YZpFr7Q
	 Cb8FSTkBaDfhE7VkHeozOC7Zt2lvRBzzx4VP0q/V3UYBlQ44N53Ta8rYKnQiHJKc9A
	 bfsnEi01Sxdyyp21hQVr30ObR6xqQrXMJL2f5MlZBKGtMSEFafKvOQAiYV7LMNhxkk
	 VetD8ogNI5y2jttNnpj9oCjPg33z4A6Zpu2nGJx1JGrb/SoAsmDXY/p7DT4vbAbRF/
	 PE+IKsyyyIUFFFAdU05S6C+sEzTPDH9jEG0SwxFUJ6I0yVQNrSNR9chOvGAu13/Tjm
	 sqJybCZMHcD0w==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51178bbb5d9so1835786e87.2;
        Sat, 10 Feb 2024 15:25:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVC1D7TV19A3kUt7RdMZT13NHnO71taTxSF4e1Jr7CwPT5Eenn0Q74SCMADRDPsJ7pnMVGb7bJp5BCPNol68k6KE1ewgA6Ovpy6HM0f
X-Gm-Message-State: AOJu0YxeC1W6YhAcDcTOZ2ZsCFCYKQpzqrOd+88RR7rFuhWw+KgvSmic
	kC8vPK1VmyjrC44pV13Z7jh9BvaBWQSfJNcXzYNYRyNi84x4J3FJ6b/m7DnwnO0Xh/187EjRJ56
	1P87oCPiWRsK12Mndgk8/aH+zFC0=
X-Google-Smtp-Source: AGHT+IGtWFeHRbAlIEu+cmwmEGyo32x4JVI+cDeJ2RCzheduLrA1ihhqotv5lI0I2KZScdx9q7GJ07d/0IY5jOXiYEA=
X-Received: by 2002:a05:6512:308d:b0:50e:a789:dd3b with SMTP id
 z13-20020a056512308d00b0050ea789dd3bmr2628377lfd.1.1707607527331; Sat, 10 Feb
 2024 15:25:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102020405.32701-1-sunying@isrc.iscas.ac.cn>
In-Reply-To: <20240102020405.32701-1-sunying@isrc.iscas.ac.cn>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 11 Feb 2024 08:24:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNATCtoCEs4-S6kgGCH8XRkX+sKT3zuP-awdFJr+E1bkZww@mail.gmail.com>
Message-ID: <CAK7LNATCtoCEs4-S6kgGCH8XRkX+sKT3zuP-awdFJr+E1bkZww@mail.gmail.com>
Subject: Re: [PATCHv3 next] kconfig: add dependency warning print about
 invalid values in verbose mode
To: sunying@isrc.iscas.ac.cn
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pengpeng@iscas.ac.cn, Siyuan Guo <zy21df106@buaa.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"in verbose mode" is stale.

Please rephrase the subject.




On Tue, Jan 2, 2024 at 11:11=E2=80=AFAM <sunying@isrc.iscas.ac.cn> wrote:
>
> From: Ying Sun <sunying@isrc.iscas.ac.cn>
>
> Warning in verbose mode about incorrect causes and
>  mismatch dependency of invalid values to help users correct them.

Same here, "verbose mode" does not exist in this patch.




>
> Detailed warning messages are printed only when the environment variable
>  is set like "KCONFIG_WARN_CHANGED_INPUT=3D1".
> By default, the current behavior is not changed.
>
> Signed-off-by: Siyuan Guo <zy21df106@buaa.edu.cn>
> Signed-off-by: Ying Sun <sunying@isrc.iscas.ac.cn>
> ---
> v2 -> v3:
> * Fixed warning message that mess up the ncurses display.
> * Fixed memory leak where str_new() was called but str_free() was not use=
d.
> * Integrated the code to avoid excessive dispersion.
> * Use the environment variable KCONFIG_WARN_CHANGED_INPUT as the switch




This checker prints wrong reports.


I just attached one test case.



[test Kconfig]

config MODULES
       def_bool y
       modules

config FOO
       tristate "foo"
       depends on BAR

config BAR
       tristate "bar"

config BAZ
       tristate "baz"
       select FOO


[test .config]

CONFIG_FOO=3Dm
# CONFIG_BAR is not set
CONFIG_BAZ=3Dy



[test command]


$ KCONFIG_WARN_CHANGED_INPUT=3D1 make  olddefconfig



[result]


Kconfig:8:warning: 'MODULES' set to y due to option constraints


WARNING: unmet direct dependencies detected for FOO
  Depends on [n]: BAR [=3Dn]
  Selected by [y]:
  - BAZ [=3Dy]
Kconfig:12:warning: 'FOO' set to n for it unmet direct dependencies
 Depends on [n]: BAR [=3Dn]



$ cat .config
#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 6.8.0-rc3 Kernel Configuration
#
CONFIG_MODULES=3Dy
CONFIG_FOO=3Dy
# CONFIG_BAR is not set
CONFIG_BAZ=3Dy







The first report

  Kconfig:8:warning: 'MODULES' set to y due to option constraints

should not be printed.

CONFIG options without prompt can be omitted.




The second report

  Kconfig:12:warning: 'FOO' set to n for it unmet direct dependencies

is completely wrong.



CONFIG_FOO was changed to 'y' due to the select.





One more thing,

Add
export KCONFIG_WARN_CHANGED_INPUT=3D1

to scripts/kconfig/Makefile




> v1 -> v2:
> * Reduced the number of code lines by refactoring and simplifying the log=
ic.
> * Changed the print "ERROR" to "WARNING".
> * Focused on handling dependency errors: dir_dep and rev_dep, and range e=
rror.
>   - A downgrade from 'y' to 'm' has be warned.
>   - A new CONFIG option should not be warned.
>   - Overwriting caused by default value is not an error and is no longer =
printed.
> * Fixed style issues.
> ---
> ---
>  scripts/kconfig/confdata.c | 76 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index f1197e672431..352774928558 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -195,6 +195,52 @@ static void conf_message(const char *fmt, ...)
>         va_end(ap);
>  }
>
> +static void conf_warn_unmet_rev_dep(struct symbol *sym)
> +{
> +       struct gstr gs =3D str_new();
> +       char value =3D 'n';
> +
> +       switch (sym->curr.tri) {
> +       case no:
> +               value =3D 'n';
> +               break;
> +       case mod:
> +               sym_calc_value(modules_sym);
> +               value =3D (modules_sym->curr.tri =3D=3D no) ? 'n' : 'm';
> +               break;
> +       case yes:
> +               value =3D 'y';
> +       }
> +
> +       str_printf(&gs,
> +               "'%s' set to %c for it is selected\n",
> +               sym->name, value);
> +       expr_gstr_print_revdep(sym->rev_dep.expr, &gs, yes,
> +                               " Selected by [y]:\n");
> +       expr_gstr_print_revdep(sym->rev_dep.expr, &gs, mod,
> +                               " Selected by [m]:\n");
> +
> +       conf_warning("%s", str_get(&gs));
> +       str_free(&gs);
> +}
> +
> +static void conf_warn_dep_error(struct symbol *sym)
> +{
> +       struct gstr gs =3D str_new();
> +
> +       str_printf(&gs,
> +               "'%s' set to n for it unmet direct dependencies\n",
> +               sym->name);
> +
> +       str_printf(&gs,
> +               " Depends on [%c]: ",
> +               sym->dir_dep.tri =3D=3D mod ? 'm' : 'n');
> +       expr_gstr_print(sym->dir_dep.expr, &gs);
> +
> +       conf_warning("%s\n", str_get(&gs));
> +       str_free(&gs);
> +}
> +
>  const char *conf_get_configname(void)
>  {
>         char *name =3D getenv("KCONFIG_CONFIG");
> @@ -568,6 +614,36 @@ int conf_read(const char *name)
>                         continue;
>                 conf_unsaved++;
>                 /* maybe print value in verbose mode... */
> +               if (getenv("KCONFIG_WARN_CHANGED_INPUT") && (sym->prop)) =
{
> +                       conf_filename =3D sym->prop->file->name;
> +                       conf_lineno =3D sym->prop->menu->lineno;
> +
> +                       switch (sym->type) {
> +                       case S_BOOLEAN:
> +                       case S_TRISTATE:
> +                               if (sym->def[S_DEF_USER].tri !=3D sym_get=
_tristate_value(sym)) {
> +                                       if (sym->dir_dep.tri < sym->def[S=
_DEF_USER].tri)
> +                                               conf_warn_dep_error(sym);
> +                                       else if (sym->rev_dep.tri > sym->=
def[S_DEF_USER].tri)
> +                                               conf_warn_unmet_rev_dep(s=
ym);
> +                                       else
> +                                               conf_warning("'%s' set to=
 %s due to option constraints\n",
> +                                                       sym->name, sym_ge=
t_string_value(sym));
> +                               }
> +                               break;
> +                       case S_INT:
> +                       case S_HEX:
> +                       case S_STRING:
> +                               if (sym->dir_dep.tri =3D=3D no && sym_has=
_value(sym))
> +                                       conf_warn_dep_error(sym);
> +                               else
> +                                       conf_warning("'%s' set to %s due =
to option constraints\n",
> +                                                       sym->name, sym_ge=
t_string_value(sym));
> +                               break;
> +                       default:
> +                               break;
> +                       }
> +               }
>         }
>
>         for_all_symbols(i, sym) {
> --
> 2.43.0
>
>


--
Best Regards


Masahiro Yamada

