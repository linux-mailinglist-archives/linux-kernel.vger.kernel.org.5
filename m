Return-Path: <linux-kernel+bounces-25353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC9F82CE28
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 19:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EB3283A91
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 18:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE85684;
	Sat, 13 Jan 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="WAW4ZWTB"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642A17733
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e68ca8b45so15928995e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 10:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705170803; x=1705775603; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nZHQqNMYwA3ydf8Sgrb1Wl3va8SACG5r69XJGJ42K5U=;
        b=WAW4ZWTBrJ6Y49OEyHprigdemL8BwhL9adofr9w9oCkveo99zCBPTXsWgdyPTNlciR
         2DrvW6yW+S1PwZwt8YV12ASyemzhjBpSXF0wpM38Qp457rG+fTkxCHPyaPC7IZtQkfME
         8PgjrQDVYt8T6mnVjPz3OrSYn/01DlwxCyR65znvP7TSECAyHmZZVdcHZ4vWMTYmz1nB
         3yGaU+bjxfakwZnsNMEd8rsIbEejkyJXsWLoL23mgXjL3MgYIiYyuQQfb3/7/2uFxLEB
         H6BMm6R+83v1MEoGRFYYkutPeXR8TjOxz+odTLPSYuZBec7CnzpYeQJXboRIL/dm/duv
         vyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705170803; x=1705775603;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZHQqNMYwA3ydf8Sgrb1Wl3va8SACG5r69XJGJ42K5U=;
        b=uEvOIVgAPQwUMD2+/n33V9v3skaZBArUcqxFOaQMWqMWUMelgmjBLb/ZVUQb5n0J2M
         jhpLpEgSz6uKYndwzK3Q2W1nd86+5SXyFjA9lGYkNwup/60lvBHfndMwX7tQ5Nd/Vh/a
         LWpLoBoT7heEj4vvupvOpgUHXTQd1FRXd0odEZiLa7MGGeMaE4hsekpxpqfaT1IPJdhc
         mqwg5fbZH5ZPDf6BUZZAHO70QnlHpj+GDv+KoB12mP8usHK8B7Z3v0pJfHOUeDU+4dxP
         jO35ZQLz5s3wUC2gqvbC6NbLo/oSQ2yYLyPWztKwXwCOOIB8KZJGbC96IbjYvkGAOb2N
         6umQ==
X-Gm-Message-State: AOJu0YzHxna5a3AarpDR2/2C/LrgB9tplG/WJHJlGNJX2dGES8EyZehx
	fazu9ijnswu1h179Oc5bLmeYfzYGnWzPzw==
X-Google-Smtp-Source: AGHT+IFP8hHqW+eSSJPeh9HZxAdky9lgc1gA170lAdeXEhO4WQAxa/nlidi0834tkme5GSgWMv7a8Q==
X-Received: by 2002:a7b:c5ce:0:b0:40e:47de:d7e1 with SMTP id n14-20020a7bc5ce000000b0040e47ded7e1mr1868394wmk.73.1705170803165;
        Sat, 13 Jan 2024 10:33:23 -0800 (PST)
Received: from airbuntu (host109-154-205-127.range109-154.btcentralplus.com. [109.154.205.127])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040d62f89381sm10206400wmn.35.2024.01.13.10.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 10:33:22 -0800 (PST)
Date: Sat, 13 Jan 2024 18:33:20 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Message-ID: <20240113183320.sfm5v35tid55d6sf@airbuntu>
References: <4405adb5-0b16-4716-9542-47d8bb1737ee@arm.com>
 <20240112181805.bjvrkvvkszdfa7co@airbuntu>
 <CAKfTPtBQZcDpiPMF2sjJopNueMe+Lv0cziPzAMAaxH1XbfHiUQ@mail.gmail.com>
 <CAHk-=wiwRb50-q6EFU9RgjxOXHC2=x_ddQ6yzWTs5ah0nVeXPw@mail.gmail.com>
 <CAHk-=wh-RR5DMb8jttBGT3Y+W0=X=dSBHZxWpNECT4Dw0_1erQ@mail.gmail.com>
 <CAHk-=whCt-Eem=BbDo+f0VoDerYQNbvnPCdh6fcBNDnLyZyvfA@mail.gmail.com>
 <20240113010432.xe25lxqogxuvl72t@airbuntu>
 <CAHk-=wgfS+F+QNbFPurhnZTVLkw4xDOmmaSD3qdQLUoE2VsGTw@mail.gmail.com>
 <CAHk-=wjMGP2STWAqEO=T3TQUu44ygz2_JpOh65RahEO5Cjc+Yw@mail.gmail.com>
 <ZaJqRfjsI820jfXE@vingu-book>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaJqRfjsI820jfXE@vingu-book>

On 01/13/24 11:47, Vincent Guittot wrote:
> Le vendredi 12 janv. 2024 à 17:31:13 (-0800), Linus Torvalds a écrit :
> > On Fri, 12 Jan 2024 at 17:24, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > With a *working* kernel, I get events, setting the frequency to either
> > > 2.2GHz (idle) or 3.8GHz (work).
> > 
> > Just to fix that - not 3.8Ghz, but in addition to 2.2 I see 2.8 or 3.7:
> 
> IIUC, with the commit you stay at lowest frequency all time which is clearly
> weird. One change that could create such behavior is in
> sugov_effective_cpu_perf() where we take the min between the actual
> utilization and the max allowed. If max is set to min capacity for whatever
> the reason, then you stay stuck to lowest capacity/frequency

I tried on Linus' ToT (052d534373b7) with and without CONFIG_UCLAMP_TASK=y and
I still can't reproduce.

> 
> What is the output of 
> /sys/devices/system/cpu/cpu0/cpu_capacity

Since it's SMP, I don't see these generated.

There's a acpi_cppc node though. For CPU0

	$ grep . /sys/devices/system/cpu/cpu0/acpi_cppc/*
	/sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:500461208742 del:522909165272
	/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:216
	/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:550
	/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:62
	/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:20
	/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3801
	/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:135
	/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:135
	/sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615

highest_perf for all CPUs

	$ grep . /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf
	/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:216
	/sys/devices/system/cpu/cpu10/acpi_cppc/highest_perf:166
	/sys/devices/system/cpu/cpu11/acpi_cppc/highest_perf:176
	/sys/devices/system/cpu/cpu12/acpi_cppc/highest_perf:216
	/sys/devices/system/cpu/cpu13/acpi_cppc/highest_perf:216
	/sys/devices/system/cpu/cpu14/acpi_cppc/highest_perf:211
	/sys/devices/system/cpu/cpu15/acpi_cppc/highest_perf:206
	/sys/devices/system/cpu/cpu16/acpi_cppc/highest_perf:201
	/sys/devices/system/cpu/cpu17/acpi_cppc/highest_perf:196
	/sys/devices/system/cpu/cpu18/acpi_cppc/highest_perf:191
	/sys/devices/system/cpu/cpu19/acpi_cppc/highest_perf:186
	/sys/devices/system/cpu/cpu1/acpi_cppc/highest_perf:216
	/sys/devices/system/cpu/cpu20/acpi_cppc/highest_perf:181
	/sys/devices/system/cpu/cpu21/acpi_cppc/highest_perf:171
	/sys/devices/system/cpu/cpu22/acpi_cppc/highest_perf:166
	/sys/devices/system/cpu/cpu23/acpi_cppc/highest_perf:176
	/sys/devices/system/cpu/cpu2/acpi_cppc/highest_perf:211
	/sys/devices/system/cpu/cpu3/acpi_cppc/highest_perf:206
	/sys/devices/system/cpu/cpu4/acpi_cppc/highest_perf:201
	/sys/devices/system/cpu/cpu5/acpi_cppc/highest_perf:196
	/sys/devices/system/cpu/cpu6/acpi_cppc/highest_perf:191
	/sys/devices/system/cpu/cpu7/acpi_cppc/highest_perf:186
	/sys/devices/system/cpu/cpu8/acpi_cppc/highest_perf:181
	/sys/devices/system/cpu/cpu9/acpi_cppc/highest_perf:171

Can we overshoot somehow now and hitting a bug in frequency translation in
cpufreq by any chance?

> 
> It should be 1024 or close
> 
> Could you try the below ? it skips this step and ensures to use the actual
> utilization to select the frequency
> 
> ---
>  kernel/sched/cpufreq_schedutil.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 95c3c097083e..e420e2ee1a10 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -181,7 +181,6 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>  	/* Add dvfs headroom to actual utilization */
>  	actual = map_util_perf(actual);
>  	/* Actually we don't need to target the max performance */
> -	if (actual < max)
>  		max = actual;
>  
>  	/*
> -- 
> 2.34.1

