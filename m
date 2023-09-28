Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F349A7B16D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjI1JK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjI1I4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:56:22 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6F7CF7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:56:12 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-774141bb415so691912185a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695891372; x=1696496172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjsABOahH1p3zhr22T+S1Bqbs2ncgSaDPI7dTvpXP1g=;
        b=Qv3y42VTqnJfICg+JTjXXEVbSdHoLskiqQEn8L+S98E/RXhzTsDtBMJVrTy1Bjhxfb
         4tjK6C4HE8vQwL/TGswGY3W69ARBj4C1kPQRNJgSES+I3q++CeaExx/QE2XKXxn+NAOm
         c+U47XGlggZUoSFN7en5qQRXQD7IE5T3ddvIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695891372; x=1696496172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjsABOahH1p3zhr22T+S1Bqbs2ncgSaDPI7dTvpXP1g=;
        b=jriJXgrj7/GK2HXcv/R9WtidE6j+kAmRj1+MGK6WS26cA79D8IwmsxM1nUXFDlDxeU
         sRKNbTcoe9hz9tu1s9vSFQ925roja7AjxvnZlk+qR1iTKMoLpeZ6r57IZrmmoycPYHi4
         rnlgQtN1oDVtW9+yFRzQaQXSkPdWcdX0GyClxt2N78B7OnlkjTg0J0XAr05TDYUPEOpF
         HzWkNZG6ogXHZOZx+01QDpDYbqjh/pOm69ZmFCObHNVElG9yAtVU4owAZ+SJixKSyX1w
         OduZ17rSVQcXokfkPWQ3spNwSzwSJDg1xTbXup6IH300Iyc0dXaU+Lrq0FvjEOZgeib0
         TWBA==
X-Gm-Message-State: AOJu0YxkWNH3JMVsiUhfhoy0XDlQOeSDkoo1wYIJz0wLRUiBALMmzhpL
        cpszxflavkkO/1BOpQuhhiLCkg==
X-Google-Smtp-Source: AGHT+IFZINVPeqfJXErTN2rCie2lFwVJ1BC+/JJWIaLnQxgJjiXywQtmxwUlS2Xc1aMsn0eo3VO4Bw==
X-Received: by 2002:a05:620a:22b8:b0:774:cf9:b206 with SMTP id p24-20020a05620a22b800b007740cf9b206mr483427qkh.42.1695891371958;
        Thu, 28 Sep 2023 01:56:11 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6747:c12a:dbfd:2cc7])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78047000000b006879493aca0sm1754016pfm.26.2023.09.28.01.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:56:11 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 07/12] regulator: mt6358: Add supply names for MT6358 regulators
Date:   Thu, 28 Sep 2023 16:55:30 +0800
Message-ID: <20230928085537.3246669-8-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20230928085537.3246669-1-wenst@chromium.org>
References: <20230928085537.3246669-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT bindings for MT6358 regulator now defines the supply names for the
PMIC.

Add support for them by adding .supply_name field settings for each
regulator.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/mt6358-regulator.c | 106 +++++++++++++--------------
 1 file changed, 51 insertions(+), 55 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index f966eedbbd6e..3eb986d4e84b 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -33,12 +33,13 @@ struct mt6358_regulator_info {
 
 #define to_regulator_info(x) container_of((x), struct mt6358_regulator_info, desc)
 
-#define MT6358_BUCK(match, vreg, min, max, step,		\
-	vosel_mask, _da_vsel_reg, _da_vsel_mask,	\
-	_modeset_reg, _modeset_shift)		\
+#define MT6358_BUCK(match, vreg, supply, min, max, step,	\
+		    vosel_mask, _da_vsel_reg, _da_vsel_mask,	\
+		    _modeset_reg, _modeset_shift)		\
 [MT6358_ID_##vreg] = {	\
 	.desc = {	\
 		.name = #vreg,	\
+		.supply_name = supply,		\
 		.of_match = of_match_ptr(match),	\
 		.ops = &mt6358_buck_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
@@ -61,10 +62,11 @@ struct mt6358_regulator_info {
 	.modeset_mask = BIT(_modeset_shift),	\
 }
 
-#define MT6358_LDO(match, vreg, volt_ranges, enreg, enbit, vosel, vosel_mask) \
+#define MT6358_LDO(match, vreg, supply, volt_ranges, enreg, enbit, vosel, vosel_mask) \
 [MT6358_ID_##vreg] = {	\
 	.desc = {	\
 		.name = #vreg,	\
+		.supply_name = supply,		\
 		.of_match = of_match_ptr(match),	\
 		.ops = &mt6358_volt_table_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
@@ -85,12 +87,12 @@ struct mt6358_regulator_info {
 	.qi = BIT(15),	\
 }
 
-#define MT6358_LDO1(match, vreg, min, max, step,	\
-	_da_vsel_reg, _da_vsel_mask,	\
-	vosel, vosel_mask)	\
+#define MT6358_LDO1(match, vreg, supply, min, max, step,	\
+		    _da_vsel_reg, _da_vsel_mask, vosel, vosel_mask)	\
 [MT6358_ID_##vreg] = {	\
 	.desc = {	\
 		.name = #vreg,	\
+		.supply_name = supply,		\
 		.of_match = of_match_ptr(match),	\
 		.ops = &mt6358_volt_range_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
@@ -110,11 +112,11 @@ struct mt6358_regulator_info {
 	.qi = BIT(0),	\
 }
 
-#define MT6358_REG_FIXED(match, vreg,	\
-	enreg, enbit, volt)	\
+#define MT6358_REG_FIXED(match, vreg, supply, enreg, enbit, volt)	\
 [MT6358_ID_##vreg] = {	\
 	.desc = {	\
 		.name = #vreg,	\
+		.supply_name = supply,		\
 		.of_match = of_match_ptr(match),	\
 		.ops = &mt6358_volt_fixed_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
@@ -463,79 +465,73 @@ static const struct regulator_ops mt6358_volt_fixed_ops = {
 
 /* The array is indexed by id(MT6358_ID_XXX) */
 static const struct mt6358_regulator_info mt6358_regulators[] = {
-	MT6358_BUCK("buck_vdram1", VDRAM1, 500000, 2087500, 12500,
+	MT6358_BUCK("buck_vdram1", VDRAM1, "vsys-vdram1", 500000, 2087500, 12500,
 		    0x7f, MT6358_BUCK_VDRAM1_DBG0, 0x7f, MT6358_VDRAM1_ANA_CON0, 8),
-	MT6358_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
+	MT6358_BUCK("buck_vcore", VCORE, "vsys-vcore", 500000, 1293750, 6250,
 		    0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f, MT6358_VCORE_VGPU_ANA_CON0, 1),
-	MT6358_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
+	MT6358_BUCK("buck_vpa", VPA, "vsys-vpa", 500000, 3650000, 50000,
 		    0x3f, MT6358_BUCK_VPA_DBG0, 0x3f, MT6358_VPA_ANA_CON0, 3),
-	MT6358_BUCK("buck_vproc11", VPROC11, 500000, 1293750, 6250,
+	MT6358_BUCK("buck_vproc11", VPROC11, "vsys-vproc11", 500000, 1293750, 6250,
 		    0x7f, MT6358_BUCK_VPROC11_DBG0, 0x7f, MT6358_VPROC_ANA_CON0, 1),
-	MT6358_BUCK("buck_vproc12", VPROC12, 500000, 1293750, 6250,
+	MT6358_BUCK("buck_vproc12", VPROC12, "vsys-vproc12", 500000, 1293750, 6250,
 		    0x7f, MT6358_BUCK_VPROC12_DBG0, 0x7f, MT6358_VPROC_ANA_CON0, 2),
-	MT6358_BUCK("buck_vgpu", VGPU, 500000, 1293750, 6250,
+	MT6358_BUCK("buck_vgpu", VGPU, "vsys-vgpu", 500000, 1293750, 6250,
 		    0x7f, MT6358_BUCK_VGPU_ELR0, 0x7f, MT6358_VCORE_VGPU_ANA_CON0, 2),
-	MT6358_BUCK("buck_vs2", VS2, 500000, 2087500, 12500,
+	MT6358_BUCK("buck_vs2", VS2, "vsys-vs2", 500000, 2087500, 12500,
 		    0x7f, MT6358_BUCK_VS2_DBG0, 0x7f, MT6358_VS2_ANA_CON0, 8),
-	MT6358_BUCK("buck_vmodem", VMODEM, 500000, 1293750, 6250,
+	MT6358_BUCK("buck_vmodem", VMODEM, "vsys-vmodem", 500000, 1293750, 6250,
 		    0x7f, MT6358_BUCK_VMODEM_DBG0, 0x7f, MT6358_VMODEM_ANA_CON0, 8),
-	MT6358_BUCK("buck_vs1", VS1, 1000000, 2587500, 12500,
+	MT6358_BUCK("buck_vs1", VS1, "vsys-vs1", 1000000, 2587500, 12500,
 		    0x7f, MT6358_BUCK_VS1_DBG0, 0x7f, MT6358_VS1_ANA_CON0, 8),
-	MT6358_REG_FIXED("ldo_vrf12", VRF12,
-			 MT6358_LDO_VRF12_CON0, 0, 1200000),
-	MT6358_REG_FIXED("ldo_vio18", VIO18,
-			 MT6358_LDO_VIO18_CON0, 0, 1800000),
-	MT6358_REG_FIXED("ldo_vcamio", VCAMIO,
-			 MT6358_LDO_VCAMIO_CON0, 0, 1800000),
-	MT6358_REG_FIXED("ldo_vcn18", VCN18, MT6358_LDO_VCN18_CON0, 0, 1800000),
-	MT6358_REG_FIXED("ldo_vfe28", VFE28, MT6358_LDO_VFE28_CON0, 0, 2800000),
-	MT6358_REG_FIXED("ldo_vcn28", VCN28, MT6358_LDO_VCN28_CON0, 0, 2800000),
-	MT6358_REG_FIXED("ldo_vxo22", VXO22, MT6358_LDO_VXO22_CON0, 0, 2200000),
-	MT6358_REG_FIXED("ldo_vaux18", VAUX18,
-			 MT6358_LDO_VAUX18_CON0, 0, 1800000),
-	MT6358_REG_FIXED("ldo_vbif28", VBIF28,
-			 MT6358_LDO_VBIF28_CON0, 0, 2800000),
-	MT6358_REG_FIXED("ldo_vio28", VIO28, MT6358_LDO_VIO28_CON0, 0, 2800000),
-	MT6358_REG_FIXED("ldo_va12", VA12, MT6358_LDO_VA12_CON0, 0, 1200000),
-	MT6358_REG_FIXED("ldo_vrf18", VRF18, MT6358_LDO_VRF18_CON0, 0, 1800000),
-	MT6358_REG_FIXED("ldo_vaud28", VAUD28,
-			 MT6358_LDO_VAUD28_CON0, 0, 2800000),
-	MT6358_LDO("ldo_vdram2", VDRAM2, vdram2,
+	MT6358_REG_FIXED("ldo_vrf12", VRF12, "vs2-ldo2", MT6358_LDO_VRF12_CON0, 0, 1200000),
+	MT6358_REG_FIXED("ldo_vio18", VIO18, "vs1-ldo1", MT6358_LDO_VIO18_CON0, 0, 1800000),
+	MT6358_REG_FIXED("ldo_vcamio", VCAMIO, "vs1-ldo1", MT6358_LDO_VCAMIO_CON0, 0, 1800000),
+	MT6358_REG_FIXED("ldo_vcn18", VCN18, "vs1-ldo1", MT6358_LDO_VCN18_CON0, 0, 1800000),
+	MT6358_REG_FIXED("ldo_vfe28", VFE28, "vsys-ldo1", MT6358_LDO_VFE28_CON0, 0, 2800000),
+	MT6358_REG_FIXED("ldo_vcn28", VCN28, "vsys-ldo1", MT6358_LDO_VCN28_CON0, 0, 2800000),
+	MT6358_REG_FIXED("ldo_vxo22", VXO22, "vsys-ldo1", MT6358_LDO_VXO22_CON0, 0, 2200000),
+	MT6358_REG_FIXED("ldo_vaux18", VAUX18, "vsys-ldo1", MT6358_LDO_VAUX18_CON0, 0, 1800000),
+	MT6358_REG_FIXED("ldo_vbif28", VBIF28, "vsys-ldo1", MT6358_LDO_VBIF28_CON0, 0, 2800000),
+	MT6358_REG_FIXED("ldo_vio28", VIO28, "vsys-ldo2", MT6358_LDO_VIO28_CON0, 0, 2800000),
+	MT6358_REG_FIXED("ldo_va12", VA12, "vs2-ldo2", MT6358_LDO_VA12_CON0, 0, 1200000),
+	MT6358_REG_FIXED("ldo_vrf18", VRF18, "vs1-ldo1", MT6358_LDO_VRF18_CON0, 0, 1800000),
+	MT6358_REG_FIXED("ldo_vaud28", VAUD28, "vsys-ldo1", MT6358_LDO_VAUD28_CON0, 0, 2800000),
+	MT6358_LDO("ldo_vdram2", VDRAM2, "vs2-ldo1", vdram2,
 		   MT6358_LDO_VDRAM2_CON0, 0, MT6358_LDO_VDRAM2_ELR0, 0xf),
-	MT6358_LDO("ldo_vsim1", VSIM1, vsim,
+	MT6358_LDO("ldo_vsim1", VSIM1, "vsys-ldo1", vsim,
 		   MT6358_LDO_VSIM1_CON0, 0, MT6358_VSIM1_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vibr", VIBR, vibr,
+	MT6358_LDO("ldo_vibr", VIBR, "vsys-ldo3", vibr,
 		   MT6358_LDO_VIBR_CON0, 0, MT6358_VIBR_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vusb", VUSB, vusb,
+	MT6358_LDO("ldo_vusb", VUSB, "vsys-ldo1", vusb,
 		   MT6358_LDO_VUSB_CON0_0, 0, MT6358_VUSB_ANA_CON0, 0x700),
-	MT6358_LDO("ldo_vcamd", VCAMD, vcamd,
+	MT6358_LDO("ldo_vcamd", VCAMD, "vs2-ldo4", vcamd,
 		   MT6358_LDO_VCAMD_CON0, 0, MT6358_VCAMD_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vefuse", VEFUSE, vefuse,
+	MT6358_LDO("ldo_vefuse", VEFUSE, "vs1-ldo1", vefuse,
 		   MT6358_LDO_VEFUSE_CON0, 0, MT6358_VEFUSE_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vmch", VMCH, vmch_vemc,
+	MT6358_LDO("ldo_vmch", VMCH, "vsys-ldo2", vmch_vemc,
 		   MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700),
-	MT6358_LDO("ldo_vcama1", VCAMA1, vcama,
+	MT6358_LDO("ldo_vcama1", VCAMA1, "vsys-ldo3", vcama,
 		   MT6358_LDO_VCAMA1_CON0, 0, MT6358_VCAMA1_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vemc", VEMC, vmch_vemc,
+	MT6358_LDO("ldo_vemc", VEMC, "vsys-ldo2", vmch_vemc,
 		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
-	MT6358_LDO("ldo_vcn33", VCN33, vcn33,
+	MT6358_LDO("ldo_vcn33", VCN33, "vsys-ldo3", vcn33,
 		   MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x300),
-	MT6358_LDO("ldo_vcama2", VCAMA2, vcama,
+	MT6358_LDO("ldo_vcama2", VCAMA2, "vsys-ldo3", vcama,
 		   MT6358_LDO_VCAMA2_CON0, 0, MT6358_VCAMA2_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vmc", VMC, vmc,
+	MT6358_LDO("ldo_vmc", VMC, "vsys-ldo2", vmc,
 		   MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vldo28", VLDO28, vldo28,
+	MT6358_LDO("ldo_vldo28", VLDO28, "vsys-ldo2", vldo28,
 		   MT6358_LDO_VLDO28_CON0_0, 0,
 		   MT6358_VLDO28_ANA_CON0, 0x300),
-	MT6358_LDO("ldo_vsim2", VSIM2, vsim,
+	MT6358_LDO("ldo_vsim2", VSIM2, "vsys-ldo2", vsim,
 		   MT6358_LDO_VSIM2_CON0, 0, MT6358_VSIM2_ANA_CON0, 0xf00),
-	MT6358_LDO1("ldo_vsram_proc11", VSRAM_PROC11, 500000, 1293750, 6250,
+	MT6358_LDO1("ldo_vsram_proc11", VSRAM_PROC11, "vs2-ldo3", 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON0, 0x7f),
-	MT6358_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
+	MT6358_LDO1("ldo_vsram_others", VSRAM_OTHERS, "vs2-ldo3", 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON2, 0x7f),
-	MT6358_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
+	MT6358_LDO1("ldo_vsram_gpu", VSRAM_GPU, "vs2-ldo3", 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON3, 0x7f),
-	MT6358_LDO1("ldo_vsram_proc12", VSRAM_PROC12, 500000, 1293750, 6250,
+	MT6358_LDO1("ldo_vsram_proc12", VSRAM_PROC12, "vs2-ldo3", 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_PROC12_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON1, 0x7f),
 };
 
-- 
2.42.0.582.g8ccd20d70d-goog

