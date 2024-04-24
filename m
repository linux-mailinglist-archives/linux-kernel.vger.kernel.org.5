Return-Path: <linux-kernel+bounces-156701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5244A8B0703
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EB51F22858
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594F915921C;
	Wed, 24 Apr 2024 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jFlvwx/j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7yaGq7/d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334651591EE;
	Wed, 24 Apr 2024 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953625; cv=none; b=agTGrnALLypriOKk+5/SPG4VM+Lw6hemLMNrEOSPrfBK+35fezt9AZQo5VFjnyMr6FyZdx//MyQM31Zsfq1gHumba6O+UNSvaKZEY3e6V/0GQpfoZS86ExZsb5XF/FEtGTHLl++dYvdlNkf5o7RIKU7FsfH4kTeGu763L8iO9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953625; c=relaxed/simple;
	bh=RzQ9MzmadsmJNJYdtFtfbcxu5HflTL8fbN7EYDTgeP8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ThymjMb5hWkslOCFgY1qLbRmjqttQCrT1HoMlsDnSadOReyxj7aAR58w38ocu1DkAKDkpMcB5TGnbmWe8ay5n2hEqR7Y5ZeAEUevdTvMkKqJoIceEZIxzAhmvBQo3Vp8aHTu/lOo/qvcv5Bq4+Xa1krRhbRw8nBOtBQlTXOTDDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jFlvwx/j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7yaGq7/d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 10:13:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713953622;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWA8ZRYSb39tNVn89T8ZAbT0WbRmXGIzDHq2lu5jI3s=;
	b=jFlvwx/j9xjO8M8Ke3IZpjT8O80eDzBuYxfcL0Rh+qSJsz/6TlLhwvJVpWHG+jM8Q4nyn2
	FKR9DoX+liurcWrCAXfJZ+s4Ur68bq9pwV/IRJa04hNviHlvwn0c+z/h+S0zqJrVi22qDZ
	fr2wiTVuNidP5IMjGBADXDesy3OcuP4wXj8yjycgyM/18PwQzarILtZ/6h+cKCQn91liX3
	yp/1nuVGiyb4FS+eRBOT/t4BTFAJd16eB+mvPRv+ZKnIbn3GvUIiEuPHTb3TfqDzELay6D
	6hFaUnwtwMywEzoQw3GSE3P5iwTrxI2A9Ef2ApiWWZsPJC/swtJbBR8FZ+y1JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713953622;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWA8ZRYSb39tNVn89T8ZAbT0WbRmXGIzDHq2lu5jI3s=;
	b=7yaGq7/dtPNym6lQm2H5VouGdVKQHLCRePJL0TewsB3YgxlDyzDoP8ikCGJOYwLaxmHd/J
	JkMMsko7oc0ok+Bg==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix update of rd->sg_overutilized
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240404155738.2866102-1-vincent.guittot@linaro.org>
References: <20240404155738.2866102-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171395362163.10875.16925187350366324489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cd18bec668bb6221a54f03d0b645b7aed841f825
Gitweb:        https://git.kernel.org/tip/cd18bec668bb6221a54f03d0b645b7aed841f825
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 04 Apr 2024 17:57:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Apr 2024 12:02:51 +02:00

sched/fair: Fix update of rd->sg_overutilized

sg_overloaded is used instead of sg_overutilized to update
rd->sg_overutilized.

Fixes: 4475cd8bfd9b ("sched/balancing: Simplify the sg_status bitmask and use separate ->overloaded and ->overutilized flags")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240404155738.2866102-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1dd3716..bb1ae4e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10661,7 +10661,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		set_rd_overloaded(env->dst_rq->rd, sg_overloaded);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
-		set_rd_overutilized(env->dst_rq->rd, sg_overloaded);
+		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
 	} else if (sg_overutilized) {
 		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
 	}

