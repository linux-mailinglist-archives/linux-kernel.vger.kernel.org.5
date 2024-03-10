Return-Path: <linux-kernel+bounces-98066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B9C8774AF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351011F21306
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14A823B7;
	Sun, 10 Mar 2024 01:02:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A97A40;
	Sun, 10 Mar 2024 01:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710032561; cv=none; b=iY5kFbkQJ18wbzOzkX/zxHeGG0V7Rj15RxXq8ofIB36WcJW8rqmBJedw04uLNa5XWdWkKN6BjIsRZDlrsuJziP85iiW5S7U4AT1KJTPCL+SohA9keF6UT+4b43kwILE+b4XpAUaHnGSZyT5BT8evE5hRPoWRNkTd87Un3P80Ep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710032561; c=relaxed/simple;
	bh=5O7AQF5CDHALvPbHjXmI3faWolFoR0At0TyxYjrJeeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q25BAgEWaobtbj1IJAtBmFFQTOwH8jJAxZp0IhcdVTutFF9kIAXMEiDVJpfIyavxRP7le1VtxSuNTic0EaPjkoJHV1/4t+AsVS5c6pVV/RFkt/ixdwngx6zTNLoE5CdElsrZiAI+ln9JucZm+Kd6VCcqv8bd8UZ775RJH7DDdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79DFE1480;
	Sat,  9 Mar 2024 17:03:09 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D5613F73F;
	Sat,  9 Mar 2024 17:02:31 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 1/4] regulator: axp20x: fix typo-ed identifier
Date: Sun, 10 Mar 2024 01:02:08 +0000
Message-Id: <20240310010211.28653-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240310010211.28653-1-andre.przywara@arm.com>
References: <20240310010211.28653-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The registers to set the X-Powers AXP313 regulators are of course
"CONTROL" registers, not "CONRTOL" ones.

Fix the typo in the header file and in its users. No functional change.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/regulator/axp20x-regulator.c | 10 +++++-----
 include/linux/mfd/axp20x.h           | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index c657820b0bbb5..7bcc2d508b65a 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -733,21 +733,21 @@ static const struct linear_range axp313a_dcdc3_ranges[] = {
 static const struct regulator_desc axp313a_regulators[] = {
 	AXP_DESC_RANGES(AXP313A, DCDC1, "dcdc1", "vin1",
 			axp313a_dcdc1_ranges, AXP313A_DCDC1_NUM_VOLTAGES,
-			AXP313A_DCDC1_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
+			AXP313A_DCDC1_CONTROL, AXP313A_DCDC_V_OUT_MASK,
 			AXP313A_OUTPUT_CONTROL, BIT(0)),
 	AXP_DESC_RANGES(AXP313A, DCDC2, "dcdc2", "vin2",
 			axp313a_dcdc2_ranges, AXP313A_DCDC23_NUM_VOLTAGES,
-			AXP313A_DCDC2_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
+			AXP313A_DCDC2_CONTROL, AXP313A_DCDC_V_OUT_MASK,
 			AXP313A_OUTPUT_CONTROL, BIT(1)),
 	AXP_DESC_RANGES(AXP313A, DCDC3, "dcdc3", "vin3",
 			axp313a_dcdc3_ranges, AXP313A_DCDC23_NUM_VOLTAGES,
-			AXP313A_DCDC3_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
+			AXP313A_DCDC3_CONTROL, AXP313A_DCDC_V_OUT_MASK,
 			AXP313A_OUTPUT_CONTROL, BIT(2)),
 	AXP_DESC(AXP313A, ALDO1, "aldo1", "vin1", 500, 3500, 100,
-		 AXP313A_ALDO1_CONRTOL, AXP313A_LDO_V_OUT_MASK,
+		 AXP313A_ALDO1_CONTROL, AXP313A_LDO_V_OUT_MASK,
 		 AXP313A_OUTPUT_CONTROL, BIT(3)),
 	AXP_DESC(AXP313A, DLDO1, "dldo1", "vin1", 500, 3500, 100,
-		 AXP313A_DLDO1_CONRTOL, AXP313A_LDO_V_OUT_MASK,
+		 AXP313A_DLDO1_CONTROL, AXP313A_LDO_V_OUT_MASK,
 		 AXP313A_OUTPUT_CONTROL, BIT(4)),
 	AXP_DESC_FIXED(AXP313A, RTC_LDO, "rtc-ldo", "vin1", 1800),
 };
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index f1755163dd9f1..9b2b7ac2107f4 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -104,11 +104,11 @@ enum axp20x_variants {
 
 #define AXP313A_ON_INDICATE		0x00
 #define AXP313A_OUTPUT_CONTROL		0x10
-#define AXP313A_DCDC1_CONRTOL		0x13
-#define AXP313A_DCDC2_CONRTOL		0x14
-#define AXP313A_DCDC3_CONRTOL		0x15
-#define AXP313A_ALDO1_CONRTOL		0x16
-#define AXP313A_DLDO1_CONRTOL		0x17
+#define AXP313A_DCDC1_CONTROL		0x13
+#define AXP313A_DCDC2_CONTROL		0x14
+#define AXP313A_DCDC3_CONTROL		0x15
+#define AXP313A_ALDO1_CONTROL		0x16
+#define AXP313A_DLDO1_CONTROL		0x17
 #define AXP313A_SHUTDOWN_CTRL		0x1a
 #define AXP313A_IRQ_EN			0x20
 #define AXP313A_IRQ_STATE		0x21
-- 
2.35.8


