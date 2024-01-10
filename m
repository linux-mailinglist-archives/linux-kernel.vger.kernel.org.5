Return-Path: <linux-kernel+bounces-21895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C392829634
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95730B2685C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840063FB0B;
	Wed, 10 Jan 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCss/AEq"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE43FB05;
	Wed, 10 Jan 2024 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50ea98440a7so3831941e87.1;
        Wed, 10 Jan 2024 01:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704878519; x=1705483319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kcvm3RQ4W/SXsTnj9zO13Q7IXLryIflibUCAdF3vpjw=;
        b=DCss/AEqiCknv7oZISnK571eUsEEdVhKBNYkpWnU1tQ8b1gmsvn+IBaD9YNGeykPYk
         1FOum886fDhGWoHpsv0EUN8Sjj/wZQvNORpxepG4pjB2Ws/z65Yt/593lNi+5qq4vLa9
         p3wTkex/Vo67lTRlUu9jUWmq7O/oftp4swLJJvut0s0W3sBPJXw3qkMauSovUdABH9LI
         /nYfUpn3MdPRlqG3sDCcK1kdu9JCDaj25u+TY4r0gHT5hm01+9SAPefkXUxPpjBzGgvX
         Zcj1PDB6styuFGTBiA2MsL3GnmNYcZ8cNpVzMHUGPeouyCZeSXSZaOMh49z8L8fVT6rf
         X2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704878519; x=1705483319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kcvm3RQ4W/SXsTnj9zO13Q7IXLryIflibUCAdF3vpjw=;
        b=m3nRARLPnPB8XI8ftkCIByu4Ebjp+KqlAnett0U7hkFaJ3JkKXvQoJamqhSRMupbDt
         prfsxLcl/czN0pMXbW1J3JFOd5sPM59Oi8SbGxeApXO7CtpnBBPCyulWtlPkVLBkT1yq
         r/eae83C9TBcK+vDMgI3L7bsT5BA3Qv2J8GohoPH3LU1S+pkK6wVbGh/i+y8rV924h9V
         Jg27mdnC/Z85NmJ7DC3d8eWX6sONscnYn2DvOr920oQQG4Sx8XjqG+oQaSg62UIft7uo
         amLDygxRfdBT2x8g+2BCs0MfYFcAfORY5n4tWoWhn3Tc3mAl8zulb+OBrmusN8HHfYck
         fYtA==
X-Gm-Message-State: AOJu0Yyaxk/JH6jafmjVh2lXKXcfvP4ax2EzOtSlPjAEZkrT+vwvwlpd
	bnGPeDKkydTIRkAGEqvKOvVROn3GsMg=
X-Google-Smtp-Source: AGHT+IEq6D7KCwlzb4gdW8qtQ/0yKhIvcL3oHlNumxuq0UPSMJ4za97Y3nk6E3Yy1usjhtuD0p0eVA==
X-Received: by 2002:a19:a418:0:b0:50e:1ef0:4843 with SMTP id q24-20020a19a418000000b0050e1ef04843mr126339lfc.160.1704878519207;
        Wed, 10 Jan 2024 01:21:59 -0800 (PST)
Received: from pc636 (host-90-233-192-22.mobileonline.telia.com. [90.233.192.22])
        by smtp.gmail.com with ESMTPSA id b23-20020ac247f7000000b0050e4e943b22sm607838lfp.247.2024.01.10.01.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 01:21:58 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 10 Jan 2024 10:21:56 +0100
To: Kalesh Singh <kaleshsingh@google.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 1/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <ZZ5htIcrlpxz5AKM@pc636>
References: <20240104162510.72773-1-urezki@gmail.com>
 <20240104162510.72773-2-urezki@gmail.com>
 <ZZ2bi5iPwXLgjB-f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ2bi5iPwXLgjB-f@google.com>

Hello, Kalesh!

> 
> Hi Uladzislau,
> 
> I've tried your patches (v3) on Android with 6.1.43 kernel.
> 
> The test cycles 10 apps (including camera) sequentially for 100
> iterations.
> 
> I've set rcu_normal to override the rcu_expedited in the boot
> parameters:
> 
> adb shell cat /proc/cmdline | tr ' ' '\n' | grep rcu
> 
> rcupdate.rcu_normal=1
> rcupdate.rcu_expedited=1
> rcu_nocbs=0-7
> 
> 
> The configurations are:
> 
> A - echo 0 >/sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> B - echo 1 >/sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> 
> Results:
> 
> = APP LAUNCH TIME =
>                                 delta (B-A)    ratio(%)
>    overall_app_launch_time(ms)    -11399.00       -6.65
> 
> 
> == camera_launch_time
>       type  delta(B-A %)  A_count  B_count
>        HOT         -7.05       99       99
>       COLD         -6.33        1        1
> 
> 
If i interpret it correctly you also see that this series reduces
a launch time by 6/7% on your app set. Is that correct?

> === Function Latencies ===
> 
> Tracing synchronize_rcu_expedited.  Hit Ctrl-C to exit                              Tracing synchronize_rcu_expedited.  Hit Ctrl-C to exit
> 
>      nsec                : count    distribution                                         nsec                : count    distribution
>          0 -> 1          : 0        |                                        |               0 -> 1          : 0        |                                        |
>          2 -> 3          : 0        |                                        |               2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |               4 -> 7          : 0        |                                        |
>          8 -> 15         : 0        |                                        |               8 -> 15         : 0        |                                        |
>         16 -> 31         : 0        |                                        |              16 -> 31         : 0        |                                        |
>         32 -> 63         : 0        |                                        |              32 -> 63         : 0        |                                        |
>         64 -> 127        : 0        |                                        |              64 -> 127        : 0        |                                        |
>        128 -> 255        : 0        |                                        |             128 -> 255        : 0        |                                        |
>        256 -> 511        : 0        |                                        |             256 -> 511        : 0        |                                        |
>        512 -> 1023       : 0        |                                        |             512 -> 1023       : 0        |                                        |
>       1024 -> 2047       : 0        |                                        |            1024 -> 2047       : 0        |                                        |
>       2048 -> 4095       : 0        |                                        |            2048 -> 4095       : 0        |                                        |
>       4096 -> 8191       : 0        |                                        |            4096 -> 8191       : 0        |                                        |
>       8192 -> 16383      : 0        |                                        |            8192 -> 16383      : 0        |                                        |
>      16384 -> 32767      : 0        |                                        |           16384 -> 32767      : 0        |                                        |
>      32768 -> 65535      : 0        |                                        |           32768 -> 65535      : 0        |                                        |
>      65536 -> 131071     : 0        |                                        |           65536 -> 131071     : 0        |                                        |
>     131072 -> 262143     : 0        |                                        |          131072 -> 262143     : 0        |                                        |
>     262144 -> 524287     : 0        |                                        |          262144 -> 524287     : 0        |                                        |
>     524288 -> 1048575    : 0        |                                        |          524288 -> 1048575    : 0        |                                        |
>    1048576 -> 2097151    : 0        |                                        |         1048576 -> 2097151    : 0        |                                        |
>    2097152 -> 4194303    : 0        |                                        |         2097152 -> 4194303    : 0        |                                        |
>    4194304 -> 8388607    : 871      |**                                      |         4194304 -> 8388607    : 1180     |****                                    |
>    8388608 -> 16777215   : 3204     |********                                |         8388608 -> 16777215   : 7020     |*************************               |
>   16777216 -> 33554431   : 15013    |****************************************|        16777216 -> 33554431   : 10952    |****************************************|
> Exiting trace of synchronize_rcu_expedited                                          Exiting trace of synchronize_rcu_expedited
> 
> 
> Tracing synchronize_rcu.  Hit Ctrl-C to exit                                        Tracing synchronize_rcu.  Hit Ctrl-C to exit
> 
>      nsec                : count    distribution                                         nsec                : count    distribution
>          0 -> 1          : 0        |                                        |               0 -> 1          : 0        |                                        |
>          2 -> 3          : 0        |                                        |               2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |               4 -> 7          : 0        |                                        |
>          8 -> 15         : 0        |                                        |               8 -> 15         : 0        |                                        |
>         16 -> 31         : 0        |                                        |              16 -> 31         : 0        |                                        |
>         32 -> 63         : 0        |                                        |              32 -> 63         : 0        |                                        |
>         64 -> 127        : 0        |                                        |              64 -> 127        : 0        |                                        |
>        128 -> 255        : 0        |                                        |             128 -> 255        : 0        |                                        |
>        256 -> 511        : 0        |                                        |             256 -> 511        : 0        |                                        |
>        512 -> 1023       : 0        |                                        |             512 -> 1023       : 0        |                                        |
>       1024 -> 2047       : 0        |                                        |            1024 -> 2047       : 0        |                                        |
>       2048 -> 4095       : 0        |                                        |            2048 -> 4095       : 0        |                                        |
>       4096 -> 8191       : 0        |                                        |            4096 -> 8191       : 0        |                                        |
>       8192 -> 16383      : 0        |                                        |            8192 -> 16383      : 0        |                                        |
>      16384 -> 32767      : 0        |                                        |           16384 -> 32767      : 0        |                                        |
>      32768 -> 65535      : 0        |                                        |           32768 -> 65535      : 0        |                                        |
>      65536 -> 131071     : 0        |                                        |           65536 -> 131071     : 0        |                                        |
>     131072 -> 262143     : 0        |                                        |          131072 -> 262143     : 0        |                                        |
>     262144 -> 524287     : 0        |                                        |          262144 -> 524287     : 0        |                                        |
>     524288 -> 1048575    : 0        |                                        |          524288 -> 1048575    : 0        |                                        |
>    1048576 -> 2097151    : 0        |                                        |         1048576 -> 2097151    : 0        |                                        |
>    2097152 -> 4194303    : 0        |                                        |         2097152 -> 4194303    : 0        |                                        |
>    4194304 -> 8388607    : 861      |**                                      |         4194304 -> 8388607    : 1136     |****                                    |
>    8388608 -> 16777215   : 3111     |********                                |         8388608 -> 16777215   : 6320     |************************                |
>   16777216 -> 33554431   : 13901    |****************************************|        16777216 -> 33554431   : 10484    |****************************************|
> Exiting trace of synchronize_rcu                                                    Exiting trace of synchronize_rcu
> 
Who is B and who is A?

> 
> Interestingly I tried the same experiment without rcu_normal=1 (leaving rcu_expedited=1):
> 
> adb shell cat /proc/cmdline | tr ' ' '\n' | grep rcu
> rcupdate.rcu_expedited=1
> rcu_nocbs=0-7
> 
> In this case I also saw the -6 to -7% decrease in the app launch times
> but I don't have a good explanation why that would be? (The fucntion
> latency histograms in this case didn't show any significant difference).
> Do you have any insight why this may happen?
> 
When rcu_expedited=1 is set and rcu_normal=0 is disabled. The
synchronize_rcu() call is converted into synchronize_rcu_expidited():

<snip>
void synchronize_rcu(void)
{
	unsigned long flags;
	struct rcu_node *rnp;

	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
			 lock_is_held(&rcu_lock_map) ||
			 lock_is_held(&rcu_sched_lock_map),
			 "Illegal synchronize_rcu() in RCU read-side critical section");
	if (!rcu_blocking_is_gp()) {
		if (rcu_gp_is_expedited())
			synchronize_rcu_expedited();
		else
			synchronize_rcu_normal();
		return;
	}
..
<snip>

rcu_gp_is_expidited() is true, so invoke "expedited" version.

I see some concerns in preferring an expedited version as a global
replacement. First of all it is related to latency sensitive workloads
because in order to expedite a grace period it sends out IPIs on all
online CPUs to force them to report a quiescent-state asap. I have not
investigated yet how it affects such workloads.

Therefore, in your case, you also see a performance boost of your app sets.

Thank you for looking at it!

--
Uladzislau Rezki

