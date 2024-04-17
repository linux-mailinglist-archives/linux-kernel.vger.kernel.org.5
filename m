Return-Path: <linux-kernel+bounces-148450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9B38A82C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391101C20AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86FF13D285;
	Wed, 17 Apr 2024 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hQF3Xqos";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oyDLGoHA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C397413CF94;
	Wed, 17 Apr 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355645; cv=none; b=VS7kt9pQDUsE5UTJOnoCSNOBdSr16EOu5/agbE3mCEZ3KYWiLUS3PVcz50z++GfAgA1CHj2Z/Glt5n5T9z74I8+TRl6uGM8sX50mhN038TrxUf2SSJqkf6KXclosME+LTNl/9hHMMvZfD/Jz0TAwKmQ32eYxL8aVZb81fRarJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355645; c=relaxed/simple;
	bh=24wbGBocfEvHtoYwR/79AhSigJ2aupjGUEw2K9rqts8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oSd3+xkiAckOM8ciR02wv7elDkXVfrTFH+INsZDuyCwJMGEYoEsXEp717KEjFBR5gOw7xU6KHs/xlznouPUn3ApqaT8FBVph3I4qxSzu5a8NLuGpxUc3rvmpC+rCnlCRgtBAcPujHvZDsbG5EprLfxexMsOmVS2OOEghjLhmHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hQF3Xqos; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oyDLGoHA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Apr 2024 12:07:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713355640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAW4fQqopXztQJ2YMRJYU7sRqbHQFRiwyCjuZskkHkM=;
	b=hQF3XqosQUlCSNJv1P16Df4CSOTluWIxAzniyP6kngsx47MpKELHMFL8dQnnr/dh0VdkKK
	nbU9D/IWdVNfehDK3K5pWV7jPTrNdgXN4cyZdmPbTyl496KQKaAjwMaUni06vmIzEada6G
	5KbTQIOA6qIc7EoYcB++bOPXL/eu7nVQgrUaXseQyuXSvtgzludSXhCY0cI/xDBSxSmYq1
	bv+sH/JNas2zfxRAtlsvECBkOO6lM9r7Yaj5geEICh87HRIpybCx13PBZHPJOhW0NlG4HR
	AIcvPMzlOIRaxM+RfVnMTPyqOJezlJsD549J65iBs3tpUXD1IKNTWOwLL+9tlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713355640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAW4fQqopXztQJ2YMRJYU7sRqbHQFRiwyCjuZskkHkM=;
	b=oyDLGoHAg2oY8liXX3VWcqb2jLP7J0PPMa/Wjj3AS2v+RI2fXurr6Cta+gMwcYlenpMpsM
	fjohz9RKXwPieXAg==
From: "tip-bot2 for Alexander Gordeev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/vtime: Do not include <asm/vtime.h> header
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cf7cd245668b9ae61a55184871aec494ec9199c4a=2E17127?=
 =?utf-8?q?60275=2Egit=2Eagordeev=40linux=2Eibm=2Ecom=3E?=
References: =?utf-8?q?=3Cf7cd245668b9ae61a55184871aec494ec9199c4a=2E171276?=
 =?utf-8?q?0275=2Egit=2Eagordeev=40linux=2Eibm=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171335563971.10875.13309363611097274996.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     08a36a48544d73bf153960245aec6c5fa23960de
Gitweb:        https://git.kernel.org/tip/08a36a48544d73bf153960245aec6c5fa23960de
Author:        Alexander Gordeev <agordeev@linux.ibm.com>
AuthorDate:    Wed, 10 Apr 2024 17:09:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Apr 2024 13:37:23 +02:00

sched/vtime: Do not include <asm/vtime.h> header

There is no architecture-specific code or data left
that generic <linux/vtime.h> needs to know about.
Thus, avoid the inclusion of <asm/vtime.h> header.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Link: https://lore.kernel.org/r/f7cd245668b9ae61a55184871aec494ec9199c4a.1712760275.git.agordeev@linux.ibm.com
---
 arch/powerpc/include/asm/Kbuild | 1 -
 include/asm-generic/vtime.h     | 1 -
 include/linux/vtime.h           | 4 ----
 3 files changed, 6 deletions(-)
 delete mode 100644 include/asm-generic/vtime.h

diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 61a8d55..e5fdc33 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -6,5 +6,4 @@ generic-y += agp.h
 generic-y += kvm_types.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
-generic-y += vtime.h
 generic-y += early_ioremap.h
diff --git a/include/asm-generic/vtime.h b/include/asm-generic/vtime.h
deleted file mode 100644
index b1a4967..0000000
--- a/include/asm-generic/vtime.h
+++ /dev/null
@@ -1 +0,0 @@
-/* no content, but patch(1) dislikes empty files */
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 593466c..29dd5b9 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -5,10 +5,6 @@
 #include <linux/context_tracking_state.h>
 #include <linux/sched.h>
 
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-#include <asm/vtime.h>
-#endif
-
 /*
  * Common vtime APIs
  */

