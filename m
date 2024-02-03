Return-Path: <linux-kernel+bounces-50786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F057847DD9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A84DB2827D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBADEACD;
	Sat,  3 Feb 2024 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HbftFuFp"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C51125B4
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920189; cv=none; b=K/YCktuAPtd0+rKFROVHdEqm2n7Wh73LzvNNCN9BpDs34be5Qr59yvfeZtWXmHqvno1Ke8z5ONn6uH1WU/5erbK6H2oW0jCchbLC+LsrIZ2Zsgge+G2/RE+EMdDxR1tmhz2fHoDz2rsGeo9S42SveIeHkqqpAau+gMYYDxffm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920189; c=relaxed/simple;
	bh=oYWu5Fo1F0+7WCqhPKRqpGmYX5+YscXs0w2BLbY2DiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrDdj8aL+yEK8qf9bGqf8j+b2hNdlU5s/eUEtgMWNUg+e53CpvEySb67Tz1Uo9xkTV2ynYVj1h+CCUP1Taur0bHRkws68t1Ey3Ff+w82kHg3xosnvGvdycClwWPHUkfRqflxCZkiFZwNhwCh6JE2NLfgXQsJaUwgy9G+Bn2gaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HbftFuFp; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 43320C001C89;
	Fri,  2 Feb 2024 16:29:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 43320C001C89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1706920184;
	bh=oYWu5Fo1F0+7WCqhPKRqpGmYX5+YscXs0w2BLbY2DiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbftFuFpjR7830bsBF/2j9Qdq7mRKEkN9FA1o1PTlAT6Ls2omsvXj9V71I+nLbXmK
	 oPgWUth5QCxpRyG8ZE4lNLwGKgLAkQ0W3W3bbASQZxAmZVqLfRo+4/slP5RQS/EKO4
	 00n+k/iE5SCbt0di86f5a4vuy3c/gnasIbnS40VQ=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id D179218041CAC4;
	Fri,  2 Feb 2024 16:29:42 -0800 (PST)
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
	David Regan <dregan@broadcom.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	William Zhang <william.zhang@broadcom.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v4 11/12] mtd: rawnand: brcmnand: exec_op helper functions return type fixes
Date: Fri,  2 Feb 2024 16:28:32 -0800
Message-Id: <20240203002834.171462-12-william.zhang@broadcom.com>
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

From: David Regan <dregan@broadcom.com>

fix return type for exec_op reset and status detect helper functions

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: http://lists.infradead.org/pipermail/linux-mtd/2023-December/102423.html
Fixes: 3c8260ce7663 ("mtd: rawnand: brcmnand: exec_op implementation")
Signed-off-by: David Regan <dregan@broadcom.com>
Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v4:
- Fix the commit id in the fixes tag

Changes in v3: None
Changes in v2:
- Added to patch series

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 8c1489ff7bd6..7ce2b267676f 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -625,7 +625,7 @@ enum {
 /* Only for v7.2 */
 #define	ACC_CONTROL_ECC_EXT_SHIFT		13
 
-static u8 brcmnand_status(struct brcmnand_host *host);
+static int brcmnand_status(struct brcmnand_host *host);
 
 static inline bool brcmnand_non_mmio_ops(struct brcmnand_controller *ctrl)
 {
@@ -1749,7 +1749,7 @@ static int brcmnand_waitfunc(struct nand_chip *chip)
 				 INTFC_FLASH_STATUS;
 }
 
-static u8 brcmnand_status(struct brcmnand_host *host)
+static int brcmnand_status(struct brcmnand_host *host)
 {
 	struct nand_chip *chip = &host->chip;
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -1760,7 +1760,7 @@ static u8 brcmnand_status(struct brcmnand_host *host)
 	return brcmnand_waitfunc(chip);
 }
 
-static u8 brcmnand_reset(struct brcmnand_host *host)
+static int brcmnand_reset(struct brcmnand_host *host)
 {
 	struct nand_chip *chip = &host->chip;
 
@@ -2492,11 +2492,14 @@ static int brcmnand_exec_op(struct nand_chip *chip,
 
 	if (brcmnand_op_is_status(op)) {
 		status = op->instrs[1].ctx.data.buf.in;
-		*status = brcmnand_status(host);
+		ret = brcmnand_status(host);
+		if (ret < 0)
+			return ret;
+
+		*status = ret & 0xFF;
 
 		return 0;
-	}
-	else if (brcmnand_op_is_reset(op)) {
+	} else if (brcmnand_op_is_reset(op)) {
 		ret = brcmnand_reset(host);
 		if (ret < 0)
 			return ret;
-- 
2.37.3


