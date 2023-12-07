Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C6E8080D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377561AbjLGGfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGGfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:35:44 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF9B10C0;
        Wed,  6 Dec 2023 22:35:48 -0800 (PST)
X-UUID: d8ab53b094ca11eeba30773df0976c77-20231207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FXuG78bG9PDHbQlfYUkB8OFI6hQl9Lucg7hG903GvlQ=;
        b=cTGs3fi3WvyH1SSk7+SkCNXPNrFsJ9AJxbK10wcRkkr0pgaGRKYmNyKcOfjcNzO9EbHiTfyXnLh/5V4o79ovj+McHYknYdaBoZ/yhCxFVAaHON5PMQlIzlfw09Oi8NdzhaQ0XAbV89/nFeueZKF73Boq4xjNrupfQ2nbddr8RaA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:afb14c3a-5929-4d80-a1b5-824ae4260a73,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:5a6163fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d8ab53b094ca11eeba30773df0976c77-20231207
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1726473605; Thu, 07 Dec 2023 14:35:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Dec 2023 14:35:41 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Dec 2023 14:35:41 +0800
From:   Axe Yang <axe.yang@mediatek.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Wenbin Mei" <wenbin.mei@mediatek.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Axe Yang <axe.yang@mediatek.com>
Subject: [PATCH v4 2/2] mmc: mediatek: extend number of tuning steps
Date:   Thu, 7 Dec 2023 14:35:35 +0800
Message-ID: <20231207063535.29546-3-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207063535.29546-1-axe.yang@mediatek.com>
References: <20231207063535.29546-1-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.836000-8.000000
X-TMASE-MatchedRID: 9N24rvusElB80yFIYo0rRuGonqgs5zxBRjqOkKPmpa4UlWIKEoGBmc+/
        a0S0vHt4WZy+62a7b19rOAp0kI1DP9H/WqWljGhSSDkh6bW+bcckMBkEieOjZi8ggN9+4AxXDk6
        /c+jKAHFIl95haju6JaPNT9pmq5xZMZPj25j8CtwD2WXLXdz+ASlayzmQ9QV0uGtlO4mJjG4p5V
        paXKVZ0ru/rdp1USGE53BNgT5ozCDJXsxRGJ73eQUNJ/OP1hfdaM4aPCtYABoT7lsB95pa6qUw+
        JzU1GXBynCQnr2+AG9YW77ecurO05Coy9iDotiwDYcOzBwKciNfohHCqSnabhIp4u9jJZb6JETW
        X/pKcs5wbQxGhptmol5bBcpAanckN8PEWMb3wthH+PTjR9EWkuWNJG9Iamrc4pinC0b7AdUnJC0
        FLrRqdyQzZXePPedHumMCMwce1mUfE8yM4pjsD23U7j2vVURrxEHRux+uk8h+ICquNi0WJCRACz
        TS4YvgXWwxxVcSCxCkqTSB73PKtxbpA9LwxbPUftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.836000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F467CA4E97EA1C01F0B5CCE6592F5B85F7B06BFBF609AE761AFC0382009FB24A2000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, during the MSDC calibration process, a full clock cycle
actually not be covered, which in some cases didn't yield the best
results and could cause CRC errors. This problem is particularly
evident when MSDC is used as an SDIO host. In fact, MSDC support
tuning up to a maximum of 64 steps, but by default, the step number
is 32. By increase the tuning step, we are more likely to cover more
parts of a clock cycle, and get better calibration result.

To illustrate, when tuning 32 steps, if the obtained window has a hole
near the middle, like this: 0xffc07ff (hex), then the selected delay
will be the 6 (counting from right to left).

(32 <- 1)
1111 1111 1100 0000 0000 0111 11(1)1 1111

However, if we tune 64 steps, the window obtained may look like this:
0xfffffffffffc07ff. The final selected delay will be 44, which is
safer as it is further away from the hole:

(64 <- 1)
1111 ... (1)111 1111 1111 1111 1111 1100 0000 0000 0111 1111 1111

In this case, delay 6 selected through 32 steps tuning is obviously
not optimal, and this delay is closer to the hole, using it would
easily cause CRC problems.

As per mesaurements taken on mediatek SoC platform, the tuning phase
will take:
	eMMC	- 32 steps: ~3ms
		- 64 steps: ~6ms
	SDIO	- 32 steps: ~4ms
		- 64 steos: ~7ms
Tuning more steps won't prolong boot times by any meaningful amount
of time, so for SD/SDIO the default tuning steps will be adjust to
64. But for eMMC, it is still preferred to use 32 steps tuning as
otherwise there would be performance lose when accessing the RPMB
partition(requiring retuning each time).

You can configure property "mediatek,tuning-step" in MSDC dts node
to adjust the step number.

Signed-off-by: Axe Yang <axe.yang@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 158 ++++++++++++++++++++++++++------------
 1 file changed, 110 insertions(+), 48 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 97f7c3d4be6e..f315db48ac02 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -252,12 +252,16 @@
 
 #define MSDC_PAD_TUNE_DATWRDLY	  GENMASK(4, 0)		/* RW */
 #define MSDC_PAD_TUNE_DATRRDLY	  GENMASK(12, 8)	/* RW */
+#define MSDC_PAD_TUNE_DATRRDLY2	  GENMASK(12, 8)	/* RW */
 #define MSDC_PAD_TUNE_CMDRDLY	  GENMASK(20, 16)	/* RW */
+#define MSDC_PAD_TUNE_CMDRDLY2	  GENMASK(20, 16)	/* RW */
 #define MSDC_PAD_TUNE_CMDRRDLY	  GENMASK(26, 22)	/* RW */
 #define MSDC_PAD_TUNE_CLKTDLY	  GENMASK(31, 27)	/* RW */
 #define MSDC_PAD_TUNE_RXDLYSEL	  BIT(15)   /* RW */
 #define MSDC_PAD_TUNE_RD_SEL	  BIT(13)   /* RW */
 #define MSDC_PAD_TUNE_CMD_SEL	  BIT(21)   /* RW */
+#define MSDC_PAD_TUNE_RD2_SEL	  BIT(13)   /* RW */
+#define MSDC_PAD_TUNE_CMD2_SEL	  BIT(21)   /* RW */
 
 #define PAD_DS_TUNE_DLY_SEL       BIT(0)	  /* RW */
 #define PAD_DS_TUNE_DLY1	  GENMASK(6, 2)   /* RW */
@@ -325,7 +329,9 @@
 
 #define DEFAULT_DEBOUNCE	(8)	/* 8 cycles CD debounce */
 
-#define PAD_DELAY_MAX	32 /* PAD delay cells */
+#define TUNING_REG2_FIXED_OFFEST	4
+#define PAD_DELAY_HALF	32 /* PAD delay cells */
+#define PAD_DELAY_FULL	64
 /*--------------------------------------------------------------------------*/
 /* Descriptor Structure                                                     */
 /*--------------------------------------------------------------------------*/
@@ -461,6 +467,7 @@ struct msdc_host {
 	u32 hs400_ds_dly3;
 	u32 hs200_cmd_int_delay; /* cmd internal delay for HS200/SDR104 */
 	u32 hs400_cmd_int_delay; /* cmd internal delay for HS400 */
+	u32 tuning_step;
 	bool hs400_cmd_resp_sel_rising;
 				 /* cmd response sample selection for HS400 */
 	bool hs400_mode;	/* current eMMC will run at hs400 mode */
@@ -1615,7 +1622,7 @@ static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32 intsts)
 	}
 
 	if (cmd_err || dat_err) {
-		dev_err(host->dev, "cmd_err = %d, dat_err =%d, intsts = 0x%x",
+		dev_err(host->dev, "cmd_err = %d, dat_err = %d, intsts = 0x%x",
 			cmd_err, dat_err, intsts);
 	}
 
@@ -1780,10 +1787,20 @@ static void msdc_init_hw(struct msdc_host *host)
 				     DATA_K_VALUE_SEL);
 			sdr_set_bits(host->top_base + EMMC_TOP_CMD,
 				     PAD_CMD_RD_RXDLY_SEL);
+			if (host->tuning_step > PAD_DELAY_HALF) {
+				sdr_set_bits(host->top_base + EMMC_TOP_CONTROL,
+					     PAD_DAT_RD_RXDLY2_SEL);
+				sdr_set_bits(host->top_base + EMMC_TOP_CMD,
+					     PAD_CMD_RD_RXDLY2_SEL);
+			}
 		} else {
 			sdr_set_bits(host->base + tune_reg,
 				     MSDC_PAD_TUNE_RD_SEL |
 				     MSDC_PAD_TUNE_CMD_SEL);
+			if (host->tuning_step > PAD_DELAY_HALF)
+				sdr_set_bits(host->base + tune_reg + TUNING_REG2_FIXED_OFFEST,
+					     MSDC_PAD_TUNE_RD2_SEL |
+					     MSDC_PAD_TUNE_CMD2_SEL);
 		}
 	} else {
 		/* choose clock tune */
@@ -1925,24 +1942,24 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		msdc_set_mclk(host, ios->timing, ios->clock);
 }
 
-static u32 test_delay_bit(u32 delay, u32 bit)
+static u64 test_delay_bit(u64 delay, u32 bit)
 {
-	bit %= PAD_DELAY_MAX;
-	return delay & BIT(bit);
+	bit %= PAD_DELAY_FULL;
+	return delay & BIT_ULL(bit);
 }
 
-static int get_delay_len(u32 delay, u32 start_bit)
+static int get_delay_len(u64 delay, u32 start_bit)
 {
 	int i;
 
-	for (i = 0; i < (PAD_DELAY_MAX - start_bit); i++) {
+	for (i = 0; i < (PAD_DELAY_FULL - start_bit); i++) {
 		if (test_delay_bit(delay, start_bit + i) == 0)
 			return i;
 	}
-	return PAD_DELAY_MAX - start_bit;
+	return PAD_DELAY_FULL - start_bit;
 }
 
-static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
+static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u64 delay)
 {
 	int start = 0, len = 0;
 	int start_final = 0, len_final = 0;
@@ -1950,28 +1967,28 @@ static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
 	struct msdc_delay_phase delay_phase = { 0, };
 
 	if (delay == 0) {
-		dev_err(host->dev, "phase error: [map:%x]\n", delay);
+		dev_err(host->dev, "phase error: [map:%016llx]\n", delay);
 		delay_phase.final_phase = final_phase;
 		return delay_phase;
 	}
 
-	while (start < PAD_DELAY_MAX) {
+	while (start < PAD_DELAY_FULL) {
 		len = get_delay_len(delay, start);
 		if (len_final < len) {
 			start_final = start;
 			len_final = len;
 		}
 		start += len ? len : 1;
-		if (len >= 12 && start_final < 4)
+		if (!upper_32_bits(delay) && len >= 12 && start_final < 4)
 			break;
 	}
 
 	/* The rule is that to find the smallest delay cell */
 	if (start_final == 0)
-		final_phase = (start_final + len_final / 3) % PAD_DELAY_MAX;
+		final_phase = (start_final + len_final / 3) % PAD_DELAY_FULL;
 	else
-		final_phase = (start_final + len_final / 2) % PAD_DELAY_MAX;
-	dev_dbg(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
+		final_phase = (start_final + len_final / 2) % PAD_DELAY_FULL;
+	dev_dbg(host->dev, "phase: [map:%016llx] [maxlen:%d] [final:%d]\n",
 		delay, len_final, final_phase);
 
 	delay_phase.maxlen = len_final;
@@ -1984,30 +2001,64 @@ static inline void msdc_set_cmd_delay(struct msdc_host *host, u32 value)
 {
 	u32 tune_reg = host->dev_comp->pad_tune_reg;
 
-	if (host->top_base)
-		sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY,
-			      value);
-	else
-		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
-			      value);
+	if (host->top_base) {
+		if (value < PAD_DELAY_HALF) {
+			sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY, value);
+			sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY2, 0);
+		} else {
+			sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY,
+				      PAD_DELAY_HALF - 1);
+			sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY2,
+				      value - PAD_DELAY_HALF);
+		}
+	} else {
+		if (value < PAD_DELAY_HALF) {
+			sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY, value);
+			sdr_set_field(host->base + tune_reg + TUNING_REG2_FIXED_OFFEST,
+				      MSDC_PAD_TUNE_CMDRDLY2, 0);
+		} else {
+			sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
+				      PAD_DELAY_HALF - 1);
+			sdr_set_field(host->base + tune_reg + TUNING_REG2_FIXED_OFFEST,
+				      MSDC_PAD_TUNE_CMDRDLY2, value - PAD_DELAY_HALF);
+		}
+	}
 }
 
 static inline void msdc_set_data_delay(struct msdc_host *host, u32 value)
 {
 	u32 tune_reg = host->dev_comp->pad_tune_reg;
 
-	if (host->top_base)
-		sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
-			      PAD_DAT_RD_RXDLY, value);
-	else
-		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_DATRRDLY,
-			      value);
+	if (host->top_base) {
+		if (value < PAD_DELAY_HALF) {
+			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
+				      PAD_DAT_RD_RXDLY, value);
+			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
+				      PAD_DAT_RD_RXDLY2, 0);
+		} else {
+			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
+				      PAD_DAT_RD_RXDLY, PAD_DELAY_HALF - 1);
+			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
+				      PAD_DAT_RD_RXDLY2, value - PAD_DELAY_HALF);
+		}
+	} else {
+		if (value < PAD_DELAY_HALF) {
+			sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_DATRRDLY, value);
+			sdr_set_field(host->base + tune_reg + TUNING_REG2_FIXED_OFFEST,
+				      MSDC_PAD_TUNE_DATRRDLY2, 0);
+		} else {
+			sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_DATRRDLY,
+				      PAD_DELAY_HALF - 1);
+			sdr_set_field(host->base + tune_reg + TUNING_REG2_FIXED_OFFEST,
+				      MSDC_PAD_TUNE_DATRRDLY2, value - PAD_DELAY_HALF);
+		}
+	}
 }
 
 static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
-	u32 rise_delay = 0, fall_delay = 0;
+	u64 rise_delay = 0, fall_delay = 0;
 	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
 	struct msdc_delay_phase internal_delay_phase;
 	u8 final_delay, final_maxlen;
@@ -2023,7 +2074,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 			      host->hs200_cmd_int_delay);
 
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
+	for (i = 0; i < host->tuning_step; i++) {
 		msdc_set_cmd_delay(host, i);
 		/*
 		 * Using the same parameters, it may sometimes pass the test,
@@ -2033,9 +2084,9 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 		for (j = 0; j < 3; j++) {
 			mmc_send_tuning(mmc, opcode, &cmd_err);
 			if (!cmd_err) {
-				rise_delay |= BIT(i);
+				rise_delay |= BIT_ULL(i);
 			} else {
-				rise_delay &= ~BIT(i);
+				rise_delay &= ~BIT_ULL(i);
 				break;
 			}
 		}
@@ -2047,7 +2098,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 		goto skip_fall;
 
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-	for (i = 0; i < PAD_DELAY_MAX; i++) {
+	for (i = 0; i < host->tuning_step; i++) {
 		msdc_set_cmd_delay(host, i);
 		/*
 		 * Using the same parameters, it may sometimes pass the test,
@@ -2057,9 +2108,9 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 		for (j = 0; j < 3; j++) {
 			mmc_send_tuning(mmc, opcode, &cmd_err);
 			if (!cmd_err) {
-				fall_delay |= BIT(i);
+				fall_delay |= BIT_ULL(i);
 			} else {
-				fall_delay &= ~BIT(i);
+				fall_delay &= ~BIT_ULL(i);
 				break;
 			}
 		}
@@ -2082,12 +2133,12 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 	if (host->dev_comp->async_fifo || host->hs200_cmd_int_delay)
 		goto skip_internal;
 
-	for (i = 0; i < PAD_DELAY_MAX; i++) {
+	for (i = 0; i < host->tuning_step; i++) {
 		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_CMDRRDLY, i);
 		mmc_send_tuning(mmc, opcode, &cmd_err);
 		if (!cmd_err)
-			internal_delay |= BIT(i);
+			internal_delay |= BIT_ULL(i);
 	}
 	dev_dbg(host->dev, "Final internal delay: 0x%x\n", internal_delay);
 	internal_delay_phase = get_best_delay(host, internal_delay);
@@ -2121,7 +2172,8 @@ static int hs400_tune_response(struct mmc_host *mmc, u32 opcode)
 		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
 	else
 		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
+
+	for (i = 0; i < PAD_DELAY_HALF; i++) {
 		sdr_set_field(host->base + PAD_CMD_TUNE,
 			      PAD_CMD_TUNE_RX_DLY3, i);
 		/*
@@ -2151,7 +2203,7 @@ static int hs400_tune_response(struct mmc_host *mmc, u32 opcode)
 static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
-	u32 rise_delay = 0, fall_delay = 0;
+	u64 rise_delay = 0, fall_delay = 0;
 	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
 	u8 final_delay, final_maxlen;
 	int i, ret;
@@ -2160,11 +2212,11 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 		      host->latch_ck);
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
-	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
+	for (i = 0; i < host->tuning_step; i++) {
 		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
-			rise_delay |= BIT(i);
+			rise_delay |= BIT_ULL(i);
 	}
 	final_rise_delay = get_best_delay(host, rise_delay);
 	/* if rising edge has enough margin, then do not scan falling edge */
@@ -2174,11 +2226,11 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
-	for (i = 0; i < PAD_DELAY_MAX; i++) {
+	for (i = 0; i < host->tuning_step; i++) {
 		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
-			fall_delay |= BIT(i);
+			fall_delay |= BIT_ULL(i);
 	}
 	final_fall_delay = get_best_delay(host, fall_delay);
 
@@ -2206,7 +2258,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
-	u32 rise_delay = 0, fall_delay = 0;
+	u64 rise_delay = 0, fall_delay = 0;
 	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
 	u8 final_delay, final_maxlen;
 	int i, ret;
@@ -2217,12 +2269,12 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
 	sdr_clr_bits(host->base + MSDC_IOCON,
 		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
-	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
+	for (i = 0; i < host->tuning_step; i++) {
 		msdc_set_cmd_delay(host, i);
 		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
-			rise_delay |= BIT(i);
+			rise_delay |= BIT_ULL(i);
 	}
 	final_rise_delay = get_best_delay(host, rise_delay);
 	/* if rising edge has enough margin, then do not scan falling edge */
@@ -2233,12 +2285,12 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
 	sdr_set_bits(host->base + MSDC_IOCON,
 		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
-	for (i = 0; i < PAD_DELAY_MAX; i++) {
+	for (i = 0; i < host->tuning_step; i++) {
 		msdc_set_cmd_delay(host, i);
 		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
-			fall_delay |= BIT(i);
+			fall_delay |= BIT_ULL(i);
 	}
 	final_fall_delay = get_best_delay(host, fall_delay);
 
@@ -2346,7 +2398,7 @@ static int msdc_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card
 	}
 
 	host->hs400_tuning = true;
-	for (i = 0; i < PAD_DELAY_MAX; i++) {
+	for (i = 0; i < PAD_DELAY_HALF; i++) {
 		if (host->top_base)
 			sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
 				      PAD_DS_DLY1, i);
@@ -2580,6 +2632,8 @@ static const struct cqhci_host_ops msdc_cmdq_ops = {
 static void msdc_of_property_parse(struct platform_device *pdev,
 				   struct msdc_host *host)
 {
+	struct mmc_host *mmc = mmc_from_priv(host);
+
 	of_property_read_u32(pdev->dev.of_node, "mediatek,latch-ck",
 			     &host->latch_ck);
 
@@ -2601,6 +2655,14 @@ static void msdc_of_property_parse(struct platform_device *pdev,
 	else
 		host->hs400_cmd_resp_sel_rising = false;
 
+	if (of_property_read_u32(pdev->dev.of_node, "mediatek,tuning-step",
+				 &host->tuning_step)) {
+		if (mmc->caps2 & MMC_CAP2_NO_MMC)
+			host->tuning_step = PAD_DELAY_FULL;
+		else
+			host->tuning_step = PAD_DELAY_HALF;
+	}
+
 	if (of_property_read_bool(pdev->dev.of_node,
 				  "supports-cqe"))
 		host->cqhci = true;
-- 
2.18.0

