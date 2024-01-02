Return-Path: <linux-kernel+bounces-14774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DB6822203
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514641C22A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CE216403;
	Tue,  2 Jan 2024 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uksCHxKr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34016402
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so1999a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 11:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704223852; x=1704828652; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOYTEsOV9lTiIGnRFctHuQqBGe69F0YWFLoKuRVOe74=;
        b=uksCHxKr0hZihpngARh1CH39gUTfHNLhA4cbu5pGAfdRlQqU4beXtPy9gSEeGjS35I
         RzZAqTsu8/ByiZkB6jhpRU2Z6skD4DyBOmTiVCGR9ToKLrx5c/0kMPB0Lb25quxQJNFp
         XBTeUrvtxBcdINpVJJI7GUSFjV12mNo9SrGG7k7h6YWNLZ96F1wq6g/o3rCAoV/0fBz1
         LuALXzMaqO4EpEU70TEU1tFC61bI5ScUymGikTJA5hwcvpSo/6w4C9TPntx3sjYqQcc+
         sxApoy12sGA7jRisdYbQSRiKXiljlYLffmyQe2cHXw3VHUv7HETIaQ1NZUXi855DZFhK
         dOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704223852; x=1704828652;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOYTEsOV9lTiIGnRFctHuQqBGe69F0YWFLoKuRVOe74=;
        b=oS/tXwbyPUq1dziYU5qv6KdkUqFV2zXXlzHasIu0uQ6RFmyA8j2u/2j+MLV2G/Nfma
         3RoQbtOaObwLarC9/BOyup2VjTFvtvvAjbSoBaWDANcncPN+3xwSjFKyVFv3x052JiGq
         RRnEgLBV4GWoHVx2Ak5xY3sr0nurJHZ9VEvOnf6hUA9usVZZBr4F/UUDTUKCZy7N6zGF
         Mt4/m6ztiNvxEDk3hpipobkj50u2Uait0CE7yln42vh/9I+ZjqHxcbgSPC5sI8yi5Efu
         dWnhV5jXw0ptvrq0XJT/WjokTr6T6XvRwtLSAJ993mP27+AC8mcrfn1tFNQ6HYUqDFxu
         qZfw==
X-Gm-Message-State: AOJu0YyFAR+YwD0SlfuX9yaJbufPmWk5gR5TDoLLR0cKVSiS8OeRo+Tf
	Dqg1Ch9qk8ImYr/IHgQHnKn0fqWd141L1Iu3JsGipJlplRIe
X-Google-Smtp-Source: AGHT+IFxkEp53qfdvKXchSLSayawO65q7whtBRhMEQhKEn3q2M+ar5ghgojFLixiM/BGo5c47KunMgRuv1alQVvLjgY=
X-Received: by 2002:a50:8d4e:0:b0:554:98aa:f75c with SMTP id
 t14-20020a508d4e000000b0055498aaf75cmr2425edt.5.1704223852224; Tue, 02 Jan
 2024 11:30:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208000515.1693746-1-irogers@google.com>
In-Reply-To: <20231208000515.1693746-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Jan 2024 11:30:39 -0800
Message-ID: <CAP-5=fVQfqS6gu9Ua3Exijc_ZaBzrt2=1PMopgdoyC_6R_cnaQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] lib subcmd: Fix memory leak in uniq
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Chenyuan Mi <cymi20@fudan.edu.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 4:05=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> uniq will write one command name over another causing the overwritten
> string to be leaked. Fix by doing a pass that removes duplicates and a
> second that removes the holes.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping for this series, no comments since sent.

Thanks,
Ian

> ---
>  tools/lib/subcmd/help.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index adfbae27dc36..8561b0f01a24 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -52,11 +52,21 @@ void uniq(struct cmdnames *cmds)
>         if (!cmds->cnt)
>                 return;
>
> -       for (i =3D j =3D 1; i < cmds->cnt; i++)
> -               if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
> -                       cmds->names[j++] =3D cmds->names[i];
> -
> +       for (i =3D 1; i < cmds->cnt; i++) {
> +               if (!strcmp(cmds->names[i]->name, cmds->names[i-1]->name)=
)
> +                       zfree(&cmds->names[i - 1]);
> +       }
> +       for (i =3D 0, j =3D 0; i < cmds->cnt; i++) {
> +               if (cmds->names[i]) {
> +                       if (i =3D=3D j)
> +                               j++;
> +                       else
> +                               cmds->names[j++] =3D cmds->names[i];
> +               }
> +       }
>         cmds->cnt =3D j;
> +       while (j < i)
> +               cmds->names[j++] =3D NULL;
>  }
>
>  void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
> --
> 2.43.0.472.g3155946c3a-goog
>

