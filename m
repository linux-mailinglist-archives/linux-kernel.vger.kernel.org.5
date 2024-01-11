Return-Path: <linux-kernel+bounces-23939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723282B42E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E047285943
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A98524C0;
	Thu, 11 Jan 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWT2UnzZ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FB51007;
	Thu, 11 Jan 2024 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e7dd8bce8so6549752e87.1;
        Thu, 11 Jan 2024 09:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704994533; x=1705599333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYTLvTHP6c15eJsjLaYySaO8Yr732/QLsj7CRRlVDCY=;
        b=YWT2UnzZ6njsWjbg3MvEpig9/ywlkkwfuE8gLjCNWKr1e9Pq2yXHwxoHlXnP3WMOA4
         qTiA35urWjLEb8b3/gtSTwaDYQY4yOAxlJWD1EUqWWDi/9VYuorq5FASsKDWg3R6fcld
         O6WC9Li4j7du43ThyKIMMmL699QKDhYy41WWxHM79/5cjmSZuGZVwx9S23NIOiZgX3aq
         g/+SHPNSi+CdkJDog45HNrfrhJFuEmdX/ywJbuhow6Sp8HiXw4CVv2vS2HqI2Thy++QX
         Uz0yfkpF78ymljSifiBz8exEldjudWQtmLWSHx4H5GoztRlBDpPjQUonKqaHI6Th5tBS
         BEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704994533; x=1705599333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYTLvTHP6c15eJsjLaYySaO8Yr732/QLsj7CRRlVDCY=;
        b=hikrU0FkLYmkAio0RKzmqVJZdbqjco5WbOm/vV+0ImEKYl7DUt2zyjZH6rYw+nZ5cD
         Q13R9JcvoGP/KWy1XQiz7ysGQM2LGrzyWi72jQKLbL8vOSDRF3Hqm2KDddOvBC8r1P2w
         cjea6Z9nPmJRAE7HqPAhFm4dIuAWL1hsTguu2XNqkGYxt6/LqjWtJC4ISuWe5qNUAo+O
         /ALwtsaedwiCGEGd+64PonlzH0gzo2B7B1y8ioa40y3IOPcQauPjULc9PTkAGKBnExjV
         g8TedENNBLuNuuY7zPWXgL/RrfgsuHowmeKMTF9IklrcVT76yw/+CjOLyMGAa8xnxlXU
         O6Lg==
X-Gm-Message-State: AOJu0YzVQXoT7avUTkkEiUd+RegE9VbQFf+emHboV1dr0EK4bWKNT3h6
	G8JB6Bz3VWiVTHnb5s/QLWk=
X-Google-Smtp-Source: AGHT+IG3fridcXStmm1x6ILCaKD/04s1ySqhQQhBhCOMj5PFGxOAG/p7tNzF+lmD7/a2QpuxDqrovw==
X-Received: by 2002:a19:7413:0:b0:50b:f279:cab with SMTP id v19-20020a197413000000b0050bf2790cabmr25279lfe.51.1704994533070;
        Thu, 11 Jan 2024 09:35:33 -0800 (PST)
Received: from pc636 (host-90-233-192-22.mobileonline.telia.com. [90.233.192.22])
        by smtp.gmail.com with ESMTPSA id y20-20020ac255b4000000b0050e7ee56355sm255564lfg.23.2024.01.11.09.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 09:35:32 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 11 Jan 2024 18:35:30 +0100
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 1/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <ZaAm4mVEf8bXnLEp@pc636>
References: <20240104162510.72773-1-urezki@gmail.com>
 <20240104162510.72773-2-urezki@gmail.com>
 <ZZ2bi5iPwXLgjB-f@google.com>
 <ZZ5htIcrlpxz5AKM@pc636>
 <CAC_TJvfe52GRrjHMfvAorC+PtTBRK0hxL9OPoi0SMqDV3XkFZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_TJvfe52GRrjHMfvAorC+PtTBRK0hxL9OPoi0SMqDV3XkFZw@mail.gmail.com>

Hello, Kalesh!
> >
> > >
> > > Hi Uladzislau,
> > >
> > > I've tried your patches (v3) on Android with 6.1.43 kernel.
> > >
> > > The test cycles 10 apps (including camera) sequentially for 100
> > > iterations.
> > >
> > > I've set rcu_normal to override the rcu_expedited in the boot
> > > parameters:
> > >
> > > adb shell cat /proc/cmdline | tr ' ' '\n' | grep rcu
> > >
> > > rcupdate.rcu_normal=1
> > > rcupdate.rcu_expedited=1
> > > rcu_nocbs=0-7
> > >
> > >
> > > The configurations are:
> > >
> > > A - echo 0 >/sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> > > B - echo 1 >/sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> > >
> > > Results:
> > >
> > > = APP LAUNCH TIME =
> > >                                 delta (B-A)    ratio(%)
> > >    overall_app_launch_time(ms)    -11399.00       -6.65
> > >
> > >
> > > == camera_launch_time
> > >       type  delta(B-A %)  A_count  B_count
> > >        HOT         -7.05       99       99
> > >       COLD         -6.33        1        1
> > >
> > >
> 
> Hi Uladzislau,
> 
> > If i interpret it correctly you also see that this series reduces
> > a launch time by 6/7% on your app set. Is that correct?
> 
> Yes your understanding is correct.
> 
> >
> > > === Function Latencies ===
> > >
> > > Tracing synchronize_rcu_expedited.  Hit Ctrl-C to exit                              Tracing synchronize_rcu_expedited.  Hit Ctrl-C to exit
> > >
> > >      nsec                : count    distribution                                         nsec                : count    distribution
> > >          0 -> 1          : 0        |                                        |               0 -> 1          : 0        |                                        |
> > >          2 -> 3          : 0        |                                        |               2 -> 3          : 0        |                                        |
> > >          4 -> 7          : 0        |                                        |               4 -> 7          : 0        |                                        |
> > >          8 -> 15         : 0        |                                        |               8 -> 15         : 0        |                                        |
> > >         16 -> 31         : 0        |                                        |              16 -> 31         : 0        |                                        |
> > >         32 -> 63         : 0        |                                        |              32 -> 63         : 0        |                                        |
> > >         64 -> 127        : 0        |                                        |              64 -> 127        : 0        |                                        |
> > >        128 -> 255        : 0        |                                        |             128 -> 255        : 0        |                                        |
> > >        256 -> 511        : 0        |                                        |             256 -> 511        : 0        |                                        |
> > >        512 -> 1023       : 0        |                                        |             512 -> 1023       : 0        |                                        |
> > >       1024 -> 2047       : 0        |                                        |            1024 -> 2047       : 0        |                                        |
> > >       2048 -> 4095       : 0        |                                        |            2048 -> 4095       : 0        |                                        |
> > >       4096 -> 8191       : 0        |                                        |            4096 -> 8191       : 0        |                                        |
> > >       8192 -> 16383      : 0        |                                        |            8192 -> 16383      : 0        |                                        |
> > >      16384 -> 32767      : 0        |                                        |           16384 -> 32767      : 0        |                                        |
> > >      32768 -> 65535      : 0        |                                        |           32768 -> 65535      : 0        |                                        |
> > >      65536 -> 131071     : 0        |                                        |           65536 -> 131071     : 0        |                                        |
> > >     131072 -> 262143     : 0        |                                        |          131072 -> 262143     : 0        |                                        |
> > >     262144 -> 524287     : 0        |                                        |          262144 -> 524287     : 0        |                                        |
> > >     524288 -> 1048575    : 0        |                                        |          524288 -> 1048575    : 0        |                                        |
> > >    1048576 -> 2097151    : 0        |                                        |         1048576 -> 2097151    : 0        |                                        |
> > >    2097152 -> 4194303    : 0        |                                        |         2097152 -> 4194303    : 0        |                                        |
> > >    4194304 -> 8388607    : 871      |**                                      |         4194304 -> 8388607    : 1180     |****                                    |
> > >    8388608 -> 16777215   : 3204     |********                                |         8388608 -> 16777215   : 7020     |*************************               |
> > >   16777216 -> 33554431   : 15013    |****************************************|        16777216 -> 33554431   : 10952    |****************************************|
> > > Exiting trace of synchronize_rcu_expedited                                          Exiting trace of synchronize_rcu_expedited
> > >
> > >
> > > Tracing synchronize_rcu.  Hit Ctrl-C to exit                                        Tracing synchronize_rcu.  Hit Ctrl-C to exit
> > >
> > >      nsec                : count    distribution                                         nsec                : count    distribution
> > >          0 -> 1          : 0        |                                        |               0 -> 1          : 0        |                                        |
> > >          2 -> 3          : 0        |                                        |               2 -> 3          : 0        |                                        |
> > >          4 -> 7          : 0        |                                        |               4 -> 7          : 0        |                                        |
> > >          8 -> 15         : 0        |                                        |               8 -> 15         : 0        |                                        |
> > >         16 -> 31         : 0        |                                        |              16 -> 31         : 0        |                                        |
> > >         32 -> 63         : 0        |                                        |              32 -> 63         : 0        |                                        |
> > >         64 -> 127        : 0        |                                        |              64 -> 127        : 0        |                                        |
> > >        128 -> 255        : 0        |                                        |             128 -> 255        : 0        |                                        |
> > >        256 -> 511        : 0        |                                        |             256 -> 511        : 0        |                                        |
> > >        512 -> 1023       : 0        |                                        |             512 -> 1023       : 0        |                                        |
> > >       1024 -> 2047       : 0        |                                        |            1024 -> 2047       : 0        |                                        |
> > >       2048 -> 4095       : 0        |                                        |            2048 -> 4095       : 0        |                                        |
> > >       4096 -> 8191       : 0        |                                        |            4096 -> 8191       : 0        |                                        |
> > >       8192 -> 16383      : 0        |                                        |            8192 -> 16383      : 0        |                                        |
> > >      16384 -> 32767      : 0        |                                        |           16384 -> 32767      : 0        |                                        |
> > >      32768 -> 65535      : 0        |                                        |           32768 -> 65535      : 0        |                                        |
> > >      65536 -> 131071     : 0        |                                        |           65536 -> 131071     : 0        |                                        |
> > >     131072 -> 262143     : 0        |                                        |          131072 -> 262143     : 0        |                                        |
> > >     262144 -> 524287     : 0        |                                        |          262144 -> 524287     : 0        |                                        |
> > >     524288 -> 1048575    : 0        |                                        |          524288 -> 1048575    : 0        |                                        |
> > >    1048576 -> 2097151    : 0        |                                        |         1048576 -> 2097151    : 0        |                                        |
> > >    2097152 -> 4194303    : 0        |                                        |         2097152 -> 4194303    : 0        |                                        |
> > >    4194304 -> 8388607    : 861      |**                                      |         4194304 -> 8388607    : 1136     |****                                    |
> > >    8388608 -> 16777215   : 3111     |********                                |         8388608 -> 16777215   : 6320     |************************                |
> > >   16777216 -> 33554431   : 13901    |****************************************|        16777216 -> 33554431   : 10484    |****************************************|
> > > Exiting trace of synchronize_rcu                                                    Exiting trace of synchronize_rcu
> > >
> > Who is B and who is A?
> 
> Left is A (rcu_normal_wake_from_gp=0)  and right is B
> (rcu_normal_wake_from_gp=1)
> >
> > >
> > > Interestingly I tried the same experiment without rcu_normal=1 (leaving rcu_expedited=1):
> > >
> > > adb shell cat /proc/cmdline | tr ' ' '\n' | grep rcu
> > > rcupdate.rcu_expedited=1
> > > rcu_nocbs=0-7
> > >
> > > In this case I also saw the -6 to -7% decrease in the app launch times
> > > but I don't have a good explanation why that would be? (The fucntion
> > > latency histograms in this case didn't show any significant difference).
> > > Do you have any insight why this may happen?
> > >
> > When rcu_expedited=1 is set and rcu_normal=0 is disabled. The
> > synchronize_rcu() call is converted into synchronize_rcu_expidited():
> >
> > <snip>
> > void synchronize_rcu(void)
> > {
> >         unsigned long flags;
> >         struct rcu_node *rnp;
> >
> >         RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
> >                          lock_is_held(&rcu_lock_map) ||
> >                          lock_is_held(&rcu_sched_lock_map),
> >                          "Illegal synchronize_rcu() in RCU read-side critical section");
> >         if (!rcu_blocking_is_gp()) {
> >                 if (rcu_gp_is_expedited())
> >                         synchronize_rcu_expedited();
> >                 else
> >                         synchronize_rcu_normal();
> >                 return;
> >         }
> > ...
> > <snip>
> >
> > rcu_gp_is_expidited() is true, so invoke "expedited" version.
> >
> > I see some concerns in preferring an expedited version as a global
> > replacement. First of all it is related to latency sensitive workloads
> > because in order to expedite a grace period it sends out IPIs on all
> > online CPUs to force them to report a quiescent-state asap. I have not
> > investigated yet how it affects such workloads.
> >
> > Therefore, in your case, you also see a performance boost of your app sets.
> 
> IIUC the patch shouldn't affect the case? The only difference in A vs
> B is rcu_normal_wake_from_gp (both have rcu_expedited=1).
> 
Right. This patch does not touch "expedited" version at all.

Appreciate for test results and looking at!

--
Uladzislau Rezki

