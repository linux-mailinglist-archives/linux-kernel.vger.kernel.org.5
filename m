Return-Path: <linux-kernel+bounces-163817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600238B7211
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF0C284DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA68A12D1E8;
	Tue, 30 Apr 2024 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+xCdbZz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SEwnfAh3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65DD12C801;
	Tue, 30 Apr 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475032; cv=none; b=aCzouv0dkQL/88QE3XnI3igvj8G/tn6o5HE7zQNsXbcA0Mc4tEzbuRwcHO+ikJq+8j7mtiZDXMvDdku9zr94cpeVA0msLGy+Svo6RoFEdORPqKL+eqQ4ftoSc8EKArYF+LYvYRXFtfwUEeB0mlWLIW+Jjos/AH66khbPjie+OIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475032; c=relaxed/simple;
	bh=DqHdpi1aL/50FmrfmlZosNAnr4l+wD0VFnhwqqeynaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SqX/UIri2LjoQM9gY5N15uFpbU1jkow/XtFoW7wrHZEOXGzmghrPER4Z9pkNG9ydqeOGYdq+FIapZwLW03sElPv19ZCbyV960ZdOxNYJCx+RxVLF3dlh4PmE21gIaD0csvCbuiFcsb6ySD5JAXYD8kSjiRlWQa4ypSalKiyUGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J+xCdbZz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SEwnfAh3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 13:03:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714475028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=IB0/69YgucCahmdfwDBYOWTe42KL67RfXfDYWFAOOTk=;
	b=J+xCdbZz8YM0JOnCu37dSgIMXXPxO7LoEtfdCTI5nYm2AnWHpTWutSciM4mffqQH6J6odZ
	/+PXUy1aktPEy0HSNcxjmrP/9BK+dNvqokM4BhqR/YtlIRuz6hkwKQl/PZp8/acNhYHEOY
	TA0RI+iXIkQ6i8w7CYeV26RI2qEZcaBMzcuhgVlzl6C1LgMi8vzJo2isThRNgbXAd3w/VH
	xResD7DzlhcC+cdctKs63xhlyr055fYyguW8O9wg14ZF6Ygnqn04XKft4BsJsXkilI6VS+
	fMZisMCj4BrYa2y1iQRJo1Dc8sO4g+OYJdeRokqCWie8Yi9GUxqJ3dYlNoNftQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714475028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=IB0/69YgucCahmdfwDBYOWTe42KL67RfXfDYWFAOOTk=;
	b=SEwnfAh3woJsgt7atj1PLFMNKy/I71kEewwQhdB7aeM+d++PGWUu3zFGeRVVqI9nER1OVJ
	YBJr2E8ZLKEsbXCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.9-rc6-rt3
Message-ID: <20240430110347.LCK9LAJr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.9-rc6-rt3 patch set. 

Changes since v6.9-rc6-rt2:

  - The tracepoints in i915 were enabled after some of them were moved
    into a different header file. This has been noticed while posting
    the series for review and now the tracepoints are disabled again.
    The problem is that some of them acquire sleeping locks within the
    tracepoint which is invoked with disabled preemption.

  - The selftest with the cxgb4 networking driver raised a warnings.
    Reported by John B. Wyatt IV.

Known issues
    None.

The delta patch against v6.9-rc6-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.9/incr/patch-6.9-rc6-rt2-rt3.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.9-rc6-rt3

The RT patch against v6.9-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.9/older/patch-6.9-rc6-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.9/older/patches-6.9-rc6-rt3.tar.xz

Sebastian

