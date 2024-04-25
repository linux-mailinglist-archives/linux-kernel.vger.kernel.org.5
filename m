Return-Path: <linux-kernel+bounces-158190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EE28B1CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1FF1F2238A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72017602B;
	Thu, 25 Apr 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j0hGuAZv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+YjVG7VT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F06EB5C;
	Thu, 25 Apr 2024 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714033403; cv=none; b=MqTw1dzoznjTVEEpgBA3aVS4CIn68f21wfGM0xbqKmvbt+BxKL/Y01X01o+fGO8gj38cJECEBHYuc9y0jBQ+qv2ncFKw6Up/+m4XSXeRTqSjZVKMX2MIxkLYkTFKPORWc1dUWvm7Rdc8raIaLrQnwgKkkUYdm34VZR40tq9u0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714033403; c=relaxed/simple;
	bh=Rlbxz3u2vqwPstRKBIjl7j1GjBKJegaWgBYk/pt6M8I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=N+qcb0oqQBiFoTOTZbe0BfYDRmGI+HpiwFGlzB3VKAN1nHdtrYjSvBuFr6EJFfgLJOrMICuSfLOKKUDKGOKbolm5KFui7+efVhsV7lAg1rpM0iw7DSCTJOQSbRlcRUFvuM+s0iQlSbLIfCPb17hMUUhc9VauJ8RdPipFxndYTgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j0hGuAZv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+YjVG7VT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714033398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=iDsI25uhXnJgqSHJkPPaJgV5jixrLs3A43JUVime1PM=;
	b=j0hGuAZv4BHeY6RJrinui9eGMNeAQ3FjDt+LW/1JxufcmkVaas/PoeU2TeMlvtA5Bh7hA2
	/2n4J877BLZeNw/IyH1ZVHbih9T/c1KclkgeRt95AgIBu4RvWlzh8fmGVCXKh+qh+HLDfD
	0nHUu3VPDzZnuKq2v3pWs4LcdIfyQoeCZuSrs7SV4n9biNvYFiVZpZjvZOFzudRl0yshoI
	to6noXi+/uOkAH4lwTShrei2I74WTfQL1jafx8tB1m6fTvKwbyUIIOSyK9zUMZsATItMcc
	UJ/ln4ZA5C9USeUqYKdUoqLD4DbDadeTNFHLgAj9pcPmHhE+fwhKSBc3Q6/4Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714033398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=iDsI25uhXnJgqSHJkPPaJgV5jixrLs3A43JUVime1PM=;
	b=+YjVG7VT68vktrMEWqPmKkx4dIe0VbbXwmlzDMvEeE1YRLq7wpFhUJ0QkLIXWOVKXtieDE
	xjeliZNJeTmJp5CQ==
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
 feng.tang@intel.com, fengwei.yin@intel.com, Frederic Weisbecker
 <frederic@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [linus:master] [timers]  7ee9887703:
 stress-ng.uprobe.ops_per_sec -17.1% regression
In-Reply-To: <Zgtjdd0C2FzYVBto@xsang-OptiPlex-9020>
Date: Thu, 25 Apr 2024 10:23:17 +0200
Message-ID: <87zfth3l6y.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

(adding cpuidle/power people to cc-list)

Oliver Sang <oliver.sang@intel.com> writes:

> hi, Frederic Weisbecker,
>
> On Tue, Apr 02, 2024 at 12:46:15AM +0200, Frederic Weisbecker wrote:
>> Le Wed, Mar 27, 2024 at 04:39:17PM +0800, kernel test robot a =C3=A9crit=
 :
>> >=20
>> >=20
>> > Hello,
>> >=20
>> >=20
>> > we reported
>> > "[tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps -1.2=
% regression"
>> > in
>> > https://lore.kernel.org/all/202403011511.24defbbd-oliver.sang@intel.co=
m/
>> >=20
>> > now we noticed this commit is in mainline and we captured further resu=
lts.
>> >=20
>> > still include netperf results for complete. below details FYI.
>> >=20
>> >=20
>> > kernel test robot noticed a -17.1% regression of stress-ng.uprobe.ops_=
per_sec
>> > on:
>>=20
>> The good news is that I can reproduce.
>> It has made me spot something already:
>>=20
>>    https://lore.kernel.org/lkml/ZgsynV536q1L17IS@pavilion.home/T/#m28c37=
a943fdbcbadf0332cf9c32c350c74c403b0
>>=20
>> But that's not enough to fix the regression. Investigation continues...
>
> Thanks a lot for information! if you want us test any patch, please let u=
s know.

Oliver, I would be happy to see, whether the patch at the end of the
message restores the original behaviour also in your test setup. I
applied it on 6.9-rc4. This patch is not a fix - it is just a pointer to
the kernel path, that might cause the regression. I know, it is
probable, that a warning in tick_sched is triggered. This happens when
the first timer is alredy in the past. I didn't add an extra check when
creating the 'defacto' timer thingy. But existing code handles this
problem already properly. So the warning could be ignored here.

For the cpuidle people, let me explain what I oberserved, my resulting
assumption and my request for help:

cpuidle governors use expected sleep length values (beside other data)
to decide which idle state would be good to enter. The expected sleep
length takes the first queued timer of the CPU into account and is
provided by tick_nohz_get_sleep_length(). With the timer pull model in
place the non pinned timers are not taken into account when there are
other CPUs up and running which could handle those timers. This could
lead to increased sleep length values. On my system during the stress-ng
uprobes test it was in the range of maximum 100us without the patch set
and with the patch set the maximum was in a range of 200sec. This is
intended behaviour, because timers which could expire on any CPU should
expire on the CPU which is busy anyway and the non busy CPU should be
able to go idle.

Those increased sleep length values were the only anomalies I could find
in the traces with the regression.

I created the patch below which simply fakes the sleep length values
that they take all timers of the CPU into account (also the non
pinned). This patch kind of restores the behavoir of
tick_nohz_get_sleep_length() before the change but still with the timer
pull model in place.

With the patch the regression was gone, at least on my system (using
cpuidle governor menu but also teo).

So my assumption here is, that cpuidle governors assume that a deeper
idle state could be choosen and selecting the deeper idle state makes an
overhead when returning from idle. But I have to notice here, that I'm
still not familiar with cpuidle internals... So I would be happy about
some hints how I can debug/trace cpuidle internals to falsify or verify
this assumption.

Thanks,

	Anna-Maria

---8<----
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3baf2fbe6848..c0e62c365355 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2027,7 +2027,8 @@ static unsigned long next_timer_interrupt(struct time=
r_base *base,
 static unsigned long fetch_next_timer_interrupt(unsigned long basej, u64 b=
asem,
 						struct timer_base *base_local,
 						struct timer_base *base_global,
-						struct timer_events *tevt)
+						struct timer_events *tevt,
+						struct timer_events *defacto)
 {
 	unsigned long nextevt, nextevt_local, nextevt_global;
 	bool local_first;
@@ -2035,6 +2036,14 @@ static unsigned long fetch_next_timer_interrupt(unsi=
gned long basej, u64 basem,
 	nextevt_local =3D next_timer_interrupt(base_local, basej);
 	nextevt_global =3D next_timer_interrupt(base_global, basej);
=20
+	if (defacto) {
+		if (base_global->timers_pending)
+			defacto->global =3D basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+
+		if (base_local->timers_pending)
+			defacto->local =3D basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+	}
+
 	local_first =3D time_before_eq(nextevt_local, nextevt_global);
=20
 	nextevt =3D local_first ? nextevt_local : nextevt_global;
@@ -2113,7 +2122,7 @@ void fetch_next_timer_interrupt_remote(unsigned long =
basej, u64 basem,
 	lockdep_assert_held(&base_local->lock);
 	lockdep_assert_held(&base_global->lock);
=20
-	fetch_next_timer_interrupt(basej, basem, base_local, base_global, tevt);
+	fetch_next_timer_interrupt(basej, basem, base_local, base_global, tevt, N=
ULL);
 }
=20
 /**
@@ -2228,6 +2237,7 @@ static void timer_use_tmigr(unsigned long basej, u64 =
basem,
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 base=
m,
 					     bool *idle)
 {
+	struct timer_events defacto =3D { .local =3D KTIME_MAX, .global =3D KTIME=
_MAX };
 	struct timer_events tevt =3D { .local =3D KTIME_MAX, .global =3D KTIME_MA=
X };
 	struct timer_base *base_local, *base_global;
 	unsigned long nextevt;
@@ -2250,7 +2260,7 @@ static inline u64 __get_next_timer_interrupt(unsigned=
 long basej, u64 basem,
 	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
=20
 	nextevt =3D fetch_next_timer_interrupt(basej, basem, base_local,
-					     base_global, &tevt);
+					     base_global, &tevt, &defacto);
=20
 	/*
 	 * If the next event is only one jiffie ahead there is no need to call
@@ -2319,6 +2329,7 @@ static inline u64 __get_next_timer_interrupt(unsigned=
 long basej, u64 basem,
 	raw_spin_unlock(&base_global->lock);
 	raw_spin_unlock(&base_local->lock);
=20
+	tevt.local =3D min_t(u64, defacto.local, defacto.global);
 	return cmp_next_hrtimer_event(basem, tevt.local);
 }
=20


