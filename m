Return-Path: <linux-kernel+bounces-79446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B93E862258
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A9F1F2475E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F01111A0;
	Sat, 24 Feb 2024 02:45:22 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B113AE9;
	Sat, 24 Feb 2024 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708742718; cv=none; b=IM6vRWt9XaGq98Kw+zLLVkWVPDoxNiSgMPYP+bdAKozOcVWQ0zwPsB83ugMd1wxl4clc9tDe41U84blM+z6nOBsGoimZc9q5mgMQR36NDOG3DNq1wAaY6213jEoy2UHSkWukzjcS2v3nyMV1LX8dsRfOqlvh5u9+7qNS8kOuJVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708742718; c=relaxed/simple;
	bh=tkQEf05oq2kmii+ClsY92Oy+mus+/9mjeSBNHOROiwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHbz/vljEzcOEpEzUlRpZH3oU2KFtmDZagBcV/dwf+IbqwIVPuNYqmiYqDCogcOwS1c1PZ4k60Xz9/8dE4sfRmDgp2iZuiyRizk0z6oWN8IbBnz6ruiAnS4FU56KNnQYcdQkXJ6DG5+Uql1rI4vW4KhCuXJIeOklTzyUc4z80Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2995fa850ddso712637a91.0;
        Fri, 23 Feb 2024 18:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708742706; x=1709347506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPPv8r1RSsDRM/zfoDy7ZupsBXVuitqH/rRRBSdP66M=;
        b=cNekbBS/dpwTLfeP9nBHN6gNpak+307Fe9YkpOoXw3tJR6yNM4op8kDdfTBneOK4Lc
         ekNu1PCc7whro2zJGVIP7VCsvj/XcbjBGvyCmY7ZgoMRdbur7S0q/e7k+L1xdviL7dqr
         tCI05kquDiJVPfMI6u+Hwk/mDtUoDZADA78/cUgVl8MRv7kd8PCSbB2YIhRgGQsYG15Q
         xIQxtfoDFxbYTkkIJZ4bBJp4T5UpC0STjbbY9VeI0fFA6WG1PH8ZLDakvu8PR+VIEVdc
         B9Fs6y9sbRnkmN3nYdi+JM92oyHr2EnEhQP01TIMFHqLh6JQnl/Smyj+oXxjN29p6Y0g
         pEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtWyaOQ5X5DHwP20CiA4fQ4qOzk4rvRNnLhG0PKETYRPJ7IISTYmiLgvJ/kz1KLyvJ2XJFGDIzH7p5DfMmdn2+ireorQM2c6sa4VRY73a7fmGxZizuHQcdmlhC65625Y9bc8tCuOD8UdZJ7gldjw==
X-Gm-Message-State: AOJu0YyXqduRP2LXpIXFL5mGSDQEI8HxZUoknt9lNqv/KZb4R1i2PUE8
	+GhDSyypmzj4i6pKRW/3n3sN8WCBuz5Q1CdGa58lO1WTa3KuQ+m9qNU9H2ULCUCahEjOIevgjxb
	aTZSYOGOUUfn73KGh7ILvp2k11ao=
X-Google-Smtp-Source: AGHT+IFR/f3udUFSXOTvTpD+RswtOEM5KE3C5Ak2h+Y+7fUTo0ahihL6PLsWilwsOPmnpeeRyGDSNst8cMjrPmTxeUY=
X-Received: by 2002:a17:90a:5b07:b0:29a:89db:7581 with SMTP id
 o7-20020a17090a5b0700b0029a89db7581mr1985562pji.13.1708742705745; Fri, 23 Feb
 2024 18:45:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221072100.412939-1-weilin.wang@intel.com>
 <20240221072100.412939-3-weilin.wang@intel.com> <ZdY4a5yx-C9ziobq@x1>
 <CAP-5=fU5JVki4OCYvYyPoBLguwHSwXripiO3Gq+MddV9ZWfnTQ@mail.gmail.com>
 <CAM9d7ch3E=hNbX6=xUHZ+B_Dphy_sALzaCki1he3-O00DAoYXg@mail.gmail.com> <CAP-5=fWf4YxOZUmuZsUt9na=CpXL-eLkd9d6OvtsgJkONC1gzQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWf4YxOZUmuZsUt9na=CpXL-eLkd9d6OvtsgJkONC1gzQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 23 Feb 2024 18:44:54 -0800
Message-ID: <CAM9d7chwXoBjkEb7itS84UUDzbARETvU7w4d0Mni4vbGHURFxA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, weilin.wang@intel.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:48=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Feb 22, 2024 at 11:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > Hi,
> >
> > On Wed, Feb 21, 2024 at 12:34=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > > Weilin raised the TPEBS problem in the LPC 2023 talk, the issue being
> > > that sampling and counting don't really exist in the current perf too=
l
> > > code at the same time. BPF could be a workaround but permissions are
> > > an issue. Perhaps leader sampling but then what to do if two latencie=
s
> > > are needed. Forking perf to do this is an expedient and ideally we'd
> > > not do it.
> >
> > Even with BPF, I think it needs two instances of an event - one for
> > counting and the other for sampling, right?  I wonder if it can just
> > use a single event for sampling and show the sum of periods in
> > PERF_SAMPLE_READ.
> >
> > I'm not sure if an event group can have sampling and non-sampling
> > events at the same time.  But it can be done without groups then.
> > Anyway what's the issue with two latencies?
>
> The latencies come from samples and with leader sampling only the
> leader gets sampled so we can't get two latencies. For 2 latencies
> we'd need 2 groups for 2 leaders or to modify leader sampling

Do those 2 latencies come from 2 events or a single event?

But I realized that PERF_SAMPLE_READ would return the period
only and I guess the latency is in PERF_SAMPLE_WEIGHT(_STRUCT), right?
Then it won't work with PERF_SAMPLE_READ unless we extend the
read format to include the weights.

> - if we
> could encode that we want to sample but don't need the sample in the
> mmap, just want the latency being available to be read, etc. This and
> BPF are both long-term viable solutions, but forking is the expedient
> solution to get something going - we'd likely want it as a fallback
> anyway.

Maybe we can add it to the read format, but I'm not sure how the
kernel maintains the value.  PERF_SAMPLE_READ would be fine
to return the value in the sample.  But it should support read(2) too.

Simply adding the values might not be what users want.  Maybe
average latency/weight is meaningful but it could depend on
what the event measures..

Thanks,
Namhyung

