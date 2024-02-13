Return-Path: <linux-kernel+bounces-64370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC35853D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A996C1C27535
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A18362802;
	Tue, 13 Feb 2024 21:45:35 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3498B6167E;
	Tue, 13 Feb 2024 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860734; cv=none; b=uf94qJUWtzjLpUnFY2JUS8RVu/jBLMTxrqdfzoqNooxrZYabsJ4WQ83p1HgcvLqW/+kiXDENOKf5Fe8cb4t3pbhLc32wzzicTBjERmqBgvGNNrxuYa3qKX1n/438xjr1w9iYpg6D/8KgJCPQwFXXk+nUTRmNYBVBEYaPQW57mIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860734; c=relaxed/simple;
	bh=zlrnLAVzSU1Jn8766Ja1eXbCBgSYS2I1GytV//3vZNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsOWRVok3u/fS7a2JMLk7aKO+Kh7+j6HHnVGd4hcJwJKDkpIiLtq1Chr5XkYi6iN/wrGg4TNfqsaLcVu/+tpDQhZ9dI9HPCle0zfmjdvIxQxHZYQLDJXSBRlQCXGzgDWRPij6Hy8CwT2j/QXvDbHRsUZ102jXxKH0Uw21lfmpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-297108e7001so2432070a91.1;
        Tue, 13 Feb 2024 13:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860732; x=1708465532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NF3MBlA6g5fE/nQpkUVGLsVhm1KDVfSDHE1cj8tEnnk=;
        b=mmL++hYk7ca+lvx/ov0MK5P0PSo/MY/sAKXIpVbz8GKXM3jyOjEHazpsJSim1sgQnC
         kclMpn4jm+AzyxOKMTDRKkdrLQzKL7kaoPEClKfePWa+5bb3edG016BXvsJfmg47qVX0
         fRYpsw/f7gWv7bX6pfE07lj/vBmdIxFjB/+KIkQ1l/zLQ0tVix4NIgnqvHBzMGQaOgsA
         ZI1F/lxZk/3H0/t5pmd0zXGLGGOlDTh08AXZG8R9CRy1qdwaEJAnwJLWGAedPAEUdGxv
         n/YObxWdCupl4SZMo0eJDBrzuJUi1dKhHVrJLg08UWpIK9U0y8nuUp097UsUD+bGrF9/
         gGvg==
X-Forwarded-Encrypted: i=1; AJvYcCWlnVGZXvb497sguWsE8nGFvk7nYto3hjcmBVaA4NeKvZISwBp+fNf4Gpd4SLeIRnuDMo3tPrQ49+xT2lLodqY1D7CR5uRv0Gn7pHraWiAoE3kKiiz45AGEuY/kKjNKiYDgHVX+kMDSrBsJb/dV2Q==
X-Gm-Message-State: AOJu0YxfjkDFg+TwXJMe35QoUuqolK946vnNX3pCNnjoFEdiq3ncf3pw
	hshAp2z/bY4lIuUt4LqrLiLHbUd7TSVHtaXjccc66ZE+d+lCH2CS6ii7UsXWQk9Ta94mwha9oUM
	JVyQHOEVzsiZBV+JwEd8tLjM+khM=
X-Google-Smtp-Source: AGHT+IHhfCe+4VNW8HkSiAA/uykrSChGIFotbydYKIvayu1h/zipDj4Ofp6vgsQItm8Nv+hV5RBh88WuUgojGb0ncIg=
X-Received: by 2002:a17:90a:7406:b0:297:3305:a690 with SMTP id
 a6-20020a17090a740600b002973305a690mr855014pjg.9.1707860732331; Tue, 13 Feb
 2024 13:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209204947.3873294-1-irogers@google.com> <20240209204947.3873294-4-irogers@google.com>
In-Reply-To: <20240209204947.3873294-4-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 13 Feb 2024 13:45:20 -0800
Message-ID: <CAM9d7ch82xZ2-tfQz641Hj0CpzadVrpp-WfaNWA5R48QJARtbg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] perf stat: Avoid metric-only segv
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 12:50=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Cycles is recognized as part of a hard coded metric in stat-shadow.c,
> it may call print_metric_only with a NULL fmt string leading to a
> segfault. Handle the NULL fmt explicitly.
>
> Fixes: 088519f318be ("perf stat: Move the display functions to stat-displ=
ay.c")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Note, the fixes tag is to a refactor that moved the function. The bug
> existed before this.

Yeah I noticed that.

> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 8c61f8627ebc..b7d00a538d70 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -560,7 +560,7 @@ static void print_metric_only(struct perf_stat_config=
 *config,
>         if (color)
>                 mlen +=3D strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
>
> -       color_snprintf(str, sizeof(str), color ?: "", fmt, val);
> +       color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);

I was thinking about fixing the callers to pass valid format strings
but it seems they don't care about the output string anyway so
I think it's fine.

Thanks,
Namhyung


>         fprintf(out, "%*s ", mlen, str);
>         os->first =3D false;
>  }
> --
> 2.43.0.687.g38aa6559b0-goog
>

