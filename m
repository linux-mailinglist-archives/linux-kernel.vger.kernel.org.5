Return-Path: <linux-kernel+bounces-50310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B187F847745
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412F2291EA5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62CD14D435;
	Fri,  2 Feb 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="NzM2wZlS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cfUC+lbU"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F415099F;
	Fri,  2 Feb 2024 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898125; cv=none; b=eATd3mG0a3TRYDFw15spMSR991GRXFEV2fdjhBUPjbsVE+5HEDgaawK+k7DbSqA78X7/v7Dlox8NNzcWeFABlRd7Pwq5NS6XfhWNRtWuVt4RoBCE927iwIQovSzsSK1h2bhH4taKXROcKRpmwPISYcQ1xRRCmkWb+sLBK5h6SVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898125; c=relaxed/simple;
	bh=3pIaTRooovaG0E4dcQJ7FyxUskX83he+uJFNra6jZ64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NYxxgXaZZUmGhse4rJk4+K6GFZd1ahxolmjwNx6Zjs2+x6nI5KSaCp0ENNqtvdYqmeO4UJsvunIx94yMDqawN9utNfY+tJKxU0iRle5tiKv6XEDa8T6YLnshw8te7ICVznteWGKVaawzPbQg4hW7eHQ90HtEsK4i/ykkDKP0bCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=NzM2wZlS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cfUC+lbU; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 077E83200AF4;
	Fri,  2 Feb 2024 13:22:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 02 Feb 2024 13:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706898121;
	 x=1706984521; bh=emcywIphRaq4Lx/jCRr9GZGkq7nczp4uQNYi6N38LSE=; b=
	NzM2wZlSP0m2rswR4Bg25pV1/EwYtaRgy4INDUAvQPBMHeigpRFLvP0+ZOtdeHe5
	FjAhFX6mVycxh3UXVP00PXuYr0CfFyLCYQcV0LLyn5zAOBYEpAr46mtKBcFUfZAo
	zt7/bgnsV7Kb2SZM5tvyD6QUhe4a4DpO0tU8QoQojOX3PTgtOF7+2z0do+Wefbnn
	vV7lAHw8BhoCdPVeoIcn+Pmxho68uIleJWwHSnKOWDKSZ6PMkGLADqb5KPx6PNpP
	GgC6xCIan/valeLe36nxjJhIqkdh1Eo5U9szUNC2vQEk66lOtuFbcpgmpPYcuGGf
	bjlBNHM1KLumtA+ix9HkTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706898121; x=
	1706984521; bh=emcywIphRaq4Lx/jCRr9GZGkq7nczp4uQNYi6N38LSE=; b=c
	fUC+lbU356dfgiCSoob5VJnSnBsmVYoaIQk9xzs07CI9E2S9ep5syv3yJQaqb7GS
	uqGhtwi5Xsuw8tnHuLx73Ggq+Ve/m0o+1vs79JHmuOBe0TqaF7zBAKvuluYgIra3
	ZNci4v4nRuyFVY+I+HzNyNQmHQF4/2mRuuamkLqelhsQA6cU2t6M8Xnn3LYogSjn
	MWhR9rD+x4IGyZ3JX2jBMoFLOurs2j56A74JLUXegAskK5HWHir8gHhvTJFFpa79
	ASGDOch1h/Q15VEUxetKjena36dvjZqZDtn8iFJuqfrv4BIeZvcEQ7oBCvBfPU6U
	dCUns01DVTzBi1Lbt1s0w==
X-ME-Sender: <xms:yTK9ZdKZ-WYnPVAaff62Fg4dfnkqjhAjHYptlbRyJKA_JWCWn6HlRA>
    <xme:yTK9ZZJGB0pu2nuP7rBtY3K8MeznBw8p81RUU7fqAabgEfcdwykkkxd-uVdOTYpjW
    NaU22TN2jIZc_kdiNc>
X-ME-Received: <xmr:yTK9ZVuQeLAwKbUsnwJIWn-UvF8cmJ1yBUo6k4kAM3GMTR7oFEC0_CNaU4bV9pfzqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeffveeifeeljeejfeetgfeiueejieffgeeuieegtdekffek
    geduudduteejleevtdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:yTK9ZeakzrfIvCURLsfDwW5540ZhUm-RmsmFHBgUfpJ9ASWaajomgw>
    <xmx:yTK9ZUaebp_BZc0dza0LogDaUMHioSvjkq2GZcEIHF_KDDCsHX9w-g>
    <xmx:yTK9ZSDkumEYjv0LampJPVMElxaLBLa9IqSA2N27qigZ3j9cKYYmQg>
    <xmx:yTK9ZU6Z94ZlaHk-3ZVmsWJ2g5neAIMlGupPxIxA9fDlPrBGUUh4rA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 13:21:59 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 02 Feb 2024 18:21:42 +0000
Subject: [PATCH 3/8] MIPS: Fallback CPU -march flag to ISA level if
 unsupported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-llvm-msym32-v1-3-52f0631057d6@flygoat.com>
References: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
In-Reply-To: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4062;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=3pIaTRooovaG0E4dcQJ7FyxUskX83he+uJFNra6jZ64=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtS9Rnts7QrWMnn7PVFYoXRr2sJa8bSnH67+32D1YkavW
 8sVldwlHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRrQcZGe6p/Ph06O5q53+i
 xofyy1Y5RRxXmLWjqcx36s37uTsbdisx/K9S2mThPvWkWE4e26aHNsbee56klf1I5L3g9jNiWcx
 jOV4A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

LLVM does not implement some of -march options. However those options
are not mandatory for kernel to build for those CPUs.

Fallback -march CFLAG to ISA level if unsupported by toolchain so
we can get those kernel to build with LLVM.

Link: https://github.com/ClangBuiltLinux/linux/issues/1544
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v0: https://lore.kernel.org/all/20230414080701.15503-7-jiaxun.yang@flygoat.com/
v1: Fix SB1 arch level to mips64
---
 arch/mips/Makefile | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index daa569ca4372..91470931a5b8 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -148,10 +148,10 @@ cflags-y += $(call cc-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
 #
 # CPU-dependent compiler/assembler options for optimization.
 #
-cflags-$(CONFIG_CPU_R3000)	+= -march=r3000
-cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
-cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
-cflags-$(CONFIG_CPU_TX49XX)	+= -march=r4600 -Wa,--trap
+cflags-$(CONFIG_CPU_R3000)	+= $(call cc-option,-march=r3000,-march=mips1)
+cflags-$(CONFIG_CPU_R4300)	+= $(call cc-option,-march=r4300,-march=mips3) -Wa,--trap
+cflags-$(CONFIG_CPU_R4X00)	+= $(call cc-option,-march=r4600,-march=mips3) -Wa,--trap
+cflags-$(CONFIG_CPU_TX49XX)	+= $(call cc-option,-march=r4600,-march=mips3) -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32_R1)	+= -march=mips32 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32_R2)	+= -march=mips32r2 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32_R5)	+= -march=mips32r5 -Wa,--trap -modd-spreg
@@ -160,26 +160,30 @@ cflags-$(CONFIG_CPU_MIPS64_R1)	+= -march=mips64 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS64_R2)	+= -march=mips64r2 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS64_R5)	+= -march=mips64r5 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS64_R6)	+= -march=mips64r6 -Wa,--trap
-cflags-$(CONFIG_CPU_P5600)	+= -march=p5600 -Wa,--trap -modd-spreg
-cflags-$(CONFIG_CPU_R5000)	+= -march=r5000 -Wa,--trap
-cflags-$(CONFIG_CPU_R5500)	+= $(call cc-option,-march=r5500,-march=r5000) \
+cflags-$(CONFIG_CPU_P5600)	+= $(call cc-option,-march=p5600,-march=mips32r5) \
+			-Wa,--trap -modd-spreg
+cflags-$(CONFIG_CPU_R5000)	+= $(call cc-option,-march=r5000,-march=mips4) \
 			-Wa,--trap
-cflags-$(CONFIG_CPU_NEVADA)	+= $(call cc-option,-march=rm5200,-march=r5000) \
+cflags-$(CONFIG_CPU_R5500)	+= $(call cc-option,-march=r5500,-march=mips4) \
 			-Wa,--trap
-cflags-$(CONFIG_CPU_RM7000)	+= $(call cc-option,-march=rm7000,-march=r5000) \
+cflags-$(CONFIG_CPU_NEVADA)	+= $(call cc-option,-march=rm5200,-march=mips4) \
 			-Wa,--trap
-cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-march=sb1,-march=r5000) \
+cflags-$(CONFIG_CPU_RM7000)	+= $(call cc-option,-march=rm7000,-march=mips4) \
+			-Wa,--trap
+cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-march=sb1,-march=mips64) \
 			-Wa,--trap
 cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-mno-mdmx)
 cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-mno-mips3d)
-cflags-$(CONFIG_CPU_R10000)	+= $(call cc-option,-march=r10000,-march=r8000) \
+cflags-$(CONFIG_CPU_R10000)	+= $(call cc-option,-march=r10000,-march=mips4) \
 			-Wa,--trap
 cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -march=octeon -Wa,--trap
 cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,-mfix-cn63xxp1
 cflags-$(CONFIG_CPU_BMIPS)	+= -march=mips32 -Wa,-mips32 -Wa,--trap
 
-cflags-$(CONFIG_CPU_LOONGSON2E) += -march=loongson2e -Wa,--trap
-cflags-$(CONFIG_CPU_LOONGSON2F) += -march=loongson2f -Wa,--trap
+cflags-$(CONFIG_CPU_LOONGSON2E) += \
+			$(call cc-option,-march=loongson2e,-march=mips3) -Wa,--trap
+cflags-$(CONFIG_CPU_LOONGSON2F) += \
+			$(call cc-option,-march=loongson2f,-march=mips3) -Wa,--trap
 # Some -march= flags enable MMI instructions, and GCC complains about that
 # support being enabled alongside -msoft-float. Thus explicitly disable MMI.
 cflags-$(CONFIG_CPU_LOONGSON2EF) += $(call cc-option,-mno-loongson-mmi)

-- 
2.43.0


