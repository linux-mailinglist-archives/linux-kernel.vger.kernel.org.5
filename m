Return-Path: <linux-kernel+bounces-77081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345EE8600F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CF71C231AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0A3158D70;
	Thu, 22 Feb 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDUYg7ta"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F971649BF;
	Thu, 22 Feb 2024 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625695; cv=none; b=OOlolRs025SA6VQAVFrp25mv+Qf1+eOhE9SQUZoONweJAgMJFoqewRhgkv7jdHNhvY4NStmh6iB7dwIr8LWCse9wuALavhztBiQJq6k9k6okP0mH1Tm20f/WIGGMVnCgejCmHvwyPoD1aTM1wzQiO/QO1wtEhzqM47MX1w/XIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625695; c=relaxed/simple;
	bh=2g9t/K6MJyoP04JMyjoN/T196jRJo1W+K2cG4NlAxzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VY2bWqXuKMTV5nXDHxFC/SoluPePlJDetpRtNXNkCoZnysbG+d3nQaE0vrSc8gmaXemPfA4YwMvJaqNu41p9QIknwQXB1PrSRtYPqxRcmi6krPMwdQJCFXG32v+T0SVQpomQPNFYKWc4fVw3T0e4DmEiZFjgCFKwHDp2qDn1mNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDUYg7ta; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso1185111fa.2;
        Thu, 22 Feb 2024 10:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625690; x=1709230490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdDgER3I/FBUh4v2IZo5kVqc0y5a5FgLioTBOyGmBsw=;
        b=WDUYg7ta4hzzxHq/YLZ6gnp9NlY3Jqr/Y/l4Fzlvv2bHJEeORRmU6PixxaZVTqoMPF
         QGYat0WUX1Y8RY8iLrFAOmXFAZq1rP/g7c/pV4QmBWz7k/GuRiFwBUQGdddJaEG5yi6I
         USagLcMzKxZHKK/4BeBF3Ii65fbIC+Y/xbH4QmlCb8ELW8bI6HCqT4i224ATiFKredX2
         8Pzi3VNellSeVnRkt2C823f8vAZ5Z8VHyXvy0uPsUGOdLXMIIBGE9kBodzBhQ/9NLTT6
         TB4HEkq6+RjyowAU2rBeh1a49KQeUqjm2Twx91+Bm6SVPFHKCdrP8CiJANKUeDnJKNQY
         OCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625690; x=1709230490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdDgER3I/FBUh4v2IZo5kVqc0y5a5FgLioTBOyGmBsw=;
        b=Cr+KLvViqi2PSN+AdrTtP8yonxD5t0bRZtL+ArycTgercrB1SQejKDXQ+/9HBS/X+x
         Nsd6cDY/pCEXbT7X/V7eki+z05cv9qiy4o6ZFDHmQ4KrcnAhRIuBiDa9zeGazHzdJ9RB
         MsneaWa5FyuPBH96JwzlMNXM9+3BUXxMwWi3057QSdguwkhn8qc9MOsoZ5jGRoY1v7i7
         2g8fS53JjaMnSG243TnbfDiy7ltWgwNXvYFcw5G7+jcDethQyYLC9FvdQBcq+hNQAJh1
         K8AR2pxYAN+SzSuMRsn5//14s7BIy+1bHYbZDUnJDTi7/w5ResUALbjM74s/zILbSqh1
         7A8A==
X-Forwarded-Encrypted: i=1; AJvYcCVwxy/rFSvybZh53TyK+/IePegccPV6icQZDutIG5qp2fiy0aO6WvvWCEXAOj+zFhpXI5o5PfjDc6NrpvUhzoslTmMutwbbfcdTEcL34nANgj2UgjceCvJXNsVSJfvjU2Vpuq2nmYWsBA==
X-Gm-Message-State: AOJu0Yw/syUWYv9U6cIt0bbasxHaqCIIcrToL+ZZ0tfuCsYJNp+Kv+v6
	U8Tam/usS/p40fA/VuzPmqhRdR+obYBuq3ChNrXrie6Rgavkgdzv
X-Google-Smtp-Source: AGHT+IGsX/zIDEFsJKLLkyNvQrmhZsnlQAJbqwhUiiFzPWDqhIC+rib/r/pPcRtu7WVXI9Uoz5vKBA==
X-Received: by 2002:ac2:5e6f:0:b0:512:b297:286f with SMTP id a15-20020ac25e6f000000b00512b297286fmr7624463lfr.52.1708625690268;
        Thu, 22 Feb 2024 10:14:50 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id br21-20020a056512401500b00512da707c90sm406390lfb.43.2024.02.22.10.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:49 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/20] EDAC/synopsys: Detach Zynq A05 DDRC support to separate driver
Date: Thu, 22 Feb 2024 21:13:01 +0300
Message-ID: <20240222181324.28242-17-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Changelog v5:
- Rename handle_error and check_errors to zynq_handle_error and
  zynq_check_errors in the kdoc comments (@tbot)
---
 MAINTAINERS                  |   1 +
 drivers/edac/Kconfig         |   9 +-
 drivers/edac/Makefile        |   1 +
 drivers/edac/synopsys_edac.c | 239 ++---------------
 drivers/edac/zynq_edac.c     | 501 +++++++++++++++++++++++++++++++++++
 5 files changed, 531 insertions(+), 220 deletions(-)
 create mode 100644 drivers/edac/zynq_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 960512bec428..baca1e55cf49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3020,6 +3020,7 @@ F:	arch/arm/mach-zynq/
 F:	drivers/clocksource/timer-cadence-ttc.c
 F:	drivers/cpuidle/cpuidle-zynq.c
 F:	drivers/edac/synopsys_edac.c
+F:	drivers/edac/zynq_edac.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/i2c/busses/i2c-xiic.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 5a7f3fabee22..6e411376d2bb 100644
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
@@ -542,6 +542,13 @@ config EDAC_DMC520
 	  Support for error detection and correction on the
 	  SoCs with ARM DMC-520 DRAM controller.
 
+config EDAC_ZYNQ
+	tristate "Xilinx Zynq A05 DDR Memory Controller"
+	depends on ARCH_ZYNQ || COMPILE_TEST
+	help
+	  Support for error detection and correction on the Xilinx Zynq A05
+	  DDR memory controller.
+
 config EDAC_ZYNQMP
 	tristate "Xilinx ZynqMP OCM Controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 9c09893695b7..2829036f8468 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -85,5 +85,6 @@ obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
 obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
+obj-$(CONFIG_EDAC_ZYNQ)			+= zynq_edac.o
 obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
 obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index dfe1abe7c86c..6ea1eaaa7d6f 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -29,68 +29,16 @@
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
@@ -134,16 +82,22 @@
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
@@ -341,61 +295,6 @@ struct synps_platform_data {
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
@@ -614,37 +513,6 @@ static void check_errors(struct mem_ctl_info *mci)
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
@@ -658,7 +526,7 @@ static enum dev_type zynqmp_get_dtype(const void __iomem *base)
 {
 	u32 regval;
 
-	regval = readl(base + CTRL_OFST);
+	regval = readl(base + DDR_MSTR_OFST);
 	if (!(regval & MEM_TYPE_DDR4))
 		return DEV_UNKNOWN;
 
@@ -677,30 +545,6 @@ static enum dev_type zynqmp_get_dtype(const void __iomem *base)
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
@@ -713,9 +557,9 @@ static bool zynqmp_get_ecc_state(void __iomem *base)
 {
 	u32 regval;
 
-	regval = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+	regval = readl(base + ECC_CFG0_OFST) & ECC_CFG0_MODE_MASK;
 
-	return (regval == SCRUB_MODE_SECDED);
+	return (regval == ECC_CFG0_MODE_SECDED);
 }
 
 /**
@@ -732,30 +576,6 @@ static u32 get_memsize(void)
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
@@ -770,7 +590,7 @@ static enum mem_type zynqmp_get_mtype(const void __iomem *base)
 	enum mem_type mt;
 	u32 memtype;
 
-	memtype = readl(base + CTRL_OFST);
+	memtype = readl(base + DDR_MSTR_OFST);
 
 	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
 		mt = MEM_DDR3;
@@ -882,14 +702,6 @@ static int setup_irq(struct mem_ctl_info *mci,
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
@@ -916,10 +728,6 @@ static const struct synps_platform_data synopsys_edac_def = {
 
 
 static const struct of_device_id synps_edac_match[] = {
-	{
-		.compatible = "xlnx,zynq-ddrc-a05",
-		.data = (void *)&zynq_edac_def
-	},
 	{
 		.compatible = "xlnx,zynqmp-ddrc-2.40a",
 		.data = (void *)&zynqmp_edac_def
@@ -1141,8 +949,8 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 	u32 width, memtype;
 	int index;
 
-	memtype = readl(priv->baseaddr + CTRL_OFST);
-	width = (memtype & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+	memtype = readl(priv->baseaddr + DDR_MSTR_OFST);
+	width = (memtype & DDR_MSTR_BUSWIDTH_MASK) >> DDR_MSTR_BUSWIDTH_SHIFT;
 
 	priv->col_shift[0] = 0;
 	priv->col_shift[1] = 1;
@@ -1337,7 +1145,7 @@ static int mc_probe(struct platform_device *pdev)
 	layers[1].size = SYNPS_EDAC_NR_CHANS;
 	layers[1].is_virt_csrow = false;
 
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
+	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers,
 			    sizeof(struct synps_edac_priv));
 	if (!mci) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -1379,13 +1187,6 @@ static int mc_probe(struct platform_device *pdev)
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
index 000000000000..be26934a9c20
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
+ * zynq_handle_error - Handle Correctable and Uncorrectable errors.
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
+ * zynq_check_errors - Check controller for ECC errors.
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
2.43.0


