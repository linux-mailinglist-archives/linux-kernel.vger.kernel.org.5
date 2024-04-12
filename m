Return-Path: <linux-kernel+bounces-142457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC598A2BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48F51F235E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE1E53E14;
	Fri, 12 Apr 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mG/TtnUT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NOr7y53a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2345524DC;
	Fri, 12 Apr 2024 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916208; cv=none; b=iKHSyXQH+hZM9imqb+u9/OT4zReNjS4YX7mpEtSGH7g2ozBtel7rfMFm4pySZfg/et5K2b+HIttB0sPt1QvjkTyQ2bwaoh9+n/UO+5s+lvALZKSYQMDjn0co+gK/oiSNPSlZFHVL4UtNpA/oa/PFEbSL5mj2lg8NKDje9su2qiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916208; c=relaxed/simple;
	bh=bEl3kUTpvDa4VaEDle7B8um9qQie+8Rg3DQQlt/FmUo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jxoQGx7zO5ku2A81if30ulVfWX9U/U4848RBcRPiV+/5hoMdoGJQxyXGTI7ing5s7nPyL4+zwhgTPhXJoH2TszOkJjr+G6bMAjLnRMfZ4Efdm/opE5sLRvLlpObmnFRDk2CwZL/r/450sV8uAH2ZfZPYaO9blBocBe6w2pCMgPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mG/TtnUT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NOr7y53a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:03:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSJ6PCd5VkQ7nahH5WRJCH3XFdhG1eWcn/lOpn9ozUU=;
	b=mG/TtnUTRfJybUn2YJemYZVP/a5w5GR3VhvZPwbLVvrw6VS0Yb+BV+kuxavO+a8qBhWq2s
	UQWQ9vicw5GED8jketOiVDBgYmrNlqSw1iW2Zy91K3jzBbKRXb1Jzb/CSvZNsMBPyyJwFs
	hzB3I4GYcfBJG3N4j479Zq9daq9R41tZPb3OMkjW1xbZ0in85tRrB0auWpa7EAmrwv/J3Y
	Jg3FXCBJBHvLxhYeh2SiyQCBU+jYVRSNFshgvEeZLMFDbovG35Gg0MVYkVhfHd6qwx3t12
	NtaPmgxZQbBhtq7U/VEetQ7+kMvSrnI6nsJPM6IPaOe+ySZFw4xSSdxcAywUEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSJ6PCd5VkQ7nahH5WRJCH3XFdhG1eWcn/lOpn9ozUU=;
	b=NOr7y53atvqb6HGacNnpJxa4q7DMaORNh22mhuDJ5pmp2NswBaOpyBe0JBXxSU+zLyaETm
	A1CsSCjOzqai1jAg==
From: "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/bpf: Allow a BPF program to suppress all sample
 side effects
Cc: Kyle Huey <khuey@kylehuey.com>, Ingo Molnar <mingo@kernel.org>,
 Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240412015019.7060-7-khuey@kylehuey.com>
References: <20240412015019.7060-7-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291620346.10875.14979532789812701380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c4fcc7d1f41532e878087c7c43f4cf247604d68b
Gitweb:        https://git.kernel.org/tip/c4fcc7d1f41532e878087c7c43f4cf247604d68b
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Thu, 11 Apr 2024 18:50:18 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 11:49:50 +02:00

perf/bpf: Allow a BPF program to suppress all sample side effects

Returning zero from a BPF program attached to a perf event already
suppresses any data output. Return early from __perf_event_overflow() in
this case so it will also suppress event_limit accounting, SIGTRAP
generation, and F_ASYNC signalling.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240412015019.7060-7-khuey@kylehuey.com
---
 kernel/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c6a6936..2212670 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9677,6 +9677,9 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
+	if (event->prog && !bpf_overflow_handler(event, data, regs))
+		return ret;
+
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
 	 * events
@@ -9726,8 +9729,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-	if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
-		READ_ONCE(event->overflow_handler)(event, data, regs);
+	READ_ONCE(event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;

