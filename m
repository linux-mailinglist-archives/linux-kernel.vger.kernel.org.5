Return-Path: <linux-kernel+bounces-36203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3639839D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEA01F26F56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9728DA3D;
	Wed, 24 Jan 2024 00:02:36 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DBA160;
	Wed, 24 Jan 2024 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706054556; cv=none; b=SJw5wuyVXoJ9KFMUk5BDviVLL+n7+xsISNvJApmSxO3qPiOsHn4ZaItb4GXgKMcjUgh4YFShCSZvueZFuZvSuN746uC8frQREkKXWXHk7P08KK55tRhiXoFtN76QEHD4wli7QBr1fmgEVka/Dy59UQucmK/aULYnp03WrSmleTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706054556; c=relaxed/simple;
	bh=z4pzDx0a8cABnhT64lFfXVb+mR+WAgKNHe/Hz/FUul8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJ/akQBqJ0+EwPAqdMbgGLAt0u6ILkgcHX5Ct2FW0tPXz/W3C13GkfFO+x0s3yx19O+RYXDhoioyHug0gypq9F7IExfYQPzkw8e/JrhxQorqmVo7/34iK9RHJPSW12zVe2inhpUwR3Pxi3afg4Vv/XrshTjVRIrUrNPXFx/Vk5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2900c648b8bso3704016a91.3;
        Tue, 23 Jan 2024 16:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706054554; x=1706659354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1GF8UXi1BgZZZeN0xcHW6QdLAPvrfHAfMo0hXV/s/w=;
        b=kavUDFcpJtgiqWm0UQuFXhGToWxinDyAy4Zdi5iuNMOjS4+9F9Nvvkh1z0S6fW3iw+
         cGcEB+Deju6gf0bMoaixJp+PESn7mT3TGatYn+jZhTshTz4HIhsH0oDudXRfZkTv7V4e
         uh9xDt4IJdOgefh3UT0m2ZqfeozvSTz5h+38eOHCV8OUCfBdk5nsGXbagc/1RiS2JpGw
         kRCJY1rYKMpvuO/LjeMcxdM0g2GOD7sRlNxBF0Yg6PTCXku1T2vxcYKuKfvjdrFiHgsJ
         EyUDLYfrrEfx6T7dOmuCqCZxYxpSJ/XJ1gcmL86spdNpTzP+0/jHBszdXtrfi20k9aj+
         jX5A==
X-Gm-Message-State: AOJu0YzVUUpCu4q9SYeAPaqo0D2q1z6r+vAwPjO+irbukDv1hfo4xjDu
	pRauZQdrSJuxQbAz1mc8LMo9zPE15I4kraqccFNkNfoDxypC5zk81CATPpI9zdDnstxkY05PtPZ
	ds+M0pPIkm5nib1BUdyvhZIB3SPI=
X-Google-Smtp-Source: AGHT+IEIC6Z8uNO7tVj3Dg0+sn6GGM3mClp7/eIvPY+HwmydTN2TZKKyoO95Y2FpxvE/yApx/SOCd4UVLlieOPsdnTg=
X-Received: by 2002:a17:90a:8004:b0:290:38ef:454a with SMTP id
 b4-20020a17090a800400b0029038ef454amr3387287pjn.56.1706054553972; Tue, 23 Jan
 2024 16:02:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123000604.1211486-1-irogers@google.com> <20240123000604.1211486-6-irogers@google.com>
In-Reply-To: <20240123000604.1211486-6-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 23 Jan 2024 16:02:23 -0800
Message-ID: <CAM9d7ciF+8UVoE46J=tB2MYPwRCGSSvexASwGd3kMBnT-_FFqA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] perf test: Make daemon signal test less racy
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Ross Zwisler <zwisler@chromium.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Shirisha G <shirisha@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 4:06=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> The daemon signal test sends signals and then expects files to be
> written. It was observed on an Intel Alderlake that the signals were
> sent too quickly leading to the 3 expected files not appearing. To
> avoid this send the next signal only after the expected previous file
> has appeared. To avoid an infinite loop the number of retries is
> limited.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/daemon.sh | 34 ++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/da=
emon.sh
> index 4c598cfc5afa..de61e7898578 100755
> --- a/tools/perf/tests/shell/daemon.sh
> +++ b/tools/perf/tests/shell/daemon.sh
> @@ -414,16 +414,30 @@ EOF
>         # start daemon
>         daemon_start ${config} test
>
> -       # send 2 signals
> -       perf daemon signal --config ${config} --session test
> -       perf daemon signal --config ${config}
> -
> -       # stop daemon
> -       daemon_exit ${config}
> -
> -       # count is 2 perf.data for signals and 1 for perf record finished
> -       count=3D`ls ${base}/session-test/*perf.data* | wc -l`
> -       if [ ${count} -ne 3 ]; then
> +        # send 2 signals then exit. Do this in a loop watching the numbe=
r of
> +        # files to avoid races. If the loop retries more than 600 times =
then
> +        # give up.
> +       local retries=3D0
> +       local signals=3D0
> +       local success=3D0
> +       while [ ${retries} -lt 600 ] && [ ${success} -eq 0 ]; do
> +               local files
> +               files=3D`ls ${base}/session-test/*perf.data* | wc -l`

Wouldn't it show error messages for 'file not found' for the first
round?  I think we can add '2> /dev/null' to suppress that.

Thanks,
Namhyung


> +               if [ ${signals} -eq 0 ]; then
> +                       perf daemon signal --config ${config} --session t=
est
> +                       signals=3D1
> +               elif [ ${signals} -eq 1 ] && [ $files -ge 1 ]; then
> +                       perf daemon signal --config ${config}
> +                       signals=3D2
> +               elif [ ${signals} -eq 2 ] && [ $files -ge 2 ]; then
> +                       daemon_exit ${config}
> +                       signals=3D3
> +               elif [ ${signals} -eq 3 ] && [ $files -ge 3 ]; then
> +                       success=3D1
> +               fi
> +               retries=3D$((${retries} +1))
> +       done
> +       if [ ${success} -eq 0 ]; then
>                 error=3D1
>                 echo "FAILED: perf data no generated"
>         fi
> --
> 2.43.0.429.g432eaa2c6b-goog
>

