Return-Path: <linux-kernel+bounces-131254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C3898555
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942F81F24B01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7B080BF7;
	Thu,  4 Apr 2024 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdmvL/MB"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5B38DD1;
	Thu,  4 Apr 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227562; cv=none; b=UdrMjTdx1TTqfLziB+yF3ZBB+eTEdUjItjAr2eIBvte0/j0JqGZA7XHDKAjhwrT71HMS2PHUOaszyIHXg8zOVhP7hLhdD172Omawbxstz9/EPq21esoIdkPdhqT7QWCxcp0IzzvX5gK9tkc+NJlWBOQlTqQvc92ma0Y9nPaj1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227562; c=relaxed/simple;
	bh=ePPMM/uIseZje0ZcIe4lHLIZ0Wj4HLiZRHfwugMfC08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKb3KhEsDFg2ZzfWrqaLPqBwwr9PVX9RVIWdKHrveZ3jUGXYT7H+IyZclkWsYJUAI96I2vknQVgRfV1eRNt1LSDoeLoKl6ZZYtcYQj2Ahn10fmZbi/R6vC/p3egakG11kC0y0qpm768LQgU8L9g5P9eXOpDFfvXjPMWRVEmRSB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdmvL/MB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5193f56986so25153966b.0;
        Thu, 04 Apr 2024 03:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712227559; x=1712832359; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F/B6UBwFbisopXHNcGO9MAQyxZ/hbRouxLNeeE3qnFQ=;
        b=UdmvL/MBM0WrFHCdPUDLQ0S1t/W8Rkph1rANEJkNmLIr4Gy+EDUbLNpf+CFS6LMlVL
         GdBpvi2Yx3qOH/XmBunoZ+iViLqWDKjrgP9EZR93tE/fn4U/ryYscPJXv8aPtmz+KAR4
         8ezawz5XeeJTTBkRkMWQomVAJtokSawOoQuJnbkM7icz2/6ikOTuVUhc+iw8XyKc5O16
         qe572ztoyDM6PS9iUjGz7OmBIIkq7gOx+b6wdsF1so76O0jlqSDlNQHU7iMOka9tG7nh
         MjJiSsmwv6lS8aehn+F3vLPc2npnTKvgI03FTKy9UzWptmClOAyQJFczdXKLYzvUjkhb
         cL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712227559; x=1712832359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/B6UBwFbisopXHNcGO9MAQyxZ/hbRouxLNeeE3qnFQ=;
        b=WseqHV3uqH39PeL22KGbb6ip8vWdOJGqnPrzJi3CoqoV5iz6Wh4eXClrzMCgQHK3ef
         /HvUS8SrBw+ugdAxmiMAbfPDY3wGIbaf2SMrzTQ2LX6WVZDc4Mp1FtwU4RAE5d6hh4Ji
         4wrU5nu54jK75pMG/oyE38w3q6GqXbAy/KIpokGtHlPeDzqFgBJfpAzaSFk510ctsDn9
         4AYq3WmfszCZRntBKTx6eOVmZ5bIJM71Mq+fzVy5K6VhXZFBQ24kpGbZ4Y5Kq0drcMJG
         F94olmrHpk0BEhW2IOrAntCJcr9X4esG/cr952o5jH4FjM1x3QEaMe2ASjKJNrsZ4ZTU
         IEnA==
X-Forwarded-Encrypted: i=1; AJvYcCVA6nNmtq/O8u5+NawdASg71L2XPxZlDzWh2MfC3URWltDdaoq387M8K3F8QMzR1P4GEEx7muKIc0v0beV7Ktaojs9FpG29wg3FNrOn2N5aATc85lN1Ii5QNYphbNju6VLHXyt2qiBZKuP6kHsiEHouawlu7JeNXelpvZP8g5OC3Fh9rL32Xr4qZp6rW94Rg5PrTa8uA4Aw4P5yZyk0420Tyts83WIv7g==
X-Gm-Message-State: AOJu0YzBUuERcFRZ/aXxLx7oVupcfnTJhtE6ovuNsXJoI1j16HM4oku1
	7t9axN/v0yMDBM8n4HWlITrfJ6NgPhc+LwtyXfGWDDQj2dmlyVA7
X-Google-Smtp-Source: AGHT+IE/1NLjMS8nR+IXCRExhY8KPmE74KM21lSRlzizDo1/vs09k4iCje3Q2udrPyYWdVVbVFLRFw==
X-Received: by 2002:a17:907:10c2:b0:a4e:21e0:2e6e with SMTP id rv2-20020a17090710c200b00a4e21e02e6emr1249068ejb.5.1712227559174;
        Thu, 04 Apr 2024 03:45:59 -0700 (PDT)
Received: from jonhaslam-mbp.dhcp.thefacebook.com ([2620:10d:c092:500::7:2535])
        by smtp.gmail.com with ESMTPSA id wn2-20020a170907068200b00a4e781bd30dsm4060237ejb.24.2024.04.04.03.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:45:58 -0700 (PDT)
Date: Thu, 4 Apr 2024 11:45:55 +0100
From: Jonthan Haslam <jonathan.haslam@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, andrii@kernel.org, bpf@vger.kernel.org, rostedt@goodmis.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
Message-ID: <ktzm722fdhwmtjfbvoymaof2k2jh53x627swbswi24d4hq7aes@yje5kzpmzizy>
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
 <20240325120323.ec3248d330b2755e73a6571e@kernel.org>
 <CAEf4BzZS_QCsSY0oGY_3pGveGfXKK_TkVURyNq=UQXVXSqi2Fw@mail.gmail.com>
 <20240327084245.a890ae12e579f0be1902ae4a@kernel.org>
 <54jakntmdyedadce7yrf6kljcjapbwyoqqt26dnllrqvs3pg7x@itra4a2ikgqw>
 <20240328091841.ce9cc613db375536de843cfb@kernel.org>
 <5yvc6rdiovfjlfpayet57ocqpo3wft3onk6of5sqoh6wjngwhr@blky37q5cuk3>
 <CAEf4BzbFR-EaQV7pyv4q-2o8q-b65rO6gYmrLBp82RomWwu7nA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbFR-EaQV7pyv4q-2o8q-b65rO6gYmrLBp82RomWwu7nA@mail.gmail.com>

> > Things to note about the results:
> >
> > - The results are slightly variable so don't get too caught up on
> >   individual thread count - it's the trend that is important.
> > - In terms of throughput with this specific benchmark a *very* macro view
> >   is that the RW spinlock provides 40-60% more throughput than the
> >   spinlock.  The per-CPU RW semaphore provides in the order of 50-100%
> >   more throughput then the spinlock.
> > - This doesn't fully reflect the large reduction in latency that we have
> >   seen in application based measurements. However, it does demonstrate
> >   that even the trivial change of going to a RW spinlock provides
> >   significant benefits.
> 
> This is probably because trig-uprobe-nop creates a single uprobe that
> is triggered on many CPUs. While in production we have also *many*
> uprobes running on many CPUs. In this benchmark, besides contention on
> uprobes_treelock, we are also hammering on other per-uprobe locks
> (register_rwsem, also if you don't have [0] patch locally, there will
> be another filter lock taken each time, filter->rwlock). There is also
> atomic refcounting going on, which when you have the same uprobe
> across all CPUs at the same time will cause a bunch of cache line
> bouncing.
> 
> So yes, it's understandable that in practice in production you see an
> even larger effect of optimizing uprobe_treelock than in this
> micro-benchmark.
> 
>   [0] https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/commit/?h=probes/for-next&id=366f7afd3de31d3ce2f4cbff97c6c23b6aa6bcdf

Thanks for the reply and the thoughts on this Andrii. Yes, I do have the
filter->rwlock fix applied but, as you say, there are no doubt other
effects at play here as to be expected in such a synthetic workload. I'm
pleased with the outcomes though as they show a good result even if they
are at the lower end of what I expect.

The results also show that pursuing an RCU solution is definitely worth it
but that write penalty is brutal in the case of a full synchronize_rcu()!
Should be fun.

> > for num_threads in {1..20}
> > do
> >     sudo ./bench -p $num_threads trig-uprobe-nop | grep Summary
> 
> just want to mention -a (affinity) option that you can pass a bench
> tool, it will pin each thread on its own CPU. It generally makes tests
> more uniform, eliminating CPU migrations variability.

Thanks for pointing that flag  out!

Jon.

> 
> > done
> >
> >
> > spinlock
> >
> > Summary: hits    1.453 ± 0.005M/s (  1.453M/prod)
> > Summary: hits    2.087 ± 0.005M/s (  1.043M/prod)
> > Summary: hits    2.701 ± 0.012M/s (  0.900M/prod)
> 
> I also wanted to point out that the first measurement (1.453M/s in
> this row) is total throughput across all threads, while value in
> parenthesis (0.900M/prod) is averaged throughput per each thread. So
> this M/prod value is the most interesting in this benchmark where we
> assess the effect of reducing contention.
> 
> > Summary: hits    1.917 ± 0.011M/s (  0.479M/prod)
> > Summary: hits    2.105 ± 0.003M/s (  0.421M/prod)
> > Summary: hits    1.615 ± 0.006M/s (  0.269M/prod)
> 
> [...]

