Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22AA7A17C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjIOHu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjIOHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:50:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EE71724;
        Fri, 15 Sep 2023 00:50:15 -0700 (PDT)
X-UUID: 7ca0e9fa539c11ee8051498923ad61e6-20230915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xXixUDLcZx+MMPBAO31CYNC2+BNKzVejaGTtSN01Sbo=;
        b=CRVIgXPNaNFj4OFvsj2tZsjBLvhZgw0m39RfvOcfOqHO1Ih1kQDFpBV4ud6t2m196ZJnSVdYdor+I8RZD23gj5U/FRGp96Roc7GFyvL1G9VASCPBOA9Ls34rfKGfizKpJIpO/tGbt8Dc9E3FONmLY/SioslKz1pTrl6ng8qrC3w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:6c884027-ecd8-49a0-b100-6bc0f252294f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:1d1310c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7ca0e9fa539c11ee8051498923ad61e6-20230915
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1337489488; Fri, 15 Sep 2023 15:50:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Sep 2023 15:50:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Sep 2023 15:50:05 +0800
From:   Mark Tseng <chun-jen.tseng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <chun-jen.tseng@mediatek.com>
Subject: [PATCH v1 2/2] soc: mediatek: svs: add support for mt8188
Date:   Fri, 15 Sep 2023 15:50:03 +0800
Message-ID: <20230915075003.1552-3-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230915075003.1552-1-chun-jen.tseng@mediatek.com>
References: <20230915075003.1552-1-chun-jen.tseng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8188 svs gpu uses 2-line high bank and low bank to optimize the
voltage of opp table for higher and lower frequency respectively.

Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 177 ++++++++++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 3a2f97cd5272..fafc72df99ee 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -407,6 +407,7 @@ struct svs_platform_data {
  * @dcbdet: svs efuse data
  * @dcmdet: svs efuse data
  * @turn_pt: 2-line turn point tells which opp_volt calculated by high/low bank
+ * @vbin_turn_pt: voltage bin turn point helps know which svsb_volt should be overridden
  * @type: bank type to represent it is 2-line (high/low) bank or 1-line bank
  *
  * Svs bank will generate suitalbe voltages by below general math equation
@@ -469,6 +470,7 @@ struct svs_bank {
 	u32 dcbdet;
 	u32 dcmdet;
 	u32 turn_pt;
+	u32 vbin_turn_pt;
 	u32 type;
 };
 
@@ -751,11 +753,12 @@ static int svs_status_debug_show(struct seq_file *m, void *v)
 
 	ret = thermal_zone_get_temp(svsb->tzd, &tzone_temp);
 	if (ret)
-		seq_printf(m, "%s: temperature ignore, turn_pt = %u\n",
-			   svsb->name, svsb->turn_pt);
+		seq_printf(m, "%s: temperature ignore, vbin_turn_pt = %u, turn_pt = %u\n",
+			   svsb->name, svsb->vbin_turn_pt, svsb->turn_pt);
 	else
-		seq_printf(m, "%s: temperature = %d, turn_pt = %u\n",
-			   svsb->name, tzone_temp, svsb->turn_pt);
+		seq_printf(m, "%s: temperature = %d, vbin_turn_pt = %u, turn_pt = %u\n",
+			   svsb->name, tzone_temp, svsb->vbin_turn_pt,
+			   svsb->turn_pt);
 
 	for (i = 0; i < svsb->opp_count; i++) {
 		opp = dev_pm_opp_find_freq_exact(svsb->opp_dev,
@@ -952,6 +955,29 @@ static void svs_get_bank_volts_v3(struct svs_platform *svsp)
 	for (i = opp_start; i < opp_stop; i++)
 		if (svsb->volt_flags & SVSB_REMOVE_DVTFIXED_VOLT)
 			svsb->volt[i] -= svsb->dvt_fixed;
+
+	/* For voltage bin support */
+	if (svsb->opp_dfreq[0] > svsb->freq_base) {
+		svsb->volt[0] = svs_opp_volt_to_bank_volt(svsb->opp_dvolt[0],
+							  svsb->volt_step,
+							  svsb->volt_base);
+
+		/* Find voltage bin turn point */
+		for (i = 0; i < svsb->opp_count; i++) {
+			if (svsb->opp_dfreq[i] <= svsb->freq_base) {
+				svsb->vbin_turn_pt = i;
+				break;
+			}
+		}
+
+		/* Override svs bank voltages */
+		for (i = 1; i < svsb->vbin_turn_pt; i++)
+			svsb->volt[i] = interpolate(svsb->freq_pct[0],
+						    svsb->freq_pct[svsb->vbin_turn_pt],
+						    svsb->volt[0],
+						    svsb->volt[svsb->vbin_turn_pt],
+						    svsb->freq_pct[i]);
+	}
 }
 
 static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
@@ -1808,6 +1834,80 @@ static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
 	return true;
 }
 
+static bool svs_mt8188_efuse_parsing(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb;
+	struct nvmem_cell *cell;
+	u32 idx, i, golden_temp;
+
+	for (i = 0; i < svsp->efuse_max; i++)
+		if (svsp->efuse[i])
+			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
+				 i, svsp->efuse[i]);
+
+	if (!svsp->efuse[5]) {
+		dev_notice(svsp->dev, "svs_efuse[5] = 0x0?\n");
+		return false;
+	}
+
+	/* Svs efuse parsing */
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (svsb->type == SVSB_LOW) {
+			svsb->mtdes = svsp->efuse[5] & GENMASK(7, 0);
+			svsb->bdes = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[5] >> 24) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[15] >> 16) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[15] >> 24) & GENMASK(7, 0);
+		} else if (svsb->type == SVSB_HIGH) {
+			svsb->mtdes = svsp->efuse[4] & GENMASK(7, 0);
+			svsb->bdes = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
+			svsb->dcbdet = svsp->efuse[14] & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[14] >> 8) & GENMASK(7, 0);
+		}
+
+		svsb->vmax += svsb->dvt_fixed;
+	}
+
+	/* Thermal efuse parsing */
+	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
+	if (IS_ERR_OR_NULL(cell)) {
+		dev_err(svsp->dev, "no \"t-calibration-data\"? %ld\n",
+			PTR_ERR(cell));
+		return false;
+	}
+
+	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_max);
+	if (IS_ERR(svsp->tefuse)) {
+		dev_err(svsp->dev, "cannot read thermal efuse: %ld\n",
+			PTR_ERR(svsp->tefuse));
+		nvmem_cell_put(cell);
+		return false;
+	}
+
+	svsp->tefuse_max /= sizeof(u32);
+	nvmem_cell_put(cell);
+
+	for (i = 0; i < svsp->tefuse_max; i++)
+		if (svsp->tefuse[i] != 0)
+			break;
+
+	if (i == svsp->tefuse_max)
+		golden_temp = 50; /* All thermal efuse data are 0 */
+	else
+		golden_temp = (svsp->tefuse[0] & GENMASK(31, 24)) >> 24;
+
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+		svsb->mts = 500;
+		svsb->bts = (((500 * golden_temp + 250460) / 1000) - 25) * 4;
+	}
+
+	return true;
+}
+
 static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb;
@@ -2052,7 +2152,7 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 		return dev_err_probe(svsp->dev, PTR_ERR(svsp->rst),
 				     "cannot get svs reset control\n");
 
-	dev = svs_add_device_link(svsp, "lvts");
+	dev = svs_add_device_link(svsp, "thermal-sensor");
 	if (IS_ERR(dev))
 		return dev_err_probe(svsp->dev, PTR_ERR(dev),
 				     "failed to get lvts device\n");
@@ -2173,6 +2273,61 @@ static struct svs_bank svs_mt8192_banks[] = {
 	},
 };
 
+static struct svs_bank svs_mt8188_banks[] = {
+	{
+		.sw_id			= SVSB_GPU,
+		.type			= SVSB_LOW,
+		.set_freq_pct		= svs_set_bank_freq_pct_v3,
+		.get_volts		= svs_get_bank_volts_v3,
+		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT,
+		.mode_support		= SVSB_MODE_INIT02,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 640000000,
+		.turn_freq_base		= 640000000,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.vmax			= 0x38,
+		.vmin			= 0x1c,
+		.age_config		= 0x555555,
+		.dc_config		= 0x555555,
+		.dvt_fixed		= 0x1,
+		.vco			= 0x10,
+		.chk_shift		= 0x87,
+		.core_sel		= 0x0fff0000,
+		.int_st			= BIT(0),
+		.ctl0			= 0x00100003,
+	},
+	{
+		.sw_id			= SVSB_GPU,
+		.type			= SVSB_HIGH,
+		.set_freq_pct		= svs_set_bank_freq_pct_v3,
+		.get_volts		= svs_get_bank_volts_v3,
+		.tzone_name		= "gpu1",
+		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT |
+					  SVSB_MON_VOLT_IGNORE,
+		.mode_support		= SVSB_MODE_INIT02 | SVSB_MODE_MON,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 880000000,
+		.turn_freq_base		= 640000000,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.vmax			= 0x38,
+		.vmin			= 0x1c,
+		.age_config		= 0x555555,
+		.dc_config		= 0x555555,
+		.dvt_fixed		= 0x4,
+		.vco			= 0x10,
+		.chk_shift		= 0x87,
+		.core_sel		= 0x0fff0001,
+		.int_st			= BIT(1),
+		.ctl0			= 0x00100003,
+		.tzone_htemp		= 85000,
+		.tzone_htemp_voffset	= 0,
+		.tzone_ltemp		= 25000,
+		.tzone_ltemp_voffset	= 7,
+	},
+};
+
 static struct svs_bank svs_mt8183_banks[] = {
 	{
 		.sw_id			= SVSB_CPU_LITTLE,
@@ -2286,6 +2441,15 @@ static const struct svs_platform_data svs_mt8192_platform_data = {
 	.bank_max = ARRAY_SIZE(svs_mt8192_banks),
 };
 
+static const struct svs_platform_data svs_mt8188_platform_data = {
+	.name = "mt8188-svs",
+	.banks = svs_mt8188_banks,
+	.efuse_parsing = svs_mt8188_efuse_parsing,
+	.probe = svs_mt8192_platform_probe,
+	.regs = svs_regs_v2,
+	.bank_max = ARRAY_SIZE(svs_mt8188_banks),
+};
+
 static const struct svs_platform_data svs_mt8183_platform_data = {
 	.name = "mt8183-svs",
 	.banks = svs_mt8183_banks,
@@ -2299,6 +2463,9 @@ static const struct of_device_id svs_of_match[] = {
 	{
 		.compatible = "mediatek,mt8192-svs",
 		.data = &svs_mt8192_platform_data,
+	}, {
+		.compatible = "mediatek,mt8188-svs",
+		.data = &svs_mt8188_platform_data,
 	}, {
 		.compatible = "mediatek,mt8183-svs",
 		.data = &svs_mt8183_platform_data,
-- 
2.18.0

