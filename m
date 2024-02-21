Return-Path: <linux-kernel+bounces-73915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1503B85CD92
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817AB1F2458C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD86C4C8A;
	Wed, 21 Feb 2024 01:53:19 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759D23C5;
	Wed, 21 Feb 2024 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480399; cv=none; b=ca9LHSV6pzNlQpRcgDGwmt5MddPbGLUqJUYr/HUO0aRQvrkH7+h9wd9urWRSA7YacA0qo6mdfpsAVRBdt43iaQwegdpQV+NN0JxzADNiW6rsd627wf3ST8PeaasKaxdqtjW/VboQRQ79bAUTT2IeBv2js5H3wCLk64y/bpPLxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480399; c=relaxed/simple;
	bh=txkMZ/Gg8fpSCMJTWXUn8JbtYWC6xphivOjGiTiGjsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWjYmWmb06RTEo5DvBdGwaLs5AgVTcBki5V28G4qp0T5VMs3gKEg1ybh+P6QyhgRYksMDzvSfEWRC0gZWSG4FqJR25COyOZy4aGLrMRFGsgxblFE8suRKGvRxz83uZ1IqlOnNydt2Y5fFi7Cnn/sgOaaIYIUW/ercp54wY7LXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-299c11b250fso1573103a91.2;
        Tue, 20 Feb 2024 17:53:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708480395; x=1709085195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBly6Q2PEojVSg3uLNQmMXendkI9nh//XLo8bYv5jdA=;
        b=simQ3dK+nY/208EPPRr7RztAp289DTLBF/4r6tEgNUK65IeOJoUFE7ziqrO94yTFR6
         BIgQw846y+wzqFR16YV6RWhDnkxoadJnETxj81gRcI9winH+3LsiWMI1G9+YYHqJnADI
         /HHqciZCjDI3zt+W9Gxnt+Xx5tgD5yh7v4GNloBPxycTCx9cP2qMsYGQQiAyu3yOx2vi
         n1JUa95DsGmNSYNVPRpH+Udo7iM3eil5opiIPqgA2XuIrifsi/VBEU97DqVNs6e1Z7/1
         gNQVC3jIIzY1EygJff7l+xx+98if8efImm/nyw4ANafZTsUoZYH3fzBJ551SO0pEn4Bz
         4VaA==
X-Forwarded-Encrypted: i=1; AJvYcCXYdNA12kaDC2WDZ2RfeApnJSobnZAG6Y2v4k/fUn6y6T5htvCYjKEvT54h/AesYxbfLHbPrQXGzY3u23Jw3hYbXt6jNb3hwVBnfP16okHnrCPDlIQQlvEX1vw5VmzWvkPzAU3l95lbvLsqQB1tpw==
X-Gm-Message-State: AOJu0YxGxgF5kyBSJ3IlX86aGIFDNLAWIEzk13WF4Uv0k41PM8b/mmNE
	daA9ZDHP9FjCXuYij894pqkJJq++xda3bsxFnUEf+vO/0nOyX5SjwbZ3VF1uYp694ZWJMcRQ9KC
	j7XjbnL1PsNqFurvWAeP1vsXS5AM=
X-Google-Smtp-Source: AGHT+IGyfZl8zQrLCDq95vXqsW3gTFcoH6OrHCZMebf7zF6Qz5F5m+BE5cvJk2Dn+v+46Is9jDoSaI4hLFX36Rx0Gdc=
X-Received: by 2002:a17:90b:4a0c:b0:299:3334:51d1 with SMTP id
 kk12-20020a17090b4a0c00b00299333451d1mr11485895pjb.10.1708480395448; Tue, 20
 Feb 2024 17:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216235203.229256-1-irogers@google.com> <20240216235203.229256-3-irogers@google.com>
In-Reply-To: <20240216235203.229256-3-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 20 Feb 2024 17:53:03 -0800
Message-ID: <CAM9d7cgqpvXLgq35B5MoysFzLeUBg7bJzX+pTK_ER=-hM0D=AQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] perf list: Add scandirat compatibility function
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Fri, Feb 16, 2024 at 3:55=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> scandirat is used during the printing of tracepoint events but may be
> missing from certain libcs. Add a compatibility implementation that
> uses the symlink of an fd in /proc as a path for the reliably present
> scandir.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

This fails to build in alpine:

  util/print-events.c: In function 'print_tracepoint_events':
  util/print-events.c:92:29: error: implicit declaration of function
'scandirat'; did you mean 'scandir'?
[-Werror=3Dimplicit-function-declaration]
  92 |                 evt_items =3D scandirat(events_fd,
sys_dirent->d_name, &evt_namelist, NULL, alphasort);
  |                             ^~~~~~~~~
  |                             scandir

Thanks,
Namhyung


> ---
>  tools/perf/util/print-events.c | 12 +++---------
>  tools/perf/util/util.c         | 19 +++++++++++++++++++
>  tools/perf/util/util.h         |  8 ++++++++
>  3 files changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-event=
s.c
> index 9e47712507cc..bf79dd366e2e 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -63,6 +63,8 @@ void print_tracepoint_events(const struct print_callbac=
ks *print_cb __maybe_unus
>  {
>         char *events_path =3D get_tracing_file("events");
>         int events_fd =3D open(events_path, O_PATH);
> +       struct dirent **sys_namelist =3D NULL;
> +       int sys_items;
>
>         put_tracing_file(events_path);
>         if (events_fd < 0) {
> @@ -70,10 +72,7 @@ void print_tracepoint_events(const struct print_callba=
cks *print_cb __maybe_unus
>                 return;
>         }
>
> -#ifdef HAVE_SCANDIRAT_SUPPORT
> -{
> -       struct dirent **sys_namelist =3D NULL;
> -       int sys_items =3D tracing_events__scandir_alphasort(&sys_namelist=
);
> +       sys_items =3D tracing_events__scandir_alphasort(&sys_namelist);
>
>         for (int i =3D 0; i < sys_items; i++) {
>                 struct dirent *sys_dirent =3D sys_namelist[i];
> @@ -130,11 +129,6 @@ void print_tracepoint_events(const struct print_call=
backs *print_cb __maybe_unus
>         }
>
>         free(sys_namelist);
> -}
> -#else
> -       printf("\nWARNING: Your libc doesn't have the scandirat function,=
 please ask its maintainers to implement it.\n"
> -              "         As a rough fallback, please do 'ls %s' to see th=
e available tracepoint events.\n", events_path);
> -#endif
>         close(events_fd);
>  }
>
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index c1fd9ba6d697..4f561e5e4162 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -552,3 +552,22 @@ int sched_getcpu(void)
>         return -1;
>  }
>  #endif
> +
> +#ifndef HAVE_SCANDIRAT_SUPPORT
> +int scandirat(int dirfd, const char *dirp,
> +             struct dirent ***namelist,
> +             int (*filter)(const struct dirent *),
> +             int (*compar)(const struct dirent **, const struct dirent *=
*))
> +{
> +       char path[PATH_MAX];
> +       int err, fd =3D openat(dirfd, dirp, O_PATH);
> +
> +       if (fd < 0)
> +               return fd;
> +
> +       snprintf(path, sizeof(path), "/proc/%d/fd/%d", getpid(), fd);
> +       err =3D scandir(path, namelist, filter, compar);
> +       close(fd);
> +       return err;
> +}
> +#endif
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 7c8915d92dca..9966c21aaf04 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -6,6 +6,7 @@
>  /* glibc 2.20 deprecates _BSD_SOURCE in favour of _DEFAULT_SOURCE */
>  #define _DEFAULT_SOURCE 1
>
> +#include <dirent.h>
>  #include <fcntl.h>
>  #include <stdbool.h>
>  #include <stddef.h>
> @@ -56,6 +57,13 @@ int perf_tip(char **strp, const char *dirpath);
>  int sched_getcpu(void);
>  #endif
>
> +#ifndef HAVE_SCANDIRAT_SUPPORT
> +int scandirat(int dirfd, const char *dirp,
> +             struct dirent ***namelist,
> +             int (*filter)(const struct dirent *),
> +             int (*compar)(const struct dirent **, const struct dirent *=
*));
> +#endif
> +
>  extern bool perf_singlethreaded;
>
>  void perf_set_singlethreaded(void);
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

