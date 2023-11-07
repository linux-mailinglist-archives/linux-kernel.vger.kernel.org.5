Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D57D7E3AE1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjKGLP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbjKGLPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:15:51 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFFDED;
        Tue,  7 Nov 2023 03:15:48 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B6545C023C;
        Tue,  7 Nov 2023 06:15:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 07 Nov 2023 06:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1699355747; x=1699442147; bh=5VSgtHUh1HuE4TohSwLN46zKOkwRL3KAH/n
        wJOWMwR4=; b=fGyVUkONaKJigNBFYrnqKj3ezte5IqtFquayEKvqmzqqM4hCM8V
        nnurvO5ArNiF2Dm13JD9m2UO7jt5Gj1aM6a+GNqTXFHY/gJBv5Plj8CdNQ54CvjM
        PmDYUR7zYpQhFqqmcIIhGLA4LvmiWLFWFxAPc3mDkLlTOku1FVdx2YkYkL/h7KoR
        o1IeQjfhZtKLbs583wica2o2FqWo+zPrRyBcmmvI1rYvThiivrkO3/kNMzy0DH3i
        ji9nZ1lyswh+CbPxlQAseStEtK7SI5+/4J0HTIjDZGjVwC5OjJtfiNAATLcZ0szn
        eXPJl7FvD+IV3tu7TLiHzD7oYWttjhwQE5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699355747; x=1699442147; bh=5VSgtHUh1HuE4TohSwLN46zKOkwRL3KAH/n
        wJOWMwR4=; b=ADiC1QJikQJrKK7jkh/NKDAbopzx++2zf6Ch3LTWYUOSD/miC55
        6YON7AC7wqit6szDZ3v/dJyDo/jOul53x1eXLOHAnM98aBSEWD6LmDdLpaeyIfKe
        fuv/aWblH8SJu86tI3UOH5apPjVeHD1Vz+FPv2sPKZ5OeWbT6+TkWhbxzczsZ9r4
        jh/IPTFvrSxiNySVhw3wNu4jWaFr1NQlyb6ju5GOVBHH9A9L/Xw0GV5sY706Aa2d
        hdYbBkRaexcOdVxuwtaElVzrH2EAiyGAw6fj4iWIZS9QlYizEOxxAZmOkFY9NPB9
        pL39aH0OlJFXBxf7U3AaVFQzKrfC+iptCUg==
X-ME-Sender: <xms:YxxKZWHhq9jqretEG74wym6zp1yWu5mTh6KQzdqXa4mqwJI7vPMCXA>
    <xme:YxxKZXU4DtlrgX7Creou_Co8kbZKlYqqbSbSABbeCkQgHwWDu961lHW7n-P13c8FC
    YZ1Pc0IvAK9A65xdnQ>
X-ME-Received: <xmr:YxxKZQKAA6sDIObsErb-fPlPhGAgQnFpJMOaw9aFe60bXQFJvVX0IN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduiedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:YxxKZQG5OvgSrWohLXBzCBltB0E68Vz1VoxwCbFwCS5CAy5Dv7w6qw>
    <xmx:YxxKZcVvZxr1zGecWrdyDlNPP7IiMp0E4fM9jRtAFQbZq4eF_9Fc6A>
    <xmx:YxxKZTMx-IxDk70EKxeQ8j8xefEl5tQTkWFM3WrD84NKWpw1scZvkw>
    <xmx:YxxKZWeqXeOpQTi7KXYg93Zxeu4Vtv0ya9V_rWb3q4P90jLHdrRJ4A>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 06:15:46 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Tue, 07 Nov 2023 11:15:19 +0000
Subject: [PATCH fixes v2 2/3] MIPS: Loongson64: Enable DMA noncoherent
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-loongson64_fixes-v2-2-5c49ceed7950@flygoat.com>
References: <20231107-loongson64_fixes-v2-0-5c49ceed7950@flygoat.com>
In-Reply-To: <20231107-loongson64_fixes-v2-0-5c49ceed7950@flygoat.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Support DMA noncoherent properly to get those systems working.

Cc: stable@vger.kernel.org
Fixes: 71e2f4dd5a65 ("MIPS: Fork loongson2ef from loongson64")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Style fixes
---
 arch/mips/Kconfig                                  |  2 ++
 arch/mips/include/asm/mach-loongson64/boot_param.h |  3 ++-
 arch/mips/loongson64/env.c                         | 10 +++++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

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
index c961e2999f15..ef3750a6ffac 100644
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
@@ -147,8 +149,14 @@ void __init prom_lefi_init_env(void)
 
 	loongson_sysconf.dma_mask_bits = eirq_source->dma_mask_bits;
 	if (loongson_sysconf.dma_mask_bits < 32 ||
-		loongson_sysconf.dma_mask_bits > 64)
+			loongson_sysconf.dma_mask_bits > 64) {
 		loongson_sysconf.dma_mask_bits = 32;
+		dma_default_coherent = true;
+	} else {
+		dma_default_coherent = !eirq_source->dma_noncoherent;
+	}
+
+	pr_info("Firmware: Coherent DMA: %s\n", dma_default_coherent ? "on" : "off");
 
 	loongson_sysconf.restart_addr = boot_p->reset_system.ResetWarm;
 	loongson_sysconf.poweroff_addr = boot_p->reset_system.Shutdown;

-- 
2.34.1

