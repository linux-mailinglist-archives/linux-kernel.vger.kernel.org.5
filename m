Return-Path: <linux-kernel+bounces-68815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A94A8580A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC6A1C20B77
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C072B138492;
	Fri, 16 Feb 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fbmX1Pjz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="au5Pbws9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D365135A6A;
	Fri, 16 Feb 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096630; cv=none; b=PRJCt2ETOT3WGcoHMAsF8s2X5hP1Ml1Jnu6GphpcgaeQMxTaN0Im8eEZn/pJvxPIFZQ/sBMLql55mZddLmhqEjPwEGJDlLwVTuiksKBd8vMDkihPbKNodmw25GqzG0bVxyiDhnC2Llwsp5eALtG2zI3SPjTeMkMVbErIwhuOwq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096630; c=relaxed/simple;
	bh=reeE0IXgN5cS+pbrBjwrRWeryJNTK2tDGL+DxHmgEaA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N0JcRDFr758csOsgaYvs+bNZDbcmJbWO92L8y+YSf9G2PJbbSO2cyi/BvsmlVMI0SEd1KKfR+k3WRwZl8/hIhJe37R8+I9IV760YwhIFmVh+ebTNdJaXNkXvZwl/4feDMnHFXbOcDppLS4mcV4AngM8UvLlmrfgeizT58E3E3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fbmX1Pjz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=au5Pbws9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwNwCQt4ZVuTypbVsBSMWfLlHk0glqJObtImo6yj+eU=;
	b=fbmX1PjzKlQ/P5iRJ9Yh1cDjpKAc0ArrFupUfgS+m+o7GZdnUH60Wca7ettUC5bS+J7wsl
	bWV7km4tEQ+cPuM/UC480zAkkypmwrQ7hBPEpDFvENVzf3k9AMOv5tuJ4wEJdAhfji2H86
	a0FEgL2hW/YOUktL+Z3ly+gNSP0RVs+Q2zkWNw5bngM1FXmFRtx/V67l0Q5Us0VIbJzC+L
	5xxZ4jIvQI0w5Y8NyMyleeLHN9YZTobxazIBS5FKRik9yeTAb6YVoddjQ9w2jSOkLeYc+5
	Tz6lNETW10yAgG2igz+TmIME9dDD+ro59TQDQW8ajDc4gDuousiSBVqbXV0kFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwNwCQt4ZVuTypbVsBSMWfLlHk0glqJObtImo6yj+eU=;
	b=au5Pbws9J294u1dXNfDGFdafvhV/3aEFEkt90aYXz/wQzrtggwdy00HID1xGghBfpxPJWn
	qmxLKuqjC28VyyAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/of: Use new APIC registration functions
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210251.776009244@linutronix.de>
References: <20240213210251.776009244@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809662632.398.13034441289371547401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     7d319c0fcae68e489fcf806cdea46a795062eaf7
Gitweb:        https://git.kernel.org/tip/7d319c0fcae68e489fcf806cdea46a795062eaf7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:42 +01:00

x86/of: Use new APIC registration functions

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210251.776009244@linutronix.de



---
 arch/x86/kernel/devicetree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index c05b900..4aeafe6 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -136,7 +136,7 @@ static void __init dtb_cpu_setup(void)
 			pr_warn("%pOF: missing local APIC ID\n", dn);
 			continue;
 		}
-		generic_processor_info(apic_id);
+		topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
 	}
 }
 

