Return-Path: <linux-kernel+bounces-145459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA388A5661
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECF51C213C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAA578C71;
	Mon, 15 Apr 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EmqXj4nA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FQ/mEvSW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619B160EF9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194898; cv=none; b=hvKw4FSKHLzwxbqpjEfbBDO437c2X7Uvr8xFDmpj9JUiAbHdacA5YuXMlS4NMfokjIytM6T9ToB9ABuF1uLaQo6qfQrzz8DLtpgEVagFD2OIvOGGy4cy0MpjDQgBIT/uJoHdAEqusX5pJ4JJ6jGjSYTlyDf2lIm37Tz0na9Tpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194898; c=relaxed/simple;
	bh=8F9ucDIw0mXDD0ZlZXTS1GEvdOSfw7kx0csGX6bWCNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DcwCdC0VgDVzkxhfgSiSXQM8wEFei9RLrAcIGB6VNXToOyrlJ/V4DiyPhvrxD83/6UTWVmJwAUNsZQVLhEU3thJ1ffLCP+n5OxDsXPPgFkVivf6LugyYFbPNJHF05OCFTdCLmUWKW99On6p60ttqPE24xmKA4KcIemi3bfjcIvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EmqXj4nA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FQ/mEvSW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713194895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8F9ucDIw0mXDD0ZlZXTS1GEvdOSfw7kx0csGX6bWCNU=;
	b=EmqXj4nAPJDhXsEarHCiyRSkFRZXjKB27EtzZqqxoc6DJ6X5+WMtVcGTezw+41D3ZsOh3R
	SZFit7eJtkR69J/mXmJFFuWHPSkXqWSDiDwJz4N+80runJlIrucQXdM4hkYNakaRN8Lrg7
	hqxsEkJqZmMOq23qcq90T21a0sP/hTe2O3PO3QU0aTJelhCeinGqgZuIiLUAzNTVAmQL5v
	b374Q7n8XBZ9NAlb3Y+o/NX7EzbXDwnJhToY8FWbgrrlx+UQL6MUzI8V7TRekjgAjZLkSE
	g47nyxyrN4J5I0TzvOqEjK4rMDGImAoQ15hyFveSmJTwOPbosWtHnX4i2vDqmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713194895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8F9ucDIw0mXDD0ZlZXTS1GEvdOSfw7kx0csGX6bWCNU=;
	b=FQ/mEvSWEVJe22UIXtF8pX4dEjuI1FskVSsBFplYfOEjPYarAO8d3N/KNcz2MDsykqNHkQ
	jikbsKZhfF1hjCBA==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 16/50] posix-cpu-timers: Simplify posix_cpu_timer_set()
In-Reply-To: <20240410165551.943625183@linutronix.de>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.943625183@linutronix.de>
Date: Mon, 15 Apr 2024 17:28:14 +0200
Message-ID: <877cgyve5t.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> Avoid the late sighand lock/unlock dance when a timer is not armed to
> enforce reevaluation of the timer base so that the process wide CPU timer
> sampling can be disabled.
>
> Do it right at the point where the arming decision is made which already
> has sighand locked.
>

Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

