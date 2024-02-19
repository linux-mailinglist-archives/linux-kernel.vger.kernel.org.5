Return-Path: <linux-kernel+bounces-71781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FCD85AA62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335392856FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A67481B1;
	Mon, 19 Feb 2024 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bsTaV1rY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wUtETLf8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F78A46B9F;
	Mon, 19 Feb 2024 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365108; cv=none; b=B3jbMEYyaE4zutu68GkN5J5B2kHRok95xhVanYWOQAF+WhqODpiXJ9BTCHZqXOrZvIWdulfSIe9yNCcRPt2mIxNSEq6AafTUqQzxCFJRNyehxHV7nt3BNjm5hJc84yH5cUWHc0H/UbusWH6g7LTR4wIhMpr99JuUP8S6V2zrXsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365108; c=relaxed/simple;
	bh=dYphAmOqh6s/jX7EW/gPNGu1P1vMlwDQLwtH2msUveg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rd83zSbUz0/tOvqH695RwYffMdh0j+nflcsE9qFYPvachimH6pLPOxLVc0U0gX8h5FIYvhzOZotX4RiTa8leRNhCkK3rXk2ZgbSw3PAXhvs1OGNXNW4GapOPK7hPjx4Hk74EwqYBQZURozQY/KtQD6jHBqO1TRlSK+7wJ0SKl7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bsTaV1rY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wUtETLf8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708365104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dYphAmOqh6s/jX7EW/gPNGu1P1vMlwDQLwtH2msUveg=;
	b=bsTaV1rYmYdP2h1KXHL2ba9PLm3Efm+FXmThu0i+m6SYG2f1khI/odAmR3xWkaq6LGmiXG
	h6lkXnG0NKO3BISN6uPVJNq9PNsuGDTDU6ctF1Xy8gbpNuGkZDvg0APWwrFJqTFq/vVE5L
	nDYfIhmE0k7BxElDbnT48ixtbDVeMfwTgwdJdaCV9Jp+We1v1TKhkGZ09TdHZkMHFvrAJn
	n/1mk0LbUGa3XWFMs+24P8IkgiA1d8ipuu0Mh107INSbHw2eao9xt235rol2AWLujnQ3r/
	jMNpe96dZP4C2+8qA3HK3qfIiA40Eopd8ZhRQGAhYC7Va7k5PCKhjCH4nC553Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708365104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dYphAmOqh6s/jX7EW/gPNGu1P1vMlwDQLwtH2msUveg=;
	b=wUtETLf82/pvASroqcT1N9/D1spRI2R8TU02pFm73ty8dVg1dHSolYq1Lenu4KDWXlENWX
	UUXZsgI1GWVijMBg==
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Clark Williams <williams@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Derek Barbosa <debarbos@redhat.com>, Bruno
 Goncalves <bgoncalv@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: Automating console_blast.sh
In-Reply-To: <ZdOQ2KzOIgYc8Ber@thinkpad2021>
References: <ZdOQ2KzOIgYc8Ber@thinkpad2021>
Date: Mon, 19 Feb 2024 18:57:23 +0106
Message-ID: <87frxo2vhg.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-19, "John B. Wyatt IV" <jwyatt@redhat.com> wrote:
> I am investigating if we can automate, and, possibly add
> console_blash.sh [1] to our test suite here at Red Hat.

It is called "console_blast.sh". ;-)

> At Red Hat we use SSH to manage our test boxes. On an off-list email
> you wrote that 'Only the UART should be used as a console'. I took
> this as no ssh session should be used from the boot up until the
> crash, but I should have confirmed this. Is this correct?

SSH is fine. SSH sessions are not consoles. Consoles are specified with
the console= or netconsole= boot argument and receive the kernel
messages automatically from the kernel.

> The license for our test suite is GPL v3 [2]. May we have your
> permission to license it under that or permissive?

Yes, GPL v3 is OK.

> [1] https://lore.kernel.org/linux-rt-users/ZcQjxa4UA6hzXHnU@thinkpad2021/
>
> [2] https://gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/tree/main/rt-tests

John

