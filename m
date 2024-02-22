Return-Path: <linux-kernel+bounces-76918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7720F85FE95
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBA32828B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2541154437;
	Thu, 22 Feb 2024 17:02:29 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45688155308;
	Thu, 22 Feb 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621348; cv=none; b=DdpBZ/6B7DbP00rQ8YtP4AsXVn3vC4q9qU7y1V9H64XaUApKTfJOe9RPZEb3RqqzMj8yD4ZSX6AGbY+mYnI0rAvGjwbYEsqNYor3RGlM+cp8diR3UbEFH9dZhr5nPDuF5I8bgq0OVUAHYcfzVgO64/fVajaYSQySbnfbJRoz+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621348; c=relaxed/simple;
	bh=o2z62yIkjV+//Puh8dbCXY7hYl26G7rkj5+/iE/jb38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZFFPSJikqm8HvM0JgMgSvPKHZtnTjxumggVcIRtD6wfqQbROWaHKm2MXIK0kLxXB6d3MawRGwjiEQ0w0udUDWbYf0vrqoIf1UmfFcHLMrtZELd6F6Fkug+wR0j1DSgf8M5l+kHKFJ+qzCC2JB5xnwcNUIy5Op1h+Ztb9dnNOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d934c8f8f7so75771255ad.2;
        Thu, 22 Feb 2024 09:02:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708621336; x=1709226136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fbb24HI7mwnQHPbFmcorW8M6W1udgr86FpNgr1pAX8g=;
        b=a08VLnpcRAtYrzxdfTxVBHyGJs12bqsc5GigEI4/3Kgsc0JCp0UYZ+9ATRq1tjSDK2
         Oc5nK1/4ipxni8BveRhKjD0+w3c6bmpO3liqxk7oGRN14oPvNsZMuV4FP/NKtTgK9Jvk
         5A7JdoUsCEsXbVUZvpG91M2wRtKbd8jRyTph0JptxuyQRMCF6nRt9Ygb6SJrApdjXmzz
         6YeJjISoR6INsIkMHRhMUxTGu2W/PXGNoYki/p9cFc4g/AeTqIJ+AdOhUxMYRtzNSBNQ
         k7h6zWjqTbKDZArRbUbMGcednB0f72ZWf9tBoHaG5zEbRs49ofzQhYHtEPGc2SxZ0jPj
         zA3g==
X-Forwarded-Encrypted: i=1; AJvYcCXc0PZlR7ztUUAEnhT/F5AX4/C7KQQPb7nraYuM6wqZ62Yay9Tgw9xUl5nvp2kZFHUOGuxgnOHMgJdj+b6ThXUcehz7cXwpRqFKOHYTTzvpFKf+0vJx/qQXJ/JUOGbmV7f2ZT3C0bj2pRCFeIxB0A==
X-Gm-Message-State: AOJu0YwkUG7vey/RaphInatUGcVZja/KFYQaEMU9gskpck0PhekHf+7I
	61TAts49pGe9S4nmwNYh+e3PY4KDZul4GLys/LuT1VZUPp09KhpsfAZvdrziyHNq2yC2N9fU5MC
	L3lQiqmHFCn9YfaEPxjo4xpOrS2E=
X-Google-Smtp-Source: AGHT+IHYXCG6IOXf5XV2s2UWgsjmMaTvB0nmyPHwa3sjr4YhsdqIJOztejAmg68niMfDbOQaYHVUmH07AFwpiDMW4MM=
X-Received: by 2002:a17:90a:3486:b0:299:398e:5cee with SMTP id
 p6-20020a17090a348600b00299398e5ceemr14241027pjb.13.1708621336292; Thu, 22
 Feb 2024 09:02:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126145605.1005472-1-mark.rutland@arm.com> <CAP-5=fURS0OQxHcukS1+NprgyMpAQSr3+BMiYPj5x7=+tcZ8hw@mail.gmail.com>
In-Reply-To: <CAP-5=fURS0OQxHcukS1+NprgyMpAQSr3+BMiYPj5x7=+tcZ8hw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 22 Feb 2024 09:02:04 -0800
Message-ID: <CAM9d7cj=tN8ACGFMmkdL_RE5R-4SCd8Zg3trJ15TvOJKpcXABQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf print-events: make is_event_supported() more robust
To: marcan@marcan.st, maz@kernel.org
Cc: Ian Rogers <irogers@google.com>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org, acme@redhat.com, james.clark@arm.com, 
	john.g.garry@oracle.com, leo.yan@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	mike.leach@linaro.org, suzuki.poulose@arm.com, tmricht@linux.ibm.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hector and Marc, can you please take a look?

Thanks,
Namhyung


On Wed, Feb 21, 2024 at 12:19=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Fri, Jan 26, 2024 at 6:56=E2=80=AFAM Mark Rutland <mark.rutland@arm.co=
m> wrote:
> >
> > Currently the perf tool doesn't detect support for extended event types
> > on Apple M1/M2 systems, and will not auto-expand plain PERF_EVENT_TYPE
> > hardware events into per-PMU events. This is due to the detection of
> > extended event types not handling mandatory filters required by the
> > M1/M2 PMU driver.
> >
> > PMU drivers and the core perf_events code can require that
> > perf_event_attr::exclude_* filters are configured in a specific way and
> > may reject certain configurations of filters, for example:
> >
> > (a) Many PMUs lack support for any event filtering, and require all
> >     perf_event_attr::exclude_* bits to be clear. This includes Alpha's
> >     CPU PMU, and ARM CPU PMUs prior to the introduction of PMUv2 in
> >     ARMv7,
> >
> > (b) When /proc/sys/kernel/perf_event_paranoid >=3D 2, the perf core
> >     requires that perf_event_attr::exclude_kernel is set.
> >
> > (c) The Apple M1/M2 PMU requires that perf_event_attr::exclude_guest is
> >     set as the hardware PMU does not count while a guest is running (bu=
t
> >     might be extended in future to do so).
> >
> > In is_event_supported(), we try to account for cases (a) and (b), first
> > attempting to open an event without any filters, and if this fails,
> > retrying with perf_event_attr::exclude_kernel set. We do not account fo=
r
> > case (c), or any other filters that drivers could theoretically require
> > to be set.
> >
> > Thus is_event_supported() will fail to detect support for any events
> > targeting an Apple M1/M2 PMU, even where events would be supported with
> > perf_event_attr:::exclude_guest set.
> >
> > Since commit:
> >
> >   82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU number i=
n perf_event_attr.type")
> >
> > ... we use is_event_supported() to detect support for extended types,
> > with the PMU ID encoded into the perf_event_attr::type. As above, on an
> > Apple M1/M2 system this will always fail to detect that the event is
> > supported, and consequently we fail to detect support for extended type=
s
> > even when these are supported, as they have been since commit:
> >
> >   5c816728651ae425 ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capabil=
ity")
> >
> > Due to this, the perf tool will not automatically expand plain
> > PERF_TYPE_HARDWARE events into per-PMU events, even when all the
> > necessary kernel support is present.
> >
> > This patch updates is_event_supported() to additionally try opening
> > events with perf_event_attr::exclude_guest set, allowing support for
> > events to be detected on Apple M1/M2 systems. I believe that this is
> > sufficient for all contemporary CPU PMU drivers, though in future it ma=
y
> > be necessary to check for other combinations of filter bits.
> >
> > I've deliberately changed the check to not expect a specific error code
> > for missing filters, as today ;the kernel may return a number of
> > different error codes for missing filters (e.g. -EACCESS, -EINVAL, or
> > -EOPNOTSUPP) depending on why and where the filter configuration is
> > rejected, and retrying for any error is more robust.
> >
> > Note that this does not remove the need for commit:
> >
> >   a24d9d9dc096fc0d ("perf parse-events: Make legacy events lower priori=
ty than sysfs/JSON")
> >
> > ... which is still necessary so that named-pmu/event/ events work on
> > kernels without extended type support, even if the event name happens t=
o
> > be the same as a PERF_EVENT_TYPE_HARDWARE event (e.g. as is the case fo=
r
> > the M1/M2 PMU's 'cycles' and 'instructions' events).
> >
> > Fixes: 82fe2e45cdb00de4 ("perf pmus: Check if we can encode the PMU num=
ber in perf_event_attr.type")
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Tested-by: Ian Rogers <irogers@google.com>
> > Tested-by: James Clark <james.clark@arm.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Hector Martin <marcan@marcan.st>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@arm.com>
> > Cc: John Garry <john.g.garry@oracle.com>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Thomas Richter <tmricht@linux.ibm.com>
> > Cc: Will Deacon <will@kernel.org>
>
> Ping. Could we land this one?
>
> Thanks,
> Ian
>
> > ---
> >  tools/perf/util/print-events.c | 27 +++++++++++++++++++--------
> >  1 file changed, 19 insertions(+), 8 deletions(-)
> >
> > Since v1 [1]:
> > * Fix typos in commit message
> > * Accumulate tags
> >
> > [1] https://lore.kernel.org/lkml/20240116170348.463479-1-mark.rutland@a=
rm.com/
> >
> > Mark.
> >
> > diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-eve=
nts.c
> > index b0fc48be623f3..4f67e8f00a4d6 100644
> > --- a/tools/perf/util/print-events.c
> > +++ b/tools/perf/util/print-events.c
> > @@ -232,7 +232,6 @@ void print_sdt_events(const struct print_callbacks =
*print_cb, void *print_state)
> >  bool is_event_supported(u8 type, u64 config)
> >  {
> >         bool ret =3D true;
> > -       int open_return;
> >         struct evsel *evsel;
> >         struct perf_event_attr attr =3D {
> >                 .type =3D type,
> > @@ -246,20 +245,32 @@ bool is_event_supported(u8 type, u64 config)
> >
> >         evsel =3D evsel__new(&attr);
> >         if (evsel) {
> > -               open_return =3D evsel__open(evsel, NULL, tmap);
> > -               ret =3D open_return >=3D 0;
> > +               ret =3D evsel__open(evsel, NULL, tmap) >=3D 0;
> >
> > -               if (open_return =3D=3D -EACCES) {
> > +               if (!ret) {
> >                         /*
> > -                        * This happens if the paranoid value
> > +                        * The event may fail to open if the paranoid v=
alue
> >                          * /proc/sys/kernel/perf_event_paranoid is set =
to 2
> > -                        * Re-run with exclude_kernel set; we don't do =
that
> > -                        * by default as some ARM machines do not suppo=
rt it.
> > -                        *
> > +                        * Re-run with exclude_kernel set; we don't do =
that by
> > +                        * default as some ARM machines do not support =
it.
> >                          */
> >                         evsel->core.attr.exclude_kernel =3D 1;
> >                         ret =3D evsel__open(evsel, NULL, tmap) >=3D 0;
> >                 }
> > +
> > +               if (!ret) {
> > +                       /*
> > +                        * The event may fail to open if the PMU requir=
es
> > +                        * exclude_guest to be set (e.g. as the Apple M=
1 PMU
> > +                        * requires).
> > +                        * Re-run with exclude_guest set; we don't do t=
hat by
> > +                        * default as it's equally legitimate for anoth=
er PMU
> > +                        * driver to require that exclude_guest is clea=
r.
> > +                        */
> > +                       evsel->core.attr.exclude_guest =3D 1;
> > +                       ret =3D evsel__open(evsel, NULL, tmap) >=3D 0;
> > +               }
> > +
> >                 evsel__delete(evsel);
> >         }
> >
> > --
> > 2.30.2
> >

