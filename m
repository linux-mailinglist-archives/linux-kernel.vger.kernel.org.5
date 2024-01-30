Return-Path: <linux-kernel+bounces-44922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A23B842919
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA6B28435D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA24129A7F;
	Tue, 30 Jan 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lfF+DvIT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hRkx7xq6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E6F1272D4;
	Tue, 30 Jan 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631961; cv=none; b=k9fNZqRzMLLAUTlAiiP7nE8+xLJ+EpEUc8FHgYwxwrQX7xPl9hKEcKjXw3HPICFn8UMjSgG1L1Mz8dpMdU1utMq6LeybE5DxZS0WJGjLpSeImkwIBVgXgocsCtkJcPVmZCrcVgz2ZOS1NXM8C4snBJ3359QvnDf09KSSZ9X1pEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631961; c=relaxed/simple;
	bh=MQoxtUL+PJp8Jvb5+0OwOji7jZqnVAujKXvnVQiE8Pw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lerDjMdSLj+4dhJYHyhCq/3zicGH8WHxLq0Ek6/EMI7eAlczon2km5JRrryvVEOEdd2Yy+Al/gRVunUrOG7DNVQfzd7g3NcXIYqtUitMk5PO6fnJeojDGajB6YVOMVtMugmGgGWEqwDTeyQZFMuyxDx3gMIToW3BCM27mQUUmcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lfF+DvIT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hRkx7xq6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:25:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631958;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZrM9m4TO/HyPoXRJrWrXkINV1Hzr5RtSOTqRMvCMgg=;
	b=lfF+DvITrzP+Bq+wKvrpPUREGAmPmlSY+jIPnr2TqIBp3gBzm3ayYT2ffT60tGflxrxSTp
	bD0PMHr6rUPo3pdsT6qNkawXTlRh3Zqdk9lmJRkamWkeeQE/A4OW4tQnm67LA+NycP3j8p
	OkA9//wYn/lEdqZvrTHNY3MJGp9EqU+1FeYpBwxfirAhQyJquTbUasnuz1N2YPg+s7q9+O
	eWzI+/WTvrsyn4/14A08AG8UX+6VM/NHf8/jKMsDztad0HRMlunG8kVRG73BsRISPmUwvL
	RNVRogywbAdU/Xtj3XIwIKQYCwkNh8kdoBTuBvEaP5KOY/WSNL+/fgmliunC0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631958;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZrM9m4TO/HyPoXRJrWrXkINV1Hzr5RtSOTqRMvCMgg=;
	b=hRkx7xq6o51QhIns8D6htHAb6lYggpjI4zNxLYFNmJdOC53l4XJOH5921cWDRh37YRgMuy
	tplG6Nwi39reQLDw==
From: "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/cpufeatures: Enable/unmask SEV-SNP CPU feature
Cc: Michael Roth <michael.roth@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-23-michael.roth@amd.com>
References: <20240126041126.1927228-23-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663195756.398.9260239005987391538.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     c3b86e61b75645276aa2565649a6da5d6e77030f
Gitweb:        https://git.kernel.org/tip/c3b86e61b75645276aa2565649a6da5d6e77030f
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:22 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:19 +01:00

x86/cpufeatures: Enable/unmask SEV-SNP CPU feature

With all the required host changes in place, it should now be possible
to initialize SNP-related MSR bits, set up RMP table enforcement, and
initialize SNP support in firmware while maintaining legacy support for
SEV/SEV-ES guests. Go ahead and enable the SNP feature now.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-23-michael.roth@amd.com
---
 arch/x86/include/asm/disabled-features.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index fc13bf7..3332d29 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -117,7 +117,11 @@
 #define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
 #endif
 
+#ifdef CONFIG_KVM_AMD_SEV
+#define DISABLE_SEV_SNP		0
+#else
 #define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
+#endif
 
 /*
  * Make sure to add features to the correct mask

