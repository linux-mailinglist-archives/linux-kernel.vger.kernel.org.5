Return-Path: <linux-kernel+bounces-31577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F93F833046
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBBF61F24198
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CD55823E;
	Fri, 19 Jan 2024 21:29:00 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0265822F;
	Fri, 19 Jan 2024 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699740; cv=none; b=IPgxhz+N1muPrbLVrkvkSTqJSgEveGk9bvU/1shUnWByJtrpjAJtmNvwnO9amdzvJODQ4gIJj1YIsSuKSb2vXdUO/DnsmQIyIisFhi8Gbm0ycSudz5W2pXXad+Duxfk93VyQtr4ee1cAOB4gw3c906roA6AXYHeHGeWMeKwaY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699740; c=relaxed/simple;
	bh=bkhrkchk6e5WhXZSlMcqDpSxsF/bbVQRA5gZJ/Q3Xj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKTgbEB6erGwEXF/GaKwlDSyD66811W51qJIiM9iFzvk8pq0/W7CQLNMvbIRK+/AA/dmZQ+55oV2SxS4VMiw7mKrT8KcW3ZeRyocGkiYyMe8zV41KpC3v+M/0tlOvBRkqqMljAAMAKC/qbt7sqPERu6wJEHtN2XfmdnoKkCfjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28beb1d946fso1214589a91.0;
        Fri, 19 Jan 2024 13:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705699732; x=1706304532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J75bWmhp2Quw+RcG/QEGo3ztv3u8VxnZgR2K2QhevHg=;
        b=mcfnX7cGubmvephtOaXPgMe8iou/53PxaM495WBTtUnh3PU8UcJEyORvWnEwWKtkLg
         QHwBKP7P5LYnfdrsrM+h+3ZoyA+97uGLbaIfwFB3m9oUEsJP64sutcQ8ScUoHYHJ4Dl2
         jqEKp7m14smvV3ftDAfGlyiIsW8WhsU4mbnZqOYdT4qKA5C4JbQ4uYmMInV9x/XLto+a
         C2bTiopvcIJ92b9JC9b9WwR8+/u52mN9U2HEnmEpVbA0EHS4YvrQoq9K1KjsDnnGU1rn
         Wk1nv9KdLx9Fur6EcE3GIW1LFljnLGjdwN/3/TI7e9Z093Wo0obziHir09Vik/6BPErI
         wP/A==
X-Gm-Message-State: AOJu0Yxjc+w2t9s8ZYFC24J7EuKx/Hf6doW+317HiWZ+7kNjApgDB5Hq
	4UJKCet7/GADl4b3yW2lBaUvpiUfgsNB/RZFAJIRkKcdCkVM0p3Sv2L/X+q7xnnEZXqqoksaxKC
	SfnaJXbd5JvghUO7tfWWW9JKNyKQ=
X-Google-Smtp-Source: AGHT+IFb9qbUR5OmU+gqI+dATA2oLJsMVF/Ou6K6ihVjumyYOdueLOX++XoiOH3w1HnlqqvSxu5vdQHIfNYOVL1nC4k=
X-Received: by 2002:a17:90b:3649:b0:28e:3b7f:a2a9 with SMTP id
 nh9-20020a17090b364900b0028e3b7fa2a9mr353478pjb.48.1705699732267; Fri, 19 Jan
 2024 13:28:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111081914.3123-1-adrian.hunter@intel.com>
 <20240111081914.3123-11-adrian.hunter@intel.com> <87ply1lebh.fsf@linux.intel.com>
 <60cc9fa8-e714-41d0-a82d-9c8a54dfde4e@intel.com>
In-Reply-To: <60cc9fa8-e714-41d0-a82d-9c8a54dfde4e@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 19 Jan 2024 13:28:41 -0800
Message-ID: <CAM9d7cg3T6DKoyDj4G7+9rQosqVKhCPpS0DZEXuLgbVwe+QM4w@mail.gmail.com>
Subject: Re: [PATCH V4 10/11] perf intel-pt: Add documentation for pause / resume
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon <will@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jan 16, 2024 at 4:22=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 16/01/24 13:15, Andi Kleen wrote:
> > Adrian Hunter <adrian.hunter@intel.com> writes:
> >> +
> >> +For example, to trace only the uname system call (sys_newuname) when =
running the
> >> +command line utility uname:
> >> +
> >> + $ perf record --kcore -e
> >> intel_pt/aux-action=3Dstart-paused/k,syscalls:sys_enter_newuname/aux-a=
ction=3Dresume/,syscalls:sys_exit_newuname/aux-action=3Dpause/
> >> uname
> >
> > It's unclear if the syntax works for hardware break points, kprobes, up=
robes too?
>
> Yes, the perf tool syntax requires only that the group leader is
> an AUX area event like intel_pt.  Note that an attempt is made to
> automatically group AUX area events with events with aux-action,
> so grouping syntax like '{...}' is not always necessary.

Depends on the position, right?  Maybe there can be other events
without aux-action mixed with aux events.

Thanks,
Namhyung

>
> Note the current kernel implementation is called from
> __perf_event_output() which is used in nearly all cases for the
> output of samples, the exceptions being Intel BTS (which we do not
> support at the same time as Intel PT, but wouldn't make much sense
> anyway) and S390 cpumsf_output_event_pid().
>
> > That would be most useful. If it works would be good to add examples fo=
r it.
>
> OK
>

