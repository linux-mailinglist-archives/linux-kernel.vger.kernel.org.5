Return-Path: <linux-kernel+bounces-15794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F396282331B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6E0283DF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D31C28C;
	Wed,  3 Jan 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="maFgg1n4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33A1C684
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e36375f91so3344e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 09:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704302250; x=1704907050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj+6ZIcdIJ4IWRtCOCmWj2sb63LnZ9xV+ocSQBdeiHw=;
        b=maFgg1n4Mrt3a0LFATnLkcw+/HyP8e9SsLMLn/FZhkB6tmnyKLpEsTWXM12xcQZ2g2
         Ay0N1Y8jQ82PR6cLOME13GGAPWKmvwxti8VRXL9PQmfOSHx+CEntxvWY9Goa06lXcmrp
         Rv7HTLAFhP2+jlV2JY6RtZPnvm5hODuiRV+4TiOWoFVsZ6q0btb8WnqjW0BghsO/WEgc
         ZzCmg7qqxhPK2mPkycbdTWi7vk3R30xNur274X4ibgCQYhemGNg/89+kIePcmckwc/Di
         +xqmcoa8uDDS4ZQz5kidY/v+n905bkf2iUk5C9xylYS9V3izLCZTx1RaobNS/c3/EjnQ
         8CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704302250; x=1704907050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lj+6ZIcdIJ4IWRtCOCmWj2sb63LnZ9xV+ocSQBdeiHw=;
        b=t3NJsAIMF1aFEbxz9HJOjou4fTbqCEHd3BLGHxRzcjGoH1Ixy+GXVxuYAoRyiaKq/J
         VcOO//+TqWPNKGidx7AmUJbWwLfvv3MpTWTGCTtTahCxmTT6p/hPnaagwvYifx1KfKxH
         byyWQ/mgUucLTgyADM1htodug0xBjANjRmri+hRcGxxx5bnM4vvsuPiV1609DsMKMd4I
         VtuQ0VCpeGlt29BVyC5oNIrkkfUBqPGMJbDy8DX2Va5jq770gByt8TC1WQA3Wel5avJq
         CBmHKfutS6pbP+WK9zcXS64xxoRmoznlcrbkB51l2g3libEnWwZj7NOED1tkjg80dPwp
         T4mg==
X-Gm-Message-State: AOJu0YwivFJId0YHHLIX+rtih4Q7agnIxW0xQIQMRfRB3YUC1sn1ycfX
	54GnOrp43Z3PMixZSkvONWTPeKH71ybhueRIpAzykwbpvk0I
X-Google-Smtp-Source: AGHT+IEvfIlTVLtGp0WB7PS5eSCN5k938gSOy/iEKUjfYYWUyQRW+OHmRVbHe8PNitQQfwlzqPOptrvEERMPiT0dOfE=
X-Received: by 2002:a05:6512:1326:b0:50e:7be0:3abd with SMTP id
 x38-20020a056512132600b0050e7be03abdmr116593lfu.6.1704302249646; Wed, 03 Jan
 2024 09:17:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102215732.1125997-1-irogers@google.com> <ZZWOdHXJJ_oecWwm@kernel.org>
In-Reply-To: <ZZWOdHXJJ_oecWwm@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jan 2024 09:17:18 -0800
Message-ID: <CAP-5=fWP-bb_Uv+Ev1URg6jGfXFRWG19OqEmbo3VKwe4dRreSA@mail.gmail.com>
Subject: Re: [PATCH v1] perf x86 test: Update hybrid expectations
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 8:42=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Tue, Jan 02, 2024 at 01:57:32PM -0800, Ian Rogers escreveu:
> > The legacy events cpu-cycles and instructions have sysfs event
> > equivalents on x86 (see /sys/devices/cpu_core/events). As sysfs/JSON
> > events are now higher in priority than legacy events this causes the
> > hybrid test expectations not to be met. To fix this switch to legacy
> > events that don't have sysfs versions, namely cpu-cycles becomes
> > cycles and instructions becomes branches.
> >
> > Fixes: a24d9d9dc096 ("perf parse-events: Make legacy events lower prior=
ity than sysfs/JSON")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> With it:
>
> root@number:/home/acme# perf test hybrid
>  71: Intel PT                                                        :
>  71.2: Intel PT hybrid CPU compatibility                             : Ok
>  75: x86 hybrid                                                      : Ok
> root@number:/home/acme#
>
> Applied.
>
> Now to look at this on this hybrid system (14700K):
>
> 101: perf all metricgroups test                                      : FA=
ILED!
>
> Testing Mem
> event syntax error: '{cpu_core/UNC_ARB_DAT_OCCUPANCY.RD,cmask=3D1,metric-=
id=3Dcpu_core!3UNC_ARB_DAT_OCCUPANCY.RD!0cmask!21!3/,UNC_ARB_DAT_OCCUPANCY.=
RD/metric-id=3DUNC_ARB_DAT_OCCUPANCY.RD/}:W,du..'
>                                \___ Bad event or PMU
>
> Unable to find PMU or event on a PMU of 'cpu_core'
>
> Initial error:
> event syntax error: '{cpu_core/UNC_ARB_DAT_OCCUPANCY.RD,cmask=3D1,metric-=
id=3Dcpu_core!3UNC_ARB_DAT_OCCUPANCY.RD!0cmask!21!3/,UNC_ARB_DAT_OCCUPANCY.=
RD/metric-id=3DUNC_ARB_DAT_OCCUPANCY.RD/}:W,du..'
>                                \___ unknown term 'UNC_ARB_DAT_OCCUPANCY.R=
D' for pmu 'cpu_core'
>
> valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,con=
fig,config1,config2,config3,name,period,percore,metric-id
> test child finished with -1
> ---- end ----
> perf all metricgroups test: FAILED!
> root@number:/home/acme# grep -m1 "model name" /proc/cpuinfo
> model name      : Intel(R) Core(TM) i7-14700K
> root@number:/home/acme#
>
>
> root@number:/home/acme# ls -la /sys/devices/uncore_
> uncore_arb_0/              uncore_cbox_1/             uncore_cbox_2/     =
        uncore_cbox_5/             uncore_cbox_8/             uncore_imc_0/=
              uncore_imc_free_running_1/
> uncore_arb_1/              uncore_cbox_10/            uncore_cbox_3/     =
        uncore_cbox_6/             uncore_cbox_9/             uncore_imc_1/
> uncore_cbox_0/             uncore_cbox_11/            uncore_cbox_4/     =
        uncore_cbox_7/             uncore_clock/              uncore_imc_fr=
ee_running_0/
> root@number:/home/acme# ls -la /sys/devices/uncore_
>
>
> 102: perf all metrics test                                           : FA=
ILED!
>
> event syntax error: '{cpu_core/UNC_ARB_DAT_OCCUPANCY.RD,cmask=3D1,metric-=
id=3Dcpu..'
>                                \___ Bad event or PMU
>
> Unable to find PMU or event on a PMU of 'cpu_core'
>
> Initial error:
> event syntax error: '{cpu_core/UNC_ARB_DAT_OCCUPANCY.RD,cmask=3D1,metric-=
id=3Dcpu..'
>                                \___ unknown term 'UNC_ARB_DAT_OCCUPANCY.R=
D' for pmu 'cpu_core'
>
> valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,con=
fig,config1,config2,config3,name,period,percore,metric-id

I'll take a look. UNC_ARB* events are going to be using uncore_arb_*
PMUs and so the cpu_core PMU shouldn't be specified. This looks like a
bug in how the metric is generated.

> Testing UNCORE_FREQ
> Metric 'UNCORE_FREQ' not printed in:
> event syntax error: '{tma_info_system_socket_clks/metric-id=3Dtma_info_sy=
stem_s..'
>                       \___ Bad event or PMU
>
> Unable to find PMU or event on a PMU of 'tma_info_system_socket_clks'
>
> Initial error:
> event syntax error: '{tma_info_system_socket_clks/metric-id=3Dtma_info_sy=
stem_s..'
>                       \___ Cannot find PMU `tma_info_system_socket_clks'.=
 Missing kernel support?
> Testing tma_info_system_socket_clks

Similar bug but different as differing PMUs aren't involved:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#L145=
9

I also see what may be a PMU driver bug in:
```
...
Metric 'tma_slow_pause' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
 Average synthesis took: 11.657 usec (+- 0.039 usec)
 Average num. events: 4.000 (+- 0.000)
 Average time per event 2.914 usec
 Average data synthesis took: 11.832 usec (+- 0.037 usec)
 Average num. events: 13.000 (+- 0.000)
 Average time per event 0.910 usec

Performance counter stats for 'perf bench internals synthesize':

    <not counted>      cpu_core/TOPDOWN.SLOTS/
                        (0.00%)
    <not counted>      cpu_core/topdown-retiring/
                        (0.00%)
    <not counted>      cpu_core/topdown-mem-bound/
                        (0.00%)
    <not counted>      cpu_core/topdown-bad-spec/
                        (0.00%)
    <not counted>      cpu_core/topdown-fe-bound/
                        (0.00%)
    <not counted>      cpu_core/topdown-be-bound/
                        (0.00%)
    <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/
                            (0.00%)
    <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/
                           (0.00%)
    <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/
                             (0.00%)
    <not counted>      cpu_core/CPU_CLK_UNHALTED.PAUSE/
                        (0.00%)
    <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/
                             (0.00%)
    <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/
                         (0.00%)
    <not counted>      cpu_core/ARITH.DIV_ACTIVE/
                        (0.00%)
    <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=3D0xc/
                                     (0.00%)
    <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=3D0x80/
                                      (0.00%)

      0.327060340 seconds time elapsed

      0.114906000 seconds user
      0.210001000 seconds sys
...
```

as adding --metric-no-group fixes the issue. Adding --metric-no-group
shouldn't be necessary as perf_event_open should be failing causing
the weak group to break (hence the possible PMU driver bug). Perhaps
there is something erroneous in weak group breaking on hybrid.

Thanks,
Ian

> - Arnaldo

