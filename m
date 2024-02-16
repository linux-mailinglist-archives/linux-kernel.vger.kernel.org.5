Return-Path: <linux-kernel+bounces-69288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843858586A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DC11F23327
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000C213AA5A;
	Fri, 16 Feb 2024 20:22:26 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABA137C5A;
	Fri, 16 Feb 2024 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114946; cv=none; b=THbKRU3mPW0TKxmEyVCBE+jCBZmDqY75qoyASNIEXwdqE/xBZrRc4WpNPoYdNjSser34sXYnEzwdm3bh1eoe6MO1fK89W4bkrIsQeXq4ThnBtKO/facJKB3TcKfsmJM4tkgZXdwh3KieweSLxcxfbnYZHEYba6G6HiGTChH/IgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114946; c=relaxed/simple;
	bh=pnCogIDz14LG5tHCuqzaTGDuVoRYHckFSaXPPX5xATI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+jeZxzIvDTOHcNHNbn/AiMwru+8OT7/NVbuzS1+8vSW9x8u18oIEp0As2nPBfpawzqeYzMAfOFbVql6jtIsCiVN8iM1+Ke5cdyRUABpR8zRGYwFXt5olLnlloKGrtEX+YY2uImxZLAUg0/Tty26S84HioJh4UJC0K9em3HsuQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2995185dbbbso141325a91.3;
        Fri, 16 Feb 2024 12:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708114944; x=1708719744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oq0A0N9FMvQiwLtedEjU1Y/XLo5XcWAr1iJu9cUBjms=;
        b=XbjlfEqd+soG7CDvwv1svXhAN+6q+9p5qM1xGRrzcZCwmaLMe+cWmCQMP3tFLzK5s5
         vZD4Q2P2MOQb1/WuCNKrOpeRIXzzX5YyMGLR5J7hdf6fepJMaOOatR2YlbWob6xPvNDi
         Cdd4w9HP+T8uGIMRSKj1HrTGRdjr6Z8C2D2J1lvBhy+4RdePyZvLAw3yIwwZTwqn/+qT
         h1t4caU/0DqaQ71pi1y3qB/FmSjLe75jZOex613fSdmer7IuXdxEFayS3lMbz6/+TGOc
         Kr/oVYlJ10/LfaEmpYEWRiGl8QUuIH1Ums3Ctir4XR0P8TtdGgFhDAwiK60pIGVIZKyQ
         OwTQ==
X-Forwarded-Encrypted: i=1; AJvYcCViRTV6pk25t8bwPxbK1Ecv35GIy19g8oPun8kbS481pRrFx+YijGyOcwIcLTb8vpb3fNd7KKwMJlOVmlLaThOO3ME5V7QwPB5FCnajvXfZ70ZdvBTbmuCc60lfX3xUHHw3Lqq5/cXqGxZTgF8sJw==
X-Gm-Message-State: AOJu0Yx4HBD9BFvtEnK9VDVtae3cMXJRoKLiw+xMJBavzAdWV4vv/TVH
	hdfjFFSrQIMFbwVT9YaeZnpuGsAMXCUhXlM1Yv9ygEkoLx5/JmPzttHGSC3Vs8mCIDA5aN22YiR
	EtKXHTEBjsAMyA0LBRZn5QcRH+2k=
X-Google-Smtp-Source: AGHT+IFguJIhRwRsgj6T4qcPSOxXHVK81XmIp86YrUJaYpTa7bcm2JYGq7PJIvPTaMXl36nvaefa641o/QO8CYYI9Dw=
X-Received: by 2002:a17:90a:a883:b0:299:1aaa:5ff with SMTP id
 h3-20020a17090aa88300b002991aaa05ffmr4758561pjq.7.1708114944478; Fri, 16 Feb
 2024 12:22:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214045356.748330-1-irogers@google.com> <20240214045356.748330-7-irogers@google.com>
In-Reply-To: <20240214045356.748330-7-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 16 Feb 2024 12:22:12 -0800
Message-ID: <CAM9d7cg5O_1yKpk_X5vn380Cu28ObLjjjnOONHF75D07ZbkR3g@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] perf tests: Use scandirat for shell script finding
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, James Clark <james.clark@arm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 8:54=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Avoid filename appending buffers by using openat, faccessat and
> scandirat more widely. Turn the script's path back to a file name
> using readlink from /proc/<pid>/fd/<fd>.
>
> Read the script's description using api/io.h to avoid fdopen
> conversions. Whilst reading perform additional sanity checks on the
> script's contents.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c  |  21 ++---
>  tools/perf/tests/tests-scripts.c | 144 ++++++++++++++++++-------------
>  tools/perf/tests/tests-scripts.h |   1 -
>  3 files changed, 95 insertions(+), 71 deletions(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index eff3c62e9b47..6d5001daaf63 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -300,22 +300,20 @@ static int test_and_print(struct test_suite *t, int=
 subtest)
>  }
>
>  struct shell_test {
> -       const char *dir;
>         const char *file;
>  };
>
>  static int shell_test__run(struct test_suite *test, int subdir __maybe_u=
nused)
>  {
>         int err;
> -       char script[PATH_MAX];
>         struct shell_test *st =3D test->priv;
> +       char *cmd;
>
> -       path__join(script, sizeof(script) - 3, st->dir, st->file);
> -
> -       if (verbose > 0)
> -               strncat(script, " -v", sizeof(script) - strlen(script) - =
1);
> -
> -       err =3D system(script);
> +       asprintf(&cmd, "%s%s", st->file, verbose ? " -v" : "");
> +       if (!cmd)
> +               return TEST_FAIL;

It fails to build.

tests/tests-scripts.c: In function =E2=80=98shell_test__run=E2=80=99:
tests/tests-scripts.c:130:9: error: ignoring return value of
=E2=80=98asprintf=E2=80=99 declared with attribute =E2=80=98warn_unused_res=
ult=E2=80=99
[-Werror=3Dunused-result]
  130 |         asprintf(&cmd, "%s%s", file, verbose ? " -v" : "");
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thanks,
Namhyung


> +       err =3D system(cmd);
> +       free(cmd);
>         if (!err)
>                 return TEST_OK;
>

