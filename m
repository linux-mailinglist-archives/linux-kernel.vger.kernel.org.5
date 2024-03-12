Return-Path: <linux-kernel+bounces-100217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ACC8793A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5061C20CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DFC7E785;
	Tue, 12 Mar 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hW2dWVZP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFTuiidY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E507D093;
	Tue, 12 Mar 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244836; cv=none; b=kGuCcXLg9TK/gtZnZrRVtpIJRNxUKRG948wq2lUp8Xmk0jumTYgH/Rew1NgPrFokrKldyvYawRhBedpXjdGnmjWj+beOWsOusB5TcoI4/KrGKy3pmy6tL3RgcMx79OXJM+AyZ33fhZUsVIlzlRb/3SbgPdRQrUmLds1tPwHTiXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244836; c=relaxed/simple;
	bh=S0IESX66TgNwo7luCH44I6uCkL3Hz8KiUQgljQt3uko=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aognMwvymI0PPZ8WI0TXnyryTOYvJhuseWfX5BrcVtPObcd3a+OUT4gPo9h5BzGuGWOFijVaaPzIC/2CnTTn8SVfzmZNdJlUCsm65Y54pPaCddvcRwV0RGDi/eddFsaVeXTZRDumE2ajPn4G2VOMol8W3GHFG+VqWj58QLNe0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hW2dWVZP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFTuiidY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zG9zHs6qbQIiUoIV4bAea7rLUJMh8fJW9pTnlMn35IE=;
	b=hW2dWVZP9ZYXJHxg3nFEUSsyUDf/yw/2ofSyj9RZV9ZC8ukPHMcvakTfNfqC2rp3eO7PA8
	/9NJ/lNgLamaaA8DPQDNefxQQN+VOoRpFY7n+n8oQNOBI0D2kTj/STCY19j9LqArHhU4K7
	aemlpHteLhRLelt5aSPR+SeBhePdA6jqRmS1+MWbrTeNvstk0x3gnaJaUz4gYP+kx807pz
	laogD2ffMpAZZ4J9FyXXeDLlTnJs68FfdBpFEs9cQe+kcs0O+Mm/ol6vP5bUmnpND+TGAN
	gMLign3HNmO9zKWBhn16i1nMtt8EsNwvKRL8PWYeWrxksI/eB9RcAOwIw0TXSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zG9zHs6qbQIiUoIV4bAea7rLUJMh8fJW9pTnlMn35IE=;
	b=iFTuiidYsj41UJGJlG2uTr2dnQiqQfaAiBA1E3ZJPL8dm77ON0M3v8NDVrj1gV8UD0MZ7M
	vOCPyE8BpmFepnCQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Allow CONFIG_SCHEDSTATS even on
 !KERNEL_DEBUG kernels
Cc:
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308105901.1096078-6-mingo@kernel.org>
References: <20240308105901.1096078-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024483260.398.15578307228976810423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9ab121d65e03b4dc38f207871070eb353b396b05
Gitweb:        https://git.kernel.org/tip/9ab121d65e03b4dc38f207871070eb353b396b05
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 11:58:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:03:41 +01:00

sched/debug: Allow CONFIG_SCHEDSTATS even on !KERNEL_DEBUG kernels

All major Linux distributions enable CONFIG_SCHEDSTATS,
so make it more widely available.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240308105901.1096078-6-mingo@kernel.org
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6c596e6..ed2ad1a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1250,7 +1250,7 @@ config SCHED_INFO
 
 config SCHEDSTATS
 	bool "Collect scheduler statistics"
-	depends on DEBUG_KERNEL && PROC_FS
+	depends on PROC_FS
 	select SCHED_INFO
 	help
 	  If you say Y here, additional code will be inserted into the

