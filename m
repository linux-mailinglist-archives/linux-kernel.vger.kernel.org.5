Return-Path: <linux-kernel+bounces-96369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81A2875B35
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11B31C212DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0848787;
	Thu,  7 Mar 2024 23:47:15 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD3B3D3BB;
	Thu,  7 Mar 2024 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709855234; cv=none; b=lfiASgz6KUnuDKrlC5vy117d7dIUjhNmh7M4pKRmbpNKbk85ZcUfZcYkDaar8ogiaCSP2NP4iapvu/X7aRIUQ5tnxTFhjRRBuXcKnbTy5uJUSS25lhMmPMEsfdjjTL57PsUK12v0iDTN12Io3sMWw89ONODr2P06ow3px5hTIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709855234; c=relaxed/simple;
	bh=hiSn8SSIe9tegeKwF4wqEjbTESubvyzdJG8DyIQ2F5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeYUKyWAssq/PH17TdZoh610PnCZest8s0i99wfSuBm3p0IF6PglRQsPT4CTI8jzxO3Hw8b7Bl4OTQ5FjS8TSGME7hC7c890ZrGrKgepz2BsfxOY7oMHS6j2IX3HTPpFm+ojg0I1WPaxVl3QPPjbBFPyJNO9/tbaefNh2gqcu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6da202aa138so1038511b3a.2;
        Thu, 07 Mar 2024 15:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709855232; x=1710460032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRglE+lg+GiCjlWhoic2nCJGJlQoZ9wZneASUD21CRs=;
        b=TgFBz6bhZ/32RivFypCTKygjGuZ3oo+p25WazFc9QsblTtfbxKUjzIIPoFRgQDikhi
         /yvPFHCbI1ux8+ClRWPazLDAIZ+HYKghgx+Tomev8Lr2i+XM7rNbHC+i/FrdDL4gAokM
         XF42pZSvOM3cu4DhahKFJMWzceckE9m0dSvdKqQ5Wf11i7s7UVS5CgHwHG/NnA+PSPiU
         GN8C60vLg36Wmalz1iI5Mup8/i8Kpwuagf3xRMxfA2YAsF0kjMxxKVEg4ASQVrrGklhM
         RMpmNoOsuX0iP5LTyT27kweljyNc1a+PTlomOBGHxiMcCgtdUg6ttuLD+LAVtxjLxJnF
         ++Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWQzlVVNnr2G02vgUU/+wX8NFr8sp6S5eov9mq95qpWjysgdmpVWEYcZieOhtllCahMMMM+tYwNKW87vJwuEv4hbns2hyDEOi3cnDCuV15Ob1xfyeo94k2tlbKnZXKYkWK11EuVDskzSK+/DcnQGcws8kFoU2RnSsXsTAvDqB7YYszP3A==
X-Gm-Message-State: AOJu0YwXAWCRmyJyYyaWA3cqooshjpUvhHNSBNsX3R0KOri3NqPhpDn9
	AAOLJDfk4GsEP3QX3Yu1xLaUwF7JOA42b4sbJC+8a2t/auBT+czGpPyld383ieP9c3mbUcA9Ml/
	mUxIEl8cVFyukok36zxlJQck4njo=
X-Google-Smtp-Source: AGHT+IGjnH5Y4f8Xc68LPqBs4yQPZ4Urn7qyiy5Tf+SuqPL2hThvfF428reoLcncH5TvvcXLda4DiyJCHhDBIBQxWys=
X-Received: by 2002:a05:6a20:a99a:b0:1a0:e187:87c4 with SMTP id
 cc26-20020a056a20a99a00b001a0e18787c4mr8978541pzb.38.1709855232461; Thu, 07
 Mar 2024 15:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com> <CAP-5=fVjAHqAHHLqE=3v2bP6S6k98psiuZds7TUTFCT7RgMFdQ@mail.gmail.com>
 <CAM9d7ciPYMd4zckrcgnPtradZ_bvaNOHji1tkkYQu_TTF5=eYw@mail.gmail.com>
In-Reply-To: <CAM9d7ciPYMd4zckrcgnPtradZ_bvaNOHji1tkkYQu_TTF5=eYw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 7 Mar 2024 15:47:00 -0800
Message-ID: <CAM9d7cgbxHZoaq4ZLCda-6TW5A+b+-8dSrRApk+AjcTVNC5hNA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Clean up libperf cpumap's empty function
To: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Kan Liang <kan.liang@linux.intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Atish Patra <atishp@rivosinc.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Changbin Du <changbin.du@huawei.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Paran Lee <p4ranlee@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	Leo Yan <leo.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

Sorry for the late reply.

On Fri, Feb 16, 2024 at 5:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Feb 14, 2024 at 2:03=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Fri, Feb 2, 2024 at 3:41=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > Rename and clean up the use of libperf CPU map functions particularly
> > > focussing on perf_cpu_map__empty that may return true for maps
> > > containing CPUs but also with an "any CPU"/dummy value.
> > >
> > > perf_cpu_map__nr is also troubling in that iterating an empty CPU map
> > > will yield the "any CPU"/dummy value. Reduce the appearance of some
> > > calls to this by using the perf_cpu_map__for_each_cpu macro.
> > >
> > > v3: Address handling of "any" is arm-spe/cs-etm patch.
> > > v2: 6 patches were merged by Arnaldo. New patch added ensure empty
> > >     maps are allocated as NULL (suggested by James Clark). Hopefully =
a
> > >     fix to "perf arm-spe/cs-etm: Directly iterate CPU maps".
> > >
> > > Ian Rogers (8):
> > >   libperf cpumap: Add any, empty and min helpers
> > >   libperf cpumap: Ensure empty cpumap is NULL from alloc
> > >   perf arm-spe/cs-etm: Directly iterate CPU maps
> > >   perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_emp=
ty
> > >     use
> > >   perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
> > >   perf arm64 header: Remove unnecessary CPU map get and put
> > >   perf stat: Remove duplicate cpus_map_matched function
> > >   perf cpumap: Use perf_cpu_map__for_each_cpu when possible
> >
> > Ping. Thanks,
> > Ian
>
> Adrian and James, are you ok with this now?

I think James is fine now and the Intel-pt part seems straight-forward
so I'd like to merge this change.  Please tell me if you have any concerns.

Thanks,
Namhyung

