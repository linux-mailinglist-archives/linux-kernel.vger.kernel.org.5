Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE217E1945
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjKFDvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 22:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFDvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:51:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E5DB8;
        Sun,  5 Nov 2023 19:51:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B44C433C7;
        Mon,  6 Nov 2023 03:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699242709;
        bh=p/6rdTgcnmPyf/XIA2wa9x+F/17gU25Jm/S8oBO6vT4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AWq/lRP/WA+uswf/g9so48tierdTuIyxSbKjhaD8RF/pCLp3xCFYl4NUzx8y/0RrI
         FSkG46ZGn0hJ2DIqDnVmy8CXQKsTWPFjZ5mych1xeAjn8Hrp0isVZIj9TT01D3QANH
         B6a83kFbbnB00xILRnz1fHKuOjEPN6YKqSDwG4rXiQ1dozHaFrxFc9zo/Qv5jQPyhE
         vJq1vs7rKSuTe0X1JhXoIEAIjCXp+iVjvWdq86UoUfquhEHOG6k9OPKJ2e9EbeQ6tG
         /5ScK6XSNH3Gfz4qO3aACyCWNWVHHaoepMIemqlKjPnfwXefntDvuh/Gccs6LnA26X
         OlT89TXlwjUGg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-581ed744114so1845195eaf.0;
        Sun, 05 Nov 2023 19:51:49 -0800 (PST)
X-Gm-Message-State: AOJu0Yy8s2xJH3k+8nb1LDq9ADcEzur6dpBR3iZt0fp/CY+8A0mn/INZ
        d/ye4uQKg4ss2dBHTtDAGAero4gNasR7nP3G5Ws=
X-Google-Smtp-Source: AGHT+IGuZlBfZvF090gNi2fS9r0XqKdmDIfH0zE5MbrDrqNh4lxHFCn0DRpcFaCOAWQlckBIxv1TfmPDbEim0T4hRKk=
X-Received: by 2002:a05:6870:1382:b0:1f0:630b:c84e with SMTP id
 2-20020a056870138200b001f0630bc84emr7707493oas.57.1699242709042; Sun, 05 Nov
 2023 19:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20230905094313.11609-1-sunying@nj.iscas.ac.cn> <4c1a77f.2190e.18b8df041d0.Coremail.guosy@buaa.edu.cn>
In-Reply-To: <4c1a77f.2190e.18b8df041d0.Coremail.guosy@buaa.edu.cn>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 6 Nov 2023 05:51:11 +0200
X-Gmail-Original-Message-ID: <CAK7LNARZPSEB2ZiZ9YjBUWhi8gNvq0s3TTLjXAs53BVG3YYf9w@mail.gmail.com>
Message-ID: <CAK7LNARZPSEB2ZiZ9YjBUWhi8gNvq0s3TTLjXAs53BVG3YYf9w@mail.gmail.com>
Subject: Re: [PATCHv2 -next] kconfig: add dependency warning print about
 invalid values in verbose mode
To:     =?UTF-8?B?6YOt5oCd6L+c?= <guosy@buaa.edu.cn>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        senozhatsky@chromium.org, mr.bossman075@gmail.com,
        pengpeng@iscas.ac.cn, sunying@isrc.iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 4:51=E2=80=AFAM =E9=83=AD=E6=80=9D=E8=BF=9C <guosy@b=
uaa.edu.cn> wrote:
>
> I am writing to inquire about the status of my patch submission.
>
> Are there any issues with this patch that we need to modify?




Yes, many issues.





This patch will break the user interface
because printing messages to stderr
is not always allowed.




For example,


$ make nconfig KCONFIG_VERBOSE=3D1

Go to

 Kernel hacking --->
   printk and dmesg options --->
     Default console loglevel (1-15) -->


Input 20


The error message will mess up the ncurses display.


You need to use conf_warning().




You introduced memory leak because you called
str_new(), but did not call str_free().




For the environment variable, please use
something specific and descriptive.
For example, KCONFIG_WARN_CHANGED_INPUT




Lastly, please do not scatter the code everywhere.


I guess the right place to inject the checker is
conf_write() (and conf_write_defconfig() as well).



        } else if (!(sym->flags & SYMBOL_CHOICE) &&
                   !(sym->flags & SYMBOL_WRITTEN)) {
                sym_calc_value(sym);

                if (warn_changed_input)                 <--
                         warn_changed_user_input(sym);  <--

                if (!(sym->flags & SYMBOL_WRITE))
                         goto next;













>
> > On Fri, Sep 5, 2023 at 5:45PM Ying Sun <sunying@nj.iscas.ac.cn>wrote:
> >
> > Add warning about the configuration option's invalid value in verbose m=
ode,
> >  including error causes, mismatch dependency, old and new values,
> >  to help users correct them.
> >
> > Detailed error messages are printed only when the environment variable
> >  is set like "KCONFIG_VERBOSE=3D1".
> > By default, the current behavior is not changed.
> >
> > Signed-off-by: Siyuan Guo <zy21df106@buaa.edu.cn>
> > Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>
> > ---
> > v1 -> v2:
> > * Reduced the number of code lines by refactoring and simplifying the l=
ogic.
> > * Changed the print "ERROR" to "WARNING".
> > * Focused on handling dependency errors: dir_dep and rev_dep, and range=
 error.
> >   - A downgrade from 'y' to 'm' has be warned.
> >   - A new CONFIG option should not be warned.
> >   - Overwriting caused by default value is not an error and is no longe=
r printed.
> > * Fixed style issues.
> > ---
> >  scripts/kconfig/confdata.c | 100 +++++++++++++++++++++++++++++++++++--
> >  scripts/kconfig/lkc.h      |   7 +++
> >  scripts/kconfig/symbol.c   |  24 +++++++--
> >  3 files changed, 121 insertions(+), 10 deletions(-)
> >
> > diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> > index 4a6811d77d18..86794ab39d7d 100644
> > --- a/scripts/kconfig/confdata.c
> > +++ b/scripts/kconfig/confdata.c
> > @@ -154,6 +154,56 @@ static void conf_message(const char *fmt, ...)
> >
> >  static const char *conf_filename;
> >  static int conf_lineno, conf_warnings;
> > +const char *verbose;
> > +
> > +void conf_error_log(enum error_type type, struct symbol *sym, char *lo=
g, ...)
> > +{
> > +     static char *const tristate2str[3] =3D {"n", "m", "y"};
> > +     struct gstr gs =3D str_new();
> > +     char s[100];
> > +     char *oldval =3D NULL;
> > +     va_list args;
> > +
> > +     va_start(args, log);
> > +     vsnprintf(s, sizeof(s), log, args);
> > +     va_end(args);
> > +
> > +     switch (sym->type) {
> > +     case S_BOOLEAN:
> > +     case S_TRISTATE:
> > +             oldval =3D tristate2str[sym->def[S_DEF_USER].tri];
> > +             break;
> > +     case S_INT:
> > +     case S_HEX:
> > +     case S_STRING:
> > +             oldval =3D sym->def[S_DEF_USER].val;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     str_printf(&gs,
> > +             "\nWARNING : %s [%s] value is invalid\n",
> > +             sym->name, oldval);
> > +     str_printf(&gs, s);
> > +     switch (type) {
> > +     case DIR_DEP:
> > +             str_printf(&gs,
> > +                     "  Depends on [%c]: ",
> > +                     sym->dir_dep.tri =3D=3D mod ? 'm' : 'n');
> > +             expr_gstr_print(sym->dir_dep.expr, &gs);
> > +             str_printf(&gs, "\n");
> > +             break;
> > +     case REV_DEP:
> > +             expr_gstr_print_revdep(sym->rev_dep.expr, &gs, yes,
> > +                                     "  Selected by [y]:\n");
> > +             expr_gstr_print_revdep(sym->rev_dep.expr, &gs, mod,
> > +                                     "  Selected by [m]:\n");
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +     fputs(str_get(&gs), stderr);
> > +}
> >
> >  static void conf_warning(const char *fmt, ...)
> >  {
> > @@ -226,11 +276,14 @@ static const char *conf_get_rustccfg_name(void)
> >  static int conf_set_sym_val(struct symbol *sym, int def, int def_flags=
, char *p)
> >  {
> >       char *p2;
> > +     static const char * const type[] =3D {"unknown", "bool", "tristat=
e", "int", "hex", "string"};
> >
> >       switch (sym->type) {
> >       case S_TRISTATE:
> >               if (p[0] =3D=3D 'm') {
> >                       sym->def[def].tri =3D mod;
> > +
> > +
> >                       sym->flags |=3D def_flags;
> >                       break;
> >               }
> > @@ -246,9 +299,14 @@ static int conf_set_sym_val(struct symbol *sym, in=
t def, int def_flags, char *p)
> >                       sym->flags |=3D def_flags;
> >                       break;
> >               }
> > -             if (def !=3D S_DEF_AUTO)
> > -                     conf_warning("symbol value '%s' invalid for %s",
> > +             if (def !=3D S_DEF_AUTO) {
> > +                     if (verbose)
> > +                             conf_warning("symbol value '%s' invalid f=
or %s\n due to its type is %s",
> > +                                  p, sym->name, type[sym->type]);
> > +                     else
> > +                             conf_warning("symbol value '%s' invalid f=
or %s",
> >                                    p, sym->name);
> > +             }
> >               return 1;
> >       case S_STRING:
> >               /* No escaping for S_DEF_AUTO (include/config/auto.conf) =
*/
> > @@ -274,9 +332,14 @@ static int conf_set_sym_val(struct symbol *sym, in=
t def, int def_flags, char *p)
> >                       sym->def[def].val =3D xstrdup(p);
> >                       sym->flags |=3D def_flags;
> >               } else {
> > -                     if (def !=3D S_DEF_AUTO)
> > -                             conf_warning("symbol value '%s' invalid f=
or %s",
> > -                                          p, sym->name);
> > +                     if (def !=3D S_DEF_AUTO) {
> > +                             if (verbose)
> > +                                     conf_warning("symbol value '%s' i=
nvalid for %s\n due to its type is %s",
> > +                                             p, sym->name, type[sym->t=
ype]);
> > +                             else
> > +                                     conf_warning("symbol value '%s' i=
nvalid for %s",
> > +                                             p, sym->name);
> > +                     }
> >                       return 1;
> >               }
> >               break;
> > @@ -545,6 +608,7 @@ int conf_read(const char *name)
> >       int conf_unsaved =3D 0;
> >       int i;
> >
> > +     verbose =3D getenv("KCONFIG_VERBOSE");
> >       conf_set_changed(false);
> >
> >       if (conf_read_simple(name, S_DEF_USER)) {
> > @@ -576,6 +640,32 @@ int conf_read(const char *name)
> >                       continue;
> >               conf_unsaved++;
> >               /* maybe print value in verbose mode... */
> > +             if (verbose) {
> > +                     switch (sym->type) {
> > +                     case S_BOOLEAN:
> > +                     case S_TRISTATE:
> > +                             if (sym->def[S_DEF_USER].tri !=3D sym->cu=
rr.tri) {
> > +                                     if (sym->dir_dep.tri < sym->def[S=
_DEF_USER].tri)
> > +                                             conf_error_log(DIR_DEP, s=
ym,
> > +                                                     "  due to unmet d=
irect dependencies\n",
> > +                                                     NULL);
> > +                                     if (sym->rev_dep.tri > sym->def[S=
_DEF_USER].tri)
> > +                                             conf_error_log(REV_DEP, s=
ym,
> > +                                                     "  due to it is s=
elected\n", NULL);
> > +                             }
> > +                             break;
> > +                     case S_INT:
> > +                     case S_HEX:
> > +                     case S_STRING:
> > +                             if (sym->dir_dep.tri =3D=3D no &&
> > +                                     strcmp((char *)(sym->def[S_DEF_US=
ER].val), "") !=3D 0)
> > +                                     conf_error_log(DIR_DEP, sym,
> > +                                             "  due to unmet direct de=
pendencies\n", NULL);
> > +                             break;
> > +                     default:
> > +                             break;
> > +                     }
> > +             }
> >       }
> >
> >       for_all_symbols(i, sym) {
> > diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
> > index 471a59acecec..242b24650f47 100644
> > --- a/scripts/kconfig/lkc.h
> > +++ b/scripts/kconfig/lkc.h
> > @@ -38,10 +38,17 @@ void zconf_initscan(const char *name);
> >  void zconf_nextfile(const char *name);
> >  int zconf_lineno(void);
> >  const char *zconf_curname(void);
> > +extern const char *verbose;
> > +enum error_type {
> > +     DIR_DEP,
> > +     REV_DEP,
> > +     RANGE
> > +};
> >
> >  /* confdata.c */
> >  const char *conf_get_configname(void);
> >  void set_all_choice_values(struct symbol *csym);
> > +void conf_error_log(enum error_type type, struct symbol *sym, char *lo=
g, ...);
> >
> >  /* confdata.c and expr.c */
> >  static inline void xfwrite(const void *str, size_t len, size_t count, =
FILE *out)
> > diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
> > index 0572330bf8a7..a78f7eb64f40 100644
> > --- a/scripts/kconfig/symbol.c
> > +++ b/scripts/kconfig/symbol.c
> > @@ -600,7 +600,7 @@ bool sym_string_valid(struct symbol *sym, const cha=
r *str)
> >  bool sym_string_within_range(struct symbol *sym, const char *str)
> >  {
> >       struct property *prop;
> > -     long long val;
> > +     long long val, left, right;
> >
> >       switch (sym->type) {
> >       case S_STRING:
> > @@ -612,8 +612,15 @@ bool sym_string_within_range(struct symbol *sym, c=
onst char *str)
> >               if (!prop)
> >                       return true;
> >               val =3D strtoll(str, NULL, 10);
> > -             return val >=3D sym_get_range_val(prop->expr->left.sym, 1=
0) &&
> > -                    val <=3D sym_get_range_val(prop->expr->right.sym, =
10);
> > +             left =3D sym_get_range_val(prop->expr->left.sym, 10);
> > +             right =3D sym_get_range_val(prop->expr->right.sym, 10);
> > +             if (val >=3D left && val <=3D right)
> > +                     return true;
> > +             if (verbose)
> > +                     conf_error_log(RANGE, sym,
> > +                             "  symbol value is %lld, the range is (%l=
ld %lld)\n",
> > +                             val, left, right);
> > +             return false;
> >       case S_HEX:
> >               if (!sym_string_valid(sym, str))
> >                       return false;
> > @@ -621,8 +628,15 @@ bool sym_string_within_range(struct symbol *sym, c=
onst char *str)
> >               if (!prop)
> >                       return true;
> >               val =3D strtoll(str, NULL, 16);
> > -             return val >=3D sym_get_range_val(prop->expr->left.sym, 1=
6) &&
> > -                    val <=3D sym_get_range_val(prop->expr->right.sym, =
16);
> > +             left =3D sym_get_range_val(prop->expr->left.sym, 16);
> > +             right =3D sym_get_range_val(prop->expr->right.sym, 16);
> > +             if (val >=3D left && val <=3D right)
> > +                     return true;
> > +             if (verbose)
> > +                     conf_error_log(RANGE, sym,
> > +                             "  symbol value is 0x%llx, the range is (=
0x%llx 0x%llx)\n",
> > +                             val, left, right);
> > +             return false;
> >       case S_BOOLEAN:
> >       case S_TRISTATE:
> >               switch (str[0]) {
> > --
> > 2.17.1



--=20
Best Regards
Masahiro Yamada
