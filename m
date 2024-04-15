Return-Path: <linux-kernel+bounces-145316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18918A529A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D242816F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38DE74433;
	Mon, 15 Apr 2024 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SpL3xDJB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YUp/794V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1203674409
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189817; cv=none; b=pgiQbQeG3fIkiOmIkd+FvlYQlzvwYDIWhZD2HlxxENMoU4t4xhgpJwGqlo/50d2fLJOmQERhpLe+8jNzFObAwWHMYa3tLRsrQFU/GKrABn7Dz2InRRsY/vWgyR1b7u8AMzNfGFJtbp/a9KWGArzxlMe8owkCkQMv5uK7bv/7mBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189817; c=relaxed/simple;
	bh=g0ktuNB51+uEoJJgeEEGfhAOyIfoyJZY+S70MJdNHgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZNTxEE8jaJRcWRWCdGdNG8om0+BS4zHnqfqWVyiNxpjnBUFuW9W9hpm1nCvobblsAX+CL7cL9gTS78xTxAV+3+RBxzHS9VFrcPMGeZfUsLBy6F6zhvh0wycazeQesCZhRZgAzDCVg4YQOAjoOCVkQaBEp9eeiJzgOC8h8+u7SMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SpL3xDJB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YUp/794V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713189813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0ktuNB51+uEoJJgeEEGfhAOyIfoyJZY+S70MJdNHgA=;
	b=SpL3xDJBsu/9Z2W+M++/WKg2/tYf5v8JyUbQUMS0ErDnhLUfuHWnLOA0ujB/s+9uKR6cVv
	OzY8JXgi5FppSLYiZjGuq2Qe1/bb5/kyjNrtVO7aQftTQVKAwx9bk1TXNHsZF3nTk2oNe1
	v5zLlap+W3leHwcjK2UX8QFaOBaupWUNxK/0eNZ2RU6goZRrhgW2Onu5GAog34A4Kouc5K
	m4S4DrqFgio1GRJlVZ58Y7g/4LkIu4oY6Gz76ukJ3XO7a3optSUG/DO9nmBHdRqYYmY6J/
	RM3OeT/sPBXNe3GYDdTP/P9vMwpOXeIreKGJSOphNNPB6P4MDJK2jH+bR4yVIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713189813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0ktuNB51+uEoJJgeEEGfhAOyIfoyJZY+S70MJdNHgA=;
	b=YUp/794VwvIJvToEUGxZZd5ucgdFr3gCbJjsLOBLP4hhYD1X07gbOxRiJniVFgHSwoZIgd
	uRUa2q1mRVJxBoBg==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 13/50] posix-cpu-timers: Do not arm SIGEV_NONE timers
In-Reply-To: <20240410165551.757677561@linutronix.de>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.757677561@linutronix.de>
Date: Mon, 15 Apr 2024 16:03:33 +0200
Message-ID: <87wmoy7mfe.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> There is no point in arming SIGEV_NONE timers as they never deliver a
> signal. timer_gettime() is handling the expiry time correctly and that's
> all SIGEV_NONE timers care about.
>
> Prevent arming them and remove the expiry handler code which just disarms
> them.
>

Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

