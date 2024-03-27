Return-Path: <linux-kernel+bounces-121395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88A788E763
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFFE1C2EE74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3C53DABF3;
	Wed, 27 Mar 2024 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U+SNVTVB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9biMVoDr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04977130A62;
	Wed, 27 Mar 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547669; cv=none; b=kMxfesqfcEJUu9nA82trs97WJiEW2i6kQ5hDM2FvbpOYhwJ/xhk0jaB+jeWLXSrxGMzyGKtR4VG0szDDp46enG16s6IEn45t/H2kSR6UiacPHyvBkgmexpfWcukJ5rzjeudDNK1L9W6ZpoKy9KBeZEtxsTQSvcGqTMmgen2kHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547669; c=relaxed/simple;
	bh=Hbd3oWX03uwgOp8a2/PzaUpi1gu4Eu9ujvTUgEuMWWk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Lmcb4RCS9GTehHst8f8vNn/pEUl0dyyivXLhnmhD8HRw0Oz1BJJSnQHhM3Ez/0G7GdE9r3brUT1jMGrYyvuF1q5/CbjEh8huYZ4ZbUFw7LP/ys3SQ3JSMqgnf0Xm+pJzArx3mHedhOnokVQ4Xk+akckXV1ofaEk4fhVBMlXuv5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U+SNVTVB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9biMVoDr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Mar 2024 13:54:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711547666;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aX/b2fH59/QoshOtDLF5aBhUA82IfpCHJbAu6eh8aNA=;
	b=U+SNVTVB+fRhWGa5kDgbn8dLUOZD0e9FXp+YWf0nysL1emuq67X7kuYwqlWFUXAG54j1e/
	JNjCiGq92GWJ05Xyz/nyZJfZp+f76O/ZxZHQnjTRjdy14cSDcnz18MXnMPOD/eGq5qysL4
	B5FE6QrAmNcmkSV0489EgHtJeCeUs/56ucnTJ8SyStZsVk/Txxn+QWqMVasshCH+APW+rx
	igYJVEu1myjAmjWUlFoM+qeeR5MZloy0WR2uHZgBVS4lHoFHWLdPapW9eK5yOiD/T4RwLl
	NcNvi0YS5PLpjrLsIaNG9Y5sSQin9QcXPauw9m2xAekwTb0kdrf+0En2UtXTuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711547666;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aX/b2fH59/QoshOtDLF5aBhUA82IfpCHJbAu6eh8aNA=;
	b=9biMVoDrckGZfzZyN4y9kGAxlgbFb0oP7TQaIFYXPf1ZQLFXoln2tuyLpJ7Kj5r/Sy9Aep
	b3E44xIlDOLrsUBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] MAINTAINERS: Add co-maintainers for time[rs]
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325172048.548199937@linutronix.de>
References: <20240325172048.548199937@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171154766510.10875.12229558418881097070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     1fed2f1ea62aa79e8c1df79b26e5bf5c8cf45065
Gitweb:        https://git.kernel.org/tip/1fed2f1ea62aa79e8c1df79b26e5bf5c8cf45065
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 25 Mar 2024 18:23:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Mar 2024 14:48:11 +01:00

MAINTAINERS: Add co-maintainers for time[rs]

Anna-Maria and Frederic are working in this area for years. Volunteer them
into co-maintainer roles.

While at it bring the file lists up to date.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240325172048.548199937@linutronix.de
---
 MAINTAINERS | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947..c8c4a70 100644
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
@@ -9661,9 +9663,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
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
@@ -22254,13 +22266,20 @@ S:	Supported
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

