Return-Path: <linux-kernel+bounces-28431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6100982FE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D0CB21C84
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B5279CC;
	Wed, 17 Jan 2024 01:35:31 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB57465;
	Wed, 17 Jan 2024 01:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455331; cv=none; b=ioc+hk1YErSh/pAYqotxSFIjC4aMbnUiXXQVFxDqQDr6gSIUAbFV5lg7itqJevLWHiaJ2hcw9retSr5Dq2WN4BW44o19NQ8KICtj2JIqOUKhi2CFieJCnmyaOlDJ6SHP/Q311htKvGjXmX0yXwqQLuhaAkUHyRUEiHpB8/4WYIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455331; c=relaxed/simple;
	bh=CdLDmKuWoZOspt6VBjN6rBwHSOufSrLY3fLlRr4hmn0=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=dH/D7SXUfB2BE9KPVyz66fmJnfVjMD5xNPFJmkvRwaNMN9ViMImiSEyKfFPBkL8eNt6SmjIFEIi9dUYCP33GTeGIkLfRsrhETWLsS9WnH2zJotjc2oaJLY6WAsEBaPiFWlmksf4T7XyZsZciJPoHXPukwyOvst7pbnAwgAOh3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bba50cd318so9033175b6e.0;
        Tue, 16 Jan 2024 17:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705455329; x=1706060129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUphaoPU4Mm9YyiMl2z+tQH9JE7/QoHz2AQOIfJEy4w=;
        b=fUJBL2P39LJ7xV3v981e1Sx5FK7G7bgdkw/2TTV8uPx9vd7UQq+hPcOu0dQ+2oVda3
         8+NB+yxfCDj1vfkb0D/U4Or5WEAcU3zYWF4LqAxoSZRfwcRmklXCgbO81Hy4vZRl+vk0
         HZED1GlV+PyqE+Re8Vc5ehxZuJtRukmV5pEAZOSRKhf4fbdz9Nfs5NgmSCDXm1rYoX2z
         /x/fq5INSnAo3kdiG120X6godt4bUYKzx7CQuMzDShPWo0vR+wQ8i5wuI8Zn9ZhgpITP
         WKghCfwp5i3gWGyUckZo3PqcPr8mMkGr+3yTMwi+pfCugLmPYYand5wm49f4AXDLX9oj
         ILfg==
X-Gm-Message-State: AOJu0Yy6UJx4X9qXDtTvTfFuzh70i2ZC7WEJ9XOWkZR/XKeeAwX+wYrJ
	2YA0jQVDPKk39RIbm//+8VVJAXtEJzxwJO3iaY8=
X-Google-Smtp-Source: AGHT+IEJDfXrF5zK+34ZeKTU65DkJKG3UVYjqvCQpYoEjiQGDdUeRFZWGxJf2F8ka8HJhrYjr8OQmQRPrZcRT+MG2pA=
X-Received: by 2002:a05:6808:6485:b0:3bd:67c5:d4ca with SMTP id
 fh5-20020a056808648500b003bd67c5d4camr7931730oib.80.1705455328885; Tue, 16
 Jan 2024 17:35:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115072306.303993-1-zegao@tencent.com>
In-Reply-To: <20240115072306.303993-1-zegao@tencent.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 16 Jan 2024 17:35:17 -0800
Message-ID: <CAM9d7cgXKaKTnfx9YJae2qqv0pXtWLVQPBN=2H0WZkenBjHFnQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf sched: Fix task state report
To: Ze Gao <zegao2021@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Jan 14, 2024 at 11:23=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wrote=
:
>
> Hi,
>
> The problems of task state report in both libtraceevent
> and perf sched has been reported in [1]. In short, they
> parsed the wrong state due to relying on the outdated
> hardcoded state string to interpret the raw bitmask
> from the record, which left the messes to maintain the
> backward compatibilities for both tools.
>
> [1] has not managed to make itself into the kernel, the
> problems and the solutions are well studied though.
>
> Luckily, as suggested by Steven, perf/libtraceevent
> records the print format, especially the __print_flags()
> part of the in-kernel tracepoint sched_switch in its
> metadata, and we have a chance to build the state str
> on the fly by parsing it.
>
> Now that libtraceevent has landed this solution in [2],
> we now apply the same idea to perf as well.

Thanks for your work.  But perf links libtraceevent
conditionally so you need to make sure if it works without
that too.

I think all libtraceevent related stuff should be in the
util/trace-event.c which is included only if the library is
available.  Maybe util/trace-event-parse.c is a better
place but then you need to tweak the python-ext-sources
and Makefile.perf for the case it's not available.

Thanks,
Namhyung

>
> Regards,
>
>         -- Ze
>
> [1]: https://lore.kernel.org/lkml/20230803083352.1585-1-zegao@tencent.com=
/
> [2]: https://lore.kernel.org/linux-trace-devel/20231224140732.7d41698d@ro=
rschach.local.home/
>
> Ze Gao (4):
>   perf sched: Sync state char array with the kernel
>   perf util: Add helpers to parse task state string from libtraceevent
>   perf util: Add evsel__taskstate() to parse the task state info instead
>   perf sched: Commit to evsel__taskstate() to parse task state info
>
>  tools/perf/builtin-sched.c |  57 +++------------
>  tools/perf/util/evsel.c    | 146 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/evsel.h    |   1 +
>  3 files changed, 157 insertions(+), 47 deletions(-)
>
> --
> 2.41.0
>

