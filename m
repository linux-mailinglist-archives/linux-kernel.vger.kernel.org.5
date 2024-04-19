Return-Path: <linux-kernel+bounces-151458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B458AAF33
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1038F1F23238
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7E126F1C;
	Fri, 19 Apr 2024 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="ANrKX3bK"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6DB19E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532805; cv=none; b=ZF7XyQ870AkZjm3VvtUwrm24WZnPFkVU7paJcNCqzJkiW4KDSY22IkpzQ/Y+W+Wf17vd66ca8MLyWA9GtjSiO7wtCIrQLmTYd+kTg2IJsYYDiZp4mW1edbYviYMaA6VdyF0Q10L0NxpjCtkAQS2KqfUNcOII8N6eG7ed0m5Ac0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532805; c=relaxed/simple;
	bh=HTBoo8zhSJDCt7l8z+9r2HDBjxGVaSx1+mDacCrdVCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7+8uRVaJzf0qUaHFcB8LG6UvwzNwdEq9Cgab7G+ThWvCt3r1yxakIlBlIVFBsRcX4sVJlbskYMXwl4s8ZO++uLf0MyuoLPCI5esJDmtwV6YawfqPBNySwPcAmIVMkW+U3S70ifxSIl3+577jR2jkVgzo6X6oodDu6mrCWGIDOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=ANrKX3bK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4196c62bb6fso3466455e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1713532802; x=1714137602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iv+zkoFSYjDMgbmcXOx+HmVbBJHG5ksXmhbMJT+VLWc=;
        b=ANrKX3bKoVxKkqS0/wn1xwrsuYsW+C8Dgmnm16L1ch3CQ9dAfEQZerOg8C6vxeanTA
         vsynUsmiWRVdPtxNrf9ppfPaEhXnq2DuzAppQCWGqPaGohwU7nU2G8BDqfIZPUtYpBqf
         Heg+Vor70K3oElOv03jVNjvRpkHb2Ve62aR+apKS7dBbRq3R/f4/CWcsIfF8WIHNe8GM
         1qMZnCeAGJE9vIvigSCQ+3xy5taDBVlmWXlZLxEYEVqloJaDzGI5qP5yzQ0gqfyr65kU
         dlHpW9nkEbz6X4I1yyKhxEihcSnKEsYe9lOWA/lX6tAW1MTf5iZuib9vXF2++LDPxeG2
         ReVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713532802; x=1714137602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iv+zkoFSYjDMgbmcXOx+HmVbBJHG5ksXmhbMJT+VLWc=;
        b=TaYFt4LIzNJBZUZqVsE4fVFG68wX8i2IktjjipHvj0SJvwDiGXqfKWP+Q20FhYlc93
         p8gW8awYvMZxMs2CV+hGRHd+6Hc3/AYD+BjA0FnK8zRj8fGlW1+B6awcnVvng0yCxCgK
         tVNm8NLXQflbX8zYMpYI8GMT2jn8q4LNEqzlmWSprwkbZPmHN6VzF71CcclRsSk4RK/D
         J5/8WWgb8gYOHMJC/B5Nhd0X1H8YNHjyi8HwgQisLNUmmT82fYVO9qiIO589S3R98P0P
         LKOtXktp2QgHkeKdlOJhrBvDajLzwgL4BC4QbX1zvGyFEPBe0qVWEJjtZfJIY+Hwv6KB
         M9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4/5E0RGqpZLFDlnOoRgBGmKAmjDlivcJdqB3LsTwj/EcZNJ3cUhv6cLdSee5MQFt5nepERXKWWjsuQDzU0iTqp20kpdMP24LS4ku0
X-Gm-Message-State: AOJu0Yz9WWN48vznYGvMHz6DThz9+TaWAVxAeHCdGD+8gsZwKGCLaxnt
	W2ysbOwV9HK5dBS0aajlYvvGrUhaSpLbj/SIQX4pzp0sO7MphOrN+NpeNSnITQM=
X-Google-Smtp-Source: AGHT+IFpFSt6GoqU2Hyg9cf+0FUQmsyX2PgKa2XdvbqdC1cam0hmYuQFihGVYeLZZkqf5n4OkOkqDg==
X-Received: by 2002:a05:600c:1d0f:b0:418:f6b7:a383 with SMTP id l15-20020a05600c1d0f00b00418f6b7a383mr1410483wms.2.1713532801675;
        Fri, 19 Apr 2024 06:20:01 -0700 (PDT)
Received: from airbuntu ([213.120.255.186])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b00418d434ae4esm6446985wmq.10.2024.04.19.06.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 06:20:01 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:19:58 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Ashay Jaiswal <quic_ashayj@quicinc.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
	quic_anshar@quicinc.com, quic_atulpant@quicinc.com,
	quic_shashim@quicinc.com, quic_rgottimu@quicinc.com,
	quic_adharmap@quicinc.com, quic_kshivnan@quicinc.com,
	quic_pkondeti@quicinc.com
Subject: Re: [PATCH v2 8/8] sched/pelt: Introduce PELT multiplier
Message-ID: <20240419131958.s46xbqtmvr2yjn6j@airbuntu>
References: <20231208002342.367117-1-qyousef@layalina.io>
 <20231208002342.367117-9-qyousef@layalina.io>
 <a561029e-993d-726d-18ce-0bc014e6533c@quicinc.com>
 <20240121000444.ghue2miejmiair6l@airbuntu>
 <8dfb5db7-6da0-4f6f-30ef-8966428e4a1c@quicinc.com>
 <CAKfTPtB=nv7DDqTvsdenOg+UNoNFx=f2SLvihHx+CMkeE6NyNA@mail.gmail.com>
 <2270ebb6-3830-d667-1b9e-2efc96746b94@quicinc.com>
 <c1f8c627-6497-4598-8b71-6be45e9c12f1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1f8c627-6497-4598-8b71-6be45e9c12f1@quicinc.com>

Hi Ashay

On 04/12/24 15:36, Ashay Jaiswal wrote:
> On 2/6/2024 10:37 PM, Ashay Jaiswal wrote:
> > 
> > 
> > On 1/30/2024 10:58 PM, Vincent Guittot wrote:
> >> On Sun, 28 Jan 2024 at 17:22, Ashay Jaiswal <quic_ashayj@quicinc.com> wrote:
> >>>
> >>> Hello Qais Yousef,
> >>>
> >>> Thank you for your response.
> >>>
> >>> On 1/21/2024 5:34 AM, Qais Yousef wrote:
> >>>> Hi Ashay
> >>>>
> >>>> On 01/20/24 13:22, Ashay Jaiswal wrote:
> >>>>> Hello Qais Yousef,
> >>>>>
> >>>>> We ran few benchmarks with PELT multiplier patch on a Snapdragon 8Gen2
> >>>>> based internal Android device and we are observing significant
> >>>>> improvements with PELT8 configuration compared to PELT32.
> >>>>>
> >>>>> Following are some of the benchmark results with PELT32 and PELT8
> >>>>> configuration:
> >>>>>
> >>>>> +-----------------+---------------+----------------+----------------+
> >>>>> | Test case                       |     PELT32     |     PELT8      |
> >>>>> +-----------------+---------------+----------------+----------------+
> >>>>> |                 |    Overall    |     711543     |     971275     |
> >>>>> |                 +---------------+----------------+----------------+
> >>>>> |                 |    CPU        |     193704     |     224378     |
> >>>>> |                 +---------------+----------------+----------------+
> >>>>> |ANTUTU V9.3.9    |    GPU        |     284650     |     424774     |
> >>>>> |                 +---------------+----------------+----------------+
> >>>>> |                 |    MEM        |     125207     |     160548     |
> >>>>> |                 +---------------+----------------+----------------+
> >>>>> |                 |    UX         |     107982     |     161575     |
> >>>>> +-----------------+---------------+----------------+----------------+
> >>>>> |                 |   Single core |     1170       |     1268       |
> >>>>> |GeekBench V5.4.4 +---------------+----------------+----------------+
> >>>>> |                 |   Multi core  |     2530       |     3797       |
> >>>>> +-----------------+---------------+----------------+----------------+
> >>>>> |                 |    Twitter    |     >50 Janks  |     0          |
> >>>>> |     SCROLL      +---------------+----------------+----------------+
> >>>>> |                 |    Contacts   |     >30 Janks  |     0          |
> >>>>> +-----------------+---------------+----------------+----------------+
> >>>>>
> >>>>> Please let us know if you need any support with running any further
> >>>>> workloads for PELT32/PELT8 experiments, we can help with running the
> >>>>> experiments.
> >>>>
> >>>> Thanks a lot for the test results. Was this tried with this patch alone or
> >>>> the whole series applied?
> >>>>
> >>> I have only applied patch8(sched/pelt: Introduce PELT multiplier) for the tests.
> >>>
> >>>> Have you tried to tweak each policy response_time_ms introduced in patch
> >>>> 7 instead? With the series applied, boot with PELT8, record the response time
> >>>> values for each policy, then boot back again to PELT32 and use those values.
> >>>> Does this produce similar results?
> >>>>
> >>> As the device is based on 5.15 kernel, I will try to pull all the 8 patches
> >>> along with the dependency patches on 5.15 and try out the experiments as
> >>> suggested.
> >>
> >> Generally speaking, it would be better to compare with the latest
> >> kernel or at least close and which includes new features added since
> >> v5.15 (which is more than 2 years old now). I understand that this is
> >> not always easy or doable but you could be surprised by the benefit of
> >> some features like [0] merged since v5.15
> >>
> >> [0] https://lore.kernel.org/lkml/249816c9-c2b5-8016-f9ce-dab7b7d384e4@arm.com/
> >>
> > Thank you Vincent for the suggestion, I will try to get the results on device running
> > with most recent kernel and update.
> > 
> > Thanks,
> > Ashay Jaiswal
> 
> Hello Qais Yousef and Vincent,
> 
> Sorry for the delay, setting up internal device on latest kernel is taking more time than anticipated.
> We are trying to bring-up latest kernel on the device and will complete the testing with the latest
> cpufreq patches as you suggested.
> 
> Regarding PELT multiplier patch [1], are we planning to merge it separately or will it be merged
> altogether with the cpufreq patches?
> 
> [1]: https://lore.kernel.org/all/20231208002342.367117-9-qyousef@layalina.io/

I am working on updated version. I've been analysing the problem more since the
last posting and found more issues to fix and enhance the response time of the
system in terms of migration and DVFS.

For the PELT multiplier, I have an updated patch now based on Vincent
suggestion of a different implementation without anew clodk. I will include
that, but haven't been testing this part so far.

I hope to send the new version soon. Will CC you so you can try and see if
these improvements help. In my view the boot time PELT multiplier is only
necessary to help low-end type of system where the max performance is
relatively low, but the scheduler has a constant model (and response time)
which means they need to a different default behavior so workloads reach this
max performance point faster.

I can potentially see a powerful system needing that, but IMHO the trade-off
with power will be very costly. If everything goes to plan, I hope we can
introduce a per-task util_est_faster like Peter suggested in earlier discussion
which should help workload that needs best ST perf to reach that faster without
changing the system default behavior.

The biggest challenge is handling those bursty tasks, and I hope the proposal
I am working on will put us on the right direction in terms of better default
behavior for those tasks.

If you have any analysis on why you think faster PELT helps, that'd be great to
share.


Cheers

--
Qais Yousef

