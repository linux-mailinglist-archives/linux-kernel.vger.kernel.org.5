Return-Path: <linux-kernel+bounces-91279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA1870C39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F4D1C222C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644E01C68E;
	Mon,  4 Mar 2024 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ksgBo3Ej";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6EKTe+l/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0544C10A3F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586783; cv=none; b=oocssFbBawd2BKSCETmI+tJR7nUx6f2Bjo7iTz/hqemCHUhSEyiUI1XukeHbhXTLioAKB9zdvzEGaiK8oV0A5k+ATMgia3VouA/CpRVF1HQB2aSf3tQVplOqVWHrQKXuENJzEQkICiqHqxIgKiN0nGtpSIxrO7ZHwTGXZTTcb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586783; c=relaxed/simple;
	bh=hjStLsdGorbBIIbaGe0InsFbZ+pj2miKsxKCpMz/pfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dJyksrFFk9x0vieLN16VyKtQfEdpmx6Ot6nS058niKGCeq2v4oJIQzKi7P4IXuLHPM2xR6AuuPbtnPPawPPYCRzyoCu6bodx5XxX7G6ajcxFi4rlKTo7RydPHUfDWBQFVjbTqLOwprsKrW38lboF75AyNhIF4ScQujziln9LeYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ksgBo3Ej; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6EKTe+l/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709586779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KTp//xg2p3SQSnpDgV8BdiNH9CEAQZVSTL74QA4IE/E=;
	b=ksgBo3Ej/9aEpeZGTWjdXVZgr3ZjFxJgFJrqm5ZL74t+ipQEMM7x2B357WuKOT3DkLF7XD
	WCwcsUMQvEn/cgtwG9tuxbMeeZh/uq11JIJXtytaiHhJNjCuw6uiWqCDdXl9iyb5Jri3+X
	GjboRYq2HTHH7x+KJmiPEosDN9EGFo7/kmMNSEBGcwGXln/L61qn8s4u8coJ1LOmpngs2a
	uSBRXtragPgAjcAPICYhv7CGvDeh3JKWj2XUjwPYMBbXBDLZLsOUlr4FSXsihzQ8Yua3Gl
	t/Yuf0LPm//4D2WgCZ72vFD9fCA8cVW7kcjW56IDz3nQ6ts0BpmqDsjGx9/FqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709586779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KTp//xg2p3SQSnpDgV8BdiNH9CEAQZVSTL74QA4IE/E=;
	b=6EKTe+l/QqSriJ0g/Bbn7l0O3YKRE6L0rFP1Jx2bp5Zti3184ExK9/fPBVd6i/bd19BvxU
	mBgDg7IBny7/94AQ==
To: Jocelyn Falempe <jfalempe@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Andrew
 Morton <akpm@linux-foundation.org>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Kefeng Wang <wangkefeng.wang@huawei.com>, Lukas
 Wunner <lukas@wunner.de>, Uros Bizjak <ubizjak@gmail.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, Uros Bizjak <ubizjak@gmail.com>, Petr
 Mladek <pmladek@suse.com>, Daniel Thompson <daniel.thompson@linaro.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [RFC] How to test panic handlers, without crashing the kernel
In-Reply-To: <266579a9-fde6-40ff-b13d-fb2312db406c@redhat.com>
References: <266579a9-fde6-40ff-b13d-fb2312db406c@redhat.com>
Date: Mon, 04 Mar 2024 22:18:24 +0106
Message-ID: <87edcpn1l3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[Added printk maintainer and kdb folks]

Hi Jocelyn,

On 2024-03-01, Jocelyn Falempe <jfalempe@redhat.com> wrote:
> While writing a panic handler for drm devices [1], I needed a way to 
> test it without crashing the machine.
> So from debugfs, I called 
> atomic_notifier_call_chain(&panic_notifier_list, ...), but it has the 
> side effect of calling all other panic notifiers registered.
>
> So Sima suggested to move that to the generic panic code, and test all 
> panic notifiers with a dedicated debugfs interface.
>
> I can move that code to kernel/, but before doing that, I would like to 
> know if you think that's the right way to test the panic code.

One major event that happens before the panic notifiers is
panic_other_cpus_shutdown(). This can cause special situations because
CPUs can be stopped while holding resources (such as raw spin
locks). And these are the situations that make it so tricky to have safe
and reliable notifiers. If triggered from debugfs, these situations will
never occur.

My concern is that the tests via debugfs will always succeed, but in the
real world panic notifiers are failing/hanging/exploding. IMHO useful
panic testing requires real panic'ing.

For my printk panic tests I trigger unknown NMIs while booting with
"unknown_nmi_panic". Particularly with Qemu this is quite easy and
amazingly effective at catching problems. In fact, a recent printk
series [0] fixed seven issues that were found through this method of
panic testing.

> The second question is how to simulate a panic context in a
> non-destructive way, so we can test the panic notifiers in CI, without
> crashing the machine.

I'm wondering if a "fake panic" can be implemented that quiesces all the
other CPUs via NMI (similar to kdb) and then calls the panic
notifiers. And finally releases everything back to normal. That might
produce a fairly realistic panic situation and should be fairly
non-destructive (depending on what the notifiers do and how long they
take).

> The worst case for a panic notifier, is when the panic occurs in NMI
> context, but I don't know how to simulate that. The goal would be to
> find early if a panic notifier tries to sleep, or do other things that
> are not allowed in a panic context.

Maybe with a new boot argument "unknown_nmi_fake_panic" that triggers
the fake panic instead?

John Ogness

[0] https://lore.kernel.org/lkml/20240207134103.1357162-1-john.ogness@linutronix.de

