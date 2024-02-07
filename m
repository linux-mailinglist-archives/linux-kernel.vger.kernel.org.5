Return-Path: <linux-kernel+bounces-57021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A396284D2EE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DD65B267C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA712E1F9;
	Wed,  7 Feb 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Tlirzqhu"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805191272CF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337454; cv=none; b=b/9RXKprg2CnDStkZjwCyinMUNsgMXPZdcPpixHiHhlOX4YsdHqP4rW7FvY7TPERQQNXDhoDyYF4dunLU1bZohZUxVYV8m2mNQcUKChJYDlb3c8JlTdAIUbiML9/5CUTSbxZKQ/6LFP9EcNUElORtPuL5Tqc8TwpBrTdQMJ4kcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337454; c=relaxed/simple;
	bh=LUvXfylQz7V0uRO9qJXNQP+bE5k1kmYrwKzlIAWOYL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SaD17gTE+0H7csSWHcQYSBX6vLO3vvmhiQsAXHS4opJQ49U95a8W0vJvqY8aCi0ClzjlVYKDQ9udK8n6hEz3GpgDiY9JqPLNTay6jKfHvpU/GilA+ynz5CupHuVL5vAYpofc7L/xYFU8mm9m/rVT2FFVn8qxULO+rLJhxrDenlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Tlirzqhu; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D7BADC002E04;
	Wed,  7 Feb 2024 12:24:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D7BADC002E04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1707337451;
	bh=LUvXfylQz7V0uRO9qJXNQP+bE5k1kmYrwKzlIAWOYL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TlirzqhuOg4tzEbiBkiwG77jPDzlr/bygIvtETqRJAeJSvGAkBKcdW74oig5H971m
	 +TASW5kxTqfJ/6Xr8yMbDxWyWItcj20C4moqq7sQYUl8fEhl9ACvmN0OBcvMqf3Eov
	 5ycU0qevpNPAqMh/f7IHSu9ryvTDNWpCqmYmBIUg=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 72E8618041CAC4;
	Wed,  7 Feb 2024 12:24:10 -0800 (PST)
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
	Florian Fainelli <florian.fainelli@broadcom.com>,
	David Regan <dregan@broadcom.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v5 10/12] mtd: rawnand: brcmnand: Support write protection setting from dts
Date: Wed,  7 Feb 2024 12:22:55 -0800
Message-Id: <20240207202257.271784-11-william.zhang@broadcom.com>
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

The write protection feature is controlled by the module parameter wp_on
with default set to enabled. But not all the board use this feature
especially in BCMBCA broadband board. And module parameter is not
sufficient as different board can have different option.  Add a device
tree property and allow this feature to be configured through the board
dts on per board basis.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>

---

Changes in v5: None
Changes in v4:
- Use the new brcm,wp-not-connected property based on the dts binding
change

Changes in v3: None
Changes in v2: None

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index efeee9e80213..8c1489ff7bd6 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -3218,6 +3218,10 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 	/* Disable XOR addressing */
 	brcmnand_rmw_reg(ctrl, BRCMNAND_CS_XOR, 0xff, 0, 0);
 
+	/* Check if the board connects the WP pin */
+	if (of_property_read_bool(dn, "brcm,wp-not-connected"))
+		wp_on = 0;
+
 	if (ctrl->features & BRCMNAND_HAS_WP) {
 		/* Permanently disable write protection */
 		if (wp_on == 2)
-- 
2.37.3


