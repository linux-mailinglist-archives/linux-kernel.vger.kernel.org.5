Return-Path: <linux-kernel+bounces-24960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E518182C550
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A1A1F24594
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB24517C9E;
	Fri, 12 Jan 2024 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="1jHM8VKc"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F0C17C8D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so6037191f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705083487; x=1705688287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzBITAPUo9KWi3BzneFq2htMGoTE+YKiey/v6v44744=;
        b=1jHM8VKcytZT8S0RZEaCRU0bVJepvO/QDt1Ix6oBOfuNqt1JNSl40PU9r8/GX86WiX
         xcI3MQOqDGsIoyXjI48IgE5v9lbXwvOhyhG+5nP1i97Z6ZScXP96H2xEeDMyM3RxJL3Z
         g3s0Yg33eSXlj17ftYX3Zh6midPEGZkvgoCbSD9H+KQ7r5Thfa66qvN+jNepmuR8oDFP
         f2Ztkcg5BTSTaCthhOjUA12uaR0RRBG66oLrYdhtzEUiKvk0dqZaoXwCI6VaThISN/t6
         GaCB6rA/6ZQckXWb7yUbKEJxRQzIJc/QBkcvFjABBfo46YOOonPoUD1EWdBDhuMObh73
         vLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705083487; x=1705688287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzBITAPUo9KWi3BzneFq2htMGoTE+YKiey/v6v44744=;
        b=Zox8vn8dFgCc+i6LjmLg1+unzArImeB15gq5VO4uJ0paVprl06/kbHi2WEI2OaBm18
         4IsyhHHaL0+bk1v7kPGDpIMuSDjhg+XP548RvDLIs9ArAPtWWlqL8+zwZVXkUODiZPpb
         ss/lb9hCkUZbd/4o+j5++E3J0h+9TzgJYtQye0cFtui73SxRUCWXpfgZJKa/KmSatWen
         dwsT7iZzb3z4Bhe3DuIVsEOIUEdMUCnqBEH/h323+25c/zRZOgzINZ0HAxJd5uWEdTMb
         MRv5Up7Ji6U5s2ilNkSXXMgygg/5wpQdDDrG3ihIjUuc3z5qFuVrrrqJKoI5oc4KV/ZK
         8Fdw==
X-Gm-Message-State: AOJu0YxZovre9+wPUkD3BdzuP0nTNUK4VfvUeoAqqXVa7vMITpQpvCfl
	32gwtvvg5dSETqkjLp3zGVdiqYyzV+zZ9A==
X-Google-Smtp-Source: AGHT+IEx4ebi4c5EO8tRfgW1gN5WDVk9iK3fAs8A7ML4MyU65yjo7LDPLFYItnvnkDZCt8e4RaUPKg==
X-Received: by 2002:adf:f404:0:b0:336:780d:cea5 with SMTP id g4-20020adff404000000b00336780dcea5mr434798wro.153.1705083487146;
        Fri, 12 Jan 2024 10:18:07 -0800 (PST)
Received: from airbuntu (host109-154-205-127.range109-154.btcentralplus.com. [109.154.205.127])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d43d1000000b0033760ad2eabsm4501172wrr.69.2024.01.12.10.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:18:06 -0800 (PST)
Date: Fri, 12 Jan 2024 18:18:05 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Message-ID: <20240112181805.bjvrkvvkszdfa7co@airbuntu>
References: <ZTz9RpZxfxysYCmt@gmail.com>
 <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <ZZ+ixagkxRPYyTCE@vingu-book>
 <CAHk-=wj75Er8k4QY-KF34NBCWkDpr3D26XptOpkfDcTyGEA7iA@mail.gmail.com>
 <CAHk-=whK-cuBUQ2hECtkGu3LR-ipai+tmB85M=C7n3b1M8B4gQ@mail.gmail.com>
 <CAKfTPtCnT9VLqiQGL5kyhzqv=WAUNRA3tVDVoKjB7jX-00Un+g@mail.gmail.com>
 <4405adb5-0b16-4716-9542-47d8bb1737ee@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4405adb5-0b16-4716-9542-47d8bb1737ee@arm.com>

On 01/12/24 15:23, Dietmar Eggemann wrote:
> On 11/01/2024 19:16, Vincent Guittot wrote:
> > On Thu, 11 Jan 2024 at 18:53, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> On Thu, 11 Jan 2024 at 09:45, Linus Torvalds
> >> <torvalds@linux-foundation.org> wrote:
> >>>
> >>> On Thu, 11 Jan 2024 at 00:11, Vincent Guittot
> >>> <vincent.guittot@linaro.org> wrote:
> >>>>
> >>>> Could you confirm that cpufreq governor is schedutil and the driver is
> >>>> amd-pstate on your system ?
> >>>
> >>> schedutil yes, amd-pstate no. I actually just use acpi_cpufreq
> >>
> >> Bah. Hit 'send' mistakenly too soon, thus the abrupt end and
> >> unfinished quoting removal.
> >>
> >> And don't ask me why it's acpi_pstate-driven. I have X86_AMD_PSTATE=y, but
> >>
> >>     /sys/devices/system/cpu/cpufreq/policy0/scaling_driver
> >>
> >> clearly says 'acpi-cpufreq'. Maybe I'm looking in the wrong place. My dmesg says
> > 
> > That seems to be the right place to look
> > 
> >>
> >>     amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
> >>
> >> which is presumably the reason my machine uses acpi-pstate.
> >>
> >> I will also test out your other questions, but I need to go back and
> >> do more pull requests first.
> > 
> > ok, thanks
> > 
> > I'm going to continue checking what else could trigger such regression
> > having in mind that your system should not have beeb impacted by this
> > changes
> 
> I can't see the regression on my
> 
>   20-core (40-thread) Intel Xeon CPU E5-2690 v2
> 
> with 'schedutil' and 'acpi-cpufreq'.

I tried to reproduce on AMD 3900X 12-Core system. I don't see any difference
in compiling defconfig with and without the two patches reverted. ~1m26s.

using schedutil and acpi-cpufreq driver too.

I disabled CONFIG_UCLAMP_TASK and that didn't make a difference.

I would have expected the iowait boost to be the more troublesome being the
more subtle one tbh.

