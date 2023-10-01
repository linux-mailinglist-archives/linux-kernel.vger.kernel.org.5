Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960547B47B0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjJANpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbjJANp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:45:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BC4C4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:45:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32337a39009so1722969f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696167924; x=1696772724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PSwRlj34WawnYB96b1PvZ1E7JgfJyhtAvZK5jo+OVcc=;
        b=A20CiVnlBJ1V3sE9irWV0eadnRS33xNpmFF/YNAWhW/T1lwwk4Og52jcwWcIRRmhee
         ZZpDHrTL/lW+A++MKLh7A8p/sDV5h7rzpUGfaTeyvZLhdGUTj9oB++pkFP4vt6bzEJCR
         PuChBsuTA/qbzv9sItwR2n1uC3rzqj3ZMSRMOjEiA5TnctwKa05rVqvRLmViybYwPn7c
         YLw9D3JWnJpt3icebfvRd6JkSxEIy5LNsLRK95FZg22axgKRuZ+1xRlBRO3mh36nh0Z6
         sDObhB4DG2TFyS9xFeRR6MSgaxF299bF/jrTmxS7R2YV+QmVz/g6bss0wAPm9YrM2Hh/
         gZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167924; x=1696772724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSwRlj34WawnYB96b1PvZ1E7JgfJyhtAvZK5jo+OVcc=;
        b=gdv65jQZykKnD01+tHyt3mMyhNB8vMtq4TcA/Nzo33P6UYF916mbQUUYJ1+DB6srgx
         fR9jsG/KByDig4fQ5fZT8f9AlmhwmnNNby4OOqdv/GKl3srpj2JugSmKo2I/Pv1nmQGW
         n8MTemGjI3oJayAtinNigkDKJUL+7QhaFRzcAcIulRti+hid/ofrEcz98vcqnYHSoKAk
         lI7L1/DO0ig4q2B9ZgIzm6mEzw+U2+GMaZ/mgPi3Igu4EP8majcp/KnQNsma+UtLUDVO
         ovqOuKx2Oq4eOQNv1Q2sPTD752otvhNsZW2m73LdboHd3LdQYEr5PcjJMrRF4zl5wiJI
         yB6Q==
X-Gm-Message-State: AOJu0YzDApNnRT0GU2lvXwYd4/+jtS5L48ohOKYy74PciO0KwAl06hMj
        vftPAP1nGOxgfO6xCYSnNTc4jF/O7GI=
X-Google-Smtp-Source: AGHT+IFnyxfQdSg/E7QYc4x/qfBVxzxQg88geg32+X9f36EEmlbnkk8pvvwlVh6FB1dGxIch6EaUAw==
X-Received: by 2002:a05:600c:1c9d:b0:405:39bb:38a8 with SMTP id k29-20020a05600c1c9d00b0040539bb38a8mr8229593wms.2.1696167923593;
        Sun, 01 Oct 2023 06:45:23 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id p17-20020aa7d311000000b00532bec5f768sm14061556edq.95.2023.10.01.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:45:23 -0700 (PDT)
Date:   Sun, 1 Oct 2023 15:45:21 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] staging: rtl8192e: Remove unused variables
 priv->reset_count and reset_cnt
Message-ID: <27adae9b824a522280485b3d16f14893bf99da4c.1696165351.git.philipp.g.hortmann@gmail.com>
References: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variables priv->reset_count, reset_cnt and reset_cnt_highpwr
as those are always 0. All equations result accordingly. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   | 49 ++------------------
 2 files changed, 4 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index fa5d0eec90d3..0ebebb3c2c35 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -368,7 +368,6 @@ struct r8192_priv {
 	u32		continue_diff_count;
 	bool		bswitch_fsync;
 	u8		framesync;
-	u32		reset_count;
 
 	u16		tx_counter;
 	u16		rx_ctr;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index fd5228e7a462..c29bc85f9577 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1088,7 +1088,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
 static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	static u32 reset_cnt;
 	u8 i;
 
 	if (!dm_digtable.dig_enable_flag)
@@ -1108,10 +1107,8 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
 		(priv->undecorated_smoothed_pwdb < dm_digtable.rssi_high_thresh))
 		return;
 	if (priv->undecorated_smoothed_pwdb <= dm_digtable.rssi_low_thresh) {
-		if (dm_digtable.dig_state == DM_STA_DIG_OFF &&
-			(priv->reset_count == reset_cnt))
+		if (dm_digtable.dig_state == DM_STA_DIG_OFF)
 			return;
-		reset_cnt = priv->reset_count;
 
 		dm_digtable.dig_highpwr_state = DM_STA_DIG_MAX;
 		dm_digtable.dig_state = DM_STA_DIG_OFF;
@@ -1136,15 +1133,10 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
 	if (priv->undecorated_smoothed_pwdb >= dm_digtable.rssi_high_thresh) {
 		u8 reset_flag = 0;
 
-		if (dm_digtable.dig_state == DM_STA_DIG_ON &&
-		    (priv->reset_count == reset_cnt)) {
+		if (dm_digtable.dig_state == DM_STA_DIG_ON) {
 			_rtl92e_dm_ctrl_initgain_byrssi_highpwr(dev);
 			return;
 		}
-		if (priv->reset_count != reset_cnt)
-			reset_flag = 1;
-
-		reset_cnt = priv->reset_count;
 
 		dm_digtable.dig_state = DM_STA_DIG_ON;
 
@@ -1175,7 +1167,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
 static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	static u32 reset_cnt_highpwr;
 
 	if ((priv->undecorated_smoothed_pwdb >
 	     dm_digtable.rssi_high_power_lowthresh) &&
@@ -1185,8 +1176,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev)
 
 	if (priv->undecorated_smoothed_pwdb >=
 	    dm_digtable.rssi_high_power_highthresh) {
-		if (dm_digtable.dig_highpwr_state == DM_STA_DIG_ON &&
-			(priv->reset_count == reset_cnt_highpwr))
+		if (dm_digtable.dig_highpwr_state == DM_STA_DIG_ON)
 			return;
 		dm_digtable.dig_highpwr_state = DM_STA_DIG_ON;
 
@@ -1195,8 +1185,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev)
 		else
 			rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x43);
 	} else {
-		if (dm_digtable.dig_highpwr_state == DM_STA_DIG_OFF &&
-			(priv->reset_count == reset_cnt_highpwr))
+		if (dm_digtable.dig_highpwr_state == DM_STA_DIG_OFF)
 			return;
 		dm_digtable.dig_highpwr_state = DM_STA_DIG_OFF;
 
@@ -1210,7 +1199,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev)
 				rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x44);
 		}
 	}
-	reset_cnt_highpwr = priv->reset_count;
 }
 
 static void _rtl92e_dm_initial_gain(struct net_device *dev)
@@ -1218,11 +1206,9 @@ static void _rtl92e_dm_initial_gain(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u8 initial_gain = 0;
 	static u8 initialized, force_write;
-	static u32 reset_cnt;
 
 	if (dm_digtable.dig_algorithm_switch) {
 		initialized = 0;
-		reset_cnt = 0;
 	}
 
 	if (rtllib_act_scanning(priv->rtllib, true)) {
@@ -1249,11 +1235,6 @@ static void _rtl92e_dm_initial_gain(struct net_device *dev)
 		dm_digtable.pre_ig_value = 0;
 	}
 
-	if (priv->reset_count != reset_cnt) {
-		force_write = 1;
-		reset_cnt = priv->reset_count;
-	}
-
 	if (dm_digtable.pre_ig_value != rtl92e_readb(dev, rOFDM0_XAAGCCore1))
 		force_write = 1;
 
@@ -1274,11 +1255,9 @@ static void _rtl92e_dm_pd_th(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	static u8 initialized, force_write;
-	static u32 reset_cnt;
 
 	if (dm_digtable.dig_algorithm_switch) {
 		initialized = 0;
-		reset_cnt = 0;
 	}
 
 	if (dm_digtable.pre_sta_connect_state == dm_digtable.cur_sta_connect_state) {
@@ -1307,11 +1286,6 @@ static void _rtl92e_dm_pd_th(struct net_device *dev)
 		dm_digtable.curpd_thstate = DIG_PD_AT_LOW_POWER;
 	}
 
-	if (priv->reset_count != reset_cnt) {
-		force_write = 1;
-		reset_cnt = priv->reset_count;
-	}
-
 	if ((dm_digtable.prepd_thstate != dm_digtable.curpd_thstate) ||
 	    (initialized <= 3) || force_write) {
 		if (dm_digtable.curpd_thstate == DIG_PD_AT_LOW_POWER) {
@@ -1340,13 +1314,10 @@ static void _rtl92e_dm_pd_th(struct net_device *dev)
 
 static void _rtl92e_dm_cs_ratio(struct net_device *dev)
 {
-	struct r8192_priv *priv = rtllib_priv(dev);
 	static u8 initialized, force_write;
-	static u32 reset_cnt;
 
 	if (dm_digtable.dig_algorithm_switch) {
 		initialized = 0;
-		reset_cnt = 0;
 	}
 
 	if (dm_digtable.pre_sta_connect_state == dm_digtable.cur_sta_connect_state) {
@@ -1364,11 +1335,6 @@ static void _rtl92e_dm_cs_ratio(struct net_device *dev)
 		dm_digtable.curcs_ratio_state = DIG_CS_RATIO_LOWER;
 	}
 
-	if (priv->reset_count != reset_cnt) {
-		force_write = 1;
-		reset_cnt = priv->reset_count;
-	}
-
 	if ((dm_digtable.precs_ratio_state != dm_digtable.curcs_ratio_state) ||
 	    !initialized || force_write) {
 		if (dm_digtable.curcs_ratio_state == DIG_CS_RATIO_LOWER)
@@ -1982,7 +1948,6 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 #define	RegC38_Fsync_AP_BCM		2
 	struct r8192_priv *priv = rtllib_priv(dev);
 	static u8 reg_c38_State = RegC38_Default;
-	static u32 reset_cnt;
 
 	if (priv->rtllib->link_state == MAC80211_LINKED &&
 	    priv->rtllib->ht_info->IOTPeer == HT_IOT_PEER_BROADCOM) {
@@ -2066,12 +2031,6 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 			}
 		}
 	}
-	if (priv->reset_count != reset_cnt) {
-		rtl92e_writeb(dev, rOFDM0_RxDetector3,
-			       priv->framesync);
-		reg_c38_State = RegC38_Default;
-		reset_cnt = priv->reset_count;
-	}
 }
 
 /*---------------------------Define function prototype------------------------*/
-- 
2.42.0

