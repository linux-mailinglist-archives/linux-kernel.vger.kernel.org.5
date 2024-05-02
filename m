Return-Path: <linux-kernel+bounces-166273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBDA8B9858
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A961F25364
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4DD7442A;
	Thu,  2 May 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="APgbQzBX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDppGbzW"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968B605CE;
	Thu,  2 May 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643989; cv=none; b=eTzhWgrkR8n1nebWNqleSYoZBS8sdvyNCIsqJOE7qawiOnx5YC4a+fDuKHG+qNmFN0LAVR+eO0k9wZ6C2z3OoUugHEvv0tTSOwirCuHQD4qgNxIM93f39C6ShI3CtlP2ho90V2znlcmBAel07nqKsR8T5mgh61W9ywjPslf1Isw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643989; c=relaxed/simple;
	bh=6Hy0CE2gz3tjfXKjbIcr16YBCFXFhkTBeaOHPEwpw3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtIJmEyhELy5msBGvy7Gc5g2nsmjiJ1q40OzymbITROJcLNHbbnq8a1xjAZ8nweQoq5M6sJOnEPAhl3qqMamdRArTozc3/RPua2LpFTvjgdfV/Fxys6fBDeaIsGzQqo1cipBK8A14q7GKIjCejrc/j65bdkX+25mkc4w+5IFDE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=APgbQzBX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CDppGbzW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 98CD41380F77;
	Thu,  2 May 2024 05:59:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 02 May 2024 05:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1714643986;
	 x=1714730386; bh=k/55CQa6Ev4TXWQ4A7fhBWTmOAnCMQDX20larfA7pmI=; b=
	APgbQzBXmWN/S1FT808Gsszhpo5GvUEIq/eD+sGH3u2xth321uF7xwrL5p0JEt68
	BEWWVI/fWeImlLEX8wvE0Bt/R9RGbwMOSmbn2r5979n7Jz9Ig+m9zhISBBHWBwyH
	+08al910BkH5KmWdeIGpNA13cB+/QY+xc0kkQhmxnlPIrSpN5R/fUKF/WRmNk1tO
	ypDFb+9nBjT7z08mvEwcDVnKs/2DO4WwE+RnnaKrIqx1l03JnqbaaJ5P5V2KHNVN
	8021HnhvtvHLqVJpfio/Fbgu9U0NrmwrxaPt0++XPg42uAng/tN6ZbFbI5OOhJfD
	Uwbr85lBOTaSU8Md6QU8Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714643986; x=
	1714730386; bh=k/55CQa6Ev4TXWQ4A7fhBWTmOAnCMQDX20larfA7pmI=; b=C
	DppGbzWTKpm3RC5hLFTVpJIDwqtsOOmXxo8+O1uJzN0LEU2mUJTAHqugNZ8ygJ8b
	Ct18SlxYee6x8+9uT+ulmLUIv7MjunAaMKY1ruKroGm0cD0oOA5Vst/sbO0MIxzX
	tWvKDcHUU813Qox9F48f+eluVwIWFF+9vvdDzuaA9pKycCqAv5LtLbGqIzrvk8S5
	3C9H+cGlXeLoQzL6cQAxfMubRR0TiPMHUk05lJEAoo0/97wzKVJkYir3Zokz6jAu
	m70ish+WLOaKU9LUDfkbYWJoXh9hmILgtC3fesaxyAT0Yh6Fpkx8F+IrdNddidKU
	uedvG4W7AjmbeVBz7hV2g==
X-ME-Sender: <xms:EmQzZihiu0o9vELQ0PPoCEbPS5iSlxPgXz6BvKc0b_CQSBua0QzEkw>
    <xme:EmQzZjDXzqAOJ9fnM2vRSfoiRrapy5w1dEDCndUMe4LuqvZ36Lg1EeqXM-u2-3XY0
    VbiiDE2OpMjM3U2by0>
X-ME-Received: <xmr:EmQzZqEXB0VV0_9qcSnJLotHiJKcMTE0w7GIHhACY07CaB88ShlMY_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleekvddvuedvffevuddvkeegheejgfdukedvkefgjedvvdei
    tdduhfdvhfehgeeunecuffhomhgrihhnpegtphhsqdhvvggtrdhssgenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:EmQzZrQhj25lBMIRB4XmOwY5o12j_CakFJ_PwVsV6HZUEBv39sYuXQ>
    <xmx:EmQzZvzVbBHu9B-9sdcErqIJLQQdyJAMmaN7FZur0plg3fuxNNbXzg>
    <xmx:EmQzZp4gzoC_FKBqjbQxzl35kmxDlAW3B-fbf0dvR7u-oJv6Si8BuQ>
    <xmx:EmQzZsxoV5EPmygG5jKu7Uedy42rIKIsYkTQV7GYj89JX491CxmmNg>
    <xmx:EmQzZqokvy2Wg_omTlC4S4lfJW39zAxZ7F--8V3KHewwmQ-7nUMW9goV>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 05:59:45 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 02 May 2024 10:59:36 +0100
Subject: [PATCH v3 9/9] MIPS: CPS: Convert to use debug_ll facilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240502-mips_debug_ll-v3-9-3b61f30e484c@flygoat.com>
References: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
In-Reply-To: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4592;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=6Hy0CE2gz3tjfXKjbIcr16YBCFXFhkTBeaOHPEwpw3w=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTjFPbbx/ecLr1Tlh3wp1np5dTfqeuO87JdyLbJ/CEou
 ELgE0NmRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzElYmR4frKqPp7Ox91dLdI
 1v0XK08Ivfog72DtszXH4t/tso68rcTIML3S1Pu179q/DtaXllRwsb39Yy0wZ0t+w4QdOlkfgr+
 EswMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

debug_ll replaced CPS's custom NS16550 printing functions
for dump early SMP bring-up exceptions.

This will enable CPS debugging on more platforms and also
reduce code duplication.

All exception name strings are prefixed with CPS to help
identification with regular low-level interrupts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig.debug    | 52 +++++++++-------------------------------------
 arch/mips/kernel/Makefile  |  1 -
 arch/mips/kernel/cps-vec.S | 16 +++++++-------
 3 files changed, 18 insertions(+), 51 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 0ce6d24d05b3..caba00cd8a33 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -96,48 +96,6 @@ config SCACHE_DEBUGFS
 
 	  If unsure, say N.
 
-menuconfig MIPS_CPS_NS16550_BOOL
-	bool "CPS SMP NS16550 UART output"
-	depends on MIPS_CPS
-	help
-	  Output debug information via an ns16550 compatible UART if exceptions
-	  occur early in the boot process of a secondary core.
-
-if MIPS_CPS_NS16550_BOOL
-
-config MIPS_CPS_NS16550
-	def_bool MIPS_CPS_NS16550_BASE != 0
-
-config MIPS_CPS_NS16550_BASE
-	hex "UART Base Address"
-	default 0x1b0003f8 if MIPS_MALTA
-	default 0
-	help
-	  The base address of the ns16550 compatible UART on which to output
-	  debug information from the early stages of core startup.
-
-	  This is only used if non-zero.
-
-config MIPS_CPS_NS16550_SHIFT
-	int "UART Register Shift"
-	default 0
-	help
-	  The number of bits to shift ns16550 register indices by in order to
-	  form their addresses. That is, log base 2 of the span between
-	  adjacent ns16550 registers in the system.
-
-config MIPS_CPS_NS16550_WIDTH
-	int "UART Register Width"
-	default 1
-	help
-	  ns16550 registers width. UART registers IO access methods will be
-	  selected in accordance with this parameter. By setting it to 1, 2 or
-	  4 UART registers will be accessed by means of lb/sb, lh/sh or lw/sw
-	  instructions respectively. Any value not from that set activates
-	  lb/sb instructions.
-
-endif # MIPS_CPS_NS16550_BOOL
-
 # These options are only for real kernel hackers who want to get their hands dirty.
 config DEBUG_LL
 	bool "Kernel low-level debugging functions (read help!)"
@@ -320,3 +278,13 @@ config DEBUG_ZBOOT_EXCEPT
 	  during decompression of a compressed kernel via the DEBUG_LL output.
 
 	  If unsure, say N.
+
+config DEBUG_CPS_EXCEPT
+	bool "Enable kernel debugging of Coherent Processing System exceptions"
+	depends on MIPS_CPS && DEBUG_LL_EXCEPT
+	help
+	  Say Y here if you want to enable debugging of exceptions happen
+	  during SMP bring-up stages on processors witn MIPS Coherent Processing
+	  System support.
+
+	  If unsure, say N.
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 6641c3370e68..94325c02cae2 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -59,7 +59,6 @@ obj-$(CONFIG_MIPS_MT)		+= mips-mt.o
 obj-$(CONFIG_MIPS_MT_FPAFF)	+= mips-mt-fpaff.o
 obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
 obj-$(CONFIG_MIPS_CPS)		+= smp-cps.o cps-vec.o
-obj-$(CONFIG_MIPS_CPS_NS16550)	+= cps-vec-ns16550.o
 obj-$(CONFIG_MIPS_SPRAM)	+= spram.o
 
 obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index f876309130ad..49d682b3b49a 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -33,15 +33,15 @@
 # define STATUS_BITDEPS		0
 #endif
 
-#ifdef CONFIG_MIPS_CPS_NS16550
+#ifdef CONFIG_DEBUG_CPS_EXCEPT
 
 #define DUMP_EXCEP(name)		\
 	PTR_LA	a0, 8f;			\
-	jal	mips_cps_bev_dump;	\
+	jal	debug_ll_exception;	\
 	 nop;				\
 	TEXT(name)
 
-#else /* !CONFIG_MIPS_CPS_NS16550 */
+#else /* !CONFIG_DEBUG_CPS_EXCEPT */
 
 #define DUMP_EXCEP(name)
 
@@ -154,31 +154,31 @@ LEAF(mips_cps_core_boot)
 
 	__INIT
 LEAF(excep_tlbfill)
-	DUMP_EXCEP("TLB Fill")
+	DUMP_EXCEP("CPS - TLB Fill")
 	b	.
 	 nop
 	END(excep_tlbfill)
 
 LEAF(excep_xtlbfill)
-	DUMP_EXCEP("XTLB Fill")
+	DUMP_EXCEP("CPS - XTLB Fill")
 	b	.
 	 nop
 	END(excep_xtlbfill)
 
 LEAF(excep_cache)
-	DUMP_EXCEP("Cache")
+	DUMP_EXCEP("CPS - Cache")
 	b	.
 	 nop
 	END(excep_cache)
 
 LEAF(excep_genex)
-	DUMP_EXCEP("General")
+	DUMP_EXCEP("CPS - General")
 	b	.
 	 nop
 	END(excep_genex)
 
 LEAF(excep_intex)
-	DUMP_EXCEP("Interrupt")
+	DUMP_EXCEP("CPS - Interrupt")
 	b	.
 	 nop
 	END(excep_intex)

-- 
2.34.1


