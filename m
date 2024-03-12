Return-Path: <linux-kernel+bounces-100222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A4D8793AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2191C20A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C868061D;
	Tue, 12 Mar 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f6zos/Ya";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+0jYBRA/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186E7F477;
	Tue, 12 Mar 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244839; cv=none; b=N7cdlmynYqELls7a+ERpftoN8P3Hp/KtEujMTzBGj63nuC9NciPkz8LOYXJ2QyzXINmzVJhYdJf67VGWj7v5PXMk+lOSMbvaDMUVvDIOxt7uZmgOvtvTvQJY5DvbOCta48X0tmM5Z+fnZt0eIKjPGXjHeC35Qm6laidUZz7sWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244839; c=relaxed/simple;
	bh=tWY8OlfsrKk2XAalsbSN3HB8cxCBCu1Y26VoBI1wWqo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ms3sPHy0QRpD9reWghOKZgV7HF1TMUcBInk0zQAogxVGFvAGo4lBillRKC1Nk9V16yhlFenLgMP21k9ET16Zsc1HSRU/aHqgUfPp3/5ccL0VXd17H5IB8Uo6HS/7i4v6EYEEkqOaWl3UQjG/NLTZjGKmEBnnOySaxdwNKm/CoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f6zos/Ya; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+0jYBRA/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244835;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBpHGJviAYvXkDjcZLVmw5k4jriT6wBuw78QrbQ1Grc=;
	b=f6zos/YaH8s6OgPuyXgCAZTR+Xajin3v6Trkn1BRqMm4IxTckeJv9F8LRYHTY/5hK/YYMR
	GTdOX4IBWGcvMSEAGQl0bqt47o5QLLQemmJcz8bamCiUg6d2pnfn2rfK8qJHa8OmPWgy4O
	XmW4pRhVmrKNSl4gTf74LEEUAiFf2xloqo+g2p/sTlXAYkoCxqZPDTV1c/oE1SV626RoeR
	cKPJr56mdoDAPZxIWlfYktuO6sqUvo1LAH2xZqey/afi17hGEBO9N7SENXsdr2COS4kNVK
	/zXXqRxST1BFC990Nr7KGUgZwwKnAJ569zKmd3Biih7b4PeMyRrDVgbBjdzKkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244835;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBpHGJviAYvXkDjcZLVmw5k4jriT6wBuw78QrbQ1Grc=;
	b=+0jYBRA/4Z4gENM3quEtEec8xh4x6km7p791Xo3j9vp3jO3m80WYZ0PXPQZJpb2Db4Opnd
	4anKfvH8WhhagGAg==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Remove reliance on 'enum
 cpu_idle_type' ordering when iterating [CPU_MAX_IDLE_TYPES] arrays in
 show_schedstat()
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308105901.1096078-3-mingo@kernel.org>
References: <20240308105901.1096078-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024483470.398.11589008733462970001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     02a61f325a8e62a7c76479c5f2f7ddcba16877e8
Gitweb:        https://git.kernel.org/tip/02a61f325a8e62a7c76479c5f2f7ddcba16877e8
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Fri, 08 Mar 2024 11:58:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:03:40 +01:00

sched/balancing: Remove reliance on 'enum cpu_idle_type' ordering when iterating [CPU_MAX_IDLE_TYPES] arrays in show_schedstat()

show_schedstat() output breaks and doesn't print all entries
if the ordering of the definitions in 'enum cpu_idle_type' is changed,
because show_schedstat() assumes that 'CPU_IDLE' is 0.

Fix it before we change the definition order & values.

[ mingo: Added changelog. ]

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240308105901.1096078-3-mingo@kernel.org
---
 kernel/sched/stats.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 857f837..8527795 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -150,8 +150,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 			seq_printf(seq, "domain%d %*pb", dcount++,
 				   cpumask_pr_args(sched_domain_span(sd)));
-			for (itype = CPU_IDLE; itype < CPU_MAX_IDLE_TYPES;
-					itype++) {
+			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
 				seq_printf(seq, " %u %u %u %u %u %u %u %u",
 				    sd->lb_count[itype],
 				    sd->lb_balanced[itype],

