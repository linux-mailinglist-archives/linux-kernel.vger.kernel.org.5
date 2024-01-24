Return-Path: <linux-kernel+bounces-36232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05DA839DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204F31C2390F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC7310F2;
	Wed, 24 Jan 2024 00:46:56 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA73A620;
	Wed, 24 Jan 2024 00:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057216; cv=none; b=VguaejoGgF0ESsnO7lLc/3tehYFzCNkIrB6R/O5c0m+dYTc0IjE4m/Nbxd5elUuWGl5YO/UN9wG1LkF8p0t4nA/8JoHYR2pFtjVEhdyYFuaXsZnHOIehiyj/PqJUc03cnBzrNUa/vDtVyHQifzN7FiLhRFBWhxvsi7qbBF+AZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057216; c=relaxed/simple;
	bh=srE4YA+djmdtDSCNFwd4QbWspRxdreZxweUmYzNXyNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAgjuY3Gk4/P0MPXCdv/yt1X1SHG4i6Njq0P+qORq1WUwu/NwfEfXKDedXRydnFoO1vJnsvVjuZL66Jn4YivdDIuVPUn2V8PwlR0ZcEKXZgiw9572k2yj5QhLxNx1WtSpeVrn5K3m2zIu03CMiSfZxjswD6beP7FfM5P3PdtyvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3859800a12.1;
        Tue, 23 Jan 2024 16:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706057214; x=1706662014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9wvAI/9Xog451Z1ptdoSzplD0UCj4/gJXYkFcm2vag=;
        b=BRVEmZN98/Ta/SMDLMY2ckaORGd3DAnqaFlnj021fckgM1TzZFLsVbGLuipe3DTPYk
         7BiJ/w9jSRT7AxF4zdNWQe8Nh/aLzrV6CZxWVFRjPzmsDOUYKi9K++YxncqLleJPKm15
         tT7hRby+SDTljn7ZHNh/lOsCKhXiml8H6KKCq8AEIBOl0gh2eoL/jPx//OHoY6PhC0A4
         nfIXS+fvF/7LCgbd43yepBMkbnIVuVgncQCmQ9OPSxa+J/GnzP+Sh7bMx3LtpZP1fy7f
         En26llLLlHXLxyxe17nBlvQhjERx2XQ7DavIIAuX9OIFEBLz7v2I3WiXTmSOxWHojp8D
         TcfA==
X-Gm-Message-State: AOJu0Yxr4PU9uUstSXxGgE/jHe5uSwQGFYx4t97G/GrtPxYkdNFHedhh
	SbR/EUe9M/uQkpn8FS60gT9KdYjynyvTFTMjEI4tjLO7uFDlDR48BS7ynWO7AWNg/+iwIAhQ7z/
	4DLdTmMZsNZ1k29NDgOoCOV1gBec=
X-Google-Smtp-Source: AGHT+IGLN2haK1udN+ASNmQ2A92p7/4zR09NsIMCpWVIEEuZtqzUpoKnHeNw6nPGzPgtAw0w2uJ3Y2zlVESAic6lZRU=
X-Received: by 2002:a05:6a20:2996:b0:19c:58d3:3460 with SMTP id
 f22-20020a056a20299600b0019c58d33460mr64362pzh.56.1706057213884; Tue, 23 Jan
 2024 16:46:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123102728.239147-1-james.clark@arm.com> <20240123103918.241423-1-james.clark@arm.com>
In-Reply-To: <20240123103918.241423-1-james.clark@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 23 Jan 2024 16:46:43 -0800
Message-ID: <CAM9d7ciSY25Jf-MG24NWJu3aKJWXT2GN43qrV5WCuohLNZn1iw@mail.gmail.com>
Subject: Re: [PATCH v3] perf evlist: Fix evlist__new_default() for > 1 core PMU
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com, 
	kan.liang@linux.intel.com, mark.rutland@arm.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Changbin Du <changbin.du@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

On Tue, Jan 23, 2024 at 2:39=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> The 'Session topology' test currently fails with this message when
> evlist__new_default() opens more than one event:
>
>   32: Session topology                                                :
>   --- start ---
>   templ file: /tmp/perf-test-vv5YzZ
>   Using CPUID 0x00000000410fd070
>   Opening: unknown-hardware:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     config                           0xb00000000
>     disabled                         1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 4
>   Opening: unknown-hardware:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     config                           0xa00000000
>     disabled                         1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 5
>   non matching sample_type
>   FAILED tests/topology.c:73 can't get session
>   ---- end ----
>   Session topology: FAILED!
>
> This is because when re-opening the file and parsing the header, Perf
> expects that any file that has more than one event has the sample ID
> flag set. Perf record already sets the flag in a similar way when there
> is more than one event, so add the same logic to evlist__new_default().
>
> evlist__new_default() is only currently used in tests, so I don't
> expect this change to have any other side effects. The other tests that
> use it don't save and re-open the file so don't hit this issue.
>
> The session topology test has been failing on Arm big.LITTLE platforms
> since commit 251aa040244a ("perf parse-events: Wildcard most
> "numeric" events") when evlist__new_default() started opening multiple
> events for 'cycles'.
>
> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
> Closes: https://lore.kernel.org/lkml/CAP-5=3DfWVQ-7ijjK3-w1q+k2WYVNHbAcej=
b-xY0ptbjRw476VKA@mail.gmail.com/
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Tested-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/evlist.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> Changes since v2:
>
>    * Undo the fact that v2 was accidentally based on v1 instead of
>      perf-tools
>
> Changes since v1:
>
>   * Reduce scope of evsel variable
>   * Add argument label
>   * Change summary to be less specific about the failing test
>   * Add the closes: tag
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 95f25e9fb994..979a6053a84d 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -106,6 +106,13 @@ struct evlist *evlist__new_default(void)
>                 evlist =3D NULL;
>         }
>
> +       if (evlist->core.nr_entries > 1) {

I think you need a NULL check for evlist here.

Thanks,
Namhyung


> +               struct evsel *evsel;
> +
> +               evlist__for_each_entry(evlist, evsel)
> +                       evsel__set_sample_id(evsel, /*can_sample_identifi=
er=3D*/false);
> +       }
> +
>         return evlist;
>  }
>
> --
> 2.34.1
>

