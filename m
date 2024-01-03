Return-Path: <linux-kernel+bounces-15743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D83823138
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD61C2812D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4131BDDB;
	Wed,  3 Jan 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIzFPeDY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A51C2AD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e70b9a840so2529e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704299060; x=1704903860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q39NKErXvaYrVgrG2HYOTokSKDGqjfbqV3d4rkHUy2c=;
        b=XIzFPeDYj+8acmvyE+XFhP/OjvPARQaUzglzPFVhCVGPs+5dxy4GpK4v0gdJP+mQU9
         SNQ/WojBNzKpukEchtG+wlrMiAzZ1Bzw4wvP7fs17frwsz5Avv4nQ03nmrDdjVltlQgP
         wHph4c1SXozCuXLdK5kl1sYv1j6OwUbG4xTU0TQ41dQKhbLoq7HpEWU2zgTIOFmfUfJz
         rk37GEU3z/6j1KAT2fN1ToNBSSRvsiMp+Ql2QXSdJhB/4d26EVlJ1eV1vKZ8aE4578sd
         nZELnZ8fxDhm6Suof5IeemGW9Xpn4kxP4tOn7FKiv+kkxOmTAX1sYqZYBX5zh+7lufGM
         dEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704299060; x=1704903860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q39NKErXvaYrVgrG2HYOTokSKDGqjfbqV3d4rkHUy2c=;
        b=VM/ozhKJSQQWMT3/gJglasjusR6WvgDg61Afv1JRoMLUPBR5hajLRBFBcvFCCgSeP6
         a7BRCTtUADUmtRXxshGUzeI9ro0uJYBAzNPYV4HdvO9nVCHzlmFtOophDRLRSZ3jnwd+
         Hr/zjZo8p88zNEZ6mXZ2xQ4J4Gh7YGmL9VLeIzkMgIYCZdPdd6UdPwn0X1xaw62auosj
         3m1wg/sgW/1GPiyoJ2ot3lhAY1Q0zyG5DdCLaLwAJRIFrWfYErd77857lupZiyXOWbyW
         di3JeQllD13lqPBIzVuWV51RmeZjGWQyrVJRUtQFyc6FTnYL2tcoLQQ17PjA03f7vPNu
         uCJg==
X-Gm-Message-State: AOJu0YwHLdISZIIhWpxHMKrfvay66rrOIly8k3/z9xaOf5UWWkIgiEDb
	pfV7l4DJGbRJwDPOa3YDhsXfOEp4lMtjHVc9ZxKmw6EPnG2g
X-Google-Smtp-Source: AGHT+IGouvJEoMzUZOF084ufcLU31TOoL1u/xZzh+dBzcSBHDcslR0XubH0RLkbyjCJWlbrtuaRqS8fv5C0MjPxcBdI=
X-Received: by 2002:ac2:58fc:0:b0:50e:9f94:1c37 with SMTP id
 v28-20020ac258fc000000b0050e9f941c37mr71440lfo.7.1704299060347; Wed, 03 Jan
 2024 08:24:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207014655.1252484-1-irogers@google.com> <ZZWGp9i-ZovCimfD@kernel.org>
In-Reply-To: <ZZWGp9i-ZovCimfD@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jan 2024 08:24:08 -0800
Message-ID: <CAP-5=fWS5vXFQWJOBNnb1LsMw9qLpe5qGY4eoja4UtgOSm-=sg@mail.gmail.com>
Subject: Re: [PATCH v1] perf env: Avoid recursively taking env->bpf_progs.lock
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Song Liu <song@kernel.org>, Ming Wang <wangming01@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 8:09=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Wed, Dec 06, 2023 at 05:46:55PM -0800, Ian Rogers escreveu:
> > Add variants of perf_env__insert_bpf_prog_info, perf_env__insert_btf
> > and perf_env__find_btf prefixed with __ to indicate the
> > env->bpf_progs.lock is assumed held. Call these variants when the lock
> > is held to avoid recursively taking it and potentially having a thread
> > deadlock with itself.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > Previously this patch was part of a larger set:
> > https://lore.kernel.org/lkml/20231127220902.1315692-51-irogers@google.c=
om/
> > ---
> >  tools/perf/util/bpf-event.c |  8 +++---
> >  tools/perf/util/bpf-event.h | 12 ++++-----
> >  tools/perf/util/env.c       | 53 +++++++++++++++++++++++--------------
> >  tools/perf/util/env.h       |  4 +++
> >  tools/perf/util/header.c    |  8 +++---
> >  5 files changed, 51 insertions(+), 34 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > index 830711cae30d..3573e0b7ef3e 100644
> > --- a/tools/perf/util/bpf-event.c
> > +++ b/tools/perf/util/bpf-event.c
> > @@ -545,9 +545,9 @@ int evlist__add_bpf_sb_event(struct evlist *evlist,=
 struct perf_env *env)
> >       return evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env)=
;
> >  }
> >
> > -void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> > -                                 struct perf_env *env,
> > -                                 FILE *fp)
> > +void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> > +                                   struct perf_env *env,
> > +                                   FILE *fp)
> >  {
> >       __u32 *prog_lens =3D (__u32 *)(uintptr_t)(info->jited_func_lens);
> >       __u64 *prog_addrs =3D (__u64 *)(uintptr_t)(info->jited_ksyms);
> > @@ -563,7 +563,7 @@ void bpf_event__print_bpf_prog_info(struct bpf_prog=
_info *info,
> >       if (info->btf_id) {
> >               struct btf_node *node;
> >
> > -             node =3D perf_env__find_btf(env, info->btf_id);
> > +             node =3D __perf_env__find_btf(env, info->btf_id);
> >               if (node)
> >                       btf =3D btf__new((__u8 *)(node->data),
> >                                      node->data_size);
> > diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
> > index 1bcbd4fb6c66..e2f0420905f5 100644
> > --- a/tools/perf/util/bpf-event.h
> > +++ b/tools/perf/util/bpf-event.h
> > @@ -33,9 +33,9 @@ struct btf_node {
> >  int machine__process_bpf(struct machine *machine, union perf_event *ev=
ent,
> >                        struct perf_sample *sample);
> >  int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *e=
nv);
> > -void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> > -                                 struct perf_env *env,
> > -                                 FILE *fp);
> > +void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> > +                                   struct perf_env *env,
> > +                                   FILE *fp);
> >  #else
> >  static inline int machine__process_bpf(struct machine *machine __maybe=
_unused,
> >                                      union perf_event *event __maybe_un=
used,
> > @@ -50,9 +50,9 @@ static inline int evlist__add_bpf_sb_event(struct evl=
ist *evlist __maybe_unused,
> >       return 0;
> >  }
> >
> > -static inline void bpf_event__print_bpf_prog_info(struct bpf_prog_info=
 *info __maybe_unused,
> > -                                               struct perf_env *env __=
maybe_unused,
> > -                                               FILE *fp __maybe_unused=
)
> > +static inline void __bpf_event__print_bpf_prog_info(struct bpf_prog_in=
fo *info __maybe_unused,
> > +                                                 struct perf_env *env =
__maybe_unused,
> > +                                                 FILE *fp __maybe_unus=
ed)
> >  {
> >
> >  }
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index c68b7a004f29..cfdacbf29456 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -22,15 +22,20 @@ struct perf_env perf_env;
> >  #include "bpf-utils.h"
> >  #include <bpf/libbpf.h>
> >
> > -void perf_env__insert_bpf_prog_info(struct perf_env *env,
> > -                                 struct bpf_prog_info_node *info_node)
> > +void perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_p=
rog_info_node *info_node)
> > +{
> > +     down_write(&env->bpf_progs.lock);
> > +     __perf_env__insert_bpf_prog_info(env, info_node);
> > +     up_write(&env->bpf_progs.lock);
> > +}
>
> Minor nit/modification:
>
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index cfdacbf294566c33..a459374d0a1a1dc8 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -22,7 +22,8 @@ struct perf_env perf_env;
>  #include "bpf-utils.h"
>  #include <bpf/libbpf.h>
>
> -void perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_pro=
g_info_node *info_node)
> +void perf_env__insert_bpf_prog_info(struct perf_env *env,
> +                                   struct bpf_prog_info_node *info_node)
>  {
>         down_write(&env->bpf_progs.lock);
>         __perf_env__insert_bpf_prog_info(env, info_node);
>
> Just to reduce patch size a bit, just like happened with
> perf_env__insert_btf() further down, where its body was changed  to call
> the __ variant but the non __ function got just the body modified.
>
> - Arnaldo

Sorry for that and thanks for the fix.

Ian

> > +void __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf=
_prog_info_node *info_node)
> >  {
> >       __u32 prog_id =3D info_node->info_linear->info.id;
> >       struct bpf_prog_info_node *node;
> >       struct rb_node *parent =3D NULL;
> >       struct rb_node **p;
> >
> > -     down_write(&env->bpf_progs.lock);
> >       p =3D &env->bpf_progs.infos.rb_node;
> >
> >       while (*p !=3D NULL) {
> > @@ -42,15 +47,13 @@ void perf_env__insert_bpf_prog_info(struct perf_env=
 *env,
> >                       p =3D &(*p)->rb_right;
> >               } else {
> >                       pr_debug("duplicated bpf prog info %u\n", prog_id=
);
> > -                     goto out;
> > +                     return;
> >               }
> >       }
> >
> >       rb_link_node(&info_node->rb_node, parent, p);
> >       rb_insert_color(&info_node->rb_node, &env->bpf_progs.infos);
> >       env->bpf_progs.infos_cnt++;
> > -out:
> > -     up_write(&env->bpf_progs.lock);
> >  }
> >
> >  struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_en=
v *env,
> > @@ -79,14 +82,22 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_=
info(struct perf_env *env,
> >  }
> >
> >  bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_n=
ode)
> > +{
> > +     bool ret;
> > +
> > +     down_write(&env->bpf_progs.lock);
> > +     ret =3D __perf_env__insert_btf(env, btf_node);
> > +     up_write(&env->bpf_progs.lock);
> > +     return ret;
> > +}
> > +
> > +bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf=
_node)
> >  {
> >       struct rb_node *parent =3D NULL;
> >       __u32 btf_id =3D btf_node->id;
> >       struct btf_node *node;
> >       struct rb_node **p;
> > -     bool ret =3D true;
> >
> > -     down_write(&env->bpf_progs.lock);
> >       p =3D &env->bpf_progs.btfs.rb_node;
> >
> >       while (*p !=3D NULL) {
> > @@ -98,25 +109,31 @@ bool perf_env__insert_btf(struct perf_env *env, st=
ruct btf_node *btf_node)
> >                       p =3D &(*p)->rb_right;
> >               } else {
> >                       pr_debug("duplicated btf %u\n", btf_id);
> > -                     ret =3D false;
> > -                     goto out;
> > +                     return false;
> >               }
> >       }
> >
> >       rb_link_node(&btf_node->rb_node, parent, p);
> >       rb_insert_color(&btf_node->rb_node, &env->bpf_progs.btfs);
> >       env->bpf_progs.btfs_cnt++;
> > -out:
> > -     up_write(&env->bpf_progs.lock);
> > -     return ret;
> > +     return true;
> >  }
> >
> >  struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id=
)
> > +{
> > +     struct btf_node *res;
> > +
> > +     down_read(&env->bpf_progs.lock);
> > +     res =3D __perf_env__find_btf(env, btf_id);
> > +     up_read(&env->bpf_progs.lock);
> > +     return res;
> > +}
> > +
> > +struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_=
id)
> >  {
> >       struct btf_node *node =3D NULL;
> >       struct rb_node *n;
> >
> > -     down_read(&env->bpf_progs.lock);
> >       n =3D env->bpf_progs.btfs.rb_node;
> >
> >       while (n) {
> > @@ -126,13 +143,9 @@ struct btf_node *perf_env__find_btf(struct perf_en=
v *env, __u32 btf_id)
> >               else if (btf_id > node->id)
> >                       n =3D n->rb_right;
> >               else
> > -                     goto out;
> > +                     return node;
> >       }
> > -     node =3D NULL;
> > -
> > -out:
> > -     up_read(&env->bpf_progs.lock);
> > -     return node;
> > +     return NULL;
> >  }
> >
> >  /* purge data in bpf_progs.infos tree */
> > diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> > index bf7e3c4c211f..7c527e65c186 100644
> > --- a/tools/perf/util/env.h
> > +++ b/tools/perf/util/env.h
> > @@ -175,12 +175,16 @@ const char *perf_env__raw_arch(struct perf_env *e=
nv);
> >  int perf_env__nr_cpus_avail(struct perf_env *env);
> >
> >  void perf_env__init(struct perf_env *env);
> > +void __perf_env__insert_bpf_prog_info(struct perf_env *env,
> > +                                   struct bpf_prog_info_node *info_nod=
e);
> >  void perf_env__insert_bpf_prog_info(struct perf_env *env,
> >                                   struct bpf_prog_info_node *info_node)=
;
> >  struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_en=
v *env,
> >                                                       __u32 prog_id);
> >  bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_n=
ode);
> > +bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf=
_node);
> >  struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id=
);
> > +struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_=
id);
> >
> >  int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
> >  char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_nam=
e,
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 08cc2febabde..02bf9d8b5f74 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -1849,8 +1849,8 @@ static void print_bpf_prog_info(struct feat_fd *f=
f, FILE *fp)
> >               node =3D rb_entry(next, struct bpf_prog_info_node, rb_nod=
e);
> >               next =3D rb_next(&node->rb_node);
> >
> > -             bpf_event__print_bpf_prog_info(&node->info_linear->info,
> > -                                            env, fp);
> > +             __bpf_event__print_bpf_prog_info(&node->info_linear->info=
,
> > +                                              env, fp);
> >       }
> >
> >       up_read(&env->bpf_progs.lock);
> > @@ -3188,7 +3188,7 @@ static int process_bpf_prog_info(struct feat_fd *=
ff, void *data __maybe_unused)
> >               /* after reading from file, translate offset to address *=
/
> >               bpil_offs_to_addr(info_linear);
> >               info_node->info_linear =3D info_linear;
> > -             perf_env__insert_bpf_prog_info(env, info_node);
> > +             __perf_env__insert_bpf_prog_info(env, info_node);
> >       }
> >
> >       up_write(&env->bpf_progs.lock);
> > @@ -3235,7 +3235,7 @@ static int process_bpf_btf(struct feat_fd *ff, vo=
id *data __maybe_unused)
> >               if (__do_read(ff, node->data, data_size))
> >                       goto out;
> >
> > -             perf_env__insert_btf(env, node);
> > +             __perf_env__insert_btf(env, node);
> >               node =3D NULL;
> >       }
> >
> > --
> > 2.43.0.rc2.451.g8631bc7472-goog
> >
>
> --
>
> - Arnaldo

