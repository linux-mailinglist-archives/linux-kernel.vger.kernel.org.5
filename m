Return-Path: <linux-kernel+bounces-166474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836F78B9B2A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77AA1C21C68
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2633C7F7EB;
	Thu,  2 May 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zxQGCFnm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BhdXEbAA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3167823D9;
	Thu,  2 May 2024 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654601; cv=none; b=Mhy/QdZClcqgraav8y0NjX+FTo03I56dYZuLAzbaBuUs2FyfuX9YVSTcq9KMALwf9zVwTZm1vKU+D1vlwIxJQNp8aAJQu9nYPuEvmISE53sL22WnIHzobBQhYz0VL9CJyTDojgH/I+T6Hq925J6UskP9F9GiU5+CaA6/ezl0e2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654601; c=relaxed/simple;
	bh=clVW9mGdBdg9TXlCTlD22bAmTuqBoHagRqQAWZ2rNz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OeBhvgIlQRhvcxik9AhEmZ6wDmt133OnScagF5M/GbyaYreFcBZAjMg4fjvu5wmAfrS9AczPbcFK+AmPL/iCBHhA16c1k9lFr2AsfhORuWzDcAwqPYFI2+F05bxzVnehoODReHEnYuhN7kdmXIT/71aboTtXo8rJsAbT1iPBb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zxQGCFnm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BhdXEbAA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714654597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjYDZW6+H5YqCRs45lbwaNsGQFiEJvG9P0BZQGh6L00=;
	b=zxQGCFnm94zj+aRQ3ZKAyxibSUunF/sH2J9LMisxeROwLoZ8GIr2Vcv66L7vJKjtcdlEtJ
	MTD+liW84KRiyfvJ3B7FATIl66Drvpzs4L4JFGbTjbwv4pr26cf34h09YwO0qNzTuLDsKW
	eXzSS5QZvdjMPpI4IeMBZkJPYmwlPhbY8ZqmcJiTFAEzAOnkNAEoC8mSbGhKR48ocue+Sp
	Z+A/VBUXBTQnuG6wl2z5o69Ze/7GXg9Q3KaGZbn3VMNaZ2fGvQSU8jC8+EMDyDD8Gx1Yba
	J5wyumXUB3LHNNu0f5enATglrQY3khHighhAnQL0OLLLigjLOq0ubWJCkApCLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714654597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjYDZW6+H5YqCRs45lbwaNsGQFiEJvG9P0BZQGh6L00=;
	b=BhdXEbAA4NhREuQC6Pi3jPT0qUku2RXfJAvtXRZhUjw/BAPE4MSI7oZNTk/FYFr+9jYohU
	DM8moLEzLDcW2PBQ==
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Oliver Sang <oliver.sang@intel.com>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
 feng.tang@intel.com, fengwei.yin@intel.com, Frederic Weisbecker
 <frederic@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-pm@vger.kernel.org
Subject: Re: [linus:master] [timers] 7ee9887703:
 stress-ng.uprobe.ops_per_sec -17.1% regression
In-Reply-To: <CAJZ5v0iLNWu6K2vhA3j==rbeHjku6eOvuWymRGcux4V9Xx_7Uw@mail.gmail.com>
References: <Zgtjdd0C2FzYVBto@xsang-OptiPlex-9020> <87zfth3l6y.fsf@somnus>
 <CAJZ5v0g_GKF8-QK5UdFCpJapf+MK7EouQ7hMTVtPYRjNNyUt+g@mail.gmail.com>
 <3aba1a1d-8ebc-4ee0-9caf-d9baae586db7@arm.com> <87zftcy0xt.fsf@somnus>
 <87sez4xxhn.fsf@somnus>
 <CAJZ5v0iLNWu6K2vhA3j==rbeHjku6eOvuWymRGcux4V9Xx_7Uw@mail.gmail.com>
Date: Thu, 02 May 2024 14:56:37 +0200
Message-ID: <87ikzwid8a.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Mon, Apr 29, 2024 at 12:40=E2=80=AFPM Anna-Maria Behnsen
> <anna-maria@linutronix.de> wrote:
>>
>> Anna-Maria Behnsen <anna-maria@linutronix.de> writes:
>>
>> > Hi,
>> >
>> > Lukasz Luba <lukasz.luba@arm.com> writes:
>> >> On 4/26/24 17:03, Rafael J. Wysocki wrote:
>> >>> On Thu, Apr 25, 2024 at 10:23=E2=80=AFAM Anna-Maria Behnsen
>> >>> <anna-maria@linutronix.de> wrote:
>> >
>> > [...]
>> >
>> >>>> So my assumption here is, that cpuidle governors assume that a deep=
er
>> >>>> idle state could be choosen and selecting the deeper idle state mak=
es an
>> >>>> overhead when returning from idle. But I have to notice here, that =
I'm
>> >>>> still not familiar with cpuidle internals... So I would be happy ab=
out
>> >>>> some hints how I can debug/trace cpuidle internals to falsify or ve=
rify
>> >>>> this assumption.
>> >>>
>> >>> You can look at the "usage" and "time" numbers for idle states in
>> >>>
>> >>> /sys/devices/system/cpu/cpu*/cpuidle/state*/
>> >>>
>> >>> The "usage" value is the number of times the governor has selected t=
he
>> >>> given state and the "time" is the total idle time after requesting t=
he
>> >>> given state (ie. the sum of time intervals between selecting that
>> >>> state by the governor and wakeup from it).
>> >>>
>> >>> If "usage" decreases for deeper (higher number) idle states relative
>> >>> to its value for shallower (lower number) idle states after applying
>> >>> the test patch, that will indicate that the theory is valid.
>> >>
>> >> I agree with Rafael here, this is the first thing to check, those
>> >> statistics. Then, when you see difference in those stats in baseline
>> >> vs. patched version, we can analyze the internal gov decisions
>> >> with help of tracing.
>> >>
>> >> Please also share how many idle states is in those testing platforms.
>> >
>> > Thanks Rafael and Lukasz, for the feedback here!
>> >
>> > So I simply added the state usage values for all 112 CPUs and calculat=
ed
>> > the diff before and after the stress-ng call. The values are from a
>> > single run.
>> >
>>
>> Now here are the values of the states and the time because I forgot to
>> track also the time in the first run:
>>
>> USAGE           good            bad             bad+patch
>>                 ----            ---             ---------
>> state0          115             137             234
>> state1          450680          354689          420904
>> state2          3092092         2687410         3169438
>>
>>
>> TIME            good            bad             bad+patch
>>                 ----            ---             ---------
>> state0          9347            9683            18378
>> state1          626029557       562678907       593350108
>> state2          6130557768      6201518541      6150403441
>>
>>
>> > good: 57e95a5c4117 ("timers: Introduce function to check timer base
>> >         is_idle flag")
>> > bad:    v6.9-rc4
>> > bad+patch: v6.9-rc4 + patch
>> >
>> > I choosed v6.9-rc4 for "bad", to make sure all the timer pull model fi=
xes
>> > are applied.
>> >
>> > If I got Raphael right, the values indicate, that my theory is not
>> > right...
>
> It appears so.
>
> However, the hardware may refuse to enter a deeper idle state in some cas=
es.
>
> It would be good to run the test under turbostat and see what happens
> to hardware C-state residencies.  I would also like to have a look at
> the CPU frequencies in use in all of the cases above.
>

	Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     SMI     POLL    C1      C2=
      POLL%   C1%     C2%     CPU%c1  CPU%c6  CoreTmp CoreThr PkgTmp  PkgWa=
tt RAMWatt PKG_%   RAM_%
good:	12      0.66    1842    2095    0.31    3584322 0       48      43991=
9  3146476 0.00    8.94    90.64   15.80   83.54   38      0       42      =
69.35   11.64   0.00    0.00
bad:	10      0.55    1757    2095    0.32    2867259 0       197     381975=
  2495863 0.00    9.00    90.65   14.94   84.51   38      0       41      6=
8.80   11.62   0.00    0.00
bad+p:	14      0.75    1832    2095    0.28    3582503 0       102     4401=
81  3147744 0.00    9.04    90.45   15.57   83.68   36      0       40     =
 69.28   11.54   0.00    0.00

I just took the 'summary line' of turbostat output and just used the
default turbostat settings. Before starting the test, the cpufreq
governor was set to performance for all CPUs (as the original test does
as well).

Thanks,

	Anna-Maria

