Return-Path: <linux-kernel+bounces-123693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179BD890CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB70293DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0113B287;
	Thu, 28 Mar 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="GAoOxsgI"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF913A3E6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662962; cv=none; b=ccU0/tkEsuydoXfUCSr1dGKLi4y5YwCrVrnQKNz2Mopxittn5ZzOSUqJwLWH2k+J40DiqRxV4gmIh+S493V8TlO5s7tOggCK1cilzEH+3D118YOiaIjO7MFiL8QFPuypxkaJQsMsEGW63Ai8Vnl8NRa2Wgx8fMoVujv8Stk52cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662962; c=relaxed/simple;
	bh=DlyCLxFd0/yFr8eXyLd5L3/VUyTryozD2axw8iYVOIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDU1ZDu8Wti601JsEkOnLMf4b8m/Fank9KZSFGsH5cVUIg/j1ZvERjep9UPolRZql9+AKT0VpNOUs/8rkMMHHntOnWpAOk8HNSCp3by0zunt9M2GEKSv8OhjKA1Rwxwx/KLUhXZBX6x+4Zg3/QANDjXEJk4SgiaLwR8Gg2GuUoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=GAoOxsgI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4149521d76aso9873525e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711662959; x=1712267759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qYWfoSnmbxKwXE32NRkk5pq/wp2s6I/haq1yw26Rqb8=;
        b=GAoOxsgIB/7+ztZHAvzX5ghlX1D8LKW/S2UkXN7UQslVb4IXJ0MHhp/6Lp66LD4j+B
         myk7dg6xBtHQwufU6AStHp4xA1Ii7HcTNogEm2RNY1SIWmWXk52/A06wImp0AeiyERlP
         eegYuDjLJaS2J/v9FhHgSly4ArLKoqtYaR/wlDcL/T3sYbuXiKimV14aOSaeKgoAW/qA
         asfUrDWdz0Ul3+YL03WTwLkC5EXia+WVPA4CyepQ7ajkoToceT4jW4w9ZxTKGXalIvVK
         Thnond2KW2E37ifTXJuq3clUDCbfrGrvL+YayxnmHR4Id7V+DnlQegNzkdR1UQYU/U3U
         ZRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711662959; x=1712267759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYWfoSnmbxKwXE32NRkk5pq/wp2s6I/haq1yw26Rqb8=;
        b=npQAOUO7aNagQFnT9O/KEaiMUziSAk3FYtrPMW++apIiwwWFttcHzRyWGxDOIOy9yK
         sLMWbruaM++DApK8vtbcctn1GjgJKflsKK3CKh9m32+rXyehFIirzBNekvqadbDOkwdN
         HX7cCcOxGa19cew77k0igNoWxqxqsyv9B8dOVI2VmVPzRSeAZFfasgaHESDMtPCeaoSJ
         ydI3bgBx1Nk8bXv8eGHfXdcZR/1UnOfxe733bYD1oCt6dkISTP6IfCKUhrUGvH6KrlxO
         Lhh0jlMfUTwOizOBdeOOPkExUbZmjhUCnENId0pUDJj4kKx4H85vRY/in6Dvnt2842YA
         R6RA==
X-Forwarded-Encrypted: i=1; AJvYcCVSpR1OygyFeQVo+EiaVfDXx3Z0Acm8lcnK59xdHOSOqILnagoK3tBMrVyjho6lcsNWgERow02MnLswtlaBLxP2fJatIleMocKidsBE
X-Gm-Message-State: AOJu0YxQdmII4ZQRrCi7h6OWUNQh/42kpwTOIRVX8ju8ZrsdYTIKaqIO
	WyQ/ZwXXYtd5IRyev27VrEHqIefO+0CYTW1o7Dh9MKpfpqmMclTeW3Jgr58+NdY=
X-Google-Smtp-Source: AGHT+IFpP5wRfNXTP35MbPkW/rtv1p/yJQeIxbL37GabuG6TljqlXXqeZdRgAaPhhbRge5XvMaVeEQ==
X-Received: by 2002:a05:600c:3151:b0:414:a8d:ca39 with SMTP id h17-20020a05600c315100b004140a8dca39mr375058wmo.6.1711662958626;
        Thu, 28 Mar 2024 14:55:58 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id fb10-20020a05600c520a00b00414957185ebsm3507560wmb.27.2024.03.28.14.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 14:55:58 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:55:56 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched: Consolidate cpufreq updates
Message-ID: <20240328215556.afaynyoldoizhcpr@airbuntu>
References: <20240324020139.1032473-1-qyousef@layalina.io>
 <ZgKFT5b423hfQdl9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgKFT5b423hfQdl9@gmail.com>

On 03/26/24 09:20, Ingo Molnar wrote:
> 
> * Qais Yousef <qyousef@layalina.io> wrote:
> 
> > Results of `perf stat --repeat 10 perf bench sched pipe` on AMD 3900X to
> > verify any potential overhead because of the addition at context switch
> > 
> > Before:
> > -------
> > 
> > 	Performance counter stats for 'perf bench sched pipe' (10 runs):
> > 
> > 		 16,839.74 msec task-clock:u              #    1.158 CPUs utilized            ( +-  0.52% )
> > 			 0      context-switches:u        #    0.000 /sec
> > 			 0      cpu-migrations:u          #    0.000 /sec
> > 		     1,390      page-faults:u             #   83.903 /sec                     ( +-  0.06% )
> > 	       333,773,107      cycles:u                  #    0.020 GHz                      ( +-  0.70% )  (83.72%)
> > 		67,050,466      stalled-cycles-frontend:u #   19.94% frontend cycles idle     ( +-  2.99% )  (83.23%)
> > 		37,763,775      stalled-cycles-backend:u  #   11.23% backend cycles idle      ( +-  2.18% )  (83.09%)
> > 		84,456,137      instructions:u            #    0.25  insn per cycle
> > 							  #    0.83  stalled cycles per insn  ( +-  0.02% )  (83.01%)
> > 		34,097,544      branches:u                #    2.058 M/sec                    ( +-  0.02% )  (83.52%)
> > 		 8,038,902      branch-misses:u           #   23.59% of all branches          ( +-  0.03% )  (83.44%)
> > 
> > 		   14.5464 +- 0.0758 seconds time elapsed  ( +-  0.52% )
> > 
> > After:
> > -------
> > 
> > 	Performance counter stats for 'perf bench sched pipe' (10 runs):
> > 
> > 		 16,219.58 msec task-clock:u              #    1.130 CPUs utilized            ( +-  0.80% )
> > 			 0      context-switches:u        #    0.000 /sec
> > 			 0      cpu-migrations:u          #    0.000 /sec
> > 		     1,391      page-faults:u             #   85.163 /sec                     ( +-  0.06% )
> > 	       342,768,312      cycles:u                  #    0.021 GHz                      ( +-  0.63% )  (83.36%)
> > 		66,231,208      stalled-cycles-frontend:u #   18.91% frontend cycles idle     ( +-  2.34% )  (83.95%)
> > 		39,055,410      stalled-cycles-backend:u  #   11.15% backend cycles idle      ( +-  1.80% )  (82.73%)
> > 		84,475,662      instructions:u            #    0.24  insn per cycle
> > 							  #    0.82  stalled cycles per insn  ( +-  0.02% )  (83.05%)
> > 		34,067,160      branches:u                #    2.086 M/sec                    ( +-  0.02% )  (83.67%)
> > 		 8,042,888      branch-misses:u           #   23.60% of all branches          ( +-  0.07% )  (83.25%)
> > 
> > 		    14.358 +- 0.116 seconds time elapsed  ( +-  0.81% )
> 
> Noise caused by too many counters & the vagaries of multi-CPU scheduling is 
> drowning out any results here.
> 
> I'd suggest somethig like this to measure same-CPU context-switching 
> overhead:
> 
>     taskset 1 perf stat --repeat 10 -e cycles,instructions,task-clock perf bench sched pipe
> 
> ... and make sure the cpufreq governor is at 'performance' first:

performance governor won't stress the patch as the static key should bypass the
new code

> 
>     for ((cpu=0; cpu < $(nproc); cpu++)); do echo performance > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor; done

There's this short hand if you like

	echo performance | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_governor

> 
> With that approach you should much, much lower noise levels even with just 
> 3 runs:
> 
>  Performance counter stats for 'perf bench sched pipe' (3 runs):
> 
>     51,616,501,297      cycles                           #    3.188 GHz                         ( +-  0.05% )
>     37,523,641,203      instructions                     #    0.73  insn per cycle              ( +-  0.08% )
>          16,191.01 msec task-clock                       #    0.999 CPUs utilized               ( +-  0.04% )
> 
>           16.20511 +- 0.00578 seconds time elapsed  ( +-  0.04% )

Thanks for the tips!

I repeated the test using taskset and fewer counters for performance and
schedutil


tip: schedutil:
---------------

 Performance counter stats for 'perf bench sched pipe' (10 runs):

       829,076,881      cycles:u                  #    0.077 GHz                      ( +-  1.26% )
        82,712,937      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
         10,735.67 msec task-clock:u              #    1.002 CPUs utilized            ( +-  0.08% )

          10.71758 +- 0.00840 seconds time elapsed  ( +-  0.08% )

tip: performance:
-----------------

 Performance counter stats for 'perf bench sched pipe' (10 runs):

       871,744,951      cycles:u                  #    0.079 GHz                      ( +-  1.04% )
        82,711,239      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
         11,076.50 msec task-clock:u              #    1.004 CPUs utilized            ( +-  0.20% )

           11.0374 +- 0.0216 seconds time elapsed  ( +-  0.20% )

tip+patch: schedutil:
---------------------

 Performance counter stats for 'perf bench sched pipe' (10 runs):

       836,767,470      cycles:u                  #    0.078 GHz                      ( +-  0.69% )
        82,712,893      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
         10,825.83 msec task-clock:u              #    1.005 CPUs utilized            ( +-  0.12% )

           10.7751 +- 0.0128 seconds time elapsed  ( +-  0.12% )

tip+patch: performance:
-----------------------

 Performance counter stats for 'perf bench sched pipe' (10 runs):

       842,037,546      cycles:u                  #    0.077 GHz                      ( +-  0.97% )
        82,717,942      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
         10,921.37 msec task-clock:u              #    0.996 CPUs utilized            ( +-  0.18% )

           10.9629 +- 0.0202 seconds time elapsed  ( +-  0.18% )


Thanks!

--
Qais Yousef

