Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A026F7A8C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjITTMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjITTMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:12:37 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89362F5;
        Wed, 20 Sep 2023 12:12:12 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50307759b65so382986e87.0;
        Wed, 20 Sep 2023 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237131; x=1695841931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDWGOcB/XNLWBgvGUvlChtIdjFViSo8WAZuKFQ14Sow=;
        b=YrsI0g48ic1xez8i5oB1I4d6FaCyUQ138ZLmkXbVItsrNiShse2rINhYXQOXMaYdyW
         6cynEcMjzHHS7T44P5v3IfSrcQCfERonOEt/ldZpvpUJb03/0edgTK0jXMpdZb9OoY9F
         lXEbSZSmoyWkoTdYwOHojRuzzUFNL3XmexlkoOyE0qhRBM/65DNNKLSDr3W3/OZOmN8e
         w2trrJjEQJrdDdDDjpq1xcbOwrscijKZBUZd/bip3g+vG4YMvm3FnOUap12Ln03FiKud
         9t6FXwphV8oRQrJHy98lg0z/MDFURmM1zx0AyHHrlS4Ztiogoz3CoG7/g+HGX3EyFfZ1
         d2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237131; x=1695841931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDWGOcB/XNLWBgvGUvlChtIdjFViSo8WAZuKFQ14Sow=;
        b=eHjctkvfyja1KXXX5eMae0c7VnxiDZbZ8peqTS2uVDssq5Bno9epGyyZN0LC5d5tzu
         YoYDJnixFsVzpeY1kwOkNY93Yasi0zahbSqGtJxpRkeRobmoQvVrsqye5hL6MvsBVr/R
         HQp4LuSmLfMytRGoDsrbvCdEJfstfmOtkovjT7SFZptigKcjuKRazPCCwy4Hd15EsHa1
         kjgWeUPAuxPxSNmHAYAITwdrdGW/HUH8uS8GokkW4I3WI3ErOrD+LnN8gVKq8nfLUqMI
         YO3hM6sUs/yrB8U2aGoNQ0EAwiyaA/d4htGJSctrDvDndIxQsQVsRAMtUeA1I2dXf30u
         HgDA==
X-Gm-Message-State: AOJu0Yyo6re5i8KQAXYoVsnlkgbdm6TqT5D2qBUnRvKwDiJsrjFIEBq7
        pA7KGWrsbs19xcrcXga+1sN+2beHxwc=
X-Google-Smtp-Source: AGHT+IFKhqWW/aVyIVzuOsHtXjddKWbWoS0znSn8jLcZuWc/OlPzpO5YCSBC71j4POJA4hQxftqlSg==
X-Received: by 2002:ac2:4e8b:0:b0:503:442:5957 with SMTP id o11-20020ac24e8b000000b0050304425957mr3155014lfr.41.1695237130497;
        Wed, 20 Sep 2023 12:12:10 -0700 (PDT)
Received: from localhost ([85.26.234.143])
        by smtp.gmail.com with ESMTPSA id v26-20020ac2559a000000b0050331960776sm810496lfg.34.2023.09.20.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:12:09 -0700 (PDT)
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
Subject: [PATCH v4 16/20] EDAC/synopsys: Detach Zynq A05 DDRC support to separate driver
Date:   Wed, 20 Sep 2023 22:10:40 +0300
Message-ID: <20230920191059.28395-17-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synopsys_edac.c driver currently supports three memory-controllers:
1. Synopsys DW uMCTL2 DDRC v3.80 (with the ZynqMP-specific params).
2. Xilinx ZynqMP DDRC Synopsys DW uMCTL2 DDRC v2.40.
3. Xilinx Zynq A05 DDR controller.
If the first two devices are based on the Synopsys DW uMCTL2 IP-cores
(ZynqMP MC is based on the DW uMCTL2 v2.40) the later device has
absolutely nothing in common with the Synopsys DW uMCTL2 DDR controllers:
the CSRs map is absolutely different; it doesn't support IRQs unlike
the Synopsys memory controllers. Having the driver to support so different
devices caused implementing an additional level of abstraction, which will
be a great deal of obstacle in about to be added comprehensive set of the
Synopsys DDR-controller features (DW uCMTL2 IP-core parameters
auto-detection, common SDRAM<->phys address translation, multi-ranked
memory, ECC scrubber, individual IRQs, DFI alert_n IRQ, and so on).
Moreover the original reason of having these devices support living in a
single driver hasn't been introduced for all these years: the
synopsys_edac.c driver currently supports only a single memory controller
detected on the system.

So in order to make the Synopsys driver ready for the new features added
move the Xilinx Zynq A05 DDRC support into a separate driver: detach the
Zynq-specific callbacks, init/probe/remove methods and move them into the
new zynq_edac.c driver. The resultant driver will mostly look similar to
the code submitted in the initial commit ae9b56e3996d ("EDAC, synps: Add
EDAC support for zynq ddr ecc controller") except a few fixes added
afterwards.

Note several Zynq-specific macros have been used in the DW uMCTL2
DDRC-specific functions. These macros just for a mere coincident have
values suitable for the DW uMCTL2 code but their names either partly or
fully unrelated with the Synopsys memory controllers. Since these macros
are now moved to another driver introduce a new Synopsys-specific ones and
fix the places where the macros have been improperly utilized.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v3:
- Drop the no longer used "priv" pointer from the zynq_mc_init() function.
  (@tbot)
---
 MAINTAINERS                  |   1 +
 drivers/edac/Kconfig         |   9 +-
 drivers/edac/Makefile        |   1 +
 drivers/edac/synopsys_edac.c | 239 ++---------------
 drivers/edac/zynq_edac.c     | 501 +++++++++++++++++++++++++++++++++++
 5 files changed, 531 insertions(+), 220 deletions(-)
 create mode 100644 drivers/edac/zynq_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 53b7ca804465..bd03b98b5e47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2977,6 +2977,7 @@ F:	arch/arm/mach-zynq/
 F:	drivers/clocksource/timer-cadence-ttc.c
 F:	drivers/cpuidle/cpuidle-zynq.c
 F:	drivers/edac/synopsys_edac.c
+F:	drivers/edac/zynq_edac.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/i2c/busses/i2c-xiic.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 110e99b86a66..eaac35c27e5c 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -487,7 +487,7 @@ config EDAC_ARMADA_XP
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || ARCH_MXC
+	depends on ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || ARCH_MXC
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
@@ -561,4 +561,11 @@ config EDAC_NPCM
 	  error detection (in-line ECC in which a section 1/8th of the memory
 	  device used to store data is used for ECC storage).
 
+config EDAC_ZYNQ
+	tristate "Xilinx Zynq A05 DDR Memory Controller"
+	depends on ARCH_ZYNQ || COMPILE_TEST
+	help
+	  Support for error detection and correction on the Xilinx Zynq A05
+	  DDR memory controller.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 61945d3113cc..4f85923e18ec 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -85,4 +85,5 @@ obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
 obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
+obj-$(CONFIG_EDAC_ZYNQ)			+= zynq_edac.o
 obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 62f498b6dfed..783a4df7eeac 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -30,68 +30,16 @@
 #define SYNPS_EDAC_MOD_STRING		"synps_edac"
 #define SYNPS_EDAC_MOD_VER		"1"
 
-/* Synopsys DDR memory controller registers that are relevant to ECC */
-#define CTRL_OFST			0x0
-#define T_ZQ_OFST			0xA4
-
-/* ECC control register */
-#define ECC_CTRL_OFST			0xC4
-/* ECC log register */
-#define CE_LOG_OFST			0xC8
-/* ECC address register */
-#define CE_ADDR_OFST			0xCC
-/* ECC data[31:0] register */
-#define CE_DATA_31_0_OFST		0xD0
-
-/* Uncorrectable error info registers */
-#define UE_LOG_OFST			0xDC
-#define UE_ADDR_OFST			0xE0
-#define UE_DATA_31_0_OFST		0xE4
-
-#define STAT_OFST			0xF0
-#define SCRUB_OFST			0xF4
-
-/* Control register bit field definitions */
-#define CTRL_BW_MASK			0xC
-#define CTRL_BW_SHIFT			2
-
-#define DDRCTL_WDTH_16			1
-#define DDRCTL_WDTH_32			0
-
-/* ZQ register bit field definitions */
-#define T_ZQ_DDRMODE_MASK		0x2
-
-/* ECC control register bit field definitions */
-#define ECC_CTRL_CLR_CE_ERR		0x2
-#define ECC_CTRL_CLR_UE_ERR		0x1
-
-/* ECC correctable/uncorrectable error log register definitions */
-#define LOG_VALID			0x1
-#define CE_LOG_BITPOS_MASK		0xFE
-#define CE_LOG_BITPOS_SHIFT		1
-
-/* ECC correctable/uncorrectable error address register definitions */
-#define ADDR_COL_MASK			0xFFF
-#define ADDR_ROW_MASK			0xFFFF000
-#define ADDR_ROW_SHIFT			12
-#define ADDR_BANK_MASK			0x70000000
-#define ADDR_BANK_SHIFT			28
-
-/* ECC statistic register definitions */
-#define STAT_UECNT_MASK			0xFF
-#define STAT_CECNT_MASK			0xFF00
-#define STAT_CECNT_SHIFT		8
-
-/* ECC scrub register definitions */
-#define SCRUB_MODE_MASK			0x7
-#define SCRUB_MODE_SECDED		0x4
-
 /* DDR ECC Quirks */
 #define DDR_ECC_INTR_SUPPORT		BIT(0)
 #define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
 #define SYNPS_ZYNQMP_IRQ_REGS		BIT(2)
 
-/* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
+/* Synopsys DDR memory controller registers that are relevant to ECC */
+
+/* DDRC Master 0 Register */
+#define DDR_MSTR_OFST			0x0
+
 /* ECC Configuration Registers */
 #define ECC_CFG0_OFST			0x70
 #define ECC_CFG1_OFST			0x74
@@ -135,16 +83,22 @@
 #define ECC_ADDRMAP0_OFFSET		0x200
 
 /* Control register bitfield definitions */
-#define ECC_CTRL_BUSWIDTH_MASK		0x3000
-#define ECC_CTRL_BUSWIDTH_SHIFT		12
+#define ECC_CTRL_CLR_CE_ERR		BIT(0)
+#define ECC_CTRL_CLR_UE_ERR		BIT(1)
 #define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
 #define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
 
 /* DDR Control Register width definitions  */
+#define DDR_MSTR_BUSWIDTH_MASK		0x3000
+#define DDR_MSTR_BUSWIDTH_SHIFT		12
 #define DDRCTL_EWDTH_16			2
 #define DDRCTL_EWDTH_32			1
 #define DDRCTL_EWDTH_64			0
 
+/* ECC CFG0 register definitions */
+#define ECC_CFG0_MODE_MASK		0x7
+#define ECC_CFG0_MODE_SECDED		0x4
+
 /* ECC status register definitions */
 #define ECC_STAT_UECNT_MASK		0xF0000
 #define ECC_STAT_UECNT_SHIFT		16
@@ -342,61 +296,6 @@ struct synps_platform_data {
 	int quirks;
 };
 
-/**
- * zynq_get_error_info - Get the current ECC error info.
- * @priv:	DDR memory controller private instance data.
- *
- * Return: one if there is no error, otherwise zero.
- */
-static int zynq_get_error_info(struct synps_edac_priv *priv)
-{
-	struct synps_ecc_status *p;
-	u32 regval, clearval = 0;
-	void __iomem *base;
-
-	base = priv->baseaddr;
-	p = &priv->stat;
-
-	regval = readl(base + STAT_OFST);
-	if (!regval)
-		return 1;
-
-	p->ce_cnt = (regval & STAT_CECNT_MASK) >> STAT_CECNT_SHIFT;
-	p->ue_cnt = regval & STAT_UECNT_MASK;
-
-	regval = readl(base + CE_LOG_OFST);
-	if (!(p->ce_cnt && (regval & LOG_VALID)))
-		goto ue_err;
-
-	p->ceinfo.bitpos = (regval & CE_LOG_BITPOS_MASK) >> CE_LOG_BITPOS_SHIFT;
-	regval = readl(base + CE_ADDR_OFST);
-	p->ceinfo.row = (regval & ADDR_ROW_MASK) >> ADDR_ROW_SHIFT;
-	p->ceinfo.col = regval & ADDR_COL_MASK;
-	p->ceinfo.bank = (regval & ADDR_BANK_MASK) >> ADDR_BANK_SHIFT;
-	p->ceinfo.data = readl(base + CE_DATA_31_0_OFST);
-	edac_dbg(3, "CE bit position: %d data: %d\n", p->ceinfo.bitpos,
-		 p->ceinfo.data);
-	clearval = ECC_CTRL_CLR_CE_ERR;
-
-ue_err:
-	regval = readl(base + UE_LOG_OFST);
-	if (!(p->ue_cnt && (regval & LOG_VALID)))
-		goto out;
-
-	regval = readl(base + UE_ADDR_OFST);
-	p->ueinfo.row = (regval & ADDR_ROW_MASK) >> ADDR_ROW_SHIFT;
-	p->ueinfo.col = regval & ADDR_COL_MASK;
-	p->ueinfo.bank = (regval & ADDR_BANK_MASK) >> ADDR_BANK_SHIFT;
-	p->ueinfo.data = readl(base + UE_DATA_31_0_OFST);
-	clearval |= ECC_CTRL_CLR_UE_ERR;
-
-out:
-	writel(clearval, base + ECC_CTRL_OFST);
-	writel(0x0, base + ECC_CTRL_OFST);
-
-	return 0;
-}
-
 /**
  * zynqmp_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
@@ -615,37 +514,6 @@ static void check_errors(struct mem_ctl_info *mci)
 	handle_error(mci, &priv->stat);
 }
 
-/**
- * zynq_get_dtype - Return the controller memory width.
- * @base:	DDR memory controller base address.
- *
- * Get the EDAC device type width appropriate for the current controller
- * configuration.
- *
- * Return: a device type width enumeration.
- */
-static enum dev_type zynq_get_dtype(const void __iomem *base)
-{
-	enum dev_type dt;
-	u32 width;
-
-	width = readl(base + CTRL_OFST);
-	width = (width & CTRL_BW_MASK) >> CTRL_BW_SHIFT;
-
-	switch (width) {
-	case DDRCTL_WDTH_16:
-		dt = DEV_X2;
-		break;
-	case DDRCTL_WDTH_32:
-		dt = DEV_X4;
-		break;
-	default:
-		dt = DEV_UNKNOWN;
-	}
-
-	return dt;
-}
-
 /**
  * zynqmp_get_dtype - Return the controller memory width.
  * @base:	DDR memory controller base address.
@@ -659,7 +527,7 @@ static enum dev_type zynqmp_get_dtype(const void __iomem *base)
 {
 	u32 regval;
 
-	regval = readl(base + CTRL_OFST);
+	regval = readl(base + DDR_MSTR_OFST);
 	if (!(regval & MEM_TYPE_DDR4))
 		return DEV_UNKNOWN;
 
@@ -678,30 +546,6 @@ static enum dev_type zynqmp_get_dtype(const void __iomem *base)
 	return DEV_UNKNOWN;
 }
 
-/**
- * zynq_get_ecc_state - Return the controller ECC enable/disable status.
- * @base:	DDR memory controller base address.
- *
- * Get the ECC enable/disable status of the controller.
- *
- * Return: true if enabled, otherwise false.
- */
-static bool zynq_get_ecc_state(void __iomem *base)
-{
-	enum dev_type dt;
-	u32 ecctype;
-
-	dt = zynq_get_dtype(base);
-	if (dt == DEV_UNKNOWN)
-		return false;
-
-	ecctype = readl(base + SCRUB_OFST) & SCRUB_MODE_MASK;
-	if ((ecctype == SCRUB_MODE_SECDED) && (dt == DEV_X2))
-		return true;
-
-	return false;
-}
-
 /**
  * zynqmp_get_ecc_state - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
@@ -714,9 +558,9 @@ static bool zynqmp_get_ecc_state(void __iomem *base)
 {
 	u32 regval;
 
-	regval = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+	regval = readl(base + ECC_CFG0_OFST) & ECC_CFG0_MODE_MASK;
 
-	return (regval == SCRUB_MODE_SECDED);
+	return (regval == ECC_CFG0_MODE_SECDED);
 }
 
 /**
@@ -733,30 +577,6 @@ static u32 get_memsize(void)
 	return inf.totalram * inf.mem_unit;
 }
 
-/**
- * zynq_get_mtype - Return the controller memory type.
- * @base:	Synopsys ECC status structure.
- *
- * Get the EDAC memory type appropriate for the current controller
- * configuration.
- *
- * Return: a memory type enumeration.
- */
-static enum mem_type zynq_get_mtype(const void __iomem *base)
-{
-	enum mem_type mt;
-	u32 memtype;
-
-	memtype = readl(base + T_ZQ_OFST);
-
-	if (memtype & T_ZQ_DDRMODE_MASK)
-		mt = MEM_DDR3;
-	else
-		mt = MEM_DDR2;
-
-	return mt;
-}
-
 /**
  * zynqmp_get_mtype - Returns controller memory type.
  * @base:	Synopsys ECC status structure.
@@ -771,7 +591,7 @@ static enum mem_type zynqmp_get_mtype(const void __iomem *base)
 	enum mem_type mt;
 	u32 memtype;
 
-	memtype = readl(base + CTRL_OFST);
+	memtype = readl(base + DDR_MSTR_OFST);
 
 	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
 		mt = MEM_DDR3;
@@ -883,14 +703,6 @@ static int setup_irq(struct mem_ctl_info *mci,
 	return 0;
 }
 
-static const struct synps_platform_data zynq_edac_def = {
-	.get_error_info	= zynq_get_error_info,
-	.get_mtype	= zynq_get_mtype,
-	.get_dtype	= zynq_get_dtype,
-	.get_ecc_state	= zynq_get_ecc_state,
-	.quirks		= 0,
-};
-
 static const struct synps_platform_data zynqmp_edac_def = {
 	.get_error_info	= zynqmp_get_error_info,
 	.get_mtype	= zynqmp_get_mtype,
@@ -917,10 +729,6 @@ static const struct synps_platform_data synopsys_edac_def = {
 
 
 static const struct of_device_id synps_edac_match[] = {
-	{
-		.compatible = "xlnx,zynq-ddrc-a05",
-		.data = (void *)&zynq_edac_def
-	},
 	{
 		.compatible = "xlnx,zynqmp-ddrc-2.40a",
 		.data = (void *)&zynqmp_edac_def
@@ -1142,8 +950,8 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 	u32 width, memtype;
 	int index;
 
-	memtype = readl(priv->baseaddr + CTRL_OFST);
-	width = (memtype & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+	memtype = readl(priv->baseaddr + DDR_MSTR_OFST);
+	width = (memtype & DDR_MSTR_BUSWIDTH_MASK) >> DDR_MSTR_BUSWIDTH_SHIFT;
 
 	priv->col_shift[0] = 0;
 	priv->col_shift[1] = 1;
@@ -1338,7 +1146,7 @@ static int mc_probe(struct platform_device *pdev)
 	layers[1].size = SYNPS_EDAC_NR_CHANS;
 	layers[1].is_virt_csrow = false;
 
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
+	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers,
 			    sizeof(struct synps_edac_priv));
 	if (!mci) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -1380,13 +1188,6 @@ static int mc_probe(struct platform_device *pdev)
 		setup_address_map(priv);
 #endif
 
-	/*
-	 * Start capturing the correctable and uncorrectable errors. A write of
-	 * 0 starts the counters.
-	 */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
-		writel(0x0, baseaddr + ECC_CTRL_OFST);
-
 	return rc;
 
 free_edac_mc:
diff --git a/drivers/edac/zynq_edac.c b/drivers/edac/zynq_edac.c
new file mode 100644
index 000000000000..0781e69e019c
--- /dev/null
+++ b/drivers/edac/zynq_edac.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Zynq DDR ECC Driver
+ * This driver is based on ppc4xx_edac.c drivers
+ *
+ * Copyright (C) 2012 - 2014 Xilinx, Inc.
+ */
+
+#include <linux/edac.h>
+#include <linux/interrupt.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "edac_module.h"
+
+/* Number of cs_rows needed per memory controller */
+#define ZYNQ_EDAC_NR_CSROWS		1
+
+/* Number of channels per memory controller */
+#define ZYNQ_EDAC_NR_CHANS		1
+
+/* Granularity of reported error in bytes */
+#define ZYNQ_EDAC_ERR_GRAIN		1
+
+#define ZYNQ_EDAC_MSG_SIZE		256
+
+#define ZYNQ_EDAC_MOD_STRING		"zynq_edac"
+#define ZYNQ_EDAC_MOD_VER		"1"
+
+/* Zynq DDR memory controller ECC registers */
+#define ZYNQ_CTRL_OFST			0x0
+#define ZYNQ_T_ZQ_OFST			0xA4
+
+/* ECC control register */
+#define ZYNQ_ECC_CTRL_OFST		0xC4
+/* ECC log register */
+#define ZYNQ_CE_LOG_OFST		0xC8
+/* ECC address register */
+#define ZYNQ_CE_ADDR_OFST		0xCC
+/* ECC data[31:0] register */
+#define ZYNQ_CE_DATA_31_0_OFST		0xD0
+
+/* Uncorrectable error info registers */
+#define ZYNQ_UE_LOG_OFST		0xDC
+#define ZYNQ_UE_ADDR_OFST		0xE0
+#define ZYNQ_UE_DATA_31_0_OFST		0xE4
+
+#define ZYNQ_STAT_OFST			0xF0
+#define ZYNQ_SCRUB_OFST			0xF4
+
+/* Control register bit field definitions */
+#define ZYNQ_CTRL_BW_MASK		0xC
+#define ZYNQ_CTRL_BW_SHIFT		2
+
+#define ZYNQ_DDRCTL_WDTH_16		1
+#define ZYNQ_DDRCTL_WDTH_32		0
+
+/* ZQ register bit field definitions */
+#define ZYNQ_T_ZQ_DDRMODE_MASK		0x2
+
+/* ECC control register bit field definitions */
+#define ZYNQ_ECC_CTRL_CLR_CE_ERR	0x2
+#define ZYNQ_ECC_CTRL_CLR_UE_ERR	0x1
+
+/* ECC correctable/uncorrectable error log register definitions */
+#define ZYNQ_LOG_VALID			0x1
+#define ZYNQ_CE_LOG_BITPOS_MASK		0xFE
+#define ZYNQ_CE_LOG_BITPOS_SHIFT	1
+
+/* ECC correctable/uncorrectable error address register definitions */
+#define ZYNQ_ADDR_COL_MASK		0xFFF
+#define ZYNQ_ADDR_ROW_MASK		0xFFFF000
+#define ZYNQ_ADDR_ROW_SHIFT		12
+#define ZYNQ_ADDR_BANK_MASK		0x70000000
+#define ZYNQ_ADDR_BANK_SHIFT		28
+
+/* ECC statistic register definitions */
+#define ZYNQ_STAT_UECNT_MASK		0xFF
+#define ZYNQ_STAT_CECNT_MASK		0xFF00
+#define ZYNQ_STAT_CECNT_SHIFT		8
+
+/* ECC scrub register definitions */
+#define ZYNQ_SCRUB_MODE_MASK		0x7
+#define ZYNQ_SCRUB_MODE_SECDED		0x4
+
+/**
+ * struct zynq_ecc_error_info - ECC error log information.
+ * @row:	Row number.
+ * @col:	Column number.
+ * @bank:	Bank number.
+ * @bitpos:	Bit position.
+ * @data:	Data causing the error.
+ */
+struct zynq_ecc_error_info {
+	u32 row;
+	u32 col;
+	u32 bank;
+	u32 bitpos;
+	u32 data;
+};
+
+/**
+ * struct zynq_ecc_status - ECC status information to report.
+ * @ce_cnt:	Correctable error count.
+ * @ue_cnt:	Uncorrectable error count.
+ * @ceinfo:	Correctable error log information.
+ * @ueinfo:	Uncorrectable error log information.
+ */
+struct zynq_ecc_status {
+	u32 ce_cnt;
+	u32 ue_cnt;
+	struct zynq_ecc_error_info ceinfo;
+	struct zynq_ecc_error_info ueinfo;
+};
+
+/**
+ * struct zynq_edac_priv - DDR memory controller private instance data.
+ * @baseaddr:	Base address of the DDR controller.
+ * @message:	Buffer for framing the event specific info.
+ * @stat:	ECC status information.
+ */
+struct zynq_edac_priv {
+	void __iomem *baseaddr;
+	char message[ZYNQ_EDAC_MSG_SIZE];
+	struct zynq_ecc_status stat;
+};
+
+/**
+ * zynq_get_error_info - Get the current ECC error info.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: one if there is no error, otherwise zero.
+ */
+static int zynq_get_error_info(struct zynq_edac_priv *priv)
+{
+	struct zynq_ecc_status *p;
+	u32 regval, clearval = 0;
+	void __iomem *base;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
+
+	regval = readl(base + ZYNQ_STAT_OFST);
+	if (!regval)
+		return 1;
+
+	p->ce_cnt = (regval & ZYNQ_STAT_CECNT_MASK) >> ZYNQ_STAT_CECNT_SHIFT;
+	p->ue_cnt = regval & ZYNQ_STAT_UECNT_MASK;
+
+	regval = readl(base + ZYNQ_CE_LOG_OFST);
+	if (!(p->ce_cnt && (regval & ZYNQ_LOG_VALID)))
+		goto ue_err;
+
+	p->ceinfo.bitpos = (regval & ZYNQ_CE_LOG_BITPOS_MASK) >> ZYNQ_CE_LOG_BITPOS_SHIFT;
+	regval = readl(base + ZYNQ_CE_ADDR_OFST);
+	p->ceinfo.row = (regval & ZYNQ_ADDR_ROW_MASK) >> ZYNQ_ADDR_ROW_SHIFT;
+	p->ceinfo.col = regval & ZYNQ_ADDR_COL_MASK;
+	p->ceinfo.bank = (regval & ZYNQ_ADDR_BANK_MASK) >> ZYNQ_ADDR_BANK_SHIFT;
+	p->ceinfo.data = readl(base + ZYNQ_CE_DATA_31_0_OFST);
+	edac_dbg(3, "CE bit position: %d data: %d\n", p->ceinfo.bitpos,
+		 p->ceinfo.data);
+	clearval = ZYNQ_ECC_CTRL_CLR_CE_ERR;
+
+ue_err:
+	regval = readl(base + ZYNQ_UE_LOG_OFST);
+	if (!(p->ue_cnt && (regval & ZYNQ_LOG_VALID)))
+		goto out;
+
+	regval = readl(base + ZYNQ_UE_ADDR_OFST);
+	p->ueinfo.row = (regval & ZYNQ_ADDR_ROW_MASK) >> ZYNQ_ADDR_ROW_SHIFT;
+	p->ueinfo.col = regval & ZYNQ_ADDR_COL_MASK;
+	p->ueinfo.bank = (regval & ZYNQ_ADDR_BANK_MASK) >> ZYNQ_ADDR_BANK_SHIFT;
+	p->ueinfo.data = readl(base + ZYNQ_UE_DATA_31_0_OFST);
+	clearval |= ZYNQ_ECC_CTRL_CLR_UE_ERR;
+
+out:
+	writel(clearval, base + ZYNQ_ECC_CTRL_OFST);
+	writel(0x0, base + ZYNQ_ECC_CTRL_OFST);
+
+	return 0;
+}
+
+/**
+ * handle_error - Handle Correctable and Uncorrectable errors.
+ * @mci:	EDAC memory controller instance.
+ * @p:		Zynq ECC status structure.
+ *
+ * Handles ECC correctable and uncorrectable errors.
+ */
+static void zynq_handle_error(struct mem_ctl_info *mci, struct zynq_ecc_status *p)
+{
+	struct zynq_edac_priv *priv = mci->pvt_info;
+	struct zynq_ecc_error_info *pinf;
+
+	if (p->ce_cnt) {
+		pinf = &p->ceinfo;
+
+		snprintf(priv->message, ZYNQ_EDAC_MSG_SIZE,
+			 "Row %d Bank %d Col %d Bit %d Data 0x%08x",
+			 pinf->row, pinf->bank, pinf->col,
+			 pinf->bitpos, pinf->data);
+
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
+				     priv->message, "");
+	}
+
+	if (p->ue_cnt) {
+		pinf = &p->ueinfo;
+
+		snprintf(priv->message, ZYNQ_EDAC_MSG_SIZE,
+			 "Row %d Bank %d Col %d",
+			 pinf->row, pinf->bank, pinf->col);
+
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
+				     priv->message, "");
+	}
+
+	memset(p, 0, sizeof(*p));
+}
+
+/**
+ * check_errors - Check controller for ECC errors.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Check and post ECC errors. Called by the polling thread.
+ */
+static void zynq_check_errors(struct mem_ctl_info *mci)
+{
+	struct zynq_edac_priv *priv = mci->pvt_info;
+	int status;
+
+	status = zynq_get_error_info(priv);
+	if (status)
+		return;
+
+	zynq_handle_error(mci, &priv->stat);
+}
+
+/**
+ * zynq_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the EDAC device type width appropriate for the current controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type zynq_get_dtype(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 width;
+
+	width = readl(base + ZYNQ_CTRL_OFST);
+	width = (width & ZYNQ_CTRL_BW_MASK) >> ZYNQ_CTRL_BW_SHIFT;
+
+	switch (width) {
+	case ZYNQ_DDRCTL_WDTH_16:
+		dt = DEV_X2;
+		break;
+	case ZYNQ_DDRCTL_WDTH_32:
+		dt = DEV_X4;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
+
+	return dt;
+}
+
+/**
+ * zynq_get_ecc_state - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the ECC enable/disable status of the controller.
+ *
+ * Return: true if enabled, otherwise false.
+ */
+static bool zynq_get_ecc_state(void __iomem *base)
+{
+	enum dev_type dt;
+	u32 ecctype;
+
+	dt = zynq_get_dtype(base);
+	if (dt == DEV_UNKNOWN)
+		return false;
+
+	ecctype = readl(base + ZYNQ_SCRUB_OFST) & ZYNQ_SCRUB_MODE_MASK;
+	if ((ecctype == ZYNQ_SCRUB_MODE_SECDED) && (dt == DEV_X2))
+		return true;
+
+	return false;
+}
+
+/**
+ * zynq_get_memsize - Read the size of the attached memory device.
+ *
+ * Return: the memory size in bytes.
+ */
+static u32 zynq_get_memsize(void)
+{
+	struct sysinfo inf;
+
+	si_meminfo(&inf);
+
+	return inf.totalram * inf.mem_unit;
+}
+
+/**
+ * zynq_get_mtype - Return the controller memory type.
+ * @base:	Zynq ECC status structure.
+ *
+ * Get the EDAC memory type appropriate for the current controller
+ * configuration.
+ *
+ * Return: a memory type enumeration.
+ */
+static enum mem_type zynq_get_mtype(const void __iomem *base)
+{
+	enum mem_type mt;
+	u32 memtype;
+
+	memtype = readl(base + ZYNQ_T_ZQ_OFST);
+
+	if (memtype & ZYNQ_T_ZQ_DDRMODE_MASK)
+		mt = MEM_DDR3;
+	else
+		mt = MEM_DDR2;
+
+	return mt;
+}
+
+/**
+ * zynq_init_csrows - Initialize the csrow data.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Initialize the chip select rows associated with the EDAC memory
+ * controller instance.
+ */
+static void zynq_init_csrows(struct mem_ctl_info *mci)
+{
+	struct zynq_edac_priv *priv = mci->pvt_info;
+	struct csrow_info *csi;
+	struct dimm_info *dimm;
+	u32 size, row;
+	int j;
+
+	for (row = 0; row < mci->nr_csrows; row++) {
+		csi = mci->csrows[row];
+		size = zynq_get_memsize();
+
+		for (j = 0; j < csi->nr_channels; j++) {
+			dimm		= csi->channels[j]->dimm;
+			dimm->edac_mode	= EDAC_SECDED;
+			dimm->mtype	= zynq_get_mtype(priv->baseaddr);
+			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
+			dimm->grain	= ZYNQ_EDAC_ERR_GRAIN;
+			dimm->dtype	= zynq_get_dtype(priv->baseaddr);
+		}
+	}
+}
+
+/**
+ * zynq_mc_init - Initialize one driver instance.
+ * @mci:	EDAC memory controller instance.
+ * @pdev:	platform device.
+ *
+ * Perform initialization of the EDAC memory controller instance and
+ * related driver-private data associated with the memory controller the
+ * instance is bound to.
+ */
+static void zynq_mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
+{
+	mci->pdev = &pdev->dev;
+	platform_set_drvdata(pdev, mci);
+
+	/* Initialize controller capabilities and configuration */
+	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
+	mci->scrub_mode = SCRUB_NONE;
+
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->ctl_name = "zynq_ddr_controller";
+	mci->dev_name = ZYNQ_EDAC_MOD_STRING;
+	mci->mod_name = ZYNQ_EDAC_MOD_VER;
+
+	edac_op_state = EDAC_OPSTATE_POLL;
+	mci->edac_check = zynq_check_errors;
+
+	mci->ctl_page_to_phys = NULL;
+
+	zynq_init_csrows(mci);
+}
+
+/**
+ * zynq_mc_probe - Check controller and bind driver.
+ * @pdev:	platform device.
+ *
+ * Probe a specific controller instance for binding with the driver.
+ *
+ * Return: 0 if the controller instance was successfully bound to the
+ * driver; otherwise, < 0 on error.
+ */
+static int zynq_mc_probe(struct platform_device *pdev)
+{
+	struct edac_mc_layer layers[2];
+	struct zynq_edac_priv *priv;
+	struct mem_ctl_info *mci;
+	void __iomem *baseaddr;
+	int rc;
+
+	baseaddr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(baseaddr))
+		return PTR_ERR(baseaddr);
+
+	if (!zynq_get_ecc_state(baseaddr)) {
+		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
+		return -ENXIO;
+	}
+
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = ZYNQ_EDAC_NR_CSROWS;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = ZYNQ_EDAC_NR_CHANS;
+	layers[1].is_virt_csrow = false;
+
+	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers,
+			    sizeof(struct zynq_edac_priv));
+	if (!mci) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Failed memory allocation for mc instance\n");
+		return -ENOMEM;
+	}
+
+	priv = mci->pvt_info;
+	priv->baseaddr = baseaddr;
+
+	zynq_mc_init(mci, pdev);
+
+	rc = edac_mc_add_mc(mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Failed to register with EDAC core\n");
+		goto free_edac_mc;
+	}
+
+	/*
+	 * Start capturing the correctable and uncorrectable errors. A write of
+	 * 0 starts the counters.
+	 */
+	writel(0x0, baseaddr + ZYNQ_ECC_CTRL_OFST);
+
+	return 0;
+
+free_edac_mc:
+	edac_mc_free(mci);
+
+	return rc;
+}
+
+/**
+ * zynq_mc_remove - Unbind driver from controller.
+ * @pdev:	Platform device.
+ *
+ * Return: Unconditionally 0
+ */
+static int zynq_mc_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+
+	return 0;
+}
+
+static const struct of_device_id zynq_edac_match[] = {
+	{ .compatible = "xlnx,zynq-ddrc-a05" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, zynq_edac_match);
+
+static struct platform_driver zynq_edac_mc_driver = {
+	.driver = {
+		   .name = "zynq-edac",
+		   .of_match_table = zynq_edac_match,
+		   },
+	.probe = zynq_mc_probe,
+	.remove = zynq_mc_remove,
+};
+module_platform_driver(zynq_edac_mc_driver);
+
+MODULE_AUTHOR("Xilinx Inc");
+MODULE_DESCRIPTION("Zynq DDR ECC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.41.0

