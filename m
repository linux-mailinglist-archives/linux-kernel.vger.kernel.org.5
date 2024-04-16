Return-Path: <linux-kernel+bounces-147209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B338D8A7106
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4EA71C21F45
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D35134405;
	Tue, 16 Apr 2024 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0iFBo3BG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sXzw1Q4G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A7132C1F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283980; cv=none; b=EjOKaJO6p9aYlGusIiLJN6aOBQ9IHP4v6peFzaQ49BUBw3/f5PMoeXcBeN02MUpvruZ9nXZfmSIZVko78R8DOU1Sfrc+XoQf3xIekFEsQbhe7rP6WpQqy3j7DtEsog6EIrx0lLWDW27ibwkeg6RQ8HlCFJm7e+5K92PYX0ln32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283980; c=relaxed/simple;
	bh=ek2Uhj6jyWBHj/ELjUsynLoBx8LqHZN7YqgFHvI8yPI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=Ul06XU8dOH3fgoffS13jfnJvydLQxouuVmUKm4N2KY/QDRfPkXLgM+jsrlPn9nz+7NPLEugNp+Xb7bmPmXwT0OYPzxiWvKn4WCxazkrS6WF3dZcXk8ypAt6ONT3bpClXW8pG+89CUnXEDwh81rFqFbrW44y9SkcAApoGPSZBHx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0iFBo3BG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sXzw1Q4G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713283977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=+3n9DTHYm/EkmX9oZRWIc3/YuhdZcuLGGOtL2I/84FI=;
	b=0iFBo3BGImp0EbEh+nKQ0hZwmEzgsyLQggdpAI88keBczuN8lWPxML46rK5SkUKoXswQI2
	H2LMslVvXmlbQcJzgB+93nkoIvDtKeEt0D/jmk3iswNZOdf1ZO7eFWl4NWqMgNZU8ZlszX
	HNXQALx/vgUi11NaT1eVOMOlDg+NA1G3/JNigSDFAZg/vEgnzRWbTR8drjzaGS3JLDyLZ3
	dSPDjcCnAlLwIuJoYH6CopqvONTMcXqIitoVKTD1mt7cii/8HNO1x+AoKhzMZhHeBdc4lz
	SgLSTiamSwWfrZHm1Ti4pn55wnVS9lzxiHVj46355TOYtXQWc+GWPOmVMXc9Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713283977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=+3n9DTHYm/EkmX9oZRWIc3/YuhdZcuLGGOtL2I/84FI=;
	b=sXzw1Q4G005Y3UbrKZtyQwlt3IozTAXkK9B7OcRbTlYDD6VMAqRwn69n9yp/tw/dqI2oK5
	pIl3DnenX1i+aKAw==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 20/50] posix-timers: Consolidate timer setup
In-Reply-To: <20240410165552.194398633@linutronix.de>
Date: Tue, 16 Apr 2024 18:12:56 +0200
Message-ID: <87le5djng7.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> hrtimer based and CPU timers have their own way to install the new interval
> and to reset overrun and signal handling related data.
>
> Create a helper function and do the same operation for all variants.
>
> This also makes the handling of the interval consistent. It's only stored
> when the timer is actually armed, i.e. timer->it_value != 0. Before that it
> was stored unconditionally for posix CPU timers and conditionally for the
> other posix timers.

Shouldn't we do this similar to the gettime() and set it_interval
unconditionally?

Thanks,

	Anna-Maria


