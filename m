Return-Path: <linux-kernel+bounces-112020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5525C887440
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F020284184
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4012C7FBAC;
	Fri, 22 Mar 2024 20:50:46 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13B656B78;
	Fri, 22 Mar 2024 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711140645; cv=none; b=Y9XcvZ0QP1bEYvl3V7iqzB2VAJEV+kY9xme2TwTpPqbjpbuO5h36w92CwmuZ5pj9juH5Pjt+41Qrv9h4cWWJ5FfIaM9PYljvf23uSVpoH8pMLJ8PXtC4DcP3vjJzwZAzcOaQ58cL1sq7ENuItNxGqm5XFY0zOJTtB+6eb+UaG8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711140645; c=relaxed/simple;
	bh=vGI/kIuL9seE6VFtSSJzXe/rjZ9o1WYYkFhZ9/U8Yr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agJk06fxh1P/8k1xPlVUpgoCfM6g/+BuzxsnAq5aM1XWVMKi3EiOjN8Xfy3kq1zih7FLQ8B64lGEe4gDchQMPErHPeOhV5QLu+sCuKcNSJxenro8iGt2BCjz8XgPgVlTfPNCI8txZhvevt5MhMK55Ep6M/kiYAI/Dmor9xzt2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd72353d9fso1442959b6e.3;
        Fri, 22 Mar 2024 13:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711140643; x=1711745443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9gnaVNFDVZDRSrC0DLgGMFlE7DekOKmyqZJ7sHI2co=;
        b=p5sDcFPlvq7BPElObfFN+Jj/S9T2N0kUHvfu8iDWhQiTYPBln6ORa8sare0iHz6inY
         RZHBkpcuB3VH08bbsfcsW2K3eH0IGEeJUYIj6E8aQ5ZxjalAdW3k0DbIjSr6FmQFSTen
         n+rXo4dN2VTW/rqIRipHNN0CSzvLm9kBHgBXTr3n3W99JrLvFT1b5lmXV8y+EDmKvaty
         htFM+LnwXZCSXmyD7jMv+sX2c1hmED14YOA2vyECkmVjskT6/l4eFrYTEnvLSmeFP90e
         3/K12k+4fU4r6rThEBOtdV+Pa89ggpMO1FwaBm270AZiHjeSTJ1QxsauGXwebAzOLgfF
         LgNA==
X-Forwarded-Encrypted: i=1; AJvYcCWu//ZUC+Hmdc71caU9EEy0w1N4S1/KQJpME9j4iFjZdEL9iL1zCw2G1ajB5M56yv123p7JdFVyY9w5O+rhVFgITB5vEcthr22WpynTqKd1dUfs96Ask9SkIdyzrPyQnhEBNjm6nHg5HLBBehJe27i12hthZC9sOlhjJ6PvKgv+aJHTGQ==
X-Gm-Message-State: AOJu0YycEbyIkDGKwCvF1JSAHAxBk9PcIzjHKtAdK+MzMph2QxXTwjHq
	LJV9QAAm4xH3Z1kZN8//rEdwUeWYyCanxoSLeskBPBRrXkyl4ZaH58v0fDcNVeXNvfnM8GGm0En
	cBFQ5avkrVmI5/r+twAJ6pi6s1Lp63p6D
X-Google-Smtp-Source: AGHT+IFoph8NtOyo10DOY20bEJdCJLR3/QAedtk0J/jlEWnFy1JbKX904DayeRJEnuy0NcidZ6MuhuKO4vu5LlYgEFs=
X-Received: by 2002:a05:6a20:4a23:b0:1a3:6194:aa2b with SMTP id
 fr35-20020a056a204a2300b001a36194aa2bmr604674pzb.23.1711140201879; Fri, 22
 Mar 2024 13:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321160300.1635121-1-irogers@google.com> <20240321160300.1635121-5-irogers@google.com>
In-Reply-To: <20240321160300.1635121-5-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 22 Mar 2024 13:43:10 -0700
Message-ID: <CAM9d7ciUwKrHsk3GencSDCRDEP0oUX6H99-uRmL=zf4gCgtdHQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] perf dsos: Add dsos__for_each_dso
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	=?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Paran Lee <p4ranlee@gmail.com>, 
	Li Dong <lidong@vivo.com>, elfring@users.sourceforge.net, 
	Andi Kleen <ak@linux.intel.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Thu, Mar 21, 2024 at 9:03=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> To better abstract the dsos internals, add dsos__for_each_dso that
> does a callback on each dso. This also means the read lock can be
> correctly held.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-inject.c | 25 +++++++-----
>  tools/perf/util/build-id.c  | 76 ++++++++++++++++++++-----------------
>  tools/perf/util/dsos.c      | 16 ++++++++
>  tools/perf/util/dsos.h      |  8 +---
>  tools/perf/util/machine.c   | 40 +++++++++++--------
>  5 files changed, 100 insertions(+), 65 deletions(-)
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index ef73317e6ae7..ce5e28eaad90 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -1187,23 +1187,28 @@ static int synthesize_build_id(struct perf_inject=
 *inject, struct dso *dso, pid_
>                                                process_build_id, machine)=
;
>  }
>
> +static int guest_session__add_build_ids_cb(struct dso *dso, void *data)
> +{
> +       struct guest_session *gs =3D data;
> +       struct perf_inject *inject =3D container_of(gs, struct perf_injec=
t, guest_session);
> +
> +       if (!dso->has_build_id)
> +               return 0;
> +
> +       return synthesize_build_id(inject, dso, gs->machine_pid);
> +

An unnecessary newline.

> +}
> +
>  static int guest_session__add_build_ids(struct guest_session *gs)
>  {
>         struct perf_inject *inject =3D container_of(gs, struct perf_injec=
t, guest_session);
> -       struct machine *machine =3D &gs->session->machines.host;
> -       struct dso *dso;
> -       int ret;
>
>         /* Build IDs will be put in the Build ID feature section */
>         perf_header__set_feat(&inject->session->header, HEADER_BUILD_ID);
>
> -       dsos__for_each_with_build_id(dso, &machine->dsos.head) {
> -               ret =3D synthesize_build_id(inject, dso, gs->machine_pid)=
;
> -               if (ret)
> -                       return ret;
> -       }
> -
> -       return 0;
> +       return dsos__for_each_dso(&gs->session->machines.host.dsos,
> +                                 guest_session__add_build_ids_cb,
> +                                 gs);
>  }
>
>  static int guest_session__ksymbol_event(struct perf_tool *tool,
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index a617b1917e6b..a6d3c253f19f 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -327,48 +327,56 @@ static int write_buildid(const char *name, size_t n=
ame_len, struct build_id *bid
>         return write_padded(fd, name, name_len + 1, len);
>  }
>
> -static int machine__write_buildid_table(struct machine *machine,
> -                                       struct feat_fd *fd)
> +struct machine__write_buildid_table_cb_args {
> +       struct machine *machine;
> +       struct feat_fd *fd;
> +       u16 kmisc, umisc;
> +};
> +
> +static int machine__write_buildid_table_cb(struct dso *dso, void *data)
>  {
> -       int err =3D 0;
> -       struct dso *pos;
> -       u16 kmisc =3D PERF_RECORD_MISC_KERNEL,
> -           umisc =3D PERF_RECORD_MISC_USER;
> +       struct machine__write_buildid_table_cb_args *args =3D data;
> +       const char *name;
> +       size_t name_len;
> +       bool in_kernel =3D false;
>
> -       if (!machine__is_host(machine)) {
> -               kmisc =3D PERF_RECORD_MISC_GUEST_KERNEL;
> -               umisc =3D PERF_RECORD_MISC_GUEST_USER;
> -       }
> +       if (!dso->has_build_id)
> +               return 0;
>
> -       dsos__for_each_with_build_id(pos, &machine->dsos.head) {
> -               const char *name;
> -               size_t name_len;
> -               bool in_kernel =3D false;
> +       if (!dso->hit && !dso__is_vdso(dso))
> +               return 0;
>
> -               if (!pos->hit && !dso__is_vdso(pos))
> -                       continue;
> +       if (dso__is_vdso(dso)) {
> +               name =3D dso->short_name;
> +               name_len =3D dso->short_name_len;
> +       } else if (dso__is_kcore(dso)) {
> +               name =3D args->machine->mmap_name;
> +               name_len =3D strlen(name);
> +       } else {
> +               name =3D dso->long_name;
> +               name_len =3D dso->long_name_len;
> +       }
>
> -               if (dso__is_vdso(pos)) {
> -                       name =3D pos->short_name;
> -                       name_len =3D pos->short_name_len;
> -               } else if (dso__is_kcore(pos)) {
> -                       name =3D machine->mmap_name;
> -                       name_len =3D strlen(name);
> -               } else {
> -                       name =3D pos->long_name;
> -                       name_len =3D pos->long_name_len;
> -               }
> +       in_kernel =3D dso->kernel || is_kernel_module(name, PERF_RECORD_M=
ISC_CPUMODE_UNKNOWN);
> +       return write_buildid(name, name_len, &dso->bid, args->machine->pi=
d,
> +                            in_kernel ? args->kmisc : args->umisc, args-=
>fd);
> +}
>
> -               in_kernel =3D pos->kernel ||
> -                               is_kernel_module(name,
> -                                       PERF_RECORD_MISC_CPUMODE_UNKNOWN)=
;
> -               err =3D write_buildid(name, name_len, &pos->bid, machine-=
>pid,
> -                                   in_kernel ? kmisc : umisc, fd);
> -               if (err)
> -                       break;
> +static int machine__write_buildid_table(struct machine *machine, struct =
feat_fd *fd)
> +{
> +       struct machine__write_buildid_table_cb_args args =3D {
> +               .machine =3D machine,
> +               .fd =3D fd,
> +               .kmisc =3D PERF_RECORD_MISC_KERNEL,
> +               .umisc =3D PERF_RECORD_MISC_USER,
> +       };
> +
> +       if (!machine__is_host(machine)) {
> +               args.kmisc =3D PERF_RECORD_MISC_GUEST_KERNEL;
> +               args.umisc =3D PERF_RECORD_MISC_GUEST_USER;
>         }
>
> -       return err;
> +       return dsos__for_each_dso(&machine->dsos, machine__write_buildid_=
table_cb, &args);
>  }
>
>  int perf_session__write_buildid_table(struct perf_session *session,
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index d269e09005a7..d43f64939b12 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -433,3 +433,19 @@ struct dso *dsos__find_kernel_dso(struct dsos *dsos)
>         up_read(&dsos->lock);
>         return res;
>  }
> +
> +int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, voi=
d *data), void *data)
> +{
> +       struct dso *dso;
> +
> +       down_read(&dsos->lock);
> +       list_for_each_entry(dso, &dsos->head, node) {
> +               int err;
> +
> +               err =3D cb(dso, data);
> +               if (err)
> +                       return err;

Please break and return the error to release the lock.

Thanks,
Namhyung


> +       }
> +       up_read(&dsos->lock);
> +       return 0;
> +}
> diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
> index a7c7f723c5ff..317a263f0e37 100644
> --- a/tools/perf/util/dsos.h
> +++ b/tools/perf/util/dsos.h
> @@ -23,12 +23,6 @@ struct dsos {
>         struct rw_semaphore lock;
>  };
>
> -#define dsos__for_each_with_build_id(pos, head)        \
> -       list_for_each_entry(pos, head, node)    \
> -               if (!pos->has_build_id)         \
> -                       continue;               \
> -               else
> -
>  void dsos__init(struct dsos *dsos);
>  void dsos__exit(struct dsos *dsos);
>
> @@ -55,4 +49,6 @@ struct dso *dsos__findnew_module_dso(struct dsos *dsos,=
 struct machine *machine,
>
>  struct dso *dsos__find_kernel_dso(struct dsos *dsos);
>
> +int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, voi=
d *data), void *data);
> +
>  #endif /* __PERF_DSOS */
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index a06b030fba54..bd153bc2c8da 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1562,16 +1562,14 @@ int machine__create_kernel_maps(struct machine *m=
achine)
>         return ret;
>  }
>
> -static bool machine__uses_kcore(struct machine *machine)
> +static int machine__uses_kcore_cb(struct dso *dso, void *data __maybe_un=
used)
>  {
> -       struct dso *dso;
> -
> -       list_for_each_entry(dso, &machine->dsos.head, node) {
> -               if (dso__is_kcore(dso))
> -                       return true;
> -       }
> +       return dso__is_kcore(dso) ? 1 : 0;
> +}
>
> -       return false;
> +static bool machine__uses_kcore(struct machine *machine)
> +{
> +       return dsos__for_each_dso(&machine->dsos, machine__uses_kcore_cb,=
 NULL) !=3D 0 ? true : false;
>  }
>
>  static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
> @@ -3137,16 +3135,28 @@ char *machine__resolve_kernel_addr(void *vmachine=
, unsigned long long *addrp, ch
>         return sym->name;
>  }
>
> +struct machine__for_each_dso_cb_args {
> +       struct machine *machine;
> +       machine__dso_t fn;
> +       void *priv;
> +};
> +
> +static int machine__for_each_dso_cb(struct dso *dso, void *data)
> +{
> +       struct machine__for_each_dso_cb_args *args =3D data;
> +
> +       return args->fn(dso, args->machine, args->priv);
> +}
> +
>  int machine__for_each_dso(struct machine *machine, machine__dso_t fn, vo=
id *priv)
>  {
> -       struct dso *pos;
> -       int err =3D 0;
> +       struct machine__for_each_dso_cb_args args =3D {
> +               .machine =3D machine,
> +               .fn =3D fn,
> +               .priv =3D priv,
> +       };
>
> -       list_for_each_entry(pos, &machine->dsos.head, node) {
> -               if (fn(pos, machine, priv))
> -                       err =3D -1;
> -       }
> -       return err;
> +       return dsos__for_each_dso(&machine->dsos, machine__for_each_dso_c=
b, &args);
>  }
>
>  int machine__for_each_kernel_map(struct machine *machine, machine__map_t=
 fn, void *priv)
> --
> 2.44.0.396.g6e790dbe36-goog
>

