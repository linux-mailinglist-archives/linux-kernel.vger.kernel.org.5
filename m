Return-Path: <linux-kernel+bounces-105955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86F687E6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E891C219A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C7A3C08A;
	Mon, 18 Mar 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hXvFlar1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TlNB/yYI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684038397;
	Mon, 18 Mar 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756466; cv=none; b=Y7NFgQfFQ7hbeYxnlWLYMryoVN+fefDwqV6mpGgpTQex/9Ve2jsaeKYdfwdlgakxHY+hmI9YHk8KyWp6ZLWSYvADhDH0moPRQK35RDdE0vAfceDi0r1tmJvFROj3COgR3MToNcLRPLIxWtn0/5Bm4Ej8ikih0caEX4VniicsMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756466; c=relaxed/simple;
	bh=bDCXRRpXizr7tVzD89qvxRJSBrcYdjZ8F3MGSSIMlsA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g6pg0goKxF9IAiu8vf9m0vFJD3X57xXPceZLqfsJb4BfjL9We+k6LHkthHrGG6mdkdqyxYxZ3oJmahA3+EddXi6VUfv4KQWZKqJmyFyx5l1zsXHRMlzegYlCsue1U6QQcN963i52TyqTQx0Y05+y+qJmNvDjsN/fbLGYjkH4e0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hXvFlar1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TlNB/yYI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756463;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x70euLGdOsG9AXw3u0Y6oV8Njx+rPnSAjBuT6ei2pm8=;
	b=hXvFlar1Jlx0AMsG/odLglWOJGSANSvVx7zRBcHHcouxa2K2o1ctTOeqbaWshK5R9cbxKl
	hW2O0c9XDGtL1J1RNESybRbmX5UNdvE+gBe5XY8d9tL2xHv/t15fmxfoivMWnnwISs99rQ
	QwhWbXrSeQQrgBT2xDIoSYkVB9dZ0YWaJwwIvVLKEIUiA1IoFVM5c9UO2BvKlktp6eCM5N
	SVZe1oWHER87NHiZ6BCvCZFT3CRgd94CMH40828FM9AphxGrVGPFVG6uvy5lRClQDLQUfw
	OK4orwINHxBf72MkEsKrp70h1gdYkgn5s6fuHcQyuangw+9GXhYt6cn/mrYicw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756463;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x70euLGdOsG9AXw3u0Y6oV8Njx+rPnSAjBuT6ei2pm8=;
	b=TlNB/yYIcMqQzzGdn/r4nB/if/ULzBYJiPrUTtupCT0QfClHwqVUNZ5ZVcE7yqoQXdr58b
	l1QT5w1mUiNVtKBg==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clocksource/drivers/ti-32K: Fix misuse of "/**" comment
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240120173624.16769-1-rdunlap@infradead.org>
References: <20240120173624.16769-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075646273.12214.15781960391067649018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     702107ed5d89e50499aa1d65fe499a028073b25e
Gitweb:        https://git.kernel.org/tip/702107ed5d89e50499aa1d65fe499a028073b25e
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sat, 20 Jan 2024 09:36:24 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 22 Jan 2024 13:16:32 +01:00

clocksource/drivers/ti-32K: Fix misuse of "/**" comment

Change "/**" to a common "/*" comment in a non-kernel-doc comment to
avoid a kernel-doc warning:

timer-ti-32k.c:42: warning: expecting prototype for timer(). Prototype was for OMAP2_32KSYNCNT_REV_OFF() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240120173624.16769-1-rdunlap@infradead.org
---
 drivers/clocksource/timer-ti-32k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 59b0be4..a86529a 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * timer-ti-32k.c - OMAP2 32k Timer Support
  *
  * Copyright (C) 2009 Nokia Corporation

