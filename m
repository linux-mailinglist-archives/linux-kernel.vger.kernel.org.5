Return-Path: <linux-kernel+bounces-156057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAF08AFD58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977D41C22131
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CCA1C36;
	Wed, 24 Apr 2024 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FvDEDUK4"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE13634
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918495; cv=none; b=CRnJeIIZt+nC9VOL87A59rd9wnhS4sTERHa2ukf/zhZPmbAC8qLnxaZn1ugv/Nr0hrVKErLh5cG8Mwh7IGpvlb5W2LLhvdrbXt2Pr0T6/921FmLWUmjJNkjfwUXH53QHYmEU+2kEwbnRxR06420Yes/S05MneMG6unjdF8jJX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918495; c=relaxed/simple;
	bh=R/OgSmiO5urrOxI3K+4q4wNzXhrJbrqWVoXEWuijYx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfTeiWUmPg35dGaK9xEZlwMifC/tWnKSAqPEGPcg7AS10N81sp8XdRXDn3HKEx86MIJE/8EyuirIvpGinsxxnbzCFCKczC0iJYXJtbnRgiYj9E+zNJCYZUJMtETiUa32T6j55gb759EN+DGrLWYAGRfarm/06B7IIiUQPk1ZuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FvDEDUK4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so7723604e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713918491; x=1714523291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXU+ikToE9vTgd0d2ogVMdIIk0usIDCY3palNyF75i4=;
        b=FvDEDUK49YxIx6JmmZnqcjWAK8rb8EFRKf4UjII+hm7SJcl/MZqnBCRWM0ag8Q3+EO
         yyz3VLEBGWAd2lZ2rl7iidbe69JZ/hDgOcEgytBi2RtPrWVdgPZfYZD72YXv8kKKfUlS
         dSQLYMnW0iW6SR/lAUipjpC20TPZ/1YphTSWUyL7k/zYTRWAvZT2l8qsGwawqgCrMp9d
         hE4u37bQYk97SxcHeSfgELYBVGSfRw3RmAGcSlora4d2oYxQ1nwEx4NAGUaQ8bhWRit/
         z2w1Ap5K3RdbFDWeJU27yifdwjz97VnqHC5UOxsehTXEf0Zuex1cGWKgJCuNF3ywFSBT
         WiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713918491; x=1714523291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXU+ikToE9vTgd0d2ogVMdIIk0usIDCY3palNyF75i4=;
        b=tV282EwilzVToyF1MhzR2HHpWXb7/KaAAqVS0CGrCZWhmjF4lQRgVkeNn7e35U2Kpc
         DghNKlVNoB/BiyS8/j48lgZKEoJUX9VDB+1w7zYj1dZ8ZTOXI5Dv5Z5dVd44YE7dX1hO
         pjm85znLgbZUHje71pYns1khRn4+7GZcbaldKsBMgad5WZ3ZdVjddVK3L3xPdzy0rQEd
         G9ttQpnaeImELJsvpfMYQhCxlTB3xRXjGxhOTmLXJ2dalxWmgrpSt8fY+WYb1GmUA1pt
         b3d6bth6cIuNEj1oOcijFHsmWt54xNFIf4984E/uma2M73oaJW6E6WdL9hbcpB/Zn4Nb
         GpMw==
X-Forwarded-Encrypted: i=1; AJvYcCVOE5f8VmgwWiSta/ityF7Zp0LflMMey8z5CVERaRfueSdXtSujVO8u0GvSCtbRNJFFTJONEEScLPR2vxo0vKy0sAb73dyzGrgcePoJ
X-Gm-Message-State: AOJu0YwwnBNYUXnz0XmPmHBaBwHMk0ORVW1PSoFW01iIY7wstTZnKwmN
	RnQEG+ZACIR7+7Oq3Ehskv34PvuvN+MkBuGYS6XFDtPGQXjbUFpHLXZfcVeprY9J9T92eAzqhk4
	xY05+pTLJKveetC6czb8tPcVaJqPhluZoTVMKsQ==
X-Google-Smtp-Source: AGHT+IFmAtveWqF5KaXct/eDRNhEoPLTdbLM1bttvHvTHWx51gYkcxlUgQIhdEx7nF7tg8XpB0fvpPToj5um1tKlVE0=
X-Received: by 2002:a19:914d:0:b0:516:c696:9078 with SMTP id
 y13-20020a19914d000000b00516c6969078mr607660lfj.50.1713918491483; Tue, 23 Apr
 2024 17:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 23 Apr 2024 17:28:00 -0700
Message-ID: <CAHBxVyF-u__MY9BNkqxUJg4ra76CzT0p_JBVaQqZm=u4V4u5AQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Consistently prefer sysfs/json events
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> As discussed in:
> https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com=
/
> preferring sysfs/json events consistently (with or without a given
> PMU) will enable RISC-V's hope to customize legacy events in the perf
> tool.
>

Thanks for remapping legacy events in a generic way. This looks great
and got rid of my
ugly arch specific way of remapping.  Is there a good way for the
driver (e.g via sysfs) to tell the perf tool
whether to remap the legacy event or not ?

In RISC-V the legacy systems without the new ISA extension may not
want to remap if running
the latest kernel.

I described the problem in detail in the original thread as well.
https://lore.kernel.org/lkml/63d73f09-84e5-49e1-99f5-60f414b22d70@rivosinc.=
com/

FWIW, for the entire series.
Tested-by: Atish Patra <atishp@rivosinc.com>

> Some minor clean-up is performed on the way.
>
> v2. Additional cleanup particularly adding better error messages. Fix
>     some line length issues on the earlier patches.
>
> Ian Rogers (16):
>   perf parse-events: Factor out '<event_or_pmu>/.../' parsing
>   perf parse-events: Directly pass PMU to parse_events_add_pmu
>   perf parse-events: Avoid copying an empty list
>   perf pmu: Refactor perf_pmu__match
>   perf tests parse-events: Use branches rather than cache-references
>   perf parse-events: Legacy cache names on all PMUs and lower priority
>   perf parse-events: Handle PE_TERM_HW in name_or_raw
>   perf parse-events: Constify parse_events_add_numeric
>   perf parse-events: Prefer sysfs/json hardware events over legacy
>   perf parse-events: Inline parse_events_update_lists
>   perf parse-events: Improve error message for bad numbers
>   perf parse-events: Inline parse_events_evlist_error
>   perf parse-events: Improvements to modifier parsing
>   perf parse-event: Constify event_symbol arrays
>   perf parse-events: Minor grouping tidy up
>   perf parse-events: Tidy the setting of the default event name
>
>  tools/perf/tests/parse-events.c |   6 +-
>  tools/perf/util/parse-events.c  | 482 ++++++++++++++++----------------
>  tools/perf/util/parse-events.h  |  49 ++--
>  tools/perf/util/parse-events.l  | 196 +++++++++----
>  tools/perf/util/parse-events.y  | 261 +++++++----------
>  tools/perf/util/pmu.c           |  27 +-
>  tools/perf/util/pmu.h           |   2 +-
>  7 files changed, 540 insertions(+), 483 deletions(-)
>
> --
> 2.44.0.683.g7961c838ac-goog
>

