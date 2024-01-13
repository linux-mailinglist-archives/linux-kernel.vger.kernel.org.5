Return-Path: <linux-kernel+bounces-25267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439A582CC20
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8D31F222DD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683C820DE1;
	Sat, 13 Jan 2024 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtX7R2Qt"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E15112E4B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3374eb61cbcso6306182f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 02:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705142855; x=1705747655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MpYY6g61jHhgjzHe8ZEpieL3QyTuTdjowEnKPA9N+Y0=;
        b=AtX7R2QtEDqZNQDvuzfqmM3SzBQgBRu6KVHcJdS4qpTdXZOLy6jHQXwHGZD8gIhVoa
         PqVnZaT+At4ipL+vuXawiRw4tM3cvc2Fs0daK0F9hDiBP36fXnO4LJQZtAOEo6BsRygm
         clLCxEHdvWuZd3e/W9l/AnC9WZOIjrfi4iW7wMTYNugnzD8rdH64JtLZ4iIHlIz5PNPA
         2K37qMXPJwJXDse10ln32YkPwWwiX0UIew/rtzq5VglQWDQLmTapM5+noRt8rzlkMnnd
         w50g343OVThmUtjIVYHMVxiec8u2NS8fNnNKv8dVd+fF1UywLG2Iko1nQjLpyByh+/mA
         6WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705142855; x=1705747655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpYY6g61jHhgjzHe8ZEpieL3QyTuTdjowEnKPA9N+Y0=;
        b=styLjst5pPoq0Vw6jokKEHdef6QVSJMm0zulBuHqQXnLtAMucMcoOyL3KVZ7Ez+JSP
         C/SuLImmwMatUO0ii2wpN1hf0qUpZnfwOnyl9sZmOEEMSTFBbfjtEQQo6WP1CLd54PX/
         pdVuXtLb5R+9EiM9NkuzoyY2bqpIYtUvsykK/gLEPQcSmVosH7CA6Y7ks/75B/ROSN+h
         U6T7HQorSRHw1DFajZAxPbTiOVIKLxHY+QfEMOotN0on/K1ryxRV3f1v9ce4ZusdJBn+
         gcdDez+9g1Bvwvev3lR77qIcB0wAE1ocNYnChelj7pW8PADiWF1B2zftH+24klshErwO
         YToQ==
X-Gm-Message-State: AOJu0YygjkiTupjMg5LAsKg0J4FiCm+Qw1qLONv7Ww2751sSOzHplUTg
	/4OBnALmCNbomlWejDpu5t1winjqTCPPRw==
X-Google-Smtp-Source: AGHT+IEPks1Dsq8SukM6ltUATZeCQg2dtdptZ3xrTbw2HoVnaASu6k9BaEfttKQKTAQhFI57cfvEPg==
X-Received: by 2002:a05:6000:2ab:b0:337:9b38:2451 with SMTP id l11-20020a05600002ab00b003379b382451mr718874wry.101.1705142855387;
        Sat, 13 Jan 2024 02:47:35 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:25b4:ff56:621:803])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d6641000000b0033609584b9dsm6450835wrw.74.2024.01.13.02.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 02:47:34 -0800 (PST)
Date: Sat, 13 Jan 2024 11:47:33 +0100
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Qais Yousef <qyousef@layalina.io>,
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
Message-ID: <ZaJqRfjsI820jfXE@vingu-book>
References: <CAKfTPtCnT9VLqiQGL5kyhzqv=WAUNRA3tVDVoKjB7jX-00Un+g@mail.gmail.com>
 <4405adb5-0b16-4716-9542-47d8bb1737ee@arm.com>
 <20240112181805.bjvrkvvkszdfa7co@airbuntu>
 <CAKfTPtBQZcDpiPMF2sjJopNueMe+Lv0cziPzAMAaxH1XbfHiUQ@mail.gmail.com>
 <CAHk-=wiwRb50-q6EFU9RgjxOXHC2=x_ddQ6yzWTs5ah0nVeXPw@mail.gmail.com>
 <CAHk-=wh-RR5DMb8jttBGT3Y+W0=X=dSBHZxWpNECT4Dw0_1erQ@mail.gmail.com>
 <CAHk-=whCt-Eem=BbDo+f0VoDerYQNbvnPCdh6fcBNDnLyZyvfA@mail.gmail.com>
 <20240113010432.xe25lxqogxuvl72t@airbuntu>
 <CAHk-=wgfS+F+QNbFPurhnZTVLkw4xDOmmaSD3qdQLUoE2VsGTw@mail.gmail.com>
 <CAHk-=wjMGP2STWAqEO=T3TQUu44ygz2_JpOh65RahEO5Cjc+Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjMGP2STWAqEO=T3TQUu44ygz2_JpOh65RahEO5Cjc+Yw@mail.gmail.com>

Le vendredi 12 janv. 2024 à 17:31:13 (-0800), Linus Torvalds a écrit :
> On Fri, 12 Jan 2024 at 17:24, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > With a *working* kernel, I get events, setting the frequency to either
> > 2.2GHz (idle) or 3.8GHz (work).
> 
> Just to fix that - not 3.8Ghz, but in addition to 2.2 I see 2.8 or 3.7:

IIUC, with the commit you stay at lowest frequency all time which is clearly
weird. One change that could create such behavior is in
sugov_effective_cpu_perf() where we take the min between the actual
utilization and the max allowed. If max is set to min capacity for whatever
the reason, then you stay stuck to lowest capacity/frequency

What is the output of 
/sys/devices/system/cpu/cpu0/cpu_capacity

It should be 1024 or close

Could you try the below ? it skips this step and ensures to use the actual
utilization to select the frequency

---
 kernel/sched/cpufreq_schedutil.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 95c3c097083e..e420e2ee1a10 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -181,7 +181,6 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 	/* Add dvfs headroom to actual utilization */
 	actual = map_util_perf(actual);
 	/* Actually we don't need to target the max performance */
-	if (actual < max)
 		max = actual;
 
 	/*
-- 
2.34.1

> 
>   ...
>   <idle>-0       [034] d.s..   208.340412: cpu_frequency:
> state=2200000 cpu_id=34
>      cc1-101686  [034] d.h..   208.342402: cpu_frequency:
> state=2800000 cpu_id=34
>      cc1-101686  [034] d.h..   208.343401: cpu_frequency:
> state=3700000 cpu_id=34
>       sh-108794  [029] d.h..   216.401014: cpu_frequency:
> state=2200000 cpu_id=29
>       sh-108794  [029] d....   216.402670: cpu_frequency:
> state=2800000 cpu_id=29
> genksyms-108565  [029] d.h..   216.404005: cpu_frequency:
> state=3700000 cpu_id=29
>   ...
> 
> etc.
> 
>               Linus

