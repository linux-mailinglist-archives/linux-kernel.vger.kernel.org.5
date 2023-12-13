Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31257811A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379312AbjLMQwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379184AbjLMQwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:52:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D363D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:50 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5451faa3aa7so1635178a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702486369; x=1703091169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QsDC6cnDlhoPFsKvfa+aFC6albQxgKIcluRdn1hA6pw=;
        b=g4+ZpjuZ2koMAqeky0luxE2LWKELD/4DIonZsw5FCaBMY/ZonRB8K10LmA/g5FvX6W
         TJpMWX8WIZP2a9eBOu3+yCNqzuGAehAb/2RR6KocVkkJ34tTLxhTX4uC/Alat0ZL+/wL
         t9PpVJZ2YxrRjPmtGcuT9AABzVozH+ME28WFYW3Pk+sDXBJ267EzymnfpCqAJYQMzxKy
         ACi3UzrQo2gxiORR735L5eNeN4rCfRv1CK275O5KAa2REeK9unIYswnPzoSu1jA6yhrh
         s0Z0l0GrPNODn8qZFRK6m+GQiuAfEcbLyZILIFZhUM5gjcBE8glQj8k7iz/mzXEy0qj/
         s6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486369; x=1703091169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsDC6cnDlhoPFsKvfa+aFC6albQxgKIcluRdn1hA6pw=;
        b=PO/4YOBc4s8TZ6WLr6qyTfz5OSMMyVjn3mMnXB4x12c3QN+XdoBc2XRIQW3ydc/KTB
         ZHSMaR55R6UDLQdAzhYFkMy3gHN+QDBOVFi6cl/TezNo+/lsqALvvve5x18LzhMjwb0P
         9DfodmNkWnVyCHbMuUF+0UkEDFIwp2CJ9qWyvRbt3syCQRqMegJa5VxMA5mQHF2Kwqj4
         XY4ktSvcCL2LOv+W49UIcFy9UeZ7EvMskL7FKty+O/JJmo9IDIfwAnjCTygtndfZhIAC
         zv/VDrS6USxNQG1eiljKvynLQyqcDFCqDKpWOTNpm1t8Gl856K1MqyUNLJgtHuTj6Jpl
         GlpA==
X-Gm-Message-State: AOJu0YypQP5hhGE6DuB6tD05hFUrO3aeC6BK455ii5bGyk00LV1ZjmMw
        ueZ5RERsQs/iVvUUAfEN3Sw=
X-Google-Smtp-Source: AGHT+IGiLZB6J8iZW9hDz38oOTk+lx19cmC2hpUGX8EXkOEEpEKEYPXqrJS9OR/tvG214l7oaDTRuw==
X-Received: by 2002:a17:907:d30a:b0:a1d:65d:c1b1 with SMTP id vg10-20020a170907d30a00b00a1d065dc1b1mr8031014ejc.2.1702486368388;
        Wed, 13 Dec 2023 08:52:48 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id cx12-20020a170907168c00b00a1caa9dd507sm8111138ejd.52.2023.12.13.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:52:48 -0800 (PST)
Date:   Wed, 13 Dec 2023 17:52:46 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] staging: rtl8192e: Remove constant variable
 reg_rt2rt_aggregation
Message-ID: <07a0954cc6fd730d9d42054fa36346d1de07cd06.1702406712.git.philipp.g.hortmann@gmail.com>
References: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ht_info->reg_rt2rt_aggregation is set to 1 and unchanged. Therefore all
equations result accordingly and ht_info->reg_rt2rt_aggregation can be
removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     |  1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 37 +++++++----------------
 2 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 315905fa4b2c..514ac9e1f3f8 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -112,7 +112,6 @@ struct rt_hi_throughput {
 	enum ht_extchnl_offset CurSTAExtChnlOffset;
 	u8 cur_tx_bw40mhz;
 	u8 sw_bw_in_progress;
-	u8 reg_rt2rt_aggregation;
 	u8 current_rt2rt_aggregation;
 	u8 current_rt2rt_long_slot_time;
 	u8 sz_rt2rt_agg_buf[10];
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 6bd4afe32f61..d9561e3a76d6 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -79,8 +79,6 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 
 	ieee->tx_enable_fw_calc_dur = 1;
 
-	ht_info->reg_rt2rt_aggregation = 1;
-
 	ht_info->reg_rx_reorder_enable = 1;
 	ht_info->rx_reorder_win_size = 64;
 	ht_info->rx_reorder_pending_time = 30;
@@ -471,25 +469,17 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 			ht_info->current_ampdu_enable = false;
 	}
 
-	if (!ht_info->reg_rt2rt_aggregation) {
-		if (ht_info->ampdu_factor > pPeerHTCap->MaxRxAMPDUFactor)
+	if (ieee->current_network.bssht.bd_rt2rt_aggregation) {
+		if (ieee->pairwise_key_type != KEY_TYPE_NA)
 			ht_info->CurrentAMPDUFactor =
-						 pPeerHTCap->MaxRxAMPDUFactor;
+					 pPeerHTCap->MaxRxAMPDUFactor;
 		else
-			ht_info->CurrentAMPDUFactor = ht_info->ampdu_factor;
-
+			ht_info->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
 	} else {
-		if (ieee->current_network.bssht.bd_rt2rt_aggregation) {
-			if (ieee->pairwise_key_type != KEY_TYPE_NA)
-				ht_info->CurrentAMPDUFactor =
-						 pPeerHTCap->MaxRxAMPDUFactor;
-			else
-				ht_info->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
-		} else {
-			ht_info->CurrentAMPDUFactor = min_t(u32, pPeerHTCap->MaxRxAMPDUFactor,
-							    HT_AGG_SIZE_32K);
-		}
+		ht_info->CurrentAMPDUFactor = min_t(u32, pPeerHTCap->MaxRxAMPDUFactor,
+						    HT_AGG_SIZE_32K);
 	}
+
 	ht_info->current_mpdu_density = pPeerHTCap->MPDUDensity;
 	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
 		ht_info->current_ampdu_enable = false;
@@ -595,15 +585,10 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 			       pNetwork->bssht.bd_ht_info_buf,
 			       pNetwork->bssht.bd_ht_info_len);
 
-		if (ht_info->reg_rt2rt_aggregation) {
-			ht_info->current_rt2rt_aggregation =
-				 pNetwork->bssht.bd_rt2rt_aggregation;
-			ht_info->current_rt2rt_long_slot_time =
-				 pNetwork->bssht.bd_rt2rt_long_slot_time;
-		} else {
-			ht_info->current_rt2rt_aggregation = false;
-			ht_info->current_rt2rt_long_slot_time = false;
-		}
+		ht_info->current_rt2rt_aggregation =
+			 pNetwork->bssht.bd_rt2rt_aggregation;
+		ht_info->current_rt2rt_long_slot_time =
+			 pNetwork->bssht.bd_rt2rt_long_slot_time;
 
 		ht_iot_peer_determine(ieee);
 
-- 
2.43.0

