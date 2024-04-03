Return-Path: <linux-kernel+bounces-129636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D8A896DA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 238D9B2859C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273E071736;
	Wed,  3 Apr 2024 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF5EwxrM"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA21139581;
	Wed,  3 Apr 2024 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142324; cv=none; b=eIQywWjZ5Tv74QA0J1DVXaVAhOXjaXtyqDJ5Vnb07G6fZuzW2ubez309XxqletXUNCgTvU2sUh6vqv22pENwjE3+xT4l9Zz69pAtKQ1eF0lM1JvKpyNLjsi55t9a503cb5JbcIPJl5rDknWLwLdpduHqGVOf48BHwOdJMNJVS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142324; c=relaxed/simple;
	bh=w18UVu/TU5bC9jQqSryPrDVzIgbmEeVdpghUNQpemyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2LIlYG4gFURdLDcJirtJMk1xCuXXs5A1dl96iiGynQcA8yFmpzKsfwi0g36V3K2Op4dAABg+WuORnpPj7CVDhlrOMKRjEy/p3s66rn5xHFB0RLrXsntjOPVl6qQdbqpkzUIq8PZ2vR3frSkE2rkFq+FWfw1e0l8p8s89tHOXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PF5EwxrM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56df377bd13so2159724a12.0;
        Wed, 03 Apr 2024 04:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712142320; x=1712747120; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uTa8/TOckEyTpCdBl7olLE+j8uZidjm/TMH1XrW2qkA=;
        b=PF5EwxrM/xHaB8H3yTJIIT1CiRCMmxurwoCyekCQIhjvvVmOc+Pq5buR4t9/okvKuA
         aSSduU3imy6WSejZZo+nWkGh5le2KgYPVkM9p4nOf5CisEmOx2TGRMa/xcGDquJ5uZSe
         xhRzaPsEBaK1/06HExxMLntsrJYaxOpn+KTOU1FDmT9sitTi7R2jA7SJGF0LuNy5m2qL
         sNDotinPLibhQhQ3t7gyDpXUFRZirv5ZBHcmEZ41mIKh+b+49x+U85RBAvVkCqswevkx
         fsxLTRUmMLPuSOEDNjumuUEeE70H+iKQwT3QXIDAg9Ru9XHjQX4MMnO7ieULwoljk8rV
         jqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712142320; x=1712747120;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTa8/TOckEyTpCdBl7olLE+j8uZidjm/TMH1XrW2qkA=;
        b=vizDw1zEE3+AuUjqhNiZMk9CX0DOQhTAj8gghKcYxgL2r+2kgy4e3AIoUMkSbn4GxM
         GbT3Y0Ljgice1/vdAlRaRjjkZXvJaTO479RyTetGRIQkC7nJfZy1maNqDi7DcbspmHhY
         i9GbVXJ3Z4c8aFHRHj3mQNBBVnWGfvgHIgmEmLLTsDNhBAaKJIlheN6xYh/V+YD7cx/H
         wpG9UiwJrzg1xb4Iq4bNu6oaBsps73eT87gORapTe2i9LhWLcdyLLhPavABdJ+tdv8ah
         paf8cBcGslXNEof9ten2h56nktu5/cj0AwLwHZHaYqXW9ez7Pb5/Qci3kDRcC0TpGEog
         wUlA==
X-Forwarded-Encrypted: i=1; AJvYcCU584VqPBXTU72dOjbi7RVHJGCAGoYhxZ94MgLvaGF13Eo7E/oBWDSnUdeLljvtKRo7JlX4WvkwU/eDUuhiaNbtKoN+puB0yNHXvEF/Jt3aPjTrVFaSZvCjbfC8vDAfbg+jh9h+dHeVAEFlvpG7cCK3Grfk0b+ofnUnPJk6eEChzXUbefWpQsBbZqxZzxYa2Ta7j7AES3ju4Q5ftcs9uUUe+2L6UiGcbg==
X-Gm-Message-State: AOJu0YxEvXJi8fdn21S+1hViV0x7ToqAnIu82J5D6h3wLs50qHiOHFhY
	5/86bXguVTjRIh1YjYqBUQLag/DOqpGuzfmubl6Nh3Y1j1j8Acxj
X-Google-Smtp-Source: AGHT+IH3UuYlS2hljnHx5KnGJBypuk1UtnhWXyO/31w1MhNfOjxHFjgdTOAY7TOIKWDlG+e+AcUDqg==
X-Received: by 2002:a05:6402:3507:b0:56b:9b69:2e81 with SMTP id b7-20020a056402350700b0056b9b692e81mr10836228edd.27.1712142319992;
        Wed, 03 Apr 2024 04:05:19 -0700 (PDT)
Received: from jonhaslam-mbp.dhcp.thefacebook.com ([2620:10d:c092:400::5:2b67])
        by smtp.gmail.com with ESMTPSA id fi8-20020a056402550800b0056c509a11acsm7814866edb.33.2024.04.03.04.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 04:05:19 -0700 (PDT)
Date: Wed, 3 Apr 2024 12:05:18 +0100
From: Jonthan Haslam <jonathan.haslam@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	linux-trace-kernel@vger.kernel.org, andrii@kernel.org, bpf@vger.kernel.org, rostedt@goodmis.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
Message-ID: <5yvc6rdiovfjlfpayet57ocqpo3wft3onk6of5sqoh6wjngwhr@blky37q5cuk3>
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
 <20240325120323.ec3248d330b2755e73a6571e@kernel.org>
 <CAEf4BzZS_QCsSY0oGY_3pGveGfXKK_TkVURyNq=UQXVXSqi2Fw@mail.gmail.com>
 <20240327084245.a890ae12e579f0be1902ae4a@kernel.org>
 <54jakntmdyedadce7yrf6kljcjapbwyoqqt26dnllrqvs3pg7x@itra4a2ikgqw>
 <20240328091841.ce9cc613db375536de843cfb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328091841.ce9cc613db375536de843cfb@kernel.org>

> > > > Given the discussion around per-cpu rw semaphore and need for
> > > > (internal) batched attachment API for uprobes, do you think you can
> > > > apply this patch as is for now? We can then gain initial improvements
> > > > in scalability that are also easy to backport, and Jonathan will work
> > > > on a more complete solution based on per-cpu RW semaphore, as
> > > > suggested by Ingo.
> > > 
> > > Yeah, it is interesting to use per-cpu rw semaphore on uprobe.
> > > I would like to wait for the next version.
> > 
> > My initial tests show a nice improvement on the over RW spinlocks but
> > significant regression in acquiring a write lock. I've got a few days
> > vacation over Easter but I'll aim to get some more formalised results out
> > to the thread toward the end of next week.
> 
> As far as the write lock is only on the cold path, I think you can choose
> per-cpu RW semaphore. Since it does not do busy wait, the total system
> performance impact will be small.
> I look forward to your formalized results :)

Sorry for the delay in getting back to you on this Masami. 

I have used one of the bpf selftest benchmarks to provide some form of
comparison of the 3 different approaches (spinlock, RW spinlock and
per-cpu RW semaphore). The benchmark used here is the 'trig-uprobe-nop'
benchmark which just executes a single uprobe with a minimal bpf program
attached. The tests were done on a 32 core qemu/kvm instance.

Things to note about the results:

- The results are slightly variable so don't get too caught up on
  individual thread count - it's the trend that is important.
- In terms of throughput with this specific benchmark a *very* macro view
  is that the RW spinlock provides 40-60% more throughput than the
  spinlock.  The per-CPU RW semaphore provides in the order of 50-100%
  more throughput then the spinlock.
- This doesn't fully reflect the large reduction in latency that we have
  seen in application based measurements. However, it does demonstrate
  that even the trivial change of going to a RW spinlock provides
  significant benefits.

I haven't included the measurements on per-CPU RW semaphore write
performance as they are completely in line with those that Paul McKenney
posted on his journal [0]. On a 32 core system I see semaphore writes to
take in the order of 25-28 millisecs - the cost of the synchronize_rcu().

Each block of results below show 1 line per execution of the benchmark (the
"Summary" line) and each line is a run with one more thread added - a
thread is a "producer". The lines are edited to remove extraneous output
that adds no value here.

The tests were executed with this driver script:

for num_threads in {1..20}
do
    sudo ./bench -p $num_threads trig-uprobe-nop | grep Summary
done


spinlock

Summary: hits    1.453 ± 0.005M/s (  1.453M/prod)
Summary: hits    2.087 ± 0.005M/s (  1.043M/prod)
Summary: hits    2.701 ± 0.012M/s (  0.900M/prod)
Summary: hits    1.917 ± 0.011M/s (  0.479M/prod)
Summary: hits    2.105 ± 0.003M/s (  0.421M/prod)
Summary: hits    1.615 ± 0.006M/s (  0.269M/prod)
Summary: hits    2.046 ± 0.004M/s (  0.292M/prod)
Summary: hits    1.818 ± 0.002M/s (  0.227M/prod)
Summary: hits    1.867 ± 0.024M/s (  0.207M/prod)
Summary: hits    1.692 ± 0.003M/s (  0.169M/prod)
Summary: hits    1.778 ± 0.004M/s (  0.162M/prod)
Summary: hits    1.710 ± 0.011M/s (  0.142M/prod)
Summary: hits    1.687 ± 0.022M/s (  0.130M/prod)
Summary: hits    1.697 ± 0.004M/s (  0.121M/prod)
Summary: hits    1.645 ± 0.011M/s (  0.110M/prod)
Summary: hits    1.671 ± 0.002M/s (  0.104M/prod)
Summary: hits    1.692 ± 0.014M/s (  0.100M/prod)
Summary: hits    1.700 ± 0.015M/s (  0.094M/prod)
Summary: hits    1.668 ± 0.005M/s (  0.088M/prod)
Summary: hits    1.644 ± 0.004M/s (  0.082M/prod)


RW spinlock

Summary: hits    1.465 ± 0.008M/s (  1.465M/prod)
Summary: hits    1.750 ± 0.035M/s (  0.875M/prod)
Summary: hits    2.164 ± 0.008M/s (  0.721M/prod)
Summary: hits    2.235 ± 0.014M/s (  0.559M/prod)
Summary: hits    2.202 ± 0.005M/s (  0.440M/prod)
Summary: hits    2.816 ± 0.003M/s (  0.469M/prod)
Summary: hits    2.364 ± 0.002M/s (  0.338M/prod)
Summary: hits    2.327 ± 0.008M/s (  0.291M/prod)
Summary: hits    2.147 ± 0.005M/s (  0.239M/prod)
Summary: hits    2.266 ± 0.011M/s (  0.227M/prod)
Summary: hits    2.483 ± 0.003M/s (  0.226M/prod)
Summary: hits    2.573 ± 0.008M/s (  0.214M/prod)
Summary: hits    2.569 ± 0.004M/s (  0.198M/prod)
Summary: hits    2.507 ± 0.013M/s (  0.179M/prod)
Summary: hits    2.165 ± 0.008M/s (  0.144M/prod)
Summary: hits    2.524 ± 0.004M/s (  0.158M/prod)
Summary: hits    2.059 ± 0.020M/s (  0.121M/prod)
Summary: hits    2.332 ± 0.007M/s (  0.130M/prod)
Summary: hits    2.404 ± 0.017M/s (  0.127M/prod)
Summary: hits    2.187 ± 0.002M/s (  0.109M/prod)


per-CPU RW semaphore

Summary: hits    1.341 ± 0.017M/s (  1.341M/prod)
Summary: hits    2.397 ± 0.011M/s (  1.198M/prod)
Summary: hits    3.547 ± 0.041M/s (  1.182M/prod)
Summary: hits    4.108 ± 0.016M/s (  1.027M/prod)
Summary: hits    3.138 ± 0.055M/s (  0.628M/prod)
Summary: hits    3.247 ± 0.017M/s (  0.541M/prod)
Summary: hits    2.877 ± 0.005M/s (  0.411M/prod)
Summary: hits    2.880 ± 0.002M/s (  0.360M/prod)
Summary: hits    2.579 ± 0.001M/s (  0.287M/prod)
Summary: hits    2.982 ± 0.011M/s (  0.298M/prod)
Summary: hits    2.603 ± 0.002M/s (  0.237M/prod)
Summary: hits    3.013 ± 0.004M/s (  0.251M/prod)
Summary: hits    3.059 ± 0.001M/s (  0.235M/prod)
Summary: hits    2.721 ± 0.014M/s (  0.194M/prod)
Summary: hits    2.943 ± 0.005M/s (  0.196M/prod)
Summary: hits    3.366 ± 0.011M/s (  0.210M/prod)
Summary: hits    2.459 ± 0.001M/s (  0.145M/prod)
Summary: hits    3.023 ± 0.024M/s (  0.168M/prod)
Summary: hits    2.919 ± 0.002M/s (  0.154M/prod)
Summary: hits    2.569 ± 0.002M/s (  0.128M/prod)

[0] https://paulmck.livejournal.com/67547.html

Thanks.

Jon.

> 
> Thank you,
> 
> > 
> > Jon.
> > 
> > > 
> > > Thank you,
> > > 
> > > > 
> > > > >
> > > > > BTW, how did you measure the overhead? I think spinlock overhead
> > > > > will depend on how much lock contention happens.
> > > > >
> > > > > Thank you,
> > > > >
> > > > > >
> > > > > > [0] https://docs.kernel.org/locking/spinlocks.html
> > > > > >
> > > > > > Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> > > > > > ---
> > > > > >  kernel/events/uprobes.c | 22 +++++++++++-----------
> > > > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > > > index 929e98c62965..42bf9b6e8bc0 100644
> > > > > > --- a/kernel/events/uprobes.c
> > > > > > +++ b/kernel/events/uprobes.c
> > > > > > @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
> > > > > >   */
> > > > > >  #define no_uprobe_events()   RB_EMPTY_ROOT(&uprobes_tree)
> > > > > >
> > > > > > -static DEFINE_SPINLOCK(uprobes_treelock);    /* serialize rbtree access */
> > > > > > +static DEFINE_RWLOCK(uprobes_treelock);      /* serialize rbtree access */
> > > > > >
> > > > > >  #define UPROBES_HASH_SZ      13
> > > > > >  /* serialize uprobe->pending_list */
> > > > > > @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
> > > > > >  {
> > > > > >       struct uprobe *uprobe;
> > > > > >
> > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > +     read_lock(&uprobes_treelock);
> > > > > >       uprobe = __find_uprobe(inode, offset);
> > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > +     read_unlock(&uprobes_treelock);
> > > > > >
> > > > > >       return uprobe;
> > > > > >  }
> > > > > > @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
> > > > > >  {
> > > > > >       struct uprobe *u;
> > > > > >
> > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > +     write_lock(&uprobes_treelock);
> > > > > >       u = __insert_uprobe(uprobe);
> > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > +     write_unlock(&uprobes_treelock);
> > > > > >
> > > > > >       return u;
> > > > > >  }
> > > > > > @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
> > > > > >       if (WARN_ON(!uprobe_is_active(uprobe)))
> > > > > >               return;
> > > > > >
> > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > +     write_lock(&uprobes_treelock);
> > > > > >       rb_erase(&uprobe->rb_node, &uprobes_tree);
> > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > +     write_unlock(&uprobes_treelock);
> > > > > >       RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> > > > > >       put_uprobe(uprobe);
> > > > > >  }
> > > > > > @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
> > > > > >       min = vaddr_to_offset(vma, start);
> > > > > >       max = min + (end - start) - 1;
> > > > > >
> > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > +     read_lock(&uprobes_treelock);
> > > > > >       n = find_node_in_range(inode, min, max);
> > > > > >       if (n) {
> > > > > >               for (t = n; t; t = rb_prev(t)) {
> > > > > > @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
> > > > > >                       get_uprobe(u);
> > > > > >               }
> > > > > >       }
> > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > +     read_unlock(&uprobes_treelock);
> > > > > >  }
> > > > > >
> > > > > >  /* @vma contains reference counter, not the probed instruction. */
> > > > > > @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
> > > > > >       min = vaddr_to_offset(vma, start);
> > > > > >       max = min + (end - start) - 1;
> > > > > >
> > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > +     read_lock(&uprobes_treelock);
> > > > > >       n = find_node_in_range(inode, min, max);
> > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > +     read_unlock(&uprobes_treelock);
> > > > > >
> > > > > >       return !!n;
> > > > > >  }
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

