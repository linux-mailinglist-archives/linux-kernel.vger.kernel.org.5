Return-Path: <linux-kernel+bounces-137925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F4089E9A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDFD2828DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBEE14A8C;
	Wed, 10 Apr 2024 05:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D4tAizNg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ldoNL6F5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDC1125AB;
	Wed, 10 Apr 2024 05:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726591; cv=none; b=hsYE6V5T6cpPuaU1vkU/u5PtIYRCwtLu5LsAX7/iIklioetcmOCyU5fljGtZQpW6B2Irvl32yS7Zlf0B9B4XkGpwB0VNve2yYaEO6+H/L6ZwSWa6iLuLxBtxQWxh5p7VAPaBLznevR77HR74Olk9NPE6XLdGYReQdt6wjpztOO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726591; c=relaxed/simple;
	bh=sFW4g/GlCSa29hoT2id3kKEoGwTb0Z67PNyuQD2hKGI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dgPX8bVTWt1VyNKayMltRHY9A8sCPnZ39qM10s0EDpuxtuZkloLDFOftpVokbflEiKFhCuTKd2xuO+LIzpjkSBDzcZQnzuc5IHRpMh6xOdcXOODQmUVGgLRqoMJMGsJvX0aEnjxMxVAE3pNeR9u9LHgV6XrNZmrXTVCJ7OUDSjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D4tAizNg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ldoNL6F5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 05:23:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712726588;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6Ma79hgeYbSHKbnD3RPxbkHFR2RTl34dogW1CdqCIM=;
	b=D4tAizNgrgXr1QWO6hs/lZmHyq//2jI2P38qJVZq1aK7qEn8Q7+l2AfCDFi3jqKIHRfBpW
	vXrqdpcf1bPNA7bpD7wsKU2wPkrgzLgPLz7ZdXT8ZtXd0vu+wqx9VRKUDNvmeZofVbtD3j
	zExUBKNjG9VQ3eKm3yRJNazchY79ki09HkUwFfKXUIn7MroKuERGwWQHMpcHF9aVKswP/8
	yUiFsY8yaDGWdm0r3mwygrJ+nEdCEFhvdJFOc3cesi0YkcYfN7q+RQeqX86E5FrpjUCA85
	KcVZJNtiG9K2LxVmlM7spcaVBXGjNYR3gmTc/sY95WFxmKxNkJ/SuN+BFJVSlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712726588;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6Ma79hgeYbSHKbnD3RPxbkHFR2RTl34dogW1CdqCIM=;
	b=ldoNL6F5hufi/hFljOZeEyMUBVZVDXDTzvUAtKXD/Od7puL5w9T9t/Q0CeCWrOs8CxgNdz
	n9OtMDkC77WXA3CQ==
From: "tip-bot2 for Daniel Sneddon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Fix return type of spectre_bhi_state()
Cc: Sean Christopherson <seanjc@google.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240409230806.1545822-1-daniel.sneddon@linux.intel.com>
References: <20240409230806.1545822-1-daniel.sneddon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171272658701.10875.7339711766368299622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     04f4230e2f86a4e961ea5466eda3db8c1762004d
Gitweb:        https://git.kernel.org/tip/04f4230e2f86a4e961ea5466eda3db8c1762004d
Author:        Daniel Sneddon <daniel.sneddon@linux.intel.com>
AuthorDate:    Tue, 09 Apr 2024 16:08:05 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 07:05:04 +02:00

x86/bugs: Fix return type of spectre_bhi_state()

The definition of spectre_bhi_state() incorrectly returns a const char
* const. This causes the a compiler warning when building with W=1:

 warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
 2812 | static const char * const spectre_bhi_state(void)

Remove the const qualifier from the pointer.

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240409230806.1545822-1-daniel.sneddon@linux.intel.com
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2954637..27f5004 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2809,7 +2809,7 @@ static char *pbrsb_eibrs_state(void)
 	}
 }
 
-static const char * const spectre_bhi_state(void)
+static const char *spectre_bhi_state(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_BHI))
 		return "; BHI: Not affected";

