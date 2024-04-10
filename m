Return-Path: <linux-kernel+bounces-138751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D8889F9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE949282632
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B56116D4D8;
	Wed, 10 Apr 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nPNG93Qb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hemBqPvG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A44158D70;
	Wed, 10 Apr 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759483; cv=none; b=R85gJ9/ipkBvcXj+O0khp9K6VKygIJNWXikJn95elwCXkZCJupwoomz47w5RUAym6ai5xTLddgcf1P7WDA53tTJ7+JQ41iCqcWFt5/5+PLmNZTMB4prLb2A61a1t9/N4vyaviE8GqPIdlPCz9thuT9Naan9r8rK4Y0Ub3GFMNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759483; c=relaxed/simple;
	bh=DnlVN7F0de0eJH9mE1+52DEgW2DBXct6it/rcLENdo8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b9Gp6eKbCxY552bwsPCqL2OzN1lQ3BVbXaJUU7irZbh9Gaj23dNho5EGbKeCfrdGCA0LusoM2UjeMAwNqekwF+tsrkuxJtmMQGoUamhF/0OuInO9+MlUWJ8WlNHwdgR4zD+/jcidaXKzBXbkXD0bIxLjns15kdZmwqHIHtB/mCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nPNG93Qb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hemBqPvG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 14:31:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712759480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYX3zOm/lIqRQk8fDRkW2GWS1VHCXhoLB5o/wti6kvQ=;
	b=nPNG93QbP0fPVVpMZaLoHazEJtZbvlMsiQYpY6iG3gWMaW3f6fl1LFnG2wCuae7T2M5iPn
	Q601OjlPIU2V8sMTt/zz8PyvZ0km8CqO929XRvzB+TjrzK5+sbQkndEADyhU3UQ1clqGcD
	zrkaa33tqIO3qMUAY60RiO59PNaOiCmuYf0SlGJ2znxvnPUjsBgMcQxB29CtkTd9cYhxEb
	iLcQITw5BttSVW8JRk3qu6VcJAizo9uPH0/uu5nCm8/3DslJEBhHsr5q8tpZAB3ZwOHPAo
	W7vKMO9fZ1OJokuP0uNdB/05f6SH3+T5d3SopSqHWewr/Wlwcz905DBa6/h68w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712759480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYX3zOm/lIqRQk8fDRkW2GWS1VHCXhoLB5o/wti6kvQ=;
	b=hemBqPvGmAbfVuElinRXHyAgQK40Y6ytWEVfaoZ94knsNwMolk1OgxDB3hNzbXix3ER+p7
	ThxwcTD5qPTCBKDA==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Disable BHI mitigation by default when
 SPECULATION_MITIGATIONS=n
Cc: Sean Christopherson <seanjc@google.com>, Ingo Molnar <mingo@kernel.org>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>, stable@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240409175108.1512861-3-seanjc@google.com>
References: <20240409175108.1512861-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171275947899.10875.3224050314165203955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e8f2ec1cc10e86adfc2089fb93a1158e69989bbd
Gitweb:        https://git.kernel.org/tip/e8f2ec1cc10e86adfc2089fb93a1158e69989bbd
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Tue, 09 Apr 2024 10:51:06 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 16:22:56 +02:00

x86/cpu: Disable BHI mitigation by default when SPECULATION_MITIGATIONS=n

Rework the initialization of bhi_mitigation to use positive CONFIG tests
for the ON/AUTO cases so that lack of *any* CONFIG_SPECTRE_BHI_* #define,
i.e. when the kernel is built with CONFIG_SPECULATION_MITIGATIONS=n,
results in the mitigation being OFF by default, not AUTO.

Per the help text for SPECULATION_MITIGATIONS, the intent is that 'N'
disables all mitigations.

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240409175108.1512861-3-seanjc@google.com
---
 arch/x86/kernel/cpu/bugs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 27f5004..7e4a706 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1630,9 +1630,9 @@ enum bhi_mitigations {
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_SPECTRE_BHI_ON)  ? BHI_MITIGATION_ON  :
-	IS_ENABLED(CONFIG_SPECTRE_BHI_OFF) ? BHI_MITIGATION_OFF :
-					     BHI_MITIGATION_AUTO;
+	IS_ENABLED(CONFIG_SPECTRE_BHI_ON)   ? BHI_MITIGATION_ON  :
+	IS_ENABLED(CONFIG_SPECTRE_BHI_AUTO) ? BHI_MITIGATION_AUTO :
+					      BHI_MITIGATION_OFF;
 
 static int __init spectre_bhi_parse_cmdline(char *str)
 {

