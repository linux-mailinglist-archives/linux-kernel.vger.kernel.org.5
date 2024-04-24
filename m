Return-Path: <linux-kernel+bounces-157557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0FC8B12D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BC61F25B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517AE1AACA;
	Wed, 24 Apr 2024 18:49:53 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A8179BF;
	Wed, 24 Apr 2024 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984592; cv=none; b=KWyof0badTgyVxuBmJB5l46Pe0eg3WGyVo94Xo84hjSl1jhKrt00ZT0fX/KHlVj47VR3wl7mMo0pXKyRBAsuE6TNbAg396kkF4PDers9lr7b3Tv25qhetohgsHZEJHH6CinZIQp1QVfNylQWfT19mPuaIfab/ZO98S3SHe6u89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984592; c=relaxed/simple;
	bh=Se3HNVOOvek+2e5idqqauLlkJtRHfOv4B49/Rn+eoU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5i3foWig1D+kbGjgMfmSIBBaxQ1TCjOeKR8sYY6VvmnfE+BRkgco2vdRsFxuRNggywsVTsi9raxXuzJZibatjmTqIkUdaHs4CQkziBEn3xucZr7ERKCgJDUYMY4kSoFs0LyUF1GhuN3YW9raJby0nuAXSTiME1f42SGEKgaPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ac16b59fbeso219172a91.2;
        Wed, 24 Apr 2024 11:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713984591; x=1714589391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5QHrMtqSSrREwVmCam6Iu7SXQsyGFb2T7UApJWOjbw=;
        b=hdXH+6eRUWqt4S9ZJUJMi/JmSGYxOzDrlimpE48aDqmTCxmWI6D1YeOP0idz69wa/t
         2c9TW23/XFhLoSx3CDX0Q8r3pXpUaRAEhghWc0sglIpWseCWgk/USR5baiw87knNRNIX
         wBhe/FdurgN6FhYq4O41hR10AtUBbetuQEbYB5rfN2lq0NZ0IFYhhBo1FsEzko61L7xw
         DQwxrcXkeBWgmrMv4PXTWOV5F1Rjq5leGh7e7FlBcswwYYknYGbaf5ceIldtiewMpl/Q
         Tz7Im/LsGUz4ONrrvu9FeckkETymj2WAs2IAyCCB3U+62qZxyBc9EOoGES3biGnbTZfv
         VMFA==
X-Forwarded-Encrypted: i=1; AJvYcCVyV+Nh2lP7GiRAetY6a6IWA+RNc3eZrgAzX8RkufPq0kfiLGFGSFIcSJbNBnm0iI1lEZBZxFOlWRJB1grzNDMlhPNc+bbTd9S4rSBaZtainGN0CgWc9S84tRJ1fqoFIIwmG6XlPwYGVzMH3AZqAw==
X-Gm-Message-State: AOJu0YwO7uggvEA5aDPmusmscPvMObOjz6F3ftaUDlF4jRj+pRwzYSyC
	Gro5O95SMZAtFzRQnrjmwq10F9D1Y7+zMrrXIdgfg3/HIPQOwCwHQwrQ0yXs9nJfvqTcFys9LbE
	CPMoq6UjfyNH3VMeeNoOb3XzfN+c=
X-Google-Smtp-Source: AGHT+IGUPIxzbhLum73eJDckTInNE2O3Vkpmo9myMEHjCG92+nRSZMDJmM9DCtsBpAZy6F+UUl84ZirRayifOWVh8b4=
X-Received: by 2002:a17:90a:4585:b0:2ad:e004:76e6 with SMTP id
 v5-20020a17090a458500b002ade00476e6mr2986780pjg.7.1713984590588; Wed, 24 Apr
 2024 11:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191224.1046866-1-weilin.wang@intel.com>
 <20240329191224.1046866-3-weilin.wang@intel.com> <CAM9d7cjBfTM2bjkrvN5XWcXJ=OyBOU06fBN=+eWnDSdP2dkD4A@mail.gmail.com>
 <CO6PR11MB56351C2AB4BE15C5371E29C2EE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjORNS9h7v6p2fg8OXsZMpeBODzTSCQNZ5zAea-baFKNQ@mail.gmail.com>
 <CO6PR11MB5635C7D8C91FEDA17EC4BCDEEE112@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7chSCQViX=VjgqdVn5un0J5MpGsGDGncUyY-K4=oPvvfQA@mail.gmail.com> <CO6PR11MB56359754A01778EA3EA53981EE102@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB56359754A01778EA3EA53981EE102@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 24 Apr 2024 11:49:38 -0700
Message-ID: <CAM9d7cj2Zmd_FMBzf=H6K6jRmYLYuR6mpcyhC0_neTvur0=pyw@mail.gmail.com>
Subject: Re: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
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

On Wed, Apr 24, 2024 at 10:08=E2=80=AFAM Wang, Weilin <weilin.wang@intel.co=
m> wrote:
>
>
>
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Tuesday, April 23, 2024 4:06 PM
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
> > Subject: Re: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record =
when
> > perf stat needs to get retire latency value for a metric.
> >
> > On Tue, Apr 23, 2024 at 3:16=E2=80=AFPM Wang, Weilin <weilin.wang@intel=
com>
> > wrote:
> > > > > > > -static int __run_perf_record(void)
> > > > > > > +static int __run_perf_record(const char **record_argv)
> > > > > > >  {
> > > > > > > +       int i =3D 0;
> > > > > > > +       struct tpebs_event *e;
> > > > > > > +
> > > > > > >         pr_debug("Prepare perf record for retire_latency\n");
> > > > > > > +
> > > > > > > +       record_argv[i++] =3D "perf";
> > > > > > > +       record_argv[i++] =3D "record";
> > > > > > > +       record_argv[i++] =3D "-W";
> > > > > > > +       record_argv[i++] =3D "--synth=3Dno";
> > > > > > > +
> > > > > > > +       if (stat_config.user_requested_cpu_list) {
> > > > > > > +               record_argv[i++] =3D "-C";
> > > > > > > +               record_argv[i++] =3D stat_config.user_request=
ed_cpu_list;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       if (stat_config.system_wide)
> > > > > > > +               record_argv[i++] =3D "-a";
> > > > > > > +
> > > > > > > +       if (!stat_config.system_wide
> > > > && !stat_config.user_requested_cpu_list)
> > > > > > {
> > > > > > > +               pr_err("Require -a or -C option to run sampli=
ng.\n");
> > > > > > > +               return -ECANCELED;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       list_for_each_entry(e, &stat_config.tpebs_events, nd)=
 {
> > > > > > > +               record_argv[i++] =3D "-e";
> > > > > > > +               record_argv[i++] =3D e->name;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       record_argv[i++] =3D "-o";
> > > > > > > +       record_argv[i++] =3D PERF_DATA;
> > > > > > > +
> > > > > > >         return 0;
> > > > > > >  }
> > > > > >
> > > > > > Still I think it's weird it has 'perf record' in perf stat (des=
pite the
> > > > > > 'perf stat record').  If it's only Intel thing and we don't hav=
e a plan
> > > > > > to do the same on other arches, we can move it to the arch
> > > > > > directory and keep the perf stat code simple.
> > > > >
> > > > > I'm not sure what is the proper way to solve this. And Ian mentio=
ned
> > > > > that put code in arch directory could potentially cause other bug=
s.
> > > > > So I'm wondering if we could keep this code here for now. I could=
 work
> > > > > on it later if we found it's better to be in arch directory.
> > > >
> > > > Maybe somewhere in the util/ and keep the main code minimal.
> > > > IIUC it's only for very recent (or upcoming?) Intel CPUs and we
> > > > don't have tests (hopefully can run on other arch/CPUs).
> > > >
> > > > So I don't think having it here would help fixing potential bugs.
> > >
> > > Do you mean by creating a new file in util/ to hold this code?
> >
> > Yeah, maybe util/intel-tpebs.c (if it's better than arch/x86/...) ?
> >
> > >
> > > Yes, this feature is for very recent Intel CPUs. It should only be tr=
iggered if
> > > a metric uses event(s) that has the R modifier in the formula.
> >
> > Can we have a test with a fake metric so that we can test
> > the code on non-(or old-)Intel machines?
>
> All the existing metrics in non-(or old-)Intel CPUs should work as usual.=
 So I think
> existing metric tests should work for it.
>
> If we want to add a fake metric uses the :R modifier for those platforms,=
 the metric
> should either fail (if the fake metric uses an event not exist on the tes=
t platform) or
> return all 0 retire latency data.
>
> So, I'm not quite sure what we want the fake metric to test for. Maybe we=
 could
> continue using existing metric tests to ensure all the defined metrics wo=
rk correctly
> in each machine under test?

I think it's ok to return all 0 retire latency for fake tPEBS metrics.
It's just to verify the background record + report logic works ok.

Thanks,
Namhyung

