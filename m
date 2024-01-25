Return-Path: <linux-kernel+bounces-38562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3774883C1A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E468828E301
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A936B0E;
	Thu, 25 Jan 2024 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R7ouKmoa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MDUzv9m5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB33589C;
	Thu, 25 Jan 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184360; cv=none; b=AksamffxEJOYoUae1MPMMRtIqLG1jMkj2VEofSS+1b6jUpZpPGL2fmMaIO4BuErQu5qS4ejuBrhy8JUFkwpJoyFUxLiPUB2iczhVNCK2Gi9CCKqf2ZmIFftUc5OzML9v3/WheNuegGtbHQhEkZWTuNnHUBVdV4ObiPtgXFGPEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184360; c=relaxed/simple;
	bh=lt+OF+4UNnZg1c3qaRm5E/ZAZAx+EIVd0cV2DOcXNZ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T8J5WVMo28YP94nCyximnx829tdGn3CqM9z+Ul9MVbTONIPbwSoPSfwIRT+y8mtrzYnzjE8eDPzhnv4WsCK243FScQkwnRpvEYF1BOvgU0SymqyUGiEShhTCCBGdBXGOqe2fhhya5FJYwzh/coM6KFsCf7YVV871WIR9r/Xqg1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R7ouKmoa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MDUzv9m5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 12:05:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706184355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBPORmsO/XzimUu2HpctLujPcqLI8Zbxm+wJVG80IR8=;
	b=R7ouKmoaORvaGV0EUGxsXrCzX7ETh2LMVltYP0pEJgElR+QioFqCBCvovI3peI8GbD654f
	yPRjTbE7/x++D04DsdN0OvpLDXn3g0De/NJoSUxd44FyoKbWIk1M/VrHLubOSDU2rxqLRe
	oAojh0jAkLIDdw2NCEjrj2N8T+5SdJRxMVxhAJkcpWfcyrnDQ9KWlozGQorD9bYyCrHB6T
	tquvLd++ISJ7ZpQ9bCP/kBqNkQzeLStIMLiKqg6a5aDbZvrPempX5M+CX7DWDnjzYIJyyp
	C+ZjTpCyevxgK2+t+H6E8EEEDZ0uFv/EaYXRMz0yByoMqpC1p4tfaakhZIs5Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706184355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBPORmsO/XzimUu2HpctLujPcqLI8Zbxm+wJVG80IR8=;
	b=MDUzv9m5x2Kr+285kw2jOuSaV4gvWK/0unFRpjcgxst/CAG9nBdvul3iTg8ubjTya3KUQJ
	4d4sTXuAIaESZhDA==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Add more models to X86_FEATURE_ZEN5
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240124220749.2983-1-mario.limonciello@amd.com>
References: <20240124220749.2983-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170618435416.398.10999476782072696923.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b9328fd636bd50da89e792e135b234ba8e6fe59f
Gitweb:        https://git.kernel.org/tip/b9328fd636bd50da89e792e135b234ba8e6fe59f
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Wed, 24 Jan 2024 16:07:49 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 25 Jan 2024 12:26:21 +01:00

x86/CPU/AMD: Add more models to X86_FEATURE_ZEN5

Add model ranges starting at 0x20, 0x40 and 0x70 to the synthetic
feature flag X86_FEATURE_ZEN5.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240124220749.2983-1-mario.limonciello@amd.com
---
 arch/x86/kernel/cpu/amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index bc49e3b..f3abca3 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -573,6 +573,9 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	case 0x1a:
 		switch (c->x86_model) {
 		case 0x00 ... 0x0f:
+		case 0x20 ... 0x2f:
+		case 0x40 ... 0x4f:
+		case 0x70 ... 0x7f:
 			setup_force_cpu_cap(X86_FEATURE_ZEN5);
 			break;
 		default:

