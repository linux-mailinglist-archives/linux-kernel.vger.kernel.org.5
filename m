Return-Path: <linux-kernel+bounces-124213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C9B8913F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355141F2214C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6714A3D3B8;
	Fri, 29 Mar 2024 06:55:51 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856933FB83;
	Fri, 29 Mar 2024 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711695351; cv=none; b=rYryU6s0g8QLHgT2/cX26dUzHQqMDR+gjQ4mvu4EKVUv2efERqG0CdMEFBnH3Br7kp3ypAy8yVKfCOUWRHKF/4K1fa+hJnTWzDpplUvMS1dnW7Gz+p5kC4p8kAthUDmMPdbp43GdTZW0FwnTKuHRb0hmQjXeuQ7u1hEoG72zo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711695351; c=relaxed/simple;
	bh=5v+e1aBwj1Iax9nn9BzV6TNm5YzcHJ/krkL5jhBxF20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8dtDqV8pKhqcqEZnfz2eOfM/i/790LJM1yp1SzYAedoCWpDHZ8FamLvqY57RP2j+ekgoaXK48Urg4jmJWyAmjufyNvifgSlKPMHgB/dgvUgZ6IClLeENsSsNADe2B3R4YD/nqlpP0KZtFcrHW/we652MweSq7eOiQ06M31XZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29f749b6667so1254436a91.0;
        Thu, 28 Mar 2024 23:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711695349; x=1712300149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kr3fxtN5qCjH963GzVf1dqapUpmOXojqbOSCe5HxI/o=;
        b=GPmtEj5VsE9hix+AxJDM+/Ka4iqXL73J9ZlxXCwCfmOJhBEvqDmUp7Ats6+UQCVCVi
         gsyv3O2sHd9ubOUxuEhXuO8VmndrQbXTSSlixpwcEdSdfeQvG6Vu8n7+ax8llxec2hVe
         cLLVGvaHQ3jmFJ41QiaBL/w6Buo/4vDc6FXfV5/esNVjWiF1K+ommxVwM3UL3nBxxfz7
         DzlxIyTLbr5cyc+kEMOEgRPEIFTqRYUq/P0Pd9oMaWi6u8hp1lDM9fWIs02iA1eDCcXy
         5OLTKKbSQQIzpfUGKNoS2VJocbYvBAHXpr8pTYE/b56f7hIiU1U0dEhpO7jbZG5mdWeU
         pIUw==
X-Forwarded-Encrypted: i=1; AJvYcCW8Gg6revrHrd1FDG+ExL2I4myDvhIJjjhF7H0c8s4CP7htTewpPrSrTySud1HwZqsbUpC7aSFEyQp4XeXRBg9AECaMEkuMw3m+pY9qfJtg5Yf41FEP4yFjRvr2TalCwXHRpLX3tQ+E+W2J1lp9zw==
X-Gm-Message-State: AOJu0YzPNFqbmOlGP9P5gvDS+5Oevy00KXWGauFnR454nxXKsasF4zA4
	1Aqn94ulcV67FvFMM4CzfMMCNAZTVHUMd6FeS7PQPVEwg8w70+7QfATnnj15XKU+W/ZLtU/tpui
	BcZqz3mq7QO0wepbymVrYIWwOxoo=
X-Google-Smtp-Source: AGHT+IHt5f0YB8zdQNiobO2B6By/ZTRlrQXUtoUBqDV68Y8QebF/S+aFCcJeJx6wvsSXVxgg7PSjdrD9HJcpBEyUkdQ=
X-Received: by 2002:a17:90a:6381:b0:29f:e772:61c3 with SMTP id
 f1-20020a17090a638100b0029fe77261c3mr1452828pjj.27.1711695348815; Thu, 28 Mar
 2024 23:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326202859.960577-1-weilin.wang@intel.com>
 <20240326202859.960577-2-weilin.wang@intel.com> <CAM9d7cjm6uOhffsiuVKk=2GBEUBZUyhNe-5QM5--tw3-X+UBJw@mail.gmail.com>
 <CO6PR11MB5635E6DE9643226FF76D08B3EE3A2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5635E6DE9643226FF76D08B3EE3A2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 28 Mar 2024 23:55:37 -0700
Message-ID: <CAM9d7chTRNS_fR-Qzo8egW4rBG9XFzZyKFWb-_LHygBypP6u9A@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/6] perf stat: Parse and find tpebs events when
 parsing metrics to prepare for perf record sampling
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:43=E2=80=AFPM Wang, Weilin <weilin.wang@intel.co=
m> wrote:
>
>
>
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Thursday, March 28, 2024 10:46 PM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > <mingo@redhat.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hun=
ter,
> > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>=
;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,=
 Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Bigge=
rs,
> > Caleb <caleb.biggers@intel.com>
> > Subject: Re: [RFC PATCH v5 1/6] perf stat: Parse and find tpebs events =
when
> > parsing metrics to prepare for perf record sampling
> >
> > On Tue, Mar 26, 2024 at 1:29=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > Metrics that use tpebs values would use the :retire_latency keyword i=
n
> > > formulas. We put all these events into a list and pass the list to pe=
rf
> > > record to collect their retire latency value.
> > >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > ---
> > [SNIP]
> > > @@ -681,8 +685,56 @@ static int metricgroup__build_event_string(struc=
t
> > strbuf *events,
> > >         hashmap__for_each_entry(ctx->ids, cur, bkt) {
> > >                 const char *sep, *rsep, *id =3D cur->pkey;
> > >                 enum perf_tool_event ev;
> > > +               /*
> > > +                * Parse and search for event name with retire_latenc=
y modifier.
> > > +                * If found, put event name into the tpebs_events lis=
t. This list
> > > +                * of events will be passed to perf record for sampli=
ng to get
> > > +                * their reitre_latency value.
> > > +                * Search for ":R" in event name without "@". Search =
for the
> > > +                * last "@R" in event name with "@".
> >
> > What is the retire_latency modifier exactly?
> > Why do you search for :R and @R?  What's the difference?
> > Why don't you search for "retire_latency"?
>
> We decided to use R as the modifier for retire_latency in one of the prev=
ious
> version of code review. Therefore, the code searches for R instead of "re=
tire_latency".
>
> It should search for :R in usual cases. But in hybrid platform, event nam=
e might be in
> format like cpu_core@event_name@R.

Ok, thanks for the explanation.  Please update the commit message and
the comment with this info.

Thanks,
Namhyung

