Return-Path: <linux-kernel+bounces-60665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6029E850833
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6CD283C96
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ECD5A781;
	Sun, 11 Feb 2024 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YSCLRXM4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqovQHQL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D5B59165;
	Sun, 11 Feb 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640895; cv=none; b=AGruyHgyNiW4JsX5C2BEb3CEIQ43cV59EPmUTyG5fEWDRJfQijxVW3ysPQF4xwZ+NFd3csK47RcoB48UgRP3L4zE7JZ/H0pADURJrcRKJmFi3El8H9tvQ72nvSqRTnwSG/h0CHJvxHzVz4iADuVxlxsIGeKGovMYCWUkdjx9HDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640895; c=relaxed/simple;
	bh=vkuQK2ZayrSuKQpNVzf/K60Vr4vkAluE2M1vZxSIxEw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fPDavXb7UaphaOE4GZ1fDTejtwG//eLnHdjDssasm6LvgA7SI9XNtzGLOA1Q73g2v0pfdhMLUI/ekS+F1w7wcE+yZ2ZnJOZzdm+5p+Q+7AkaSJXuEIJxmKY/3GpO+W6jVQxPxD8HLMG8XX+Fn01IQcLe1BoGS/Lel5Oa9H0viFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YSCLRXM4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqovQHQL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 11 Feb 2024 08:41:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707640892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saO3EDBD2W+LzkwxfyBQxJVlHOrm2xKpIUw0203BTt0=;
	b=YSCLRXM4AMy//713+PYqaEFoMeVwEhK4kdR05H3/Gc61dGJyqgKL19k38NCTcQjZmL1zks
	Tx9MtWgoUzCZIl6KQ7tXbPt+vm1ZqR7h2DdplpmL9RmDDm2O3tg3AsOS7SVvmGfiwcIb1A
	RJc5ylTnlA+zjtMDi8Bi95ehtnnPTKxPXljBIWSAAH1ulVg7XxTxJlBKdfYNbPI9lMJMT7
	wGhSUqrzmxQaq+/Qj8VPsrGgF+wi24l1Un5ve+T0mTL+HJsjAfbpNc4wU91/XSY/sqLFD1
	HA2plMO5Oq+k92PyLGuoB+pGReYwS8fHuEOTEwGN2xxT8r24qDG2r1bL6J4P7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707640892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saO3EDBD2W+LzkwxfyBQxJVlHOrm2xKpIUw0203BTt0=;
	b=aqovQHQLdM/feHq29GapVQTv3gYDGP5SYlY33m1FLmld74xuSzZOni8BdnCwN9tX/9fR3W
	sMTh+0ifMUN2l5DQ==
From: "tip-bot2 for Peter Hilber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Add clocksource ID to struct
 system_counterval_t
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240201010453.2212371-3-peter.hilber@opensynergy.com>
References: <20240201010453.2212371-3-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170764089178.398.8282186862342058207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     93630d6df7507fa4e664110b1878c06a0c00b0b9
Gitweb:        https://git.kernel.org/tip/93630d6df7507fa4e664110b1878c06a0c00b0b9
Author:        Peter Hilber <peter.hilber@opensynergy.com>
AuthorDate:    Thu, 01 Feb 2024 02:04:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Feb 2024 17:05:21 +01:00

timekeeping: Add clocksource ID to struct system_counterval_t

Clocksource pointers can be problematic to obtain for drivers which are not
clocksource drivers themselves. In particular, the RFC virtio_rtc driver
[1] would require a new helper function to obtain a pointer to the ARM
Generic Timer clocksource. The ptp_kvm driver also required a similar
workaround.

Add a clocksource ID member to struct system_counterval_t, which in the
future shall identify the clocksource, and which shall replace the struct
clocksource * member. By this, get_device_system_crosststamp() callers
(such as virtio_rtc and ptp_kvm) will be able to supply easily accessible
clocksource ids instead of clocksource pointers.

[1] https://lore.kernel.org/lkml/20231218073849.35294-1-peter.hilber@opensynergy.com/

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240201010453.2212371-3-peter.hilber@opensynergy.com
---
 include/linux/timekeeping.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 7c43e98..ca234fa 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -273,10 +273,15 @@ struct system_device_crosststamp {
  * @cycles:	System counter value
  * @cs:		Clocksource corresponding to system counter value. Used by
  *		timekeeping code to verify comparibility of two cycle values
+ * @cs_id:	Clocksource ID corresponding to system counter value. To be
+ *		used instead of cs in the future.
+ *		The default ID, CSID_GENERIC, does not identify a specific
+ *		clocksource.
  */
 struct system_counterval_t {
 	u64			cycles;
 	struct clocksource	*cs;
+	enum clocksource_ids	cs_id;
 };
 
 /*

