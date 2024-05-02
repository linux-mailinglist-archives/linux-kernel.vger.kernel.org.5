Return-Path: <linux-kernel+bounces-166267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8FF8B9849
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39D41C21DDB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA8959148;
	Thu,  2 May 2024 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="kmKSb5Wx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VSS2LiEl"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFCB56B72;
	Thu,  2 May 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643982; cv=none; b=b5O8hg2Q+/Y/JnZBEeh3w8LpWSU/wyWnp5Q1gw+LKDBkuS17+XjqIrOvNbO66zYBaql3xG+Vnsjk8x108eWDG+2j3qOGEmBwHtl+jeGDJHxGa1BkZY/EllhtUJBpune0wrF+D47fUqig8pP5Ls6cHUZ62YJCmcs6pY7LiiNIUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643982; c=relaxed/simple;
	bh=w9xlwGFJnIHWa5fchmk4oq7/y7T06fED6QHXHCyosCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NgTliMCXW387ccQLYadUG3Tl2LeExujcK3xVTcH7D1XvdNk81V/QoraaiTAsp2PliApHosKZ2+EsXDMQJKB813py0WxDrExDbxR2YkPN0xoMQFEu9zNj9bZ8tvSVxYhbnCkCvtAB4kNP2/X7AGsI7HypBs4wG+NwUbSUGFofIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=kmKSb5Wx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VSS2LiEl; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F0B6A11400FA;
	Thu,  2 May 2024 05:59:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 02 May 2024 05:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1714643979;
	 x=1714730379; bh=5M6GPkYDnWff3CvPMNx1/kIvO2GekmTkKu/MnzVvRc0=; b=
	kmKSb5WxSBb5iiXsxWIG63sq17h9UeFKylE3ZVIgByTqpXn6cRUjT1x6srV4yP0w
	/4oUlAMEtFNuTwdvgf/bYpfargiWMNU0/M2hYBIYCWFtlOYNMlELMcO/3v9yO7QA
	iPr4uaJvrVQCsv+wgW082WHk5cvGSCrmwO3plRVOrwLb3/JEcB1gvxrVZFmmYS4e
	Vugo2ssq/e20zCKonkhVA62IQgE810RpHffXaP/EvvU6n/ziojrRXdfLpCZvuOVX
	qCAIBUgyvVVF6v0L7cFGpzryBTjyEKdG1JzmQGq58ROoydJrmHg/G2a7ELJb6Ruu
	SzFmMT4WARvYJX7ZZLx+UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714643979; x=
	1714730379; bh=5M6GPkYDnWff3CvPMNx1/kIvO2GekmTkKu/MnzVvRc0=; b=V
	SS2LiEl4l/AmZ70HoYbbwG/tb/7zl/PcT8wJEZXC3qHtPwJcl1Qqx4gPx3KbvfvT
	hZMdzrMgkvfIklQ2c7oWVTakH7ZcCfkMP6lOo765GtL7mlzXEJ6hUJnrYaI06O39
	DQItP21kbVMy5cyM46dVG4lz4VEhdlPXFVCWBeJgqbEnD8YVBdDg7q0WVIVpWXfm
	MrziCjv5UgngWK+Dl14zI4OCp1rlvE52jYhoJV7O1le9XBNbfRjI85l3KgjAvDsY
	mcjnI8lV5NuzycCpzpPPt7SC6aZLwZNJuutcIXOA+ATT7ajf4qYsWySgZLP8js80
	Um0GDJy51PxvmM4usvIEg==
X-ME-Sender: <xms:C2QzZl8TSTcUhd6CcTZbOHvhVy-rLpWMQMbG6tvSMRJnxi9axJxiRA>
    <xme:C2QzZpu1DrcQUqVR34ckwERs90oTeLKEc89JCT2Awtc3Dj0AhKU0RUHRIRZVkzYy-
    PKr2_SAmusu7CoLcH8>
X-ME-Received: <xmr:C2QzZjDtsPSpwSYuU-_qAUQS_Zkn7QiJMF2c84MiG8HmGVoIyTGrIh0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepveevteehgefggeejkeejtddtteeuleduheevjefgjeetvdfh
    udegtefglefhveeknecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:C2QzZpeJkbH0dHwRzgR6mwAg55tFkZTxrpIPnVCN4_ZoK7_X0FIvWA>
    <xmx:C2QzZqMDDWJ_ev1w40yKQT6s75NWWm0H_knWWz6BBxYDSfpjjV8Qyg>
    <xmx:C2QzZrma-aXQXWLe416aCQchLyyPCHIyF1NDcsGU5-Wnalb19tQF7Q>
    <xmx:C2QzZkuocm_8lWNmb6aXKEr3481O6qFcQT2NSPTZW5SKF9WL8ts8rg>
    <xmx:C2QzZh13RVejdbspXgH8SJakGX5a5KUS9DfN1WmG_g8dRqfPHzZ8TAa7>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 05:59:38 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 02 May 2024 10:59:30 +0100
Subject: [PATCH v3 3/9] MIPS: debug: Hook up DEBUG_LL with early printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240502-mips_debug_ll-v3-3-3b61f30e484c@flygoat.com>
References: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
In-Reply-To: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1810;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=w9xlwGFJnIHWa5fchmk4oq7/y7T06fED6QHXHCyosCc=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTjFHb/xoM9/89encH7fc2ZXyaXliue1+Z513eU4+2h8
 n+FJTtZOkpZGMQ4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAibdWMDFN/fP348Ups7jle
 3gl+3GrpvdmWAVP3tQfnc+4+lt73z4CRYV3PRN4EsZTnoverY5mXTf7Yxb3h0Gvvx5YGIrm7jY3
 N+AE=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Output earlyprintk to low-level debug functions when it's
available.

DEBUG_LL takes priority over platform earlyprintk because
people must know what are they doing when they are trying
to enable DEBUG_LL.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig.debug         |  2 +-
 arch/mips/kernel/early_printk.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 892e31804982..6ef42edc7d67 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -2,7 +2,7 @@
 
 config EARLY_PRINTK
 	bool "Early printk" if EXPERT
-	depends on SYS_HAS_EARLY_PRINTK
+	depends on SYS_HAS_EARLY_PRINTK || DEBUG_LL
 	default y
 	help
 	  This option enables special console drivers which allow the kernel
diff --git a/arch/mips/kernel/early_printk.c b/arch/mips/kernel/early_printk.c
index 4a1647ddfbd9..c3f3b0a930f0 100644
--- a/arch/mips/kernel/early_printk.c
+++ b/arch/mips/kernel/early_printk.c
@@ -14,6 +14,24 @@
 
 #include <asm/setup.h>
 
+#ifdef CONFIG_DEBUG_LL
+extern void printascii(const char *);
+
+static void early_console_write(struct console *con, const char *s, unsigned n)
+{
+	char buf[128];
+
+	while (n) {
+		unsigned int l = min(n, sizeof(buf)-1);
+
+		memcpy(buf, s, l);
+		buf[l] = 0;
+		s += l;
+		n -= l;
+		printascii(buf);
+	}
+}
+#else
 static void early_console_write(struct console *con, const char *s, unsigned n)
 {
 	while (n-- && *s) {
@@ -23,6 +41,7 @@ static void early_console_write(struct console *con, const char *s, unsigned n)
 		s++;
 	}
 }
+#endif
 
 static struct console early_console_prom = {
 	.name	= "early",

-- 
2.34.1


