Return-Path: <linux-kernel+bounces-144400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E548A4574
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBB0280FF2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B17D137762;
	Sun, 14 Apr 2024 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LT3xvCsu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zpzPM8gB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66646136985;
	Sun, 14 Apr 2024 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713127634; cv=none; b=BjhP9gpNe61k5ag4NGJcMf6pfChS4dBiHpdyi5QRozxJFD55qPkaz6h0Bmwik9a7MnofAIfs8avB6w6+7uUb1EraSP3Qr7XwBakBTdYdVZ+vnKoAIHwHRieVwLxZz/dmKvwQlWvKi5iCKYRJ7izsfuzvvZNfkA1esaHPQ076pog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713127634; c=relaxed/simple;
	bh=x+Ak8cEMnEs0r5HJV4MBanw21DT0LmnuS2x6w/wIPOw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hctcMvRiDmGmVfuR4W+qCFBKhwVb/DhV6xqkPA1GSGc89PhG2PX9wCakE32oPkB/6TDr/TKKFE09Lxai6TI6aGwCTDF+O+yUiHjxgobrdlnavp+0rzRX15D19g0jCKYL6hjPZfHjK5QyurgIzgyov9QrxfUv09L7Ceg+bq7qHQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LT3xvCsu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zpzPM8gB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Apr 2024 20:47:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713127631;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EjIJ3DkzzkjR8BKk0uV8rpRhAkpgORCuuMkujBl6a5U=;
	b=LT3xvCsuay9ZzD0WZQzjvEVk+ZDxgwKShl0vDSiGH5OlBxSgDLwqNFCHaFA11wyNTGDaKA
	Sjyx4bLYqie7m+J/syxpUuX6W7hyUvWyP5U15LUuL9shr3ZHoFmyGSfza8gjgWbYf1ZSDX
	ncKP37KJBAWNMYnK8UXnGk4FeZwH74g++kwCS7C/HprcIfrHLlRTZjQC51BHbggNQNqiCt
	O8iyEAKwsX5xueOBrXGDIT5m89yBnNOXOX3t+lBaBoK5DUWe/w4C1oapHOF64YLB47oJ0d
	iywjVmTFhLmx0vdcMv3Kv/eNEAsl5DAcylYbKckIHWBtO0rL9VOvT/Cy6zJAqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713127631;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EjIJ3DkzzkjR8BKk0uV8rpRhAkpgORCuuMkujBl6a5U=;
	b=zpzPM8gBXjKUemYAYHOwBhcZzYH7cz1FyEQ7n0Y+scXaGI4GGBAsXTiDrrph850Ufm5Yw8
	MO/t0oBaKTMWn+Ag==
From: "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/ring_buffer: Trigger IO signals for watermark_wakeup
Cc: Kyle Huey <khuey@kylehuey.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240413141618.4160-3-khuey@kylehuey.com>
References: <20240413141618.4160-3-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171312763097.10875.3668318921597821479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fd20bb51ed3913e0d25085eb79e8c0babfb4ee28
Gitweb:        https://git.kernel.org/tip/fd20bb51ed3913e0d25085eb79e8c0babfb4ee28
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Sat, 13 Apr 2024 07:16:18 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Apr 2024 22:26:32 +02:00

perf/ring_buffer: Trigger IO signals for watermark_wakeup

perf_output_wakeup() already marks the perf event fd available for polling.
Trigger IO signals with FASYNC too.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240413141618.4160-3-khuey@kylehuey.com
---
 kernel/events/ring_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 60ed43d..4013408 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -22,6 +22,10 @@ static void perf_output_wakeup(struct perf_output_handle *handle)
 	atomic_set(&handle->rb->poll, EPOLLIN);
 
 	handle->event->pending_wakeup = 1;
+
+	if (*perf_event_fasync(handle->event) && !handle->event->pending_kill)
+		handle->event->pending_kill = POLL_IN;
+
 	irq_work_queue(&handle->event->pending_irq);
 }
 

