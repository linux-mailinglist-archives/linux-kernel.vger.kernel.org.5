Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE107C880C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjJMOo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjJMOoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:44:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37353C9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:44:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40651b22977so5492125e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697208259; x=1697813059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R65tSR19h2ERSFEN/PYuOVhJkp4kEom7jNZNDOgm2Dw=;
        b=bPyns9HJZ8LzVjZbVF6AV0LSRiY1aIiSuNxqsoqUYzJOtxJot51Y+OJJEyUAhNwFTp
         8TLvxRumhNGo0kdjUzboyrErwFrzHx7pb3oSHh00G2u6O6xSdZQvWJ8b5BhnUlaUNb0u
         cU3Op11Xiq21mvnnyxT9hOXPuUI/7Uc5+bkqG0jmBVMx8tmgsgknVEaeFQ5e5bCbtY6H
         8tpWMBvSps6Vr3tx50EUcLE+19wLeJv2UZXDqa85V6qZL7I3u7bBKWXogLrn5XXrFhva
         FxxdEs82gy6/isN93j/oe9G8vXunxAy4GGbDrgqbMtfi6f88r498JWYoEosNEjkmZfgh
         9tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697208259; x=1697813059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R65tSR19h2ERSFEN/PYuOVhJkp4kEom7jNZNDOgm2Dw=;
        b=C1E8YJ7v3TIN8ro6zf6u0/iN+q3DY+WjUJsMnl8lvLeSbQeaB4vhOADVR4jUK4/bWK
         JVxXtX2EWLtHDP4fDmEtuJzgn6rIEmxSQjR6CnJI0Se/EzHih4VvzVBLrTJOQ4/jpyle
         955Nu6y44bWTEJoDf8jI7Ss7c5JqYTRjjmwNl+o+/Hkd7jBslr/4K9dCwZSlBaQ/QGMr
         MYFSeouGWtA8h+tQYXY4xkuw+NqzhmpUzcT2vQoAVz4z69ZTx0R91bpWgL9wZkG0Lc8X
         yB3zv4HakRhN3JWl57ASEC7cgpFyEGPlH4Z87yQUCepWZvMs2ZBbpOUQSjTpgCnQXObp
         S71Q==
X-Gm-Message-State: AOJu0YyKY3SP2X0TybXhp7NS7cLPVd8MzmU0owAzuDztSbjbyCRQlRc1
        Onc6gC5fmWq3wx4kLsFAPDk=
X-Google-Smtp-Source: AGHT+IHYPPr6sH0xTh0JgXu27oRZb4vGWPHKDgwKcIcRqvksiJGAB2sO6wYI4wLMOxfcZ4Mm+JGSGQ==
X-Received: by 2002:adf:8b54:0:b0:32d:9a32:6261 with SMTP id v20-20020adf8b54000000b0032d9a326261mr1801911wra.7.1697208259367;
        Fri, 13 Oct 2023 07:44:19 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id dh13-20020a0560000a8d00b00327cd5e5ac1sm6402480wrb.1.2023.10.13.07.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:44:19 -0700 (PDT)
Date:   Fri, 13 Oct 2023 16:44:17 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] staging: rtl8192e: Remove unused variable dig_state
Message-ID: <7bacd7e152a2d044527924d57efdbbaae0f4c9e8.1697127817.git.philipp.g.hortmann@gmail.com>
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

Remove variable dig_state as it is unused. Remove unused variable
dig_highpwr_state as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 3 ---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 0bd9211500ac..97de404840df 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -911,8 +911,6 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	dm_digtable.dig_state		= DM_STA_DIG_MAX;
-	dm_digtable.dig_highpwr_state	= DM_STA_DIG_MAX;
 	dm_digtable.cur_sta_connect_state = DIG_STA_DISCONNECT;
 	dm_digtable.pre_sta_connect_state = DIG_STA_DISCONNECT;
 
@@ -964,7 +962,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
 		for (i = 0; i < 3; i++)
 			rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x8);
 		fw_dig++;
-		dm_digtable.dig_state = DM_STA_DIG_OFF;
 	}
 
 	if (priv->rtllib->link_state == MAC80211_LINKED)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 12b7d426b6b9..80ac77e269fd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -56,8 +56,6 @@ struct dig_t {
 	long		rssi_high_power_lowthresh;
 	long		rssi_high_power_highthresh;
 
-	u8		dig_state;
-	u8		dig_highpwr_state;
 	u8		cur_sta_connect_state;
 	u8		pre_sta_connect_state;
 
-- 
2.42.0

