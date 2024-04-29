Return-Path: <linux-kernel+bounces-162079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09C98B5597
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D83BCB209E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491C93715E;
	Mon, 29 Apr 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="faZ8shbe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cmk4WAQo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AA17BB4;
	Mon, 29 Apr 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387256; cv=none; b=k4FrCuGA0DSAsMBb0CR682aFhFUOHQ99B8uOJ2uAPmeZMux5n/eO7FWCoQATMZElDYQpgRzCuEMYIRvU5qxKyd11u5JSif/2FlGWmdl3zYUWQVc/IJ119eZaqdxkctw6te5PGo26j2kcQNrFYpQmEUbQv+wasMx4axIc7GyCN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387256; c=relaxed/simple;
	bh=y5x7amVJ/sqQKb3JnyAhmkVdBx0ResiB8bNE31f7Bao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h+SCl4K13uTAuoa2xpI/gm2YLprjKCbiNWhNaOuSdrAwaVYDEiepFFQ51+exYjS3ofNW5tDggghoOaOAaJe3Ua97fssTs+Jz4Czqj0lbkDBG4DtYFemgVnw3AEO5f18EK87iQ3oVDNwAZg80Mo9s7RVLEzFKIhGwrUV7Lk/oZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=faZ8shbe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cmk4WAQo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714387253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=op6A8/PmHmUNQW21h+dT1TGGNeQ/SjvmhaKqAuCSxss=;
	b=faZ8shbeeWMWVgx2ZidxD1jd7kLbz7E2iHygKQls0+1waERTfbEfYwolZc/p41P4ZfsVFP
	z2REY2O8xnA8EkVPY0ss8HBZ5E/8DJVLsZEZCqn9kGvJjLJ1aVw2873qele3U3u3is4Kii
	yt0xJULBB61l0DC3R10DkSwnzcfeiqemtnrYLWT3GcOvtea4xDhdNiCfYlZslVFMaNhSMz
	tpnC6X9tBzthZ1beqbKuInhRfwMPTCtIlpzO7qtOzwD9j/Wcg01hLYCh30U/xi+9QWmiA4
	7epGw3fxlxl8Bojp1ProVs39Z/zRx6lRMnou7HsFqt+K7YAgDQWxHmpiE9Ayew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714387253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=op6A8/PmHmUNQW21h+dT1TGGNeQ/SjvmhaKqAuCSxss=;
	b=cmk4WAQoe/sUuJUi/wV9eWKU6tDCWSxctr3uPrCJ2VkMhIP916S5FWetvBgVtixgiMYnHT
	bFAv/1Rrnf2y/9CA==
To: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, ying.huang@intel.com, feng.tang@intel.com,
 fengwei.yin@intel.com, Frederic Weisbecker <frederic@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [linus:master] [timers] 7ee9887703:
 stress-ng.uprobe.ops_per_sec -17.1% regression
In-Reply-To: <87zftcy0xt.fsf@somnus>
References: <Zgtjdd0C2FzYVBto@xsang-OptiPlex-9020> <87zfth3l6y.fsf@somnus>
 <CAJZ5v0g_GKF8-QK5UdFCpJapf+MK7EouQ7hMTVtPYRjNNyUt+g@mail.gmail.com>
 <3aba1a1d-8ebc-4ee0-9caf-d9baae586db7@arm.com> <87zftcy0xt.fsf@somnus>
Date: Mon, 29 Apr 2024 12:40:52 +0200
Message-ID: <87sez4xxhn.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anna-Maria Behnsen <anna-maria@linutronix.de> writes:

> Hi,
>
> Lukasz Luba <lukasz.luba@arm.com> writes:
>> On 4/26/24 17:03, Rafael J. Wysocki wrote:
>>> On Thu, Apr 25, 2024 at 10:23=E2=80=AFAM Anna-Maria Behnsen
>>> <anna-maria@linutronix.de> wrote:
>
> [...]
>
>>>> So my assumption here is, that cpuidle governors assume that a deeper
>>>> idle state could be choosen and selecting the deeper idle state makes =
an
>>>> overhead when returning from idle. But I have to notice here, that I'm
>>>> still not familiar with cpuidle internals... So I would be happy about
>>>> some hints how I can debug/trace cpuidle internals to falsify or verify
>>>> this assumption.
>>>=20
>>> You can look at the "usage" and "time" numbers for idle states in
>>>=20
>>> /sys/devices/system/cpu/cpu*/cpuidle/state*/
>>>=20
>>> The "usage" value is the number of times the governor has selected the
>>> given state and the "time" is the total idle time after requesting the
>>> given state (ie. the sum of time intervals between selecting that
>>> state by the governor and wakeup from it).
>>>=20
>>> If "usage" decreases for deeper (higher number) idle states relative
>>> to its value for shallower (lower number) idle states after applying
>>> the test patch, that will indicate that the theory is valid.
>>
>> I agree with Rafael here, this is the first thing to check, those
>> statistics. Then, when you see difference in those stats in baseline
>> vs. patched version, we can analyze the internal gov decisions
>> with help of tracing.
>>
>> Please also share how many idle states is in those testing platforms.
>
> Thanks Rafael and Lukasz, for the feedback here!
>
> So I simply added the state usage values for all 112 CPUs and calculated
> the diff before and after the stress-ng call. The values are from a
> single run.
>

Now here are the values of the states and the time because I forgot to
track also the time in the first run:

USAGE		good            bad		bad+patch
		----            ---             ---------
state0          115		137		234
state1          450680		354689		420904
state2          3092092		2687410		3169438


TIME		good            bad		bad+patch
		----            ---             ---------
state0		9347		9683		18378
state1		626029557	562678907	593350108
state2		6130557768	6201518541	6150403441


> good:	57e95a5c4117 ("timers: Introduce function to check timer base
>         is_idle flag")
> bad:    v6.9-rc4
> bad+patch: v6.9-rc4 + patch
>
> I choosed v6.9-rc4 for "bad", to make sure all the timer pull model fixes
> are applied.
>
> If I got Raphael right, the values indicate, that my theory is not
> right...

.. but with the time values: CPUs are less often but in total longer in
state2.

Thanks,

	Anna-Maria

