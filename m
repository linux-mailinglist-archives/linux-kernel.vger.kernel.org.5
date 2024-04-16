Return-Path: <linux-kernel+bounces-146530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086778A66A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870C51F21B24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0423884FDB;
	Tue, 16 Apr 2024 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Fax2au8N"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A883CD1;
	Tue, 16 Apr 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258133; cv=none; b=hfwPMZQcGI/whqrdAuhgHlMAUZHXV0hE1+aVGlFVjTAK2Nt2aNG527tGId7kJpYD7aljg9xGqoTs/Iakf4HqSa17SQzHUtySHsV4iwIt0Or++yBJcWYuo+gAN4mCTwCIm6woHXqywElWxHLzsXqz/KtWRv5lS1L7j3vfj9Bg6UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258133; c=relaxed/simple;
	bh=g/FqV19rKWb535cexKioS66bqLX57/QzG0Uv51rTSZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Exh07IV488gnDlXCkGDXbFSOjq+C7o+Kw8G5CP1uPaZKrMnCvrFTm4FyNEiniMC3/6QyGWY974gujITPPgjVslm29Nf72Jz6ZqLk0Hj5E1Zv92W0Mvfg4aK0CnurnUc83MJQpeu6A32BrVSjqYO7nr9aFXGmTNFKGbgepvEYJHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Fax2au8N; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E725F12000C;
	Tue, 16 Apr 2024 12:02:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E725F12000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713258121;
	bh=nlvCjxCsDmswnKHUR9zLC0s4ABtaZZnkhgMtH/U3PBg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Fax2au8NBRg6oQLiW1pgS6MAwaHUT+aTcYWb6WgGUioTTPUe7ysJfipCbchyOIzFi
	 9vsRIKlGk0Ki1jY0SV1yEjNX9yjsLEZ4Y8Ih8Kc/NylVIKdXgj9yD033aXSK3OetJd
	 BZ2IfDKZS7+QxAJQm5NaXM1I4MR50m1iebUcs7gwNpG2/J2a7u513i1syMI1APCErn
	 J78q8WENHskiRBvv6pkWwGuTA+u/QHzo6QIgZxoP9Zregjdoxg26yq39hoCt0/f9RA
	 GEsHiHNOw0yk9NzJbrHxPeD7wLDoCSs4U3Pmvw9arqSsLFWwoUUVx85165gtdAMicm
	 tZGFggLbNTQyg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 16 Apr 2024 12:02:01 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 16 Apr 2024 12:02:01 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
CC: <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <oxffffaa@gmail.com>,
	<kernel@sberdevices.ru>, Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: [PATCH v5 2/2] mtd: rawnand: meson: support R/W mode for boot ROM
Date: Tue, 16 Apr 2024 11:51:01 +0300
Message-ID: <20240416085101.740458-3-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20240416085101.740458-1-avkrasnov@salutedevices.com>
References: <20240416085101.740458-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184729 [Apr 16 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 17 0.3.17 f2153f38d75b12894d9cf445f96cd15c9ef63a9d, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/16 06:39:00 #24817376
X-KSMG-AntiVirus-Status: Clean, skipped

Boot ROM code on Meson requires that some pages on NAND must be written
in special mode: "short" ECC mode where each block is 384 bytes and
scrambling mode is on. Such pages located with the specified interval
within specified offset. Both interval and offset are located in the
device tree and used by driver if 'nand-is-boot-medium' is set for
NAND chip.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 88 +++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 00ce0e5bb970..9ee11243b257 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -35,6 +35,7 @@
 #define NFC_CMD_RB		BIT(20)
 #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
 #define NFC_CMD_SCRAMBLER_DISABLE	0
+#define NFC_CMD_SHORTMODE_ENABLE	1
 #define NFC_CMD_SHORTMODE_DISABLE	0
 #define NFC_CMD_RB_INT		BIT(14)
 #define NFC_CMD_RB_INT_NO_PIN	((0xb << 10) | BIT(18) | BIT(16))
@@ -78,6 +79,8 @@
 #define DMA_DIR(dir)		((dir) ? NFC_CMD_N2M : NFC_CMD_M2N)
 #define DMA_ADDR_ALIGN		8
 
+#define NFC_SHORT_MODE_ECC_SZ	384
+
 #define ECC_CHECK_RETURN_FF	(-1)
 
 #define NAND_CE0		(0xe << 10)
@@ -125,6 +128,8 @@ struct meson_nfc_nand_chip {
 	u32 twb;
 	u32 tadl;
 	u32 tbers_max;
+	u32 boot_pages;
+	u32 boot_page_step;
 
 	u32 bch_mode;
 	u8 *data_buf;
@@ -298,28 +303,49 @@ static void meson_nfc_cmd_seed(struct meson_nfc *nfc, u32 seed)
 	       nfc->reg_base + NFC_REG_CMD);
 }
 
-static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
-				 int scrambler)
+static int meson_nfc_page_is_boot(struct nand_chip *nand, int page)
+{
+	const struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
+
+	return (nand->options & NAND_IS_BOOT_MEDIUM) &&
+	       !(page % meson_chip->boot_page_step) &&
+	       (page < meson_chip->boot_pages);
+}
+
+static void meson_nfc_cmd_access(struct nand_chip *nand, bool raw, bool dir, int page)
 {
+	const struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct meson_nfc *nfc = nand_get_controller_data(mtd_to_nand(mtd));
-	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
-	u32 bch = meson_chip->bch_mode, cmd;
 	int len = mtd->writesize, pagesize, pages;
+	int scrambler;
+	u32 cmd;
 
-	pagesize = nand->ecc.size;
+	if (nand->options & NAND_NEED_SCRAMBLING)
+		scrambler = NFC_CMD_SCRAMBLER_ENABLE;
+	else
+		scrambler = NFC_CMD_SCRAMBLER_DISABLE;
 
 	if (raw) {
 		len = mtd->writesize + mtd->oobsize;
 		cmd = len | scrambler | DMA_DIR(dir);
-		writel(cmd, nfc->reg_base + NFC_REG_CMD);
-		return;
-	}
+	} else if (meson_nfc_page_is_boot(nand, page)) {
+		pagesize = NFC_SHORT_MODE_ECC_SZ >> 3;
+		pages = mtd->writesize / 512;
+
+		scrambler = NFC_CMD_SCRAMBLER_ENABLE;
+		cmd = CMDRWGEN(DMA_DIR(dir), scrambler, NFC_ECC_BCH8_1K,
+			       NFC_CMD_SHORTMODE_ENABLE, pagesize, pages);
+	} else {
+		pagesize = nand->ecc.size >> 3;
+		pages = len / nand->ecc.size;
 
-	pages = len / nand->ecc.size;
+		cmd = CMDRWGEN(DMA_DIR(dir), scrambler, meson_chip->bch_mode,
+			       NFC_CMD_SHORTMODE_DISABLE, pagesize, pages);
+	}
 
-	cmd = CMDRWGEN(DMA_DIR(dir), scrambler, bch,
-		       NFC_CMD_SHORTMODE_DISABLE, pagesize, pages);
+	if (scrambler == NFC_CMD_SCRAMBLER_ENABLE)
+		meson_nfc_cmd_seed(nfc, page);
 
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
 }
@@ -743,15 +769,7 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
-	if (nand->options & NAND_NEED_SCRAMBLING) {
-		meson_nfc_cmd_seed(nfc, page);
-		meson_nfc_cmd_access(nand, raw, DIRWRITE,
-				     NFC_CMD_SCRAMBLER_ENABLE);
-	} else {
-		meson_nfc_cmd_access(nand, raw, DIRWRITE,
-				     NFC_CMD_SCRAMBLER_DISABLE);
-	}
-
+	meson_nfc_cmd_access(nand, raw, DIRWRITE, page);
 	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
 	meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tPROG_max), false);
@@ -829,15 +847,7 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
-	if (nand->options & NAND_NEED_SCRAMBLING) {
-		meson_nfc_cmd_seed(nfc, page);
-		meson_nfc_cmd_access(nand, raw, DIRREAD,
-				     NFC_CMD_SCRAMBLER_ENABLE);
-	} else {
-		meson_nfc_cmd_access(nand, raw, DIRREAD,
-				     NFC_CMD_SCRAMBLER_DISABLE);
-	}
-
+	meson_nfc_cmd_access(nand, raw, DIRREAD, page);
 	ret = meson_nfc_wait_dma_finish(nfc);
 	meson_nfc_check_ecc_pages_valid(nfc, nand, raw);
 
@@ -1436,6 +1446,26 @@ meson_nfc_nand_chip_init(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (nand->options & NAND_IS_BOOT_MEDIUM) {
+		ret = of_property_read_u32(np, "amlogic,boot-pages",
+					   &meson_chip->boot_pages);
+		if (ret) {
+			dev_err(dev, "could not retrieve 'amlogic,boot-pages' property: %d",
+				ret);
+			nand_cleanup(nand);
+			return ret;
+		}
+
+		ret = of_property_read_u32(np, "amlogic,boot-page-step",
+					   &meson_chip->boot_page_step);
+		if (ret) {
+			dev_err(dev, "could not retrieve 'amlogic,boot-page-step' property: %d",
+				ret);
+			nand_cleanup(nand);
+			return ret;
+		}
+	}
+
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(dev, "failed to register MTD device: %d\n", ret);
-- 
2.35.0


