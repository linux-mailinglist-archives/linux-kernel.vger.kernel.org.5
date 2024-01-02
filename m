Return-Path: <linux-kernel+bounces-14779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3D1822214
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3991F2363F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6E515E9B;
	Tue,  2 Jan 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YnFrFJaw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487015E97
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e70d8273fso368e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 11:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704224055; x=1704828855; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Un5GyHZQ4WSWEA7P5VD9SJRg2P6RBD31ou6ndsq25Jg=;
        b=YnFrFJawr0V3ZjIDkrq3v6Zty0EFOLf2hP/E13iPEU2xBwkCAdbhKFzKdksP2DrFdU
         4B/5Vue1OdfVRBDL9JXbdT/7mNqDXd3SkQn8jYEvreUtIsHRbuBjpl8K+lOxpGowNSFd
         y7TdEfk+FHTtOX5WXivKWBqdQPnHRZpIqvR0R9vrTIpTFfpTur6c4ok76VrgdNr2ryQL
         W+GJzAj4fLMwHLM324v7tAF72+XUrmXMyt61NOux4NEJQU0PEIfK+qGh6zkxwsWS2W5y
         Ab7ZtYScbka5ZoegQk+hvHdB4/7NroLapBBP4mMLV5ROgUjmflYLFP9r37n0boOVaMkU
         Ak/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704224055; x=1704828855;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Un5GyHZQ4WSWEA7P5VD9SJRg2P6RBD31ou6ndsq25Jg=;
        b=liERCeT93hKCZ3lO4UCj6sMUsEINvSBj/9kBpcBJ1/cGP48VKKO3b5N/Kx9x5cPrWE
         X03ApR0uF6gag7o4Je7AUQMNe5Nc1v0sbh+rC9OuyGXDCsZGrYSiNq/iJe3nBFf9hBAI
         WrTmgKZMFLKyd6OnSEwE45Ymow9URJJYc+blsi1B7XnPRAEEPT5CYWzGlA7nXvWhYvJu
         upp6g0jk+AIIEcz70Blav5ZsKqX1W8Zw7A6d+imrC1OeKdlo6uBYexGwngFGTw1s5DF5
         y98twDNdbXda8snRGoIYopJVtbSagj32Rj2mZpE7wCayR3lJDHf3w3sXJINrLlHi/8FS
         167Q==
X-Gm-Message-State: AOJu0Yy7/sd9Gd7cjsdphoHqjE6kBDql3B5u/aeD+DeyehoPvy67ibsq
	LXajNXUj7sO68a6phtI8apGptMSTBWhdH/xtajIHJALpHqIr
X-Google-Smtp-Source: AGHT+IFxjYsaOeK5XhU1uu7IppfCk2WA4+/o1h1EcG10m4jwKG838oN7yXVRSx6u7d+yF1SReZInyj/CB4cJp6xZtd0=
X-Received: by 2002:a05:6512:3f08:b0:50e:84b4:2bdc with SMTP id
 y8-20020a0565123f0800b0050e84b42bdcmr5113lfa.2.1704224054555; Tue, 02 Jan
 2024 11:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211181242.1721059-1-irogers@google.com>
In-Reply-To: <20231211181242.1721059-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Jan 2024 11:34:03 -0800
Message-ID: <CAP-5=fVWZ7etZq7YBU1HGMnyJ6wsZ3zok9JuS7eWQsTKuqzrAA@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Fix hard coded ll miss units
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Guillaume Endignoux <guillaumee@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 10:13=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Copy-paste error where LL cache misses are reported as l1i.
>
> Suggested-by: Guillaume Endignoux <guillaumee@google.com>
> Fixes: 0a57b910807a ("perf stat: Use counts rather than saved_value")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. Trivial 1 character fix but no reviews :-(

Thanks,
Ian

> ---
>  tools/perf/util/stat-shadow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 1c5c3eeba4cf..e31426167852 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -264,7 +264,7 @@ static void print_ll_miss(struct perf_stat_config *co=
nfig,
>         static const double color_ratios[3] =3D {20.0, 10.0, 5.0};
>
>         print_ratio(config, evsel, aggr_idx, misses, out, STAT_LL_CACHE, =
color_ratios,
> -                   "of all L1-icache accesses");
> +                   "of all LL-cache accesses");
>  }
>
>  static void print_dtlb_miss(struct perf_stat_config *config,
> --
> 2.43.0.472.g3155946c3a-goog
>

