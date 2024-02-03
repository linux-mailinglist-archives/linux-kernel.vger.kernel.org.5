Return-Path: <linux-kernel+bounces-50783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0FC847DD6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D5A1B26226
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75CD10A2E;
	Sat,  3 Feb 2024 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fuc3uRjm"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCDF9CD
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920180; cv=none; b=f4FaK8cVa3ZkTe9DDpoNWkuv9CKEZtakLNgr+LKO6DZZ4VWMSNwwlH3pXzXSWPvhTp5AJRXxOw8Xb+wMC8cHooSv5rSG/XAsLnNO2RxGPbTP6u7utZaPREju2NVzty1Z6PFDNzC7PlhB3KI0BIkfFmGZhQ3no2puDOIWoZ2ltjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920180; c=relaxed/simple;
	bh=s/ChhgfzXW1d5Br4dKiO6tP7LbtmJXzGgiphezRGZXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q5a/L3GFD09vDiIFxfynd8RvneUItHiSjzeBHbl0JVRq1CqjyABungsxNTbdu1ZTYeo2yZ8u/HSGbzjCoyLQXJE2c5Go/I5w/UZlGuo2IYgFisCzXs0jSYswXRDTAubfeZsP5ssU1VPCktBaA6Sag1ediJgbRMLILezj7Zyaafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fuc3uRjm; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A277BC00329C;
	Fri,  2 Feb 2024 16:29:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A277BC00329C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1706920177;
	bh=s/ChhgfzXW1d5Br4dKiO6tP7LbtmJXzGgiphezRGZXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fuc3uRjmNby/3g0/5tQhOOe6cRZ7YokmGYLsDNUdPH80/MjQsljPtBH4nNiMRi3n+
	 qeijZ9E9ExRwWV/alTJQjDfevJkCj6oJhG97SNj2a3k7OKvWXcdnMfQFfiUHTrBW1B
	 6ZGuCzhjNNqCepATMQlHk4Hc0bgh93xhgwkNIvMc=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 3139018041CAC4;
	Fri,  2 Feb 2024 16:29:36 -0800 (PST)
From: William Zhang <william.zhang@broadcom.com>
To: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	David Regan <dregan@broadcom.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v4 09/12] mtd: rawnand: brcmnand: Add support for getting ecc setting from strap
Date: Fri,  2 Feb 2024 16:28:30 -0800
Message-Id: <20240203002834.171462-10-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240203002834.171462-1-william.zhang@broadcom.com>
References: <20240203002834.171462-1-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BCMBCA broadband SoC based board design does not specify ecc setting in
dts but rather use the SoC NAND strap info to obtain the ecc strength
and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
this purpose and update driver to support this option.

The generic nand ecc settings still take precedence over this flag. For
example, if nand-ecc-strength is set in the dts, the driver ignores the
strap setting and falls back to original behavior. This makes sure that
the existing BCMBCA board dts still works the old way even the strap
flag is set in the BCMBCA chip dtsi.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>

---

Changes in v4:
- Update the comments for ecc setting selection

Changes in v3: None
Changes in v2:
- Minor cosmetic fixes

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 83 ++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 73fdf7ce21aa..efeee9e80213 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1038,6 +1038,19 @@ static inline int brcmnand_sector_1k_shift(struct brcmnand_controller *ctrl)
 		return -1;
 }
 
+static int brcmnand_get_sector_size_1k(struct brcmnand_host *host)
+{
+	struct brcmnand_controller *ctrl = host->ctrl;
+	int shift = brcmnand_sector_1k_shift(ctrl);
+	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
+						  BRCMNAND_CS_ACC_CONTROL);
+
+	if (shift < 0)
+		return 0;
+
+	return (nand_readreg(ctrl, acc_control_offs) >> shift) & 0x1;
+}
+
 static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int val)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
@@ -1055,6 +1068,38 @@ static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int val)
 	nand_writereg(ctrl, acc_control_offs, tmp);
 }
 
+static int brcmnand_get_spare_size(struct brcmnand_host *host)
+{
+	struct brcmnand_controller *ctrl = host->ctrl;
+	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
+						  BRCMNAND_CS_ACC_CONTROL);
+	u32 acc = nand_readreg(ctrl, acc_control_offs);
+
+	return (acc & brcmnand_spare_area_mask(ctrl));
+}
+
+static int brcmnand_get_ecc_strength(struct brcmnand_host *host)
+{
+	struct brcmnand_controller *ctrl = host->ctrl;
+	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
+						  BRCMNAND_CS_ACC_CONTROL);
+	int sector_size_1k = brcmnand_get_sector_size_1k(host);
+	int spare_area_size, ecc_level, ecc_strength;
+	u32 acc;
+
+	spare_area_size = brcmnand_get_spare_size(host);
+	acc = nand_readreg(ctrl, acc_control_offs);
+	ecc_level = (acc & brcmnand_ecc_level_mask(ctrl)) >> ctrl->ecc_level_shift;
+	if (sector_size_1k)
+		ecc_strength = ecc_level * 2;
+	else if (spare_area_size == 16 && ecc_level == 15)
+		ecc_strength = 1; /* hamming */
+	else
+		ecc_strength = ecc_level;
+
+	return ecc_strength;
+}
+
 /***********************************************************************
  * CS_NAND_SELECT
  ***********************************************************************/
@@ -2622,19 +2667,43 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 		nanddev_get_memorg(&chip->base);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct brcmnand_cfg *cfg = &host->hwcfg;
-	char msg[128];
+	struct device_node *np = nand_get_flash_node(chip);
 	u32 offs, tmp, oob_sector;
-	int ret;
+	int ret, sector_size_1k = 0;
+	bool use_strap = false;
+	char msg[128];
 
 	memset(cfg, 0, sizeof(*cfg));
+	use_strap = of_property_read_bool(np, "brcm,nand-ecc-use-strap");
 
-	ret = of_property_read_u32(nand_get_flash_node(chip),
-				   "brcm,nand-oob-sector-size",
+	/*
+	 * Set ECC size and strength based on hw configuration from strap
+	 * if brcm,nand-ecc-use-strap is set. However if nand-ecc-strength
+	 * is set, its value will be used and ignore the strap setting.
+	 */
+	if (chip->ecc.strength)
+		use_strap = 0;
+
+	if (use_strap) {
+		chip->ecc.strength = brcmnand_get_ecc_strength(host);
+		sector_size_1k = brcmnand_get_sector_size_1k(host);
+		if (chip->ecc.size == 0) {
+			if (sector_size_1k < 0)
+				chip->ecc.size = 512;
+			else
+				chip->ecc.size = 512 << sector_size_1k;
+		}
+	}
+
+	ret = of_property_read_u32(np, "brcm,nand-oob-sector-size",
 				   &oob_sector);
 	if (ret) {
-		/* Use detected size */
-		cfg->spare_area_size = mtd->oobsize /
-					(mtd->writesize >> FC_SHIFT);
+		if (use_strap)
+			cfg->spare_area_size = brcmnand_get_spare_size(host);
+		else
+			/* Use detected size */
+			cfg->spare_area_size = mtd->oobsize /
+						(mtd->writesize >> FC_SHIFT);
 	} else {
 		cfg->spare_area_size = oob_sector;
 	}
-- 
2.37.3


