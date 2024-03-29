Return-Path: <linux-kernel+bounces-124031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42B5891164
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102E41C29BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DAB219E8;
	Fri, 29 Mar 2024 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDIDpJ0O"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE61E516
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678100; cv=none; b=KIyxc9srX1kuq6O5JY/W1v0sO/P/DE9uG1y0oQDHwMbzNdn0iWQ2x1AG6RzXWag4/JHUdGEX5ZGJ5lkjBb3ePzYdjvRavlzwfMSsOqL9HjDWZwYLB49Wxug0A+47qyl3kerCAnIgLISt6Kiy0VcBPzslIap87ZWioSbx32B79zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678100; c=relaxed/simple;
	bh=dKZD1mCUX8lAyUbGN2qUjdW4OBAkBdD2j0gBbpJsO/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyIy58lzqQXJIeedv98PjmV01t4eB6+k4qe8oPjscQbDL65b07GvlKR3XKX6q2kJNiMcS9Ix6817OOCp4yLSYpbvIvVhgOy2pXhrQfhaBPCRSjy/z99AQx1AP6SgqFTgUkmjyfB6YPFZzPacsW4p0CIqb60do/1wE2/Bdu79NJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDIDpJ0O; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a02c4dffd2so1357794a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711678098; x=1712282898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pX+xlgHnVO0ivx09FP8o5h5//8YYHu0/1HElauId9Hc=;
        b=aDIDpJ0O4AeTAPY5V4YeZumnf9Ld3Pb/99Hvgb1TiE1bUtpul+6lf3WSQMLaDxc6ph
         LnfxoKSfAv7BDc46lXbwa6jBu5JvhmRhsEodvI56lEbhA0V4XCczic+kf4jtZffn3DUB
         ELOhZdJL0etOkD8MyWvFlf55xYuvvhYCm/RRu6/90LtQtXym+lYn2kQxBDeTIIkH9jaF
         +EIHvIK8HrwGHGMoaJ1v3XxMjYDXHjmYRlhALIlMPNmxSxAN85Yb/0O5D02uXrDu4Jbz
         DtWUMZGiJ/nlVRVd3nzJqu9w8FrIcVrb1fx2zFyOI9flUFFPtPljzRnSsxkHe8W9sY+E
         SUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711678098; x=1712282898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pX+xlgHnVO0ivx09FP8o5h5//8YYHu0/1HElauId9Hc=;
        b=D8OGZ0f7R5xFsIqI9/6yUqB0kgYVEKwuS/IVE33SYU/YJ2GAL0vE54gqWHDBiFIYsK
         l5NTL3ralufpSsEk8jfErL43QiTD8wmF0vpuGRCsdP4P3WQzU1QgCRRzcgL4k8M5rpDb
         I9t6y8sXSosEbiwWZ8WQDT+3yH9JTFniSddWBjE0xZ7xCEpXqv9eYAmRjx4RQxckJjG6
         wT1FtCPOn37HiF06PzdCYkNGnVOYHmr97CPNFiWcjbnwmbKxyJI2wYw8VSaKkrGIXqf9
         wxe8k+AzsAcA67Mz1HoY23nrlSDsZhWigxE8c9OwG+Z2wv8SeLTR10dJoZKUUUUjvqIh
         5G4w==
X-Forwarded-Encrypted: i=1; AJvYcCXZO6UcVuKTWNXV0LVlIeqgyO9T+tHFzd2DwogNmSfp3DnbKoAMhl8zxmJ49FibGzq9MeNyKaZDzCZi9cWhx3jWcEehpqlxxYSgdvBf
X-Gm-Message-State: AOJu0YxIIMzSEAlH3+Lgy0krOm7bLiL0+eIvpSDqM+sONh6Z8qmVbnh5
	r/4NA5NU1l0aM3oaJlAwDSYr+QFggzLu8cMh55iPf71fLtZK7Erq
X-Google-Smtp-Source: AGHT+IE7IqJneESPBHa+urV0DUyTJuu7Hvj39VAciEXrUZR4Z+cDeodTKTkbmTfLnIKtMFA+cOXLDQ==
X-Received: by 2002:a17:90a:1116:b0:2a0:3d59:4632 with SMTP id d22-20020a17090a111600b002a03d594632mr1250548pja.15.1711678098273;
        Thu, 28 Mar 2024 19:08:18 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a0cc300b002a20c0dcebbsm1317772pjt.31.2024.03.28.19.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 19:08:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 28 Mar 2024 16:08:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Alex Shi <alexs@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Barry Song <song.bao.hua@hisilicon.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: for_each_domain()/sched_domain_span() has offline CPUs (was Re:
 [PATCH 2/2] timers: Fix removed self-IPI on global timer's enqueue in
 nohz_full)
Message-ID: <ZgYikMb5kZ7rxPp6@slm.duckdns.org>
References: <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <Zf1sSv/6mQHJuJ8G@lothringen>
 <Zf2GDjekyemQKn7I@lothringen>
 <xhsmhwmppaqls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <87cyrfe7a3.ffs@tglx>
 <xhsmhle62ay5f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhle62ay5f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

(cc'ing Waiman and quoting whole body)

Hello,

On Thu, Mar 28, 2024 at 09:39:56PM +0100, Valentin Schneider wrote:
> On 27/03/24 21:42, Thomas Gleixner wrote:
> > On Tue, Mar 26 2024 at 17:46, Valentin Schneider wrote:
> >> On 22/03/24 14:22, Frederic Weisbecker wrote:
> >>> On Fri, Mar 22, 2024 at 12:32:26PM +0100, Frederic Weisbecker wrote:
> >> Now, on top of the above, there's one more thing worth noting:
> >>   cpu_up_down_serialize_trainwrecks()
> >>
> >> This just flushes the cpuset work, so after that the sched_domain topology
> >> should be sane. However I see it's invoked at the tail end of _cpu_down(),
> >> IOW /after/ takedown_cpu() has run, which sounds too late. The comments
> >> around this vs. lock ordering aren't very reassuring however, so I need to
> >> look into this more.
> >
> > commit b22afcdf04c96ca58327784e280e10288cfd3303 has more information in
> > the change log.
> >
> > TLDR: The problem is that cpusets have the lock order cpuset_mutex ->
> > cpu_hotplug_lock in the hotplug path for whatever silly reason. So
> > trying to flush the work from within the cpu hotplug lock write held
> > region is guaranteed to dead lock.
> >
> > That's why all of this got deferred to a work queue. The flush at the
> > end of the hotplug code after dropping the hotplug lock is there to
> > prevent that user space sees the CPU hotplug uevent before the work is
> > done. But of course between bringing the CPU offline and the flush the
> > kernel internal state is inconsistent.
> >
> 
> Thanks for the summary!
> 
> > There was an attempt to make the CPU hotplug path synchronous in commit
> > a49e4629b5ed ("cpuset: Make cpuset hotplug synchronous") which got
> > reverted with commit 2b729fe7f3 for the very wrong reason:
> >
> > https://lore.kernel.org/all/F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw/T/#u
> >
> >  (cpu_hotplug_lock){++++}-{0:0}:
> >   lock_acquire+0xe4/0x25c
> >   cpus_read_lock+0x50/0x154
> >   static_key_slow_inc+0x18/0x30
> >   mem_cgroup_css_alloc+0x824/0x8b0
> >   cgroup_apply_control_enable+0x1d8/0x56c
> >   cgroup_apply_control+0x40/0x344
> >   cgroup_subtree_control_write+0x664/0x69c
> >   cgroup_file_write+0x130/0x2e8
> >   kernfs_fop_write+0x228/0x32c
> >   __vfs_write+0x84/0x1d8
> >   vfs_write+0x13c/0x1b4
> >   ksys_write+0xb0/0x120
> >
> > Instead of the revert this should have been fixed by doing:
> >
> > +  cpus_read_lock();
> >    mutex_lock();
> >    mem_cgroup_css_alloc();
> > -  static_key_slow_inc();
> > +  static_key_slow_inc_cpuslocked();
> >
> 
> So looking at the state of things now, writing to the
> cgroup.subtree_control file looks like: 
> 
>   cgroup_file_write()
>   `\
>     cgroup_subtree_control_write()
>     `\
>       cgroup_kn_lock_live()
>       `\
>       | cgroup_lock()
>       | `\
>       |   mutex_lock(&cgroup_mutex);
>       |
>       cgroup_apply_control()
>       `\
>         cgroup_apply_control_enable()
>         `\
>           css_create()
>           `\
>             ss->css_alloc() [mem_cgroup_css_alloc()]
>             `\
>               static_branch_inc()        
> 
> and same with cgroup_mkdir(). So if we want to fix the ordering that caused
> the revert, we'd probably want to go for:
> 
>   static inline void cgroup_lock(void)
>   {
> +       cpus_read_lock();
> 	mutex_lock(&cgroup_mutex);
>   }
> 
>   static inline void cgroup_unlock(void)
>   {
> 	mutex_unlock(&cgroup_mutex);
> -       cpus_read_unlock();        
>   }
> 
> + a handful of +_cpuslocked() changes.
> 
> As for cpuset, it looks like it's following this lock order:
> 
> 	cpus_read_lock();
> 	mutex_lock(&cpuset_mutex);
> 
> Which AFAICT is what we want.
> 
> > Sorry that I did not notice this back then because I was too focussed on
> > fixing that uevent nonsense in a halfways sane way.
> >
> > After that revert cpuset locking became completely insane.
> >
> > cpuset_hotplug_cpus_read_trylock() is the most recent but also the most
> > advanced part of that insanity. Seriously this commit is just tasteless
> > and disgusting demonstration of how to paper over a problem which is not
> > fully understood.
> >
> > After staring at it some more (including the history which led up to
> > these insanities) I really think that the CPU hotplug path can be made
> > truly synchronous and the memory hotplug path should just get the lock
> > ordering correct.
> >
> > Can we please fix this for real and get all of this insanity out of the
> > way
> 
> Yes please!

Yeah, making that operation synchronous would be nice. Waiman, you're a lot
more familiar with this part than I am. Can you please take a look and see
whether we can turn the sched domain updates synchronous?

Thanks.

-- 
tejun

