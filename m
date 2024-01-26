Return-Path: <linux-kernel+bounces-40103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAA083DA5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687E1292A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E62E1B80B;
	Fri, 26 Jan 2024 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u1CDzLdq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uP72eXYU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0291B7E4;
	Fri, 26 Jan 2024 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273621; cv=none; b=adbfLtC/rPUn4spZwN2vlDYorixE2RV74D/8UYz0TdKvdR2avTra4GPOE5dRp0V0Bx+rwclPpp/zdwVFuMlI4gqRwh9jnLjUhRMu0PhaO6ZeIY7rypnjWAVgxYcd9GphVApv1DvvRS2RZncZFAW4D1l17iK0w8F1ukHupyOscQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273621; c=relaxed/simple;
	bh=EuOvVORF127CkByqo9JvRaz0G5LimiWwyijltrAf+2w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OXDWpvv6wxX63wsNYmz3kSz4Rg/xoHnIAKgcGO42i7UhxkuOo8CqXWIyIDJ4or2GstNwo8sPBv2xQHOlJogaSwWt1+gBvm0Yv/T2H9aYpOxJsp7/udOYXMUeY3GIM/1Pngj7BFID8hFKPZRn95CPD8q165+MikrP74cbUVhmSp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u1CDzLdq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uP72eXYU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Jan 2024 12:53:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706273618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1KY0embBGLnATWagIuUNxYX+cMSq4KE6tVZfncqHzA=;
	b=u1CDzLdqMRIEloIb75C5CTEM6OIEGIexJRG7fmD+CBbBn+qU2DpXSEJ0+cjFox8VCEn6YF
	fL7pCor5OlfuyfucVQrCDJsV4IJLpWIpoqLN5u1BK61jaEoDieY2sC+VhQjVaEtXiJ6ZcG
	6xeHboovkxykMBnP58pWvdNoyrd0+LKGaw5/6B+CgBPolq8K4XT3cTC9H2kzZ09jI6/f6F
	guk8z6N+euvGPiybnjPkNucRJFuGrkrPTUsK/kS8ZNaEpd+jol8nVybrd0JTdasQOZrDgr
	J/VfOW6LuY8bZqkDDXEPL5gq2s21nXvaGpCuhCdtKC5hntDMaok6dRVALjsNoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706273618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1KY0embBGLnATWagIuUNxYX+cMSq4KE6tVZfncqHzA=;
	b=uP72eXYUp39+3u4qIPBeOgvqLx5UC6Ti/77cqceYzVWvQQrs//qO3Q66VV/SWRwvdCMLPH
	t0UhuCZcyClS0WBQ==
From: "tip-bot2 for Bartosz Golaszewski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irq_sim: Remove unused field from struct
 irq_sim_irq_ctx
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240122124243.44002-3-brgl@bgdev.pl>
References: <20240122124243.44002-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170627361776.398.10630627936128999989.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3832f390423302e373a1818f6cf8cb29ebf3a195
Gitweb:        https://git.kernel.org/tip/3832f390423302e373a1818f6cf8cb29ebf3a195
Author:        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
AuthorDate:    Mon, 22 Jan 2024 13:42:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Jan 2024 13:44:48 +01:00

genirq/irq_sim: Remove unused field from struct irq_sim_irq_ctx

The irqnum field is unused. Remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240122124243.44002-3-brgl@bgdev.pl

---
 kernel/irq/irq_sim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index dd76323..f5ebb3b 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -19,7 +19,6 @@ struct irq_sim_work_ctx {
 };
 
 struct irq_sim_irq_ctx {
-	int			irqnum;
 	bool			enabled;
 	struct irq_sim_work_ctx	*work_ctx;
 };

