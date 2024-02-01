Return-Path: <linux-kernel+bounces-47898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0523D84544A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DE81F24471
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE2F4DA0E;
	Thu,  1 Feb 2024 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bOdD5Fm5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQerAkrn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8724C4DA05
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780415; cv=none; b=nhN/foN6V66DBjMP392sOigJsuA92LoDqzQdMwYeONucsRc4vDluAhX9jpK3uIJ7ZJOIcYTZ1jccEEpV0BxjN2ngkvsB/MQrY9//3gji55gK/YyMIlu2PsrwYVL8a7jU2bSgx8bGWv+w/uH7NRS9GuHuVD8LL3RXCfqh1SxX7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780415; c=relaxed/simple;
	bh=Yw6CwQJLniazKUtT+U8g4/MPXo7C7LOlF0oEgz0Hd6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=joGn3dYdoWmB7o7q3FasXAOsHcjBTIR+QOxWYYfgV8HPbQFCAh6i61wEIjhY6iXTdtdNZJrutWULf1DyK+pHtDoyKXBPZs2f1wEQC9pLw+QxMIZeoHTLeb9oAIP7oJQxpnZBJWAJHYmHbYEsbe9oz9hOEKQ9dAZq0xDHo2yXGmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bOdD5Fm5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQerAkrn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706780411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9Q5jjgLj7eKlaEplPRaPpJNFTv/wD2bvjRT6tpdFWY=;
	b=bOdD5Fm52sMGMNvlYxz+G0SbuJ8CA7fxNcoLfj0XhHW56JEzbfm3ZZwM2h4vpz2eb4vbRj
	X22gG30mWHdPEVXdy+XhjqKCHsy5c+vZKngice0MF6GTqqG6vVSxGlPCxrP1VtnAxR2Pe8
	7pqgyDmcCYx5rJFncWP4UKjC6P3TkQ9exOt19hU80zBNV3eIEoBlT0B8QNaFtnFhpvKZHk
	mL2FHM9YdZ1ZiZu6gndH+l5sDCNZv6EyBUKeroLXrU0NHim4pCvR0i5oqwKF10UQ9/9rwm
	UWd6WA9SPnANYTwnSs3gB3EPtMTuqEcUFZkIm8vFCZHWvjPc/lSchpw36JTVXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706780411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9Q5jjgLj7eKlaEplPRaPpJNFTv/wD2bvjRT6tpdFWY=;
	b=vQerAkrngqmJyay481fVBltJpflVSbLF5biadgNMh/Ff9sFj/XnNsfmXhNEQFMEnEJ9or8
	QSrfr4Xkp5PP/JCQ==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peng Liu
 <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 03/15] tick: Remove useless oneshot ifdeffery
In-Reply-To: <20240131231120.12006-4-frederic@kernel.org>
References: <20240131231120.12006-1-frederic@kernel.org>
 <20240131231120.12006-4-frederic@kernel.org>
Date: Thu, 01 Feb 2024 10:40:10 +0100
Message-ID: <87ttmsikud.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Frederic Weisbecker <frederic@kernel.org> writes:

> tick-sched.c is only built when CONFIG_TICK_ONESHOT=y, which is selected
> only if CONFIG_NO_HZ_COMMON=y or CONFIG_HIGH_RES_TIMERS=y. Therefore
> the related ifdeferry in this file is needless and can be removed.
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

It's a nitpick, but shouldn't the ordering of sob and reviewed-by be the
other way round?

Thanks,

	Anna-Maria


