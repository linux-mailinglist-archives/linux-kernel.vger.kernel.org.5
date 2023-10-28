Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697477DA765
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjJ1Nw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1NwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:52:25 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A4393;
        Sat, 28 Oct 2023 06:52:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 76BA85C01F6;
        Sat, 28 Oct 2023 09:52:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 28 Oct 2023 09:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698501141; x=1698587541; bh=6IKvXKpxSl4lY0afrTUCucwVFAqsFt38LYk
        qHWmNzL8=; b=EWwHB4EdV/uPg01AcSInLDmOSSFspbjAQL94KUdOe7PX+4TrfZB
        ttL+LTEyoqFLgZ4j9068oaUWojXf+17EIWjgz+e2MQIspWi02G/x2HfBgagbfkkS
        Eb86gfOBDjVurt01odOI9G0A0jLiTQHWsKiC2eNdq1H3LyRKM0Wnm1awYDmGDyzI
        pmFM4xaPHkfiI1U6nHS9JS8B9LI+hHEXZq3ZtF1RI6XN7q0s3eVi3kopz8PGUl78
        ffP3uxH4uuAkTIZ7V/XNAFU2lQM8XrHnprshA5ry8ZIvntG2u+QPIlbrWaLqYkmg
        XEUmfIDXk3zBhePZoq1pCmbwh2W3rKy9Jzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698501141; x=1698587541; bh=6IKvXKpxSl4lY0afrTUCucwVFAqsFt38LYk
        qHWmNzL8=; b=hwlcPC/gFFTjen2bz9Im7vP7fNH6NNl6iCZWIXXnYMJ5uJOr8VD
        pQWKMltfAji4hTFe0M3b+Fy/TJ/BlmXP2/3tQOizhu8Sg89EsA1/LV+BnUf/w9/j
        7XLzvXXzpg7br4pYXA6Tl4kOGMLMNeNtlioZdFSqDvpWX9nAnu2WvmF9AC5Pwj9x
        u+I7QWR79ccQQ9esDdd5Kh0Zh1SIL5Xp2TBV0bVeqJ8wzD27sh1ZmD7BbwvJoTzz
        EXdasOykWXfJqQU/oycYwI2XcHKSXTATh5k4XXbBKi6nsJwWelWv37yppVJsJPrv
        zqAeQ96sDVDhjFjI+4XkY6Wd1oALknjIJRg==
X-ME-Sender: <xms:FRI9ZUpt0T4DB5NMrK4zgNrohAQC14aWLlvxIhA2pMz93det4u-QhA>
    <xme:FRI9ZaogihufPL6Kp9qR4CMVNzUTIzHOnyoxKYrI1nFGvdcZP-CPy0ToOqKI7DZp7
    sWktugFvtYpa1Rse5A>
X-ME-Received: <xmr:FRI9ZZP8QFNfbuRCXNpnPBUOA48rPbwBu6y3P-_YPc6xqKDqITcOYeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeigdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
    geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:FRI9Zb4I_2tODy_zRemUr3oBK_tSscQuPC2YX9EtkvgtYD55i2hFbg>
    <xmx:FRI9ZT4x3SziWLkoXpyabp4A-qU6S2tgppwmPOAmI_OqQVrFTuKfyw>
    <xmx:FRI9ZbhHen6PnopYU3qJinhDa9nFxswyT5GQUBlpvEI7fPvQxC_htg>
    <xmx:FRI9ZTHo2YYGjL4I_Wuv_MaTdWyg-h1KmnraXzLwpHZIDkDuyQZ6sQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Oct 2023 09:52:20 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Sat, 28 Oct 2023 14:52:16 +0100
Subject: [PATCH 1/2] MIPS: Enable SPARSEMEM option unconditionally on 64BIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231028-mm-v1-1-45377cd158cf@flygoat.com>
References: <20231028-mm-v1-0-45377cd158cf@flygoat.com>
In-Reply-To: <20231028-mm-v1-0-45377cd158cf@flygoat.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPARSEMEM have been tested on Cavium and Loongson64 for a while
and we are confident that they are working properly on 64bit
systems.

Since it's almost certain for 64bit MIPS system to have a hole
in memory space, SPARSEMEM will be more efficent for them.

Also promote platforms marked with SPARSEMEM_ENABLE before
to SPARSEMEM_DEFAULT, as they tend to have huge holes in
address space.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig             | 13 ++++++++-----
 arch/mips/loongson2ef/Kconfig |  4 ++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 76db82542519..d12e8f3c1d08 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -460,7 +460,7 @@ config MACH_LOONGSON2EF
 
 config MACH_LOONGSON64
 	bool "Loongson 64-bit family of machines"
-	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_SPARSEMEM_DEFAULT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
@@ -656,7 +656,7 @@ config SGI_IP22
 config SGI_IP27
 	bool "SGI IP27 (Origin200/2000)"
 	select ARCH_HAS_PHYS_TO_DMA
-	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_SPARSEMEM_DEFAULT
 	select FW_ARC
 	select FW_ARC64
 	select ARC_CMDLINE_ONLY
@@ -923,7 +923,7 @@ config CAVIUM_OCTEON_SOC
 	select ZONE_DMA32
 	select GPIOLIB
 	select USE_OF
-	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_SPARSEMEM_DEFAULT
 	select SYS_SUPPORTS_SMP
 	select NR_CPUS_DEFAULT_64
 	select MIPS_NR_CPU_NR_MAP_1024
@@ -2573,10 +2573,13 @@ config CPU_SUPPORTS_MSA
 
 config ARCH_FLATMEM_ENABLE
 	def_bool y
-	depends on !NUMA && !CPU_LOONGSON2EF
 
 config ARCH_SPARSEMEM_ENABLE
-	bool
+	def_bool y
+	depends on 64BIT
+
+config ARCH_SELECT_MEMORY_MODEL
+	def_bool ARCH_SPARSEMEM_ENABLE
 
 config NUMA
 	bool "NUMA Support"
diff --git a/arch/mips/loongson2ef/Kconfig b/arch/mips/loongson2ef/Kconfig
index f93eb6f42238..e593294b2995 100644
--- a/arch/mips/loongson2ef/Kconfig
+++ b/arch/mips/loongson2ef/Kconfig
@@ -6,7 +6,7 @@ choice
 
 config LEMOTE_FULOONG2E
 	bool "Lemote Fuloong(2e) mini-PC"
-	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_SPARSEMEM_DEFAULT
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
@@ -36,7 +36,7 @@ config LEMOTE_FULOONG2E
 
 config LEMOTE_MACH2F
 	bool "Lemote Loongson 2F family machines"
-	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_SPARSEMEM_DEFAULT
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO

-- 
2.34.1

