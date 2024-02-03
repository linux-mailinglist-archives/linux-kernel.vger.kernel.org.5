Return-Path: <linux-kernel+bounces-50782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13C6847DD5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E4D3B258F2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BD910782;
	Sat,  3 Feb 2024 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YMSOX+OL"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E2D537
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920178; cv=none; b=TXs4SUR0TDR77i/ywB6s5ZatcqyRU/U9MavDG3nUMrMlasBfoNOM7OhMsQlkZ71zcRBAR32KXU/UBH9t0b+3p0CDJdvxFBdk8ENGoMv/7+Bh6YCc0NU3dqTSnJM2+eO0ddbE22gF22oJ6V4+/nfRpioRBjnZ6p9Eg0pRR/IyNZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920178; c=relaxed/simple;
	bh=rHgDo1RKEQeKn1A0o+gadEkZReIynFyOZSruP7Uclbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icHeYiYC434/Asw6uT7Qz5IbWmH4DYNOV9hCCV+SwpxDW4Pcfc7hH2B/XruKX15+qANUUEctx5DqkJi+jqtBVw13G7huyouIGXOFcpALRcHqthtdnhNOFrgsYIB1kuCKC8szcobUINolyhelEqzOcR03/48HpkknXFDuTvUkG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YMSOX+OL; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1AA05C0019BC;
	Fri,  2 Feb 2024 16:29:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1AA05C0019BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1706920176;
	bh=rHgDo1RKEQeKn1A0o+gadEkZReIynFyOZSruP7Uclbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMSOX+OLBaxYUxdfEaqMtA8//BYlesGFGKHuZaVAu6lq/yoBtpOle7Pa/zSuDiYB/
	 iQGae9yacVQymVany2+tpQhE7Ug1VPTaxDnnyFnM9zNw6R5rscEdgrqJtqgz88UR9M
	 L6eWU40IDbTJqfGzGI7t/O1+sHpK6VdRRbdI1mZw=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id A855718041CAC4;
	Fri,  2 Feb 2024 16:29:34 -0800 (PST)
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
	Richard Weinberger <richard@nod.at>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v4 08/12] mtd: rawnand: brcmnand: Add BCMBCA read data bus interface
Date: Fri,  2 Feb 2024 16:28:29 -0800
Message-Id: <20240203002834.171462-9-william.zhang@broadcom.com>
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

The BCMBCA broadband SoC integrates the NAND controller differently than
STB, iProc and other SoCs.  It has different endianness for NAND cache
data.

Add a SoC read data bus shim for BCMBCA to meet the specific SoC need
and performance improvement using the optimized memcpy function on NAND
cache memory.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>

---

Changes in v4: None
Changes in v3:
- Updated bcmbca_read_data_bus comment

Changes in v2:
- Drop the is_param argument to the read data bus function now that we
have the exec_op API to read the parameter page and ONFI data
- Remove be32_to_cpu from brcmnand_read_data_bus

 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c | 27 +++++++++++++++++++++
 drivers/mtd/nand/raw/brcmnand/brcmnand.c    | 20 ++++++++++++---
 drivers/mtd/nand/raw/brcmnand/brcmnand.h    |  2 ++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
index 3e2f3b79788d..7ad3e7a98f97 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
@@ -26,6 +26,18 @@ enum {
 	BCMBCA_CTLRDY		= BIT(4),
 };
 
+#if defined(CONFIG_ARM64)
+#define ALIGN_REQ		8
+#else
+#define ALIGN_REQ		4
+#endif
+
+static inline bool bcmbca_nand_is_buf_aligned(void *flash_cache,  void *buffer)
+{
+	return IS_ALIGNED((uintptr_t)buffer, ALIGN_REQ) &&
+				IS_ALIGNED((uintptr_t)flash_cache, ALIGN_REQ);
+}
+
 static bool bcmbca_nand_intc_ack(struct brcmnand_soc *soc)
 {
 	struct bcmbca_nand_soc *priv =
@@ -56,6 +68,20 @@ static void bcmbca_nand_intc_set(struct brcmnand_soc *soc, bool en)
 	brcmnand_writel(val, mmio);
 }
 
+static void bcmbca_read_data_bus(struct brcmnand_soc *soc,
+				 void __iomem *flash_cache,  u32 *buffer, int fc_words)
+{
+	/*
+	 * memcpy can do unaligned aligned access depending on source
+	 * and dest address, which is incompatible with nand cache. Fallback
+	 * to the memcpy_fromio in such case
+	 */
+	if (bcmbca_nand_is_buf_aligned((void *)flash_cache, buffer))
+		memcpy((void *)buffer, (void *)flash_cache, fc_words * 4);
+	else
+		memcpy_fromio((void *)buffer, flash_cache, fc_words * 4);
+}
+
 static int bcmbca_nand_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -73,6 +99,7 @@ static int bcmbca_nand_probe(struct platform_device *pdev)
 
 	soc->ctlrdy_ack = bcmbca_nand_intc_ack;
 	soc->ctlrdy_set_enabled = bcmbca_nand_intc_set;
+	soc->read_data_bus = bcmbca_read_data_bus;
 
 	return brcmnand_probe(pdev, soc);
 }
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 8faca43ae1ff..73fdf7ce21aa 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -851,6 +851,20 @@ static inline u32 edu_readl(struct brcmnand_controller *ctrl,
 	return brcmnand_readl(ctrl->edu_base + offs);
 }
 
+static inline void brcmnand_read_data_bus(struct brcmnand_controller *ctrl,
+					  void __iomem *flash_cache, u32 *buffer, int fc_words)
+{
+	struct brcmnand_soc *soc = ctrl->soc;
+	int i;
+
+	if (soc->read_data_bus) {
+		soc->read_data_bus(soc, flash_cache, buffer, fc_words);
+	} else {
+		for (i = 0; i < fc_words; i++)
+			buffer[i] = brcmnand_read_fc(ctrl, i);
+	}
+}
+
 static void brcmnand_clear_ecc_addr(struct brcmnand_controller *ctrl)
 {
 
@@ -1975,7 +1989,7 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
-	int i, j, ret = 0;
+	int i, ret = 0;
 
 	brcmnand_clear_ecc_addr(ctrl);
 
@@ -1988,8 +2002,8 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 		if (likely(buf)) {
 			brcmnand_soc_data_bus_prepare(ctrl->soc, false);
 
-			for (j = 0; j < FC_WORDS; j++, buf++)
-				*buf = brcmnand_read_fc(ctrl, j);
+			brcmnand_read_data_bus(ctrl, ctrl->nand_fc, buf, FC_WORDS);
+			buf += FC_WORDS;
 
 			brcmnand_soc_data_bus_unprepare(ctrl->soc, false);
 		}
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
index 928114c0be5e..7261a69989fe 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
@@ -24,6 +24,8 @@ struct brcmnand_soc {
 	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
 	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
 				 bool is_param);
+	void (*read_data_bus)(struct brcmnand_soc *soc, void __iomem *flash_cache,
+				  u32 *buffer, int fc_words);
 	const struct brcmnand_io_ops *ops;
 };
 
-- 
2.37.3


