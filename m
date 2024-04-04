Return-Path: <linux-kernel+bounces-131938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD643898DBD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF21C1C28D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C0212FB2C;
	Thu,  4 Apr 2024 18:08:45 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097412FF71;
	Thu,  4 Apr 2024 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254124; cv=none; b=NODe+CjvRK+Ozjbj08F4BflB+8DONn7tF0OoB9kYQAT8o51hh/dFoMiXbX6GA6z2Asb0gBru5rUMm6InViD7kgcv1Kwn4N8jkb4EnOaKzPGBjKiLoO196v2aSSZdndPGTUJGkheYwjun5pbSFfr5qUHm1uV0SPYF5Kv2cIA6L/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254124; c=relaxed/simple;
	bh=0DbusI7GY03Wj0tGOtwXkpAVva/Wgxk1NxWdN40xn+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIqGutPbNbrRHVIqm8jLoBuJfOTZcONcsvc1ClT4A3nOcwnaB+op80EJMDNJgOs4SoOHq1qt1b0AGHYhPCWBR7hmpCReBxIzrwYrZm32zLZIKuUA631vqV5LVn9tLIER3kfSlox+4yX5Xl0OfzioUsxtu/XNBoSdFLw3N3QU7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5f034b4dcecso955368a12.1;
        Thu, 04 Apr 2024 11:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712254122; x=1712858922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0Iw1ZA3glUSrCjqo0XgoMrR9akniIS9Yku901iiv9o=;
        b=ulMHaorPtVCabsUrESsseKQfmWnMvlVkxcFB37bT5VEtcpDETjkyVbagX7IwpiZFyC
         NRzafD/yCi1DJ7+H9eSMlX0U19F1HjfZus5ajA9YnnLywxhG/wVEI/qEDJ4JpegMirS7
         V5cW0TXxlDXM8cL+un6mtUZp9n/b2m+jpjISEz/GIZ5Y08EDj85qdZ5w9AbmWxepjj74
         YgXMiYjfXMDvyHbZP8u49AegoaW6ANYpYdY9ksRHJzVuJRO0LSR7z76+CbzCOrHmP21Y
         9YDRh0mxJH6vDzCQ/pGrzDXJGjeu6ropFVGMJym5t76+eITpavL4VpZpuaV2BlA2C8Tm
         i1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXm1rYO+no7od/chJB6iXHCSv0SPxTklj3ow+lFRO6yJoGIgXxFw/DDC78pSpN5+V3XA3geDoattItSsji+fV3oiDPXATltYg9L7S5u4iNI1DGi0XiUFNxxvTD442dSdbXuqdn14EnBLd9CGnTyeg==
X-Gm-Message-State: AOJu0YwMIJMsygu7934SaCsi552+paQt+3DvVXe9+hunHTx69Gk9iFfh
	VMCLNGGGJLJeJ/NQfgmmi9y1GDy9QYBX3eJzVHHuZjWmB3OU7WNpM7r3srfUmpAIx8h3LRP+Ffj
	IEgMIN+PcmgzDnoF8X0JUOOKvjWg=
X-Google-Smtp-Source: AGHT+IFunuj9sblh5HiySy+tjJp5z708RHdeC2RTydCVSG5q+NeE58+2Z93eUeFeYUJGARdzOg09IbCz8sKaJabfE2A=
X-Received: by 2002:a17:90a:2f05:b0:2a2:6244:32b5 with SMTP id
 s5-20020a17090a2f0500b002a2624432b5mr374623pjd.11.1712254122425; Thu, 04 Apr
 2024 11:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403164818.3431325-1-irogers@google.com>
In-Reply-To: <20240403164818.3431325-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 4 Apr 2024 11:08:31 -0700
Message-ID: <CAM9d7chRiUO8uqJjHNbf3w8bx00xpS7f-rjGnKwMp+6+ftZniA@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Be more tolerant of metricgroup failures
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Wed, Apr 3, 2024 at 9:48=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> Previously "set -e" meant any non-zero exit code from perf stat would
> cause a test failure. As a non-zero exit happens when there aren't
> sufficient permissions, check for this case and make the exit code
> 2/skip for it.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  .../perf/tests/shell/stat_all_metricgroups.sh | 28 +++++++++++++++----
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf=
/tests/shell/stat_all_metricgroups.sh
> index 55ef9c9ded2d..d6db192b9f18 100755
> --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> @@ -1,9 +1,7 @@
> -#!/bin/sh
> +#!/bin/bash
>  # perf all metricgroups test
>  # SPDX-License-Identifier: GPL-2.0
>
> -set -e
> -
>  ParanoidAndNotRoot()
>  {
>    [ "$(id -u)" !=3D 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid=
)" -gt $1 ]
> @@ -14,11 +12,29 @@ if ParanoidAndNotRoot 0
>  then
>    system_wide_flag=3D""
>  fi
> -
> +err=3D0
>  for m in $(perf list --raw-dump metricgroups)
>  do
>    echo "Testing $m"
> -  perf stat -M "$m" $system_wide_flag sleep 0.01
> +  result=3D$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
> +  result_err=3D$?
> +  if [[ $result_err -gt 0 ]]
> +  then
> +    if [[ "$result" =3D~ \
> +          "Access to performance monitoring and observability operations=
 is limited" ]]
> +    then
> +      echo "Permission failure"
> +      echo $result
> +      if [[ $err -eq 0 ]]
> +      then
> +        err=3D2 # Skip
> +      fi
> +    else
> +      echo "Metric group $m failed"
> +      echo $result
> +      err=3D1 # Fail
> +    fi
> +  fi
>  done
>
> -exit 0
> +exit $err
> --
> 2.44.0.478.gd926399ef9-goog
>

