Return-Path: <linux-kernel+bounces-31652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0918331F1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D951F22F07
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4122B804;
	Sat, 20 Jan 2024 00:49:55 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741BB642;
	Sat, 20 Jan 2024 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705711794; cv=none; b=hvFmaF5dDtUcVEJBfZl4xfiFUPPZSD3HrPevjxRGC7GwGe0BkJWRHZEAQJElTP9w4OIrRgqWsZasyVVvEwRl/aqoH5aVv5bqDNU5udQ/vZkpgYI6oeI76BKqhQk5gJfdxn+86xMW1cN1qf1xGPd7Cya4i+pGppEvO8s2DBQKgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705711794; c=relaxed/simple;
	bh=2CyF9+z+T8PciXgm3k1a4ERDVw/8+aQtn1hEGW24CX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGOwbsHNX9NRl7YFUJ3PaBPbat8Nn1Rr7VPl3UFXA1UcQXGJOuC2xVazPidPTEma8XZlUeHEfqlLGxPNxTS3Wn2ODn4F9JNhClpTKmc6jQPQ9jkJRWqjYGZQPD8y0zxQi5YuhBxm3C6LiTRUZTSSRfbs/dBrq5rQ9I+PDKP40bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d5f388407bso9907835ad.0;
        Fri, 19 Jan 2024 16:49:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705711793; x=1706316593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCXbLDU63kblVQW+umHhD1ON0m0heS0Hwmk/gcU5dVM=;
        b=jinMEV2vzgn8o4yXWfMLkXd7x5J+PiToo7XTiVdWkTIkICypgOND8B7s/vrqy3qGDz
         HcjMcdp1mITmEAC6NxhRwG7NgdeOB736wy965+9g4rVtOoxE0DHzhhmy5PE4F8kTzydQ
         2QFf5AcZHxVgW0KjE4JZqCcAT8NB7JGynDDX6emZsPu3ds25rNP8mUkIVcyjOJsoUpwH
         Oeluc5I1lQo00PpcL6CbB+Yi8+haHpf6NzT2oygP3Lqnvwms8NrIFbynuAPcP4oIL5nG
         ISxMH6/E4E5tnFFFhCYuWDGXPl09Dx/xVqC4GkQj7MGH544Y9XLua/rIJujhW8jfY6UD
         kimg==
X-Gm-Message-State: AOJu0Yy5nCWRM7BZnNBcBjaXkCdrh195GGWLNicMKnfBQa9dnwXs2DFI
	6zdeztn6s4enL3vbaIe06M6rutPEZ4RSk3Y3bumd4kVAr3MdXAaepotl/ZsFtafhtyk+qglh1ly
	i5dSOeOzf0OYiKTfOwlskFNh3D24=
X-Google-Smtp-Source: AGHT+IFvfWRA9P0J+5pETEoFsqVDu3l/PFCkh0dNwUHrZYypZVyhZNIPb42uWDbOPJ/BYuqczyBJm+J423sGJ/Gb090=
X-Received: by 2002:a17:90a:f312:b0:28e:2975:dd7 with SMTP id
 ca18-20020a17090af31200b0028e29750dd7mr443472pjb.5.1705711792719; Fri, 19 Jan
 2024 16:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119163924.2801678-1-ben.gainey@arm.com>
In-Reply-To: <20240119163924.2801678-1-ben.gainey@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 19 Jan 2024 16:49:41 -0800
Message-ID: <CAM9d7chcAVm8TyJz9iOoEom1g82O5hFD3M+DHYDrphUADATjgA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Support PERF_SAMPLE_READ with inherit_stat
To: Ben Gainey <ben.gainey@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jan 19, 2024 at 8:39=E2=80=AFAM Ben Gainey <ben.gainey@arm.com> wro=
te:
>
> This change allows events to use PERF_SAMPLE READ with inherit so long
> as both inherit_stat and PERF_SAMPLE_TID are set.
>
> Currently it is not possible to use PERF_SAMPLE_READ with inherit. This
> restriction assumes the user is interested in collecting aggregate
> statistics as per `perf stat`. It prevents a user from collecting
> per-thread samples using counter groups from a multi-threaded or
> multi-process application, as with `perf record -e '{....}:S'`. Instead
> users must use system-wide mode, or forgo the ability to sample counter
> groups. System-wide mode is often problematic as it requires specific
> permissions (no CAP_PERFMON / root access), or may lead to capture of
> significant amounts of extra data from other processes running on the
> system.
>
> Perf already supports the ability to collect per-thread counts with
> `inherit` via the `inherit_stat` flag. This patch changes
> `perf_event_alloc` relaxing the restriction to combine `inherit` with
> `PERF_SAMPLE_READ` so that the combination will be allowed so long as
> `inherit_stat` and `PERF_SAMPLE_TID` are enabled.

I'm not sure if it's correct.  Maybe I misunderstand inherit_stat but
AFAIK it's just to use prev_task's events when next_task has the
compatible event context.  So the event values it sees in samples
would depend on the timing or scheduler behavior.

Also event counts and time values PERF_SAMPLE_READ sees
include child event's so the values of the parent event can be
updated even if it's inactive.  And the values will vary for the
next_task whether prev_task is the parent or not.  I think it
would return consistent values only if it iterates all child events
and sums up the values like it does for read(2).  But it cannot
do that in the NMI handler.

Frankly I don't understand how inherit_stat supports per-thread
counts properly.  Also it doesn't seem to be used by default in
the perf tools.  IIUC per-thread count is supported when you
don't set the inherit bit and open separate events for each
thread but I guess that's not what you want.

Anyway, I'm ok with the idea of using PERF_SAMPLE_READ to
improve per-thread profiling especially with event groups.
But I think it should not use inherit_stat and it needs a way to
not include child stats in the samples.

What do you think?

Thanks,
Namhyung

>
> In this configuration stream ids (such as may appear in the read_format
> field of a PERF_RECORD_SAMPLE) are no longer globally unique, rather
> the pair of (stream id, tid) uniquely identify each event. Tools that
> rely on this, for example to calculate a delta between samples, would
> need updating to take this into account. Previously valid event
> configurations (system-wide, no-inherit and so on) where each stream id
> is the identifier are unaffected.
>
> This patch has been tested on aarch64 both my manual inspection of the
> output of `perf script -D` and through a modified version of Arm's
> commercial profiling tools and the numbers appear to line up as one
> would expect, but some further validation across other architectures
> and/or edge cases would be welcome.
>
> This patch was developed and tested on top of v6.7.
>
>
> Ben Gainey (1):
>   perf: Support PERF_SAMPLE_READ with inherit_stat
>
>  kernel/events/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> --
> 2.43.0
>

