Return-Path: <linux-kernel+bounces-166837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396E8BA08E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E60C2818E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1842174ECF;
	Thu,  2 May 2024 18:32:34 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC5515E80D;
	Thu,  2 May 2024 18:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674754; cv=none; b=u+un0dZEBvZQg0RD2KKqNEbYsyLfI0ziR5iwP3bBAkJR1w7hxnGcIYxFI+kwGpU+wLs+R24ZV0S8fZTPgkj/7tLk2s7IC1VJeT64d7YrE47nUSFLd4leHje31mkTHAMoz5YF8qYXVaYXNLm9h5Fo2WZCgCrwdF73Mh0IaAsTfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674754; c=relaxed/simple;
	bh=wk4Ngof6yU26+Asb22aYLpemVSazW1dXkLAq0tYukyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0KO0QTIYUYwoBrONqmCZKSFEBwu6CPk1v8SD/skkxp08E2rzYz9Gf+f5ONJPkB24QGKNmEk74iFxuKnpmCooDQ9gDZWLlcds7kSTYGpXFTmEcNv92g2FXQaJ9O7vdOcN3RygWQWCKiMZ5of+NgTdtvSuyCG8V5vvUDjsHPz6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c70d8bb618so3734742b6e.2;
        Thu, 02 May 2024 11:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714674752; x=1715279552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DNylzW5XAts2CCwACCkXw9O6Z2hKXG+ML4plDdKHJg=;
        b=nDxC1P20Fx8AIuWafP4h9Xal3t2Y7xq7xaIINuxQk43N3S9tQvTw5r65OvIGGVSCVC
         dll4d78CrtWzqYoylQh+3VDpPUM0FY/h0brvirxdFaxkEFe+eKzqTdDKythQ2KQHNcCt
         gB4m8NiOsjHaGvH/rhJ6r7Cm4MwCfdecHmczhonOwAP1Zyovn+/YSIKYyVu/Zb72qXMq
         VmPiuYw81/k37kU+dPmk5+A+0OHu6JzN96j5GtsXqTr6MP5SPIPwekbiE1Ltp5foAYsn
         XsW3x+93LIYhsByKuugZ/OqbTcC5u6mU7DyecmfPnjFdB8l1W/AUZkREhi9R00j8MAzs
         YJAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDr/Z8ZQYHmgCq1s5cEsmoxKwPJ3Ww8S4aKYXHMzDsRiAcUutfUPQZtUWYMbdWHMRZjI+2xhcSJ7UterdJvVoy7dq+nxdkKL7RJLGqp/9rdg==
X-Gm-Message-State: AOJu0YyZXyY1Zt3yQXhUSupomMwsOrSy42Mg+xPeztg5oj0WMFipIYiY
	bTY79prKD6CBAb4KLNXj00mxmo2AxkfHZgCXcUIeCQkreTB088wYEr8r78o610obKtb9/upi/pP
	B8i7HrKhirWVy1wBVsFIuor87iSY=
X-Google-Smtp-Source: AGHT+IGLb0E0X/4J0Cv8NxiR82lpQ+dcjQLL8nIs3sBdcTV/hSXSw8TZDnyDXD/IIYtETvHtFH9mY9soHTtrqH5rvyQ=
X-Received: by 2002:a54:438f:0:b0:3c8:47a3:3cb6 with SMTP id
 u15-20020a54438f000000b003c847a33cb6mr762553oiv.21.1714674752158; Thu, 02 May
 2024 11:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502091446.3037-1-nick.forrington@arm.com> <20240502091446.3037-2-nick.forrington@arm.com>
In-Reply-To: <20240502091446.3037-2-nick.forrington@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 2 May 2024 11:32:20 -0700
Message-ID: <CAM9d7cjWDwg1nQPL4qDKHi59pmhrZq8+c8GhsgAT72cLUv_i2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] perf lock info: Display both map and thread by default
To: Nick Forrington <nick.forrington@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, May 2, 2024 at 2:15=E2=80=AFAM Nick Forrington <nick.forrington@arm=
com> wrote:
>
> Change "perf lock info" argument handling to:
>
> Display both map and thread info (rather than an error) when neither are
> specified.
>
> Display both map and thread info (rather than just thread info) when
> both are requested.
>
> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> ---
>  tools/perf/Documentation/perf-lock.txt |  4 ++--
>  tools/perf/builtin-lock.c              | 22 +++++++++++++++++-----
>  2 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Document=
ation/perf-lock.txt
> index f5938d616d75..57a940399de0 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -111,11 +111,11 @@ INFO OPTIONS
>
>  -t::
>  --threads::
> -       dump thread list in perf.data
> +       dump only the thread list in perf.data
>
>  -m::
>  --map::
> -       dump map of lock instances (address:name table)
> +       dump only the map of lock instances (address:name table)

But your change allows both thread and map info to be printed, right?

>
>
>  CONTENTION OPTIONS
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 230461280e45..86c68c39aac0 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1483,11 +1483,16 @@ static int dump_info(void)
>
>         if (info_threads)
>                 dump_threads();
> -       else if (info_map)
> +
> +       if (info_map) {
> +               if (info_threads)
> +                       fputc('\n', lock_output);
>                 dump_map();
> -       else {
> +       }
> +
> +       if (!info_threads && !info_map) {
>                 rc =3D -1;
> -               pr_err("Unknown type of information\n");
> +               pr_err("No lock info specified\n");
>         }

I guess you made this condition impossible.

>
>         return rc;
> @@ -2578,9 +2583,9 @@ int cmd_lock(int argc, const char **argv)
>
>         const struct option info_options[] =3D {
>         OPT_BOOLEAN('t', "threads", &info_threads,
> -                   "dump thread list in perf.data"),
> +                   "dump only the thread list in perf.data"),
>         OPT_BOOLEAN('m', "map", &info_map,
> -                   "map of lock instances (address:name table)"),
> +                   "dump only the map of lock instances (address:name ta=
ble)"),

Ditto, I think we can drop the 'only' part.

Thanks,
Namhyung


>         OPT_PARENT(lock_options)
>         };
>
> @@ -2694,6 +2699,13 @@ int cmd_lock(int argc, const char **argv)
>                         if (argc)
>                                 usage_with_options(info_usage, info_optio=
ns);
>                 }
> +
> +               /* If neither threads nor map requested, display both */
> +               if (!info_threads && !info_map) {
> +                       info_threads =3D true;
> +                       info_map =3D true;
> +               }
> +
>                 /* recycling report_lock_ops */
>                 trace_handler =3D &report_lock_ops;
>                 rc =3D __cmd_report(true);
> --
> 2.44.0
>
>

