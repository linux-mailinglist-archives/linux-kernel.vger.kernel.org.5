Return-Path: <linux-kernel+bounces-116986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A44088A5D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D67D1C39809
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B141147C6F;
	Mon, 25 Mar 2024 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cmjLs/AX"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1013146D46;
	Mon, 25 Mar 2024 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369166; cv=none; b=ajHR/L7YRfHFnwDJLHOfr7f7lfinSXTqg55ZGj73Z/m/GvcFo4XM1itvsvxJy/aWetAM9SAUCpJJ8Btg1VqPDvLyZZh0Zw263eiaGx7gPb10k/UF4XEjfwebG+N+uvhmOBJ0ctaKhZ3HivxKPYk5LATsJP+wtyZETIukcjFRprE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369166; c=relaxed/simple;
	bh=R1JXzbStYXKW0W8uATT6sTW8gpZYe1Hs2sTYq2U3Q00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpAyM3bANKZd04cwSAGnLjzN80FOo658fQwz6Sa5dUy0tSXacLijXKZ0EmgpQst5Jqt0aPxyAAdDsgnEg4/MwScBmPMa0btxSrXbhtvANMiuXSXeUZb39Fg6xUknfhInhDTFND/iUllxe8q9JZy4GRwAF/8WgdFMRuHQ8+1lBZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cmjLs/AX; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e5ded32ceaa111eeb8927bc1f75efef4-20240325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4sLEnPsFPQ4wRaWZ5jE/hfeLE57gwcIPemTYqqxv+Ik=;
	b=cmjLs/AXLI33dXZdzctoCP5twdaFbIZkm8d0aEJCC1EbEGo3LibDJbQtHsk1VJvPCn+JXAapcKBR1RsYRmy+LaWdcdPkgmpsRE+57hHwFrkg3Ri35Vtaqw9Q/MYavjKu18eE77zEvVkB4+8Vx+pbO+TEocj0Das9y8UfyI4p4tU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:0fb6ecfc-14d3-43f8-a62d-bc5eb3666fca,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:4306cf90-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e5ded32ceaa111eeb8927bc1f75efef4-20240325
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <yu-chang.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 745035205; Mon, 25 Mar 2024 20:19:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Mar 2024 20:19:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Mar 2024 20:19:14 +0800
From: yu-chang.lee <yu-chang.lee@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<mandyjh.liu@mediatek.com>, <fan.chen@mediatek.com>,
	<xiufeng.li@mediatek.com>, <yu-chang.lee@mediatek.com>
Subject: [PATCH 2/2] soc: mediatek: pm-domains: support smi clamp protection
Date: Mon, 25 Mar 2024 20:19:08 +0800
Message-ID: <20240325121908.3958-3-yu-chang.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240325121908.3958-1-yu-chang.lee@mediatek.com>
References: <20240325121908.3958-1-yu-chang.lee@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.232700-8.000000
X-TMASE-MatchedRID: 82HXDiODsmMPv5/+N9RjEodlc1JaOB1TSjyMfjCRfaPfUZT83lbkEN6M
	yUV+2+DZ23e6ga05Tae8t+v2unSIfNYOxuVS5w3+98sqn8kK3uEOPDBPSvoRdKvM+zzl/BSTmtc
	Q2r1onEyw2nks2gP6QWjT8PQAXOh+Fn6miqL6+G1c/msUC5wFQT4H4hoqLeJJfmHrLgoJIlxQqT
	fsthoSXC3czQwuDa9VvU52Vy7HkdYfE8yM4pjsDwtuKBGekqUpOlxBO2IcOBbySgIkk90zzqHh9
	ol1FR9sR7VEdXK04ughltD7NXKg1VD0eWBFH1w4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.232700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	02B601C143082A5EB99CE72FF1848A917E984C747259A9787E86FEA6106D85A62000:8
X-MTK: N

In order to avoid power glitch, this patch use smi clamp
to disable/enable smi common port.

Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>
---
 drivers/pmdomain/mediatek/mt8188-pm-domains.h |  41 ++++-
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 147 ++++++++++++++----
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |   1 +
 3 files changed, 156 insertions(+), 33 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mt8188-pm-domains.h b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
index 7bbba4d56a77..39f057dca92c 100644
--- a/drivers/pmdomain/mediatek/mt8188-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
@@ -573,6 +573,18 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(SMI,
+				    MT8188_SMI_COMMON_SMI_CLAMP_DIP_TO_VDO0,
+				    MT8188_SMI_COMMON_CLAMP_EN_SET,
+				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8188_SMI_COMMON_CLAMP_EN_STA),
+			BUS_PROT_WR(SMI,
+				    MT8188_SMI_COMMON_SMI_CLAMP_DIP_TO_VPP1,
+				    MT8188_SMI_COMMON_CLAMP_EN_SET,
+				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8188_SMI_COMMON_CLAMP_EN_STA),
+		},
 		.reset_smi = {
 			SMI_RESET_WR(MT8188_SMI_LARB10_RESET,
 				     MT8188_SMI_LARB10_RESET_ADDR),
@@ -585,7 +597,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 			SMI_RESET_WR(MT8188_SMI_LARB15_RESET,
 				     MT8188_SMI_LARB15_RESET_ADDR),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_CLAMP_PROTECTION,
 	},
 	[MT8188_POWER_DOMAIN_IPE] = {
 		.name = "ipe",
@@ -595,11 +607,18 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(SMI,
+				    MT8188_SMI_COMMON_SMI_CLAMP_IPE_TO_VPP1,
+				    MT8188_SMI_COMMON_CLAMP_EN_SET,
+				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8188_SMI_COMMON_CLAMP_EN_STA),
+		},
 		.reset_smi = {
 			SMI_RESET_WR(MT8188_SMI_LARB12_RESET,
 				     MT8188_SMI_LARB12_RESET_ADDR),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_CLAMP_PROTECTION,
 	},
 	[MT8188_POWER_DOMAIN_CAM_VCORE] = {
 		.name = "cam_vcore",
@@ -676,13 +695,20 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(SMI,
+				    MT8188_SMI_COMMON_SMI_CLAMP_IPE_TO_VPP1,
+				    MT8188_SMI_COMMON_CLAMP_EN_SET,
+				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8188_SMI_COMMON_CLAMP_EN_STA),
+		},
 		.reset_smi = {
 			SMI_RESET_WR(MT8188_SMI_LARB16A_RESET,
 				     MT8188_SMI_LARB16A_RESET_ADDR),
 			SMI_RESET_WR(MT8188_SMI_LARB17A_RESET,
 				     MT8188_SMI_LARB17A_RESET_ADDR),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_CLAMP_PROTECTION,
 	},
 	[MT8188_POWER_DOMAIN_CAM_SUBB] = {
 		.name = "cam_subb",
@@ -692,13 +718,20 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(SMI,
+				    MT8188_SMI_COMMON_SMI_CLAMP_CAM_SUBB_TO_VDO0,
+				    MT8188_SMI_COMMON_CLAMP_EN_SET,
+				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8188_SMI_COMMON_CLAMP_EN_STA),
+		},
 		.reset_smi = {
 			SMI_RESET_WR(MT8188_SMI_LARB16B_RESET,
 				     MT8188_SMI_LARB16B_RESET_ADDR),
 			SMI_RESET_WR(MT8188_SMI_LARB17B_RESET,
 				     MT8188_SMI_LARB17B_RESET_ADDR),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_CLAMP_PROTECTION,
 	},
 };
 
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 9ab6fa105c8c..3c797e136c0e 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -47,9 +47,10 @@ struct scpsys_domain {
 	struct clk_bulk_data *subsys_clks;
 	struct regmap *infracfg_nao;
 	struct regmap *infracfg;
-	struct regmap *smi;
+	struct regmap **smi;
 	struct regmap **larb;
 	int num_larb;
+	int num_smi;
 	struct regulator *supply;
 };
 
@@ -122,29 +123,19 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 					MTK_POLL_TIMEOUT);
 }
 
-static struct regmap *scpsys_bus_protect_get_regmap(struct scpsys_domain *pd,
-						    const struct scpsys_bus_prot_data *bpd)
-{
-	if (bpd->flags & BUS_PROT_COMPONENT_SMI)
-		return pd->smi;
-	else
-		return pd->infracfg;
-}
-
 static struct regmap *scpsys_bus_protect_get_sta_regmap(struct scpsys_domain *pd,
 							const struct scpsys_bus_prot_data *bpd)
 {
 	if (bpd->flags & BUS_PROT_STA_COMPONENT_INFRA_NAO)
 		return pd->infracfg_nao;
 	else
-		return scpsys_bus_protect_get_regmap(pd, bpd);
+		return pd->infracfg;
 }
 
 static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
-				    const struct scpsys_bus_prot_data *bpd)
+				    const struct scpsys_bus_prot_data *bpd,
+					struct regmap *sta_regmap, struct regmap *regmap)
 {
-	struct regmap *sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
-	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
 	u32 sta_mask = bpd->bus_prot_sta_mask;
 	u32 expected_ack;
 	u32 val;
@@ -165,10 +156,9 @@ static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
 }
 
 static int scpsys_bus_protect_set(struct scpsys_domain *pd,
-				  const struct scpsys_bus_prot_data *bpd)
+				  const struct scpsys_bus_prot_data *bpd,
+				  struct regmap *sta_regmap, struct regmap *regmap)
 {
-	struct regmap *sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
-	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
 	u32 sta_mask = bpd->bus_prot_sta_mask;
 	u32 val;
 
@@ -182,19 +172,32 @@ static int scpsys_bus_protect_set(struct scpsys_domain *pd,
 					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
-static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
+static int _scpsys_clamp_bus_protection_enable(struct scpsys_domain *pd, bool is_smi)
 {
+	int smi_count = 0;
+
 	for (int i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
 		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
+		struct regmap *sta_regmap, *regmap;
+		bool is_smi = bpd->flags & BUS_PROT_COMPONENT_SMI;
 		int ret;
 
 		if (!bpd->bus_prot_set_clr_mask)
 			break;
 
+		if (is_smi) {
+			sta_regmap = pd->smi[smi_count];
+			regmap = pd->smi[smi_count];
+			smi_count++;
+		} else {
+			sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
+			regmap = pd->infracfg;
+		}
+
 		if (bpd->flags & BUS_PROT_INVERTED)
-			ret = scpsys_bus_protect_clear(pd, bpd);
+			ret = scpsys_bus_protect_clear(pd, bpd, sta_regmap, regmap);
 		else
-			ret = scpsys_bus_protect_set(pd, bpd);
+			ret = scpsys_bus_protect_set(pd, bpd, sta_regmap, regmap);
 		if (ret)
 			return ret;
 	}
@@ -202,19 +205,32 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 	return 0;
 }
 
-static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
+static int _scpsys_clamp_bus_protection_disable(struct scpsys_domain *pd, bool is_smi)
 {
+	int smi_count = pd->num_smi - 1;
+
 	for (int i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
 		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
+		struct regmap *sta_regmap, *regmap;
+		bool is_smi = bpd->flags & BUS_PROT_COMPONENT_SMI;
 		int ret;
 
 		if (!bpd->bus_prot_set_clr_mask)
 			continue;
 
+		if (is_smi) {
+			sta_regmap = pd->smi[smi_count];
+			regmap = pd->smi[smi_count];
+			smi_count--;
+		} else {
+			sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
+			regmap = pd->infracfg;
+		}
+
 		if (bpd->flags & BUS_PROT_INVERTED)
-			ret = scpsys_bus_protect_set(pd, bpd);
+			ret = scpsys_bus_protect_set(pd, bpd, sta_regmap, regmap);
 		else
-			ret = scpsys_bus_protect_clear(pd, bpd);
+			ret = scpsys_bus_protect_clear(pd, bpd, sta_regmap, regmap);
 		if (ret)
 			return ret;
 	}
@@ -222,6 +238,50 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 	return 0;
 }
 
+static int scpsys_clamp_protection(struct scpsys_domain *pd)
+{
+	int ret;
+
+	ret = _scpsys_clamp_bus_protection_enable(pd, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int scpsys_clamp_protection_disable(struct scpsys_domain *pd)
+{
+	int ret;
+
+	ret = _scpsys_clamp_bus_protection_disable(pd, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
+{
+	int ret;
+
+	ret = _scpsys_clamp_bus_protection_enable(pd, false);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
+{
+	int ret;
+
+	ret = _scpsys_clamp_bus_protection_disable(pd, false);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int scpsys_regulator_enable(struct regulator *supply)
 {
 	return supply ? regulator_enable(supply) : 0;
@@ -272,6 +332,12 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	bool tmp;
 	int ret;
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_CLAMP_PROTECTION)) {
+		ret = scpsys_clamp_protection(pd);
+		if (ret)
+			return ret;
+	}
+
 	ret = scpsys_regulator_enable(pd->supply);
 	if (ret)
 		return ret;
@@ -318,6 +384,12 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		goto err_disable_subsys_clks;
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_CLAMP_PROTECTION)) {
+		ret = scpsys_clamp_protection_disable(pd);
+		if (ret)
+			return ret;
+	}
+
 	ret = scpsys_bus_protect_disable(pd);
 	if (ret < 0)
 		goto err_disable_sram;
@@ -353,6 +425,12 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	bool tmp;
 	int ret;
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_CLAMP_PROTECTION)) {
+		ret = scpsys_clamp_protection(pd);
+		if (ret)
+			return ret;
+	}
+
 	ret = scpsys_bus_protect_enable(pd);
 	if (ret < 0)
 		return ret;
@@ -450,12 +528,23 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	if (IS_ERR(pd->infracfg))
 		return ERR_CAST(pd->infracfg);
 
-	smi_node = of_parse_phandle(node, "mediatek,smi", 0);
-	if (smi_node) {
-		pd->smi = device_node_to_regmap(smi_node);
-		of_node_put(smi_node);
-		if (IS_ERR(pd->smi))
-			return ERR_CAST(pd->smi);
+	pd->num_smi = of_count_phandle_with_args(node, "mediatek,smi", NULL);
+	if (pd->num_smi > 0) {
+		pd->smi = devm_kcalloc(scpsys->dev, pd->num_smi, sizeof(*pd->smi), GFP_KERNEL);
+		if (!pd->smi)
+			return ERR_PTR(-ENOMEM);
+
+		for (i = 0; i < pd->num_smi; i++) {
+			smi_node = of_parse_phandle(node, "mediatek,smi", i);
+			if (!smi_node)
+				return ERR_PTR(-EINVAL);
+
+			pd->smi[i] = device_node_to_regmap(smi_node);
+			if (IS_ERR(pd->smi[i]))
+				return ERR_CAST(pd->smi[i]);
+		}
+	} else {
+		pd->num_smi = 0;
 	}
 
 	pd->num_larb = of_count_phandle_with_args(node, "mediatek,larb", NULL);
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index 31c2a1bb500f..e0eb7214719e 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -13,6 +13,7 @@
 #define MTK_SCPD_EXT_BUCK_ISO		BIT(6)
 #define MTK_SCPD_HAS_INFRA_NAO		BIT(7)
 #define MTK_SCPD_STRICT_BUS_PROTECTION	BIT(8)
+#define MTK_SCPD_CLAMP_PROTECTION	BIT(9)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
-- 
2.18.0


