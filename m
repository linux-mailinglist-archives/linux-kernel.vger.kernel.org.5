Return-Path: <linux-kernel+bounces-19979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758A98277CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228FF283BD5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028BC55C14;
	Mon,  8 Jan 2024 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UahwxOPA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A151855C04
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so2564078e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 10:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704739063; x=1705343863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Fn/vm7iOQ6ScVuyrdABBMSC9h+mKMI7gV8fitPzaT0=;
        b=UahwxOPAY8OYR9IXd5zgK4fDfLhFboe8PGsl0TU1Off9UBb9GN2OaccRsp8XrjhP/F
         bdyMZPEtiLpSkKNpo9J/xRW3/+8kyghhN++xJhnYd4gOr+KJevjRZewPOcbKhSoy81bs
         xzQhnaVHJfWNQkIbRnKPjJ42QtrCBcCESkvxkxfVdsDx+CD3dEfR3vgMMXlu9REBCXHN
         GRIQznGbJiNZ4Qm8LHyBmi7YRHFCxNFe7JxLDSt5+TCgU0rz1RV4d3eHv9nm/ZKzZ8+a
         wpJfvFhnZAb60Yl1wnAdw8/qxcKT5T9dLRIx2bIYU9Htbp6nr9/X0h2eq8H4xOX8VHDE
         jTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704739063; x=1705343863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Fn/vm7iOQ6ScVuyrdABBMSC9h+mKMI7gV8fitPzaT0=;
        b=XOkxNHWiaRL0EjLs/d9Iiby1b+CTmsoxlK8fKjuYqrJLVhxhUXzCZLFx5TqUxhZwCH
         78JD6rd0KrRXqOZE7gsxtNaXg2YP0dNAUWCjOK3L8GPLmr/yuAq91ZSlk6CsH6ByD+HG
         UpMMc6w7PWckU4gB4XZuina6gwnUJcw1uuDRqz4HJJotDMUVC8s0+ys8TZdUTstITess
         FjEis0Ce9Elnb1DCQsRhHXKofFsFjuaH10eWEMH/F+gY72fif3tZqf1Ii7c1xgBdnrhj
         Fjo3YoV4/WlrTBlKnmfeLOZ/XzzoYYoBCf675xuwTp0cudYJ/Js/k9wWJj/05aXXyFEy
         ZVFg==
X-Gm-Message-State: AOJu0YwaeVEnCSdwQYdvwCpULpDQ3tFh1yw6/VeDsiv0pNNiIARqM4ll
	yMWkllk4fxKyPIUjrFsOWkc=
X-Google-Smtp-Source: AGHT+IEGLO8/Qd7YIUC8gujNcMYCMcdnZkTZmkc3GgD/jscUHJQbHAsP3FLNYWFYyvS+v5EUVzsCaA==
X-Received: by 2002:a05:6512:3b95:b0:50e:8158:1fae with SMTP id g21-20020a0565123b9500b0050e81581faemr2116026lfv.99.1704739063208;
        Mon, 08 Jan 2024 10:37:43 -0800 (PST)
Received: from pc636 (host-90-233-199-110.mobileonline.telia.com. [90.233.199.110])
        by smtp.gmail.com with ESMTPSA id q25-20020a194319000000b0050e1bfde451sm40878lfa.123.2024.01.08.10.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:37:42 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 8 Jan 2024 19:37:40 +0100
To: Wen Gu <guwen@linux.alibaba.com>, Hillf Danton <hdanton@sina.com>
Cc: Hillf Danton <hdanton@sina.com>, Uladzislau Rezki <urezki@gmail.com>,
	linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/11] mm: vmalloc: Remove global vmap_area_root
 rb-tree
Message-ID: <ZZxA9FTCCKC6Fvrr@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-5-urezki@gmail.com>
 <238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com>
 <ZZfe4O850fFaxOgQ@pc638.lan>
 <52766da2-41de-41ce-b60b-1118da343b8a@linux.alibaba.com>
 <20240107065942.3141-1-hdanton@sina.com>
 <328501ae-828f-4aa8-baab-833573c010e7@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <328501ae-828f-4aa8-baab-833573c010e7@linux.alibaba.com>

On Mon, Jan 08, 2024 at 03:45:18PM +0800, Wen Gu wrote:
> 
> 
> On 2024/1/7 14:59, Hillf Danton wrote:
> > On Sat, 6 Jan 2024 17:36:23 +0100 Uladzislau Rezki <urezki@gmail.com>
> > > > 
> > > > Thank you! I tried the patch, and it seems that the wait for rwlock_t
> > > > also exists, as much as using spinlock_t. (The flamegraph is attached.
> > > > Not sure why the read_lock waits so long, given that there is no frequent
> > > > write_lock competition)
> > > > 
> > > >                 vzalloced shmem(spinlock_t)   vzalloced shmem(rwlock_t)
> > > > Requests/sec         583729.93                     460007.44
> > > > 
> > > > So I guess the overhead in finding vmap area is inevitable here and the
> > > > original spin_lock is fine in this series.
> > > > 
> > > I have also noticed a erformance difference between rwlock and spinlock.
> > > So, yes. This is what we need to do extra if CONFIG_HARDENED_USERCOPY is
> > > set, i.e. find a VA.
> > 
> > See if read bias helps to understand the gap between spinlock and rwlock.
> > 
> > --- x/kernel/locking/qrwlock.c
> > +++ y/kernel/locking/qrwlock.c
> > @@ -23,7 +23,7 @@ void __lockfunc queued_read_lock_slowpat
> >   	/*
> >   	 * Readers come here when they cannot get the lock without waiting
> >   	 */
> > -	if (unlikely(in_interrupt())) {
> > +	if (1) {
> >   		/*
> >   		 * Readers in interrupt context will get the lock immediately
> >   		 * if the writer is just waiting (not holding the lock yet),
> 
> Thank you for the idea! Hillf.
> 
> IIUC, the change makes read operations more likely to acquire lock and
> modified fairness to favor reading.
> 
> The test in my scenario shows:
> 
> vzalloced shmem with     spinlock_t      rwlock_t      rwlock_t(with above change)
> Requests/sec              564961.29     442534.33     439733.31
> 
> In addition to read bias, there seems to be other factors that cause the
> gap, but I haven't figured it out yet..
> 
<snip>
urezki@pc638:~$ cat locktorture.sh 
#!/bin/sh

# available lock types: spin_lock, rw_lock
torture_type=$1
test_time=$2

echo "Start..."

modprobe locktorture $torture_type nreaders_stress=0 > /dev/null 2>&1
sleep $test_time
rmmod locktorture > /dev/null 2>&1

echo "Done."
urezki@pc638:~$
<snip>

Out:

# sudo ./locktorture.sh rw_lock 30
[12107.327566] Writes:  Total: 53304415  Max/Min: 1620715/3225 ???  Fail: 0 
[12107.327898] spin_lock-torture: lock_torture_stats is stopping
[12107.328192] Writes:  Total: 53304415  Max/Min: 1620715/3225 ???  Fail: 0 
[12107.328368] spin_lock-torture:--- End of test: SUCCESS: acq_writer_lim=0 bind_readers=0-63 bind_writers=0-63 call_rcu_chains=0 long_hold=100 nested_locks=0 nreaders_stress=0 nwriters_stress=128 onoff_holdoff=0 onoff_interval=0 rt_boost=2 rt_boost_factor=50 shuffle_interval=3 shutdown_secs=0 stat_interval=60 stutter=5 verbose=1 writer_fifo=0

# sudo ./locktorture.sh spin_lock 30
[12051.968992] Writes:  Total: 47843400  Max/Min: 1335320/5942 ???  Fail: 0 
[12051.969236] spin_lock-torture: lock_torture_stats is stopping
[12051.969507] Writes:  Total: 47843400  Max/Min: 1335320/5942 ???  Fail: 0 
[12051.969813] spin_lock-torture:--- End of test: SUCCESS: acq_writer_lim=0 bind_readers=0-63 bind_writers=0-63 call_rcu_chains=0 long_hold=100 nested_locks=0 nreaders_stress=0 nwriters_stress=128 onoff_holdoff=0 onoff_interval=0 rt_boost=2 rt_boost_factor=50 shuffle_interval=3 shutdown_secs=0 stat_interval=60 stutter=5 verbose=1 writer_fifo=0

I do not see a big difference between spin_lock and rw_lock. In fact
the locktorture.ko test shows that a spin_lock is slightly worse but
it might be something that i could miss or is not accurate enough in
this test.

When it comes to vmap test-suite and the difference between rw_lock
and spin_lock. I have not spend much time figuring out the difference.
From the first glance it can be that a cache-miss rate is higher when
switch to rw_lock or rw-lock requires more atomics.

--
Uladzislau Rezki

