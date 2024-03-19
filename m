Return-Path: <linux-kernel+bounces-107976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63AA880457
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAC428562E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2302C1A3;
	Tue, 19 Mar 2024 18:05:18 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9792B9CC;
	Tue, 19 Mar 2024 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871517; cv=none; b=lyOX0CXd34vEBYnfRpZ35bvJUculfvk9zVV5jBfe8rww0d7hT4VcX9RszgIqw1TdeWsYbJ94xa3LsloeOAlmm8b14G2enanX3DGVUBhktroViA6i3lDJP2LhAGU23R2LFiSNVVVlfgBa2RMupfOXa+y/AX9K9+tkl9TobbQKiL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871517; c=relaxed/simple;
	bh=DJNy2TohmbTVOJdHdPDSq/sRpyMSsgcjQh38nVA0HxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjeyMv5Om9bpSkT2J71Fb2ezhcAri9JSyVnh4NJTJ97wVqfz2fJ+L4vWm2OJyHLUpva4WEbMLicOoINtHtWAGWAUGFXmtZdaxCed4kSzvhapelbvq3V26N+2TJWIErUe61z+6fhZulNrwyuZMVHC3/AxlDqBWJplGaB/joA3GJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0411c0a52so10792655ad.0;
        Tue, 19 Mar 2024 11:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871515; x=1711476315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLmPTyrnYvg0mqlvufhGAL1B5AMMFytUWBWUfteYyH8=;
        b=nTadr1DvNlTGhhFn4u9F1n3O5X4mdBSzIFVpdpUE1DUZODqFsoRovSfULR1S0Ka/zk
         gFaQxnOSjz8UNiLC8enoWtakDJ6YVl3bBzRZ/B7fs5CrZ+CdelMK/QNTp9zhYLW59n9c
         Rb24Hjp6cJ41gMozgZJkxKI5XLE5C+c7fxWAWetry0yx0F1+HBFHwczaMvGdaRLfrmuD
         scVi5rpXGn1+N/do5N3ceLTRY4x7igDSDSW0M3KYv2APTMTlH9LwVgJZpAbHYwN8sM5G
         8r7Hp51g7XujQi2E3zF4GB6OUeRqixIIz6gc/uWBG9oecYuQaRCswRra38gjCwngyGOn
         nvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd+6mKSc5A3M87GriRvRuxqOA5MW/lIcn1VdRXq3iB5a950Y1oCrlKnGElgJILoEcyrTqbe4YScyaNpgzYcU9xsE6BbnReonISUCB7YBrXRV+LL1DFtf7tTb3qauIrkNbE8OvIk8PiPAnd0FJMUQKmvrZ5sS5PQNUZIhJuhgHm/OpQiG6ptqNHIDoTBsZBZ03Cp9Ov5J41+1Tw+JZ6eOV2fgTjF6EBW9oztWa9niuuMS72yg==
X-Gm-Message-State: AOJu0Yy6kRlvb56Rs072Qi4fWREZfL2GnegMKlou+xodZshgTJcmsFQ/
	jLZuhmU8Sj+eyAMyGgfx7pZWywY19DSrkOGag28dfrIRGAqLso+xTnK48GBj8zFZv0jKOzSifjI
	dnbNBuqJN2rnANyqr8ExA8hjHPz0KWVYb
X-Google-Smtp-Source: AGHT+IF/dh/ZOhds+v50NacrVPuH5krtLnXzNAPSyQOUgr48a7+CjYqKrwf+HsDuQ8xywz6PVvKyK6NrGoGs1TpN2JI=
X-Received: by 2002:a17:902:f547:b0:1dd:8b94:c4c7 with SMTP id
 h7-20020a170902f54700b001dd8b94c4c7mr4246279plf.16.1710871515002; Tue, 19 Mar
 2024 11:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319055115.4063940-1-namhyung@kernel.org> <20240319055115.4063940-23-namhyung@kernel.org>
In-Reply-To: <20240319055115.4063940-23-namhyung@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 19 Mar 2024 11:05:04 -0700
Message-ID: <CAM9d7cjhuxB_iWPPWgFxK1_oBaYqF=MgthV=EBG0HeyJ9-ONXg@mail.gmail.com>
Subject: Re: [PATCH 22/23] perf annotate-data: Add a cache for global variable types
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 10:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> They are often searched by many different places.  Let's add a cache
> for them to reduce the duplicate DWARF access.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate-data.c | 107 +++++++++++++++++++++++++++++++-
>  tools/perf/util/annotate-data.h |   7 +++
>  tools/perf/util/dso.c           |   2 +
>  tools/perf/util/dso.h           |   6 +-
>  4 files changed, 118 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 633fe125fcd8..4b3184b7c799 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -433,6 +433,91 @@ static struct type_state_stack *findnew_stack_state(=
struct type_state *state,
>         return stack;
>  }
>
> +/* Maintain a cache for quick global variable lookup */
> +struct global_var_entry {
> +       struct rb_node node;
> +       char *name;
> +       u64 start;
> +       u64 end;
> +       u64 die_offset;
> +};
> +
> +static int global_var_cmp(const void *_key, const struct rb_node *node)
> +{
> +       const u64 addr =3D (uintptr_t)_key;
> +       struct global_var_entry *gvar;
> +
> +       gvar =3D rb_entry(node, struct global_var_entry, node);
> +
> +       if (gvar->start <=3D addr && addr < gvar->end)
> +               return 0;
> +       return gvar->start > addr ? -1 : 1;
> +}
> +
> +static bool global_var_less(struct rb_node *node_a, const struct rb_node=
 *node_b)
> +{
> +       struct global_var_entry *gvar_a, *gvar_b;
> +
> +       gvar_a =3D rb_entry(node_a, struct global_var_entry, node);
> +       gvar_b =3D rb_entry(node_b, struct global_var_entry, node);
> +
> +       return gvar_a->start < gvar_b->start;
> +}
> +
> +static struct global_var_entry *global_var__find(struct data_loc_info *d=
loc, u64 addr)
> +{
> +       struct dso *dso =3D map__dso(dloc->ms->map);
> +       struct rb_node *node;
> +
> +       node =3D rb_find((void *)addr, &dso->global_vars, global_var_cmp)=
;

It seems to cause a build error on 32-bit systems.  It needs one
more cast to suppress the "pointer cast w/ different size" warning.

    node =3D rb_find(void *)(uintptr_tr)addr, ...);

Thanks,
Namhyung



> +       if (node =3D=3D NULL)
> +               return NULL;
> +
> +       return rb_entry(node, struct global_var_entry, node);
> +}
> +
> +static bool global_var__add(struct data_loc_info *dloc, u64 addr,
> +                           const char *name, Dwarf_Die *type_die)
> +{
> +       struct dso *dso =3D map__dso(dloc->ms->map);
> +       struct global_var_entry *gvar;
> +       Dwarf_Word size;
> +
> +       if (dwarf_aggregate_size(type_die, &size) < 0)
> +               return false;
> +
> +       gvar =3D malloc(sizeof(*gvar));
> +       if (gvar =3D=3D NULL)
> +               return false;
> +
> +       gvar->name =3D strdup(name);
> +       if (gvar->name =3D=3D NULL) {
> +               free(gvar);
> +               return false;
> +       }
> +
> +       gvar->start =3D addr;
> +       gvar->end =3D addr + size;
> +       gvar->die_offset =3D dwarf_dieoffset(type_die);
> +
> +       rb_add(&gvar->node, &dso->global_vars, global_var_less);
> +       return true;
> +}
> +
> +void global_var_type__tree_delete(struct rb_root *root)
> +{
> +       struct global_var_entry *gvar;
> +
> +       while (!RB_EMPTY_ROOT(root)) {
> +               struct rb_node *node =3D rb_first(root);
> +
> +               rb_erase(node, root);
> +               gvar =3D rb_entry(node, struct global_var_entry, node);
> +               free(gvar->name);
> +               free(gvar);
> +       }
> +}
> +
>  static bool get_global_var_info(struct data_loc_info *dloc, u64 addr,
>                                 const char **var_name, int *var_offset)
>  {
> @@ -467,14 +552,25 @@ static bool get_global_var_type(Dwarf_Die *cu_die, =
struct data_loc_info *dloc,
>         u64 pc;
>         int offset;
>         bool is_pointer =3D false;
> -       const char *var_name;
> +       const char *var_name =3D NULL;
> +       struct global_var_entry *gvar;
>         Dwarf_Die var_die;
>
> +       gvar =3D global_var__find(dloc, var_addr);
> +       if (gvar) {
> +               if (!dwarf_offdie(dloc->di->dbg, gvar->die_offset, type_d=
ie))
> +                       return false;
> +
> +               *var_offset =3D var_addr - gvar->start;
> +               return true;
> +       }
> +
>         /* Try to get the variable by address first */
>         if (die_find_variable_by_addr(cu_die, var_addr, &var_die, &offset=
) &&
>             check_variable(&var_die, type_die, offset, is_pointer) =3D=3D=
 0) {
> +               var_name =3D dwarf_diename(&var_die);
>                 *var_offset =3D offset;
> -               return true;
> +               goto ok;
>         }
>
>         if (!get_global_var_info(dloc, var_addr, &var_name, var_offset))
> @@ -485,9 +581,14 @@ static bool get_global_var_type(Dwarf_Die *cu_die, s=
truct data_loc_info *dloc,
>         /* Try to get the name of global variable */
>         if (die_find_variable_at(cu_die, var_name, pc, &var_die) &&
>             check_variable(&var_die, type_die, *var_offset, is_pointer) =
=3D=3D 0)
> -               return true;
> +               goto ok;
>
>         return false;
> +
> +ok:
> +       /* The address should point to the start of the variable */
> +       global_var__add(dloc, var_addr - *var_offset, var_name, type_die)=
;
> +       return true;
>  }
>
>  /**
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-d=
ata.h
> index 1b5a152163b5..fe1e53d6e8c7 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -153,6 +153,9 @@ int annotated_data_type__update_samples(struct annota=
ted_data_type *adt,
>  /* Release all data type information in the tree */
>  void annotated_data_type__tree_delete(struct rb_root *root);
>
> +/* Release all global variable information in the tree */
> +void global_var_type__tree_delete(struct rb_root *root);
> +
>  #else /* HAVE_DWARF_SUPPORT */
>
>  static inline struct annotated_data_type *
> @@ -175,6 +178,10 @@ static inline void annotated_data_type__tree_delete(=
struct rb_root *root __maybe
>  {
>  }
>
> +static inline void global_var_type__tree_delete(struct rb_root *root __m=
aybe_unused)
> +{
> +}
> +
>  #endif /* HAVE_DWARF_SUPPORT */
>
>  #endif /* _PERF_ANNOTATE_DATA_H */
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 22fd5fa806ed..6e2a7198b382 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1329,6 +1329,7 @@ struct dso *dso__new_id(const char *name, struct ds=
o_id *id)
>                 dso->inlined_nodes =3D RB_ROOT_CACHED;
>                 dso->srclines =3D RB_ROOT_CACHED;
>                 dso->data_types =3D RB_ROOT;
> +               dso->global_vars =3D RB_ROOT;
>                 dso->data.fd =3D -1;
>                 dso->data.status =3D DSO_DATA_STATUS_UNKNOWN;
>                 dso->symtab_type =3D DSO_BINARY_TYPE__NOT_FOUND;
> @@ -1373,6 +1374,7 @@ void dso__delete(struct dso *dso)
>         dso->symbol_names_len =3D 0;
>         zfree(&dso->symbol_names);
>         annotated_data_type__tree_delete(&dso->data_types);
> +       global_var_type__tree_delete(&dso->global_vars);
>
>         if (dso->short_name_allocated) {
>                 zfree((char **)&dso->short_name);
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index ce9f3849a773..2cdcd1e2ef8b 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -154,7 +154,8 @@ struct dso {
>         size_t           symbol_names_len;
>         struct rb_root_cached inlined_nodes;
>         struct rb_root_cached srclines;
> -       struct rb_root  data_types;
> +       struct rb_root   data_types;
> +       struct rb_root   global_vars;
>
>         struct {
>                 u64             addr;
> @@ -411,4 +412,7 @@ int dso__strerror_load(struct dso *dso, char *buf, si=
ze_t buflen);
>
>  void reset_fd_limit(void);
>
> +u64 dso__find_global_type(struct dso *dso, u64 addr);
> +u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
> +
>  #endif /* __PERF_DSO */
> --
> 2.44.0.291.gc1ea87d7ee-goog
>
>

