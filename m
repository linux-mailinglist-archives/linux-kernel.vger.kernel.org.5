Return-Path: <linux-kernel+bounces-117255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE888A937
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836721F617CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029E6159918;
	Mon, 25 Mar 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v8O4fvRw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8O8P4Q3P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09AD1598F6;
	Mon, 25 Mar 2024 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376944; cv=none; b=sv5NWB1KFTpRxzu6xQWJvfRmJNjLztaPkFb4gUEUsKpy5Xy9hxsN6z8wBalt7qI/cFdmr00xETViIFWNlUUf3w16bxNgBM9JCcJ7teVeGU5qc5BGWph5CvcsRsCmlVyTSs3X7j4iSk2Od9QKCUJtdkws9pjLQq/abCcZspTdsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376944; c=relaxed/simple;
	bh=UxKX4UhVrOAnBC4MDQX+O6HB2KiBGEMlXPbZ39WIHiM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lBLygNgtHdhhIPNCgODUZgduVvdzuISkSvsoV9FpRhY1DMJJZPpIyNxGQkgtQcDejsG3YkWWTuWCqKjjMCMLKNHasEz5DJFm0+ZnsJyJXhccI5aD3ENlmVjtP9VAgCkmX3tntQGCtFgVRmPOrTmIyTVFWUmu0TGxOPLA0G/uLnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v8O4fvRw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8O8P4Q3P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 14:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711376940;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHsuH3Kbcge5Opsyc0uGjuVaFJ98ERBpPpFpXxaQpwU=;
	b=v8O4fvRwF66mUjH/c1q/Q7RIp4Bv5QR/GnKVEpSGGhQA588uJaXfHfvmS25fW5J21RME3o
	LiV6nQAvyVZXzghaCGuTspen7pm5WCkTGEegc7ZN+hXExCPrdlP2LY58gpoYkaPE8JmQrT
	//sBjpe+c5j193/v98LvUO3XkyLpHTE9g7i5IyPLZ/YM27sTdCLXnA9z9E+2KUZ1jVIUZy
	gfcV/9mDKDYh4+m87WQxUzzJGl8RrgxXOaCauRNLbgl4P25JIm1MTOWm+n7cpAX5xLjXgF
	uqUi4boCu7SSIG06vqxvILpiOTQrCicp6/1kzJRu0qTngZTirL54Ow7vF9c6rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711376940;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHsuH3Kbcge5Opsyc0uGjuVaFJ98ERBpPpFpXxaQpwU=;
	b=8O8P4Q3PovKbzM/57OUqj/KRxsk193HxrR8VOm8oH2X7F4a3RAB+k5MVrEDNk2xnthHjpO
	lI4kHSBpjjzeN2AQ==
From: "tip-bot2 for Yuntao Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/head: Simplify relative include path to xen-head.S
Cc: Yuntao Wang <ytcoode@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231231121904.24622-1-ytcoode@gmail.com>
References: <20231231121904.24622-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171137693961.10875.2329693946022715442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     c3262d3d19d2d42705334e40d9c731c2a5df9eb5
Gitweb:        https://git.kernel.org/tip/c3262d3d19d2d42705334e40d9c731c2a5df9eb5
Author:        Yuntao Wang <ytcoode@gmail.com>
AuthorDate:    Sun, 31 Dec 2023 20:19:04 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 25 Mar 2024 15:24:10 +01:00

x86/head: Simplify relative include path to xen-head.S

Fix the relative path specification in the include directives adding
xen-head.S to the kernel's head_*.S files since they both have
"arch/x86/" as prefix.

  [ bp: Rewrite commit message. ]

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231231121904.24622-1-ytcoode@gmail.com
---
 arch/x86/kernel/head_32.S | 2 +-
 arch/x86/kernel/head_64.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index b50f364..78a6570 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -500,7 +500,7 @@ __INITRODATA
 int_msg:
 	.asciz "Unknown interrupt or fault at: %p %p %p\n"
 
-#include "../../x86/xen/xen-head.S"
+#include "../xen/xen-head.S"
 
 /*
  * The IDT and GDT 'descriptors' are a strange 48-bit object
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8198fb..2f8a594 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -720,7 +720,7 @@ SYM_DATA(smpboot_control,		.long 0)
 SYM_DATA(phys_base, .quad 0x0)
 EXPORT_SYMBOL(phys_base)
 
-#include "../../x86/xen/xen-head.S"
+#include "../xen/xen-head.S"
 
 	__PAGE_ALIGNED_BSS
 SYM_DATA_START_PAGE_ALIGNED(empty_zero_page)

