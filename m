Return-Path: <linux-kernel+bounces-101336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7E287A5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CC71C2131E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA18F3B784;
	Wed, 13 Mar 2024 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXsrAcSI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8rTNQETu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981A3A8F5;
	Wed, 13 Mar 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325361; cv=none; b=AfSj9d4Ue3PYJt/sWEG/BfEbzqzfy9vqQegfu+S5zPEgLA4r2pvJQupqDKOQqvTp+Y2KquQSQSn2a44IO50V3nN7ecRg8gOlLDoTG4Trj3mmu+lKElWHKIRo5UtlVQIPx2apPf8O9mXnEWyZpshPH/91KgDun4lSbXMq1zKIYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325361; c=relaxed/simple;
	bh=gcUWdpJM6KFXyBaEYUL06ewk+ya42ASQvejhLXp0nHs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GkebrXIJqxV8h6dBFBh/ZETWfib7yosPlsgpMSC0np1xekBnNDawwVD4wGa+NSVdQ6rBrCXsHc3R5gwqkPHljheufV04HRcIHfvaxMn/CxT7PEIxwOdcmckthQZJllsSmmoHwMyzklXbp5TBHFAI8z48A4V0oZrAmz0WQPLKPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXsrAcSI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8rTNQETu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Mar 2024 10:22:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710325357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/ncNhPA6ZIAkn7Q6/N7SXfEFiDYEuIPvqhLKjXMVuk=;
	b=zXsrAcSIyEBajCRpZxpKT3ZSH7TG4RTNjRePEuK7ZGyq7+GSfoxWN+Qk1YZA5o6BxxMiHU
	Lbv6mkjE6aMJRehHEDJn1f9DKKQ1lZdhuFV2no7pBVNy/KfpzF129Z2/zkkKHPV+Ry/IPe
	0Wuhw23l73EKPVfrUcPhdE2IqlGQMp/yLSQSAjrP9sp+4ew+6K4eoIhiUcAu4jqiDlIVkI
	OS0ORQZ+P2nlBCNIhS6GDvfm23zyBDqDSWtVZ/MBwjpADZagtPLkHDQHEpNf+A4xF87wVU
	Yoq50BFWC4CqTQsysHOxu2vBgby3kY6U+jJI1Noi6rJlww4d7F8r+pwsMCHQNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710325357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/ncNhPA6ZIAkn7Q6/N7SXfEFiDYEuIPvqhLKjXMVuk=;
	b=8rTNQETuOOzTdAHpCtL2qXrLIvxlK7j9ZlahcfsG3NcUTEMNakCgmZD6xKBLvVUOZG51o7
	3XoRUuFoEHtVoqBQ==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/x86/amd/core: Avoid register reset when CPU is dead
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C550a026764342cf7e5812680e3e2b91fe662b5ac=2E17065?=
 =?utf-8?q?26029=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C550a026764342cf7e5812680e3e2b91fe662b5ac=2E170652?=
 =?utf-8?q?6029=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171032535648.398.6298108731990613596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ad8c91282c95f801c37812d59d2d9eba6899b384
Gitweb:        https://git.kernel.org/tip/ad8c91282c95f801c37812d59d2d9eba6899b384
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Mon, 29 Jan 2024 16:36:26 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Mar 2024 11:01:30 +01:00

perf/x86/amd/core: Avoid register reset when CPU is dead

When bringing a CPU online, some of the PMC and LBR related registers
are reset. The same is done when a CPU is taken offline although that
is unnecessary. This currently happens in the "cpu_dead" callback which
is also incorrect as the callback runs on a control CPU instead of the
one that is being taken offline. This also affects hibernation and
suspend to RAM on some platforms as reported in the link below.

Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/550a026764342cf7e5812680e3e2b91fe662b5ac.1706526029.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 69a3b02..aec16e5 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -604,7 +604,6 @@ static void amd_pmu_cpu_dead(int cpu)
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
-	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;

