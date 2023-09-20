Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047F87A8D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjITTun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjITTum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:50:42 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDBE9E;
        Wed, 20 Sep 2023 12:50:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5033918c09eso385947e87.2;
        Wed, 20 Sep 2023 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239434; x=1695844234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWC//1VDwpZ/BXBcYZgbJZ5FW8tYbZIyE13JuB9Qg8Y=;
        b=WQDOOwZzpxRoJ3c/RXfjjZlkJlIwZOno+CMl8wDD+WhQVaXguWew2XHdQZe721f1nK
         SF31UmiStBeWxXCrdmUA/8cc4eHkqW4p+tpvok8nyzN1v5Odt4GisnTK0qNid25j2ztv
         1YSyqSokrgwA/gxHkGDdQwGau9eWtiQJZDsdSI9+9uvYfOGrPu7h7dZNYwbU5/QTlmdj
         aQm453jXRu26bfHg7LMV93ZyYOYT6f2yipPlsS73/IYqajtp2oBDkBWuJd6mZaP2/PjO
         9HG5izX3YFYJHvdpf5ARyXvxQ/kplUH3Hv68PEgvk321JfjTJMccSrEwAfNvvyWxpebB
         2fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239434; x=1695844234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWC//1VDwpZ/BXBcYZgbJZ5FW8tYbZIyE13JuB9Qg8Y=;
        b=C9nmGobUeb0usn074ZdjhwN2KP5e/kBpv/VjZMBtGPkHYwtfW6cf6ApK4nyGXhdW4a
         +cxTGGvO6jb/HEVz0qAY5TKdckwRBncE35VzLGOI0EpgoF+Job/F2uPsNpmKdwEUaNww
         PSJ6bHV90EcwHSPCMMB1cPEony9l4BjzWlVrhS517e4vI84Nf2rkTC9NJZ73Zgqgql3e
         3de1nnU0QfWdxGd5FpV7k8xvTu9sRPZATEiRz4GlLklNCB+FRw4WSVnlvA9c5ASyG0d5
         0lxPA8888qQtjj0SK8hOSHIuo8muYevCOGMgkGflEtfyoLVq8cmzIwpd1naLj0vI7y+5
         FXEg==
X-Gm-Message-State: AOJu0Yz40s+x+RC6CW5WfCg4GIlSxiI19onOkPldM+Zxg98+WuMICc5y
        nwF5UjaDmRKN0PQA1C+Wze4mYuwQD7s=
X-Google-Smtp-Source: AGHT+IHl9bQqdS2KJb5XtEqsELvseVSuXh9tdWPDur97OTi1SeKgJauyCJnpn1BUq+4/XVCrCREzNw==
X-Received: by 2002:a19:5057:0:b0:503:2561:c8b with SMTP id z23-20020a195057000000b0050325610c8bmr2989096lfj.33.1695239433506;
        Wed, 20 Sep 2023 12:50:33 -0700 (PDT)
Received: from localhost ([178.176.81.142])
        by smtp.gmail.com with ESMTPSA id w26-20020ac2443a000000b004fe47879d93sm2798613lfl.106.2023.09.20.12.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:50:33 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/18] EDAC/synopsys: Add system address regions support
Date:   Wed, 20 Sep 2023 22:50:27 +0300
Message-ID: <20230920195030.31437-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aside with the Application, HIF and SDRAM address spaces DW uMCTL2 DDR
controller supports one more level of the address abstraction. It's the
System Address Regions (SARs). By default SARs are disabled by means of
the IP-core synthesize parameter UMCTL2_A_NSAR being set to zero. In that
case the System and Application address spaces match. But if that
parameter is set to a non-zero value (but less than or equal to 4), then
it's possible to define up to 4 disjoint memory regions mapping to the
SDRAM as consecutive addresses. So if the SARs are available on the
particular DW uMCTL2 DDR controller, they need to be taken into account in
order to get a correct Physical/DMA address by the SDRAM address and
vice-versa.

The SAR/Application address mapping support is implemented in the similar
way as it has been done for the HIF/SDRAM address translation: read the
mapping from the SARBASEn and SARSIZEn CSRs and save it in the
System/Application address mapping table as the regions base address, size
and offset; use the SARs mapping table to translate the system addresses
to the application addresses and vice-versa in the framework of the
sys-to-SDRAM and SDRAM-to-sys address translation chain. The described
functionality is utilized in the code requiring the address translation:
ECC errors detection and ECC data poisoning.

Note aside with the number of SARs there is the aUMCTL2_SARMINSIZE IP-core
parameter which indicates the SARs minimal block size. Alas it isn't
auto-detectable, but it's critical to have a correct mapping table. So the
suggested functionality expects it being specified for each particular
controller otherwise the system address regions support will be forcibly
disabled in the driver.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 191 ++++++++++++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 5384e93ec58c..d67a19fedb3c 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -15,6 +15,7 @@
 #include <linux/pfn.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
+#include <linux/sizes.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
@@ -92,6 +93,10 @@
 #define ECC_POISONPAT1_OFST		0x380
 #define ECC_POISONPAT2_OFST		0x384
 
+/* DDR SAR Registers */
+#define DDR_SARBASE0_OFST		0xF04
+#define DDR_SARSIZE0_OFST		0xF08
+
 /* ZynqMP DDR QOS Registers */
 #define ZYNQMP_DDR_QOS_IRQ_STAT_OFST	0x20200
 #define ZYNQMP_DDR_QOS_IRQ_EN_OFST	0x20208
@@ -220,6 +225,10 @@
 #define RANK_B0_BASE			6
 #define RANK_B1_BASE			7
 
+/* DDRC System Address parameters */
+#define DDR_MAX_NSAR			4
+#define DDR_MIN_SARSIZE			SZ_256M
+
 /* ZynqMP DDR QOS Interrupt register definitions */
 #define ZYNQMP_DDR_QOS_UE_MASK		BIT(2)
 #define ZYNQMP_DDR_QOS_CE_MASK		BIT(1)
@@ -310,6 +319,24 @@ struct snps_ddrc_info {
 	unsigned int ranks;
 };
 
+/**
+ * struct snps_sys_app_map - System/Application mapping table.
+ * @nsar:	Number of SARs enabled on the controller (max 4).
+ * @minsize:	Minimal block size (from 256MB to 32GB).
+ * @sar.base:	SAR base address aligned to minsize.
+ * @sar.size:	SAR size aligned to minsize.
+ * @sar.ofst:	SAR address offset.
+ */
+struct snps_sys_app_map {
+	u8 nsar;
+	u64 minsize;
+	struct {
+		u64 base;
+		u64 size;
+		u64 ofst;
+	} sar[DDR_MAX_NSAR];
+};
+
 /**
  * struct snps_hif_sdram_map - HIF/SDRAM mapping table.
  * @row:	HIF bit offsets used as row address bits.
@@ -378,6 +405,7 @@ struct snps_ecc_status {
 /**
  * struct snps_edac_priv - DDR memory controller private data.
  * @info:		DDR controller config info.
+ * @sys_app_map:	Sys/App mapping table.
  * @hif_sdram_map:	HIF/SDRAM mapping table.
  * @pdev:		Platform device.
  * @baseaddr:		Base address of the DDR controller.
@@ -388,6 +416,7 @@ struct snps_ecc_status {
  */
 struct snps_edac_priv {
 	struct snps_ddrc_info info;
+	struct snps_sys_app_map sys_app_map;
 	struct snps_hif_sdram_map hif_sdram_map;
 	struct platform_device *pdev;
 	void __iomem *baseaddr;
@@ -399,6 +428,77 @@ struct snps_edac_priv {
 #endif
 };
 
+/**
+ * snps_map_sys_to_app - Map System address to Application address.
+ * @priv:	DDR memory controller private instance data.
+ * @sys:	System address (source).
+ * @app:	Application address (destination).
+ *
+ * System address space is used to define disjoint memory regions
+ * mapped then to the contiguous application memory space:
+ *
+ *  System Address Space (SAR) <-> Application Address Space
+ *        +------+                        +------+
+ *        | SAR0 |----------------------->| Reg0 |
+ *        +------+       -offset          +------+
+ *        | ...  |           +----------->| Reg1 |
+ *        +------+           |            +------+
+ *        | SAR1 |-----------+            | ...  |
+ *        +------+
+ *        | ...  |
+ *
+ * The translation is done by applying the corresponding SAR offset
+ * to the inbound system address. Note according to the hardware reference
+ * manual the same mapping is applied to the addresses up to the next
+ * SAR base address irrespective to the region size.
+ */
+static void snps_map_sys_to_app(struct snps_edac_priv *priv,
+				dma_addr_t sys, u64 *app)
+{
+	struct snps_sys_app_map *map = &priv->sys_app_map;
+	u64 ofst;
+	int i;
+
+	ofst = 0;
+	for (i = 0; i < map->nsar; i++) {
+		if (sys < map->sar[i].base)
+			break;
+
+		ofst = map->sar[i].ofst;
+	}
+
+	*app = sys - ofst;
+}
+
+/**
+ * snps_map_sys_to_app - Map Application address to System address.
+ * @priv:	DDR memory controller private instance data.
+ * @app:	Application address (source).
+ * @sys:	System address (destination).
+ *
+ * Backward App-to-sys translation is easier because the application address
+ * space is contiguous. So we just need to add the offset corresponding
+ * to the region the passed address belongs to. Note the later offset is applied
+ * to all the addresses above the last available region.
+ */
+static void snps_map_app_to_sys(struct snps_edac_priv *priv,
+				u64 app, dma_addr_t *sys)
+{
+	struct snps_sys_app_map *map = &priv->sys_app_map;
+	u64 ofst, size;
+	int i;
+
+	ofst = 0;
+	for (i = 0, size = 0; i < map->nsar; i++) {
+		ofst = map->sar[i].ofst;
+		size += map->sar[i].size;
+		if (app < size)
+			break;
+	}
+
+	*sys = app + ofst;
+}
+
 /**
  * snps_map_app_to_hif - Map Application address to HIF address.
  * @priv:	DDR memory controller private instance data.
@@ -547,7 +647,7 @@ static void snps_map_sys_to_sdram(struct snps_edac_priv *priv,
 {
 	u64 app, hif;
 
-	app = sys;
+	snps_map_sys_to_app(priv, sys, &app);
 
 	snps_map_app_to_hif(priv, app, &hif);
 
@@ -572,7 +672,7 @@ static void snps_map_sdram_to_sys(struct snps_edac_priv *priv,
 
 	snps_map_hif_to_app(priv, hif, &app);
 
-	*sys = app;
+	snps_map_app_to_sys(priv, app, sys);
 }
 
 /**
@@ -976,6 +1076,52 @@ static int snps_get_ddrc_info(struct snps_edac_priv *priv)
 	return init_plat ? init_plat(priv) : 0;
 }
 
+/**
+ * snps_get_sys_app_map - Get System/Application address map.
+ * @priv:	DDR memory controller private instance data.
+ * @sarregs:	Array with SAR registers value.
+ *
+ * System address regions are defined by the SARBASEn and SARSIZEn registers.
+ * Controller reference manual requires the base addresses and sizes creating
+ * a set of ascending non-overlapped regions in order to have a linear
+ * application address space. Doing otherwise causes unpredictable results.
+ */
+static void snps_get_sys_app_map(struct snps_edac_priv *priv, u32 *sarregs)
+{
+	struct snps_sys_app_map *map = &priv->sys_app_map;
+	int i, ofst;
+
+	/*
+	 * SARs are supposed to be initialized in the ascending non-overlapped
+	 * order: base[i - 1] < base[i] < etc. If that rule is broken for a SAR
+	 * it's considered as no more SARs have been enabled, so the detection
+	 * procedure will halt. Having the very first SAR with zero base
+	 * address only makes sense if there is a consequent SAR.
+	 */
+	for (i = 0, ofst = 0; i < DDR_MAX_NSAR; i++) {
+		map->sar[i].base = sarregs[2 * i] * map->minsize;
+		if (map->sar[i].base)
+			map->nsar = i + 1;
+		else if (i && map->sar[i].base <= map->sar[i - 1].base)
+			break;
+
+		map->sar[i].size = (sarregs[2 * i + 1] + 1) * map->minsize;
+		map->sar[i].ofst = map->sar[i].base - ofst;
+		ofst += map->sar[i].size;
+	}
+
+	/*
+	 * SAR block size isn't auto-detectable. If one isn't specified for the
+	 * platform there is a good chance to have invalid mapping of the
+	 * detected SARs. So proceed with 1:1 mapping then.
+	 */
+	if (!map->minsize && map->nsar) {
+		edac_printk(KERN_WARNING, EDAC_MC,
+			    "No block size specified. Discard SARs mapping\n");
+		map->nsar = 0;
+	}
+}
+
 /**
  * snps_get_hif_row_map - Get HIF/SDRAM-row address map.
  * @priv:	DDR memory controller private instance data.
@@ -1225,9 +1371,14 @@ static void snps_get_hif_rank_map(struct snps_edac_priv *priv, u32 *addrmap)
  */
 static void snps_get_addr_map(struct snps_edac_priv *priv)
 {
-	u32 regval[DDR_ADDRMAP_NREGS];
+	u32 regval[max(DDR_ADDRMAP_NREGS, 2 * DDR_MAX_NSAR)];
 	int i;
 
+	for (i = 0; i < 2 * DDR_MAX_NSAR; i++)
+		regval[i] = readl(priv->baseaddr + DDR_SARBASE0_OFST + i * 4);
+
+	snps_get_sys_app_map(priv, regval);
+
 	for (i = 0; i < DDR_ADDRMAP_NREGS; i++)
 		regval[i] = readl(priv->baseaddr + DDR_ADDRMAP0_OFST + i * 4);
 
@@ -1418,6 +1569,37 @@ static int snps_ddrc_info_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(snps_ddrc_info);
 
+static int snps_sys_app_map_show(struct seq_file *s, void *data)
+{
+	struct mem_ctl_info *mci = s->private;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	struct snps_sys_app_map *map = &priv->sys_app_map;
+	u64 size;
+	int i;
+
+	if (!map->nsar) {
+		seq_puts(s, "No SARs detected\n");
+		return 0;
+	}
+
+	seq_printf(s, "%9s %-37s %-18s %-37s\n",
+		   "", "System address", "Offset", "App address");
+
+	for (i = 0, size = 0; i < map->nsar; i++) {
+		seq_printf(s, "Region %d: ", i);
+		seq_printf(s, "0x%016llx-0x%016llx ", map->sar[i].base,
+			   map->sar[i].base + map->sar[i].size - 1);
+		seq_printf(s, "0x%016llx ", map->sar[i].ofst);
+		seq_printf(s, "0x%016llx-0x%016llx\n", size,
+			   size + map->sar[i].size - 1);
+		size += map->sar[i].size;
+	}
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(snps_sys_app_map);
+
 static u8 snps_find_sdram_dim(struct snps_edac_priv *priv, u8 hif, char *dim)
 {
 	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
@@ -1615,6 +1797,9 @@ static void snps_create_debugfs_nodes(struct mem_ctl_info *mci)
 	edac_debugfs_create_file("ddrc_info", 0400, mci->debugfs, mci,
 				 &snps_ddrc_info_fops);
 
+	edac_debugfs_create_file("sys_app_map", 0400, mci->debugfs, mci,
+				 &snps_sys_app_map_fops);
+
 	edac_debugfs_create_file("hif_sdram_map", 0400, mci->debugfs, mci,
 				 &snps_hif_sdram_map_fops);
 
-- 
2.41.0

