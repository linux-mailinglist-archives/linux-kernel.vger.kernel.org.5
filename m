Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C3C79A4C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjIKHnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjIKHnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:43:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D12CCD;
        Mon, 11 Sep 2023 00:42:51 -0700 (PDT)
X-UUID: cc8612a2507611eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bqOAJL2L5ry7d5iqYT8CMfxaIDQc6oaLYP0JacyncDM=;
        b=tjDdYD3bRVXqvRjiQ13sDs9E5uuxyTthcPbzLZ3WxVw39/sww158T6ZWMaEMsplUJbZWoez3DiQwHlcnmHPbZT8McNygHb/blqgAnDJ5jir9H8pV75kQ9cqVu3A9MTKeZtBEvJ24+pWP0O9sZn060pIa8BZYSp60rdIyjfyM+mY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:4131d153-0363-4d41-b502-86d4c460b250,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:0ad78a4,CLOUDID:ca528def-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cc8612a2507611eea33bb35ae8d461a2-20230911
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1923003083; Mon, 11 Sep 2023 15:42:46 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 15:42:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 15:42:45 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "CK Hu" <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [RESEND PATCH v6 09/20] soc: mediatek: Support reset bit mapping in mmsys driver
Date:   Mon, 11 Sep 2023 15:42:22 +0800
Message-ID: <20230911074233.31556-10-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230911074233.31556-1-shawn.sung@mediatek.com>
References: <20230911074233.31556-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.363700-8.000000
X-TMASE-MatchedRID: 6IKkQlwkGxfhsdkaHFW0p25IHkZABHAU0nXvwjW2mSXb6Y+fnTZUL+jk
        huBL0aGZ9SK5q0H2UamK0Joj0npda6m/G7eYsFM7wVaayvK71l/pJe7BSAYfSFsoEE3nOobwSI7
        v7A0N15jT01A2vEikVgG2ORx9EyapQylVlmxnJkaQOktEo73GFKIf1lfNT7Zi0pEcoXqJQB0G1W
        3alEv3RuLzNWBegCW2wgn7iDBesS15zdAzex5xZj9r4WNkRLyxP+RoM9XW59hTS8P4x4CF66R/v
        Avxhb30t/6JS9H4YL2UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.363700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 3637EF1BB1672C280C65598578CE07B1A2B28AC846130E95A9486961C0C3E6572000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Reset ID must starts from 0 and be consecutive, but
  the reset bits in our hardware design is not continuous,
  some bits are left unused, we need a map to solve the problem
- Use old style 1-to-1 mapping if .rst_tb is not defined

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/soc/mediatek/mtk-mmsys.c | 9 +++++++++
 drivers/soc/mediatek/mtk-mmsys.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 84b2d8187011..6fc59f85f4fa 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -310,6 +310,15 @@ static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned l
 	u32 offset;
 	u32 reg;

+	if (mmsys->data->rst_tb) {
+		if (id >= mmsys->data->num_resets) {
+			dev_err(rcdev->dev, "Invalid reset ID: %lu (>=%u)\n",
+				id, mmsys->data->num_resets);
+			return -EINVAL;
+		}
+		id = mmsys->data->rst_tb[id];
+	}
+
 	offset = (id / MMSYS_SW_RESET_PER_REG) * sizeof(u32);
 	id = id % MMSYS_SW_RESET_PER_REG;
 	reg = mmsys->data->sw0_rst_offset + offset;
diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
index 964b5449d672..dfbb742eaa11 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -78,6 +78,8 @@
 #define DSI_SEL_IN_RDMA				0x1
 #define DSI_SEL_IN_MASK				0x1

+#define MMSYS_RST_NR(bank, bit) (((bank) * 32) + (bit))
+
 struct mtk_mmsys_routes {
 	u32 from_comp;
 	u32 to_comp;
@@ -119,6 +121,7 @@ struct mtk_mmsys_driver_data {
 	const struct mtk_mmsys_routes *routes;
 	const unsigned int num_routes;
 	const u16 sw0_rst_offset;
+	const u8 *rst_tb;
 	const u32 num_resets;
 	const bool is_vppsys;
 	const u8 vsync_len;
--
2.18.0

