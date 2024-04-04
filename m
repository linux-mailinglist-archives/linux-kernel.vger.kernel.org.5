Return-Path: <linux-kernel+bounces-131152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9AB8983C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9982B287F17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D030C745C4;
	Thu,  4 Apr 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lPhqarTD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIDrA7tY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5E74405;
	Thu,  4 Apr 2024 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221880; cv=none; b=CoPCT5nJSAP5MvVIMn3Qqv2wWr+9mZRMzp63uApNtcDgLGOpd8Bsate1HPU5jAl211T5XJ9Whx/RgGnFKBE8716hfpIUJwgALkz7eCkBmwXYpLjr/mK0xmXCJ9Z3mW0XPKUZgQGxCaNF0VNflfq0yqutkzneQ7GrDypaF31JQb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221880; c=relaxed/simple;
	bh=sSiAHnCYkMAb41uzqPX+bVFr0C/dLkqAWl3jCy0fZ9Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mkfdWzp+Ohku23/GTibG9Dh598U/Lc1cGO3jwfunhPfydKXiBzPGG1njk2vyI+GpByELJikpl6UuZtRmL7VIbpcdRfYXjStxWUV1U3QpbFBsCLvFpI9rvYmY4BD55TREGCovqJdYB3yzfZ+vY3Y2ht76fajeQ8+iAodXKe4M3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lPhqarTD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIDrA7tY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Apr 2024 09:11:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712221876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+LRvHTpnOJnw49qH5A279TkC00i92hA34WqJSFN1GI=;
	b=lPhqarTD0ara8iv/wt6nADF9NK1k0j7bmvEQn3Qruo3VLMRrkQR8nk9aew383NsJZRgM0e
	7K5WqksXS+7g9f/KpVs2t9crI5q5/g6s77hMaK8Wpkbgrlt2UdZu8PuU8nFElamPwsMgZ0
	enq8kLKjE1pPk77DvSp0cJwQ15rmeHLtBWU4H8touyK06zl5xXz+3QW44Y5NLfTFBVKnUG
	QJwavA367GfwuxTtkXgVhAcpBeH9DCbfUS/I0iZpCXTsFlE24dgXO9Aq/nprjH5Exiic6x
	cEw2YXbfKbaGalC622t4uxudhX5s/cma6JJy9vQMi82ilXJCnBnKAZQG1MJnTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712221876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+LRvHTpnOJnw49qH5A279TkC00i92hA34WqJSFN1GI=;
	b=TIDrA7tYCHfeSiemTWu3K0BVuz2g/hQNHPMCCur9/H97ylxfXlm5Af+2VON1PjTjXnV+tS
	HnEvrc8kt55ofJDA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cc: Add cc_platform_set/_clear() helpers
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Srikanth Aithal <sraithal@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240327154317.29909-5-bp@alien8.de>
References: <20240327154317.29909-5-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171222187533.10875.12139303211259990842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     bc6f707fc0feec72acc2f49c312eb31d257363a3
Gitweb:        https://git.kernel.org/tip/bc6f707fc0feec72acc2f49c312eb31d257363a3
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 27 Mar 2024 16:43:16 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 04 Apr 2024 10:40:27 +02:00

x86/cc: Add cc_platform_set/_clear() helpers

Add functionality to set and/or clear different attributes of the
machine as a confidential computing platform. Add the first one too:
whether the machine is running as a host for SEV-SNP guests.

Fixes: 216d106c7ff7 ("x86/sev: Add SEV-SNP host initialization support")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Link: https://lore.kernel.org/r/20240327154317.29909-5-bp@alien8.de
---
 arch/x86/coco/core.c        | 52 ++++++++++++++++++++++++++++++++++++-
 include/linux/cc_platform.h | 12 ++++++++-
 2 files changed, 64 insertions(+)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index ddd4efd..b31ef24 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -20,6 +20,11 @@
 enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
 u64 cc_mask __ro_after_init;
 
+static struct cc_attr_flags {
+	__u64 host_sev_snp	: 1,
+	      __resv		: 63;
+} cc_flags;
+
 static bool noinstr intel_cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
@@ -93,6 +98,9 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_SEV_SNP:
 		return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 
+	case CC_ATTR_HOST_SEV_SNP:
+		return cc_flags.host_sev_snp;
+
 	default:
 		return false;
 	}
@@ -153,6 +161,50 @@ u64 cc_mkdec(u64 val)
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
 
+static void amd_cc_platform_clear(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_HOST_SEV_SNP:
+		cc_flags.host_sev_snp = 0;
+		break;
+	default:
+		break;
+	}
+}
+
+void cc_platform_clear(enum cc_attr attr)
+{
+	switch (cc_vendor) {
+	case CC_VENDOR_AMD:
+		amd_cc_platform_clear(attr);
+		break;
+	default:
+		break;
+	}
+}
+
+static void amd_cc_platform_set(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_HOST_SEV_SNP:
+		cc_flags.host_sev_snp = 1;
+		break;
+	default:
+		break;
+	}
+}
+
+void cc_platform_set(enum cc_attr attr)
+{
+	switch (cc_vendor) {
+	case CC_VENDOR_AMD:
+		amd_cc_platform_set(attr);
+		break;
+	default:
+		break;
+	}
+}
+
 __init void cc_random_init(void)
 {
 	/*
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index cb0d6cd..60693a1 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -90,6 +90,14 @@ enum cc_attr {
 	 * Examples include TDX Guest.
 	 */
 	CC_ATTR_HOTPLUG_DISABLED,
+
+	/**
+	 * @CC_ATTR_HOST_SEV_SNP: AMD SNP enabled on the host.
+	 *
+	 * The host kernel is running with the necessary features
+	 * enabled to run SEV-SNP guests.
+	 */
+	CC_ATTR_HOST_SEV_SNP,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
@@ -107,10 +115,14 @@ enum cc_attr {
  * * FALSE - Specified Confidential Computing attribute is not active
  */
 bool cc_platform_has(enum cc_attr attr);
+void cc_platform_set(enum cc_attr attr);
+void cc_platform_clear(enum cc_attr attr);
 
 #else	/* !CONFIG_ARCH_HAS_CC_PLATFORM */
 
 static inline bool cc_platform_has(enum cc_attr attr) { return false; }
+static inline void cc_platform_set(enum cc_attr attr) { }
+static inline void cc_platform_clear(enum cc_attr attr) { }
 
 #endif	/* CONFIG_ARCH_HAS_CC_PLATFORM */
 

