Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A8E7C880D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjJMOoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjJMOoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:44:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C717ACA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:44:08 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405e48d8e72so5561735e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697208247; x=1697813047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2pr0IzxvU4PJX3BEoAev8yksHWUcNoh24JtDBC0yvj8=;
        b=MgD21UYqDQ/DEUBTumtP+Q/fEX2M6J736jyUlnOg1AnIoR31DTVokUxR2JIQd3+ujJ
         1nt46gYP/M4pdvDvtXZ/NVo+0XUc3v0VHf/OOCFv2zGCPtw7wpTN5CTRSj1LAJOP6Gj8
         Cmb621i+8bbIt99A35j6xed46A7anqZR8gTFlaq5RQe9npehg4esjMdVjIliS08QACcj
         H0ruOiKBYJJpOko5mF3DvqlwQ4oNyv/hdMPm13eVqYzOvXM4+cui+UcxiOP1f4ptnAev
         F0oErY361jNnhESKBb5G4ZGruDhUIMUm+R8h5sMHTDzjjuGR53eUQhA17/N2eIbQd1bm
         ZusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697208247; x=1697813047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pr0IzxvU4PJX3BEoAev8yksHWUcNoh24JtDBC0yvj8=;
        b=H6GpkmxwxaUN5UoV2HvUtzuorp6K8FbNKCo5d8oxAAKYANVmqIdp0/Dc/Ap41PuITz
         1hkPxxNhW5pZYrHqY738ykXgae+KGp6cTRq/h8UKOIPPxFpizVILSlkfbHpGyR1UUp6C
         Qs5JkiOU+RwfMombNjiAXSXj7bYY6UpaN3JdcFy7YB6xyPq9P7K3Im+sKAv4rp1jxUx3
         vh5Wu/NnvqVlLGmfp43j1QjfaaNXSxknrnW0v7miKmJj3cDDd5e1gt+eaeof7cUxQps/
         tnRPpGUj+ovFYs6Y+jonDkBdY0T55Kyz85jazI1x57SbsCNA4JbWPeAac1qRoA7fWo/x
         y4+g==
X-Gm-Message-State: AOJu0YwwBdiF5xOIkI8dXxkWUxXZJoky0SxbNrFp2irXqzM9DL2XP5Ma
        m/ekDBtd58PQdkKyypD9qOk=
X-Google-Smtp-Source: AGHT+IHtZomzfKRt/2/71UhVOm+Uh/gqPQFN82UqGQjXbQNaaKC0vahQ2HX9x92+okKCLYnYUJrtcQ==
X-Received: by 2002:a05:600c:3c96:b0:403:334:fb0d with SMTP id bg22-20020a05600c3c9600b004030334fb0dmr24327640wmb.4.1697208246738;
        Fri, 13 Oct 2023 07:44:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b00401e32b25adsm333362wmq.4.2023.10.13.07.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:44:06 -0700 (PDT)
Date:   Fri, 13 Oct 2023 16:44:05 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] staging: rtl8192e: Remove
 _rtl92e_dm_ctrl_initgain_byrssi_false_alarm()
Message-ID: <80a5a0b67d9d225a58c96781c33e2216c0ea1c6e.1697127817.git.philipp.g.hortmann@gmail.com>
References: <cover.1697127817.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697127817.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function _rtl92e_dm_ctrl_initgain_byrssi_false_alarm() as it is
unused. Remove in above function called function
_rtl92e_dm_ctrl_initgain_byrssi_highpwr() as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 115 ---------------------
 1 file changed, 115 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 2bbc6a67188c..e69c22e5d205 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -163,9 +163,7 @@ static	void	_rtl92e_dm_check_tx_power_tracking(struct net_device *dev);
 
 static void _rtl92e_dm_dig_init(struct net_device *dev);
 static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev);
-static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev);
 static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev);
-static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev);
 static void _rtl92e_dm_initial_gain(struct net_device *dev);
 static void _rtl92e_dm_pd_th(struct net_device *dev);
 static void _rtl92e_dm_cs_ratio(struct net_device *dev);
@@ -987,119 +985,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
 	dm_digtable.pre_sta_connect_state = dm_digtable.cur_sta_connect_state;
 }
 
-static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	u8 i;
-
-	if (dm_digtable.dig_algorithm_switch) {
-		dm_digtable.dig_state = DM_STA_DIG_MAX;
-		for (i = 0; i < 3; i++)
-			rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x1);
-		dm_digtable.dig_algorithm_switch = 0;
-	}
-
-	if (priv->rtllib->link_state != MAC80211_LINKED)
-		return;
-
-	if ((priv->undecorated_smoothed_pwdb > dm_digtable.rssi_low_thresh) &&
-		(priv->undecorated_smoothed_pwdb < dm_digtable.rssi_high_thresh))
-		return;
-	if (priv->undecorated_smoothed_pwdb <= dm_digtable.rssi_low_thresh) {
-		if (dm_digtable.dig_state == DM_STA_DIG_OFF)
-			return;
-
-		dm_digtable.dig_highpwr_state = DM_STA_DIG_MAX;
-		dm_digtable.dig_state = DM_STA_DIG_OFF;
-
-		rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x8);
-
-		rtl92e_writeb(dev, rOFDM0_XAAGCCore1, 0x17);
-		rtl92e_writeb(dev, rOFDM0_XBAGCCore1, 0x17);
-		rtl92e_writeb(dev, rOFDM0_XCAGCCore1, 0x17);
-		rtl92e_writeb(dev, rOFDM0_XDAGCCore1, 0x17);
-
-		if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
-			rtl92e_writeb(dev, (rOFDM0_XATxAFE + 3), 0x00);
-		else
-			rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x42);
-
-		rtl92e_writeb(dev, 0xa0a, 0x08);
-
-		return;
-	}
-
-	if (priv->undecorated_smoothed_pwdb >= dm_digtable.rssi_high_thresh) {
-		u8 reset_flag = 0;
-
-		if (dm_digtable.dig_state == DM_STA_DIG_ON) {
-			_rtl92e_dm_ctrl_initgain_byrssi_highpwr(dev);
-			return;
-		}
-
-		dm_digtable.dig_state = DM_STA_DIG_ON;
-
-		if (reset_flag == 1) {
-			rtl92e_writeb(dev, rOFDM0_XAAGCCore1, 0x2c);
-			rtl92e_writeb(dev, rOFDM0_XBAGCCore1, 0x2c);
-			rtl92e_writeb(dev, rOFDM0_XCAGCCore1, 0x2c);
-			rtl92e_writeb(dev, rOFDM0_XDAGCCore1, 0x2c);
-		} else {
-			rtl92e_writeb(dev, rOFDM0_XAAGCCore1, 0x20);
-			rtl92e_writeb(dev, rOFDM0_XBAGCCore1, 0x20);
-			rtl92e_writeb(dev, rOFDM0_XCAGCCore1, 0x20);
-			rtl92e_writeb(dev, rOFDM0_XDAGCCore1, 0x20);
-		}
-
-		if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
-			rtl92e_writeb(dev, (rOFDM0_XATxAFE + 3), 0x20);
-		else
-			rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x44);
-
-		rtl92e_writeb(dev, 0xa0a, 0xcd);
-
-		rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x1);
-	}
-	_rtl92e_dm_ctrl_initgain_byrssi_highpwr(dev);
-}
-
-static void _rtl92e_dm_ctrl_initgain_byrssi_highpwr(struct net_device *dev)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	if ((priv->undecorated_smoothed_pwdb >
-	     dm_digtable.rssi_high_power_lowthresh) &&
-	    (priv->undecorated_smoothed_pwdb <
-	     dm_digtable.rssi_high_power_highthresh))
-		return;
-
-	if (priv->undecorated_smoothed_pwdb >=
-	    dm_digtable.rssi_high_power_highthresh) {
-		if (dm_digtable.dig_highpwr_state == DM_STA_DIG_ON)
-			return;
-		dm_digtable.dig_highpwr_state = DM_STA_DIG_ON;
-
-		if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
-			rtl92e_writeb(dev, (rOFDM0_XATxAFE + 3), 0x10);
-		else
-			rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x43);
-	} else {
-		if (dm_digtable.dig_highpwr_state == DM_STA_DIG_OFF)
-			return;
-		dm_digtable.dig_highpwr_state = DM_STA_DIG_OFF;
-
-		if ((priv->undecorated_smoothed_pwdb <
-		     dm_digtable.rssi_high_power_lowthresh) &&
-		    (priv->undecorated_smoothed_pwdb >=
-		    dm_digtable.rssi_high_thresh)) {
-			if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
-				rtl92e_writeb(dev, (rOFDM0_XATxAFE + 3), 0x20);
-			else
-				rtl92e_writeb(dev, rOFDM0_RxDetector1, 0x44);
-		}
-	}
-}
-
 static void _rtl92e_dm_initial_gain(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-- 
2.42.0

