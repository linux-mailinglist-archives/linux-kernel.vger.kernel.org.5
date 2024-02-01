Return-Path: <linux-kernel+bounces-48283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E523845997
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED481C27FDB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340BC5D475;
	Thu,  1 Feb 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GKWED4Y5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/aX3yW02"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180225D473
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796303; cv=none; b=NcWvkb5QjIWYYmIo2g/w/fpPEt/iBUyVDnaQQnQ+Shvxdj0ea/mEarAYLBMA2u95QUuklJl992Ohp5R34KLN0qAHLtUUyRFCdvcFn/pwXrGTRvgkkP3QPoa6Nvq4u19FxduFeEHtuNQomfevnoPgcrDHJaK8i5KbWMdlm1BP3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796303; c=relaxed/simple;
	bh=qTbe2w2YOxtxZeFo7i+Hbfe5GUaAqTNREuYYUhZ4JRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZ9tcD28OBR7Kp49ZeXqIC/54MNdHKKRTwDWh72D5hWmboYCXZ8IfZsn4L/Sk8CYcuguWLfhHkEL7gj0uttJi7vIKxOpJZd9kAzGMTJ3x80OWKXAOKFqCvck0T4EC3lYGjKDysAeAj8mVE+neQQArhX82FzJBGdepPJqqGozFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GKWED4Y5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/aX3yW02; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706796300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8FZuGBOU1pHC+8Sc4g536Zw8P/8F9nULgyDhskpGg0=;
	b=GKWED4Y5w2e4gRq7iBnx5koSzwwyJjsNWO5zd2FFM+oBSEHoEr8nJWnUQgs5l39aENYsmc
	v7KmCZyS2IJOjB3Q12aVxWjtS0v1mytBzOW75762VayrulRES7dvVNJNQ04MGj9Q+iZlSL
	8eqax6XS9Js2jo75HLDv1K42ZUgXp6wymL1BkHoB2vAmKqKqnRXWyPWzr1j3kWMVTNsqzE
	qJhTl5Lr8yhixo+GXetrTZTnYISBNqC960dcPG9CdkFw0mXfyc1gwNIgVgbHKbRTcttE9b
	81zIJZSLDRhCFuU10X4m4OqiellpvmYRsk7vAuvDs3uxEtY21UETuaEMy2xKvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706796300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8FZuGBOU1pHC+8Sc4g536Zw8P/8F9nULgyDhskpGg0=;
	b=/aX3yW0250WjiLbGFnHQ+NttUrEVcV6WbMROFki6tCxV0eAKR45LYLmyy5FEe7Qsmc1dMb
	HwugZRPJPEcMrfDQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peng Liu
 <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 03/15] tick: Remove useless oneshot ifdeffery
In-Reply-To: <ZbuZyu2XmRO-UVCY@localhost.localdomain>
References: <20240131231120.12006-1-frederic@kernel.org>
 <20240131231120.12006-4-frederic@kernel.org> <87ttmsikud.fsf@somnus>
 <ZbuZyu2XmRO-UVCY@localhost.localdomain>
Date: Thu, 01 Feb 2024 15:04:59 +0100
Message-ID: <87il38i8l0.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Thu, Feb 01, 2024 at 10:40:10AM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> Frederic Weisbecker <frederic@kernel.org> writes:
>>=20
>> > tick-sched.c is only built when CONFIG_TICK_ONESHOT=3Dy, which is sele=
cted
>> > only if CONFIG_NO_HZ_COMMON=3Dy or CONFIG_HIGH_RES_TIMERS=3Dy. Therefo=
re
>> > the related ifdeferry in this file is needless and can be removed.
>> >
>> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>=20
>> It's a nitpick, but shouldn't the ordering of sob and reviewed-by be the
>> other way round?
>
> I've seen it both ways here and there, I'm not sure if there is a strict =
rule
> for it...
>

As it is for the tip maintainers, they have some rules - I don't know
how strictly they are used :)

  Documentation/process/maintainer-tip.rst


