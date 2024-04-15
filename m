Return-Path: <linux-kernel+bounces-145315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EC88A5299
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B1F1C214F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402A374419;
	Mon, 15 Apr 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A9pZo1Ot";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AZCmW2T3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB47353F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189799; cv=none; b=Ydg78I9mkz1DK3ouD9cpDdfmOCXJ1oAEhC6wn1G6U0Pjt63SxweYF9Mh/PN6R9Fa0WMiLVkJA/rwdssGaBhwrWYt7q/m3BP+wSFTyo7+BGOLFA6yp/lvZ/OT698d+6NWhLYSqC6rAapRmV+AdJU2wHLD32V7YniRneR8ux/rxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189799; c=relaxed/simple;
	bh=xn8zrjZjBmz4WB664WGZU4YFqH/wLtmanPIn64LFWpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s1CBfER+2FLjKibYPtFcz/tcNIhtXkYk+9Q0GJonIW7s3/vfqyhZMKtaWcaI5CnYuMRszWYxCzYHiHvAcR/S5dFBqgaBoJS7srhrn/PlFsPAdsxWw/j4zIrayW8k45xir8tNDR1TZV+1uemEVbZzjE53qBBup6BGts1LJLgsFAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A9pZo1Ot; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AZCmW2T3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713189790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xn8zrjZjBmz4WB664WGZU4YFqH/wLtmanPIn64LFWpQ=;
	b=A9pZo1OtJQiU070ztBJ/gB4PZa8Vs7rLWkjq8XooA27cL5TQQu2xTv1i+Rbn/cf1sRXukS
	/9rveOVOJTXm2CyKpaDbzor9kjHj1BSQcoqCxAKvG3oYITw/Q2R4NqkBIRqcOm2WjFN0vf
	/Gkjh9Wv/Jd10hftvohTJVh2Wz09WkL6pj8aUIkyc10zEcQeWDxRn0/xSAX06c+M6O/4XC
	vZ7By48AjIcWewnyAXT3zOkseI+eklHcN/CHdPVVre+x3Rh4oPyqF7iwIT/v9H4SI4D4C0
	n7nzt2v6tflV+FWQfG7cK5bTo8sLeLuCwecGZ/aYTNhwHezokGm3Y47/3hKRlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713189790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xn8zrjZjBmz4WB664WGZU4YFqH/wLtmanPIn64LFWpQ=;
	b=AZCmW2T3xnj/yRkX83ZRyyVlTGPRsmzRoWbgVtF6wZlMdjUGZFNpjlMww8km9dQ4SBxK0f
	fhBZDrWAbHKN9vCQ==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 12/50] posix-cpu-timers: Replace old expiry retrieval
 in posix_cpu_timer_set()
In-Reply-To: <20240410165551.696591376@linutronix.de>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.696591376@linutronix.de>
Date: Mon, 15 Apr 2024 16:03:10 +0200
Message-ID: <87zftu7mg1.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> Reuse the split out __posix_cpu_timer_get() function which does already the
> right thing.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

