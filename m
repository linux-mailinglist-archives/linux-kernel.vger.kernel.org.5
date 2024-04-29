Return-Path: <linux-kernel+bounces-163075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999058B64B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5519028115C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF3D184105;
	Mon, 29 Apr 2024 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="siBTceqN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+2nUi15d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D65946C;
	Mon, 29 Apr 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426692; cv=none; b=cuL8RWnI827dsp9GnSP9NUvDlw+D4ysrQj5zXeF2lPqBC2j+DL0GSDuic35/Vgl4aFHUI9/JJqMUA6mEmGEWNDAA1yjyFE5bgzyLkYtGNg8uxWwwG4/HMLbpThczfdlQG91lf8IoqfwHMw6ShG7vPaKNdpAYRk75111rtWWmpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426692; c=relaxed/simple;
	bh=k8g/TiU8lIU8Mibjz3VChly9XimolgFwCzPlqtxQveM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HkY2BWP9afGnB7BJja6ij8MD3nMMW/wJ0Alf9Wr0SZiIqvDVUsPGjjzWk0BxG+/ivOCIsNRptC+SKMIlgARUV2Uz1Kdj3+q1VM5INNAxU10EgzODkrQMmtVveYJ5cG5gsFs5L7uTIe6hLkzO0W8LXASXXeSP8U7qVgz4m0QnChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=siBTceqN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+2nUi15d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 21:38:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714426688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTJ77so2WRoXGher0vupuLRohX0a5C8x4hw3nGSKDmM=;
	b=siBTceqN18t4AkSRqy1DqWvgDyioPnO6h1gudSE5tR93CnPHdjQvrVvM8W+sPd5olhkQIZ
	Hrze7YxMShI8YkY2LTwAA/+izT9jnbOOdSDYk5F1npQ/5FeY8sxfVEa3UGza460fOdfRqK
	hTJwR+uCRZf1mZySPhSFwundB8UIqrgl0uU9gOMR8a2jNX1On5aqD9jy0WaAd5BYXv5u/r
	dgbysIze0oFPkt0so4b60WFG7CoZi96BscrhOGxrnuj4Sm8a7mR2T0Q8Ux0nMcRUTFNsD4
	d0jwkqPqpU026QeURH8DoSVfW8CnSpsaLu/w6E1ptw7JHeXhrYpZFLHT/Tucdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714426688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTJ77so2WRoXGher0vupuLRohX0a5C8x4hw3nGSKDmM=;
	b=+2nUi15dQtqXxR4ffhKiMVbLeNcXBXOeY2o+gcnERQZ4Q/MruYrKhxEBWH2OfInESyM6l9
	6ANZK+nUvuy1+mAw==
From: "tip-bot2 for Daniel J Blueman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/timers] x86/tsc: Trust initial offset in architectural
 TSC-adjust MSRs
Cc: Daniel J Blueman <daniel@quora.org>, Thomas Gleixner <tglx@linutronix.de>,
 Steffen Persvold <sp@numascale.com>,
 James Cleverdon <james.cleverdon.external@eviden.com>,
 Dimitri Sivanich <sivanich@hpe.com>, Prarit Bhargava <prarit@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240419085146.175665-1-daniel@quora.org>
References: <20240419085146.175665-1-daniel@quora.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171442668800.10875.19345624016971341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/timers branch of tip:

Commit-ID:     455f9075f14484f358b3c1d6845b4a438de198a7
Gitweb:        https://git.kernel.org/tip/455f9075f14484f358b3c1d6845b4a438de198a7
Author:        Daniel J Blueman <daniel@quora.org>
AuthorDate:    Fri, 19 Apr 2024 16:51:46 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Apr 2024 23:27:16 +02:00

x86/tsc: Trust initial offset in architectural TSC-adjust MSRs

When the BIOS configures the architectural TSC-adjust MSRs on secondary
sockets to correct a constant inter-chassis offset, after Linux brings the
cores online, the TSC sync check later resets the core-local MSR to 0,
triggering HPET fallback and leading to performance loss.

Fix this by unconditionally using the initial adjust values read from the
MSRs. Trusting the initial offsets in this architectural mechanism is a
better approach than special-casing workarounds for specific platforms.

Signed-off-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steffen Persvold <sp@numascale.com>
Reviewed-by: James Cleverdon <james.cleverdon.external@eviden.com>
Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Link: https://lore.kernel.org/r/20240419085146.175665-1-daniel@quora.org
---
 arch/x86/kernel/tsc_sync.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 1123ef3..4334033 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -193,11 +193,9 @@ bool tsc_store_and_check_tsc_adjust(bool bootcpu)
 	cur->warned = false;
 
 	/*
-	 * If a non-zero TSC value for socket 0 may be valid then the default
-	 * adjusted value cannot assumed to be zero either.
+	 * The default adjust value cannot be assumed to be zero on any socket.
 	 */
-	if (tsc_async_resets)
-		cur->adjusted = bootval;
+	cur->adjusted = bootval;
 
 	/*
 	 * Check whether this CPU is the first in a package to come up. In

