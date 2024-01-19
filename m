Return-Path: <linux-kernel+bounces-31602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1B383309F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2752728347B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025B758AB8;
	Fri, 19 Jan 2024 22:06:26 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B7537EE;
	Fri, 19 Jan 2024 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705701985; cv=none; b=AiJShDfbUkhVqSpotRR6lT/bKBv0jrf7ysXk8Q6BVjgHvcfYgMm3A5FL7rCejB4iRAG0TVM7tAs9rFJpjfNO89N+R9YjAYNosTSCEdMYtJzlNb/2o+h76JBuIR24dube2kh3z3doNVt9cyg9QcK8PCJcmE2tn9jQz3ohPrpr9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705701985; c=relaxed/simple;
	bh=zhaVfEhWynwbx7C9lDCvozKetdFXiOTJKUY5TMI0l54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOBq1DNcPCQRfZzcYct6Qc0qDgSptOheHZW4HTGHoUdICLiAujTMvnzUOSCkqTh1FS7cNywVrDK7u/FiZGd3lDGSEO1TwvfgjRJixf+k3R4jdMeHKy8vp468Wl/CRhM5ihXb3vRywlA9At7g/aJI/R4G/60M50H6W01mhca7Few=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cdfed46372so1177088a12.3;
        Fri, 19 Jan 2024 14:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705701984; x=1706306784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLiBau14xJmw6pibIF0iVnHj1duiVItI9rclo/jaOto=;
        b=Hl/r23SHkxpdiMuW4lm1IRFUpDESDriaikc5ekGAtvu9MCBj3/MMYTFhG0YigPVqLH
         zq8eeBq4FZxbjsNRPUAazgmFrtIS7O2HGanWpb13rovayfmKGXJtQF+mbgwxP2flU+l4
         gs2t+IJaDQavxtglrOnuOlZ47GtYLHMaY9VI4Ca8o0z50kriVxIlmhCOas4ssels6uCz
         i2NcZmyhH09OW2ud39VrIyeAQVpZBuO+4eRX7qNUQzwbBADP+Nnxa8r0B/SsR8hfOHrV
         36iQS2iml7YvIn29YtaP6RHdUK2GpGXZs1sIXYUJIGLFttGC2fVZ95CUeMXPPyh5duA+
         mJsw==
X-Gm-Message-State: AOJu0Yxg0/A+c6jPA2Y/NFO9SP5SUMzLiAHn4AFw6xAXRC6c3SDc7cXT
	W+aGyoVARgCJL5Ayx1mdhfqFjXnWrVw+a2k5J+cH7pUBB7/01dmzppELjdytj5M1tddLkn1aAc8
	Ttro/KOkiYce/1ITJ4wP1JlRls0Q=
X-Google-Smtp-Source: AGHT+IHaLWSOypnk8Bq3sMJzz8IOvtOQOu2TfZa97jph0NydtDD21Zq5X193ApaLI6YHkc1CIS+FISEp4Sw/EptNfSc=
X-Received: by 2002:a05:6a21:9217:b0:19a:f684:cbc4 with SMTP id
 tl23-20020a056a21921700b0019af684cbc4mr489615pzb.104.1705701983718; Fri, 19
 Jan 2024 14:06:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119040304.3708522-1-yangjihong1@huawei.com>
In-Reply-To: <20240119040304.3708522-1-yangjihong1@huawei.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 19 Jan 2024 14:06:12 -0800
Message-ID: <CAM9d7chheMq=J1kHCTD+2Vxh=iKA5Toe=DyWmvRRX_E6xdXNKA@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf record: Fix segfault with '--timestamp-filename'
 option and pipe mode
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 18, 2024 at 8:07=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> When perf record uses '--timestamp-filename' option and pipe mode,
> will occur segfault:
>
>   # perf record --timestamp-filename -o- true 1>/dev/null
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Dump -.2024011813361681 ]
>   perf: Segmentation fault
>   Segmentation fault (core dumped)
>
> Debug the core file by using the gdb:
>
>   # gdb perf core.3706841
>   <SNIP>
>   [New LWP 3706841]
>   [Thread debugging using libthread_db enabled]
>   Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.=
1".
>   Core was generated by `perf record --timestamp-filename -o- true'.
>   Program terminated with signal SIGSEGV, Segmentation fault.
>   #0  evsel__free_stat_priv (evsel=3D0x555ea56197af) at util/stat.c:145
>   145             struct perf_stat_evsel *ps =3D evsel->stats;
>   (gdb) bt
>   #0  evsel__free_stat_priv (evsel=3D0x555ea56197af) at util/stat.c:145
>   #1  evlist__free_stats (evlist=3Devlist@entry=3D0x555bf0dad1b0) at util=
/stat.c:215
>   #2  0x0000555befd425e8 in evlist__delete (evlist=3D0x555bf0dad1b0) at u=
til/evlist.c:175
>   #3  0x0000555befd42785 in evlist__delete (evlist=3D<optimized out>) at =
util/evlist.c:181
>   #4  0x0000555befc7f547 in cmd_record (argc=3D<optimized out>, argv=3D<o=
ptimized out>) at builtin-record.c:4252
>   #5  0x0000555befd27700 in run_builtin (p=3Dp@entry=3D0x555bf05acf88 <co=
mmands+264>, argc=3Dargc@entry=3D4, argv=3Dargv@entry=3D0x7ffc2696a920) at =
perf.c:349
>   #6  0x0000555befc68751 in handle_internal_command (argv=3D0x7ffc2696a92=
0, argc=3D4) at perf.c:402
>   #7  run_argv (argv=3D<synthetic pointer>, argcp=3D<synthetic pointer>) =
at perf.c:446
>   #8  main (argc=3D4, argv=3D0x7ffc2696a920) at perf.c:562
>
> It is found that the memory of the evsel is modified.
> The reason is that perf_data__switch() not initialized 'new_filename',
> as a result, it uses the on-stack variable. It happens that the evsel
> address is stored here. 'new_filename' is freed later when uses
> '--timestamp-filename' option. Therefore, segfault occurs in the evsel_de=
lete().
>
>
> 1. patch1 fixes this problem.
> 2. patch2 to optimize the process, check conflict between
>    '--timestamp-filename' option and the pipe mode before recording to
>    avoid switch perf data.
> 3. patch3 fixes the code style problem by the way.
>
>
> Yang Jihong (3):
>   perf record: Fix possible incorrect free in record__switch_output()
>   perf record: Check conflict between '--timestamp-filename' option and
>     pipe mode before recording
>   perf data: Minor code style alignment cleanup

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/builtin-record.c | 14 ++++++++++----
>  tools/perf/util/data.c      | 10 ++++------
>  tools/perf/util/data.h      |  6 +++---
>  3 files changed, 17 insertions(+), 13 deletions(-)
>
> --
> 2.34.1
>

