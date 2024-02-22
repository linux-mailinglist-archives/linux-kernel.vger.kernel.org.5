Return-Path: <linux-kernel+bounces-77322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB818603B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11A11C24F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A96E606;
	Thu, 22 Feb 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SR77vt2e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDOWpG9/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB610A05
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634018; cv=none; b=nBlO505P1g7i+IZN+YI0cAlvcoAsejOktTicMv9NYKg6uijZ0TLUM5hpHEGgWuEVRBh3+p5jxGj7nD3Jv+cN2O2D4IUdG+WeEXCeW4uwGu1HzPJLN+07diFEgAuyzOWIs24z5S2MgZhGUoP5HjThWpD1TKp8dyhehpoMWae0/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634018; c=relaxed/simple;
	bh=4Ps0iR9+3QGUlPjbNsHsXZLbNqooArLyZSC9K1TD72A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XL13Eth2I6ayUneENXlW8Vd+o/Z/RIr88CSOZtZHqXTeBInZNwvJWmd9T3+aEJrk8XbwLZse/qpbperL0fHS6KHKj+Ig+ELeamBa96OmTlCU2TflDWj6us/O/Cd7+inOR+qEp3pCh4sPQD/aVdx3+jOI6bnPciALghRcZtI4ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SR77vt2e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDOWpG9/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <jogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708634009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DniZuGJeiAYZMjYY1WgxfhTrSfX4CCM88FQCLYeTz9I=;
	b=SR77vt2eU/+wJ3ZBnhkR3OsQSE82MJEMnAhkdRz2jX2KfBaYv6vQIz5pt+rD4tQwrF8AZz
	P6E0+yEHPARD14V7eNz+ewwjfNlEbyhmMlovUClYyXNwUbnZWosMblEElc5ZIkU4T29W6O
	HJdDC0lTJxLF3M73ZmT80TXaBYQCMOgdmql37SkI/d6Xj9x7am7McP+d7GjrtABbe4WDkP
	BFAi0cA/KFsHyoCQWIq9w070WZphgnalCfHKR6+JeNXpHHFwxfSGETP53GgE/TOOFwiq5d
	hZBeVyIhwVaA4caBIw+lFU5v7GDlyr+JFF1ND7A8NBNm+byMnxis13RVu0LAvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708634009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DniZuGJeiAYZMjYY1WgxfhTrSfX4CCM88FQCLYeTz9I=;
	b=EDOWpG9/yLz7uA8dVZP7edFdoK8sGABu4QxTWZsQCjuY8Wn4Ws8hzWWStuTwRU+cwKaDbn
	7X0R+bb2tqBzC5CA==
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kernel-team@android.com
Subject: Re: [RFC][PATCH] hrtimer: Use printk_deferred_once for
 hrtimer_interrupt message
In-Reply-To: <CANDhNCoHqX9fo5e=K7_74YSmV8-T2tE-Obu+phhqy+n2bqc4QQ@mail.gmail.com>
References: <20240222051253.1361002-1-jstultz@google.com>
 <8734tkfrzz.ffs@tglx>
 <CANDhNCoHqX9fo5e=K7_74YSmV8-T2tE-Obu+phhqy+n2bqc4QQ@mail.gmail.com>
Date: Thu, 22 Feb 2024 21:39:04 +0106
Message-ID: <87wmqwz1bz.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-02-22, John Stultz <jstultz@google.com> wrote:
> On Thu, Feb 22, 2024 at 7:17=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> On Wed, Feb 21 2024 at 21:12, John Stultz wrote:
>> > With qemu, I constantly see lockdep warnings after the
>> > hrimter_interrupt message is printed:
>> >
>> > [   43.434557] hrtimer: interrupt took 6517564 ns
>> > [   43.435000]
>> > [   43.435000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > [   43.435000] [ BUG: Invalid wait context ]
>>
>> Do you have PROVE_RAW_LOCK_NESTING enabled?
>
> Yes, I do. Let me know if there's anything else you'd like me to try.

This option is to "ensure that the lock nesting rules for PREEMPT_RT
enabled kernels are not violated."

Since you are not running a PREEMPT_RT enabled kernel, these warnings
are irrelevant for _your_ kernel.

>> > I thought the new printk work was going to resolve this, but
>> > apparently not

Yes, it will, but it is not all mainline yet. The full printk rework is
only available as part of the PREEMPT_RT patch series [0]. With that
series applied, it makes more sense to enable PROVE_RAW_LOCK_NESTING
because the series should resolve all known lock nesting problems with
PREEMPT_RT. (And indeed, the warning you are reporting does not occur
there.)

If you really want to test lock nesting for PREEMPT_RT, I recommend
applying the PREEMPT_RT series and keeping PROVE_RAW_LOCK_NESTING
enabled. Otherwise, if you do not want to apply the PREEMPT_RT series, I
recommend disabling PROVE_RAW_LOCK_NESTING.

Note that you can apply the PREEMPT_RT series and still choose the
!PREEMPT_RT preemption model for your kernel.

John Ogness

[0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/l=
og/?h=3Dlinux-6.8.y-rt-rebase

