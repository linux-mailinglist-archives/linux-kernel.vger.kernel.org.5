Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E723D7C880E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjJMOoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjJMOoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:44:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798AFBE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:44:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3232e96deaaso433220f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697208239; x=1697813039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8MB7xPzHf04XyceB1JLxAP8TnhpBNOxPI35yzUOf6A=;
        b=QWCbTh31BZXVvwinJfIiDJMm76W3dm2rjieMMhl1dLm9ywjfVouoOicnu907WJwzRZ
         kc0CXqSPh1fhBEbHmmGtuZSW8VBRx3BQShngqQUOs2B6AA2mGOtGW4m1WhCY1xgVRBpW
         yLKt1granhERx84nA9SNkr3evudLFPs/V4I4Ju7Iwooa+rQHCcTFlLGRNu1zU+eE4PFd
         h5I69g5nxH/lOtNRxwTo1GVhMj33ZsXoqiDALfO+olClRPhJ5+zx2TsFrkZIClXq0RHI
         yY7KZJTTZNMxk9M7dJOfQNLDEwXtB1Gcbo+ipz+q2F8U/Z+OnpIX++nrMtK8ZLUU2zf6
         /ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697208239; x=1697813039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8MB7xPzHf04XyceB1JLxAP8TnhpBNOxPI35yzUOf6A=;
        b=H2z3UrWMvoLsvbf9eJ9wL5KBoG7a2L/fnA2hBkltTB/biGgbk5a8AS/kj6p2oECeSH
         DEaxFsWM4wz5spH0wOcd8RUvGiwi1PVnbMgm5/1FJANmKqMSVeVa8Yj8uLzPZAmJ6y3d
         wFGStsJ9D9MUSBHX60p5b3LemN9Lz3mNKZY4dqQWD0dSIhc2UTnDV3RznEVWG5gYukxP
         DC/zjyshvi/U6E5GOEt6Is4i5LNIDV7uFx7niF2m49WLkZKysYp2U1vjw0cOeOno9tIH
         nKM0MX9DZM6lVckAP3JapBQgDeQyzVBOBmlRff/4Arjo2cwtGnnab33OHbT4yFB2l3aN
         LPBQ==
X-Gm-Message-State: AOJu0YzUo/7+gaRoc+OiA9HwqIViAIlQfVuRFeZOOjnSp4vtLUQPtM1p
        wFoqAISvuoOnBa7z+RIoW53RGNhl1Dw=
X-Google-Smtp-Source: AGHT+IEb9FEF2/ovxsr3Xtts6ZNg+IzB3L73Po3QSFmFUm6EynuuiaLoxiaVJz/+Ezvqx9mCF6KN/g==
X-Received: by 2002:adf:cf0a:0:b0:31a:e54e:c790 with SMTP id o10-20020adfcf0a000000b0031ae54ec790mr23130655wrj.6.1697208238545;
        Fri, 13 Oct 2023 07:43:58 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id h12-20020a056000000c00b003176aa612b1sm20911022wrx.38.2023.10.13.07.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:43:58 -0700 (PDT)
Date:   Fri, 13 Oct 2023 16:43:56 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] staging: rtl8192e: Remove unchanged variable
 dig_algorithm
Message-ID: <66f7275aa46e68577cc4c20582ffbd16de13f470.1697127817.git.philipp.g.hortmann@gmail.com>
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

Remove variable dig_algorithm as its value is set to DIG_ALGO_BY_RSSI at
initialization. No further writes to dig_algorithm are done. The
equations result accordingly. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 11 -----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     |  9 +--------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h     |  1 -
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 875540a2079d..bc06c2cab35d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -920,9 +920,6 @@ void rtl92e_init_gain(struct net_device *dev, u8 Operation)
 		case IG_Backup:
 			initial_gain = SCAN_RX_INITIAL_GAIN;
 			BitMask = bMaskByte0;
-			if (dm_digtable.dig_algorithm ==
-			    DIG_ALGO_BY_FALSE_ALARM)
-				rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x8);
 			priv->initgain_backup.xaagccore1 =
 				 rtl92e_get_bb_reg(dev, rOFDM0_XAAGCCore1,
 						   BitMask);
@@ -947,10 +944,6 @@ void rtl92e_init_gain(struct net_device *dev, u8 Operation)
 			break;
 		case IG_Restore:
 			BitMask = 0x7f;
-			if (dm_digtable.dig_algorithm ==
-			    DIG_ALGO_BY_FALSE_ALARM)
-				rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x8);
-
 			rtl92e_set_bb_reg(dev, rOFDM0_XAAGCCore1, BitMask,
 					 (u32)priv->initgain_backup.xaagccore1);
 			rtl92e_set_bb_reg(dev, rOFDM0_XBAGCCore1, BitMask,
@@ -965,10 +958,6 @@ void rtl92e_init_gain(struct net_device *dev, u8 Operation)
 
 			rtl92e_set_tx_power(dev,
 					 priv->rtllib->current_network.channel);
-
-			if (dm_digtable.dig_algorithm ==
-			    DIG_ALGO_BY_FALSE_ALARM)
-				rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x1);
 			break;
 		}
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index bbd18b6cc252..2bbc6a67188c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -913,8 +913,6 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	dm_digtable.dig_algorithm = DIG_ALGO_BY_RSSI;
-
 	dm_digtable.dig_algorithm_switch = 0;
 
 	dm_digtable.dig_state		= DM_STA_DIG_MAX;
@@ -939,12 +937,7 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
 
 static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev)
 {
-	if (dm_digtable.dig_algorithm == DIG_ALGO_BY_FALSE_ALARM)
-		_rtl92e_dm_ctrl_initgain_byrssi_false_alarm(dev);
-	else if (dm_digtable.dig_algorithm == DIG_ALGO_BY_RSSI)
-		_rtl92e_dm_ctrl_initgain_byrssi_driver(dev);
-	else
-		return;
+	_rtl92e_dm_ctrl_initgain_byrssi_driver(dev);
 }
 
 /*-----------------------------------------------------------------------------
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index faf08763c340..15af490d2dcd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -50,7 +50,6 @@
 
 /*------------------------------Define structure----------------------------*/
 struct dig_t {
-	u8		dig_algorithm;
 	u8		dig_algorithm_switch;
 
 	long		rssi_low_thresh;
-- 
2.42.0

