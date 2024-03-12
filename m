Return-Path: <linux-kernel+bounces-100219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A2F8793A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FBE1C20CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF4D7EEED;
	Tue, 12 Mar 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18NwRsji";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k6zegU5w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5477D3F9;
	Tue, 12 Mar 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244836; cv=none; b=ugzWADh+qnDFaaD1UG7+gnDdVqod1Wr07Sxn2mPf/Qfb2zeiAHKqz0a1vbHlA8Hq/KB4rPVpNz8SXDdXEpsiIYfJIxeO+RGNKT6OluMv9ZbuuUvxyX3CwG/XU39C0O9yee23hsnLqP+xpfLcxB3qCoza7EDx1ZWSKMfEqF/+cJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244836; c=relaxed/simple;
	bh=ffTgJwgePG/lyn4KEKIAPBF/S8FqzM1RFLtZv0CfBMY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jaTh1V6RvgpVZsbrVsZUVG4n2CoEdQzT7CkCRKjJpLAEZmIkMepEr6cDcerHC7OqxGjwaMG5VA2bbvncZiWOW/WJgXJeJ/HyGYB8fSvk9fEJ3R/SrkZGNvxrplYhemFbNXt+9HMKBIhZwo89139mxS9Nhvv8rhQLo2hSx+vNLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18NwRsji; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k6zegU5w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPocG23OkaPIkxJOYAyPiD4g7QU8xy3hTMbfgDNGiIY=;
	b=18NwRsjiXq2JPlYFpFqVvlR78vF9BjIAvVe8T2n6FynfuCEIJEst2ANIaKobogAsnV4rwZ
	nSFNtOIz1JnxE6Ekc88qYWYYti/1DIwsQe0RlGuGsPe1DUliO7RJJ+Gc6sf6hhwkJrPxvS
	7NxHz3xSvjPyJamfiKbNCGEFzzNigWRpCpu7TIwcH5auDxtPKui31/sWGwPTxRL4nBHaWv
	5WDVqtNQltzbvOco0iBwL4wljuyfcTK/XgSJ+Ns/Ho4H2zD2zrQbLxpdAW8+txPB4NT8uD
	OsKxPaSDsJTS42AGtphxIAO2odLBsZk3FXVORNqMeXLJ0V3nhICu5vMxbuL1Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPocG23OkaPIkxJOYAyPiD4g7QU8xy3hTMbfgDNGiIY=;
	b=k6zegU5wgZrcpckiIWp0/v81TPr2N/iXxNkxUkw3zcYw76HaakLxxwmkBFxJyQQYSvjANL
	/5RHnRAD8/IVcBAg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Change comment formatting to not
 overlap Git conflict marker lines
Cc: Ingo Molnar <mingo@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308105901.1096078-7-mingo@kernel.org>
References: <20240308105901.1096078-7-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024483192.398.2147820481172410047.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     be8858dba9a2c3aec454a6b382671101fd0dc3b7
Gitweb:        https://git.kernel.org/tip/be8858dba9a2c3aec454a6b382671101fd0dc3b7
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 11:58:57 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:03:41 +01:00

sched/balancing: Change comment formatting to not overlap Git conflict marker lines

So the scheduler has two such comment blocks, with '=' used as a double underline:

        /*
         * VRUNTIME
         * ========
         *

'========' also happens to be a Git conflict marker, throwing off a simple
search in an editor for this pattern.

Change them to '-------' type of underline instead - it looks just as good.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240308105901.1096078-7-mingo@kernel.org
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3a510cf..84d4791 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3679,7 +3679,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	/*
 	 * VRUNTIME
-	 * ========
+	 * --------
 	 *
 	 * COROLLARY #1: The virtual runtime of the entity needs to be
 	 * adjusted if re-weight at !0-lag point.
@@ -3762,7 +3762,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	/*
 	 * DEADLINE
-	 * ========
+	 * --------
 	 *
 	 * When the weight changes, the virtual time slope changes and
 	 * we should adjust the relative virtual deadline accordingly.

