Return-Path: <linux-kernel+bounces-57023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F273784D2F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA341F21709
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BA212C538;
	Wed,  7 Feb 2024 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZIPVbQpS"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82912F369
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337462; cv=none; b=B2B1vMFqxWC0AF4Nd4dVZQotPAdGJH4ZEfhpszLNcvcWhGrqzf9mFhYskleCmyiwvKLOlt2O1e2vjDW+QboH3FveC4Dvo0rDryiu6Wn2waWZc0uR57XWK9h90fqFf6Bum8c3wRi0PououNn8wEVZ5Q7JnQjjEODfxioGG64eTWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337462; c=relaxed/simple;
	bh=SEUbGpLY/kY+cXDOt4nGhWXvuLxy9O4W4aujYHBLgx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q5gsj7cseglQz7mweZdXP186IIUPotDlFfW7c2h4KgaqVu03hLm1sbAWeU5HAQ2FGVbSAe/d94BAODY4clqKv/S8IEAGZnYYzeysbDzRo0wtg4IODBN+QvYuBqGjLlsz5CkacDo2gwp3tPRjwC6D8FFSpGOLER6FLD194b8Y7JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZIPVbQpS; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id CBF2DC0000EA;
	Wed,  7 Feb 2024 12:24:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com CBF2DC0000EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1707337459;
	bh=SEUbGpLY/kY+cXDOt4nGhWXvuLxy9O4W4aujYHBLgx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIPVbQpSX+4Q7HG6G31j2tj52V5Arp1KquoQWdsWog6U5WWgkqi3EuS9Mb/mfm/vG
	 iupk/k2CeHLXY/uNw7oSFDFmxis6bDppBvoExe0bmXBT+N5/i7Qn9vW2LW7esNO+9E
	 FaBYjVXDts+CWijp8FMkWVhw49fT3YEFF79dJKEA=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 3286918041CAC4;
	Wed,  7 Feb 2024 12:24:18 -0800 (PST)
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
	William Zhang <william.zhang@broadcom.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v5 12/12] mtd: rawnand: brcmnand: update log level messages
Date: Wed,  7 Feb 2024 12:22:57 -0800
Message-Id: <20240207202257.271784-13-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240207202257.271784-1-william.zhang@broadcom.com>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Regan <dregan@broadcom.com>

Update log level messages so that more critical messages can be logged
to console and help the troubleshooting with field devices.

Signed-off-by: David Regan <dregan@broadcom.com>
Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v5:
- Update the commit message

Changes in v4:
- Revert the log level change for correctable ecc error

Changes in v3: None
Changes in v2:
- Added to patch series

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 7ce2b267676f..e50582b45182 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1143,7 +1143,7 @@ static int bcmnand_ctrl_poll_status(struct brcmnand_host *host,
 	if ((val & mask) == expected_val)
 		return 0;
 
-	dev_warn(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
+	dev_err(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
 		 expected_val, val & mask);
 
 	return -ETIMEDOUT;
@@ -2196,7 +2196,7 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 				return err;
 		}
 
-		dev_dbg(ctrl->dev, "uncorrectable error at 0x%llx\n",
+		dev_err(ctrl->dev, "uncorrectable error at 0x%llx\n",
 			(unsigned long long)err_addr);
 		mtd->ecc_stats.failed++;
 		/* NAND layer expects zero on ECC errors */
-- 
2.37.3


