Return-Path: <linux-kernel+bounces-37976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E206D83B90E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802791F2560D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EB0D533;
	Thu, 25 Jan 2024 05:24:25 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC41381;
	Thu, 25 Jan 2024 05:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706160264; cv=none; b=sOW5RBBUletqhQz9J6OqPlE/xnOZCMFAtWz+Yz/OfKQBqTQDIaIL8DUi7Pl3Yg8FW4W0Xb7sltb1zJ/yk0zCgb6e2PjTjiBPbafygpVFWRfmIlB+GokkVszRzlrPiC3D6//hqKcXLXxZod2dK9iuPaoNkMwFPPNU5a+rkuX4Wrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706160264; c=relaxed/simple;
	bh=4NYXGRZOaDdDc+tbFNq0jWf2RH1PbPOSU0nGQPJoLOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pigyA3LcePsUNlzeqU8S/BJQv6C3fqDDmi/xEzb9/V7bFW0oiuhknSvzDE6Ne66iWCOrgY5lSqmVjsyUmpElrsiSE6WV19Y59HrGUhrQeof0GUlx+Yq5NLKj34mFPSxqd8cMUc51W+4/6bcZ8Mb/t95uafg79FpRIvHGAH/Owxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6db599d5cb8so5151824b3a.0;
        Wed, 24 Jan 2024 21:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706160263; x=1706765063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8Z7SFkDyIDkq/bR5bk4BWXOPD5loSRpNrPh9YRa0n4=;
        b=ubj1WdEadCbID7244JT73bWGHxhj1/cUoYuP9/x0gJhlq4ULaB7KMV8c1RcUNrphmR
         UxTb4KjVJ5Z2M9dpAfmBXqViXmtEZzJ3DOa4FsoGmiGs1Sf02qlHA/y2LLE9iYGPipjR
         VyHRgpkmW9pKkvo6NgeJiX7UvrufUPGE5kV8SHxt/vSnEgeYTWMcWAYSWW5N6wVgBsP6
         NWbry/VE1rfds8KOzy4V8Eky8kuCshDF5uYP+Q6qtT00ZM0sX7QuMg0l7ws6vkDlVyRR
         3vsubdZSSU74Vgbl7BDupqH19OO6VopB5LTXEx7j5ex7Gf9RIoOr4tLNzwc8Ykf8cSa0
         qfyA==
X-Gm-Message-State: AOJu0YwgUleKe8m9sfXZjEulekWV8M3z26wYM/Dl8Y4yXxr10Cr9FV7l
	N8KmufiiY6262DcXRUCwZemFKz2nBhK51v8lqIUV5eijcnzrcrnzEgf9dQb8tr1Qkpc13wxC52j
	VOTQ7y554lCPPxCdBG7k/9e+BD1o=
X-Google-Smtp-Source: AGHT+IH98NpfGBC+6cuW4zul7cRHUe+rxmPA3mTeRoPWBpxdY+EZcYNlsVGdXodaE/5GvXagmaP9RWc8PX1+wcbwS3A=
X-Received: by 2002:a05:6a00:198b:b0:6dd:8211:9ff0 with SMTP id
 d11-20020a056a00198b00b006dd82119ff0mr244480pfl.18.1706160262557; Wed, 24 Jan
 2024 21:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123185036.3461837-1-kan.liang@linux.intel.com> <CAP-5=fWuUJHUMb4mq2oPo+eVH32cLrrzYrKVuMymkkrYqMAYFw@mail.gmail.com>
In-Reply-To: <CAP-5=fWuUJHUMb4mq2oPo+eVH32cLrrzYrKVuMymkkrYqMAYFw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 24 Jan 2024 21:24:11 -0800
Message-ID: <CAM9d7chCdSSeoBnj2=suzou3udMRQ3XW_qYQe+oejHcO8y3PPQ@mail.gmail.com>
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

On Wed, Jan 24, 2024 at 10:24=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Tue, Jan 23, 2024 at 10:51=E2=80=AFAM <kan.liang@linux.intel.com> wrot=
e:
> >
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > Changes since V3:
> > - Fix the powerPC building error (Kajol Jain)
> > - The s390 does not support perf mem. Remove the code. (Thomas)
> > - Add reviewed-by and tested-by from Kajol Jain for patch 1 and 2
> > - Add tested-by from Leo
> >
> > Changes since V2:
> > - Fix the Arm64 building error (Leo)
> > - Add two new patches to clean up perf_mem_events__record_args()
> >   and perf_pmus__num_mem_pmus() (Leo)
> >
> > Changes since V1:
> > - Fix strcmp of PMU name checking (Ravi)
> > - Fix "/," typo (Ian)
> > - Rename several functions with perf_pmu__mem_events prefix. (Ian)
> > - Fold the header removal patch into the patch where the cleanups made.
> >   (Arnaldo)
> > - Add reviewed-by and tested-by from Ian and Ravi
> >
> > As discussed in the below thread, the patch set is to clean up perf mem=
.
> > https://lore.kernel.org/lkml/afefab15-cffc-4345-9cf4-c6a4128d4d9c@linux=
intel.com/
> >
> > Introduce generic functions perf_mem_events__ptr(),
> > perf_mem_events__name() ,and is_mem_loads_aux_event() to replace the
> > ARCH specific ones.
> > Simplify the perf_mem_event__supported().
> >
> > Only keeps the ARCH-specific perf_mem_events array in the corresponding
> > mem-events.c for each ARCH.
> >
> > There is no functional change.
> >
> > The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
> > etc. But I can only test it on two Intel platforms.
> > Please give it try, if you have machines with other ARCHs.
> >
> > Here are the test results:
> > Intel hybrid machine:
> >
> > $perf mem record -e list
> > ldlat-loads  : available
> > ldlat-stores : available
> >
> > $perf mem record -e ldlat-loads -v --ldlat 50
> > calling: record -e cpu_atom/mem-loads,ldlat=3D50/P -e cpu_core/mem-load=
s,ldlat=3D50/P
> >
> > $perf mem record -v
> > calling: record -e cpu_atom/mem-loads,ldlat=3D30/P -e cpu_atom/mem-stor=
es/P -e cpu_core/mem-loads,ldlat=3D30/P -e cpu_core/mem-stores/P
> >
> > $perf mem record -t store -v
> > calling: record -e cpu_atom/mem-stores/P -e cpu_core/mem-stores/P
> >
> >
> > Intel SPR:
> > $perf mem record -e list
> > ldlat-loads  : available
> > ldlat-stores : available
> >
> > $perf mem record -e ldlat-loads -v --ldlat 50
> > calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=3D50/}:P
> >
> > $perf mem record -v
> > calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=3D30/}:P -e =
cpu/mem-stores/P
> >
> > $perf mem record -t store -v
> > calling: record -e cpu/mem-stores/P
> >
> > Kan Liang (7):
> >   perf mem: Add mem_events into the supported perf_pmu
> >   perf mem: Clean up perf_mem_events__ptr()
> >   perf mem: Clean up perf_mem_events__name()
> >   perf mem: Clean up perf_mem_event__supported()
> >   perf mem: Clean up is_mem_loads_aux_event()
> >   perf mem: Clean up perf_mem_events__record_args()
> >   perf mem: Clean up perf_pmus__num_mem_pmus()
>
> I think this is ready to land in perf-tools-next, multiple Tested-by
> or Reviewed-by.

Sure, queued for a local testing.

Thanks,
Namhyung

