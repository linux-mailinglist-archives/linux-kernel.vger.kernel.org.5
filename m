Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A361781C38
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 04:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjHTCya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 22:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjHTCyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 22:54:20 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A2476BF;
        Sat, 19 Aug 2023 19:41:04 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1ba5cda3530so1448244fac.3;
        Sat, 19 Aug 2023 19:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692499263; x=1693104063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Kpw3yWiFKlfFLv5GS4zKO6CrOfXeWkscrMb9gqFLe4=;
        b=ImDbeLxqUehgxT/7yc4i8IKtSOvt1aEqHNus72ZwXUuTBsgAmlGoMWmEWvwCKK/Jan
         3Fq2QRUkaZg0dK8aO90QKw8L9tw+xiaUaIgB2nZ2VgMelLxvL+Rh2O//u+3EM+hAk9Hf
         rtjPuVUrxRvi8iDImEQK5RRKvVXEVCgXLmaQFY+n4eKxWe3y4ITYXruJwz5OBaOYsDe4
         AyyPOTZbJEwgf/sjqxSwzeLQkqWz2OpLvfp4xUw4AjwXEQcsjq0Wbbnz6y4K0+R/uZES
         4nDkrzVKo0PqNGAP+YKW3t0PLrfMGxPzlbdY/022CI68egDU04KjTNrPRql4m9F5v09k
         xFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692499263; x=1693104063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Kpw3yWiFKlfFLv5GS4zKO6CrOfXeWkscrMb9gqFLe4=;
        b=eeR6iX0MdpnjHxnm0TDLEek0p2jtAk2liC/xOLqHeQrpNQdnU+tWo1z31tvx8hW4b7
         NjZ8Z/4rzW1ddyUd7fyFKWQLM1jPJWu1S+ZAL3OxJ3nyR1OJYjF23OcId3ldzLYdZT2Z
         JY5N+KlrNopNK4Ja9mMEQZF6tYKcpKGBKx3WatNn/gBRyClWbcuDQcYZJbZJP+Gjlv91
         pu+weoJG3m1CoQpnkrElUSa6A/zSb3Rpr9H5ZV7RgYZ6sS9786SAFTnpGe+U9QCN1qsH
         zA5oHiechw2PGRS4wQypSz+/f3wVtqAnN31pyq4uVdIc6/ff/VSAVs3ZC0t6J1BgY0ZW
         eIRg==
X-Gm-Message-State: AOJu0YxjG2nmtDb6ZL/hsnG3YEo97q6OVrkuM8K6W09X9Eay0vzWgSgp
        JSnwNNfk2FBDSmWaW0ubIj475DQ5v+xXtIKa1us=
X-Google-Smtp-Source: AGHT+IF0/BpgNnaEFFp+5tGGZpCsDWps1ZoQZenOxe1/szfSXioRjwV0ucm73pRmIpK8zfTGk7s1RLD+9MTyoAmzaAk=
X-Received: by 2002:a05:6870:659f:b0:1b0:408a:1d14 with SMTP id
 fp31-20020a056870659f00b001b0408a1d14mr4521580oab.44.1692499263196; Sat, 19
 Aug 2023 19:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230809002436.18079-1-sunying@nj.iscas.ac.cn> <CAK7LNARH-ziDD8=+90y5Zzo0cqqnc5qaiVWW0YQzdZ=nO9+e8w@mail.gmail.com>
In-Reply-To: <CAK7LNARH-ziDD8=+90y5Zzo0cqqnc5qaiVWW0YQzdZ=nO9+e8w@mail.gmail.com>
From:   Jesse T <mr.bossman075@gmail.com>
Date:   Sat, 19 Aug 2023 22:40:26 -0400
Message-ID: <CAJFTR8SajdzT2kKscEpPon9faUa8tHrvYPC_+awG3VeHVS8sSg@mail.gmail.com>
Subject: Re: [PATCH] kconfig: add dependency warning print about invalid
 values in verbose mode
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     sunying@nj.iscas.ac.cn, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Siyuan Guo <zy21df106@buaa.edu.cn>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 8:59=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Wed, Aug 9, 2023 at 9:32=E2=80=AFAM <sunying@nj.iscas.ac.cn> wrote:
> >
> > From: Ying Sun <sunying@nj.iscas.ac.cn>
> >
> > Add warning about the configuration option's invalid value in verbose m=
ode,
> >  including error causes, mismatch dependency, old and new values,
> >  to help users correct them.

It should also warn about invalid options which were being talked
about in other places.
https://lore.kernel.org/all/20230817012007.131868-1-senozhatsky@chromium.or=
g/T/#u
https://lore.kernel.org/lkml/CAMuHMdWF0LseSGK6=3DaodXaoK9D16mxok4DDRs=3DgKo=
Gox8k6zjg@mail.gmail.com/T/#mb5b73532166014ce0a66b0e7e11dbe06528d863c

I can also cause a segfault by removing options such as removing
`CONFIG_SMP=3Dy`  from x86_64_defconfig

> >
> > Detailed error messages are printed only when the environment variable
> >  is set like "KCONFIG_VERBOSE=3D1".
> > By default, the current behavior is not changed.
> >
> > Signed-off-by: Siyuan Guo <zy21df106@buaa.edu.cn>
> > Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>
>
>
> This patch is much bigger than I had expected.
>
> I did not go through all the lines, but
> I think the behavior should be improved.
>
>
>
> [1] A downgrade from 'y' to 'm' should be warned.
>
>
> You only check (sym->dir_dep.tri =3D=3D no && sym->def[S_DEF_USER].tri !=
=3D no)
>
> but (sym->dir_dep.tri =3D=3D mod && sym->def[S_DEF_USER].tri =3D=3D yes)
> will cause =3Dy to be downgraded to =3Dm.
> This must be warned.
>
>
>
>
> [2] A new CONFIG option should not be warned.
>
> $ make defconfig
>
> Add the following two lines to a Kconfig file.
>
> config THIS_IS_A_NEW_OPTION
>        def_bool y
>
>
> $ make KCONFIG_VERBOSE=3D1 oldconfig
>
> ERROR : THIS_IS_A_NEW_OPTION[n =3D> y] value is invalid
>  due to it has default value
> #
> # configuration written to .config
> #
>
>
>
>
> This is totally harmless.
> I do not understand why it is warned.
>
>
>
>
>
> BTW, your patch subject says
> "add dependency warning", but your actually code prints "ERROR".
>
> Also, check the coding style.
>
>
>
>
>
>
>
> > ---
> >  scripts/kconfig/confdata.c | 121 +++++++++++++++++++++++++++++++++++--
> >  scripts/kconfig/lkc.h      |   3 +
> >  scripts/kconfig/symbol.c   |  82 +++++++++++++++++++++++--
> >  3 files changed, 195 insertions(+), 11 deletions(-)
> >
> > diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> > index 992575f1e976..fa2ae6f63352 100644
> > --- a/scripts/kconfig/confdata.c
> > +++ b/scripts/kconfig/confdata.c
> > @@ -154,6 +154,7 @@ static void conf_message(const char *fmt, ...)
> >
> >  static const char *conf_filename;
> >  static int conf_lineno, conf_warnings;
> > +const char *verbose;
> >
> >  static void conf_warning(const char *fmt, ...)
> >  {
> > @@ -226,7 +227,7 @@ static const char *conf_get_rustccfg_name(void)
> >  static int conf_set_sym_val(struct symbol *sym, int def, int def_flags=
, char *p)
> >  {
> >         char *p2;
> > -
> > +       static const char * const type[] =3D {"unknown", "bool", "trist=
ate", "int", "hex", "string"};

Add a new line after the declaration.
Not sure why checkpatch didn't get this.

> >         switch (sym->type) {
> >         case S_TRISTATE:
> >                 if (p[0] =3D=3D 'm') {
> > @@ -246,9 +247,14 @@ static int conf_set_sym_val(struct symbol *sym, in=
t def, int def_flags, char *p)
> >                         sym->flags |=3D def_flags;
> >                         break;
> >                 }
> > -               if (def !=3D S_DEF_AUTO)
> > -                       conf_warning("symbol value '%s' invalid for %s"=
,
> > +               if (def !=3D S_DEF_AUTO) {
> > +                       if (verbose)
> > +                               conf_warning("symbol value '%s' invalid=
 for %s\n due to its type is %s",
> > +                                    p, sym->name, type[sym->type]);

normally indented to the opening parenthesis, same with the rest.

> > +                       else
> > +                               conf_warning("symbol value '%s' invalid=
 for %s",
> >                                      p, sym->name);
> > +               }
> >                 return 1;
> >         case S_STRING:
> >                 /* No escaping for S_DEF_AUTO (include/config/auto.conf=
) */
> > @@ -274,9 +280,14 @@ static int conf_set_sym_val(struct symbol *sym, in=
t def, int def_flags, char *p)
> >                         sym->def[def].val =3D xstrdup(p);
> >                         sym->flags |=3D def_flags;
> >                 } else {
> > -                       if (def !=3D S_DEF_AUTO)
> > -                               conf_warning("symbol value '%s' invalid=
 for %s",
> > -                                            p, sym->name);
> > +                       if (def !=3D S_DEF_AUTO) {
> > +                               if (verbose)
> > +                                       conf_warning("symbol value '%s'=
 invalid for %s\n due to its type is %s",
> > +                                               p, sym->name, type[sym-=
>type]);
> > +                               else
> > +                                       conf_warning("symbol value '%s'=
 invalid for %s",
> > +                                               p, sym->name);
> > +                       }
> >                         return 1;
> >                 }
> >                 break;
> > @@ -528,6 +539,7 @@ int conf_read(const char *name)
> >         int conf_unsaved =3D 0;
> >         int i;
> >
> > +       verbose =3D getenv("KCONFIG_VERBOSE");
> >         conf_set_changed(false);
> >
> >         if (conf_read_simple(name, S_DEF_USER)) {
> > @@ -559,6 +571,103 @@ int conf_read(const char *name)
> >                         continue;
> >                 conf_unsaved++;
> >                 /* maybe print value in verbose mode... */
> > +               if (verbose) {
> > +                       if (sym_is_choice_value(sym)) {
> > +                               struct property *prop =3D sym_get_choic=
e_prop(sym);
> > +                               struct symbol *defsym =3D prop_get_symb=
ol(prop)->curr.val;
> > +
> > +                               if (defsym && defsym !=3D sym) {
> > +                                       struct gstr gs =3D str_new();
> > +
> > +                                       str_printf(&gs,
> > +                                               "\nERROR : %s[%c =3D> %=
c] value is invalid\n",
> > +                                               sym->name,
> > +                                               tristate2char[sym->def[=
S_DEF_USER].tri],
> > +                                               tristate2char[sym->curr=
.tri]);
> > +                                       str_printf(&gs,
> > +                                               " due to its not the ch=
oice default symbol\n");
> > +                                       str_printf(&gs,
> > +                                               " the default symbol is=
 %s\n",
> > +                                               defsym->name);
> > +                                       fputs(str_get(&gs), stderr);
> > +                               }
> > +                       } else {
> > +                               switch (sym->type) {
> > +                               case S_BOOLEAN:
> > +                               case S_TRISTATE:
> > +                                       if (sym->dir_dep.tri =3D=3D no =
&&
> > +                                               sym->def[S_DEF_USER].tr=
i !=3D no) {
> > +                                               struct gstr gs =3D str_=
new();
> > +
> > +                                               str_printf(&gs,
> > +                                                       "\nERROR: unmet=
 direct dependencies detected for %s[%c =3D> %c]\n",
> > +                                                       sym->name,
> > +                                                       tristate2char[s=
ym->def[S_DEF_USER].tri],
> > +                                                       tristate2char[s=
ym->curr.tri]);
> > +                                               str_printf(&gs,
> > +                                                       "  Depends on [=
%c]: ",
> > +                                                       sym->dir_dep.tr=
i =3D=3D mod ? 'm' : 'n');
> > +                                               expr_gstr_print(sym->di=
r_dep.expr, &gs);
> > +                                               str_printf(&gs, "\n");
> > +                                               fputs(str_get(&gs), std=
err);
> > +                                       } else if (sym->rev_dep.tri !=
=3D no) {
> > +                                               struct gstr gs =3D str_=
new();
> > +
> > +                                               str_printf(&gs,
> > +                                                       "\nERROR : %s[%=
c =3D> %c] value is invalid\n",
> > +                                                       sym->name,
> > +                                                       tristate2char[s=
ym->def[S_DEF_USER].tri],
> > +                                                       tristate2char[s=
ym->curr.tri]);
> > +                                               str_printf(&gs,
> > +                                                       " due to its in=
visible and it is selected\n");

As Masahiro said this is unnecessary.
Maybe add a verbosity level for this.

> > +                                               expr_gstr_print_revdep(=
sym->rev_dep.expr, &gs, yes,
> > +                                                                      =
 "  Selected by [y]:\n");
> > +                                               expr_gstr_print_revdep(=
sym->rev_dep.expr, &gs, mod,
> > +                                                                      =
 "  Selected by [m]:\n");
> > +                                               fputs(str_get(&gs), std=
err);
> > +                                       } else {
> > +                                               sym_validate_default(sy=
m);
> > +                                       }
> > +                                       break;
> > +                               case S_INT:
> > +                               case S_HEX:
> > +                                       if (sym->dir_dep.tri =3D=3D no =
&&
> > +                                       strcmp((char *)(sym->def[S_DEF_=
USER].val), "") !=3D 0) {
> > +                                               struct gstr gs =3D str_=
new();
> > +
> > +                                               str_printf(&gs,
> > +                                                       "\nERROR: unmet=
 direct dependencies detected for %s\n",
> > +                                                       sym->name);
> > +                                               str_printf(&gs,
> > +                                                       "  Depends on [=
%c]: ",
> > +                                                       sym->dir_dep.tr=
i =3D=3D mod ? 'm' : 'n');
> > +                                               expr_gstr_print(sym->di=
r_dep.expr, &gs);
> > +                                               str_printf(&gs, "\n");
> > +                                               fputs(str_get(&gs), std=
err);
> > +                                       } else {
> > +                                               sym_validate_default(sy=
m);
> > +                                       }
> > +                                       break;
> > +                               case S_STRING:
> > +                                       if (sym->dir_dep.tri =3D=3D no =
&&
> > +                                       strcmp((char *)(sym->def[S_DEF_=
USER].val), "") !=3D 0) {
> > +                                               struct gstr gs =3D str_=
new();
> > +
> > +                                               str_printf(&gs,
> > +                                                       "\nERROR: unmet=
 direct dependencies detected for %s\n",
> > +                                                       sym->name);
> > +                                               str_printf(&gs,
> > +                                                       "  Depends on [=
%c]: ",
> > +                                                       sym->dir_dep.tr=
i =3D=3D mod ? 'm' : 'n');
> > +                                               expr_gstr_print(sym->di=
r_dep.expr, &gs);
> > +                                               str_printf(&gs, "\n");
> > +                                               fputs(str_get(&gs), std=
err);
> > +                                       }
> > +                               default:
> > +                                       break;
> > +                               }
> > +                       }
> > +               }
> >         }
> >
> >         for_all_symbols(i, sym) {
> > diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
> > index 471a59acecec..820a47fb4968 100644
> > --- a/scripts/kconfig/lkc.h
> > +++ b/scripts/kconfig/lkc.h
> > @@ -38,6 +38,8 @@ void zconf_initscan(const char *name);
> >  void zconf_nextfile(const char *name);
> >  int zconf_lineno(void);
> >  const char *zconf_curname(void);
> > +extern const char *verbose;
> > +static const char tristate2char[3] =3D {'n', 'm', 'y'};

This seems non-ideal

> >
> >  /* confdata.c */
> >  const char *conf_get_configname(void);
> > @@ -112,6 +114,7 @@ struct property *sym_get_range_prop(struct symbol *=
sym);
> >  const char *sym_get_string_default(struct symbol *sym);
> >  struct symbol *sym_check_deps(struct symbol *sym);
> >  struct symbol *prop_get_symbol(struct property *prop);
> > +void sym_validate_default(struct symbol *sym);
> >
> >  static inline tristate sym_get_tristate_value(struct symbol *sym)
> >  {
> > diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
> > index 0572330bf8a7..8b11d6ea1d30 100644
> > --- a/scripts/kconfig/symbol.c
> > +++ b/scripts/kconfig/symbol.c
> > @@ -91,6 +91,53 @@ static struct property *sym_get_default_prop(struct =
symbol *sym)
> >         return NULL;
> >  }
> >
> > +void sym_validate_default(struct symbol *sym)
> > +{
> > +       if (sym->visible =3D=3D no) {
> > +               struct gstr gs =3D str_new();
> > +               const char *value =3D sym_get_string_default(sym);
> > +
> > +               switch (sym->type) {
> > +               case S_BOOLEAN:
> > +               case S_TRISTATE:
> > +                       if (strcmp(value, "n") !=3D 0) {
> > +                               str_printf(&gs,
> > +                                       "\nERROR : %s[%c =3D> %c] value=
 is invalid\n due to it has default value\n",
> > +                                       sym->name,
Same here
> > +                                       tristate2char[sym->def[S_DEF_US=
ER].tri],
> > +                                       tristate2char[sym->curr.tri]);
> > +                       } else if (sym->implied.tri !=3D no) {
> > +                               str_printf(&gs,
> > +                                       "\nERROR : %s[%c =3D> %c] value=
 is invalid\n due to its invisible and has imply value\n",
> > +                                       sym->name,
And here
> > +                                       tristate2char[sym->def[S_DEF_US=
ER].tri],
> > +                                       tristate2char[sym->curr.tri]);
> > +                               str_printf(&gs,
> > +                                       " Imply : ");
> > +                               expr_gstr_print(sym->implied.expr, &gs)=
;
> > +                               str_printf(&gs, "\n");
> > +                       }
> > +                       break;
> > +               case S_STRING:
> > +               case S_INT:
> > +               case S_HEX:
> > +                       if (strcmp(value, "") !=3D 0) {
> > +                               str_printf(&gs,
> > +                                       "\nERROR : %s[%s =3D> %s] value=
 is invalid\n",
> > +                                       sym->name,
> > +                                       (char *)(sym->def[S_DEF_USER].v=
al),
> > +                                       (char *)(sym->curr.val));
> > +                               str_printf(&gs,
> > +                                       " due to it has default value\n=
");
> > +                       }
> > +                       break;
> > +               default:
> > +                       break;
> > +               }
> > +               fputs(str_get(&gs), stderr);
> > +       }
> > +}
> > +
> >  struct property *sym_get_range_prop(struct symbol *sym)
> >  {
> >         struct property *prop;
> > @@ -600,7 +647,8 @@ bool sym_string_valid(struct symbol *sym, const cha=
r *str)
> >  bool sym_string_within_range(struct symbol *sym, const char *str)
> >  {
> >         struct property *prop;
> > -       long long val;
> > +       long long val, left, right;
> > +       struct gstr gs =3D str_new();
> >
> >         switch (sym->type) {
> >         case S_STRING:
> > @@ -612,8 +660,20 @@ bool sym_string_within_range(struct symbol *sym, c=
onst char *str)
> >                 if (!prop)
> >                         return true;
> >                 val =3D strtoll(str, NULL, 10);
> > -               return val >=3D sym_get_range_val(prop->expr->left.sym,=
 10) &&
> > -                      val <=3D sym_get_range_val(prop->expr->right.sym=
, 10);
> > +               left =3D sym_get_range_val(prop->expr->left.sym, 10);
> > +               right =3D sym_get_range_val(prop->expr->right.sym, 10);
> > +               if (val >=3D left && val <=3D right)
> > +                       return true;
> > +               if (verbose) {
> > +                       str_printf(&gs,
> > +                               "\nERROR: unmet range detected for %s\n=
",
> > +                               sym->name);
> > +                       str_printf(&gs,
> > +                               " symbol value is %lld, the range is (%=
lld %lld)\n",
> > +                               val, left, right);
> > +                       fputs(str_get(&gs), stderr);
> > +               }
> > +               return false;
> >         case S_HEX:
> >                 if (!sym_string_valid(sym, str))
> >                         return false;
> > @@ -621,8 +681,20 @@ bool sym_string_within_range(struct symbol *sym, c=
onst char *str)
> >                 if (!prop)
> >                         return true;
> >                 val =3D strtoll(str, NULL, 16);
> > -               return val >=3D sym_get_range_val(prop->expr->left.sym,=
 16) &&
> > -                      val <=3D sym_get_range_val(prop->expr->right.sym=
, 16);
> > +               left =3D sym_get_range_val(prop->expr->left.sym, 16);
> > +               right =3D sym_get_range_val(prop->expr->right.sym, 16);
> > +               if (val >=3D left && val <=3D right)
> > +                       return true;
> > +               if (verbose) {
> > +                       str_printf(&gs,
> > +                               "\nERROR: unmet range detected for %s\n=
",
> > +                               sym->name);
> > +                       str_printf(&gs,
> > +                               " symbol value is 0x%llx, the range is =
(0x%llx 0x%llx)\n",
> > +                               val, left, right);
> > +                       fputs(str_get(&gs), stderr);
> > +               }
> > +               return false;
> >         case S_BOOLEAN:
> >         case S_TRISTATE:
> >                 switch (str[0]) {
> > --
> > 2.17.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada
