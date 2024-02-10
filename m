Return-Path: <linux-kernel+bounces-60280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA88485028D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663C01F242E2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 04:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FEC63B3;
	Sat, 10 Feb 2024 04:41:09 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E223B0;
	Sat, 10 Feb 2024 04:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707540069; cv=none; b=IFJDMVeb0ZhfEBuoSTab1jL6m5ubHVwRM9ZeMFH0tuxieimNAF2T1qja2HBooOA2pqIMyxwHO5PiuYrsAzjzQolYhsWJOtr4ceczPWuMtcITTrJPJONDeeLwTOPw7zVGhhXltRs2U1/Xk5UR5ZmKAR/EslxeIeCip44OdnrIeqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707540069; c=relaxed/simple;
	bh=glEKylj6hGoshCUUwb23D4sXjlqavO0BCnKPI92hvlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCEIMa6XCzcnHRG+VhUzPHL128gxYnkrweMGD9TMt+ccMmTmQQ9q16jFt0ifj8ro9Qsl3apKhF9U8YzFiCbW2QblZ9WPCQfZvyNU69ZUvVNkBrLOt/02GzGQ2ZJKmwv1/AsnxPB8uZZMWZoxKghksbpKUwqBU57F1rCqVKuPIdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59d11e0b9e1so917264eaf.1;
        Fri, 09 Feb 2024 20:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707540067; x=1708144867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZCGeaOgFb/POuILW7FEZXlx24Rn7F7T3YvkEdqGZn8=;
        b=A2xBbxwe0JMbk/DL93RM3i181nBltz7HDElkyCQv9wADRh9DATvoVHXwo+DPTem04g
         WfrXt6KtTUZjLgQtrvA2bzZpKyOX1G4bkFFGM4ci7vEXktiKbMYaGB5fvdLHN8s4TxS/
         2Wbkd/s2pAId+2Uo+xebvlLY5Kr8/IOx96IudN2VQuS0poJklyJioqhYaBHQHq3t8ZP8
         sJksiH1clmXXBXlIsZxCe0b72AhIGApk0/MyzuJ5DShOqPwp3HTnFY9qeyRP2QX2krvI
         x2QS1/D+s4XwwFF3D/HBizx0J1ZSzyO7s6W3OKghXW2ICPBtu3Jek1y6oa4QSwSXYwRg
         Xdzw==
X-Forwarded-Encrypted: i=1; AJvYcCXPjzNpcB+8g3XbMfvqPwkqGntGfMq0zKFnVlpgGYTp4ZJ4YMucbw4uwktmJvL89jzjqaewPmuWcH1wrw276R+9BB1jaBfiRN244a+X1lZc2Df0Hx9pfi9gx7LM1I+RMNeEWMceNxiq9QsfJ3zJuw==
X-Gm-Message-State: AOJu0Yzu1hRnMQq/hG/vngozwGOUVFeoaGFdTTSUspVZC68BdFhaEFsL
	MGYu45VtC4rxTxiCRn+yszXhNPjH+e2xAWiM19G3Y9nP8T4VuqxDccUQp9+VaYhTwA53+O+bFUe
	zDIkWPxeOy9m8hQcHCaM+/aW80PQ=
X-Google-Smtp-Source: AGHT+IEJ/x2TjQP1hdkhnSUv18VsQ0EdYULkKuKuNTVsNhbj3HngAA7gbe7Ti38jDWoSmT5WSwMTz2Cq/iSJVKXP2VQ=
X-Received: by 2002:a05:6358:5985:b0:179:22c:4a4d with SMTP id
 c5-20020a056358598500b00179022c4a4dmr2150235rwf.22.1707540066959; Fri, 09 Feb
 2024 20:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201001504.1348511-1-irogers@google.com> <20240201001504.1348511-6-irogers@google.com>
In-Reply-To: <20240201001504.1348511-6-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 9 Feb 2024 20:40:54 -0800
Message-ID: <CAM9d7cjka_O5OmCxkrp-K6g45VnxEJNd73jjv6kQanutf+6sbg@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] perf tests: Use scandirat for shell script finding
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 4:15=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
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
[SNIP]
> -static const char *shell_test__description(char *description, size_t siz=
e,
> -                                           const char *path, const char =
*name)
> +static char *shell_test__description(int dir_fd, const char *name)
>  {
> -       FILE *fp;
> -       char filename[PATH_MAX];
> -       int ch;
> +       struct io io;
> +       char buf[128], desc[256];
> +       int ch, pos =3D 0;
>
> -       path__join(filename, sizeof(filename), path, name);
> -       fp =3D fopen(filename, "r");
> -       if (!fp)
> +       io__init(&io, openat(dir_fd, name, O_RDONLY), buf, sizeof(buf));
> +       if (io.fd < 0)
>                 return NULL;
>
>         /* Skip first line - should be #!/bin/sh Shebang */
> +       if (io__get_char(&io) !=3D '#')
> +               goto err_out;
> +       if (io__get_char(&io) !=3D '!')
> +               goto err_out;
>         do {
> -               ch =3D fgetc(fp);
> -       } while (ch !=3D EOF && ch !=3D '\n');
> -
> -       description =3D fgets(description, size, fp);
> -       fclose(fp);
> +               ch =3D io__get_char(&io);
> +               if (ch < 0)
> +                       goto err_out;
> +       } while (ch !=3D '\n');
>
> -       /* Assume first char on line is omment everything after that desc=
 */
> -       return description ? strim(description + 1) : NULL;
> +       do {
> +               ch =3D io__get_char(&io);
> +               if (ch < 0)
> +                       goto err_out;
> +       } while (ch =3D=3D '#' || isspace(ch));
> +       while (ch > 0 && ch !=3D '\n') {
> +               desc[pos++] =3D ch;
> +               if (pos >=3D (int)sizeof(desc) - 1)

Maybe (pos =3D=3D sizeof(desc) - 2) ?  I'm not sure what happens if it has =
a
description longer than the buffer size.

> +                       break;
> +               ch =3D io__get_char(&io);
> +       }
> +       while (pos > 0 && isspace(desc[--pos]))
> +               ;
> +       desc[++pos] =3D '\0';

Wouldn't it overflow the buffer?

Thanks,
Namhyung


> +       close(io.fd);
> +       return strdup(desc);
> +err_out:
> +       close(io.fd);
> +       return NULL;
>  }

