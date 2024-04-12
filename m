Return-Path: <linux-kernel+bounces-142158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5935F8A283E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1FB1F21C73
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A1A4CE13;
	Fri, 12 Apr 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TZzWMGMA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tg0wswcT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BE44BAA6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907341; cv=none; b=HHVHd6up440eieRGQ6JfpYaGEx5npSrjH6df9bFzz19VAy17rRxpvPW6A/FQla59Q2nRWx7uHyQDqspVlnDIY4lfInOQzpB2Y2b1GxvqZtAa4WLXfJeJsUJZ6IJ+ZCy8jHkWXtKIXMypsbDZTMKCzUzK8BWT8/v+PWiWQb+IfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907341; c=relaxed/simple;
	bh=I8UCgoIuHmSMIqhNFagbezt4NPkAYdb6VNpDEThhRhE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HAXN6YhzeqIzCnv1yZ+MEAOmXLHpx4C+oH3UHgrPu3bz4lpiTin9w4lLssNzTUUVfFSI6G0nhTjekSglLsa19Hd1zJFmbWjpQ8Qqhmez6kbEyNIBfUP1Zf4oZYUZlbTDWC1UNaojGjJNxa3KojxN1G36/1Yj/uhRQISZHnKAjuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TZzWMGMA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tg0wswcT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712907338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8UCgoIuHmSMIqhNFagbezt4NPkAYdb6VNpDEThhRhE=;
	b=TZzWMGMAZ9xLJ7JaxrGMgz6JDNymNNMGlGlLuWY4jmaPDyLzuc2gThgX54CVbwa/M0iC4/
	UMTEp2rwSNJBF/GcPZcOMjYRTWs/K27tg6I5GX7jygL12qII8ZKZq/zqInbXs/hKlJqH+E
	AvMNQuQvhrO8FBKHJ5COaLWAIjgVX6gUhhUgci/3xMn9uxBNY+LKmj/6ptFbS9Gbj3nQSa
	l9oOQKGT+DKnsYCZNdF5rOmk0nlPGuUjvHwmfrbGT1RhVT9U5DX7RPoCXDMtAh6dNmlE/v
	7ts5LAle8/MZP0Q2Lz90svALJkbkgzNW7R61G1e0pOA1uBccadguHq0tbmpeFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712907338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8UCgoIuHmSMIqhNFagbezt4NPkAYdb6VNpDEThhRhE=;
	b=tg0wswcT5chAfcSSnrY5y09O1zUmfhssKm8AE1ROt8El11d2eDC/lSfXqj5V3J9oHFfCiw
	ebakoYvOrUWGOWBw==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 07/50] posix-cpu-timers: Split up posix_cpu_timer_get()
In-Reply-To: <20240410165551.376994018@linutronix.de>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.376994018@linutronix.de>
Date: Fri, 12 Apr 2024 09:35:37 +0200
Message-ID: <87le5jjanq.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> In preparation for addressing issues in the timer_get() and timer_set()
> functions of posix CPU timers.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

