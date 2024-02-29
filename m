Return-Path: <linux-kernel+bounces-86829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B24786CB63
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10022B252F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1AD1350E4;
	Thu, 29 Feb 2024 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CdQgvwcL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AhQycSGj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408117D091
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216622; cv=none; b=PhUQKtJtcNHNSLI1Ph1kQ+evTEoXE0InDyupgZuCg8B+QhkWCFoazr+sl0aSQvz0xXEONV+lNoaEFRoxhiP14SL9dDUzYD+BB10EcssRtT8jjsRsnjLuaxizY8DtRwU+qAg3iAF6SQ9t/lwCceuAgU1EOAlEWcxPFAcrLYP6M4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216622; c=relaxed/simple;
	bh=9YxB+yDw77PtyqZXKGijQ4xOSfluWqcXRfMJfBlF3oU=;
	h=Message-ID:From:To:Cc:Subject:Date; b=ig4Pc6elt1lHqE4DNo3TB52KuZcDHxhm8OVKCIHhPxFugoFnto8c4Mzql5i+k9/OxCDGwTmI1aLyXqOgp6fw1PuHf5AToESbYxBbT6d+ikcWlu83MWW29eRV45iqjUfM9/EgfMe6S/JMXPQSCFVqoA6ab/BhUQvvM8uQrmA4ezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CdQgvwcL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AhQycSGj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240229141407.283316443@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709216615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=YmE0uxXodHKBHzS272mmIFqP1XyyLlUoXMVZdCkWWBE=;
	b=CdQgvwcLvUOf7I7P/QJAFmhRhrN/GrnJiF6bo7TmW1AeQydDSRGeJh5ymd/3TwWNYOH0vC
	AklpITWn7D9I0Az/wqObRFWhh5MKWs8ryta4d177nZvJXGTcYhQSumWWGlWLyshffK8FVT
	Ki0VWGiC2EKS5KLD72SrFmOqkU4t1d5X8R/jDCc2RQogS9l0HfwppCJMMdqvlYNL42mZfD
	uyzlTakTyj2f7K/ZQEycf5tTjjJEstLe+vCCHfF3k+TpAxi0FlSn+KODH6lmzAlh9/A8wr
	MvznxtN0ww8EdtR+onlJmaSUmoPyd0xf3ZMu7Pbld4xR4Tt854Q/Ir7e5SD0Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709216615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=YmE0uxXodHKBHzS272mmIFqP1XyyLlUoXMVZdCkWWBE=;
	b=AhQycSGjdyuPlwZFb6D7y/qhoQ4zGWkCLoR9a+yRfnza0GO4GRl9G/cqekLWEqKw3Hs4m+
	FKLT92Ai5G1+84DA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 0/6] x86/idle: Cure RCU violations and cleanups
Date: Thu, 29 Feb 2024 15:23:35 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Boris reported that a RCU related warning triggers in the tracer code on
AMD machines which are affected by Erratum 400. On those CPUs the local
APIC timer stops in the C1E halt state. This is handled by a special idle
function which invokes tick_broadcast_enter()/exit() around HALT.  These
functions can end up in lockdep or tracing which use RCU protected data,
but the core code already set RCU to idle which means that the RCU
protection is not longer given.

This series fixes this by handling the tick broadcast conditionally in the
core idle function. While working on it I noticed a few bogosities in the
related code and cleaned that up on top.

The series is also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/core

Thanks,

	tglx
---
 arch/x86/Kconfig                 |    1 
 arch/x86/include/asm/processor.h |    2 
 arch/x86/kernel/cpu/common.c     |    4 -
 arch/x86/kernel/process.c        |   89 +++++++++++----------------------------
 include/linux/cpu.h              |    2 
 include/linux/tick.h             |    3 +
 kernel/sched/idle.c              |   21 +++++++++
 kernel/time/Kconfig              |    5 ++
 8 files changed, 62 insertions(+), 65 deletions(-)

