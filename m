Return-Path: <linux-kernel+bounces-111968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F8D887371
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F642284CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F53D7603C;
	Fri, 22 Mar 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MGeeBfB7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HoBKkMlj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078147603E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133798; cv=none; b=YohNEdqvwxSNz+0Ng15fa0S+tqhHpNa6AWu9CRR94SUyAWLHUWDPwiWjF1WLcMJfWvFcki55HBHMsGT9JExztThZE84k+MJ/NagOeD/+tOiresUDZmoAJg7HCVp5sXR8caFm3VupKdHUY6vZqfnou/2n7WzOzn/Zjej10h4+oog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133798; c=relaxed/simple;
	bh=L6JelVHvG2IqQvcLh08kyCpVpbp02m6DvQr4OiXJJQI=;
	h=Message-ID:From:To:Cc:Subject:Date; b=t+/fDarEUpibwuzcPUEGtGjUgoE3m8fFyGAAtmiX2+ULCaIV79Nau0nR68eUZgw5359UrnPZEIA32kRzYT0KPftryGCSqXIsturCgxxla9Vr9C9ZLPJou1+pWxFTn23FgYd6fOTEWBziaLp+6JRAs6dY9OabBqvcI/uuNfvGxs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MGeeBfB7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HoBKkMlj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240322184944.141421692@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711133795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=OTy3h54e1kGT4Ez3ZfvdwcV/kPM9OYqTCCZrrVK+Uko=;
	b=MGeeBfB7uSymtvWV3JxhHu9DhkxDHdsrgSBr/3nXTe1oyUTaGaOUbLEXAmmyyGPCY249JF
	G1ubxrJrq9UisD1maeYpt3i3sm8fQMc1AtqZvPahQ3SMDoeoP1vs5sn08mWtnzoPISHnKC
	l1B2Aqjaq5278wrvX6pkbgXMTTQbTnVr44NcLP7VI2xsi6YmjmVXrG8NoCKfAyDQ6/uPKU
	O5Y9oM9h2xvX2DMp977xsG/7u83wRHVHHBHQMslSjT8D9cOrrDuySapcHkswANYc0aUGjW
	AkhJeoFiV9Oz4Uq8eqWoJZVT7l+cPxpxGFHiYU/ncovYBrApw9iItvOeY7YonA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711133795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=OTy3h54e1kGT4Ez3ZfvdwcV/kPM9OYqTCCZrrVK+Uko=;
	b=HoBKkMlj/cLz3W+1kZCJ1bWAFqVMqqp5AR7vw1c3yS6XeVBxI57VheoyYnWz5cr143Q8+8
	lD6oFU+QOlESi+BA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 0/4] x86/topology: Cure fallout
Date: Fri, 22 Mar 2024 19:56:34 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Guenter reported a crash on UP which was caused by the per CPU rework and
this unearthed a few other issues in the new topology evaluation code:

  https://lore.kernel.org/all/e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net/

The following series addresses it. It is based on Linus tree and also
available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/core

Thanks,

	tglx
---
 arch/x86/kernel/cpu/common.c          |    9 +++++++++
 arch/x86/kernel/cpu/topology.c        |   11 +++++++++++
 arch/x86/kernel/cpu/topology_common.c |   12 +++++++-----
 arch/x86/kernel/mpparse.c             |   10 +++++-----
 arch/x86/kernel/setup.c               |   10 ----------
 arch/x86/kernel/smpboot.c             |   32 +++++---------------------------
 6 files changed, 37 insertions(+), 47 deletions(-)

