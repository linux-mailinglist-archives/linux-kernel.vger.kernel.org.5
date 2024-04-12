Return-Path: <linux-kernel+bounces-142156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F178A2832
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6057282CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA53B4CDEC;
	Fri, 12 Apr 2024 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iwua4qsk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6KxjlpZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1934655D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907308; cv=none; b=bHJ7GWEdXX9JIw1maOkwkUByd+UKLsYspAKTjcdcHsh7/Hzfl7eTvGKWH5mbvzgEI1YvXC+a8SGDxKon7xXk2o+0/qsKpsz5bfIM9PTVm4k4xoYT4OptIBTFeCaCfTsk4NnT+4MZ2F7KsMIcYx7m32FR9I7rpPqvSDPxfK+aDVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907308; c=relaxed/simple;
	bh=vAFNCj6DG0DEk9PQMYBFRIbBKUOyxKhrQKtD/5YzGbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pN152Od/yvqvuLS8+/YDxUXKr9gY3tjing+EliLlUQOBrtHcP0gb1FnWEh9lG/rJbNXCuOWyKwjPEx1wf50uqtqHI6YfX7469oSVfk4Cl64ZLu9I7yT9kxepXeVgVb5qyVfLW3mkflsaIaHrbM5aMKuqFl6jitvA7pZOsSqqVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iwua4qsk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D6KxjlpZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712907304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAFNCj6DG0DEk9PQMYBFRIbBKUOyxKhrQKtD/5YzGbA=;
	b=iwua4qskf8xLufn9Cjf464gt4dvPdaItj0hx1WRH7tbjgKrrUnlvUTyogt9TaKNLdkkFkI
	lrtS1G6q40+eWzifOyPmNXIvepT9GHBRjoMhs8CvzBtqAC8ViUZ9O6aJmGmDvXixDBfnWg
	MX8iHdrBK4AYGku+rsJLWaMqrmOrVyJrNOJ6LuXsW2EUCpPrG1D0wAuLurR2oKIaYME7Il
	6xfdvtgT7zuyxqiPPl9ZjXv0HlmT7lunXY8QBPlkig/oixWuC/mXuH5nGWW7mxfInK1ENl
	TZj1gZXw4gmWl/PmldBktRTejxktfrX08Wlf6tpRbCHl9zqG0tW9e70RqmiPcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712907304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAFNCj6DG0DEk9PQMYBFRIbBKUOyxKhrQKtD/5YzGbA=;
	b=D6KxjlpZQoKiXrtJTKzMwTAI5RndXwsBr+SAwZ2M8Yk2sKYlPulhxDHyXGLucCvfTQHGkR
	0K0zF55O77jol1AA==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 01/50] selftests/timers/posix_timers: Simplify error
 handling
In-Reply-To: <20240410165551.001110156@linutronix.de>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.001110156@linutronix.de>
Date: Fri, 12 Apr 2024 09:35:02 +0200
Message-ID: <87o7afjaop.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> No point in returning to main() on fatal errors. Just exit right away.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>


