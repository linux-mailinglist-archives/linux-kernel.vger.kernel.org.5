Return-Path: <linux-kernel+bounces-25354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA75682CE2A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 19:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B769A1C211BA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB9F63C7;
	Sat, 13 Jan 2024 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="p8n4+Yhs"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE263A6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33694bf8835so5724956f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 10:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705171077; x=1705775877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zLHitRwn8P5MWByWsP9MWy9vMCnP3S50sHRU56/35w8=;
        b=p8n4+YhskKkLSgcKfSp21kg9qGeGyPiOGtU74MFo6Rg01D4eoSqG+VOnOFEtbwzPGw
         WTZV24eh5Shv4IcQjX/vcycLq8U08GChHPexcEAkqPV3DDibzZC5DNcsSlAmyDFnyBCX
         uo8JqpK88KP+zVSTqT+AJrQ+jCjt3WBxvdaTV3TOk7KKcM+EhFcVcUV5wf2ZmIhr4Uax
         1n1wGiNAQYfCeI6sXlkmkbXfIRb2ALp6SiScZDeIavBHmkM1YmRGfzdOsaBJyNIeGCmp
         MNvEMFbsfGG9tUQYxWJiFHNjd+JXPEa/D5tfMEmVg3Adj6NasdnClZ4BPa7/Yr8mdfU6
         nYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705171077; x=1705775877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLHitRwn8P5MWByWsP9MWy9vMCnP3S50sHRU56/35w8=;
        b=puSMlhYkUc0vuNfr1D92AS+SyS6HSkYZ38dDDxPdFah3NtULChO1shadYwIaPNsHfo
         tULMF3cDbRBf8u4haWMMWB/lkrBwSIhm2p5MbBKTsznkKaIfahut39nVWuiKfI9JMgQx
         MAPy8drtGXBLTxNq6B6zsVUXagqsLFcEQ6EYkPWjPyl1Qj75o/OMyTxi+unjvgPRuak/
         zdHkliHB83co/2D1ZJXJkW6iPkMwC/mHxEWYuof4RJt82QIPwhWS6IfrlFjqBCdlCYam
         BlKi8ueHql1PPevVGg0xlZzDDs+flj/2UkStFJhjxqV3DwTcOCXFhNxYU3c+2t0A2ykE
         Vf5Q==
X-Gm-Message-State: AOJu0Yy/iMxl58bfwOZAyMVtZ/fz9Vl0JOmdbYFmJ8NTbhV/IBw+nKuj
	q9pNhEyPyRueanzw1FWUd22Z6L8KkykpPg==
X-Google-Smtp-Source: AGHT+IGx+typfGV6pw88t0MhNDVovMTO/6LAQT5VVf/hJ8arArE+DoukPULemtHJk7obzpVYRYbGeg==
X-Received: by 2002:a5d:4087:0:b0:336:ca46:2ce1 with SMTP id o7-20020a5d4087000000b00336ca462ce1mr1687719wrp.122.1705171077431;
        Sat, 13 Jan 2024 10:37:57 -0800 (PST)
Received: from airbuntu (host109-154-205-127.range109-154.btcentralplus.com. [109.154.205.127])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d63d1000000b003365fcc1846sm7297613wrw.52.2024.01.13.10.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 10:37:57 -0800 (PST)
Date: Sat, 13 Jan 2024 18:37:55 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
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
Message-ID: <20240113183755.3gppkooy2g72f3qn@airbuntu>
References: <CAHk-=whK-cuBUQ2hECtkGu3LR-ipai+tmB85M=C7n3b1M8B4gQ@mail.gmail.com>
 <CAKfTPtCnT9VLqiQGL5kyhzqv=WAUNRA3tVDVoKjB7jX-00Un+g@mail.gmail.com>
 <4405adb5-0b16-4716-9542-47d8bb1737ee@arm.com>
 <20240112181805.bjvrkvvkszdfa7co@airbuntu>
 <CAKfTPtBQZcDpiPMF2sjJopNueMe+Lv0cziPzAMAaxH1XbfHiUQ@mail.gmail.com>
 <CAHk-=wiwRb50-q6EFU9RgjxOXHC2=x_ddQ6yzWTs5ah0nVeXPw@mail.gmail.com>
 <CAHk-=wh-RR5DMb8jttBGT3Y+W0=X=dSBHZxWpNECT4Dw0_1erQ@mail.gmail.com>
 <CAHk-=whCt-Eem=BbDo+f0VoDerYQNbvnPCdh6fcBNDnLyZyvfA@mail.gmail.com>
 <20240113010432.xe25lxqogxuvl72t@airbuntu>
 <CAHk-=wgfS+F+QNbFPurhnZTVLkw4xDOmmaSD3qdQLUoE2VsGTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgfS+F+QNbFPurhnZTVLkw4xDOmmaSD3qdQLUoE2VsGTw@mail.gmail.com>

On 01/12/24 17:24, Linus Torvalds wrote:
> On Fri, 12 Jan 2024 at 17:04, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > That is odd. I can't see how the patch can cause this yet, could you try with
> > a different compiler if possible?
> 
> I use two different compilers - I do my allmodconfig builds with gcc,
> and the kernels I boot with clang, so my problems have been with a
> kernel built with
> 
>    clang version 17.0.6
> 
> but to check that it's not a compiler issue I just did another try
> with my current public tip of tree (ie *without* any reverts for this
> issue) and gcc:
> 
>     gcc version 13.2.1
> 
> and the behavior is exactly the same: all cores are stuck at 2.2GHz.
> 
> So no, it's not compiler-dependent.
> 
> > I usually use perfetto but it should be easy to see frequency updates from
> > power/cpu_frequency trace event.
> >
> >         echo 1 | sudo tee /sys/kernel/tracing/tracing_on
> >         echo 1 | sudo tee /sys/kernel/tracing/events/power/cpu_frequency/enable
> >         sudo cat /sys/kernel/tracing/trace
> 
> Shows absolutely nothing. Or rather, it shows the header with
> 
>   # entries-in-buffer/entries-written: 0/0   #P:64
> 
> and that's it.
> 
> With a *working* kernel, I get events, setting the frequency to either
> 2.2GHz (idle) or 3.8GHz (work).
> 
> IOW, the tracing output is 100% consistent with "that commit breaks everything".

Thanks for all the info. It seems for some reason we no longer think we need to
update the frequency. Not sure why yet. It's strange I can't reproduce too even
running from top of your tree. I ran with these patches on M1, Pixel, Intel and
now AMD and haven't noticed anything since they got merged.

