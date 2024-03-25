Return-Path: <linux-kernel+bounces-117585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882CA88B218
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E7AC2446F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9D7679E5;
	Mon, 25 Mar 2024 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q3ZMblpm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WIxZA1MC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2116CDC1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387401; cv=none; b=R8XLrmVrEwhwg/pB2Dhp+GW1zAv9btvmeOsgEq6DSywV9LvCU9ExRlOlVFMNw2TYqgkeTA4jxKBNbFw9gLmDyBFmgM1Qvsw9zyimLdr9pQtwPJxraxKSmM5oD7yvF65/KuAYTTsOMXT2Vyq46+tMKHoNYaQY0QS2pjOVvwjOlTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387401; c=relaxed/simple;
	bh=DxVhH848FmR2TSa91xhlWwh+14W5DPhDbCXuE/y8z8E=;
	h=Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type:Date; b=AwF17MvjVvRNyH9Ji1Z9v4gySL9U/oyiglub1xuqtINfvY48VPurgVkukgkc9oglRai3os/WXon4zYiDv+umzhQK8AN2dm7PhtbciBngGIWEUQ6Yjtcx+W3HIUlFGIIKyZqBeVhnkv1mTVAtdEkYfaHGYWgZoFTJkem08hT9FSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q3ZMblpm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WIxZA1MC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240325172048.548199937@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711387398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=khJqvECZCsi8ilTDOqh8jVnha+7AH+jfFZfLReHQck8=;
	b=Q3ZMblpmLnGorufIZqKPf0/QTem7G8jyHBTaLUkSc11QMifM/BJndOeJcx04dWhmzDEA/o
	VmphSHFkI2fL83k8Cxt0oqMbdWHotbEgv+JLiHSsQr+5NWMwqtKjxAOhaMkhtah5ckq7yB
	ft6ikx2dNxI84b1wDtbrTA7CNbI+9XAWgOER3JMP0D1xVFjBpGRST6HRWXS1lrwLQqijmc
	TZSuenP5PqTrnUbtuqIHACdVvC8mZehWZEM4d5DO3A54y4YA711+c9/HTZCnHvqGI7Mt7l
	3Sg+7NOzzepQjRRatiyrATTgvm6dFex7Yg+RrSCXMC8/1L+EUSi9/QyOSClTpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711387398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=khJqvECZCsi8ilTDOqh8jVnha+7AH+jfFZfLReHQck8=;
	b=WIxZA1MC4OYzSlXy5xk49lUw+04SAmW+M7uH7X024CLvMj4ZSECW+gidisUfW+FSz5nnVC
	fkQrcYMfSjpmE5DA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 John Stultz <jstultz@google.com>
Subject: [patch 1/1] MAINTAINERS: Add co-maintainers for time[rs]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Mar 2024 18:23:17 +0100 (CET)

Anna-Maria and Frederic are working in this area for years. Volunteer them
into co-maintainer roles.

While at it bring the file lists up to date.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 MAINTAINERS |   35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9653,7 +9653,9 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-logitech-hidpp.c
 
-HIGH-RESOLUTION TIMERS, CLOCKEVENTS
+HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS
+M:	Anna-Maria Behnsen <anna-maria@linutronix.de>
+M:	Frederic Weisbecker <frederic@kernel.org>
 M:	Thomas Gleixner <tglx@linutronix.de>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
@@ -9661,9 +9663,13 @@ T:	git git://git.kernel.org/pub/scm/linu
 F:	Documentation/timers/
 F:	include/linux/clockchips.h
 F:	include/linux/hrtimer.h
+F:	include/linux/timer.h
 F:	kernel/time/clockevents.c
 F:	kernel/time/hrtimer.c
-F:	kernel/time/timer_*.c
+F:	kernel/time/timer.c
+F:	kernel/time/timer_list.c
+F:	kernel/time/timer_migration.*
+F:	tools/testing/selftests/timers/
 
 HIGH-SPEED SCC DRIVER FOR AX.25
 L:	linux-hams@vger.kernel.org
@@ -15627,9 +15633,10 @@ F:	drivers/misc/nsm.c
 F:	include/uapi/linux/nsm.h
 
 NOHZ, DYNTICKS SUPPORT
+M:	Anna-Maria Behnsen <anna-maria@linutronix.de>
 M:	Frederic Weisbecker <frederic@kernel.org>
-M:	Thomas Gleixner <tglx@linutronix.de>
 M:	Ingo Molnar <mingo@kernel.org>
+M:	Thomas Gleixner <tglx@linutronix.de>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/nohz
@@ -17590,15 +17597,20 @@ F:	drivers/pnp/
 F:	include/linux/pnp.h
 
 POSIX CLOCKS and TIMERS
+M:	Anna-Maria Behnsen <anna-maria@linutronix.de>
+M:	Frederic Weisbecker <frederic@kernel.org>
 M:	Thomas Gleixner <tglx@linutronix.de>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 F:	fs/timerfd.c
 F:	include/linux/time_namespace.h
-F:	include/linux/timer*
+F:	include/linux/timerfd.h
+F:	include/uapi/linux/time.h
+F:	include/uapi/linux/timerfd.h
 F:	include/trace/events/timer*
-F:	kernel/time/*timer*
+F:	kernel/time/itimer.c
+F:	kernel/time/posix-*
 F:	kernel/time/namespace.c
 
 POWER MANAGEMENT CORE
@@ -22268,13 +22280,20 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 F:	include/linux/clocksource.h
 F:	include/linux/time.h
+F:	include/linux/timekeeper_internal.h
+F:	include/linux/timekeeping.h
 F:	include/linux/timex.h
 F:	include/uapi/linux/time.h
 F:	include/uapi/linux/timex.h
 F:	kernel/time/alarmtimer.c
-F:	kernel/time/clocksource.c
-F:	kernel/time/ntp.c
-F:	kernel/time/time*.c
+F:	kernel/time/clocksource*
+F:	kernel/time/ntp*
+F:	kernel/time/time.c
+F:	kernel/time/timeconst.bc
+F:	kernel/time/timeconv.c
+F:	kernel/time/timecounter.c
+F:	kernel/time/timekeeping*
+F:	kernel/time/time_test.c
 F:	tools/testing/selftests/timers/
 
 TIPC NETWORK LAYER


