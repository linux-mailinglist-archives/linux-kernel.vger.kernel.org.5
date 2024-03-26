Return-Path: <linux-kernel+bounces-119100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD4E88C42C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9075B23683
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238F5762F7;
	Tue, 26 Mar 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fJR/E4g7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QkPPSOqz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C67602D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461397; cv=none; b=Q/H4Fi5fz0J/YUZrVnj3V+2DhWAiyRIKFPxj+jrLGlqZcsPSXoL1SxBKV1/BmNIUz/Kl5ksu6PDWQzqxo2xGhavXQJgh/z2iPRbttpt4Ow91qZiZGATEAPjphlHcNugrRJsBW1mdChchiw7PneZEmxYFczTgWM4gM0/X0NL5Wro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461397; c=relaxed/simple;
	bh=nxQFAB1Tb5hVwu9qk7YsFavhCTXPLgENlIfm4MVLRZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f6oYrPL8gITQRW2OfuxuRlB7gMjdoqe45y2uXTFTAdIbdN2hrG6AxUDnNN6ohEjI6LwdGAmuubrGtsMWG4MEOrMDiMW0Mu/6sqYgxy9Hc4iMfEwMYM2SXwOdcKdrgnwMzmu6ebVpa3Qi3x8DuU+ZU4AF0FCbUQo/mDWEGVm7H7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fJR/E4g7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QkPPSOqz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711461394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w9sxAoNwjLa7ZuS8N1Wq8b3qnMTcZlZr1kvXbtFsTqc=;
	b=fJR/E4g759XVdYJEa54Mevc9uuM88nSKytFGSKgo4XAPjZy3nzWqWHPXKQSGiZ4LQ7U0Rk
	bCsujEz2FSvAqBxCr+I9dUTGFK7qaVZWtwB0nUVKl60NStxYCQRGxX0LsIOoBMFEJQI8Yg
	bTPYz6fwuoD9JmllnVZ7wVAArduoGMcdKW4vJLgb4US0vvsx40T26JsT/aoJeix71ZUxlb
	d2+ukO2FSwCNp4E7msFVzwQkes4NLPrcQvjYeCtEpTMKuQu372E/gPjZm8BIIRnFeyHlwN
	ILDXcLj/5vHWSencVp4uRcvXN5dMR3FF4OebtbLtYzWLnZWf6ko8wPte0n3biQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711461394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w9sxAoNwjLa7ZuS8N1Wq8b3qnMTcZlZr1kvXbtFsTqc=;
	b=QkPPSOqzYC0gPGN2VTGmjDHzf1mNoUBt05sDF2w2qz3e7sV/VQmyMP79E711Q7LEtfqB4f
	O4q3P6mDJhPCeiBg==
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux kernel
 regressions list <regressions@lists.linux.dev>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [regression] Bug 218641 - Framework Laptop 13 AMD
 suspend/wakeup regression with 6.9rc1
In-Reply-To: <5b778e74-1278-42b1-84e1-a2c04a8211f0@leemhuis.info>
References: <5b778e74-1278-42b1-84e1-a2c04a8211f0@leemhuis.info>
Date: Tue, 26 Mar 2024 14:56:33 +0100
Message-ID: <877chpt7u6.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

"Linux regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:

> Hi, Thorsten here, the Linux kernel's regression tracker.
>
> Anna-Maria, I noticed a regression report in bugzilla.kernel.org that
> apparently is caused by a change of yours. As many (most?) kernel
> developers don't keep an eye on it, I decided to forward it by mail.

Thanks a lot! I already saw this bug report in the morning and will have
a look at it.

> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> not CC them in mails like this.

I will do this :)

Thanks,

	Anna-Maria


