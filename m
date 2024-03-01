Return-Path: <linux-kernel+bounces-87813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 404F086D957
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77012286E54
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D11B38F9B;
	Fri,  1 Mar 2024 02:04:13 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B839AC9;
	Fri,  1 Mar 2024 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258652; cv=none; b=POK981BhqEnF49C5nPkpio4gg7wH/Tukd+uyl19SYuGkkD92RB9rzvOtxaq+FnLq7PQcbuxsprY0lJ7OJkhPEgS+N6G/5iMFCZ+k+P5yCfzrDoUoocZTIU1xenWoxHnvrXaWFDtt4oEq3IjYvfH4NFU/rnwMfVUbufgD3/Zppe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258652; c=relaxed/simple;
	bh=/d9AG0yAYaKw80HGazSSs3yzEkw5b6BjdLgT2pIrXDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5T/UkpjDIbnIy2zyOeBV+oLPgpKaNEib783aSDcmepOqjmuDkw6WCqiIjSFaHyo2/Jr63zko3DpoiOiZD2UR6qnZnTV97OkottCs3fnBOcY0thnq6lhVwTpykGPxXEHhhzSVcrMantY2TJ0dbeMo/fkJzPFz8B28k8ixAUKtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29a6dcfdd30so1253187a91.0;
        Thu, 29 Feb 2024 18:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709258651; x=1709863451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suOSlNRm11HwW5KZFh7zQNpV0hqocGQ1PpQrvLWCrew=;
        b=jxw8oA0c/53Uimm81rXTM8UYOL5UZIXWXgPhDnKa1HYxVI+7JjToInBZBCx6Ib5DPr
         +GKKUMV486IiAW4t5/5+LV21KeBppoaoFTgIFLf1mEtQQY8e8Elr6x6769MGlbvjpz7+
         pjyesWodil2nY+x6kHmd2zkTsXcNEyWLqdm4dxPJKenu1F8y3E4pV8PNScRCT1s9fenh
         ZtZhCbQEllWnpa9JRLmYLMMa4CwNuV7mldxIiyVK/UBRIHNWjEk08UJBPhsaiYSxboBz
         2DisNgaT6rzMR36RacE1E4va4Smp2y/GRGsoch5/bdZBnIlp94znKXJBIhgzV/GWma3V
         e3jw==
X-Forwarded-Encrypted: i=1; AJvYcCWzH7rf+OxAuYTY9hQMgDIDiTz2v4J+R/qbi+9ITLdGEiT8vLoo0E4OehrLKqYJGwTA+gpjRWLD45JbJ134B/Q7jd9WKylf7wBL0ciedQIT+APimNPlC1Qb0wXwweLUXVxYdi/2iy/NBKUAI0BhKQ==
X-Gm-Message-State: AOJu0YyMsKBrSyc0rbmjw1Cm2rUyNczuLs2yhAywAswsQV/0OnCzG4+Y
	y9j3VbAd9CsqGwARgnzPlGLvytZK+2yKTx+BWoTAaQtuac/oYjQxc8T5JqOF/HhVsHbCNBhYlcm
	RTTMzsnBwCQQOgCOOoMMUKhprYjY=
X-Google-Smtp-Source: AGHT+IGpkrbJcWmIpOQ994xbrP0TgrArhB16iqTpTpOaTB7y93OuV1723dzmhSta1S643y/4jxhRWmp4u+0btWfB/9Q=
X-Received: by 2002:a17:90a:d184:b0:29b:1e0a:10c8 with SMTP id
 fu4-20020a17090ad18400b0029b1e0a10c8mr396759pjb.4.1709258650888; Thu, 29 Feb
 2024 18:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229062048.558799-1-irogers@google.com>
In-Reply-To: <20240229062048.558799-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 29 Feb 2024 18:04:00 -0800
Message-ID: <CAM9d7cjCn-GFtjejw+DtK_Y6kNRGLQTAZNn6zarQfNDjvWHUXw@mail.gmail.com>
Subject: Re: [PATCH v1] perf map: Fix map reference count issues
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 10:21=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> The find will get the map, ensure puts are done on all paths.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/maps.c        | 14 +++++++-------
>  tools/perf/util/probe-event.c |  4 +---
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 53aea6d2ef93..ce13145a9f8e 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -611,14 +611,14 @@ struct symbol *maps__find_symbol(struct maps *maps,=
 u64 addr, struct map **mapp)
>         struct symbol *result =3D NULL;
>
>         /* Ensure map is loaded before using map->map_ip */
> -       if (map !=3D NULL && map__load(map) >=3D 0) {
> -               if (mapp)
> -                       *mapp =3D map;
> -
> +       if (map !=3D NULL && map__load(map) >=3D 0)
>                 result =3D map__find_symbol(map, map__map_ip(map, addr));
> -               if (!mapp)
> -                       map__put(map);
> -       }
> +
> +       if (mapp)
> +               *mapp =3D map;
> +       else
> +               map__put(map);
> +
>         return result;
>  }
>
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.=
c
> index be71abe8b9b0..2a0ad9ecf0a2 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2274,9 +2274,7 @@ static int find_perf_probe_point_from_map(struct pr=
obe_trace_point *tp,
>         ret =3D pp->function ? 0 : -ENOMEM;
>
>  out:
> -       if (map && !is_kprobe) {
> -               map__put(map);
> -       }
> +       map__put(map);
>
>         return ret;
>  }
> --
> 2.44.0.278.ge034bb2e1d-goog
>

