Return-Path: <linux-kernel+bounces-15106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F6B822749
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F304284C0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB3446B7;
	Wed,  3 Jan 2024 02:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuldBrQE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FD84A14
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so7139a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 18:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704250755; x=1704855555; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCq1Lfb8MiGC7Na0tk2+xuLDB2WWLfolpfiM5LugPs0=;
        b=LuldBrQE2Rmx6pPs9YcvJNagTFVOPGbbDVUAE4RkBxO3t+FfIMdO9Dgu3xn/iavF4A
         kzsOTl4/ekYcWXG6cwc7JGAi1VyXINluwAapM1rBEyRkEN3lzE7mWFtQe0LOQuQi4d4r
         rD5q51XPkGEbep0q5eEAIGSgTSNXMXpIyAE6M4TOI/v3F9xBuQO3ja1DzK7yab3HTs9D
         YBU6xaPR5MvVZ6kwSKfHZ16tyNQS0tBojF4fsUEyrBkd1HBOWYHCvWgwEzaYJ0ufWqQN
         RrReWrQo7R30D2ML6cH4k0vL3gJRkWiFlFXX0Or1U/vVnLlTNxKoPgMPO3TlZ7KXOTYD
         Quqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704250755; x=1704855555;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCq1Lfb8MiGC7Na0tk2+xuLDB2WWLfolpfiM5LugPs0=;
        b=mSJZJghZD/NrWFK9UkCx5uqad7VagC+d3Ae3+t20yj1/EfRE45EiUYM0aD2oTt8M6G
         X5K9zpvkhXAknBXd4qd8C/yPsl0NS9oIjq28NHB2Nmvl9b1YP6VER47Q/RtsU1tse/O/
         f6VAuDmwKS+y/RSpGcfgna81K0aSfny9uOMInTVx7R5HoJ3gfdQroPrzuZPzVFLqg4Q2
         Y5QQRFtEL/lsHyPDbzWUj+LS2j3VYsZAN7ogNDmUQgpUkaTlySBgLRLVxW7dtD2TzI9M
         A7QVD4klb9EAzhr8kA+tesBhLgXsUoRhL5lX6YKqHSYLomh469BczOaNkwfTXzoLC1JU
         gW6Q==
X-Gm-Message-State: AOJu0YxEnRcfYaFlpBuOmBTH+YeM2NEZHcRe6gnsdJc5MRBC+lpMJlda
	feQESWo8QycCmvlyFWHIBwVE/ChOMwrtEPtuNu5miFCDpVtv
X-Google-Smtp-Source: AGHT+IHoREibGnYniTB05gP+Ptytz72pRY8BioD0lJCU/ju3PsY3jfGNtDuaQyvnSB6buBlsCSN/MexnFlRKt4BgKN8=
X-Received: by 2002:a50:9e6c:0:b0:554:53d0:23f1 with SMTP id
 z99-20020a509e6c000000b0055453d023f1mr79550ede.0.1704250754578; Tue, 02 Jan
 2024 18:59:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207021627.1322884-1-irogers@google.com>
In-Reply-To: <20231207021627.1322884-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Jan 2024 18:59:03 -0800
Message-ID: <CAP-5=fVfddHzk_pUramFdUKACDw_buHAFt_B0y1VLY6yn9G72A@mail.gmail.com>
Subject: Re: [PATCH v1] perf record: Reduce memory for recording lost samples event
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 6:16=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Reduce from PERF_SAMPLE_MAX_SIZE to "sizeof(*lost) +
> session->machines.host.id_hdr_size".
>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
> Suggested in:
> https://lore.kernel.org/lkml/CAM9d7cjpYHN_Q63sW70vTCisdW=3D-SzjsrryUUJjgt=
Z3+9jdxfA@mail.gmail.com/
> ---
>  tools/perf/builtin-record.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index eb5a398ddb1d..206110fc2799 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1954,7 +1954,8 @@ static void record__read_lost_samples(struct record=
 *rec)
>
>                                 if (count.lost) {
>                                         if (!lost) {
> -                                               lost =3D zalloc(PERF_SAMP=
LE_MAX_SIZE);
> +                                               lost =3D zalloc(sizeof(*l=
ost) +
> +                                                             session->ma=
chines.host.id_hdr_size);
>                                                 if (!lost) {
>                                                         pr_debug("Memory =
allocation failed\n");
>                                                         return;
> @@ -1970,7 +1971,8 @@ static void record__read_lost_samples(struct record=
 *rec)
>                 lost_count =3D perf_bpf_filter__lost_count(evsel);
>                 if (lost_count) {
>                         if (!lost) {
> -                               lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
> +                               lost =3D zalloc(sizeof(*lost) +
> +                                             session->machines.host.id_h=
dr_size);
>                                 if (!lost) {
>                                         pr_debug("Memory allocation faile=
d\n");
>                                         return;
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>

