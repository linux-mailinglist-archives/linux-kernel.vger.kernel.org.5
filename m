Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E2C7DA340
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346717AbjJ0WMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346750AbjJ0WL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:11:59 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E411734;
        Fri, 27 Oct 2023 15:11:37 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4DD703200917;
        Fri, 27 Oct 2023 18:11:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 27 Oct 2023 18:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698444695; x=
        1698531095; bh=ovE6ErC2FU6MOXhQYQRXjYJQxqoUgfjvz+3gaCNVsfA=; b=u
        e7ck+5iPL0iPXFtIY+Ef4HQgt0qcg5TNXnQMH8qmACIoCZ4gpNBL0zSWPgifwCIF
        v7XubnvOnAkAtXObd6PkrAKFcbF8j3Xtpab7Mpovhdr6wyvOy/0W0+IGVH8iehZu
        pVNvVpPE8BJS6/2+sJatakKTNkqORtnSVHOITvwG841IuRRSY/hVwG7++U24EzFV
        cwXXJtkQU1+fdYPORtHrxBHUYrwERqpAYFNa2741pSFzr6yiSCoueykoRYVd+9PV
        NzOLhM2ysyD8w7jSD3vr8W92+Ge74s1U3Ux9mLOEHJ1cdr5Z5phSwEODbgln7Ank
        VBJFfbkpWEdiCAvU4D7OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698444695; x=
        1698531095; bh=ovE6ErC2FU6MOXhQYQRXjYJQxqoUgfjvz+3gaCNVsfA=; b=E
        Yng0q4pCC6u+tC5gUP8F1ecIF+9/AxrER0glqDMx7YsQlmILMYXrn+x6XEBH+wkQ
        LlnHKkgD4YiQdGgdpPKqSJvoDnKBQK+aamyuSKeIdwNWJL5XUyC/FOqkut0ejlwY
        7C7QPYd4+7VjWz7VWAeEfF42lmOz7wvWBhSZkUNynVGcK5pAiEh7wHlExw9lIomB
        yuThJy4mekqy7tIVBEdiQpAoull3mFh/j/l43QfsTXI2D5tjxF7Xoe0i3aO7axOd
        CZ2tTIaLi5z0xUt37gOg8n2LoYHsaOGEiBRgeEnhMXonBZiJsaIBTNUZQ5VNBhG8
        BLo2J74hv38zDwlIyH6BA==
X-ME-Sender: <xms:lzU8ZbPtkoAGoxZeChVxo8H9xY-wgG17zVXSV5_x1xe1Fs2Io6c3SA>
    <xme:lzU8ZV8jGGNS9nuSoL2lSp3Nq3hL0aoJ2DK9rWIaJHN-kFXemnte6HgYoHcjXHqwQ
    f9zsIsqvb4aABqkhx0>
X-ME-Received: <xmr:lzU8ZaTBAtaHW3cPpyeyX1ihjm9cEcYRgK_X3E153_2oPiObHluqyhyFyQZfippqSVcAuJARhH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeufeefkeffveeuhfevke
    egheefjeelhfegvdelleeiveduvdevvdfhvdeuleegleenucffohhmrghinhephhgvrggu
    rdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:lzU8Zfs2OZlAyvWUjFIA0k0Ypn8Qxpje33V7vhqwX3Kd9pDLqPfN3w>
    <xmx:lzU8ZTevaTqQC4zvxJkxgvLp3AaEDmHzLC-8fWcYEzki3oQ7hIlbUw>
    <xmx:lzU8Zb2gBYx6-CI7wFfJfHTzw1aNc_RrL8qJuRGmYTlpR599eLtykQ>
    <xmx:lzU8Za6_vkcRbi7LzIcy8EP6dD4LPgUMH-AqdG05rTM4yoIq2luMvw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 18:11:34 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 10/10] MIPS: Get rid of CONFIG_NO_EXCEPT_FILL
Date:   Fri, 27 Oct 2023 23:11:06 +0100
Message-Id: <20231027221106.405666-11-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
References: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NO_EXCEPT_FILL is used to indicate platform that does not
need to reserve ebase memory at start of kernel.

This is true for all R2+ platform as they allocate ebase
memory on fly, and also true for any platform that does
not load kernel at start of physical memory.

Get rid this Kconfig symbol by use macro to detect conditions
above.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig       | 9 ---------
 arch/mips/kernel/head.S | 7 +++++--
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bfedc8b48a81..e928ebc2cd1f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -149,7 +149,6 @@ config MIPS_GENERIC_KERNEL
 	select MIPS_CPU_SCACHE
 	select MIPS_GIC
 	select MIPS_L1_CACHE_SHIFT_7
-	select NO_EXCEPT_FILL
 	select PCI_DRIVERS_GENERIC
 	select SMP_UP if SMP
 	select SWAP_IO_SPACE
@@ -210,7 +209,6 @@ config AR7
 	select CEVT_R4K
 	select CSRC_R4K
 	select IRQ_MIPS_CPU
-	select NO_EXCEPT_FILL
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_EARLY_PRINTK
@@ -265,7 +263,6 @@ config BMIPS_GENERIC
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 	select BOOT_RAW
-	select NO_EXCEPT_FILL
 	select USE_OF
 	select CEVT_R4K
 	select CSRC_R4K
@@ -309,7 +306,6 @@ config BCM47XX
 	select HAVE_PCI
 	select IRQ_MIPS_CPU
 	select SYS_HAS_CPU_MIPS32_R1
-	select NO_EXCEPT_FILL
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MIPS16
@@ -445,7 +441,6 @@ config LANTIQ
 	select IRQ_MIPS_CPU
 	select CEVT_R4K
 	select CSRC_R4K
-	select NO_EXCEPT_FILL
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -494,7 +489,6 @@ config MACH_LOONGSON64
 	select ISA
 	select I8259
 	select IRQ_MIPS_CPU
-	select NO_EXCEPT_FILL
 	select NR_CPUS_DEFAULT_64
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select PCI_DRIVERS_GENERIC
@@ -1177,9 +1171,6 @@ config PCI_GT64XXX_PCI0
 config PCI_XTALK_BRIDGE
 	bool
 
-config NO_EXCEPT_FILL
-	bool
-
 config MIPS_SPRAM
 	bool
 
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index b825ed4476c7..4af53b1628f5 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -59,10 +59,13 @@
 #endif
 	.endm
 
-#ifndef CONFIG_NO_EXCEPT_FILL
+#if (MIPS_ISA_REV < 2) &&			\
+	((VMLINUX_LOAD_ADDRESS == KSEG0) ||	\
+	(VMLINUX_LOAD_ADDRESS == CKSEG0))
 	/*
 	 * Reserved space for exception handlers.
-	 * Necessary for machines which link their kernels at KSEG0.
+	 * Necessary for machines which link their kernels at KSEG0
+	 * and incapable of moving ebase.
 	 */
 	.fill	0x400
 #endif
-- 
2.34.1

