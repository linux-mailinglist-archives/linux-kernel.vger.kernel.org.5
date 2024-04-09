Return-Path: <linux-kernel+bounces-137113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0978389DD26
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5611C2377A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC7257873;
	Tue,  9 Apr 2024 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ayISxNYt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED74F898
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673916; cv=none; b=HWkG1qZeQxMmM3RqIPIerMAPbV94lBnoc4efd8ddjIscpZoK5dDe+tDtDB8NkTBlSzSJ7sSCHnT74LeceDAW8rWLNfAXnyCLXUqUjaKw5hEMOcd/BF3gzQyYZKtIZFrRus9iq3GXlmMj08pnYMtzyoNYXKyFaVDkwqvsbg1oM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673916; c=relaxed/simple;
	bh=UftbN0m2pUi/mwxebOuigXnwEqq3yH4KeqKijMHOaP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUK6p8zeZtequy24a4Ytj6rm3BV9E7Gsd1jID4ANw74Aph0Pj4CEv7iarWMHvM+vszLC5dO05k9Ql79qfp6OQCF1tCg9/nv8TZ561oEvGWq1vLi65bo7b+PgJFYtRZrzpBz4vwix83jKQCL+0ggrG+qjdKfzDbhrn1NyDk5znes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ayISxNYt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712673913;
	bh=UftbN0m2pUi/mwxebOuigXnwEqq3yH4KeqKijMHOaP8=;
	h=From:To:Cc:Subject:Date:From;
	b=ayISxNYt4kSq5+SwfhSdyxXlr/oBi6qEP87xBL/Xa9n93optnT22mmt+mrQ2x0MG/
	 yuhl2ahd5+Kiwl+pD/7Da7dP3jFY3Zx9+7aTrD+kmmt1WOFaLw8CWucl5s9qcSXJhr
	 Slv3apRtbXy0Z87l10EVfZ2KII1MSjzKxFdfXglYCkcyq9kfxDlPvBTODSbUmZ7o2H
	 C+HRstZ9HKXQ14NzwfJUMNQpsIET6ktidFg4lbgGSNKrDOIquTcBvhVKKVuIHNSigF
	 aAqgahfzp8RJ92DHcKMAWZYHlmIUeu+sGS1r5lZQVdzxFlzo5yGR1v7K6TDSpBBScW
	 rCKtPveO1DxDg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7B4C0378201A;
	Tue,  9 Apr 2024 14:45:12 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: lgirdwood@gmail.com
Cc: broonie@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	gene_chen@richtek.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] regulator: mt6360: De-capitalize devicetree regulator subnodes
Date: Tue,  9 Apr 2024 16:44:38 +0200
Message-ID: <20240409144438.410060-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT6360 regulator binding, the example in the MT6360 mfd binding, and
the devicetree users of those bindings are rightfully declaring MT6360
regulator subnodes with non-capital names, and luckily without using the
deprecated regulator-compatible property.

With this driver declaring capitalized BUCKx/LDOx as of_match string for
the node names, obviously no regulator gets probed: fix that by changing
the MT6360_REGULATOR_DESC macro to add a "match" parameter which gets
assigned to the of_match.

Fixes: d321571d5e4c ("regulator: mt6360: Add support for MT6360 regulator")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/mt6360-regulator.c | 32 +++++++++++++++++-----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/mt6360-regulator.c b/drivers/regulator/mt6360-regulator.c
index ad6587a378d0..24cc9fc94e90 100644
--- a/drivers/regulator/mt6360-regulator.c
+++ b/drivers/regulator/mt6360-regulator.c
@@ -319,15 +319,15 @@ static unsigned int mt6360_regulator_of_map_mode(unsigned int hw_mode)
 	}
 }
 
-#define MT6360_REGULATOR_DESC(_name, _sname, ereg, emask, vreg,	vmask,	\
-			      mreg, mmask, streg, stmask, vranges,	\
-			      vcnts, offon_delay, irq_tbls)		\
+#define MT6360_REGULATOR_DESC(match, _name, _sname, ereg, emask, vreg,	\
+			      vmask, mreg, mmask, streg, stmask,	\
+			      vranges, vcnts, offon_delay, irq_tbls)	\
 {									\
 	.desc = {							\
 		.name = #_name,						\
 		.supply_name = #_sname,					\
 		.id =  MT6360_REGULATOR_##_name,			\
-		.of_match = of_match_ptr(#_name),			\
+		.of_match = of_match_ptr(match),			\
 		.regulators_node = of_match_ptr("regulator"),		\
 		.of_map_mode = mt6360_regulator_of_map_mode,		\
 		.owner = THIS_MODULE,					\
@@ -351,21 +351,29 @@ static unsigned int mt6360_regulator_of_map_mode(unsigned int hw_mode)
 }
 
 static const struct mt6360_regulator_desc mt6360_regulator_descs[] =  {
-	MT6360_REGULATOR_DESC(BUCK1, BUCK1_VIN, 0x117, 0x40, 0x110, 0xff, 0x117, 0x30, 0x117, 0x04,
+	MT6360_REGULATOR_DESC("buck1", BUCK1, BUCK1_VIN,
+			      0x117, 0x40, 0x110, 0xff, 0x117, 0x30, 0x117, 0x04,
 			      buck_vout_ranges, 256, 0, buck1_irq_tbls),
-	MT6360_REGULATOR_DESC(BUCK2, BUCK2_VIN, 0x127, 0x40, 0x120, 0xff, 0x127, 0x30, 0x127, 0x04,
+	MT6360_REGULATOR_DESC("buck2", BUCK2, BUCK2_VIN,
+			      0x127, 0x40, 0x120, 0xff, 0x127, 0x30, 0x127, 0x04,
 			      buck_vout_ranges, 256, 0, buck2_irq_tbls),
-	MT6360_REGULATOR_DESC(LDO6, LDO_VIN3, 0x137, 0x40, 0x13B, 0xff, 0x137, 0x30, 0x137, 0x04,
+	MT6360_REGULATOR_DESC("ldo6", LDO6, LDO_VIN3,
+			      0x137, 0x40, 0x13B, 0xff, 0x137, 0x30, 0x137, 0x04,
 			      ldo_vout_ranges1, 256, 0, ldo6_irq_tbls),
-	MT6360_REGULATOR_DESC(LDO7, LDO_VIN3, 0x131, 0x40, 0x135, 0xff, 0x131, 0x30, 0x131, 0x04,
+	MT6360_REGULATOR_DESC("ldo7", LDO7, LDO_VIN3,
+			      0x131, 0x40, 0x135, 0xff, 0x131, 0x30, 0x131, 0x04,
 			      ldo_vout_ranges1, 256, 0, ldo7_irq_tbls),
-	MT6360_REGULATOR_DESC(LDO1, LDO_VIN1, 0x217, 0x40, 0x21B, 0xff, 0x217, 0x30, 0x217, 0x04,
+	MT6360_REGULATOR_DESC("ldo1", LDO1, LDO_VIN1,
+			      0x217, 0x40, 0x21B, 0xff, 0x217, 0x30, 0x217, 0x04,
 			      ldo_vout_ranges2, 256, 0, ldo1_irq_tbls),
-	MT6360_REGULATOR_DESC(LDO2, LDO_VIN1, 0x211, 0x40, 0x215, 0xff, 0x211, 0x30, 0x211, 0x04,
+	MT6360_REGULATOR_DESC("ldo2", LDO2, LDO_VIN1,
+			      0x211, 0x40, 0x215, 0xff, 0x211, 0x30, 0x211, 0x04,
 			      ldo_vout_ranges2, 256, 0, ldo2_irq_tbls),
-	MT6360_REGULATOR_DESC(LDO3, LDO_VIN1, 0x205, 0x40, 0x209, 0xff, 0x205, 0x30, 0x205, 0x04,
+	MT6360_REGULATOR_DESC("ldo3", LDO3, LDO_VIN1,
+			      0x205, 0x40, 0x209, 0xff, 0x205, 0x30, 0x205, 0x04,
 			      ldo_vout_ranges2, 256, 100, ldo3_irq_tbls),
-	MT6360_REGULATOR_DESC(LDO5, LDO_VIN2, 0x20B, 0x40, 0x20F, 0x7f, 0x20B, 0x30, 0x20B, 0x04,
+	MT6360_REGULATOR_DESC("ldo5", LDO5, LDO_VIN2,
+			      0x20B, 0x40, 0x20F, 0x7f, 0x20B, 0x30, 0x20B, 0x04,
 			      ldo_vout_ranges3, 128, 100, ldo5_irq_tbls),
 };
 
-- 
2.44.0


