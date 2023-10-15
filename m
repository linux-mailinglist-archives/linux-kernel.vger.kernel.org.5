Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CAA7C984B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 09:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJOHoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 03:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjJOHo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 03:44:29 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C59FA3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 00:44:26 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9ac9573274so3576080276.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697355865; x=1697960665; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0wqUm86cDZ6XuiugN8Qh4XmEQLH60ID9xk9j+/hyJE=;
        b=cY3UHeGR9VWHN01x/X12iH5R2KLubcsXpTExoS0T/qOJ2OhKBVbKg9J/R/mJJJF05R
         wEN+wBRs4I+uHnHBYwthxs9HX/cdMlNoe65mvroodcA6GIrXzgLPRRInqxdr1K+jjnM/
         zyPeqDJT/76x1PLTY1UNcGH41d5WFbfHCb/4BmHwwjF0bSWZlwNWXp1QQvqYTQSXCD54
         6Uh3aXUUbGzUo3RWPBweWtldTOQm4SeGL4qlHG6imG2e3qIYLUkk7VA/UGALWT1B9QUh
         o0O8w3Ql+ukpjdGmlCZWI5d476AT+o0SwvbMvEwa0OKd/N2IJnATpHU5IpDgPE5ZgJ6D
         4jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697355865; x=1697960665;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0wqUm86cDZ6XuiugN8Qh4XmEQLH60ID9xk9j+/hyJE=;
        b=TMYX14AttD3Y7ftTi2p0d6eDYH+PyRSgujl210pyUbgWFSTmWJ2adtVCdKEMtTnrAH
         hBs9lVCZY54OL9QmVt9vK+t0B+SYzAiwTNlRZ7SQQC7yMCmj/N5UwXocfkA36MA43GDF
         D5kxh3oLChsBRpu2qNc7NBhT9tSBOA2ztlweubW+miMPZCfw6JgYCEP11mBvduDs40Dg
         QFI+KerF7GcPQmBaLoL+MelpXN79YV8EzPnRqLlbqGWdgjxdH3unsBppiIS8jyutpicc
         lXrZ3UIRmbwMIC0CwnG5DuD8aQk/uDfXpNKo2L1+385kufOdjBve8fSWmx5rH5C1DT+6
         GTmg==
X-Gm-Message-State: AOJu0YwmN1u4jruJBeUxXpvIyH7A9x70gS3g+1xw58kXgrNGI45wzRZR
        jFHmuB0ck5x4ZAGeRtUEQcB9aIUBaUjbg5EXFSw=
X-Google-Smtp-Source: AGHT+IGUpnu7+FkN4+R9jYBUPKfDAeCGSKcw9pE2xxCsHas6sTfNRM1E+dDvWE5Kzl9ArkUizEeeEQ==
X-Received: by 2002:a25:c085:0:b0:c4b:ada8:8b86 with SMTP id c127-20020a25c085000000b00c4bada88b86mr24951799ybf.64.1697355865422;
        Sun, 15 Oct 2023 00:44:25 -0700 (PDT)
Received: from gilbert-PC ([105.112.18.68])
        by smtp.gmail.com with ESMTPSA id 20-20020a250214000000b00d7f06aa25c5sm1767555ybc.58.2023.10.15.00.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 00:44:24 -0700 (PDT)
Date:   Sun, 15 Oct 2023 08:44:18 +0100
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: Align descendant arguments
Message-ID: <ZSuYUmX5P5M0Ok/I@gilbert-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux kernel coding style.

"...A very commonly used style is to align descendants to a function
open parenthesis" - (Excerpted from Linux kernel coding style (#2))

Reported by checkpatch:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/rtl8192u/r8180_93cx6.c     |  4 ++--
 drivers/staging/rtl8192u/r8190_rtl8256.c   | 16 +++++++--------
 drivers/staging/rtl8192u/r8192U_core.c     | 20 +++++++++---------
 drivers/staging/rtl8192u/r8192U_dm.c       | 24 +++++++++++-----------
 drivers/staging/rtl8192u/r819xU_firmware.c |  4 ++--
 drivers/staging/rtl8192u/r819xU_phy.c      |  2 +-
 6 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8180_93cx6.c b/drivers/staging/rtl8192u/r8180_93cx6.c
index 2527cea60e3e..1453a0307eb4 100644
--- a/drivers/staging/rtl8192u/r8180_93cx6.c
+++ b/drivers/staging/rtl8192u/r8180_93cx6.c
@@ -114,7 +114,7 @@ int eprom_read(struct net_device *dev, u32 addr)
 	ret = 0;
 	/* enable EPROM programming */
 	write_nic_byte_E(dev, EPROM_CMD,
-		       (EPROM_CMD_PROGRAM << EPROM_CMD_OPERATING_MODE_SHIFT));
+			 (EPROM_CMD_PROGRAM << EPROM_CMD_OPERATING_MODE_SHIFT));
 	force_pci_posting(dev);
 	udelay(EPROM_DELAY);
 
@@ -165,6 +165,6 @@ int eprom_read(struct net_device *dev, u32 addr)
 
 	/* disable EPROM programming */
 	write_nic_byte_E(dev, EPROM_CMD,
-		       (EPROM_CMD_NORMAL << EPROM_CMD_OPERATING_MODE_SHIFT));
+			 (EPROM_CMD_NORMAL << EPROM_CMD_OPERATING_MODE_SHIFT));
 	return ret;
 }
diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
index 54747fda552f..a81e88894e01 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -46,17 +46,17 @@ void phy_set_rf8256_bandwidth(struct net_device *dev, enum ht_channel_width Band
 				    priv->card_8192_version == VERSION_819XU_B) {
 					/* 8256 D-cut, E-cut, xiong: consider it later! */
 					rtl8192_phy_SetRFReg(dev,
-						(enum rf90_radio_path_e)eRFPath,
-						0x0b, bMask12Bits, 0x100); /* phy para:1ba */
+							     (enum rf90_radio_path_e)eRFPath,
+							     0x0b, bMask12Bits, 0x100); /* phy para:1ba */
 					rtl8192_phy_SetRFReg(dev,
-						(enum rf90_radio_path_e)eRFPath,
-						0x2c, bMask12Bits, 0x3d7);
+							     (enum rf90_radio_path_e)eRFPath,
+							     0x2c, bMask12Bits, 0x3d7);
 					rtl8192_phy_SetRFReg(dev,
-						(enum rf90_radio_path_e)eRFPath,
-						0x0e, bMask12Bits, 0x021);
+							     (enum rf90_radio_path_e)eRFPath,
+							     0x0e, bMask12Bits, 0x021);
 					rtl8192_phy_SetRFReg(dev,
-						(enum rf90_radio_path_e)eRFPath,
-						0x14, bMask12Bits, 0x5ab);
+							     (enum rf90_radio_path_e)eRFPath,
+							     0x14, bMask12Bits, 0x5ab);
 				} else {
 					RT_TRACE(COMP_ERR, "%s(): unknown hardware version\n", __func__);
 					}
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 0a60ef20107c..2985c4f05bc8 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2236,7 +2236,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 			*((u16 *)(&priv->EEPROMTxPowerLevelCCK_V1[1])) = tmpValue;
 			if (bLoad_From_EEPOM)
 				tmpValue = eprom_read(dev,
-					EEPROM_TX_PW_INDEX_OFDM_24G_V1 >> 1);
+						      EEPROM_TX_PW_INDEX_OFDM_24G_V1 >> 1);
 			else
 				tmpValue = 0x1010;
 			*((u16 *)(&priv->EEPROMTxPowerLevelOFDM24G[0])) = tmpValue;
@@ -2536,16 +2536,16 @@ static bool rtl8192_adapter_start(struct net_device *dev)
 
 	/* Initialize Number of Reserved Pages in Firmware Queue */
 	write_nic_dword(dev, RQPN1,
-		NUM_OF_PAGE_IN_FW_QUEUE_BK << RSVD_FW_QUEUE_PAGE_BK_SHIFT |
-		NUM_OF_PAGE_IN_FW_QUEUE_BE << RSVD_FW_QUEUE_PAGE_BE_SHIFT |
-		NUM_OF_PAGE_IN_FW_QUEUE_VI << RSVD_FW_QUEUE_PAGE_VI_SHIFT |
-		NUM_OF_PAGE_IN_FW_QUEUE_VO << RSVD_FW_QUEUE_PAGE_VO_SHIFT);
+			NUM_OF_PAGE_IN_FW_QUEUE_BK << RSVD_FW_QUEUE_PAGE_BK_SHIFT |
+			NUM_OF_PAGE_IN_FW_QUEUE_BE << RSVD_FW_QUEUE_PAGE_BE_SHIFT |
+			NUM_OF_PAGE_IN_FW_QUEUE_VI << RSVD_FW_QUEUE_PAGE_VI_SHIFT |
+			NUM_OF_PAGE_IN_FW_QUEUE_VO << RSVD_FW_QUEUE_PAGE_VO_SHIFT);
 	write_nic_dword(dev, RQPN2,
-		NUM_OF_PAGE_IN_FW_QUEUE_MGNT << RSVD_FW_QUEUE_PAGE_MGNT_SHIFT |
-		NUM_OF_PAGE_IN_FW_QUEUE_CMD << RSVD_FW_QUEUE_PAGE_CMD_SHIFT);
+			NUM_OF_PAGE_IN_FW_QUEUE_MGNT << RSVD_FW_QUEUE_PAGE_MGNT_SHIFT |
+			NUM_OF_PAGE_IN_FW_QUEUE_CMD << RSVD_FW_QUEUE_PAGE_CMD_SHIFT);
 	write_nic_dword(dev, RQPN3,
-		APPLIED_RESERVED_QUEUE_IN_FW |
-		NUM_OF_PAGE_IN_FW_QUEUE_BCN << RSVD_FW_QUEUE_PAGE_BCN_SHIFT);
+			APPLIED_RESERVED_QUEUE_IN_FW |
+			NUM_OF_PAGE_IN_FW_QUEUE_BCN << RSVD_FW_QUEUE_PAGE_BCN_SHIFT);
 	write_nic_dword(dev, RATR0 + 4 * 7, (RATE_ALL_OFDM_AG | RATE_ALL_CCK));
 
 	/* Set AckTimeout */
@@ -3019,7 +3019,7 @@ static void rtl819x_ifsilentreset(struct net_device *dev)
 }
 
 static void rtl819x_update_rxcounts(struct r8192_priv *priv, u32 *TotalRxBcnNum,
-			     u32 *TotalRxDataNum)
+				    u32 *TotalRxDataNum)
 {
 	u16			SlotIndex;
 	u16			i;
diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index cbae852478ea..84c2ad89f02c 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -331,7 +331,7 @@ static void dm_check_rate_adaptive(struct net_device *dev)
 		if (pra->ping_rssi_enable) {
 			if (priv->undecorated_smoothed_pwdb < (long)(pra->ping_rssi_thresh_for_ra+5)) {
 				if ((priv->undecorated_smoothed_pwdb < (long)pra->ping_rssi_thresh_for_ra) ||
-					ping_rssi_state) {
+				    ping_rssi_state) {
 					pra->ratr_state = DM_RATR_STA_LOW;
 					targetRATR = pra->ping_rssi_ratr;
 					ping_rssi_state = 1;
@@ -612,7 +612,7 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 			if (tmpRegA == OFDMSwingTable[i]) {
 				priv->OFDM_index = (u8)i;
 				RT_TRACE(COMP_POWER_TRACKING, "Initial reg0x%x = 0x%x, OFDM_index=0x%x\n",
-					rOFDM0_XATxIQImbalance, tmpRegA, priv->OFDM_index);
+					 rOFDM0_XATxIQImbalance, tmpRegA, priv->OFDM_index);
 			}
 		}
 
@@ -622,7 +622,7 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 			if (TempCCk == (u32)CCKSwingTable_Ch1_Ch13[i][0]) {
 				priv->CCK_index = (u8) i;
 				RT_TRACE(COMP_POWER_TRACKING, "Initial reg0x%x = 0x%x, CCK_index=0x%x\n",
-					rCCK0_TxFilter1, TempCCk, priv->CCK_index);
+					 rCCK0_TxFilter1, TempCCk, priv->CCK_index);
 				break;
 			}
 		}
@@ -695,7 +695,7 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 		priv->OFDM_index = tmpOFDMindex;
 		rtl8192_setBBreg(dev, rOFDM0_XATxIQImbalance, bMaskDWord, OFDMSwingTable[priv->OFDM_index]);
 		RT_TRACE(COMP_POWER_TRACKING, "Update OFDMSwing[%d] = 0x%x\n",
-			priv->OFDM_index, OFDMSwingTable[priv->OFDM_index]);
+			 priv->OFDM_index, OFDMSwingTable[priv->OFDM_index]);
 	}
 	priv->txpower_count = 0;
 }
@@ -1352,7 +1352,7 @@ static void dm_CCKTxPowerAdjust_ThermalMeter(struct net_device *dev, bool  bInCH
 					(CCKSwingTable_Ch1_Ch13[priv->CCK_index][1]<<8);
 		rtl8192_setBBreg(dev, rCCK0_TxFilter1, bMaskHWord, TempVal);
 		RT_TRACE(COMP_POWER_TRACKING, "CCK not chnl 14, reg 0x%x = 0x%x\n",
-			rCCK0_TxFilter1, TempVal);
+			 rCCK0_TxFilter1, TempVal);
 		/* Write 0xa24 ~ 0xa27 */
 		TempVal =	CCKSwingTable_Ch1_Ch13[priv->CCK_index][2] +
 					(CCKSwingTable_Ch1_Ch13[priv->CCK_index][3]<<8) +
@@ -1360,14 +1360,14 @@ static void dm_CCKTxPowerAdjust_ThermalMeter(struct net_device *dev, bool  bInCH
 					(CCKSwingTable_Ch1_Ch13[priv->CCK_index][5]<<24);
 		rtl8192_setBBreg(dev, rCCK0_TxFilter2, bMaskDWord, TempVal);
 		RT_TRACE(COMP_POWER_TRACKING, "CCK not chnl 14, reg 0x%x = 0x%x\n",
-			rCCK0_TxFilter2, TempVal);
+			 rCCK0_TxFilter2, TempVal);
 		/* Write 0xa28  0xa29 */
 		TempVal =	CCKSwingTable_Ch1_Ch13[priv->CCK_index][6] +
 					(CCKSwingTable_Ch1_Ch13[priv->CCK_index][7]<<8);
 
 		rtl8192_setBBreg(dev, rCCK0_DebugPort, bMaskLWord, TempVal);
 		RT_TRACE(COMP_POWER_TRACKING, "CCK not chnl 14, reg 0x%x = 0x%x\n",
-			rCCK0_DebugPort, TempVal);
+			 rCCK0_DebugPort, TempVal);
 	} else {
 		/* Write 0xa22 0xa23 */
 		TempVal =	CCKSwingTable_Ch14[priv->CCK_index][0] +
@@ -1764,7 +1764,7 @@ static void dm_ctrl_initgain_byrssi_highpwr(
 
 	/*  For smooth, we can not change high power DIG state in the range. */
 	if ((priv->undecorated_smoothed_pwdb > dm_digtable.rssi_high_power_lowthresh) &&
-		(priv->undecorated_smoothed_pwdb < dm_digtable.rssi_high_power_highthresh))
+	    (priv->undecorated_smoothed_pwdb < dm_digtable.rssi_high_power_highthresh))
 		return;
 
 	/* 3. When RSSI >75% or <70%, it is a high power issue. We have to judge if
@@ -1790,7 +1790,7 @@ static void dm_ctrl_initgain_byrssi_highpwr(
 		dm_digtable.dig_highpwr_state = DM_STA_DIG_OFF;
 
 		if (priv->undecorated_smoothed_pwdb < dm_digtable.rssi_high_power_lowthresh &&
-			 priv->undecorated_smoothed_pwdb >= dm_digtable.rssi_high_thresh) {
+		    priv->undecorated_smoothed_pwdb >= dm_digtable.rssi_high_thresh) {
 			/*  3.2 Recover PD_TH for OFDM for normal power region. */
 			if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
 				write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
@@ -1881,7 +1881,7 @@ static void dm_pd_th(
 			else if (dm_digtable.rssi_val <= dm_digtable.rssi_low_thresh)
 				dm_digtable.curpd_thstate = DIG_PD_AT_LOW_POWER;
 			else if ((dm_digtable.rssi_val >= dm_digtable.rssi_high_thresh) &&
-					(dm_digtable.rssi_val < dm_digtable.rssi_high_power_lowthresh))
+				 (dm_digtable.rssi_val < dm_digtable.rssi_high_power_lowthresh))
 				dm_digtable.curpd_thstate = DIG_PD_AT_NORMAL_POWER;
 			else
 				dm_digtable.curpd_thstate = dm_digtable.prepd_thstate;
@@ -2620,7 +2620,7 @@ void dm_check_fsync(struct net_device *dev)
 	RT_TRACE(COMP_HALDM, "RateBitmap 0x%x FirstDiffRateThreshold %d SecondDiffRateThreshold %d\n", priv->ieee80211->fsync_rate_bitmap, priv->ieee80211->fsync_firstdiff_ratethreshold, priv->ieee80211->fsync_seconddiff_ratethreshold);
 
 	if (priv->ieee80211->state == IEEE80211_LINKED &&
-		(priv->ieee80211->pHTInfo->IOTAction & HT_IOT_ACT_CDD_FSYNC)) {
+	    (priv->ieee80211->pHTInfo->IOTAction & HT_IOT_ACT_CDD_FSYNC)) {
 		if (priv->ieee80211->bfsync_enable == 0) {
 			switch (priv->ieee80211->fsync_state) {
 			case Default_Fsync:
@@ -2779,7 +2779,7 @@ static void dm_dynamic_txpower(struct net_device *dev)
 	}
 
 	if ((priv->bDynamicTxHighPower != priv->bLastDTPFlag_High) ||
-		(priv->bDynamicTxLowPower != priv->bLastDTPFlag_Low)) {
+	    (priv->bDynamicTxLowPower != priv->bLastDTPFlag_Low)) {
 		RT_TRACE(COMP_TXAGC, "SetTxPowerLevel8190()  channel = %d\n", priv->ieee80211->current_network.channel);
 
 #if  defined(RTL8190P) || defined(RTL8192E)
diff --git a/drivers/staging/rtl8192u/r819xU_firmware.c b/drivers/staging/rtl8192u/r819xU_firmware.c
index 4f8629e47e82..c515b4773e37 100644
--- a/drivers/staging/rtl8192u/r819xU_firmware.c
+++ b/drivers/staging/rtl8192u/r819xU_firmware.c
@@ -88,8 +88,8 @@ static bool fw_download_code(struct net_device *dev, u8 *code_virtual_address,
 
 		index = tcb_desc->queue_index;
 		if (!priv->ieee80211->check_nic_enough_desc(dev, index) ||
-		       (!skb_queue_empty(&priv->ieee80211->skb_waitQ[index])) ||
-		       (priv->ieee80211->queue_stop)) {
+		    (!skb_queue_empty(&priv->ieee80211->skb_waitQ[index])) ||
+		    (priv->ieee80211->queue_stop)) {
 			RT_TRACE(COMP_FIRMWARE, "=====================================================> tx full!\n");
 			skb_queue_tail(&priv->ieee80211->skb_waitQ[tcb_desc->queue_index], skb);
 		} else {
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index e6836eacc7aa..c61a29976e9a 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -875,7 +875,7 @@ void rtl8192_phy_getTxPower(struct net_device *dev)
 	read_nic_byte(dev, rOFDM0_RxDetector2, &tmp);
 	priv->framesyncC34 = tmp;
 	RT_TRACE(COMP_INIT, "Default framesync (0x%x) = 0x%x\n",
-		rOFDM0_RxDetector3, priv->framesync);
+		 rOFDM0_RxDetector3, priv->framesync);
 
 	/* Read SIFS (save the value read fome MACPHY_REG.txt) */
 	read_nic_word(dev, SIFS, &priv->SifsTime);
-- 
2.34.1

