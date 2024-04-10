Return-Path: <linux-kernel+bounces-139141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3EE89FF06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E806B239BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2E1A38CC;
	Wed, 10 Apr 2024 17:45:15 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977481802A1;
	Wed, 10 Apr 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771115; cv=none; b=L7DHqllPBAtMxv8n/4AYFuIFELPzNX+vkZqPNdaN5e0AgUiDz2EsZkMRlb8R4HHQ/yLFWBbh0RHc7pPkPSYc/Nk0BbdXmFxL8oPa6TMPBeX9zJLoowzR4bkrlKGEL+CAk7Zu+vHvEbgXLKLBvght3cjcnRtSn1Qr7mrLeoti5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771115; c=relaxed/simple;
	bh=Wj6ZRvlrOSDMBt6W7n9IjAZ7AZ//hA1fkrsJS10CLKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fi0xT0i61XOVV/0xLK41tH/g6Pk1jb/WZaMtPB0PSaA+Qi4FnkIuQ8hmSkUwhSOQYlTmlJUYbIMRCxPDxzLvsos6R17WgnRVqzCfDT/nktN9I/0Tz7CEPdZzBasV7sks8wwnbKNuXPkYHr6GoJak574SLcLw5JjQxpBfkfy/PbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so63023a12.0;
        Wed, 10 Apr 2024 10:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771113; x=1713375913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6yLmtZ0A7ipNhWm4F0IrALVPTgUBnQRDTiWvpPH58w=;
        b=dqyQZVpHdH23KwIqFXX4O4Uvu9Q2boFA6jOYHfDl0o+ib0YsuILdwZrAzU4vib5PB0
         bAWSuO54bJojiUPHyKgjjdpPUrh1IJkJqaAfckI4N6lM9+7RBp9ytxyE7YlY1+f/TOqW
         cfstgQxzfuB2oyHEmAOaZFY6aVu4x/cZY/SgWTsVaTQvBzcdjEJICPRyqmzN7HbeTzm1
         pwOFEBCZOJfJD7Akq6n6nfTUevOVP0EtxZd63y1/Or23ByG3JHe3b9Pk+aqPiGeUzPsu
         hqPnib0qKjkCZlZZEDmppmJsFIVYSwHtanKO00hhlKEHjlxgsdVpml5a8ZpH678b9qVL
         +o5w==
X-Forwarded-Encrypted: i=1; AJvYcCUrSlTfa+kf8JhIGKRrTnnb+rHNtdPBKL8ZbSTBrxqTQqBKZNAq+f7ObcxGhZZ/in9Y4+67/QjmCaYBJ1OpdFodhs8Eke5wzMVuloOHgNczJxDjx+lLbxa/IzQLUn6Kfdg9tuMvbhLPO0r7WRd3rw==
X-Gm-Message-State: AOJu0YySWQCu09y2nvKNuK0VcGj0+CXQDclC1mD2aX/ywFxdFQVPUa5d
	EOlv2NWj2gaHbQIQMC4OCvUuEDlFrHpdMKltnD6mOzKmP2gwdRqVIuVN744S460t28E9ut0yMWC
	rkpYf87T/ximnfGlQ+Wn0OreKoSk=
X-Google-Smtp-Source: AGHT+IGR5Q/4Md6XRPDFOZYZCA29OSHEwciU9ZcwjlSpvOPYr1vpBgVJGEcgGhvz5WXiumG4zrUPoZKHzxQHmQg+fC8=
X-Received: by 2002:a17:90a:7281:b0:2a0:78f4:2dc5 with SMTP id
 e1-20020a17090a728100b002a078f42dc5mr415791pjg.22.1712771112758; Wed, 10 Apr
 2024 10:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410104450.15602-1-adrian.hunter@intel.com> <CAP-5=fXw+HEnyiry=6LWhpPcexbNu=CzknNfcjr=MHa78ujkpw@mail.gmail.com>
In-Reply-To: <CAP-5=fXw+HEnyiry=6LWhpPcexbNu=CzknNfcjr=MHa78ujkpw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 10 Apr 2024 10:45:00 -0700
Message-ID: <CAM9d7cg54QYtyOO0986ffBFU2yV49RV7OgTmX5drRAqV84aKSQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Simplify is_event_supported()
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 9:08=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Apr 10, 2024 at 3:45=E2=80=AFAM Adrian Hunter <adrian.hunter@inte=
l.com> wrote:
> >
> > Simplify is_event_supported by using sys_perf_event_open() directly lik=
e
> > other perf API probe functions and move it into perf_api_probe.c where
> > other perf API probe functions reside.
> >
> > A side effect is that the probed events do not appear when debug prints
> > are enabled, which is beneficial because otherwise they can be confused
> > with selected events.
> >
> > This also affects "Test per-thread recording" in
> > "Miscellaneous Intel PT testing" which expects the debug prints of
> > only selected events to appear between the debug prints:
> > "perf record opening and mmapping events" and
> > "perf record done opening and mmapping events"
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>
> nit:
> Closes: https://lore.kernel.org/lkml/ZhVfc5jYLarnGzKa@x1/
>
> > ---
> >  tools/perf/util/perf_api_probe.c | 40 +++++++++++++++++++++++++
> >  tools/perf/util/perf_api_probe.h |  2 ++
> >  tools/perf/util/pmus.c           |  1 +
> >  tools/perf/util/print-events.c   | 50 +-------------------------------
> >  tools/perf/util/print-events.h   |  1 -
> >  5 files changed, 44 insertions(+), 50 deletions(-)
> >
> > diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_ap=
i_probe.c
> > index 1de3b69cdf4a..13acb34a4e1c 100644
> > --- a/tools/perf/util/perf_api_probe.c
> > +++ b/tools/perf/util/perf_api_probe.c
> > @@ -195,3 +195,43 @@ bool perf_can_record_cgroup(void)
> >  {
> >         return perf_probe_api(perf_probe_cgroup);
> >  }
> > +
> > +bool is_event_supported(u8 type, u64 config)
> > +{
> > +       struct perf_event_attr attr =3D {
> > +               .type =3D type,
> > +               .config =3D config,
> > +               .disabled =3D 1,
> > +       };
> > +       int fd =3D sys_perf_event_open(&attr, 0, -1, -1, 0);
>
> It looks like this is a change to the actual perf_event_open
> arguments, I don't think it is an issue but wanted to flag it.
>
> > +
> > +       if (fd < 0) {
> > +               /*
> > +                * The event may fail to open if the paranoid value
> > +                * /proc/sys/kernel/perf_event_paranoid is set to 2
> > +                * Re-run with exclude_kernel set; we don't do that by
> > +                * default as some ARM machines do not support it.
> > +                */
> > +               attr.exclude_kernel =3D 1;
>
> I worry about the duplicated fallback logic getting out of sync,
> perhaps we could have a quiet option for evsel__open option, or better
> delineate the particular log entries. I don't really have a good
> alternative idea and kind of like that detecting an event is available
> loses the evsel baggage. I would kind of like event parsing just to
> give 1 or more perf_event_attr for similar reasons.

We have the missing feature check in the evsel open code,
and I think we should check the exclude-bits first than others.
Currently struct pmu has missing_features.exclude_guest only
and it can have exclude_kernel or others too.

Anyway, I'm ok with this change.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

