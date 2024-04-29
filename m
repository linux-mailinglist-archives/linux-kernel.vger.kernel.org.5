Return-Path: <linux-kernel+bounces-161985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4131C8B5436
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF17B2115D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B34D23746;
	Mon, 29 Apr 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KC3k+dj/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H965Peh0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107F617C79;
	Mon, 29 Apr 2024 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382786; cv=none; b=cpsFDlz4Lc7Ae6mhXW8poFILVK4YImyGmpszCynxidcTqBXznOFXJPPfYRyVftWLDdZvIBt6o8+dCxGOJnhIJnQ8DeIkkbYQZHDMliMedsuqXPwrXqO3Kr1soKjKbWHgSYSRxWDfKUwhygUgnU8onaN4KiQDSdLp28sS50oaaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382786; c=relaxed/simple;
	bh=SLVI6Etnc8zMjR1e/ICye9g8Ys1rXumPjVBxuNJ2eEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dMRkNK9J720YKzETtodvZxIc4v1D+6uGzGcN1Rf9rf6zrTmyBaFHfRjYprbJm40JkdhCmfxQOwI215JpsOsZQe+RZAVdXcj076O026nNvJdle5PGz3zJ8vjh3SsALuTGVnS6BlNDPt4x20YAw49kHdRK2DAKs87i4Kgb5vl85i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KC3k+dj/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H965Peh0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714382783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1GXw1gO6D6nnmB5gtcPpIclvYTx4k8uaGgwcw1GQyI=;
	b=KC3k+dj/b6aD0OV3B1ZT5L7VLTsrPP4SGcFONuCT/FqFeVqbSNpeC/8g6tbaHE3KAi0SCr
	gDi96Sl3LqPVhUtN+3WOm2mRJ81cei++NgydMeiUeuotebnQ76qtc9rhaxyU6bKFPlGSe5
	xCUz7Z5wWje8lX4mwYxS10/QQCGdPrMzVipxxRY3mLksJvIXevEeRl0SuO4wIvqM9d/8oX
	Wvgsey+KELYBIrINzYybeDcXrM6WVvhOVdhA0/wXcWxhhZbO/dftAf1YJhM8ITW+VVXaB6
	MQYHf0nXViozVYrWMZy7v3WGL9XZikmcuEVHigDBaCjtYWOdlnZazjlDLabNpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714382783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1GXw1gO6D6nnmB5gtcPpIclvYTx4k8uaGgwcw1GQyI=;
	b=H965Peh0WaXP3WFUroR+JUhgjaFxfYKtKSkheRGeuailliv31YsC89trAD+ZOfxUxYlxkZ
	5+mvcfkMciDVzpCA==
To: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, ying.huang@intel.com, feng.tang@intel.com,
 fengwei.yin@intel.com, Frederic Weisbecker <frederic@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [linus:master] [timers] 7ee9887703:
 stress-ng.uprobe.ops_per_sec -17.1% regression
In-Reply-To: <3aba1a1d-8ebc-4ee0-9caf-d9baae586db7@arm.com>
References: <Zgtjdd0C2FzYVBto@xsang-OptiPlex-9020> <87zfth3l6y.fsf@somnus>
 <CAJZ5v0g_GKF8-QK5UdFCpJapf+MK7EouQ7hMTVtPYRjNNyUt+g@mail.gmail.com>
 <3aba1a1d-8ebc-4ee0-9caf-d9baae586db7@arm.com>
Date: Mon, 29 Apr 2024 11:26:22 +0200
Message-ID: <87zftcy0xt.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Lukasz Luba <lukasz.luba@arm.com> writes:
> On 4/26/24 17:03, Rafael J. Wysocki wrote:
>> On Thu, Apr 25, 2024 at 10:23=E2=80=AFAM Anna-Maria Behnsen
>> <anna-maria@linutronix.de> wrote:

[...]

>>> So my assumption here is, that cpuidle governors assume that a deeper
>>> idle state could be choosen and selecting the deeper idle state makes an
>>> overhead when returning from idle. But I have to notice here, that I'm
>>> still not familiar with cpuidle internals... So I would be happy about
>>> some hints how I can debug/trace cpuidle internals to falsify or verify
>>> this assumption.
>>=20
>> You can look at the "usage" and "time" numbers for idle states in
>>=20
>> /sys/devices/system/cpu/cpu*/cpuidle/state*/
>>=20
>> The "usage" value is the number of times the governor has selected the
>> given state and the "time" is the total idle time after requesting the
>> given state (ie. the sum of time intervals between selecting that
>> state by the governor and wakeup from it).
>>=20
>> If "usage" decreases for deeper (higher number) idle states relative
>> to its value for shallower (lower number) idle states after applying
>> the test patch, that will indicate that the theory is valid.
>
> I agree with Rafael here, this is the first thing to check, those
> statistics. Then, when you see difference in those stats in baseline
> vs. patched version, we can analyze the internal gov decisions
> with help of tracing.
>
> Please also share how many idle states is in those testing platforms.

Thanks Rafael and Lukasz, for the feedback here!

So I simply added the state usage values for all 112 CPUs and calculated
the diff before and after the stress-ng call. The values are from a
single run.

		good            bad		bad+patch
                ----            ---             ---------
state0          111		68              234
state1          419774		362549		408681
state2          3184799		2499565		3185723


good:	57e95a5c4117 ("timers: Introduce function to check timer base
        is_idle flag")
bad:    v6.9-rc4
bad+patch: v6.9-rc4 + patch

I choosed v6.9-rc4 for "bad", to make sure all the timer pull model fixes
are applied.

If I got Raphael right, the values indicate, that my theory is not
right...

Thanks,

	Anna-Maria


