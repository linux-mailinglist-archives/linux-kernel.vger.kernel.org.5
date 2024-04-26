Return-Path: <linux-kernel+bounces-159852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C698B3523
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C351F215F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA99143C5F;
	Fri, 26 Apr 2024 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A2APrOue";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5U/SVVte"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5E9143899;
	Fri, 26 Apr 2024 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126552; cv=none; b=T0fYSAnblfoW0IwZGxkLg/2vKsE1c7Sg4rDNZWjqeErFXdTeIHLp1djLQdVu2FNGpkErCEhKKfM3FL4okd/JWPn+gh7WH0dqI8LLnK9QBtjrKvH4RLnYC/WRdXHUK9xAXQbDHI9necuQGaRPah+tZVNvJhQL90oC/SYTwd+Ds2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126552; c=relaxed/simple;
	bh=eczfEPf8+cFClZXypKyENnkZzh1ZDabFL3TAGE42UJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qYoYKINkcT9c0B+hLhCje0FPmyZKPfS63up8hClAZNOKlmXr4FdmojjU6uLyZi94ZK9QRuhJ9hg/K5yuiioMJnK3GVx+MRyucpa41BCCYJHyw17OEs+EbYKQNCspqvSHDa8Gr++i89H1jynF+CYyig0LjS0ycDvXtupckvGIGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A2APrOue; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5U/SVVte; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714126548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyQmuETk80+Og3yZd6Uncex8B3lEi+jXfmfyncA+Ljc=;
	b=A2APrOuetVI6C/yQVZOeesx+RmkjWqSWin3XQdMjtdNHbUXzbewqZrHP3dUtZNUi5A3YqO
	BehI0HeR0y7Tdze0Nex3Eby6nivnrYwCMk9CgWW3OGgC0x54C0liQpSmp071yxaYduE9Hc
	2W1dEC0eCFFWIGXkxYFK+a0qwz7sDGicV39vSufc5bKzKD/wTNYvmO3fXh8NDmHtRhsT+H
	vQFqfKjeKH/vw99E+OmAlPvcpBRQFbbwgoI9rQiLC7HJMiYvP1PA8V3V6/JtmKdRMKnDCV
	8fFuq4s+TYXBLJDDp+lg4YZdMdUtaN4Ts8i9MdlpBd3L6w27vBElg9OWp7X51Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714126548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyQmuETk80+Og3yZd6Uncex8B3lEi+jXfmfyncA+Ljc=;
	b=5U/SVVtev+wtSQkVBKpp2wGp4bHkO48NJOAPp3+411brazE8px+0OGRMjOFYL8R9CeCiYc
	doD/Wd9D/QjUFTCA==
To: Christian Loehle <christian.loehle@arm.com>, Oliver Sang
 <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
 feng.tang@intel.com, fengwei.yin@intel.com, Frederic Weisbecker
 <frederic@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [linus:master] [timers] 7ee9887703:
 stress-ng.uprobe.ops_per_sec -17.1% regression
In-Reply-To: <9272d284-ec2c-4e35-be90-c8852278b648@arm.com>
References: <87zfth3l6y.fsf@somnus>
 <9272d284-ec2c-4e35-be90-c8852278b648@arm.com>
Date: Fri, 26 Apr 2024 12:15:47 +0200
Message-ID: <87h6foig4s.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian Loehle <christian.loehle@arm.com> writes:

> On 25/04/2024 09:23, Anna-Maria Behnsen wrote:
>> Hi,
>>=20
>> (adding cpuidle/power people to cc-list)
>>=20
>> Oliver Sang <oliver.sang@intel.com> writes:
>>=20
>>> hi, Frederic Weisbecker,
>>>
>>> On Tue, Apr 02, 2024 at 12:46:15AM +0200, Frederic Weisbecker wrote:
>>>> Le Wed, Mar 27, 2024 at 04:39:17PM +0800, kernel test robot a =C3=A9cr=
it :
>>>>>
>>>>>
>>>>> Hello,
>>>>>
>>>>>
>>>>> we reported
>>>>> "[tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps -1.=
2% regression"
>>>>> in
>>>>> https://lore.kernel.org/all/202403011511.24defbbd-oliver.sang@intel.c=
om/
>>>>>
>>>>> now we noticed this commit is in mainline and we captured further res=
ults.
>>>>>
>>>>> still include netperf results for complete. below details FYI.
>>>>>
>>>>>
>>>>> kernel test robot noticed a -17.1% regression of stress-ng.uprobe.ops=
_per_sec
>>>>> on:
>>>>
>>>> The good news is that I can reproduce.
>>>> It has made me spot something already:
>>>>
>>>>    https://lore.kernel.org/lkml/ZgsynV536q1L17IS@pavilion.home/T/#m28c=
37a943fdbcbadf0332cf9c32c350c74c403b0
>>>>
>>>> But that's not enough to fix the regression. Investigation continues...
>>>
>>> Thanks a lot for information! if you want us test any patch, please let=
 us know.
>>=20
>> Oliver, I would be happy to see, whether the patch at the end of the
>> message restores the original behaviour also in your test setup. I
>> applied it on 6.9-rc4. This patch is not a fix - it is just a pointer to
>> the kernel path, that might cause the regression. I know, it is
>> probable, that a warning in tick_sched is triggered. This happens when
>> the first timer is alredy in the past. I didn't add an extra check when
>> creating the 'defacto' timer thingy. But existing code handles this
>> problem already properly. So the warning could be ignored here.
>>=20
>> For the cpuidle people, let me explain what I oberserved, my resulting
>> assumption and my request for help:
>>=20
>> cpuidle governors use expected sleep length values (beside other data)
>> to decide which idle state would be good to enter. The expected sleep
>> length takes the first queued timer of the CPU into account and is
>> provided by tick_nohz_get_sleep_length(). With the timer pull model in
>> place the non pinned timers are not taken into account when there are
>> other CPUs up and running which could handle those timers. This could
>> lead to increased sleep length values. On my system during the stress-ng
>> uprobes test it was in the range of maximum 100us without the patch set
>> and with the patch set the maximum was in a range of 200sec. This is
>> intended behaviour, because timers which could expire on any CPU should
>> expire on the CPU which is busy anyway and the non busy CPU should be
>> able to go idle.
>>=20
>> Those increased sleep length values were the only anomalies I could find
>> in the traces with the regression.
>>=20
>> I created the patch below which simply fakes the sleep length values
>> that they take all timers of the CPU into account (also the non
>> pinned). This patch kind of restores the behavoir of
>> tick_nohz_get_sleep_length() before the change but still with the timer
>> pull model in place.
>>=20
>> With the patch the regression was gone, at least on my system (using
>> cpuidle governor menu but also teo).
>
> I assume the regression is reproducible for both?
> (The original report is using menu for anyone else looking at this)

Yes. (at least in my setup)

>>=20
>> So my assumption here is, that cpuidle governors assume that a deeper
>> idle state could be choosen and selecting the deeper idle state makes an
>> overhead when returning from idle. But I have to notice here, that I'm
>> still not familiar with cpuidle internals... So I would be happy about
>> some hints how I can debug/trace cpuidle internals to falsify or verify
>> this assumption.
>
> I'd say that sounds correct.
> Comparing cpu_idle_miss would be interesting for both.

	total nr	above		below
"bad":	2518343		2329072		189271
"good":	3016019         2960004		56015

-> this is the result of just a single run using:

  perf script record -a -e power:cpu_idle_miss /home/anna-maria/src/stress-=
ng/stress-ng --timeout 60  --times --verify --metrics --no-rand-seed --upro=
be 112



But beside of this, when running this stress-ng test, the cpus seems to
be mostly idle (top tells me). So the question here fore me is, what is
the stress in this test and what should the numbers tell we are
comparing? It is not totally clear to me even after looking at the code.

Thanks,

	Anna-Maria


