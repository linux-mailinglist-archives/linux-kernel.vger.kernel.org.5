Return-Path: <linux-kernel+bounces-140637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872AE8A1715
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C972825AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B94214E2EF;
	Thu, 11 Apr 2024 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EJ3bs3fC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IxgkO6uq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A9149C7F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845513; cv=none; b=PplfQ1NZ33/NJvPwAIVK+TCHvh3NS7JOotkIhklAtgOtvJILtofMWk6+5ErVvjmS7G5zlbEw2G9j8/QSQauZBsrDuNlgcISEv0et2s83xxnX5P8I2pYTyK8eQ+aMayW/rKlI2NELHThgBrdevexS5mL99ObaB9gqrB1Z0ZpHnh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845513; c=relaxed/simple;
	bh=PZP5QcVK83AK5kTIbDXf89GtmzISnvQfTR1cmMBW7y4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FSguYeSAn7SsdWumImNeod+0GDNKG78gB5i9x0PaAgztvoZkr5B8mCsWVJeEnZNkYe5mim7iIxA0N3imE5ArnVFMg+54Df8RcoUPhJMi0imfY2K7c3Dp+a6qwyUK+0WqrUumU7nL2Fh0R0h9WqOivYrSa2kxolAoJkTRtODBi0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EJ3bs3fC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IxgkO6uq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712845510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEKIPLmzSrj2/vg+Hg5MOencwz/q/754oDxsJ/Tx2DI=;
	b=EJ3bs3fC1I/+RSvJYqb7XXQV67cp4yS8p/3KrTfLdd/pmMc5EW+iP1gZpL14yi4GTvJ2pq
	w9SD1TJpLKYDepgFukqrRP4iKU/eAfbla5dXalVQ88CaTQVo/8CMUGYZ2VRcTLGM9zEo4w
	MSKxgxkgdumZ9aOydhzQjzGCt2hgiOtZWXyV+LIpz+Jxq6ETHvDjNCw5KCeMv+bOnjZL3b
	SjUbVlYftfm6QCrVbtkqpaBfdcXx6bUI/SNCEcC38uuXpUcJXvRfhn7GAaQ+tsQ733oMTW
	kQbxSU5FP6KY3M+GUhwZ7M2RdESwWzbI5vRzw5Ta6BNcAX4gj53Cowr1wgnBZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712845510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEKIPLmzSrj2/vg+Hg5MOencwz/q/754oDxsJ/Tx2DI=;
	b=IxgkO6uqCPYcJmHwXfKg5lok+Rx2ZIvaovD0qUG+ioF46cvSN0ypdxn3+bck4YD1Kr5ChE
	osa3lk2CeEaYT1DQ==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 08/50] posix-cpu-timers: Save interval only for armed
 timers
In-Reply-To: <20240410165551.442678509@linutronix.de>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.442678509@linutronix.de>
Date: Thu, 11 Apr 2024 16:25:10 +0200
Message-ID: <875xwougc9.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> There is no point to return the interval for timers which have been
> disarmed.
>

common_timer_get() returns/updates interval unconditionally - so
behavior then differs.

Thanks,

	Anna-Maria

