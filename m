Return-Path: <linux-kernel+bounces-39327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F29E883CECC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833A8B21963
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088D613AA22;
	Thu, 25 Jan 2024 21:45:02 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328E1350E8;
	Thu, 25 Jan 2024 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219101; cv=none; b=KXWJbbTAvw9hTRaWVdeEF4qNjoVZ31IIevYSokO+hPVEznugXeTqRjM8rfE1AozDeAL9pDtY/0Kd9BReuSPyYEx2ocxHUqmQdFbk+5DRVwJvkxo5GqSPzKuV0HotL8AG6KvQXQI8KKcYYCvSBdGcuxP9ThucUY9gCdAy8OCdob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219101; c=relaxed/simple;
	bh=9u4anSjlouTgw/2P/q/Jq3ADuTKVXo6TI+Vf4cQgPZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRXV7G/S7h62zqxmWAOohA1b0qsNZKi5yR3N/QcKZHdiwOMouek0ydegT/Z5p6XZxsaeX/e7/5FLCZcCIhWhFHN1So5A8cyTBw/ECJR3Spyjd5iXK1UdJBECY4l6S174xhmM47QjyEx4y4YlW9cm6YBZgMak+odivl18Mo4es0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29041136f73so4552a91.0;
        Thu, 25 Jan 2024 13:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706219099; x=1706823899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbmRSc7ZlDh5JTNaoRV6DZxWPyFidEzfmHZVG8JBRMc=;
        b=ez99wzURGVwz987S3LtCtJ39BWqxah4051tsR3D8LVNNpkZjn7kZ7XoZJnKtPChN0/
         xoSw0DNVI3QiPjavauCrOW+bXq3D4VoFDX6Jgsr4jDt/LTieKv6trL0tM5TcFwMSmM7J
         CRro7grk2OZyPK1W1WfEQYRCsUCNZHqQ0QHDGW690tR4oR1wG7LGG+HRKXyHiRTUgr/E
         +K21+mKbKeXg+WzlYzAn+LOlRs3QYUmFh7KpppHHdVx1EsN1dUA2Y2F/dXfEiPkVVYeY
         dlLIMupi9C4V1XtEfEgwevCM1/5ltj3M97M05K6y/vjgaP36rFmlAA9so53nrah4+5WN
         pi5w==
X-Gm-Message-State: AOJu0YwYQBM2aXy00xw+2abMmNjXKxVK9oioamzznS4LYVtJTnuVhNSA
	7Chr1YYYaaTDikJnnz7ClxofEap8E8wpyhZnyDALMlAJSxeR5sUyg6SUl+SNiSWnAAMmbOQfIIj
	UqzLC+LEH9nsiQ4r86FlUB/Zxohc=
X-Google-Smtp-Source: AGHT+IHCMp/MWj1+jPa5h7pSxHiBv8GYZGu1MfqAEy53tVm0nxahs2oEaKw2fR+PKHL7GJSDjgpewKxB0Ru0WSL8hhs=
X-Received: by 2002:a17:90b:3d90:b0:290:1cba:7ccc with SMTP id
 pq16-20020a17090b3d9000b002901cba7cccmr234706pjb.75.1706219099258; Thu, 25
 Jan 2024 13:44:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123185036.3461837-1-kan.liang@linux.intel.com>
 <CAP-5=fWuUJHUMb4mq2oPo+eVH32cLrrzYrKVuMymkkrYqMAYFw@mail.gmail.com> <CAM9d7chCdSSeoBnj2=suzou3udMRQ3XW_qYQe+oejHcO8y3PPQ@mail.gmail.com>
In-Reply-To: <CAM9d7chCdSSeoBnj2=suzou3udMRQ3XW_qYQe+oejHcO8y3PPQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 25 Jan 2024 13:44:48 -0800
Message-ID: <CAM9d7chRmZLLTKAPvANj4FButtxpK3H6iX7W35fOedG-tYMzZA@mail.gmail.com>
Subject: Re: [PATCH V4 0/7] Clean up perf mem
To: Ian Rogers <irogers@google.com>
Cc: kan.liang@linux.intel.com, acme@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com, 
	mike.leach@linaro.org, leo.yan@linaro.org, yuhaixin.yhx@linux.alibaba.com, 
	renyu.zj@linux.alibaba.com, tmricht@linux.ibm.com, ravi.bangoria@amd.com, 
	atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 9:24=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jan 24, 2024 at 10:24=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Tue, Jan 23, 2024 at 10:51=E2=80=AFAM <kan.liang@linux.intel.com> wr=
ote:
> > >
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > >
> > > Changes since V3:
> > > - Fix the powerPC building error (Kajol Jain)
> > > - The s390 does not support perf mem. Remove the code. (Thomas)
> > > - Add reviewed-by and tested-by from Kajol Jain for patch 1 and 2
> > > - Add tested-by from Leo
> > >
> > > Changes since V2:
> > > - Fix the Arm64 building error (Leo)
> > > - Add two new patches to clean up perf_mem_events__record_args()
> > >   and perf_pmus__num_mem_pmus() (Leo)
> > >
> > > Changes since V1:
> > > - Fix strcmp of PMU name checking (Ravi)
> > > - Fix "/," typo (Ian)
> > > - Rename several functions with perf_pmu__mem_events prefix. (Ian)
> > > - Fold the header removal patch into the patch where the cleanups mad=
e.
> > >   (Arnaldo)
> > > - Add reviewed-by and tested-by from Ian and Ravi
> > >
> > > As discussed in the below thread, the patch set is to clean up perf m=
em.
> > > https://lore.kernel.org/lkml/afefab15-cffc-4345-9cf4-c6a4128d4d9c@lin=
ux.intel.com/
> > >
> > > Introduce generic functions perf_mem_events__ptr(),
> > > perf_mem_events__name() ,and is_mem_loads_aux_event() to replace the
> > > ARCH specific ones.
> > > Simplify the perf_mem_event__supported().
> > >
> > > Only keeps the ARCH-specific perf_mem_events array in the correspondi=
ng
> > > mem-events.c for each ARCH.
> > >
> > > There is no functional change.
> > >
> > > The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power an=
d
> > > etc. But I can only test it on two Intel platforms.
> > > Please give it try, if you have machines with other ARCHs.
> > >
> > > Here are the test results:
> > > Intel hybrid machine:
> > >
> > > $perf mem record -e list
> > > ldlat-loads  : available
> > > ldlat-stores : available
> > >
> > > $perf mem record -e ldlat-loads -v --ldlat 50
> > > calling: record -e cpu_atom/mem-loads,ldlat=3D50/P -e cpu_core/mem-lo=
ads,ldlat=3D50/P
> > >
> > > $perf mem record -v
> > > calling: record -e cpu_atom/mem-loads,ldlat=3D30/P -e cpu_atom/mem-st=
ores/P -e cpu_core/mem-loads,ldlat=3D30/P -e cpu_core/mem-stores/P
> > >
> > > $perf mem record -t store -v
> > > calling: record -e cpu_atom/mem-stores/P -e cpu_core/mem-stores/P
> > >
> > >
> > > Intel SPR:
> > > $perf mem record -e list
> > > ldlat-loads  : available
> > > ldlat-stores : available
> > >
> > > $perf mem record -e ldlat-loads -v --ldlat 50
> > > calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=3D50/}:P
> > >
> > > $perf mem record -v
> > > calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=3D30/}:P -=
e cpu/mem-stores/P
> > >
> > > $perf mem record -t store -v
> > > calling: record -e cpu/mem-stores/P
> > >
> > > Kan Liang (7):
> > >   perf mem: Add mem_events into the supported perf_pmu
> > >   perf mem: Clean up perf_mem_events__ptr()
> > >   perf mem: Clean up perf_mem_events__name()
> > >   perf mem: Clean up perf_mem_event__supported()
> > >   perf mem: Clean up is_mem_loads_aux_event()
> > >   perf mem: Clean up perf_mem_events__record_args()
> > >   perf mem: Clean up perf_pmus__num_mem_pmus()
> >
> > I think this is ready to land in perf-tools-next, multiple Tested-by
> > or Reviewed-by.
>
> Sure, queued for a local testing.

Applied to perf-tools-next, thanks!

Namhyung

