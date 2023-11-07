Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFC27E3AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjKGLQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjKGLPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:15:52 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DA291;
        Tue,  7 Nov 2023 03:15:49 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B8ACB5C00C3;
        Tue,  7 Nov 2023 06:15:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 07 Nov 2023 06:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1699355748; x=1699442148; bh=Mm+JRDBtZvObmZ+uO6jWZAPic1sg7YIcuKF
        rNlBR5/c=; b=ZgutTNumwvrMQGpNLynyX595KkXb8khTPQvzCl8bQRelwmW6sR8
        ZL6a1xeJhByoEXW9gKqpZOWsT681eMNHkfoPMYSWiCNNDCu6B2ZwFRMf6qnGKJKR
        XhdvuCIr0wySjHR13QT6bx6JJo9jafua7E4WdH4otWmPbRJXUCYSk1vqSw0kVaLK
        vnyfCNXvkS6B56MDGzfF9InkEGFH8E9/NbQIUruGYA6KHBNZK4ziHpBPRhEklxva
        u5kyElhodfRNxzIFlRBvDUZ7F4GqNGJEPmSag725ptkObt5do/VJn3I1kkmxfnpJ
        K/5DopC2QZylwJ/Nhq8kg9UH12saxp3RHuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699355748; x=1699442148; bh=Mm+JRDBtZvObmZ+uO6jWZAPic1sg7YIcuKF
        rNlBR5/c=; b=RXVpR9wwXujQRrtHExjLnvo4Wufi6GYIyA/k7kDomw7UlG5qTIG
        B8GOW01ACMzdhfXFc9FBAJZNC2EOP6MMEqwJBfuEyl9nt5y1ytGKNFdBJ51itpQ4
        tCB9L/NLE5iBnQ7jmimJgD5rtgH9fw0YPQYAoGSUichidkyqhUUuN/yz8OMywLEz
        UOGc3FTahRPc8NfJaDgSIS9g11jrmgtffmn2UmHysX16MqLbrdiNR0pWhGgmy9Vx
        InFxKRbu80TOXzDtHtIGJnxkQWe41eepWNLQrGBusxsQKc1bdDxFvwRunXjRHrRp
        kj+WTN0IG6tRLm2+JnobXyo/heVKSWm+6EQ==
X-ME-Sender: <xms:ZBxKZcH2gLxZgxpLs56D8lnVGvNDNd0sMVqCcatkGtdVeJXI53U8hg>
    <xme:ZBxKZVWSfEAHtGm5mfXeg6GpSmnrXYcPZeXMND9f0NBZxMMELhqt1WMe_q3GJzx51
    -qQSxkqrBtn-hbklAY>
X-ME-Received: <xmr:ZBxKZWIEP_T2NzWsckJSOe2YcXO5NMVK5NpcFQlN5-9xWPtPYtsvsX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduiedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:ZBxKZeFVAOh-lOoOXwaVkoFF0V7wUUYeGTIg4SJedHm94pJvpiOAmw>
    <xmx:ZBxKZSV7_Jo9V9htDuPVjuHHvoh6kn6ltTIAGaNOU3QaAwX_NbANOg>
    <xmx:ZBxKZRNJJvFjeZZPaixUSX12bfZ_zLWA2t5cqWDmnWTGm1Iy3YGRnQ>
    <xmx:ZBxKZUexpqjyC-LRq_0OPhmESL6vzJei6nul1zE2pe-FEyNuIttFMQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 06:15:47 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Tue, 07 Nov 2023 11:15:20 +0000
Subject: [PATCH fixes v2 3/3] MIPS: Loongson64: Handle more memory types
 passed from firmware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-loongson64_fixes-v2-3-5c49ceed7950@flygoat.com>
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

