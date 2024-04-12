Return-Path: <linux-kernel+bounces-142455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661378A2BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD480B25B21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15538535BF;
	Fri, 12 Apr 2024 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fiJIP4oF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m8XaeSpH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE551C4C;
	Fri, 12 Apr 2024 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916207; cv=none; b=shXDECikBe862MrgqrEoHwZyVv+g/Zfg/+43MQRrxgs1Tcxd0aypHszvARzT8NDSoAuqO4usHtEPtrHxKTc239mvkZm69LL4qbsl7nOE014gsQ+ahQOYGtHr3cAYI6jHMj/f9E4GmEB4nSskcFVtlXmpKeLWUYsj1r2gGga3rfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916207; c=relaxed/simple;
	bh=GE3zewDFEJy62QBcsshA51A2GHr1MK+CmGMdKwDY9ew=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TdmxR39Vn09CwB1de5rmFqICKe4wFwpC5h3nxmilryS1T1v8Mtg4pwHKHrGThgRU8y13Zo1RzolTElz4ZBHlXa/KhgtIAzQAOZ1fOAxAVTC0NylYgcpvmM6LiysMwDQEHc6ONlqYxfOOi9Q7xT/9xjB+Us+MpxyPLc/Vw4an0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fiJIP4oF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m8XaeSpH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:03:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXX4u4b55YoYWQNcUt9JRPqDtNAJ3+fmaYA8NC8A0CI=;
	b=fiJIP4oFlhPHljGqD3623yYP5JeWPR8Sd2iBBSUw9ANwbC41GUCGYhi2UCRrBwu6+tucwl
	dtyJyuE7wOBUHcEiMWNYYsNvv99vH/efRpYvoOQjJ7MRjHSx7AJZRGsmhvVS29X98qIKv1
	vKPbsUrun8Y/7vJVstAd/gunbFlApdJwfZ3daI4Cm53PVtXvx6ZWJLkC52x3nWe6QFKGcg
	D1WlcoGA/yrmn33x+frXp2FAfMMtJ/o3LdEmQxggxVNRFrAdeBeSyDplWn4e2SF0GnlsFu
	oFq4+gPNsjyzaENFs9gsZLlvUoOGEVO/+UCVvgoBnDrKUFMFsGcF/9WaO1rDlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXX4u4b55YoYWQNcUt9JRPqDtNAJ3+fmaYA8NC8A0CI=;
	b=m8XaeSpHmB91B5bmK20u2HKrMJEwJkFgr5XxVJdhzUAt//ompcalkQMZdWC/1kb1ScmCs3
	796ILoqkwqmQYFDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/bpf: Change the !CONFIG_BPF_SYSCALL stubs to
 static inlines
Cc: Ingo Molnar <mingo@kernel.org>, Kyle Huey <me@kylehuey.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ZhkE9F4dyfR2dH2D@gmail.com>
References: <ZhkE9F4dyfR2dH2D@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291620188.10875.569943657110108283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     93d3fde7fd19c2e2cde7220e7986f9a75e9c5680
Gitweb:        https://git.kernel.org/tip/93d3fde7fd19c2e2cde7220e7986f9a75e9c5680
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 12 Apr 2024 11:55:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 11:56:00 +02:00

perf/bpf: Change the !CONFIG_BPF_SYSCALL stubs to static inlines

Otherwise the compiler will be unhappy if they go unused,
which they do on allnoconfigs.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Kyle Huey <me@kylehuey.com>
Link: https://lore.kernel.org/r/ZhkE9F4dyfR2dH2D@gmail.com
---
 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2212670..6708c11 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9638,21 +9638,21 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
 	bpf_prog_put(prog);
 }
 #else
-static int bpf_overflow_handler(struct perf_event *event,
-				struct perf_sample_data *data,
-				struct pt_regs *regs)
+static inline int bpf_overflow_handler(struct perf_event *event,
+				       struct perf_sample_data *data,
+				       struct pt_regs *regs)
 {
 	return 1;
 }
 
-static int perf_event_set_bpf_handler(struct perf_event *event,
-				      struct bpf_prog *prog,
-				      u64 bpf_cookie)
+static inline int perf_event_set_bpf_handler(struct perf_event *event,
+					     struct bpf_prog *prog,
+					     u64 bpf_cookie)
 {
 	return -EOPNOTSUPP;
 }
 
-static void perf_event_free_bpf_handler(struct perf_event *event)
+static inline void perf_event_free_bpf_handler(struct perf_event *event)
 {
 }
 #endif

