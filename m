Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52627AB2B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjIVNaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjIVN3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:29:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC3E1BE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405101a02bcso7331645e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695389383; x=1695994183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QkdCAog+xgLVXDuxIQHdYyarWuQwp/PxNXP6mPL61iA=;
        b=FnCp4mC16FhUlXYYARpX++k3ohl9wyA6TI5hXpMWi7d/OALHs1vKXEO+76OB8G2BeR
         8jx4ZHJ9rPzm0raN4ndEmpqZyasixBML/Ojj/8v0I+U9gcMYDF9t+D3Uxw6UYunoL+QF
         M+PHe4aSVPmybe5NPGZ5x92VH3QcVh85asOEEIaEuqsb6g2BWfipkpMxBi3MbTGbnXVN
         R9qeidteJBC8CpPxsPyvj/nNTEU3027cMtqvsQPjinkixl/AedhsfiOx1J1qmhp7e8wE
         tPwtG1xanqSCKs1RWbR9ZfiAsscEfw1gX646/Xq9b6kKipHC4FBSU82HjyQ5R6l0e1PT
         3/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695389383; x=1695994183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkdCAog+xgLVXDuxIQHdYyarWuQwp/PxNXP6mPL61iA=;
        b=wbxT6q+glRJvVBdb6K7LgNRX9dEcCLRK0G/yOe7Q/KJ4GX1rB7gL4i8QfC9Q5Clgno
         73YmFcP35lSHSgVous00KzcgDG3s23TuHx2MDpjli60ZLANa1kntwZYWaUNedn3Qp43N
         +SQvoTJh5a19MtgSSi6K7siPoA4bVU2HegqA8xjT5EXbEJF3xjopOUHDbm9s56HnB1B5
         gI3Nv9geXTz3rPdz4AK2ENVj13ZQyLRhpnqE2C3m34fQXvEitnAEv4SkE+X4kIXoJHb5
         jTCBFF/Ba0EV5NOxlJPKW63X8MkhjVnI03Pp/RH7JM9CrCWFWPIafa4R9wJ21fzueFbd
         X6xw==
X-Gm-Message-State: AOJu0YzfEVb8fLAyR4hG+QDKiKy4MmEYL/PtEr7POJsnAig39vfFnA2B
        Qtk4ifD6fijHfeQrueEfpsA=
X-Google-Smtp-Source: AGHT+IFPjbiSRkd3GnqcGVlXS3FO5CvkNL2JyplN6eRYlBwsdEoRKvBene65g2Nmjk0YNSrdV8bpvQ==
X-Received: by 2002:a5d:6308:0:b0:31a:ea18:c516 with SMTP id i8-20020a5d6308000000b0031aea18c516mr7268333wru.3.1695389382946;
        Fri, 22 Sep 2023 06:29:42 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b0031ffa453affsm4468073wru.17.2023.09.22.06.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 06:29:42 -0700 (PDT)
Date:   Fri, 22 Sep 2023 15:29:41 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] staging: rtl8192e: Remove mode IW_MODE_ADHOC from
 rtl_cam.c
Message-ID: <143345585dfcc0e920b2ba5fa614f626ab3ad8ee.1695387832.git.philipp.g.hortmann@gmail.com>
References: <cover.1695387832.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695387832.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unsupported mode IW_MODE_ADHOC from rtl_cam.c.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c | 61 +++------------------
 1 file changed, 7 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index 944cc73fb2b6..14b48cacfbbd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -33,11 +33,6 @@ void rtl92e_enable_hw_security_config(struct net_device *dev)
 	     (priv->rtllib->auth_mode != 2)) {
 		SECR_value |= SCR_RxUseDK;
 		SECR_value |= SCR_TxUseDK;
-	} else if ((ieee->iw_mode == IW_MODE_ADHOC) &&
-		   (ieee->pairwise_key_type & (KEY_TYPE_CCMP |
-		   KEY_TYPE_TKIP))) {
-		SECR_value |= SCR_RxUseDK;
-		SECR_value |= SCR_TxUseDK;
 	}
 
 	ieee->hwsec_active = 1;
@@ -157,29 +152,14 @@ void rtl92e_cam_restore(struct net_device *dev)
 		}
 
 	} else if (priv->rtllib->pairwise_key_type == KEY_TYPE_TKIP) {
-		if (priv->rtllib->iw_mode == IW_MODE_ADHOC) {
-			rtl92e_set_key(dev, 4, 0,
-				       priv->rtllib->pairwise_key_type,
-				       (const u8 *)dev->dev_addr, 0,
-				       (u32 *)(&priv->rtllib->swcamtable[4].key_buf[0]));
-		} else {
-			rtl92e_set_key(dev, 4, 0,
-				       priv->rtllib->pairwise_key_type,
-				       MacAddr, 0,
-				       (u32 *)(&priv->rtllib->swcamtable[4].key_buf[0]));
-		}
-
+		rtl92e_set_key(dev, 4, 0,
+			       priv->rtllib->pairwise_key_type,
+			       MacAddr, 0,
+			       (u32 *)(&priv->rtllib->swcamtable[4].key_buf[0]));
 	} else if (priv->rtllib->pairwise_key_type == KEY_TYPE_CCMP) {
-		if (priv->rtllib->iw_mode == IW_MODE_ADHOC) {
-			rtl92e_set_key(dev, 4, 0,
-				       priv->rtllib->pairwise_key_type,
-				       (const u8 *)dev->dev_addr, 0,
-				       (u32 *)(&priv->rtllib->swcamtable[4].key_buf[0]));
-		} else {
-			rtl92e_set_key(dev, 4, 0,
-				       priv->rtllib->pairwise_key_type, MacAddr,
-				       0, (u32 *)(&priv->rtllib->swcamtable[4].key_buf[0]));
-			}
+		rtl92e_set_key(dev, 4, 0,
+			       priv->rtllib->pairwise_key_type, MacAddr,
+			       0, (u32 *)(&priv->rtllib->swcamtable[4].key_buf[0]));
 	}
 
 	if (priv->rtllib->group_key_type == KEY_TYPE_TKIP) {
@@ -192,19 +172,6 @@ void rtl92e_cam_restore(struct net_device *dev)
 					       (u32 *)(&priv->rtllib->swcamtable[EntryId].key_buf[0]));
 			}
 		}
-		if (priv->rtllib->iw_mode == IW_MODE_ADHOC) {
-			if (priv->rtllib->swcamtable[0].bused) {
-				rtl92e_set_key(dev, 0, 0,
-					       priv->rtllib->group_key_type,
-					       CAM_CONST_ADDR[0], 0,
-					       (u32 *)(&priv->rtllib->swcamtable[0].key_buf[0]));
-			} else {
-				netdev_warn(dev,
-					    "%s(): ADHOC TKIP: missing key entry.\n",
-					    __func__);
-				return;
-			}
-		}
 	} else if (priv->rtllib->group_key_type == KEY_TYPE_CCMP) {
 		MacAddr = CAM_CONST_BROAD;
 		for (EntryId = 1; EntryId < 4; EntryId++) {
@@ -215,19 +182,5 @@ void rtl92e_cam_restore(struct net_device *dev)
 					       (u32 *)(&priv->rtllib->swcamtable[EntryId].key_buf[0]));
 			}
 		}
-
-		if (priv->rtllib->iw_mode == IW_MODE_ADHOC) {
-			if (priv->rtllib->swcamtable[0].bused) {
-				rtl92e_set_key(dev, 0, 0,
-					       priv->rtllib->group_key_type,
-					       CAM_CONST_ADDR[0], 0,
-					       (u32 *)(&priv->rtllib->swcamtable[0].key_buf[0]));
-			} else {
-				netdev_warn(dev,
-					    "%s(): ADHOC CCMP: missing key entry.\n",
-					    __func__);
-				return;
-			}
-		}
 	}
 }
-- 
2.42.0

