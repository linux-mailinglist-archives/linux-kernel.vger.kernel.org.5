Return-Path: <linux-kernel+bounces-160550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AD08B3F04
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE511F235D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3DB172BA7;
	Fri, 26 Apr 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZF78jg8G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3D+0+37Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CFD16F8FC;
	Fri, 26 Apr 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155137; cv=none; b=V86/v7iYoRHPHD3vLz4GGZ/h5D5rd6Ys3RXTcveKrW7q6uWQt75t6QTEiSrCXq7H9OaGX2vaRR/jQB/FnG5GIRLyJ5txQiOVeDCtqNrDanHqVf23k+CT2/bSxbqw+3/SVwYgdkJMioJmKSgvur5FVq+0zz4ctgVor8klzTn5gHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155137; c=relaxed/simple;
	bh=jSY0nA+ROhRqTnRhQs/ve/+tyARjxDRZJy8Uj4HGnYs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=dysJfUKrnvGqfvQT+SBkd+lAa7gJaHknGyvAhwX9P1Zj0gfjRiGFAEXY/thOJGOpjnX4cPnZtLxOaD2Ha0rKUFCMrgAcP4SQtmKC+rqDkw7xq8RHt2Kol5hkHMkCdzKI7lSXWP/gnF1hOofjZ6x66xQ05uwfAAJ9XNzWyxvPjlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZF78jg8G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3D+0+37Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Apr 2024 18:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ycy0ZFmdvZj6/8voNpxWj0nxNZyEC+RHC/uTiGiH8fQ=;
	b=ZF78jg8GLjrUCcsknwUzQ6r9f0N8RGtckQPHgWSQCFGf2JIR3if/z0N4oyp31Wq6aVGD5k
	qCVwk8gq3OtvDj2BlOs7q6a229bdzto+aX3iaiPaLWio42bUXSopkbYDZKvukM91bMp2l9
	W1wp8jNcxSpXD2S0PN+rBsK6YBRXhgG+bN54qHkrmiCN6g30MmUO2PPQMEdk+4Ih51YNJk
	pfUsYAbqOw7kJ+w/6oF/W5Fvtfb26dbFwl2sUE4cAsC6IHRDGlsRIyRkxGsOFxOP13Ao1k
	KE08h7T3dhbtyiyqyKTyI2+WZdDcyOZWaEM0qpvt0VrGlLP7S0e4yRuILpeVCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ycy0ZFmdvZj6/8voNpxWj0nxNZyEC+RHC/uTiGiH8fQ=;
	b=3D+0+37QP47isYVb1frGSRKSTNhainvlurRJ/UEsxukpyuM/g+tH80d6tcNNny+Qgp/4fa
	j3msJerv/nm+UQDA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mce: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171415513142.10875.5506937113869096290.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     066f54e65e47b3b35ecc79c2fe934e0867ffbe2f
Gitweb:        https://git.kernel.org/tip/066f54e65e47b3b35ecc79c2fe934e0867ffbe2f
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:11 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 26 Apr 2024 08:49:24 -07:00

x86/mce: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181511.41772-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 771a9f1..ad0623b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -47,7 +47,7 @@
 #include <linux/kexec.h>
 
 #include <asm/fred.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/traps.h>
 #include <asm/tlbflush.h>
@@ -1948,14 +1948,14 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
 			cfg->bootlog = 0;
 
-		if (c->x86 == 6 && c->x86_model == 45)
+		if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
 			mce_flags.snb_ifu_quirk = 1;
 
 		/*
 		 * Skylake, Cascacde Lake and Cooper Lake require a quirk on
 		 * rep movs.
 		 */
-		if (c->x86 == 6 && c->x86_model == INTEL_FAM6_SKYLAKE_X)
+		if (c->x86_vfm == INTEL_SKYLAKE_X)
 			mce_flags.skx_repmov_quirk = 1;
 	}
 

