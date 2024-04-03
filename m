Return-Path: <linux-kernel+bounces-129194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BC38966CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28EB28BCC6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B7B5C60D;
	Wed,  3 Apr 2024 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MrpJWWaX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ol8Yp1xr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD985BAD7;
	Wed,  3 Apr 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130030; cv=none; b=Wd57PeBA/DL2GBtSWZcoS0Q/FEm0PYyBc/1pgPGisZXWSAaS1uC3PuWVR1XrzFS6ndLVF2IK9Lk8EG6vyWyYPPCF8qsKoRPUHOrvZcYd2LbGhe/tpdoPkk0DGR5EmiwPzPu9fbwQkv646OM/2nYHD+gA0cYIZ1SMzw06QeUwDA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130030; c=relaxed/simple;
	bh=qcinsCSc+z/uEu173J5QS8eSC6zsUqM0DdUtcs/Iyp0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qvmg9szJqMp6cRtADL76UlDu7y24SGSPmhx0FHCHygl33N9jezDzY+nNQrdPMsHBJBHnwwlRQgGMMeto+gJMTPAhpZpPmmlCYwoR7ZRFJ0s7UmDA50cv6iSQQs5F5ZOaAZ2LcCKYSSasWZeNx1nqQZbHERomsTIsaNMHWG00hPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MrpJWWaX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ol8Yp1xr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 07:40:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712130027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MbZKS+B606DnWQ6gGxuBH0v9zCGdjBd86EJrA21kuY=;
	b=MrpJWWaXpXh8X8qkV3GQ+9EeZLIQ9O4g0MQOq/fV9y+PTBHEuPJcnhzzpPIoRcxQTixIuC
	mOQiVa7ZOkvLhyvi3RBuBEbrVEyCn2oXsZdelS7VzvTK/ScmmG1STHJ3hglvTwSbJr0El4
	/KtfQ1bMy1DBeZsYzXmyJkA4XhZ2dcF9A7+35iAt0mk6u6Q8QgXi1xoQgA3K/e27qKO93m
	YrgqAT+2Jc7DavTmx0264qt+7fQogWx/j/VePydxsEBjBvSvD7dm/ro8533j1FPXQKHDyH
	yswQMyuutlXMcLn3/JunnZOzmZYky2lZRJappyhxIrhQRoShhaHfg4dAKqYHLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712130027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MbZKS+B606DnWQ6gGxuBH0v9zCGdjBd86EJrA21kuY=;
	b=Ol8Yp1xrbKXuE+d892TG0tiFBjBBYCkMQV0lp8Es2IyuIBuTxMg6NAvZ+j0GT4asJGdov4
	9+JK0yWt3TeqD1AQ==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Don't reject non-sampling events with
 configured LBR
Cc: Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Sandipan Das <sandipan.das@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240402022118.1046049-5-andrii@kernel.org>
References: <20240402022118.1046049-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171213002604.10875.4290828436978142700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9794563d4d053b1b46a0cc91901f0a11d8678c19
Gitweb:        https://git.kernel.org/tip/9794563d4d053b1b46a0cc91901f0a11d8678c19
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Mon, 01 Apr 2024 19:21:18 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 09:14:26 +02:00

perf/x86/amd: Don't reject non-sampling events with configured LBR

Now that it's possible to capture LBR on AMD CPU from BPF at arbitrary
point, there is no reason to artificially limit this feature to just
sampling events. So corresponding check is removed. AFAIU, there is no
correctness implications of doing this (and it was possible to bypass
this check by just setting perf_event's sample_period to 1 anyways, so
it doesn't guard all that much).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20240402022118.1046049-5-andrii@kernel.org
---
 arch/x86/events/amd/lbr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 33d0a45..19c7b76 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -310,10 +310,6 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
 {
 	int ret = 0;
 
-	/* LBR is not recommended in counting mode */
-	if (!is_sampling_event(event))
-		return -EINVAL;
-
 	ret = amd_pmu_lbr_setup_filter(event);
 	if (!ret)
 		event->attach_state |= PERF_ATTACH_SCHED_CB;

