Return-Path: <linux-kernel+bounces-18915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F97826513
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF8281F5F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0F213AE4;
	Sun,  7 Jan 2024 16:25:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m25492.xmail.ntesmail.com (mail-m25492.xmail.ntesmail.com [103.129.254.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2513ADB
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.118.189.127])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 425C180005B;
	Sun,  7 Jan 2024 20:30:23 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] mtd: nand: Add Dosilicon manufacturer id
Date: Sun,  7 Jan 2024 20:30:20 +0800
Message-Id: <20240107123020.22053-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaThlDVksZTElKSUkdHUsaT1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVKSkNVSkNCVUpJTFlXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8ce3e71cd0b03akuuu425c180005b
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46GSo4NzwtGDw2KyIJLxwu
	CygKFEtVSlVKTEtPTUhLTUlPS09JVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSkNVSkNCVUpJTFlXWQgBWUFJSk9JNwY+

Add Dosilicon manufacturer id.
Tested on Dosilicon FMND1G08S3D.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/mtd/nand/raw/internals.h | 1 +
 drivers/mtd/nand/raw/nand_ids.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
index b7162ced9efa..e94788597a72 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -18,6 +18,7 @@
  */
 #define NAND_MFR_AMD		0x01
 #define NAND_MFR_ATO		0x9b
+#define NAND_MFR_DOSILICON	0xf8
 #define NAND_MFR_EON		0x92
 #define NAND_MFR_ESMT		0xc8
 #define NAND_MFR_FUJITSU	0x04
diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index 650351c62af6..54e07e148c6e 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -181,6 +181,7 @@ struct nand_flash_dev nand_flash_ids[] = {
 static const struct nand_manufacturer_desc nand_manufacturer_descs[] = {
 	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
 	{NAND_MFR_ATO, "ATO"},
+	{NAND_MFR_DOSILICON, "Dosilicon"},
 	{NAND_MFR_EON, "Eon"},
 	{NAND_MFR_ESMT, "ESMT", &esmt_nand_manuf_ops},
 	{NAND_MFR_FUJITSU, "Fujitsu"},
-- 
2.25.1


