Return-Path: <linux-kernel+bounces-25945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 604CA82D8A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124181F225D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5212D2C690;
	Mon, 15 Jan 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="O5JVqAyJ"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380A2C68B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cdc1af60b2so9948791fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 03:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705319971; x=1705924771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O5hovQlCyFfUT1w/kNP0sdfTe0f7KSxDUv62cZRI4N4=;
        b=O5JVqAyJb3xJ/YlGzK5uxnzHuLtwlUaTUXSM0LsNV6hGLVf2rcGdW97vmQ6V/OONrT
         9FVCTToz3M/hLp8mOswnf59x0yxPqeVEbZA1DSAq5xpAEwtXinrKAYtCKe1Gil/ObPUf
         QR7+WMRuzxKGv93FoCGNxCGYvuxvvPiv+iJOg74c5S6R7+kVUJbGhtYkdyAqUFZeZqdI
         8FwHM65K7CTyIAcWEHrHxPsIjvzmLL5vWaVmlNR+1j6yhPQxZVH6PE+OFmnD7XTSM9rJ
         wS1v+57pUg5uDRTsWl3fzXaax2FC44WkXtrAmJChpWcqpb66m/gi8PaxLhRDvwlZls8b
         n5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705319971; x=1705924771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5hovQlCyFfUT1w/kNP0sdfTe0f7KSxDUv62cZRI4N4=;
        b=L0QhRKxb3801uo3G+dLAA2ygroOmDue6RqYEEtqdK5ex205nZx/8eatJrbWcdsZJ0k
         4HgQqlT/teuEMFqmfusarKpfTRvbfmEMyis0VyxLxP9X+JdT8DHJk9OL96X0DHx+LNEh
         GyIjW7B1Rp9ibuxDhvcU11j1REXaXJeoHpY4Stb6PTyxdZOdqZ+LRgL9zt+H3F6jtD72
         dGZ+5LQVrfgGezFk0zluXlnUF/p71Mw3WY64699HbGlgGBnLufE6v4xjfUBBD3WrRHQ7
         wfqwrI2JRz+BSnWmBOQARCHcVew+QOUB4DrXLsmQwKQN+Y0KpmYPCZo1gH81L0FwBH8x
         sDIA==
X-Gm-Message-State: AOJu0YwvpHAu/0tGFVF2j0zpXjrVW7T8uX1zzFyW7HvYhF0itDnW5ctC
	EQYhhXa0YpU2qq+XAWob7xK2P8sArpppVA==
X-Google-Smtp-Source: AGHT+IHGRHMo4VhBXy6hSCYZ1XRFQETsAjSrKVsA9kDbBeh41BdpUKjBl7BOI0qixDQnObQ3xK/bYA==
X-Received: by 2002:a2e:9595:0:b0:2cc:df3f:9f83 with SMTP id w21-20020a2e9595000000b002ccdf3f9f83mr2379829ljh.64.1705319971394;
        Mon, 15 Jan 2024 03:59:31 -0800 (PST)
Received: from airbuntu (host109-154-205-127.range109-154.btcentralplus.com. [109.154.205.127])
        by smtp.gmail.com with ESMTPSA id w26-20020a2e301a000000b002cd7fe5655asm1351741ljw.88.2024.01.15.03.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 03:59:30 -0800 (PST)
Date: Mon, 15 Jan 2024 11:59:28 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Wyes Karny <wkarny@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Message-ID: <20240115115928.rxafxbrf7i55hepj@airbuntu>
References: <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc>
 <ZaPC7o44lEswxOXp@vingu-book>
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc>
 <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>
 <20240114151250.5wfexq44o3mdm3nh@airbuntu>
 <CAKfTPtAMxiTbvAYav1JQw+MhjzDPCZDrMLL2JOfsc0GWp+FnOA@mail.gmail.com>
 <20240114195815.nes4bn53tc25djbh@airbuntu>
 <20240114233728.hrmyelo66beaajhp@airbuntu>
 <CAAE01kGAdczPmWZ5VqrF397FeOHexWfHDi9eYXv8LogDbuWiHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAE01kGAdczPmWZ5VqrF397FeOHexWfHDi9eYXv8LogDbuWiHQ@mail.gmail.com>

Hi Wyes

On 01/15/24 11:55, Wyes Karny wrote:

> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 95c3c097083e..155f96a44fa0 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -123,7 +123,8 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
> >   * Return: the reference CPU frequency to compute a capacity.
> >   */
> >  static __always_inline
> > -unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> > +unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy,
> > +                                   unsigned long *max)
> >  {
> >         unsigned int freq = arch_scale_freq_ref(policy->cpu);
> >
> > @@ -133,6 +134,9 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> >         if (arch_scale_freq_invariant())
> >                 return policy->cpuinfo.max_freq;
> >
> > +       if (max)
> > +               *max = policy->cur * (*max) / policy->cpuinfo.max_freq;
> 
> But when freq_invaiant is disabled we don't have policy->cpuinfo.max_freq.

They are reported as 3.8GHz correctly for me

$ grep . /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_max_freq
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy10/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy11/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy12/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy13/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy14/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy15/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy16/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy17/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy18/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy19/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy1/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy20/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy21/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy22/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy23/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy2/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy3/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy5/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy6/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy7/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy8/cpuinfo_max_freq:3800000
/sys/devices/system/cpu/cpufreq/policy9/cpuinfo_max_freq:3800000

