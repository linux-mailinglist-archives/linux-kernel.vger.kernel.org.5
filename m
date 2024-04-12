Return-Path: <linux-kernel+bounces-142461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8798A2BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B141F22DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6BC55E73;
	Fri, 12 Apr 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ib1ubaLm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/QMVXIis"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60B53E12;
	Fri, 12 Apr 2024 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916211; cv=none; b=c35i+B3oRh+/xConiU5cxNiLWNhO+ZQuXGvVOxdfrAkjekjnbHPGbsLmeUUaCFpi20AUD3JV8YLxkk6OWDcKmO6a5JRtM3CWgHNDEYQX3o72SLhXyBOOGWvhsKL8bNbzIVyjmhTnDwWEcppHPGtCRlBEXRpVBxqn+zhZErTvqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916211; c=relaxed/simple;
	bh=OsLvxWH5pk4PjFTNog6JnoDIUnLYRfVbXoXwRqIZwr0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kdpNAn2ubrvLtuJl/3zYo1sUQm3hsyoaM0qBxHgxXO3ojfKKoEwHSo0zBCyuzcnLAXIF1SX83c2NS5Z7axv4vFAgVquPtnC5wuw4ydopfJhy7rBtL66kuhnemEvE9lteHK8SEnp5XSZ3E0ZfcNxDp1uAlEx4HDlopxAa8SvRN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ib1ubaLm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/QMVXIis; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:03:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ux76BwEZsstQe0WDx09TcWlygdAG24xjwUfPRwhrouM=;
	b=ib1ubaLmpbbFVXRM2jiXFhaHd0mfPE1fI2QgWQFLdPR0gXlcS6X5SYw/BkL/Dok3+BdYr3
	SPalEKpS1FxQiUPqp+qmYE20/1DmRs6G3elsB4Vq/8v4054TkBK2+7xWNhDNXmTA7buioc
	bqf1Eb4g8dXwbJjthyoj3UNYOD8DFRMw6TeVt97z+wsWBSHwUxWgelCmqDVJmgKe+FVPQs
	GIgrVKPwQieQXdrQIOV4vLh1yKyrjLctWupaFEElgqsQjGf4PE7Fxo6THaBETLW2JOaDqT
	NtpS/25w63csJJ8jbbZNRKcxx31SlAe5qdM2Ot13xYrI+V3Hpcci3k7VEgik7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ux76BwEZsstQe0WDx09TcWlygdAG24xjwUfPRwhrouM=;
	b=/QMVXIisdBhSu4tw6YOSG7wKwHmvKLB1rTKDqDsIU8rR8QOzyTQ3qpnk61GwkSeOzGfqRZ
	vKmIcMvvfqf8qHCA==
From: "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/bpf: Create bpf_overflow_handler() stub for
 !CONFIG_BPF_SYSCALL
Cc: Kyle Huey <khuey@kylehuey.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240412015019.7060-3-khuey@kylehuey.com>
References: <20240412015019.7060-3-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291620648.10875.1841975768856503179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     924d934393f98fa6a41d6ea27352faf79c2bbaf6
Gitweb:        https://git.kernel.org/tip/924d934393f98fa6a41d6ea27352faf79c2bbaf6
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Thu, 11 Apr 2024 18:50:14 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 11:49:48 +02:00

perf/bpf: Create bpf_overflow_handler() stub for !CONFIG_BPF_SYSCALL

This will allow __perf_event_overflow() (which is independent of
CONFIG_BPF_SYSCALL) to call bpf_overflow_handler().

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240412015019.7060-3-khuey@kylehuey.com
---
 kernel/events/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ca0a906..d3f3f55 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9643,6 +9643,12 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
 	bpf_prog_put(prog);
 }
 #else
+static void bpf_overflow_handler(struct perf_event *event,
+				 struct perf_sample_data *data,
+				 struct pt_regs *regs)
+{
+}
+
 static int perf_event_set_bpf_handler(struct perf_event *event,
 				      struct bpf_prog *prog,
 				      u64 bpf_cookie)

