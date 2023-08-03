Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C27B76E22D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjHCHzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjHCHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:54:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BCF8A75
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:43:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26824c32cfbso453807a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691048598; x=1691653398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYtZMjXodhA5vRSSpPNu8uTEt7aziOrY4tK7YzdA+uo=;
        b=FKJIi/gsJl3JfcSap6E6Vt2r7mOW4TWAroqb1zmDVHvIuVtRumHoq+UEgQkMZwRhCF
         cXX/7AMV+cwFpQkAVo1HLKpCEYy5afTKgWP1Kz45xOPMx02fz9U7PCN8cAXmzjygHY8t
         E08p3Oda9vE94Uy0mBFaEuYKBYqqj4gU4JCZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048598; x=1691653398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYtZMjXodhA5vRSSpPNu8uTEt7aziOrY4tK7YzdA+uo=;
        b=Gfwt0texxobwmgigWL3EKUeEoSOXKGcamixvmALOwhmmifXJWFUNrl+GPiNHOQfUwT
         Toebuv+RBT3IGSpHylmB3D9E2IEjU+Z6xYd8GC1/iJOxtXw5PShapu80w8rYQVvhsgeL
         4f9chFSz8D5x6ILZVwg1DmWmTq6rVTReKmHM5PsST1z+5eeecyCutuMd5TCgpvD11Qhh
         LKqEPg7HWWEAekLdBa0aKO3/LzT23Qcwuq00LbIa1W+JRXMDSec7NTZNP9eO87s0KG9v
         4o4P+JEqheC46eQdzdtWx97fseJ/KL46PwrfXLWM861NxEjzKqNETwFRsLJLtNcpvP6m
         3yhQ==
X-Gm-Message-State: ABy/qLYvmVywp3HyhaLtFGuoZMjgp1KInTlByRHGSth5JxotOMvUcabu
        gmeH17EGA+Wirdr2HGk9gxvGvj+hi7jW8W7FPT4=
X-Google-Smtp-Source: APBJJlF+1NPFptChmyQLuvlMDD23CL9DIJVTVJOQVWL4sdpBufIZ3RogUiIXTOX8sI4cCANaPO4mWQ==
X-Received: by 2002:a17:90b:1910:b0:268:2f6:61c4 with SMTP id mp16-20020a17090b191000b0026802f661c4mr23605812pjb.12.1691048598049;
        Thu, 03 Aug 2023 00:43:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6f3e:66ee:db46:473b])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a72cb00b00262d079720bsm2095753pjk.29.2023.08.03.00.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 00:43:17 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 8/9] regulator: mt6358: Add supply names for MT6366 regulators
Date:   Thu,  3 Aug 2023 15:42:46 +0800
Message-ID: <20230803074249.3065586-9-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230803074249.3065586-1-wenst@chromium.org>
References: <20230803074249.3065586-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT bindings for MT6366 regulator defines the supply names for the
PMIC.

Add support for them by adding .supply_name field settings for each
regulator. The buck regulators each have their own supply whose name
can be derived from the regulator name. The LDOs have shared supplies.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/mt6358-regulator.c | 73 ++++++++++++++--------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index c9fd5904d13f..b3de933c58b3 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -139,6 +139,7 @@ struct mt6358_regulator_info {
 [MT6366_ID_##vreg] = {	\
 	.desc = {	\
 		.name = #vreg,	\
+		.supply_name = "vsys_" match,		\
 		.of_match = of_match_ptr(match),	\
 		.ops = &mt6358_volt_range_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
@@ -161,10 +162,11 @@ struct mt6358_regulator_info {
 	.modeset_mask = BIT(_modeset_shift),	\
 }
 
-#define MT6366_LDO(match, vreg, volt_ranges, enreg, enbit, vosel, vosel_mask) \
+#define MT6366_LDO(match, vreg, volt_ranges, supply, enreg, enbit, vosel, vosel_mask) \
 [MT6366_ID_##vreg] = {	\
 	.desc = {	\
 		.name = #vreg,	\
+		.supply_name = supply,		\
 		.of_match = of_match_ptr(match),	\
 		.ops = &mt6358_volt_table_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
@@ -185,12 +187,13 @@ struct mt6358_regulator_info {
 	.qi = BIT(15),	\
 }
 
-#define MT6366_LDO1(match, vreg, min, max, step,	\
+#define MT6366_LDO1(match, vreg, supply, min, max, step,	\
 	_da_vsel_reg, _da_vsel_mask,	\
 	vosel, vosel_mask)	\
 [MT6366_ID_##vreg] = {	\
 	.desc = {	\
 		.name = #vreg,	\
+		.supply_name = supply,		\
 		.of_match = of_match_ptr(match),	\
 		.ops = &mt6358_volt_range_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
@@ -210,11 +213,12 @@ struct mt6358_regulator_info {
 	.qi = BIT(0),	\
 }
 
-#define MT6366_REG_FIXED(match, vreg,	\
+#define MT6366_REG_FIXED(match, vreg, supply,	\
 	enreg, enbit, volt)	\
 [MT6366_ID_##vreg] = {	\
 	.desc = {	\
 		.name = #vreg,	\
+		.supply_name = supply,		\
 		.of_match = of_match_ptr(match),	\
 		.ops = &mt6358_volt_fixed_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
@@ -589,57 +593,52 @@ static const struct mt6358_regulator_info mt6366_regulators[] = {
 		    0x7f, MT6358_BUCK_VMODEM_DBG0, 0x7f, MT6358_VMODEM_ANA_CON0, 8),
 	MT6366_BUCK("vs1", VS1, 1000000, 2587500, 12500,
 		    0x7f, MT6358_BUCK_VS1_DBG0, 0x7f, MT6358_VS1_ANA_CON0, 8),
-	MT6366_REG_FIXED("vrf12", VRF12,
-			 MT6358_LDO_VRF12_CON0, 0, 1200000),
-	MT6366_REG_FIXED("vio18", VIO18,
-			 MT6358_LDO_VIO18_CON0, 0, 1800000),
-	MT6366_REG_FIXED("vfe28", VFE28, MT6358_LDO_VFE28_CON0, 0, 2800000),
-	MT6366_REG_FIXED("vcn28", VCN28, MT6358_LDO_VCN28_CON0, 0, 2800000),
-	MT6366_REG_FIXED("vxo22", VXO22, MT6358_LDO_VXO22_CON0, 0, 2200000),
-	MT6366_REG_FIXED("vaux18", VAUX18,
-			 MT6358_LDO_VAUX18_CON0, 0, 1800000),
-	MT6366_REG_FIXED("vbif28", VBIF28,
-			 MT6358_LDO_VBIF28_CON0, 0, 2800000),
-	MT6366_REG_FIXED("vio28", VIO28, MT6358_LDO_VIO28_CON0, 0, 2800000),
-	MT6366_REG_FIXED("va12", VA12, MT6358_LDO_VA12_CON0, 0, 1200000),
-	MT6366_REG_FIXED("vrf18", VRF18, MT6358_LDO_VRF18_CON0, 0, 1800000),
-	MT6366_REG_FIXED("vaud28", VAUD28,
-			 MT6358_LDO_VAUD28_CON0, 0, 2800000),
-	MT6366_LDO("vdram2", VDRAM2, vdram2,
+	MT6366_REG_FIXED("vrf12", VRF12, "vs2_ldo2", MT6358_LDO_VRF12_CON0, 0, 1200000),
+	MT6366_REG_FIXED("vio18", VIO18, "vs1_ldo1", MT6358_LDO_VIO18_CON0, 0, 1800000),
+	MT6366_REG_FIXED("vfe28", VFE28, "vsys_ldo1", MT6358_LDO_VFE28_CON0, 0, 2800000),
+	MT6366_REG_FIXED("vcn28", VCN28, "vsys_ldo1", MT6358_LDO_VCN28_CON0, 0, 2800000),
+	MT6366_REG_FIXED("vxo22", VXO22, "vsys_ldo1", MT6358_LDO_VXO22_CON0, 0, 2200000),
+	MT6366_REG_FIXED("vaux18", VAUX18, "vsys_ldo1", MT6358_LDO_VAUX18_CON0, 0, 1800000),
+	MT6366_REG_FIXED("vbif28", VBIF28, "vsys_ldo1", MT6358_LDO_VBIF28_CON0, 0, 2800000),
+	MT6366_REG_FIXED("vio28", VIO28, "vsys_ldo2", MT6358_LDO_VIO28_CON0, 0, 2800000),
+	MT6366_REG_FIXED("va12", VA12, "vs2_ldo2", MT6358_LDO_VA12_CON0, 0, 1200000),
+	MT6366_REG_FIXED("vrf18", VRF18, "vs1_ldo1", MT6358_LDO_VRF18_CON0, 0, 1800000),
+	MT6366_REG_FIXED("vaud28", VAUD28, "vsys_ldo1", MT6358_LDO_VAUD28_CON0, 0, 2800000),
+	MT6366_LDO("vdram2", VDRAM2, vdram2, "vs2_ldo1",
 		   MT6358_LDO_VDRAM2_CON0, 0, MT6358_LDO_VDRAM2_ELR0, 0x10),
-	MT6366_LDO("vsim1", VSIM1, vsim,
+	MT6366_LDO("vsim1", VSIM1, vsim, "vsys_ldo1",
 		   MT6358_LDO_VSIM1_CON0, 0, MT6358_VSIM1_ANA_CON0, 0xf00),
-	MT6366_LDO("vibr", VIBR, vibr,
+	MT6366_LDO("vibr", VIBR, vibr, "vsys_ldo3",
 		   MT6358_LDO_VIBR_CON0, 0, MT6358_VIBR_ANA_CON0, 0xf00),
-	MT6366_LDO("vusb", VUSB, vusb,
+	MT6366_LDO("vusb", VUSB, vusb, "vsys_ldo1",
 		   MT6358_LDO_VUSB_CON0_0, 0, MT6358_VUSB_ANA_CON0, 0x700),
-	MT6366_LDO("vefuse", VEFUSE, vefuse,
+	MT6366_LDO("vefuse", VEFUSE, vefuse, "vs1_ldo1",
 		   MT6358_LDO_VEFUSE_CON0, 0, MT6358_VEFUSE_ANA_CON0, 0xf00),
-	MT6366_LDO("vmch", VMCH, vmch_vemc,
+	MT6366_LDO("vmch", VMCH, vmch_vemc, "vsys_ldo2",
 		   MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700),
-	MT6366_LDO("vemc", VEMC, vmch_vemc,
+	MT6366_LDO("vemc", VEMC, vmch_vemc, "vsys_ldo3",
 		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
-	MT6366_LDO("vcn33", VCN33, vcn33,
+	MT6366_LDO("vcn33", VCN33, vcn33, "vsys_ldo3",
 		   MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x300),
-	MT6366_LDO("vmc", VMC, vmc,
+	MT6366_LDO("vmc", VMC, vmc, "vsys_ldo2",
 		   MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
-	MT6366_LDO("vsim2", VSIM2, vsim,
+	MT6366_LDO("vsim2", VSIM2, vsim, "vsys_ldo2",
 		   MT6358_LDO_VSIM2_CON0, 0, MT6358_VSIM2_ANA_CON0, 0xf00),
-	MT6366_LDO("vcn18", VCN18, mt6366_vcn18_vm18,
+	MT6366_LDO("vcn18", VCN18, mt6366_vcn18_vm18, "vs1_ldo1",
 		   MT6358_LDO_VCN18_CON0, 0, MT6358_VCN18_ANA_CON0, 0xf00),
-	MT6366_LDO("vm18", VM18, mt6366_vcn18_vm18,
+	MT6366_LDO("vm18", VM18, mt6366_vcn18_vm18, "vs1_ldo1",
 		   MT6358_LDO_VM18_CON0, 0, MT6358_VM18_ANA_CON0, 0xf00),
-	MT6366_LDO("vmddr", VMDDR, mt6366_vmddr,
+	MT6366_LDO("vmddr", VMDDR, mt6366_vmddr, "vs2_ldo1",
 		   MT6358_LDO_VMDDR_CON0, 0, MT6358_VMDDR_ANA_CON0, 0xf00),
-	MT6366_LDO1("vsram-proc11", VSRAM_PROC11, 500000, 1293750, 6250,
+	MT6366_LDO1("vsram-proc11", VSRAM_PROC11, "vs2_ldo3", 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON0, 0x7f),
-	MT6366_LDO1("vsram-others", VSRAM_OTHERS, 500000, 1293750, 6250,
+	MT6366_LDO1("vsram-others", VSRAM_OTHERS, "vs2_ldo3", 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON2, 0x7f),
-	MT6366_LDO1("vsram-gpu", VSRAM_GPU, 500000, 1293750, 6250,
+	MT6366_LDO1("vsram-gpu", VSRAM_GPU, "vs2_ldo3", 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON3, 0x7f),
-	MT6366_LDO1("vsram-proc12", VSRAM_PROC12, 500000, 1293750, 6250,
+	MT6366_LDO1("vsram-proc12", VSRAM_PROC12, "vs2_ldo3", 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_PROC12_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON1, 0x7f),
-	MT6366_LDO1("vsram-core", VSRAM_CORE, 500000, 1293750, 6250,
+	MT6366_LDO1("vsram-core", VSRAM_CORE, "vs2_ldo3", 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_CORE_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON5, 0x7f),
 };
 
-- 
2.41.0.585.gd2178a4bd4-goog

