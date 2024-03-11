Return-Path: <linux-kernel+bounces-99547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9908789D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C607A280E65
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DEA56772;
	Mon, 11 Mar 2024 21:08:16 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9754744;
	Mon, 11 Mar 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191296; cv=none; b=l5F/SYiYAQEEgdIQQzrbXw5GMH/DEYbTd4mLwLpjzP+Rd8QG017mDJ5L4DknAkNSEWbcMfS7hoWiv5M1K2R5rCHwVFiz+ADJiJAjvCcaiFKWSdbUPmh049cmj/WLWhJcQ2Oq+t0MzHazgbDcWwMnJFRgEGXAJXJd3Bo+TjWTHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191296; c=relaxed/simple;
	bh=WuLL2kNfykIrPC02UoqXP1sqC6o5ywnMEccY3IEjVIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWo3Q1Io7NmfcRy1ybenKgtOne+yBqR7twr2npPUd2+nhJd2ZPHpyxBt0gD4bhNbtW1cC4orTuaduYw1qt5+SIXNJfV2g3gU6P/4dOt4l/QSG8Xr8GkibVvJyrcKICCu3bDanRVoY1qInskZwWuyrSNscoSQ033p5eaGHQvC0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e64997a934so3799101b3a.0;
        Mon, 11 Mar 2024 14:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710191294; x=1710796094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HJ7mGPmH4nvjVfLzJ9f2J+CexeqjKqHI5a66rdCrjw=;
        b=gaOB93a76u5569Bz0LjmaciYg+g4Vd1uqUrAzYV4Zw/vr1hG83qlZ5RW4UCPb/7/wb
         F0Ag6Mpi+JbbHGkHI6QwMChrHA8yYMAp9CDIhk2PuI9MwCuBFoGLMatkmfTIdWaJ+ip1
         CUvQBq/hIC1OE0F+TcAaJJFzYrp4oB3uQyJhx0Em4bmeWGANDz3TOfHxDUZIg8F1o5tV
         VCxDQ18W6qXoa+zTsTPp4/LvJD42bFxZGu/JsYdxDEYlKZZvskLvefyMDxRFATyPi/4/
         5Odzd4OZObD3elLGfEah8U9l6tQ2YhuyBbzMQsyK1aP2XYtbUnhkzD0kkx71JQpLq7dd
         z/cA==
X-Forwarded-Encrypted: i=1; AJvYcCVzU/BElW0WEnZ103l2edALYaxZA2jXL96mqwfLkyLTdTbnY/Z5+on0nLHSYCOTqMc37VIUmE2Aur0MMT4G1pIb5QzpQv837u8D5QPLQ5k7RTR+F+cpmk5ibC3XF7n3YdZl87ILoFCF2qpPBspuJA==
X-Gm-Message-State: AOJu0Yy4oo959RKi9MLkbRoy4L5r+oQHw58WoH+VN148WrAsyfNTgmM4
	UDioAZWJphGuTQIi63q/A3Lrjq4+Itr/v0FnP8G5clOROuIUCzE2dLMV8wrT4ph6HIpR8fksjrd
	NQ1YQYIY1zFNnDca8il20dgGmnJQ=
X-Google-Smtp-Source: AGHT+IH9CfieunkQBz28qm/hisRo9qN+6hrgmX1gRGP34fCVDFRLxULcr2KH8jvyniuhK9MsjvrPXdTTQGB58nYaY7Q=
X-Received: by 2002:a05:6a21:6da7:b0:1a3:115b:acb5 with SMTP id
 wl39-20020a056a216da700b001a3115bacb5mr1583039pzb.21.1710191294083; Mon, 11
 Mar 2024 14:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302001139.604829-1-weilin.wang@intel.com> <20240302001139.604829-3-weilin.wang@intel.com>
In-Reply-To: <20240302001139.604829-3-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Mar 2024 14:08:02 -0700
Message-ID: <CAM9d7cjz1JPM0MQ5m6V7DCgShCBNCd5uqVLotf61J3eu216mEQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Weilin,

On Fri, Mar 1, 2024 at 4:11=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> When retire_latency value is used in a metric formula, perf stat would fo=
rk a
> perf record process with "-e" and "-W" options. Perf record will collect
> required retire_latency values in parallel while perf stat is collecting
> counting values.
>
> At the point of time that perf stat stops counting, it would send sigterm=
 signal
> to perf record process and receiving sampling data back from perf record =
from a
> pipe. Perf stat will then process the received data to get retire latency=
 data
> and calculate metric result.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/builtin-stat.c     | 179 +++++++++++++++++++++++++++++++++-
>  tools/perf/util/data.c        |   4 +
>  tools/perf/util/data.h        |   1 +
>  tools/perf/util/metricgroup.h |   7 ++
>  tools/perf/util/stat.h        |   3 +
>  5 files changed, 191 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 5a3093541cff..3890a579349e 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -94,8 +94,13 @@
>  #include <perf/evlist.h>
>  #include <internal/threadmap.h>
>
> +#include "util/sample.h"
> +#include <sys/param.h>
> +#include <subcmd/run-command.h>
> +
>  #define DEFAULT_SEPARATOR      " "
>  #define FREEZE_ON_SMI_PATH     "devices/cpu/freeze_on_smi"
> +#define PERF_DATA              "-"
>
>  static void print_counters(struct timespec *ts, int argc, const char **a=
rgv);
>
> @@ -162,7 +167,8 @@ static struct perf_stat_config stat_config =3D {
>         .ctl_fd                 =3D -1,
>         .ctl_fd_ack             =3D -1,
>         .iostat_run             =3D false,
> -       .tpebs_event_size =3D 0,
> +       .tpebs_event_size       =3D 0,
> +       .tpebs_pid              =3D -1,
>  };
>
>  static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> @@ -687,12 +693,163 @@ static enum counter_recovery stat_handle_error(str=
uct evsel *counter)
>         return COUNTER_FATAL;
>  }
>
> -static int __run_perf_record(void)
> +static int __run_perf_record(const char **record_argv)
>  {
> +       int i =3D 0;
> +       struct tpebs_event *e;

Please put a blank line after the declaration.


>         pr_debug("Prepare perf record for retire_latency\n");
> +
> +

A duplicate new line.

> +       record_argv[i++] =3D "perf";
> +       record_argv[i++] =3D "record";
> +       record_argv[i++] =3D "-W";
> +
> +       if (stat_config.user_requested_cpu_list) {
> +               record_argv[i++] =3D "-C";
> +               record_argv[i++] =3D stat_config.user_requested_cpu_list;
> +       }
> +
> +       if (stat_config.system_wide)
> +               record_argv[i++] =3D "-a";
> +
> +       list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> +               record_argv[i++] =3D "-e";
> +               record_argv[i++] =3D e->name;
> +       }
> +
> +       record_argv[i++] =3D "-o";
> +       record_argv[i++] =3D PERF_DATA;

I don't think you need side-band records and synthesizing for this.
I'd like to disable all of them but it'd require changes in perf record.
For now, you need to pass --synth=3Dno at least.

Thanks,
Namhyung


> +
>         return 0;
>  }

