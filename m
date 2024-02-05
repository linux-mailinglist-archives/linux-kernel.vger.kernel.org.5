Return-Path: <linux-kernel+bounces-52716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82318849BC5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6A11C229BC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039FB1CFB2;
	Mon,  5 Feb 2024 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xpUjKGve";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ralIZEmh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851E1CD07
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139779; cv=none; b=KNbsLo1Gufv/yvWU9suO0uUiCcLw88heBQOQwiBKZYr8uZna6fGQgumV4Q2okZ7+MLw55Bw/iYawJOm7zYKtWBQE95nRVxyntdcCb1Sam1HgrYMUex6ASqs5mnrUkgjmbgjIGKYbuRMTSZEApl8vNa2x3dJjtgTp5yU4iJifcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139779; c=relaxed/simple;
	bh=HSJDQGj09Vdrr1CI4vDZdQ+urLB1rzR9hCsQlFmeb3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hi+KqKNg2EJd88s/OhmOZUYFV97YWgLidEk6dlG1Jrzgm7z3ijb8AUUQD4k0Cv89gPNBOww5IGfajQ4eySKh5hWCLQG64OR1k5IwVAAjTydgSDzyWFYrZXF/oYjj9VUaguN9Zeg5fXWw2UOGJw9IQBMk4FVAhlphp/g1xgq4+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xpUjKGve; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ralIZEmh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707139775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33RfgDPl/nKg741Zgol959MzqPz/EjpNFz30m1+ZUZk=;
	b=xpUjKGveVzslc4iTe+iP8VU3IpPOS5Cg9xeWiqg0on21O5LSYW67j1hy0AfqWqFTV7Rj4f
	NH+UY9R0b9i6nEqWtJMW3AikpmFjeIRKE4pKoMvJp89C8w1B6fb49/ptFADMMnJ36bu44o
	BgpWX1g6Sn6gB1m55qDGEm7y1Tv7vdbyDe4fSMG+2h1tYzEIzWxvKTqLMql3yRYhXHofKc
	uCfWgkcvE+cDSRoO2kb0w0YppmKuAFgaKxRD+/KVXh1SLiItzqFms3IfPDcTyyAv946YVn
	MaivX2LQwJulVs+WI5hKsBFbA15J1GCX6ltTu2AwDv9zb89NjHRS1mZVQ9Gbgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707139775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33RfgDPl/nKg741Zgol959MzqPz/EjpNFz30m1+ZUZk=;
	b=ralIZEmhpBCQi7io9fZDJADZBXYpALXfaOnHpmVaNG67bkZpDXguMNcqlhSVfDv47f+xf4
	hSgwGxs4GUO4kbCQ==
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
In-Reply-To: <87y1c3lxec.fsf@somnus>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZbuzMeKlCgebhJZ-@localhost.localdomain> <87bk90i2ja.fsf@somnus>
 <ZbvYJysR7gnaQiNg@localhost.localdomain> <87y1c3lxec.fsf@somnus>
Date: Mon, 05 Feb 2024 14:29:34 +0100
Message-ID: <87y1bzqbsx.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anna-Maria Behnsen <anna-maria@linutronix.de> writes:

> Frederic Weisbecker <frederic@kernel.org> writes:
>
>> Le Thu, Feb 01, 2024 at 05:15:37PM +0100, Anna-Maria Behnsen a =C3=A9cri=
t :
>>> Frederic Weisbecker <frederic@kernel.org> writes:
>>>=20
>>> > Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a =C3=A9=
crit :
>>> > Heh, I was about to say that it's impossible that timer_base_is_idle()
>>> > at this stage but actually if we run in nohz_full...
>>> >
>>> > It happens so that nohz_full is deactivated until rcutree_online_cpu()
>>> > which calls tick_dep_clear() but it's a pure coincidence that might
>>> > disappear one day. So yes, let's keep it that way.
>>>=20
>>> I instrumented the code (with NOHZ FULL and NOHZ_IDLE) to make sure the
>>> timer migration hierarchy state 'idle' is in sync with the timer base
>>> 'idle'. And this was one part where it was possible that it runs out of
>>> sync as I remember correctly. But if I understood you correctly, this
>>> shouldn't happen at the moment?
>>
>> Well, it's not supposed to :-)
>
> Hmm, let me double check this and run the tests on the instrumented
> version...

I added a prinkt() to verify what I think I remember. I was able to see
the prints. So it seems, that the coincidence that nohz_full is
deactivated until rcutree_online_cpu() already disappeared.

--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1672,6 +1672,8 @@ static int tmigr_cpu_online(unsigned int
 	tmc->idle =3D timer_base_is_idle();
 	if (!tmc->idle)
 		__tmigr_cpu_activate(tmc);
+	else
+		printk("TIMER BASE IS IDLE\n");
 	tmc->online =3D true;
 	raw_spin_unlock_irq(&tmc->lock);
 	return 0;

Thanks,

        Anna-Maria


