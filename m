Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E3E7DE38D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjKAPRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjKAPRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:17:22 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82258191;
        Wed,  1 Nov 2023 08:16:49 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id D05445C026B;
        Wed,  1 Nov 2023 11:16:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 01 Nov 2023 11:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698851808; x=1698938208; bh=Mm+JRDBtZvObmZ+uO6jWZAPic1sg7YIcuKF
        rNlBR5/c=; b=URsyfAr2jR4DaeRxAEJ+ozYGQ20/t1waQFKOE81pCv3g7T84RR0
        OwtHcHTHsiXqsjq31xK6GsKqMbVlnwHYTiS9QJE+JAyzYhCQkafHtP1+KOpA2mxX
        3Ke/5whz4ByHA9i3yrSYG4BpV3Pw+px8M5dquDLq5pL0w1ACsP9laWypcxqZJxFT
        HuHRYuFds9mLbzj2eysMvR2p2rdXOCEnvFw/79QkkMlolJp4MZbFIJhXdSIVptua
        7L833q+E5UWgZSGmEcKhVz/wODc0CEN8cBo4FAm997uBMkOhekd96kwyvRSbW/Qf
        vu1ASJByIUGgrlDzVfxfIKralmNVpTADrYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698851808; x=1698938208; bh=Mm+JRDBtZvObmZ+uO6jWZAPic1sg7YIcuKF
        rNlBR5/c=; b=MD4x5sfy8SNN6nBRoBFlSo413yZMS8RRL93V+HN7If5+1cyGX8P
        jMpJaXDvMmONqHW1RmZ+WLU4VzNCo2/mpNiarlbY/f4yYGe+OYGRH5JyuB0Kmea3
        Gv3kQ/vgL2dc2LuJe5yKR3EUYcMNbzKrVu2Vno8DYBQGRKtPBdeIYLkd9+E987qt
        1EPShDJK046p9f1LodmUFNCOlQQqFTH0UWowTYklHjFYZgcNoD5S+K1/kff6qUNr
        jsfwvktaBHNN2++ZpECIEFfvqH4QOLXgLgbOlkRydhsiyeVC3l7jaad2VTwyz7xE
        2oLMY/VxCNo0k78K+9FGmJAmA/U/rQAQ3zw==
X-ME-Sender: <xms:4GtCZeX1evdsrZliOITD1jXH5K0dJS_M0xXR1aErXxUUSztPkvf6iA>
    <xme:4GtCZamMWGVce88SmFp0lIe9mjWVu51JMxy--I8_LAw8rZ1hgLaJoKp8DaJ8j_arZ
    x6HJ8HFG0vnMlEd7fs>
X-ME-Received: <xmr:4GtCZSYSQOZLqrV88Rgrl40sQWR1tJqEEO2bjIW_qKQp_F0VkB4F1MM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:4GtCZVVKgY2OKaWacaZvqcMSwkobraL04X1PUAyC_BX0AC18NS1kfQ>
    <xmx:4GtCZYnIdOHhDJq2_2lySTN775zySmevg0pyrOe8rvdm5UzFAHnn8A>
    <xmx:4GtCZacUFxgS5ECMseLqG3n8yJ4dj9xIrFrdMUZ-Eg00Vy058QyEDQ>
    <xmx:4GtCZZDIVEFax_WBJSbTB3LNDl3Pp_tj0IxfdipLOkp72qVKT8RUvA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 11:16:47 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Wed, 01 Nov 2023 11:39:09 +0000
Subject: [PATCH fixes 3/3] MIPS: Loongson64: Handle more memory types
 passed from firmware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-loongson64_fixes-v1-3-2a2582a4bfa9@flygoat.com>
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

There are many types of revsered memory passed from firmware
that should be reserved in memblock, and UMA memory passed
from firmware that should be added to system memory for system
to use.

Also for memblock there is no need to align those space into page,
which actually cause problems.

Handle them properly to prevent memory corruption on some systems.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/mach-loongson64/boot_param.h |  6 +++-
 arch/mips/loongson64/init.c                        | 42 +++++++++++++---------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index c454ef734c45..e007edd6b60a 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -14,7 +14,11 @@
 #define ADAPTER_ROM		8
 #define ACPI_TABLE		9
 #define SMBIOS_TABLE		10
-#define MAX_MEMORY_TYPE		11
+#define UMA_VIDEO_RAM		11
+#define VUMA_VIDEO_RAM		12
+#define MAX_MEMORY_TYPE		13
+
+#define MEM_SIZE_IS_IN_BYTES	(1 << 31)
 
 #define LOONGSON3_BOOT_MEM_MAP_MAX 128
 struct efi_memory_map_loongson {
diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
index d62262f93069..f25caa6aa9d3 100644
--- a/arch/mips/loongson64/init.c
+++ b/arch/mips/loongson64/init.c
@@ -49,8 +49,7 @@ void virtual_early_config(void)
 void __init szmem(unsigned int node)
 {
 	u32 i, mem_type;
-	static unsigned long num_physpages;
-	u64 node_id, node_psize, start_pfn, end_pfn, mem_start, mem_size;
+	phys_addr_t node_id, mem_start, mem_size;
 
 	/* Otherwise come from DTB */
 	if (loongson_sysconf.fw_interface != LOONGSON_LEFI)
@@ -64,27 +63,38 @@ void __init szmem(unsigned int node)
 
 		mem_type = loongson_memmap->map[i].mem_type;
 		mem_size = loongson_memmap->map[i].mem_size;
-		mem_start = loongson_memmap->map[i].mem_start;
+
+		/* Memory size comes in MB if MEM_SIZE_IS_IN_BYTES not set */
+		if (mem_size & MEM_SIZE_IS_IN_BYTES)
+			mem_size &= ~MEM_SIZE_IS_IN_BYTES;
+		else
+			mem_size = mem_size << 20;
+
+		mem_start = (node_id << 44) | loongson_memmap->map[i].mem_start;
 
 		switch (mem_type) {
 		case SYSTEM_RAM_LOW:
 		case SYSTEM_RAM_HIGH:
-			start_pfn = ((node_id << 44) + mem_start) >> PAGE_SHIFT;
-			node_psize = (mem_size << 20) >> PAGE_SHIFT;
-			end_pfn  = start_pfn + node_psize;
-			num_physpages += node_psize;
-			pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx MB\n",
-				(u32)node_id, mem_type, mem_start, mem_size);
-			pr_info("       start_pfn:0x%llx, end_pfn:0x%llx, num_physpages:0x%lx\n",
-				start_pfn, end_pfn, num_physpages);
-			memblock_add_node(PFN_PHYS(start_pfn),
-					  PFN_PHYS(node_psize), node,
+		case UMA_VIDEO_RAM:
+			pr_info("Node %d, mem_type:%d\t[%pa], %pa bytes usable\n",
+				(u32)node_id, mem_type, &mem_start, &mem_size);
+			memblock_add_node(mem_start, mem_size, node,
 					  MEMBLOCK_NONE);
 			break;
 		case SYSTEM_RAM_RESERVED:
-			pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx MB\n",
-				(u32)node_id, mem_type, mem_start, mem_size);
-			memblock_reserve(((node_id << 44) + mem_start), mem_size << 20);
+		case VIDEO_ROM:
+		case ADAPTER_ROM:
+		case ACPI_TABLE:
+		case SMBIOS_TABLE:
+			pr_info("Node %d, mem_type:%d\t[%pa], %pa bytes reserved\n",
+				(u32)node_id, mem_type, &mem_start, &mem_size);
+			memblock_reserve(mem_start, mem_size);
+			break;
+		/* We should not reserve VUMA_VIDEO_RAM as it overlaps with MMIO */
+		case VUMA_VIDEO_RAM:
+		default:
+			pr_info("Node %d, mem_type:%d\t[%pa], %pa bytes unhandled\n",
+				(u32)node_id, mem_type, &mem_start, &mem_size);
 			break;
 		}
 	}

-- 
2.34.1

