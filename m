Return-Path: <linux-kernel+bounces-105948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5627D87E6C5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27461F2297C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BB0376E1;
	Mon, 18 Mar 2024 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qu0JJ3Dx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I8i8V/h9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C438D328DB;
	Mon, 18 Mar 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756462; cv=none; b=DVJApK5c7ZpM2lm4H1eWbFfteWDeS5aHmfDOyXayHs6Bo9dvsS6duaZFNKP0w9MMNwJw03H1l62dv3fcAel3OdFvf+Bx97DiMgtsme1aScInlbQ4314vW7G4U+ouPCqaV9VETC1KzUFrVtRUqHmHPtecOIfqBw6d5K7GrgqfYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756462; c=relaxed/simple;
	bh=ZORe+M54VBTISmp8QXGhsVBVyxOdFnI4pyTk3aqviVk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Nh+3feDeYWb2pyjRRKzuPfhSC8GJXm/PqMm6M7rgVSTiIVXudkhkq6ZlTEQCLqNAelt63mIHYwLx0RONZvQeJ+umjDEZxfP8TaCiA1w8GTzDrdDGGgxOeG3adfeZ/jusUt72EwIvEvbhJNKgkjj3e86OGvG1IhZ+1gdMvmq0lKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qu0JJ3Dx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I8i8V/h9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CC7+PfqlKfaDakptWbGV4aGiRRlihW47M/22hbQ0PM=;
	b=Qu0JJ3DxJlJaMQkhfmsWIHvxKsFlLj+dJdKmhrFcCON+RYdyDVoklquSFtmFfo1fAWo6zC
	VTciMEkP4ozgKkG+BNQ+BavNRlLDzeSWeKkVzUlmLSEAJrdu6MmIvw6aFdYUgpVsaJ5pV2
	M/uW41pHb/ZvKBiWsWp37qdiYt7ITcxIWqU/jgXtB5GGN/6k6IOEuJDCl6oYUrz7joUA+f
	Bb3lDMNNXvRs7cYtlJqKQxrN3t0Mygd5lRfNzbbguzyDRIIZDNR6+WPDi8qQzmKYWGY2ST
	DXi+HsN+94oNfVk/BLayOWEUzGZdTc8Kzk1QBFUzhQYPuIKGKddbHVWCCVhiCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CC7+PfqlKfaDakptWbGV4aGiRRlihW47M/22hbQ0PM=;
	b=I8i8V/h9uWB14GbIQdM1FbugNcMzdloJN6J1diowdHXgkwoeBWMAUJnEfhqjbogk3rBeaw
	7O+UMqW9pSVd4jAg==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clocksource: arm_global_timer: fix non-kernel-doc comment
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-arm-kernel@lists.infradead.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240115053641.29129-1-rdunlap@infradead.org>
References: <20240115053641.29129-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075645726.12214.10815054239263839051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     97454a65d56b240013ed8d396427b85e34384238
Gitweb:        https://git.kernel.org/tip/97454a65d56b240013ed8d396427b85e34384238
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 14 Jan 2024 21:36:41 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 21 Feb 2024 09:56:06 +01:00

clocksource: arm_global_timer: fix non-kernel-doc comment

Use a common C comment "/*" instead of a kernel-doc marker "/**"
to prevent kernel-doc warnings:

arm_global_timer.c:92: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * To ensure that updates to comparator value register do not set the
arm_global_timer.c:92: warning: missing initial short description on line:
 * To ensure that updates to comparator value register do not set the

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240115053641.29129-1-rdunlap@infradead.org
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 8dd1e46..d749dee 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -88,7 +88,7 @@ static u64 gt_counter_read(void)
 	return _gt_counter_read();
 }
 
-/**
+/*
  * To ensure that updates to comparator value register do not set the
  * Interrupt Status Register proceed as follows:
  * 1. Clear the Comp Enable bit in the Timer Control Register.

