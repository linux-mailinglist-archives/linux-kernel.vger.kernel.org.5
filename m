Return-Path: <linux-kernel+bounces-36202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB0D839D76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2141F252B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2AEED1;
	Wed, 24 Jan 2024 00:00:11 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095D2ED8;
	Wed, 24 Jan 2024 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706054410; cv=none; b=o5aVnBQEwubw1vmDe8+mZEmqFTWwRUeOt3ULAiPgXuMryL062ibdLTh64wzuzLOWdSVRBYFiN9qvJbIbTAsMlwaRtc3KYhUQ3PrQEuHvTPW/MlpoNT4cWkyNhZya1wf/qjQ6+/+2XDKEUB6IYfSqLsLm/Gc69MkW6/8tSjgVIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706054410; c=relaxed/simple;
	bh=U10nGEUE4cVQYUDnFu+7rOSFUdiJ6KYDfAxDrn8zcRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmc05QTeMEHH/SyKeN3qzGiwcai5CJCc81UwEfF6v5fLVmHOR036c8GEgoy4CNlWdZIuLDMrr+OSstYAm5tY09IO+EYb0HXgn/RpQTtq+FvbGX018dzNgfgURJhuDRZJIWjTi/DFsgKV9sjubKXGOJ4OeMMgzTfhuVv+bg8VvCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so230116a12.0;
        Tue, 23 Jan 2024 16:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706054408; x=1706659208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQle4+CUBnZaj6W1Lf3jcAaTPV6tjOTH4uhcTRizJNY=;
        b=gm6Bege4uOnEos7tTlEmcr7PRS1yCRIzRIawfc1ODKX/5U+KmEJPlvFvbuxLxEJqF2
         +yUvVNoQQUpmiE4u1yVEkb7Lo0YHhpQa0VgLQPeosaQSQVV73GO4sbM/g1/mETGEWSUu
         XDDpPjYLkS60ie6jBXfHWhDXgJKxr/PXsx662DMzK7VoA6NWq8zStc4isRTVH/+UYz/R
         0hGdEHPRZU6y0Pu+MXF6v9Hqj4wqbcoH0+blMhX0v8cPROvU1LKp/2aGiEN7Ks1JT/bA
         vVtuSR3AopjGc4VidEMoEzay4AonM2ggjNyJqiDMTGlrRy7OSKpy/fDrWCqcS2oxLM8a
         KHWw==
X-Gm-Message-State: AOJu0YzJL59ijFOfY3lxGBOrXNtg2zBcnb/q0HRkYJxaj/9UhSudk2Nq
	LxHFTR50JvZo6RY+1kBpwG9wZxnR3Kdf+pgQ4djiQIyCAloirAzRNUc6JQiWbLDea4liLI57t8h
	+xB3bZLv7vbnavjILo5cY8GiLjMn1cEgKSk8=
X-Google-Smtp-Source: AGHT+IEtD8mxiz/f5RScsi5J+Vm2JRwvkAD2vJGFFS128YQLBdkaYD7uUgDBOBLSgqwRGxSdZJ6NPJduMv7wDfOBpM0=
X-Received: by 2002:a05:6a21:3989:b0:19a:4f9b:3bf0 with SMTP id
 ad9-20020a056a21398900b0019a4f9b3bf0mr19438pzc.0.1706054407846; Tue, 23 Jan
 2024 16:00:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123000604.1211486-1-irogers@google.com>
In-Reply-To: <20240123000604.1211486-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 23 Jan 2024 15:59:56 -0800
Message-ID: <CAM9d7cg2Sr5wjR7Nu8pwmdWzErRT4R5V=VnUnnZhw0w=06Resw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Fixes for 6.8 PR1
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Ross Zwisler <zwisler@chromium.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Shirisha G <shirisha@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Mon, Jan 22, 2024 at 4:06=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Discovered some testing issues around perf list, perf script and perf
> daemon based on Linux 6.8-rc1. Some of the issues were discovered in
> the context of an Alderlake system.
>
> Ian Rogers (5):
>   perf list: Switch error message to pr_err
>   perf list: Add output file option
>   perf test: Workaround debug output in list test
>   perf test: Fix script test for python being disabled
>   perf test: Make daemon signal test less racy

Acked-by: Namhyung Kim <namhyung@kernel.org>

I only have a nitpick on patch 5.

Thanks,
Namhyung

>
>  tools/perf/Documentation/perf-list.txt |   4 +
>  tools/perf/builtin-list.c              | 211 +++++++++++++++----------
>  tools/perf/tests/shell/daemon.sh       |  34 ++--
>  tools/perf/tests/shell/list.sh         |  21 ++-
>  tools/perf/tests/shell/script.sh       |   3 +-
>  tools/perf/util/print-events.c         |   2 +-
>  6 files changed, 177 insertions(+), 98 deletions(-)
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

