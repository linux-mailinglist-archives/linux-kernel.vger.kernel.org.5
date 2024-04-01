Return-Path: <linux-kernel+bounces-127178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9168947C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE111C22078
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE85B56B91;
	Mon,  1 Apr 2024 23:31:33 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC255C3B;
	Mon,  1 Apr 2024 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014292; cv=none; b=CkbR/bTdFq6CFSb8erpyB9ir8Hn7fc+Vgga/n0GrQ3db2f/siGks6Mz6AjpycccnB8zBdTu3+Q5s8xSHGo/VJy/qUTId4AY4ntS6NCki6NnBRllBvCOZsOD4jftDadOFSAf0YCNp3Ok9ZcEdYWxKl5MmdU/01+Mphni4h6e4oUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014292; c=relaxed/simple;
	bh=W9Rd3Vg90HSyochB1c8eX8D31ta8C0k+c1YAiursWOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZ3m7Wn4rMdkX2025OiMZZVYtfY5J32ecUiJZUfwVgASn+TUXtIlGSgSGA5x63t0zhgrM1Zc/lXhsIUftlTq85O/qaZSaTU8IRERWJ/1ZZRr+MIbE7zTG6HA+tZkC8TIOL1AXuKqmL1VZZXWw9GlxGnY/cDXgJjnZlCmN0RiNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so2461033a12.3;
        Mon, 01 Apr 2024 16:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712014290; x=1712619090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyRsGRAwNFsxUGN4nIP6zyyeaRDG9dHknKxTE5z7gR0=;
        b=lp4YobQTI4WYiwRdnssDHWR0WzbryiEeXdulz98m+CSGYy36QCMs5dg0jnVrvTh/HG
         M8UcryqlbO2OIINQYFphF4DdTuueDw9vUrJamtvFX1NnL1+7zueBiZ9rkK8LjgyHKWlH
         2rfplynrE8h+lomsec5z7OgqpxU8O6q6NFphS9riQuiuNvkozSNS5PqJi53cRfPs80XT
         mjkc8IjviavqU4coqgInCsBp1wS9+y/TMGbAc6AsDBIP6Eeytcbe5fClRUrwVH0CLi0c
         UHysC+3C4XPlgh1YG53i06wNw8ypiacr4UhrRtk/i9z7owUaHin2GPnydXzp4ZrhLEd1
         9Lew==
X-Forwarded-Encrypted: i=1; AJvYcCUrIyuD4sn9w0zKFTy/y2lS8bxj5pVYR2QZoTAIsYgHcm6inySS80TZHY9erCCiHwJM8C16N/KMckcuLuxHqMPPeVJiNDB+Jr+quYi1VYNBGKh4cGDV2tUPJhl4uFdg2SeQpsbuEz70DYs6oKEwVg==
X-Gm-Message-State: AOJu0Yxk8lBRQlnbdkEomiWWRB66+1jRiIRNZEB8TVxwwbnCGLmSKP9v
	mYg2QEWfq1zjiBXJ289iucva9BGdUrJMF2HS2I5nnY9m6X0KPMsNVHDuEEgtHzjrIEyhoUno5wy
	IshMP7Zt1/kFUNO/W5YMcGgIPgtY=
X-Google-Smtp-Source: AGHT+IHUcj7bvvOAZ4jdASGxpoQpJwHl+eeiUqNOo7akmbttuzadQVwSi31YMAvfAdXehQ+GUFWlh/h7CiuRkBgK7CM=
X-Received: by 2002:a17:903:11d1:b0:1e0:a8b8:aba3 with SMTP id
 q17-20020a17090311d100b001e0a8b8aba3mr14714827plh.35.1712014289753; Mon, 01
 Apr 2024 16:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401160805.51277-1-yakoyoku@gmail.com> <CAP-5=fXu4uM=cU8Q=1JP19sELfarNE9BtBmbFW0Uyq2e_HJ6QA@mail.gmail.com>
In-Reply-To: <CAP-5=fXu4uM=cU8Q=1JP19sELfarNE9BtBmbFW0Uyq2e_HJ6QA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 1 Apr 2024 16:31:18 -0700
Message-ID: <CAM9d7cjgfQpo6dgV4f5Wm4shVpknzP4_m36AkTwaUaF4jLrV1w@mail.gmail.com>
Subject: Re: [PATCH] perf srcline: Implement addr2line using libdw
To: Ian Rogers <irogers@google.com>
Cc: Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Apr 1, 2024 at 9:56=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Mon, Apr 1, 2024 at 9:08=E2=80=AFAM Martin Rodriguez Reboredo
> <yakoyoku@gmail.com> wrote:
> >
> > `perf script` can be quite slow when inlines are enabled, by default it
> > spawns an `addr2line` process and communicates with it via pipes, that
> > comes with a certain overhead. The other option is to build perf with
> > libbfd enabled so that its methods are called directly instead, but due
> > to its licensing the resulting binary cannot be redistribuited.
> >
> > This commit adds the ability for perf to use libdw to query the source
> > lines of binaries from the passed addresses. This avoids the process
> > spawn overhead and because libdw is licensed dually under
> > GPL-2.0-or-later and LGPL-3.0-or-later it can be distributed by
> > downstream packagers. Another thing to consider is that if libdebuginfo=
d
> > was enabled for libdw then it's used to download debug info, it can be
> > switched off by unsetting the `DEBUGINFOD_URLS` envvar.

Thanks for doing this!  Yep, we could unset the env temporarily.

As a general comment, perf has some helper functions for libdw
in util/dwarf-aux.[ch].  Please take a look and use/update them.

> >
> > Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
>
> Awesome sauce! Namhyung was just mentioning the idea to do this to me.
> I wonder when this lands we can just work to remove all of the
> BUILD_NONDISTRO options, namely libbfd, libiberty, etc. I suspect we
> have dead/broken code hiding there.
>
> > ---
> >  tools/perf/Makefile.config |   7 +-
> >  tools/perf/util/srcline.c  | 277 ++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 281 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 1fe8df97fe88..ab6d41e7a6b6 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -947,13 +947,16 @@ ifdef BUILD_NONDISTRO
> >      $(call feature_check,disassembler-init-styled)
> >    endif
> >
> > -  CFLAGS +=3D -DHAVE_LIBBFD_SUPPORT
> > -  CXXFLAGS +=3D -DHAVE_LIBBFD_SUPPORT
> > +  CFLAGS +=3D -DHAVE_LIBBFD_SUPPORT -DHAVE_SYMBOLIZER_SUPPORT
> > +  CXXFLAGS +=3D -DHAVE_LIBBFD_SUPPORT -DHAVE_SYMBOLIZER_SUPPORT
>
> What does SYMBOLIZER mean in this context? Shouldn't the code be gated
> on say a HAVE_LIBDW?
>
> >    ifeq ($(feature-libbfd-buildid), 1)
> >      CFLAGS +=3D -DHAVE_LIBBFD_BUILDID_SUPPORT
> >    else
> >      $(warning Old version of libbfd/binutils things like PE executable=
 profiling will not be available)
> >    endif
> > +else ifndef NO_LIBDW_DWARF_UNWIND
> > +  CFLAGS +=3D -DHAVE_SYMBOLIZER_SUPPORT
> > +  CXXFLAGS +=3D -DHAVE_SYMBOLIZER_SUPPORT
> >  endif
> >
> >  ifndef NO_DEMANGLE
> > diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> > index 7addc34afcf5..8117424137cc 100644
> > --- a/tools/perf/util/srcline.c
> > +++ b/tools/perf/util/srcline.c
> > @@ -130,6 +130,8 @@ static struct symbol *new_inline_sym(struct dso *ds=
o,
> >
> >  #define MAX_INLINE_NEST 1024
> >
> > +#ifdef HAVE_SYMBOLIZER_SUPPORT
> > +
> >  #ifdef HAVE_LIBBFD_SUPPORT
> >
> >  /*
> > @@ -372,6 +374,279 @@ void dso__free_a2l(struct dso *dso)
> >
> >  #else /* HAVE_LIBBFD_SUPPORT */
> >
> > +#include <elfutils/libdwfl.h>
> > +#include <dwarf.h>
> > +
> > +static char *debuginfo_path =3D NULL;
> > +
> > +static const Dwfl_Callbacks offline_callbacks =3D {
> > +       /* We use this table for core files too.  */
> > +       .find_elf =3D dwfl_build_id_find_elf,
> > +       .find_debuginfo =3D dwfl_standard_find_debuginfo,
> > +       .section_address =3D dwfl_offline_section_address,
> > +       .debuginfo_path =3D &debuginfo_path,
> > +
> > +};
> > +
> > +struct a2l_data {
>
> Perhaps libdw_a2l_data to avoid confusion with data used for forked
> addr2line. Could you comment the variables? Names like "input" are
> fairly generic so you could provide an example of what their values
> are. It is also useful to comment when something like a string is
> owned by the struct, so that cleaning it up can be checked.
>
> > +       const char *input;
> > +       Dwarf_Addr addr;
> > +       Dwarf_Addr bias;
> > +
> > +       bool found;
> > +       const char *filename;
> > +       const char *funcname;
> > +       int line;
>
> Moving "found" and "line" later will avoid padding. As this data is
> attached to a DSO, does there need to be some kind of locking protocol
> for >1 symbolizing the same DSO? Perhaps these should be filled in as
> out arguments to avoid this kind of complexity.

Right, we cannot attach this to a DSO.  Maybe only dwfl can be
attached, but we might want to use debuginfo abstraction instead.

Also I don't think we can keep all debuginfo/dwfl descriptors at
once due to the file descriptor limit.  But I'm not sure if we have
something for the external addr2line.


>
> Also, there is some DSO clean up happening in:
> https://lore.kernel.org/lkml/CAM9d7chqnsDBCVFoK2hSs=3D22QrXBS=3D13Px5hGA4=
hM=3Dho7CZd2g@mail.gmail.com/
> where accessor functions are used for the sake of reference count checkin=
g:
> https://perf.wiki.kernel.org/index.php/Reference_Count_Checking
> which may cause some minor conflicts with this patch.
>
> > +
> > +       Dwfl *dwfl;
> > +       Dwfl_Module *mod;
> > +       GElf_Sym **syms;
> > +};
> > +
> > +static const char *get_diename(Dwarf_Die *die)
> > +{
> > +       Dwarf_Attribute attr;
> > +       const char *name;
> > +
> > +       name =3D dwarf_formstring(
> > +               dwarf_attr_integrate(die, DW_AT_MIPS_linkage_name, &att=
r) ?:
> > +                       dwarf_attr_integrate(die, DW_AT_linkage_name, &=
attr));

We have die_get_linkage_name() but it doesn't seem to
handle MIPS_linkage_name though.


> > +
> > +       if (name =3D=3D NULL)
> > +               name =3D dwarf_diename(die) ?: "??";
> > +
> > +       return name;
> > +}
> > +
> > +static void find_address_in_section(struct a2l_data *a2l)

Probably we can use cu_find_lineinfo().


> > +{
> > +       Dwarf_Addr addr;
> > +       Dwfl_Line *line;
> > +
> > +       if (a2l->found)
> > +               return;
> > +
> > +       a2l->mod =3D dwfl_addrmodule(a2l->dwfl, a2l->addr);
> > +       if (!a2l->mod)
> > +               return;
> > +
> > +       dwfl_module_getdwarf(a2l->mod, &a2l->bias);
> > +       addr =3D a2l->addr + a2l->bias;
> > +
> > +       line =3D dwfl_module_getsrc(a2l->mod, addr);
> > +       if (!line)
> > +               line =3D dwfl_getsrc(a2l->dwfl, addr);
> > +       if (!line)
> > +               return;
> > +
> > +       a2l->filename =3D dwfl_lineinfo(line, NULL, &a2l->line, NULL, N=
ULL, NULL);
> > +       a2l->funcname =3D dwfl_module_addrname(a2l->mod, addr);
> > +
> > +       if (a2l->filename && !strlen(a2l->filename))
> > +               a2l->filename =3D NULL;
> > +       else
> > +               a2l->found =3D true;
> > +}
> > +
> > +static struct a2l_data *addr2line_init(const char *path)

debuginfo__new()?


> > +{
> > +       Dwfl *dwfl;
> > +       struct a2l_data *a2l =3D NULL;
> > +
> > +       dwfl =3D dwfl_begin(&offline_callbacks);
> > +       if (!dwfl)
> > +               goto out;
> > +
> > +       if (dwfl_report_offline(dwfl, "", path, -1) =3D=3D NULL)
> > +               return NULL;
> > +
> > +       a2l =3D zalloc(sizeof(*a2l));
> > +       if (a2l =3D=3D NULL)
> > +               goto out;
> > +
> > +       a2l->dwfl =3D dwfl;
> > +       a2l->input =3D strdup(path);
> > +       if (a2l->input =3D=3D NULL)
> > +               goto out;
> > +
> > +       if (dwfl_report_end(dwfl, NULL, NULL))
> > +               goto out;
> > +
> > +       return a2l;
> > +
> > +out:
> > +       if (a2l) {
> > +               zfree((char **)&a2l->input);
> > +               free(a2l);
> > +       }
> > +       dwfl_end(dwfl);
> > +       return NULL;
> > +}
> > +
> > +static void addr2line_cleanup(struct a2l_data *a2l)
> > +{
> > +       if (a2l->dwfl)
> > +               dwfl_end(a2l->dwfl);
> > +       zfree((char **)&a2l->input);
> > +       zfree(&a2l->syms);
> > +       free(a2l);
> > +}
> > +
> > +static int inline_list__append_dso_a2l(struct dso *dso,
> > +                                      struct inline_node *node,
> > +                                      struct symbol *sym)
> > +{
> > +       struct a2l_data *a2l =3D dso->a2l;
> > +       struct symbol *inline_sym =3D new_inline_sym(dso, sym, a2l->fun=
cname);
> > +       char *srcline =3D NULL;
> > +
> > +       if (a2l->filename)
> > +               srcline =3D srcline_from_fileline(a2l->filename, a2l->l=
ine);
> > +
> > +       return inline_list__append(inline_sym, srcline, node);
> > +}
> > +
> > +static int get_inline_function(struct dso *dso, struct inline_node *no=
de,
> > +                              struct symbol *sym)
> > +{
> > +       struct a2l_data *a2l =3D dso->a2l;
> > +       Dwarf_Addr addr =3D a2l->addr + a2l->bias;
> > +       Dwarf_Addr bias =3D 0;
> > +       Dwarf_Die *cudie =3D dwfl_module_addrdie(a2l->mod, addr, &bias)=
;
> > +
> > +       Dwarf_Die *scopes =3D NULL;
> > +       int nscopes =3D dwarf_getscopes(cudie, addr - bias, &scopes);

It's not clear to me how this dwarf_getscopes() and later
dwarf_getscopes_die() work together.  Can you please add some
comment?  Also we have die_get_scopes() and I think it's simpler.


> > +       if (nscopes < 0)
> > +               return 0;
> > +
> > +       if (nscopes > 0) {
>
> Try to prefer early return to avoid indenting the code. So I think the
> above can just be:
>
> if (nscopes <=3D 0)
>     return 0;
>
> and then you don't need this "if (nscopes > 0) {"
>
> > +               Dwarf_Die subroutine;
> > +               Dwarf_Off dieoff =3D dwarf_dieoffset(&scopes[0]);
> > +               dwarf_offdie(dwfl_module_getdwarf(a2l->mod, &bias), die=
off,
> > +                            &subroutine);
> > +               free(scopes);
> > +               scopes =3D NULL;
>
> Is this dead code?

It seems you can use zfree().


>
> > +
> > +               nscopes =3D dwarf_getscopes_die(&subroutine, &scopes);
> > +               if (nscopes > 1) {
>
> Similar early return comment to above to avoid indentation.
>
> Thanks,
> Ian
>
> > +                       Dwarf_Die cu;
> > +                       Dwarf_Files *files;
> > +                       if (dwarf_diecu(&scopes[0], &cu, NULL, NULL) !=
=3D NULL &&
> > +                           dwarf_getsrcfiles(cudie, &files, NULL) =3D=
=3D 0) {
> > +                               for (int i =3D 0; i < nscopes - 1; i++)=
 {
> > +                                       Dwarf_Word val;
> > +                                       Dwarf_Attribute attr;
> > +                                       Dwarf_Die *die =3D &scopes[i];
> > +                                       if (dwarf_tag(die) !=3D
> > +                                           DW_TAG_inlined_subroutine)
> > +                                               continue;
> > +
> > +                                       for (int j =3D i + 1; j < nscop=
es; j++) {
> > +                                               Dwarf_Die *parent =3D &=
scopes[j];
> > +                                               int tag =3D dwarf_tag(p=
arent);
> > +                                               if (tag =3D=3D DW_TAG_i=
nlined_subroutine ||
> > +                                                   tag =3D=3D DW_TAG_e=
ntry_point ||
> > +                                                   tag =3D=3D DW_TAG_s=
ubprogram) {
> > +                                                       a2l->funcname =
=3D
> > +                                                               get_die=
name(
> > +                                                                      =
 parent);

Why not get the function name from the abstract origin?


> > +                                                       break;
> > +                                               }
> > +                                       }
> > +
> > +                                       a2l->filename =3D NULL;
> > +                                       a2l->line =3D 0;
> > +                                       if (dwarf_formudata(
> > +                                                   dwarf_attr(die,
> > +                                                              DW_AT_ca=
ll_file,
> > +                                                              &attr),
> > +                                                   &val) =3D=3D 0)
> > +                                               a2l->filename =3D dwarf=
_filesrc(
> > +                                                       files, val, NUL=
L, NULL);
> > +
> > +                                       if (dwarf_formudata(
> > +                                                   dwarf_attr(die,
> > +                                                              DW_AT_ca=
ll_line,
> > +                                                              &attr),
> > +                                                   &val) =3D=3D 0)
> > +                                               a2l->line =3D val;

We have die_get_call_file() and die_get_call_lineno().

Thanks,
Namhyung


> > +
> > +                                       if (a2l->filename !=3D NULL)
> > +                                               if (inline_list__append=
_dso_a2l(
> > +                                                       dso, node, sym)=
)
> > +                                                       return 0;
> > +                               }
> > +                       }
> > +               }
> > +       }
> > +       free(scopes);
> > +
> > +       return 1;
> > +}
> > +
> > +static int addr2line(const char *dso_name, u64 addr, char **file,
> > +                    unsigned int *line, struct dso *dso, bool unwind_i=
nlines,
> > +                    struct inline_node *node, struct symbol *sym)
> > +{
> > +       int ret =3D 0;
> > +       struct a2l_data *a2l =3D dso->a2l;
> > +
> > +       if (!a2l) {
> > +               dso->a2l =3D addr2line_init(dso_name);
> > +               a2l =3D dso->a2l;
> > +       }
> > +
> > +       if (a2l =3D=3D NULL) {
> > +               if (!symbol_conf.disable_add2line_warn)
> > +                       pr_warning("addr2line_init failed for %s\n", ds=
o_name);
> > +               return 0;
> > +       }
> > +
> > +       a2l->addr =3D addr;
> > +       a2l->found =3D false;
> > +
> > +       find_address_in_section(a2l);
> > +
> > +       if (!a2l->found)
> > +               return 0;
> > +
> > +       if (unwind_inlines) {
> > +               if (node && inline_list__append_dso_a2l(dso, node, sym)=
)
> > +                       return 0;
> > +
> > +               if (node && !get_inline_function(dso, node, sym))
> > +                       return 0;
> > +
> > +               ret =3D 1;
> > +       }
> > +
> > +       if (file) {
> > +               *file =3D a2l->filename ? strdup(a2l->filename) : NULL;
> > +               ret =3D *file ? 1 : 0;
> > +       }
> > +
> > +       if (line)
> > +               *line =3D (unsigned int)a2l->line;
> > +
> > +       return ret;
> > +}
> > +
> > +void dso__free_a2l(struct dso *dso)
> > +{
> > +       struct a2l_data *a2l =3D dso->a2l;
> > +
> > +       if (!a2l)
> > +               return;
> > +
> > +       addr2line_cleanup(a2l);
> > +
> > +       dso->a2l =3D NULL;
> > +}
> > +
> > +#endif /* HAVE_LIBBFD_SUPPORT */
> > +
> > +#else /* HAVE_SYMBOLIZER_SUPPORT */
> > +
> >  static int filename_split(char *filename, unsigned int *line_nr)
> >  {
> >         char *sep;
> > @@ -788,7 +1063,7 @@ void dso__free_a2l(struct dso *dso)
> >         dso->a2l =3D NULL;
> >  }
> >
> > -#endif /* HAVE_LIBBFD_SUPPORT */
> > +#endif /* HAVE_SYMBOLIZER_SUPPORT */
> >
> >  static struct inline_node *addr2inlines(const char *dso_name, u64 addr=
,
> >                                         struct dso *dso, struct symbol =
*sym)
> > --
> > 2.44.0
> >

