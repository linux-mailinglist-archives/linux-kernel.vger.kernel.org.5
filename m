Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD87D7B5F41
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 05:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbjJCDOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 23:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjJCDOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:14:40 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5275BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 20:14:29 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-49352207f33so211701e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 20:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1696302869; x=1696907669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYVwlv9t9FkMI5y5k7RpgiC3k/zNedl/ZXc1cFJ/T84=;
        b=aG0RPIFlWVR2gRJ4cjAXAcCXSsJsTO9Y7W96Oz+iQWWFd1DgrxLYAq7AZKCNgB1oNC
         SA/srOFS3r+eamJsjigmefXl2yKt5+lKTBIG9W8cvjtMAJ4siUKmV5QNlJf/fNS4RRzE
         kHl8FPAJ0RECzZv6E+65fG27cwvW9r8DBcjDc5mMXUmpMWLsw2xmb7eFcniDHf+C3nWo
         rE81I1aS8IrAoOA+XA89Fci4RJhURNiZVuwXS4MbW9sr6sn5B4gWFjTbJCpzMj8HAUff
         J7Pb20xVPbzlNMr13CzBxQRkSlUV7Sjibrq70nfWL+xpONOFCcaz/u1OGVSaZMgCIZq4
         USAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696302869; x=1696907669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYVwlv9t9FkMI5y5k7RpgiC3k/zNedl/ZXc1cFJ/T84=;
        b=Aibr99N8GNdHzd5yP2Q0xFFhMSWkeGGG2xplThhWcFR6UjSXBw0OMkSNth4a5Wg1jz
         XHjPAxq2ggpkVQUMUKq33SMca3PI+PXMf2XdUxXpUPWAYxDJ/rj+mgt3AWQ8GN2pEZUh
         majXsHHadpcOKP8VqnfhmUc95g7sGB6PZscVgkmz3mDK7avaFx2Rvg8S9k7Z2e2q8KzN
         DhXrHl1AhMM1A+T3sHh5J+8lr64F7k0DJxVRz2MmjcukLPvtGU5ql1Aj5/UTnUqskcKj
         Q5ALZgHJr4WkS49FDpAgIDjXJQEDyP71PKKvJbDJMGdntgLBA4FnnXwP3apuwWF2TOOC
         subg==
X-Gm-Message-State: AOJu0YwpBv92oSiUKm46epceOJTskAYWQqug/4k0EKwEciw4Ckk9Hy7/
        R7/5feMCK8FRykQKByOU5UQZwARxwx+NERFsN5c=
X-Google-Smtp-Source: AGHT+IFwjWgNK0D8U4l5DrZ4uxZr9/XsCqhiNmmcujoHkCreZwQY9g1+TRNw4oYsy4mJBMJzsQCr2Q==
X-Received: by 2002:a1f:e043:0:b0:495:bf04:89f8 with SMTP id x64-20020a1fe043000000b00495bf0489f8mr10527197vkg.6.1696302868849;
        Mon, 02 Oct 2023 20:14:28 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a004b00b00273fc850342sm7692550pjb.20.2023.10.02.20.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 20:14:28 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 2/3] Staging: rtl8192e: Rename variable bCurrentHTSupport
Date:   Mon,  2 Oct 2023 20:18:48 -0700
Message-ID: <20231003031849.176743-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003031849.176743-1-tdavies@darkphysics.net>
References: <20231003031849.176743-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable bCurrentHTSupport to current_ht_support to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   |  2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c    | 12 ++++++------
 drivers/staging/rtl8192e/rtl819x_HT.h        |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 12 ++++++------
 drivers/staging/rtl8192e/rtllib_softmac.c    | 15 +++++++--------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  2 +-
 drivers/staging/rtl8192e/rtllib_tx.c         |  8 ++++----
 8 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 87f5441fbb10..d63c6854886e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -294,7 +294,7 @@ static void _rtl92e_update_beacon(void *data)
 	struct rtllib_device *ieee = priv->rtllib;
 	struct rtllib_network *net = &ieee->current_network;
 
-	if (ieee->ht_info->bCurrentHTSupport)
+	if (ieee->ht_info->current_ht_support)
 		HT_update_self_and_peer_setting(ieee, net);
 	ieee->ht_info->current_rt2rt_long_slot_time = net->bssht.bd_rt2rt_long_slot_time;
 	ieee->ht_info->RT2RT_HT_Mode = net->bssht.rt2rt_ht_mode;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 17e7fcc01f70..0494555c30af 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -864,7 +864,7 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 			rtl92e_set_swcam(dev, idx, idx, alg, broadcast_addr, key);
 		} else {
 			if ((ieee->pairwise_key_type == KEY_TYPE_CCMP) &&
-			     ieee->ht_info->bCurrentHTSupport)
+			     ieee->ht_info->current_ht_support)
 				rtl92e_writeb(dev, 0x173, 1);
 			rtl92e_set_key(dev, 4, idx, alg,
 				       (u8 *)ieee->ap_mac_addr, 0, key);
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 820b5ee2ded1..15e4b83af234 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -244,13 +244,13 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	pBaStartSeqCtrl = (union sequence_control *)(req + 7);
 
 	if (!ieee->current_network.qos_data.active ||
-	    !ieee->ht_info->bCurrentHTSupport ||
+	    !ieee->ht_info->current_ht_support ||
 	    (ieee->ht_info->iot_action & HT_IOT_ACT_REJECT_ADDBA_REQ)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev,
 			    "Failed to reply on ADDBA_REQ as some capability is not ready(%d, %d)\n",
 			    ieee->current_network.qos_data.active,
-			    ieee->ht_info->bCurrentHTSupport);
+			    ieee->ht_info->current_ht_support);
 		goto OnADDBAReq_Fail;
 	}
 	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
@@ -326,12 +326,12 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	pBaTimeoutVal = (u16 *)(tag + 7);
 
 	if (!ieee->current_network.qos_data.active ||
-	    !ieee->ht_info->bCurrentHTSupport ||
+	    !ieee->ht_info->current_ht_support ||
 	    !ieee->ht_info->bCurrentAMPDUEnable) {
 		netdev_warn(ieee->dev,
 			    "reject to ADDBA_RSP as some capability is not ready(%d, %d, %d)\n",
 			    ieee->current_network.qos_data.active,
-			    ieee->ht_info->bCurrentHTSupport,
+			    ieee->ht_info->current_ht_support,
 			    ieee->ht_info->bCurrentAMPDUEnable);
 		ReasonCode = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
@@ -413,11 +413,11 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 	}
 
 	if (!ieee->current_network.qos_data.active ||
-	    !ieee->ht_info->bCurrentHTSupport) {
+	    !ieee->ht_info->current_ht_support) {
 		netdev_warn(ieee->dev,
 			    "received DELBA while QOS or HT is not supported(%d, %d)\n",
 			    ieee->current_network. qos_data.active,
-			    ieee->ht_info->bCurrentHTSupport);
+			    ieee->ht_info->current_ht_support);
 		return -1;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 2bbd01048561..f8eb4d553fe0 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -93,7 +93,7 @@ enum ht_aggre_mode {
 
 struct rt_hi_throughput {
 	u8 enable_ht;
-	u8 bCurrentHTSupport;
+	u8 current_ht_support;
 	u8 bRegBW40MHz;
 	u8 bCurBW40MHz;
 	u8 bRegShortGI40MHz;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index a7e356e90d0e..bb80d3ba182d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -489,7 +489,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	static const u8 EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
 	static const u8 EWC11NHTInfo[] = { 0x00, 0x90, 0x4c, 0x34 };
 
-	if (!ht_info->bCurrentHTSupport) {
+	if (!ht_info->current_ht_support) {
 		netdev_warn(ieee->dev, "%s(): HT_DISABLE\n", __func__);
 		return;
 	}
@@ -594,7 +594,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	ht_info->bCurrentHTSupport = false;
+	ht_info->current_ht_support = false;
 
 	ht_info->bCurBW40MHz = false;
 	ht_info->cur_tx_bw40mhz = false;
@@ -665,7 +665,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 	 * function rtllib_softmac_new_net. WB 2008.09.10
 	 */
 	if (pNetwork->bssht.bd_support_ht) {
-		ht_info->bCurrentHTSupport = true;
+		ht_info->current_ht_support = true;
 		ht_info->ePeerHTSpecVer = pNetwork->bssht.bd_ht_spec_ver;
 
 		if (pNetwork->bssht.bd_ht_cap_len > 0 &&
@@ -719,7 +719,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 		if (bIOTAction)
 			ht_info->iot_action |= HT_IOT_ACT_CDD_FSYNC;
 	} else {
-		ht_info->bCurrentHTSupport = false;
+		ht_info->current_ht_support = false;
 		ht_info->current_rt2rt_aggregation = false;
 		ht_info->current_rt2rt_long_slot_time = false;
 		ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
@@ -736,7 +736,7 @@ void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 	struct ht_info_ele *pPeerHTInfo =
 		 (struct ht_info_ele *)pNetwork->bssht.bd_ht_info_buf;
 
-	if (ht_info->bCurrentHTSupport) {
+	if (ht_info->current_ht_support) {
 		if (pNetwork->bssht.bd_ht_info_len != 0)
 			ht_info->current_op_mode = pPeerHTInfo->OptMode;
 	}
@@ -745,7 +745,7 @@ EXPORT_SYMBOL(HT_update_self_and_peer_setting);
 
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame)
 {
-	if (ieee->ht_info->bCurrentHTSupport) {
+	if (ieee->ht_info->current_ht_support) {
 		if ((IsQoSDataFrame(pFrame) && Frame_Order(pFrame)) == 1) {
 			netdev_dbg(ieee->dev, "HT CONTROL FILED EXIST!!\n");
 			return true;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 72d0225dfdf1..a3191bc890c9 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -769,7 +769,7 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
 	encrypt = crypt && crypt->ops &&
 		((strcmp(crypt->ops->name, "R-WEP") == 0 || wpa_ie_len));
-	if (ieee->ht_info->bCurrentHTSupport) {
+	if (ieee->ht_info->current_ht_support) {
 		tmp_ht_cap_buf = (u8 *)&(ieee->ht_info->SelfHTCap);
 		tmp_ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
 		tmp_ht_info_buf = (u8 *)&(ieee->ht_info->SelfHTInfo);
@@ -976,7 +976,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		ieee->mode = WIRELESS_MODE_G;
 	}
 
-	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
+	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
 		ht_cap_buf = (u8 *)&(ieee->ht_info->SelfHTCap);
 		ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
 		HTConstructCapabilityElement(ieee, ht_cap_buf, &ht_cap_len,
@@ -1114,7 +1114,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		memcpy(tag, osCcxVerNum.Octet, osCcxVerNum.Length);
 		tag += osCcxVerNum.Length;
 	}
-	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
+	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
 		if (ieee->ht_info->ePeerHTSpecVer != HT_SPEC_VER_EWC) {
 			tag = skb_put(skb, ht_cap_len);
 			*tag++ = MFIE_TYPE_HT_CAP;
@@ -1148,7 +1148,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		rtllib_TURBO_Info(ieee, &tag);
 	}
 
-	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
+	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
 		if (ieee->ht_info->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
 			tag = skb_put(skb, ht_cap_len);
 			*tag++ = MFIE_TYPE_GENERIC;
@@ -1313,13 +1313,13 @@ static void rtllib_associate_complete_wq(void *data)
 		ieee->set_wireless_mode(ieee->dev, WIRELESS_MODE_B);
 		netdev_info(ieee->dev, "Using B rates:%d\n", ieee->rate);
 	}
-	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
+	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
 		netdev_info(ieee->dev, "Successfully associated, ht enabled\n");
 		HTOnAssocRsp(ieee);
 	} else {
 		netdev_info(ieee->dev,
 			    "Successfully associated, ht not enabled(%d, %d)\n",
-			    ieee->ht_info->bCurrentHTSupport,
+			    ieee->ht_info->current_ht_support,
 			    ieee->ht_info->enable_ht);
 		memset(ieee->dot11ht_oper_rate_set, 0, 16);
 	}
@@ -1477,8 +1477,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 					HTResetSelfAndSavePeerSetting(ieee,
 						 &(ieee->current_network));
 				else
-					ieee->ht_info->bCurrentHTSupport =
-								 false;
+					ieee->ht_info->current_ht_support = false;
 
 				ieee->link_state = RTLLIB_ASSOCIATING;
 				schedule_delayed_work(
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 3c7c0f07ab0b..2b43bef39d26 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -317,7 +317,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 
 	ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_BACKUP);
 
-	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht &&
+	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht &&
 	    ieee->ht_info->bCurBW40MHz) {
 		b40M = 1;
 		chan_offset = ieee->ht_info->CurSTAExtChnlOffset;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index bad01599033b..53ad5e3fb174 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -273,7 +273,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 	if (rtllib_act_scanning(ieee, false))
 		return;
 
-	if (!ht_info->bCurrentHTSupport || !ht_info->enable_ht)
+	if (!ht_info->current_ht_support || !ht_info->enable_ht)
 		return;
 	if (!IsQoSDataFrame(skb->data))
 		return;
@@ -354,7 +354,7 @@ static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
 
 	tcb_desc->bUseShortGI		= false;
 
-	if (!ht_info->bCurrentHTSupport || !ht_info->enable_ht)
+	if (!ht_info->current_ht_support || !ht_info->enable_ht)
 		return;
 
 	if (ht_info->forced_short_gi) {
@@ -375,7 +375,7 @@ static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
 
 	tcb_desc->bPacketBW = false;
 
-	if (!ht_info->bCurrentHTSupport || !ht_info->enable_ht)
+	if (!ht_info->current_ht_support || !ht_info->enable_ht)
 		return;
 
 	if (tcb_desc->bMulticast || tcb_desc->bBroadcast)
@@ -438,7 +438,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 			tcb_desc->rts_rate = MGN_24M;
 			break;
 		}
-		if (ht_info->bCurrentHTSupport  && ht_info->enable_ht) {
+		if (ht_info->current_ht_support && ht_info->enable_ht) {
 			u8 HTOpMode = ht_info->current_op_mode;
 
 			if ((ht_info->bCurBW40MHz && (HTOpMode == 2 ||
-- 
2.39.2

