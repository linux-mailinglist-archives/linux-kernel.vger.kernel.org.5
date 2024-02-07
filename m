Return-Path: <linux-kernel+bounces-55904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDBF84C33B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DA51C248D2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F4710940;
	Wed,  7 Feb 2024 03:44:03 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657CFC05;
	Wed,  7 Feb 2024 03:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277443; cv=none; b=f0wJooFac3AApD1TVReJRPbTYBZYc5MLKFADRZTn/NnV8qBPiQr0iwpdpCGb2L4iwEpn+ZVMhJ/S69iAKH5aff4mgJyhmFEkVb2+azJ9Gw2stcBcb1cSm53mzOmYEf0yVog2cmDGtL7BiMm10r9DIMqWwDSvKK76fI40E3fDCpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277443; c=relaxed/simple;
	bh=NKdGqa02hSaQu5JelJ/ksYe+zhE7UAptAzAuxtKjJc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ph455ZGB0m/IZ1AQde7G1/9dEN7vsEiN9jVUQKWkrnWz8kEfh9Uxq0OJllmwIAODSWMHvxWM/6Bjvd2t6oubpsifSZsDcsjqYQQBT54CCHAmSexMe/Pa7y2SpRKoSbBlSZYzb9Qshexa5YsVCTE2ijhCgNcaItW60Pn++ImlfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-296db7e258dso170255a91.0;
        Tue, 06 Feb 2024 19:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707277441; x=1707882241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXYHBO/Sk9zqXtLS3+vl4Dw89XDk75azVHAu3XUaUas=;
        b=PWb84E250xFohyIyh8cCXXtOtutZSakG/RsJO54gojzqopKPXVlhwYYU2mwsjnu0G0
         cwEaoaJ1q8lE5S6ChckmM/+GzivLVvoH+lH2zK2oP5oxJHz9iqYJbNVZmgruyh9CuNtu
         uhgddOrbW+gTeuL7olJkTmao3LUIwGCT97qh/RFMkCHbHl76oyu7gkFpKPwgXnMgwq1d
         ZiCjHAbhTu+3pVHxJR4QnGcsufVNh5h6+XcmaVrJxzeh9xMQew5MpW4VTr2DvYXEwPeH
         O2e7OyxxPj2OnA9xlk/kvStNs8t2WOr29GtGO7+3t7kigoabMAWkCWMjeKYD98gngQNd
         YYfw==
X-Gm-Message-State: AOJu0Yynh7zeCdrTfM0hU69N9p5Ny7GQXfi554K+SJUpcEniy6rn/gC8
	i2VDtpfBkiTianGAjHxuFJtrQmow1L5HzIan7pAaSJ2U5bLmTVvXSitJwmArCsVUcAdfu/VrB48
	+Ss7QeVumc9QXQ+cU1TuCaAi4uLw=
X-Google-Smtp-Source: AGHT+IGEPIphPBJ3SG91ugAQu3jAc6gnya8eOCAXJm5wVKBb/y2U6JdG+iSfAZ+R+/o55W4i4WV555ctwvTj67vnkOs=
X-Received: by 2002:a17:90a:470e:b0:296:a76a:9711 with SMTP id
 h14-20020a17090a470e00b00296a76a9711mr2325191pjg.12.1707277440608; Tue, 06
 Feb 2024 19:44:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112231340.779469-1-namhyung@kernel.org>
In-Reply-To: <20240112231340.779469-1-namhyung@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Feb 2024 19:43:49 -0800
Message-ID: <CAM9d7chHZumJ5+KHex0hkp0JsL1phMPsA_qtaVnBZXyJus5NZg@mail.gmail.com>
Subject: Re: [PATCH] perf record: Display data size on pipe mode
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping!

On Fri, Jan 12, 2024 at 3:13=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Currently pipe mode doesn't set the file size and it results in a
> misleading message of 0 data size at the end.  Although it might miss
> some accounting for pipe header or more, just displaying the data size
> would reduce the possible confusion.
>
> Before:
>   $ perf record -o- perf test -w noploop | perf report -i- -q --percent-l=
imit=3D1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB - ]    <=3D=3D=3D=3D=3D=3D  =
(here)
>       99.58%  perf     perf                  [.] noploop
>
> After:
>   $ perf record -o- perf test -w noploop | perf report -i- -q --percent-l=
imit=3D1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.229 MB - ]
>       99.46%  perf     perf                  [.] noploop
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-record.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 91e6828c38cc..21ebcb04f1d8 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1773,8 +1773,11 @@ record__finish_output(struct record *rec)
>         struct perf_data *data =3D &rec->data;
>         int fd =3D perf_data__fd(data);
>
> -       if (data->is_pipe)
> +       if (data->is_pipe) {
> +               /* Just to display approx. size */
> +               data->file.size =3D rec->bytes_written;
>                 return;
> +       }
>
>         rec->session->header.data_size +=3D rec->bytes_written;
>         data->file.size =3D lseek(perf_data__fd(data), 0, SEEK_CUR);
> --
> 2.43.0.275.g3460e3d667-goog
>
>

