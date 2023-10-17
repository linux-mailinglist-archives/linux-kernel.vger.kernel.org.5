Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F607CBECC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbjJQJSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343490AbjJQJSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:18:09 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BD8B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:18:07 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7db1f864bso64921697b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697534286; x=1698139086; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVDqeX7oxEECgEEHyppkUFbbAL3TzzFJ4INHuHiAmFA=;
        b=YqZx5uCwQmvr4bWFA75236cjnbkSQ3q4dhxMgKr5QHGDUD3o0FCJV41+uJjFfQkxCO
         Bd+kcmD7Ca272PDI2bhBMlxshyt/NjomI9Vq8SL7e2aQ86AiPBrxwiSisJ8bmV69Ud/x
         Gkuuqd7EtnntVDrP/BHDxyNnK9PKy4F/Y7PKjzTncHke4Vw8QK/7EE8yvuSe3JKAwWC6
         9fxV5BvNfMetvT+YzzDZnP3Hbz7zPBulACsQ3Pmz/04jYUhTFkDBgF+0ZYqSa06tbLWm
         bdn+VJaAt3cdGz8VhdNnTHW7P7bDzunQ5nPMdlIS3Dnf9976rtQN2szkTdP6EKHwwUJK
         xONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534286; x=1698139086;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVDqeX7oxEECgEEHyppkUFbbAL3TzzFJ4INHuHiAmFA=;
        b=CpTkomJMk/bWNQviuTpGkuGRYMHiAB+0hlcIhaMmihvajm10+GEZTLgqCrZofcE5KM
         AlHn/myfbxt2OrNMCjSFFFtZpxDI5OXVfOnsJndgZxTZ9WABojI6ZAdGijYN+b0IqIbJ
         xc7NhL4rRM12Gmbg7y5Cebdx+Vpwae75vYVu1SfuM7nVDCQikOAE/mxCZSmulUwJm3RA
         RhfBg7hN0D6EdttVWd9bBbeACJHMt3azVocNEid4dOHnikjwIZNKJIg2dz2EZwUdRYOz
         Lm+uGSPwqrZk7ubF2A72Lhtf32Nhd5haUKdFcAExPK9rhToQhTUUbKqR973G11SIemUI
         mC0g==
X-Gm-Message-State: AOJu0YxKbDMkfqYlyr429nD8khNrVVSV4LwLApLqo7yknwbELGXwjg4O
        6aij71W8AqN4JVQkkb+6JvNFwT8/CvFtBA==
X-Google-Smtp-Source: AGHT+IG2I9aTLQt8kqHRxspuigf9Th/LYHrBm2FSBTp1df4q3g0YU5Vmnc2Pr8iD5Ib7Ia10oM20jg==
X-Received: by 2002:a0d:c447:0:b0:59f:21c1:30b6 with SMTP id g68-20020a0dc447000000b0059f21c130b6mr1549066ywd.51.1697534285669;
        Tue, 17 Oct 2023 02:18:05 -0700 (PDT)
Received: from lab-ubuntu ([41.90.67.11])
        by smtp.gmail.com with ESMTPSA id o80-20020a0dcc53000000b0059bcadded9dsm456616ywd.116.2023.10.17.02.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:18:05 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:18:02 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Calvince Otieno <calvncce@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Deepak R Varma <drv@mailo.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: use netdev_dbg over pr_debug
Message-ID: <ZS5RSsaNvOvshNj6@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the usage of pr_debug() with netdev_dbg().
The change is made to enhance context-aware debugging,
improve code clarity, and maintain compatibility with established
network debugging practices. There were no functional code changes.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/wlan-ng/prism2sta.c | 127 +++++++++++++++-------------
 1 file changed, 69 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
index b5e95a3207fe..964164bb4165 100644
--- a/drivers/staging/wlan-ng/prism2sta.c
+++ b/drivers/staging/wlan-ng/prism2sta.c
@@ -265,46 +265,50 @@ static int prism2sta_mlmerequest(struct wlandevice *wlandev,
 
 	switch (msg->msgcode) {
 	case DIDMSG_DOT11REQ_MIBGET:
-		pr_debug("Received mibget request\n");
+		netdev_dbg(wlandev->netdev, "Received mibget request\n");
 		result = prism2mgmt_mibset_mibget(wlandev, msg);
 		break;
 	case DIDMSG_DOT11REQ_MIBSET:
-		pr_debug("Received mibset request\n");
+		netdev_dbg(wlandev->netdev, "Received mibset request\n");
 		result = prism2mgmt_mibset_mibget(wlandev, msg);
 		break;
 	case DIDMSG_DOT11REQ_SCAN:
-		pr_debug("Received scan request\n");
+		netdev_dbg(wlandev->netdev, "Received scan request\n");
 		result = prism2mgmt_scan(wlandev, msg);
 		break;
 	case DIDMSG_DOT11REQ_SCAN_RESULTS:
-		pr_debug("Received scan_results request\n");
+		netdev_dbg(wlandev->netdev, "Received scan_results request\n");
 		result = prism2mgmt_scan_results(wlandev, msg);
 		break;
 	case DIDMSG_DOT11REQ_START:
-		pr_debug("Received mlme start request\n");
+		netdev_dbg(wlandev->netdev, "Received mlme start request\n");
 		result = prism2mgmt_start(wlandev, msg);
 		break;
 		/*
 		 * Prism2 specific messages
 		 */
 	case DIDMSG_P2REQ_READPDA:
-		pr_debug("Received mlme readpda request\n");
+		netdev_dbg(wlandev->netdev, "Received mlme readpda request\n");
 		result = prism2mgmt_readpda(wlandev, msg);
 		break;
 	case DIDMSG_P2REQ_RAMDL_STATE:
-		pr_debug("Received mlme ramdl_state request\n");
+		netdev_dbg(wlandev->netdev,
+			   "Received mlme ramdl_state request\n");
 		result = prism2mgmt_ramdl_state(wlandev, msg);
 		break;
 	case DIDMSG_P2REQ_RAMDL_WRITE:
-		pr_debug("Received mlme ramdl_write request\n");
+		netdev_dbg(wlandev->netdev,
+			   "Received mlme ramdl_write request\n");
 		result = prism2mgmt_ramdl_write(wlandev, msg);
 		break;
 	case DIDMSG_P2REQ_FLASHDL_STATE:
-		pr_debug("Received mlme flashdl_state request\n");
+		netdev_dbg(wlandev->netdev,
+			   "Received mlme flashdl_state request\n");
 		result = prism2mgmt_flashdl_state(wlandev, msg);
 		break;
 	case DIDMSG_P2REQ_FLASHDL_WRITE:
-		pr_debug("Received mlme flashdl_write request\n");
+		netdev_dbg(wlandev->netdev,
+			   "Received mlme flashdl_write request\n");
 		result = prism2mgmt_flashdl_write(wlandev, msg);
 		break;
 		/*
@@ -315,7 +319,7 @@ static int prism2sta_mlmerequest(struct wlandevice *wlandev,
 	case DIDMSG_LNXREQ_IFSTATE: {
 		struct p80211msg_lnxreq_ifstate *ifstatemsg;
 
-		pr_debug("Received mlme ifstate request\n");
+		netdev_dbg(wlandev->netdev, "Received mlme ifstate request\n");
 		ifstatemsg = (struct p80211msg_lnxreq_ifstate *)msg;
 		result = prism2sta_ifstate(wlandev,
 					   ifstatemsg->ifstate.data);
@@ -326,17 +330,18 @@ static int prism2sta_mlmerequest(struct wlandevice *wlandev,
 		break;
 	}
 	case DIDMSG_LNXREQ_WLANSNIFF:
-		pr_debug("Received mlme wlansniff request\n");
+		netdev_dbg(wlandev->netdev,
+			   "Received mlme wlansniff request\n");
 		result = prism2mgmt_wlansniff(wlandev, msg);
 		break;
 	case DIDMSG_LNXREQ_AUTOJOIN:
-		pr_debug("Received mlme autojoin request\n");
+		netdev_dbg(wlandev->netdev, "Received mlme autojoin request\n");
 		result = prism2mgmt_autojoin(wlandev, msg);
 		break;
 	case DIDMSG_LNXREQ_COMMSQUALITY: {
 		struct p80211msg_lnxreq_commsquality *qualmsg;
 
-		pr_debug("Received commsquality request\n");
+		netdev_dbg(wlandev->netdev, "Received commsquality request\n");
 
 		qualmsg = (struct p80211msg_lnxreq_commsquality *)msg;
 
@@ -389,8 +394,8 @@ u32 prism2sta_ifstate(struct wlandevice *wlandev, u32 ifstate)
 
 	result = P80211ENUM_resultcode_implementation_failure;
 
-	pr_debug("Current MSD state(%d), requesting(%d)\n",
-		 wlandev->msdstate, ifstate);
+	netdev_dbg(wlandev->netdev, "Current MSD state(%d), requesting(%d)\n",
+		   wlandev->msdstate, ifstate);
 	switch (ifstate) {
 	case P80211ENUM_ifstate_fwload:
 		switch (wlandev->msdstate) {
@@ -998,15 +1003,15 @@ static void prism2sta_inf_scanresults(struct wlandevice *wlandev,
 	nbss /= sizeof(struct hfa384x_scan_result_sub);
 
 	/* Print em */
-	pr_debug("rx scanresults, reason=%d, nbss=%d:\n",
-		 inf->info.scanresult.scanreason, nbss);
+	netdev_dbg(wlandev->netdev, "rx scanresults, reason=%d, nbss=%d:\n",
+		   inf->info.scanresult.scanreason, nbss);
 	for (i = 0; i < nbss; i++) {
-		pr_debug("chid=%d anl=%d sl=%d bcnint=%d\n",
-			 sr->result[i].chid,
-			 sr->result[i].anl,
-			 sr->result[i].sl, sr->result[i].bcnint);
-		pr_debug("  capinfo=0x%04x proberesp_rate=%d\n",
-			 sr->result[i].capinfo, sr->result[i].proberesp_rate);
+		netdev_dbg(wlandev->netdev, "chid=%d anl=%d sl=%d bcnint=%d\n",
+			   sr->result[i].chid, sr->result[i].anl,
+			   sr->result[i].sl, sr->result[i].bcnint);
+		netdev_dbg(wlandev->netdev,
+			   "  capinfo=0x%04x proberesp_rate=%d\n",
+			   sr->result[i].capinfo, sr->result[i].proberesp_rate);
 	}
 	/* issue a join request */
 	joinreq.channel = sr->result[0].chid;
@@ -1044,7 +1049,7 @@ static void prism2sta_inf_hostscanresults(struct wlandevice *wlandev,
 	int nbss;
 
 	nbss = (inf->framelen - 3) / 32;
-	pr_debug("Received %d hostscan results\n", nbss);
+	netdev_dbg(wlandev->netdev, "Received %d hostscan results\n", nbss);
 
 	if (nbss > 32)
 		nbss = 32;
@@ -1107,13 +1112,14 @@ static void prism2sta_inf_chinforesults(struct wlandevice *wlandev,
 		chinforesult->pnl = result->pnl;
 		chinforesult->active = result->active;
 
-		pr_debug("chinfo: channel %d, %s level (avg/peak)=%d/%d dB, pcf %d\n",
-			 chan + 1,
-			 (chinforesult->active & HFA384x_CHINFORESULT_BSSACTIVE)
-				? "signal" : "noise",
-			 chinforesult->anl, chinforesult->pnl,
-			 (chinforesult->active & HFA384x_CHINFORESULT_PCFACTIVE)
-				? 1 : 0);
+		netdev_dbg(wlandev->netdev,
+			   "chinfo: channel %d, %s level (avg/peak)=%d/%d dB, pcf %d\n",
+			   chan + 1,
+			   (chinforesult->active & HFA384x_CHINFORESULT_BSSACTIVE) ?
+			   "signal" : "noise",
+			   chinforesult->anl,
+			   chinforesult->pnl,
+			   (chinforesult->active & HFA384x_CHINFORESULT_PCFACTIVE) ? 1 : 0);
 		n++;
 	}
 	atomic_set(&hw->channel_info.done, 2);
@@ -1192,9 +1198,9 @@ void prism2sta_processing_defer(struct work_struct *data)
 							wlandev->bssid,
 							WLAN_BSSID_LEN);
 			if (result) {
-				pr_debug
-				    ("getconfig(0x%02x) failed, result = %d\n",
-				     HFA384x_RID_CURRENTBSSID, result);
+				netdev_dbg(wlandev->netdev,
+					   "getconfig(0x%02x) failed, result = %d\n",
+					   HFA384x_RID_CURRENTBSSID, result);
 				return;
 			}
 
@@ -1202,9 +1208,9 @@ void prism2sta_processing_defer(struct work_struct *data)
 							HFA384x_RID_CURRENTSSID,
 							&ssid, sizeof(ssid));
 			if (result) {
-				pr_debug
-				    ("getconfig(0x%02x) failed, result = %d\n",
-				     HFA384x_RID_CURRENTSSID, result);
+				netdev_dbg(wlandev->netdev,
+					   "getconfig(0x%02x) failed, result = %d\n",
+					   HFA384x_RID_CURRENTSSID, result);
 				return;
 			}
 			prism2mgmt_bytestr2pstr((struct hfa384x_bytestr *)&ssid,
@@ -1215,9 +1221,9 @@ void prism2sta_processing_defer(struct work_struct *data)
 							  HFA384x_RID_PORTSTATUS,
 							  &portstatus);
 			if (result) {
-				pr_debug
-				    ("getconfig(0x%02x) failed, result = %d\n",
-				     HFA384x_RID_PORTSTATUS, result);
+				netdev_dbg(wlandev->netdev,
+					   "getconfig(0x%02x) failed, result = %d\n",
+					   HFA384x_RID_PORTSTATUS, result);
 				return;
 			}
 			wlandev->macmode =
@@ -1275,8 +1281,9 @@ void prism2sta_processing_defer(struct work_struct *data)
 						HFA384x_RID_CURRENTBSSID,
 						wlandev->bssid, WLAN_BSSID_LEN);
 		if (result) {
-			pr_debug("getconfig(0x%02x) failed, result = %d\n",
-				 HFA384x_RID_CURRENTBSSID, result);
+			netdev_dbg(wlandev->netdev,
+				   "getconfig(0x%02x) failed, result = %d\n",
+				   HFA384x_RID_CURRENTBSSID, result);
 			return;
 		}
 
@@ -1284,8 +1291,9 @@ void prism2sta_processing_defer(struct work_struct *data)
 						HFA384x_RID_CURRENTSSID,
 						&ssid, sizeof(ssid));
 		if (result) {
-			pr_debug("getconfig(0x%02x) failed, result = %d\n",
-				 HFA384x_RID_CURRENTSSID, result);
+			netdev_dbg(wlandev->netdev,
+				   "getconfig(0x%02x) failed, result = %d\n",
+				   HFA384x_RID_CURRENTSSID, result);
 			return;
 		}
 		prism2mgmt_bytestr2pstr((struct hfa384x_bytestr *)&ssid,
@@ -1761,7 +1769,7 @@ void prism2sta_ev_info(struct wlandevice *wlandev,
  */
 void prism2sta_ev_txexc(struct wlandevice *wlandev, u16 status)
 {
-	pr_debug("TxExc status=0x%x.\n", status);
+	netdev_dbg(wlandev->netdev, "TxExc status=0x%x.\n", status);
 }
 
 /*
@@ -1782,7 +1790,7 @@ void prism2sta_ev_txexc(struct wlandevice *wlandev, u16 status)
  */
 void prism2sta_ev_tx(struct wlandevice *wlandev, u16 status)
 {
-	pr_debug("Tx Complete, status=0x%04x\n", status);
+	netdev_dbg(wlandev->netdev, "Tx Complete, status=0x%04x\n", status);
 	/* update linux network stats */
 	wlandev->netdev->stats.tx_packets++;
 }
@@ -1891,10 +1899,10 @@ void prism2sta_commsqual_defer(struct work_struct *data)
 			return;
 		}
 
-		pr_debug("commsqual %d %d %d\n",
-			 le16_to_cpu(hw->qual.cq_curr_bss),
-			 le16_to_cpu(hw->qual.asl_curr_bss),
-			 le16_to_cpu(hw->qual.anl_curr_fc));
+		netdev_dbg(wlandev->netdev, "commsqual %d %d %d\n",
+			   le16_to_cpu(hw->qual.cq_curr_bss),
+			   le16_to_cpu(hw->qual.asl_curr_bss),
+			   le16_to_cpu(hw->qual.anl_curr_fc));
 	}
 
 	/* Get the signal rate */
@@ -1903,8 +1911,8 @@ void prism2sta_commsqual_defer(struct work_struct *data)
 	result = p80211req_dorequest(wlandev, (u8 *)&msg);
 
 	if (result) {
-		pr_debug("get signal rate failed, result = %d\n",
-			 result);
+		netdev_dbg(wlandev->netdev,
+			   "get signal rate failed, result = %d\n", result);
 		return;
 	}
 
@@ -1922,7 +1930,8 @@ void prism2sta_commsqual_defer(struct work_struct *data)
 		hw->txrate = 110;
 		break;
 	default:
-		pr_debug("Bad ratebit (%d)\n", mibitem->data);
+		netdev_dbg(wlandev->netdev, "Bad ratebit (%d)\n",
+			   mibitem->data);
 	}
 
 	/* Lastly, we need to make sure the BSSID didn't change on us */
@@ -1930,8 +1939,9 @@ void prism2sta_commsqual_defer(struct work_struct *data)
 					HFA384x_RID_CURRENTBSSID,
 					wlandev->bssid, WLAN_BSSID_LEN);
 	if (result) {
-		pr_debug("getconfig(0x%02x) failed, result = %d\n",
-			 HFA384x_RID_CURRENTBSSID, result);
+		netdev_dbg(wlandev->netdev,
+			   "getconfig(0x%02x) failed, result = %d\n",
+			   HFA384x_RID_CURRENTBSSID, result);
 		return;
 	}
 
@@ -1939,8 +1949,9 @@ void prism2sta_commsqual_defer(struct work_struct *data)
 					HFA384x_RID_CURRENTSSID,
 					&ssid, sizeof(ssid));
 	if (result) {
-		pr_debug("getconfig(0x%02x) failed, result = %d\n",
-			 HFA384x_RID_CURRENTSSID, result);
+		netdev_dbg(wlandev->netdev,
+			   "getconfig(0x%02x) failed, result = %d\n",
+			   HFA384x_RID_CURRENTSSID, result);
 		return;
 	}
 	prism2mgmt_bytestr2pstr((struct hfa384x_bytestr *)&ssid,
-- 
2.34.1

