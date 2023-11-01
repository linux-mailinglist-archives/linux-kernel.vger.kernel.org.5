Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD4F7DE372
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjKAPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjKAPRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:17:20 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C27D12F;
        Wed,  1 Nov 2023 08:16:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 767B45C0272;
        Wed,  1 Nov 2023 11:16:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Nov 2023 11:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698851807; x=1698938207; bh=mi/1bIt+Wi3Xu7dZdtAdadElR9m1kdodNDS
        n+OFK8VA=; b=ajhg2tQdp2pNsnNcvSch/5K7YmLxTP/ZUdoW3WE20Kp9ybXnZbq
        f6Ik7Kt/qypiKrcHNQJkg7h4GkXFBBvwod619VGA1oH/VgKfZ/ouf0ZtzkHNcvoK
        ZGWb2GKslkvjOe2u6VnDsRMHFTut6GA52tFx2BOQMqCZBtw4kZEf+xsGv8UFLfXK
        e073r8CM7rBtpgZzrp+R6xPceqr5QxbvLjeKk0oF+w4CWHqXo8ZmE7O4cu/vwnCP
        DEsIgtOWcN1WN+HAWYNbsvr1p8nD53nQ7OedctrQacAr5P8OhYOTGKn80S3JA4lz
        3AGWjCeJ5+hL1CXd5Wr/Pd7Ijh6oe6l4aXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698851807; x=1698938207; bh=mi/1bIt+Wi3Xu7dZdtAdadElR9m1kdodNDS
        n+OFK8VA=; b=rV5qMkzfb1iSOJtDx7GwG3ghF6+egzjgEXc8FSLp0cVfHoemdhp
        9kFbmgCC0F+C+VE5YJeVZxpBHCyvvqRiDfUayLS58vK5QVwldzN73962d8fcpoQ/
        Hbb33z82xCumuq5Hrqe9yzyvy+Vxy9lWQcObOXX0NBALr1ianPY6H2ADifKRv2rm
        NsmRiDbX62XCzavxRbGV2FwROqVewYZpv9N2tHkKFYL+ye9hqjq413U9uqO2ZPrG
        BFUJyEafnFu/aioW+WhsU4Vx8B39OjLJ91g+RrweyPbRGK68+wSpWPeB20998sbj
        K7ztSW/OydIFyOcwtRrneKJLEVTcKzKmvVA==
X-ME-Sender: <xms:3mtCZTna28LJ43CEyAHgNhQWn0m6RsCtzVYQjlMkFeAJvU9hNaLVYg>
    <xme:3mtCZW08LWA2p5zDx30otIym-3yIIIliY0xdqrdirWg4Dbg8mJAGk2P2VYMflvj6W
    cliQLk1k8rSzPFzY4Q>
X-ME-Received: <xmr:3mtCZZoAacmc7e7L9Q5jWYrdLEFawSWs6G2KV6hVWzG2LPLUjNqeRhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:32tCZbkJG3dtDZYIB-Wi2UAY6y5HjTWpIBZloCrZrTFzMaA4oQlNNA>
    <xmx:32tCZR0eD6JmY4GebGYmdh-ABBfJYgPSRuHfeHE4RViLYAkq_su0_w>
    <xmx:32tCZat8IP-IyEo4XFmniyGmZXVILQCW32hk6KriYz0RbrmQnYy0RA>
    <xmx:32tCZcSsSIefWLMMs0Pdh1zUlCgsr6OM_MfJHmRaPhvT83uTRRAkkw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 11:16:46 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Wed, 01 Nov 2023 11:39:08 +0000
Subject: [PATCH fixes 2/3] MIPS: Loongson64: Enable DMA noncoherent support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-loongson64_fixes-v1-2-2a2582a4bfa9@flygoat.com>
References: <20231101-loongson64_fixes-v1-0-2a2582a4bfa9@flygoat.com>
In-Reply-To: <20231101-loongson64_fixes-v1-0-2a2582a4bfa9@flygoat.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some Loongson64 systems come with broken coherent DMA
support, firmware will set a bit in boot_param and pass nocoherentio
in cmdline.

However nonconherent support was missed out when spin off Loongson-2EF
form Loongson64, and that boot_param change never made itself into
upstream.

Support DMA noncoherent properly to get those systems work.

Cc: stable@vger.kernel.org
Fixes: 71e2f4dd5a65 ("MIPS: Fork loongson2ef from loongson64")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig                                  | 2 ++
 arch/mips/include/asm/mach-loongson64/boot_param.h | 3 ++-
 arch/mips/loongson64/env.c                         | 9 ++++++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 76db82542519..797ae590ebdb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -460,6 +460,7 @@ config MACH_LOONGSON2EF
 
 config MACH_LOONGSON64
 	bool "Loongson 64-bit family of machines"
+	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
@@ -1251,6 +1252,7 @@ config CPU_LOONGSON64
 	select CPU_SUPPORTS_MSA
 	select CPU_DIEI_BROKEN if !LOONGSON3_ENHANCEMENT
 	select CPU_MIPSR2_IRQ_VI
+	select DMA_NONCOHERENT
 	select WEAK_ORDERING
 	select WEAK_REORDERING_BEYOND_LLSC
 	select MIPS_ASID_BITS_VARIABLE
diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index 035b1a69e2d0..c454ef734c45 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -117,7 +117,8 @@ struct irq_source_routing_table {
 	u64 pci_io_start_addr;
 	u64 pci_io_end_addr;
 	u64 pci_config_addr;
-	u32 dma_mask_bits;
+	u16 dma_mask_bits;
+	u16 dma_noncoherent;
 } __packed;
 
 struct interface_info {
diff --git a/arch/mips/loongson64/env.c b/arch/mips/loongson64/env.c
index c961e2999f15..df0e92cd3920 100644
--- a/arch/mips/loongson64/env.c
+++ b/arch/mips/loongson64/env.c
@@ -13,6 +13,8 @@
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  */
+
+#include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <linux/pci_ids.h>
 #include <asm/bootinfo.h>
@@ -147,8 +149,13 @@ void __init prom_lefi_init_env(void)
 
 	loongson_sysconf.dma_mask_bits = eirq_source->dma_mask_bits;
 	if (loongson_sysconf.dma_mask_bits < 32 ||
-		loongson_sysconf.dma_mask_bits > 64)
+		loongson_sysconf.dma_mask_bits > 64) {
 		loongson_sysconf.dma_mask_bits = 32;
+		dma_default_coherent = true;
+	} else
+		dma_default_coherent = !eirq_source->dma_noncoherent;
+
+	pr_info("DMA coherent: %s\n", dma_default_coherent ? "on" : "off");
 
 	loongson_sysconf.restart_addr = boot_p->reset_system.ResetWarm;
 	loongson_sysconf.poweroff_addr = boot_p->reset_system.Shutdown;

-- 
2.34.1

