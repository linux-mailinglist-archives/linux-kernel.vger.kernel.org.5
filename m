Return-Path: <linux-kernel+bounces-54645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC0884B1EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C0D1F24D8E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ACA12DD8B;
	Tue,  6 Feb 2024 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fz9I91x7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mSGaNTQG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00591E4AE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213983; cv=none; b=N3W4snrP9OT9I1znSPcrSLcGqQnXKt/k79/Q+OID+LYc/51x9D0/SJitbcvdd2Hb28ESFg41tmkNFzSmje+ZdZ/P9R7cx9yITrEo+vfL32UBH+Q+NpD4nzW+TTuLJk8cCZT14sOT8CszSbJZF3y1nC9kdrbVo0oB5s78GJo8G1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213983; c=relaxed/simple;
	bh=LnMWeAvoaoskkuDWGIHN7SmiE6ZEcRPNjOucfW4tTfs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OnsJC2pRAJcjgXRAAVw2Von9F0C5Ftssw32j1luIfSVUn4pp2hVtriRg9V0FyXemKZlq23iFUVBurw5h6zBAjZ0FSjU5WkP1jgFV1+9wcZMK7k2c4kPWlUSuD8TCyKTIlLZ5PYAsDKFkazolpx1D9a91R6pcmzHGt92ttqcGCRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fz9I91x7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mSGaNTQG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707213979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idJONz41UOIGMo273swuIiDhYL4rtcVvfBlz+o14yOw=;
	b=fz9I91x75TAAxJp5PS+xfvCQ6cw1N3UTtdHPUIvJIX79TsKH0Eo2OHTSDVaRTvJPEkb6JD
	n6jx+/I8wquy6qM01XcafAd240++0T3KrrTZX3RbRtkHY7KcN8xx1q+KwCx+4lMVBEQ1+9
	rNK4snKG0VmVAW/4KP3fm/DADvbWtUiqqgLz7SFHTlheeLWccZdcrGOESVYVZuGtYObCrt
	s1KLgEwWdFlkCa9VHIXXMoNB6ly+w5IEQb/zM7Uq4d7xfdWF7wsuDBSHDq1BW8C5Bzdozf
	qj+bNd7fUaiKHrKXTKswae8oj/X3uk9pyn9U8M1gY5R+QtVvutzK8Q8FxwU9HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707213979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idJONz41UOIGMo273swuIiDhYL4rtcVvfBlz+o14yOw=;
	b=mSGaNTQGn2YuuIfcElvGgavpvMU+IKMjwikEMfpsyYGYNb7lSyJ0tQbJmDzcoUUMJxeQZ3
	DZ/narPnhjjGnrBw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@infradead.org>,
 "Paul E . McKenney" <paulmck@kernel.org>, Rik van Riel <riel@surriel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Sebastian Siewior
 <bigeasy@linutronix.de>, Giovanni Gherdovich <ggherdovich@suse.cz>, Lukasz
 Luba <lukasz.luba@arm.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@intel.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
In-Reply-To: <ZcFFSgjcDcuz7Swv@pavilion.home>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZbuzMeKlCgebhJZ-@localhost.localdomain> <87bk90i2ja.fsf@somnus>
 <ZbvYJysR7gnaQiNg@localhost.localdomain> <87y1c3lxec.fsf@somnus>
 <87y1bzqbsx.fsf@somnus> <ZcFFSgjcDcuz7Swv@pavilion.home>
Date: Tue, 06 Feb 2024 11:06:19 +0100
Message-ID: <87jznh3o10.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Mon, Feb 05, 2024 at 02:29:34PM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> Anna-Maria Behnsen <anna-maria@linutronix.de> writes:
>>=20
>> > Frederic Weisbecker <frederic@kernel.org> writes:
>> >
>> >> Le Thu, Feb 01, 2024 at 05:15:37PM +0100, Anna-Maria Behnsen a =C3=A9=
crit :
>> >>> Frederic Weisbecker <frederic@kernel.org> writes:
>> >>>=20
>> >>> > Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a =C3=
=A9crit :
>> >>> > Heh, I was about to say that it's impossible that timer_base_is_id=
le()
>> >>> > at this stage but actually if we run in nohz_full...
>> >>> >
>> >>> > It happens so that nohz_full is deactivated until rcutree_online_c=
pu()
>> >>> > which calls tick_dep_clear() but it's a pure coincidence that might
>> >>> > disappear one day. So yes, let's keep it that way.
>> >>>=20
>> >>> I instrumented the code (with NOHZ FULL and NOHZ_IDLE) to make sure =
the
>> >>> timer migration hierarchy state 'idle' is in sync with the timer base
>> >>> 'idle'. And this was one part where it was possible that it runs out=
 of
>> >>> sync as I remember correctly. But if I understood you correctly, this
>> >>> shouldn't happen at the moment?
>> >>
>> >> Well, it's not supposed to :-)
>> >
>> > Hmm, let me double check this and run the tests on the instrumented
>> > version...
>>=20
>> I added a prinkt() to verify what I think I remember. I was able to see
>> the prints. So it seems, that the coincidence that nohz_full is
>> deactivated until rcutree_online_cpu() already disappeared.
>
> Nice, then I guess it can become a WARN_ON.

Either I misunderstood something, or wasn't able to explain what I
wanted to say.

I understood, that nohz full is disabled (by coincidence) until
rcutree_online_cpu() which comes after the timer migration CPU hotplug
AP. This means, that the check whether timer base is idle or not,
shouldn't be required in tmigr_cpu_online() to keep cpu idle or mark it
active in the hierarchy. But we could keep it in case coincidence
disappears. No?

So I added a printk() when timer base is idle in tmigr_cpu_online(). And
I was able to see the prints. This means, nohz full is _not_ disabled
when executing tmigr_cpu_online(), or am I wrong?

So when I replace the printk() with a WARN_ON() it will definitely
trigger. So I'm not sure if this is what you want to have :)

Thanks,

        Anna-Maria

