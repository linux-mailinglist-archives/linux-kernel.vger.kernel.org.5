Return-Path: <linux-kernel+bounces-144401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C62AC8A4576
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828C3280FB5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F62137913;
	Sun, 14 Apr 2024 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SaMycIfR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fbSKRmT8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31511136E31;
	Sun, 14 Apr 2024 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713127635; cv=none; b=OT5GvJJkKvssxshhhfHe08gahELkRkwxudN3MfBszM3tfcn7jYSwImp3xR6Z+abq3l/HGuiRMCTrYEF1LHBPtseytHSO0kPk8y/aeG2/jR28CpioIcIGZVxv42ZmNRWOf6fqdmuf/g0+9M65TQNxctKgaONjSdoobdgMeI8rOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713127635; c=relaxed/simple;
	bh=j8yYjNB/lwgdtj7d5dFQqesE42JDJmZZopH+iHq3GT4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZyBjl3qOeJG7ocn7wh3gJMd4+QEuz1JE1/YOa0OXbiASUbGxaVlFpoTUXGNBcfU6LKd0DnZs2/mLXIx7E1NBtTa24C3VfwojoRXmHS2IHqFp/fnmTgvpPx4OpWY3BS05SFVtESE9yTmGNxB6atR9JWlnme6lEnafO5DEnifXDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SaMycIfR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fbSKRmT8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Apr 2024 20:47:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713127632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kk33WvAgbOeZne4fG/MnGSoLByjT4UvbrYfIWfMtSSI=;
	b=SaMycIfRckIeJSYfD7r4r8LwE2ArrUMjUIk/FdPZnr7vXF1IJAshtfIBhBzxopUIiu19uL
	qTrWpTCnZSUc14wVMbw3A6u26t7d8m3TXPPjurVsj4kdOcZvIE7YZeE9LlMGdPzDyTy0VV
	s4setirnGcQpHZOTiAxRjRqUb9GUsIeOpwVe1kYIRyeyT4wvgzrzwwqPHbEKchL8F557jC
	MzgxankRExjXSIprJtEQ8VbIUOBAaN+NdVkbBfjarW7eKORHu85V9+47j2dpvVGDKZU6V6
	X+7FWjFZnHU3NqlXcbdyTshiWkhWS4RlTel18L3KmtFkC750eViyR4RlKGWxeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713127632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kk33WvAgbOeZne4fG/MnGSoLByjT4UvbrYfIWfMtSSI=;
	b=fbSKRmT8TxCvy5hemdO42hFz6epxjdeF3Q3/SxedpxDDCxI3fljhvRn05JwH6z9hFDb8ag
	mczSPa/k0YymbjDA==
From: "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Move perf_event_fasync() to perf_event.h
Cc: Kyle Huey <khuey@kylehuey.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240413141618.4160-2-khuey@kylehuey.com>
References: <20240413141618.4160-2-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171312763167.10875.45937385096988617.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4a013980666857c1eb2df6a2137817caa21d38a6
Gitweb:        https://git.kernel.org/tip/4a013980666857c1eb2df6a2137817caa21d38a6
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Sat, 13 Apr 2024 07:16:16 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Apr 2024 22:26:32 +02:00

perf: Move perf_event_fasync() to perf_event.h

This will allow it to be called from perf_output_wakeup().

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240413141618.4160-2-khuey@kylehuey.com
---
 include/linux/perf_event.h | 8 ++++++++
 kernel/events/core.c       | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5ff0c1..a5304ae 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1686,6 +1686,14 @@ perf_event_addr_filters(struct perf_event *event)
 	return ifh;
 }
 
+static inline struct fasync_struct **perf_event_fasync(struct perf_event *event)
+{
+	/* Only the parent has fasync state */
+	if (event->parent)
+		event = event->parent;
+	return &event->fasync;
+}
+
 extern void perf_event_addr_filters_sync(struct perf_event *event);
 extern void perf_report_aux_output_id(struct perf_event *event, u64 hw_id);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6708c11..da9d9a1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6703,14 +6703,6 @@ static const struct file_operations perf_fops = {
  * to user-space before waking everybody up.
  */
 
-static inline struct fasync_struct **perf_event_fasync(struct perf_event *event)
-{
-	/* only the parent has fasync state */
-	if (event->parent)
-		event = event->parent;
-	return &event->fasync;
-}
-
 void perf_event_wakeup(struct perf_event *event)
 {
 	ring_buffer_wakeup(event);

