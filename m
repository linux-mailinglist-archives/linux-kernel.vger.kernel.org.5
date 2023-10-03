Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D4C7B6B43
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbjJCOVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjJCOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:21:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B056AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:21:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5789ffc8ae0so623836a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696342886; x=1696947686; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KCc1BN5IZwIo6NJ+zmLse1l+5oCRdEzdpoksoTT54tk=;
        b=Cn3UkBvL4OszN93H7MW2QFozwllt/q3zbsqagCIsGIPUvL5yc+GEKJ4qR/Hdjfi2/E
         ikcjML4RTkX4wKbeYfDivM6uszuIoMri1dbVUfLDjW8emuNuqNM/l1XiRveda1/4vOd1
         4b3lRHWiY0b0Nq3DWfV+yPb/8lBXn9CxHfx4i3dvVWh2gdr1GbSFx8T29EmjnOxnWzC/
         ObIvHfxlawjlyt70hPmXbCMCkItvgbXkuzTtNqxpsdj98ux3vOwu45ZthI6TeN+wNNgF
         EJIQJdZ5BtO1WgQommK7LnKTiVVlS68yPAnANdIuSJrtammR8j8STrmE3vzV5obHzTl+
         MvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696342886; x=1696947686;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCc1BN5IZwIo6NJ+zmLse1l+5oCRdEzdpoksoTT54tk=;
        b=LJi1A0CnGlvcueP8hLNMrBYImdiafVMFN3d7pKMZBHdPIFDIwu74BMTACI2Y/CT6kN
         KHHeTKHly427uBqV8xMWs5HQTwfPTBhVp6nB4Ggn+Y433VEXaIyCrPOPJGjCBpCl7VR/
         OaMOcWkQD9+Ogl6Ee9PzEzHJFoEi9RFyIB9KhQ7A+BVZ+QF0yO6BiPeX+lb0aLBea5dR
         rVKi6gPS35iEBk8/F+HAPVRRrc0GP58RbfiNQYrGiAvpk2ql5jHg0sKGkkP5Opfgwx80
         RpqD1+4uB2jejG+mCfyXk9khlnS7kADwIuVGVSQKOFMztIFQFkj1BM95JL1YoV4eRvxp
         +PpQ==
X-Gm-Message-State: AOJu0Yzq8Y11fbA1euFrTUR4DKiXI1VY53wWnRcuUTlYWy7FoJmWxj8p
        fZRU6+7iV45J4n7X4p1VFgs=
X-Google-Smtp-Source: AGHT+IExX6LkzUpYg5wL2t4bbJK3cKThariNngZyxAg2VA4vp1YMK0vKYLYsUaUOhQp1h+Q8roVQJw==
X-Received: by 2002:a05:6a20:9191:b0:14d:6309:fc96 with SMTP id v17-20020a056a20919100b0014d6309fc96mr14128431pzd.4.1696342885957;
        Tue, 03 Oct 2023 07:21:25 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([171.61.192.246])
        by smtp.gmail.com with ESMTPSA id s134-20020a63778c000000b005776aeea638sm1423993pgc.21.2023.10.03.07.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:21:25 -0700 (PDT)
Date:   Tue, 3 Oct 2023 19:51:22 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Type encoding info dropped from arrary name
 "abyBBVGA" and variable names "byBBVGACurrent", "byBBVGANew"
Message-ID: <cover.1696141471.git.opensource206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset series consist of fixes to issues found by checkpatch

Pavan Bobba (3):
  staging: vt6655: Type encoding info dropped from array name "abyBBVGA"
  staging: vt6655: Type encoding info dropped from variable name
    "byBBVGACurrent"
  staging: vt6655: Type encoding info dropped from variable name
    "byBBVGANew"

 drivers/staging/vt6655/baseband.c    | 40 ++++++++++++++--------------
 drivers/staging/vt6655/channel.c     |  6 ++---
 drivers/staging/vt6655/device.h      |  6 ++---
 drivers/staging/vt6655/device_main.c | 24 ++++++++---------
 4 files changed, 38 insertions(+), 38 deletions(-)

-- 
2.34.1

From 6894dff7cc5a780627e0335e8f5cdc8b353eea53 Mon Sep 17 00:00:00 2001
Message-Id: <6894dff7cc5a780627e0335e8f5cdc8b353eea53.1696141471.git.opensource206@gmail.com>
In-Reply-To: <cover.1696141471.git.opensource206@gmail.com>
References: <cover.1696141471.git.opensource206@gmail.com>
From: Pavan Bobba <opensource206@gmail.com>
Date: Thu, 28 Sep 2023 18:27:27 +0530
Subject: [PATCH v4 1/3] staging: vt6655: Type encoding info dropped
 from array name "abyBBVGA"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-staging@lists.linux.dev,linux-kernel@vger.kernel.org

array name "abyBBVGA" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
v1 -> v2 : 1.cover letter added
           2.patches sent as attachments in a single mail for review

v2 -> v3 : patches sending in a series intead of attachments

v3 -> v4 : version info updated in patchset subject

 drivers/staging/vt6655/baseband.c    | 38 ++++++++++++++--------------
 drivers/staging/vt6655/channel.c     |  4 +--
 drivers/staging/vt6655/device.h      |  2 +-
 drivers/staging/vt6655/device_main.c |  8 +++---
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 0ae2ab3987c6..a19a75f5d761 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2016,10 +2016,10 @@ bool bb_vt3253_init(struct vnt_private *priv)
 			iowrite32(0x23, iobase + MAC_REG_ITRTMSET);
 			vt6655_mac_reg_bits_on(iobase, MAC_REG_PAPEDELAY, BIT(0));
 		}
-		priv->abyBBVGA[0] = 0x18;
-		priv->abyBBVGA[1] = 0x0A;
-		priv->abyBBVGA[2] = 0x0;
-		priv->abyBBVGA[3] = 0x0;
+		priv->bbvga[0] = 0x18;
+		priv->bbvga[1] = 0x0A;
+		priv->bbvga[2] = 0x0;
+		priv->bbvga[3] = 0x0;
 		priv->dbm_threshold[0] = -70;
 		priv->dbm_threshold[1] = -50;
 		priv->dbm_threshold[2] = 0;
@@ -2034,10 +2034,10 @@ bool bb_vt3253_init(struct vnt_private *priv)
 			result &= bb_write_embedded(priv,
 				vt3253b0_agc[ii][0], vt3253b0_agc[ii][1]);
 
-		priv->abyBBVGA[0] = 0x1C;
-		priv->abyBBVGA[1] = 0x10;
-		priv->abyBBVGA[2] = 0x0;
-		priv->abyBBVGA[3] = 0x0;
+		priv->bbvga[0] = 0x1C;
+		priv->bbvga[1] = 0x10;
+		priv->bbvga[2] = 0x0;
+		priv->bbvga[3] = 0x0;
 		priv->dbm_threshold[0] = -70;
 		priv->dbm_threshold[1] = -48;
 		priv->dbm_threshold[2] = 0;
@@ -2056,10 +2056,10 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		iowrite8(0x23, iobase + MAC_REG_ITRTMSET);
 		vt6655_mac_reg_bits_on(iobase, MAC_REG_PAPEDELAY, BIT(0));
 
-		priv->abyBBVGA[0] = 0x14;
-		priv->abyBBVGA[1] = 0x0A;
-		priv->abyBBVGA[2] = 0x0;
-		priv->abyBBVGA[3] = 0x0;
+		priv->bbvga[0] = 0x14;
+		priv->bbvga[1] = 0x0A;
+		priv->bbvga[2] = 0x0;
+		priv->bbvga[3] = 0x0;
 		priv->dbm_threshold[0] = -60;
 		priv->dbm_threshold[1] = -50;
 		priv->dbm_threshold[2] = 0;
@@ -2074,10 +2074,10 @@ bool bb_vt3253_init(struct vnt_private *priv)
 			result &= bb_write_embedded(priv,
 				vt3253b0_agc[ii][0], vt3253b0_agc[ii][1]);
 
-		priv->abyBBVGA[0] = 0x1C;
-		priv->abyBBVGA[1] = 0x10;
-		priv->abyBBVGA[2] = 0x0;
-		priv->abyBBVGA[3] = 0x0;
+		priv->bbvga[0] = 0x1C;
+		priv->bbvga[1] = 0x10;
+		priv->bbvga[2] = 0x0;
+		priv->bbvga[3] = 0x0;
 		priv->dbm_threshold[0] = -70;
 		priv->dbm_threshold[1] = -48;
 		priv->dbm_threshold[2] = 0;
@@ -2088,7 +2088,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 	} else {
 		/* No VGA Table now */
 		priv->bUpdateBBVGA = false;
-		priv->abyBBVGA[0] = 0x1C;
+		priv->bbvga[0] = 0x1C;
 	}
 
 	if (by_local_id > REV_ID_VT3253_A1) {
@@ -2126,7 +2126,7 @@ bb_set_short_slot_time(struct vnt_private *priv)
 
 	/* patch for 3253B0 Baseband with Cardbus module */
 	bb_read_embedded(priv, 0xE7, &by_bb_vga);
-	if (by_bb_vga == priv->abyBBVGA[0])
+	if (by_bb_vga == priv->bbvga[0])
 		by_bb_rx_conf |= 0x20; /* 0010 0000 */
 
 	bb_write_embedded(priv, 0x0A, by_bb_rx_conf); /* CR10 */
@@ -2140,7 +2140,7 @@ void bb_set_vga_gain_offset(struct vnt_private *priv, unsigned char by_data)
 
 	bb_read_embedded(priv, 0x0A, &by_bb_rx_conf); /* CR10 */
 	/* patch for 3253B0 Baseband with Cardbus module */
-	if (by_data == priv->abyBBVGA[0])
+	if (by_data == priv->bbvga[0])
 		by_bb_rx_conf |= 0x20; /* 0010 0000 */
 	else if (priv->short_slot_time)
 		by_bb_rx_conf &= 0xDF; /* 1101 1111 */
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index e90e0b43505d..e20701815db9 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -87,8 +87,8 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 
 	/* Set VGA to max sensitivity */
 	if (priv->bUpdateBBVGA &&
-	    priv->byBBVGACurrent != priv->abyBBVGA[0]) {
-		priv->byBBVGACurrent = priv->abyBBVGA[0];
+	    priv->byBBVGACurrent != priv->bbvga[0]) {
+		priv->byBBVGACurrent = priv->bbvga[0];
 
 		bb_set_vga_gain_offset(priv, priv->byBBVGACurrent);
 	}
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 8c90539cc3d7..b662c74a2dc7 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -250,7 +250,7 @@ struct vnt_private {
 	unsigned int	uBBVGADiffCount;
 	unsigned char byBBVGANew;
 	unsigned char byBBVGACurrent;
-	unsigned char abyBBVGA[BB_VGA_LEVEL];
+	unsigned char bbvga[BB_VGA_LEVEL];
 	long                    dbm_threshold[BB_VGA_LEVEL];
 
 	unsigned char byBBPreEDRSSI;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index f76f482f4c06..385848df8848 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -424,9 +424,9 @@ static void device_init_registers(struct vnt_private *priv)
 	bb_vt3253_init(priv);
 
 	if (priv->bUpdateBBVGA) {
-		priv->byBBVGACurrent = priv->abyBBVGA[0];
+		priv->byBBVGACurrent = priv->bbvga[0];
 		priv->byBBVGANew = priv->byBBVGACurrent;
-		bb_set_vga_gain_offset(priv, priv->abyBBVGA[0]);
+		bb_set_vga_gain_offset(priv, priv->bbvga[0]);
 	}
 
 	bb_set_rx_antenna_mode(priv, priv->byRxAntennaMode);
@@ -1053,7 +1053,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 
 	for (i = 0; i < BB_VGA_LEVEL; i++) {
 		if (dbm < priv->dbm_threshold[i]) {
-			priv->byBBVGANew = priv->abyBBVGA[i];
+			priv->byBBVGANew = priv->bbvga[i];
 			break;
 		}
 	}
@@ -1510,7 +1510,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 			priv->short_slot_time = false;
 
 		CARDbSetPhyParameter(priv, priv->byBBType);
-		bb_set_vga_gain_offset(priv, priv->abyBBVGA[0]);
+		bb_set_vga_gain_offset(priv, priv->bbvga[0]);
 	}
 
 	if (changed & BSS_CHANGED_TXPOWER)
-- 
2.34.1

From d40eb60e6cccf2b5432904abb74bc009fac5e2e1 Mon Sep 17 00:00:00 2001
Message-Id: <d40eb60e6cccf2b5432904abb74bc009fac5e2e1.1696141471.git.opensource206@gmail.com>
In-Reply-To: <cover.1696141471.git.opensource206@gmail.com>
References: <cover.1696141471.git.opensource206@gmail.com>
From: Pavan Bobba <opensource206@gmail.com>
Date: Thu, 28 Sep 2023 20:26:02 +0530
Subject: [PATCH v4 2/3] staging: vt6655: Type encoding info dropped
 from variable name "byBBVGACurrent"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-staging@lists.linux.dev,linux-kernel@vger.kernel.org

variable name "byBBVGACurrent" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
v1 -> v2 : 1.cover letter added
           2.patches sent as attachments in a single mail for review

v2 -> v3 : patches sending in a series intead of attachments

v3 -> v4 : version info updated in patchset subject
 
 drivers/staging/vt6655/baseband.c    |  2 +-
 drivers/staging/vt6655/channel.c     |  6 +++---
 drivers/staging/vt6655/device.h      |  2 +-
 drivers/staging/vt6655/device_main.c | 10 +++++-----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index a19a75f5d761..7d47b266b87e 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2146,7 +2146,7 @@ void bb_set_vga_gain_offset(struct vnt_private *priv, unsigned char by_data)
 		by_bb_rx_conf &= 0xDF; /* 1101 1111 */
 	else
 		by_bb_rx_conf |= 0x20; /* 0010 0000 */
-	priv->byBBVGACurrent = by_data;
+	priv->bbvga_current = by_data;
 	bb_write_embedded(priv, 0x0A, by_bb_rx_conf); /* CR10 */
 }
 
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index e20701815db9..6ac7d470c041 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -87,10 +87,10 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 
 	/* Set VGA to max sensitivity */
 	if (priv->bUpdateBBVGA &&
-	    priv->byBBVGACurrent != priv->bbvga[0]) {
-		priv->byBBVGACurrent = priv->bbvga[0];
+	    priv->bbvga_current != priv->bbvga[0]) {
+		priv->bbvga_current = priv->bbvga[0];
 
-		bb_set_vga_gain_offset(priv, priv->byBBVGACurrent);
+		bb_set_vga_gain_offset(priv, priv->bbvga_current);
 	}
 
 	/* clear NAV */
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index b662c74a2dc7..9ae7171d02ee 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -249,7 +249,7 @@ struct vnt_private {
 	bool bUpdateBBVGA;
 	unsigned int	uBBVGADiffCount;
 	unsigned char byBBVGANew;
-	unsigned char byBBVGACurrent;
+	unsigned char bbvga_current;
 	unsigned char bbvga[BB_VGA_LEVEL];
 	long                    dbm_threshold[BB_VGA_LEVEL];
 
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 385848df8848..6990129ceb10 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -424,8 +424,8 @@ static void device_init_registers(struct vnt_private *priv)
 	bb_vt3253_init(priv);
 
 	if (priv->bUpdateBBVGA) {
-		priv->byBBVGACurrent = priv->bbvga[0];
-		priv->byBBVGANew = priv->byBBVGACurrent;
+		priv->bbvga_current = priv->bbvga[0];
+		priv->byBBVGANew = priv->bbvga_current;
 		bb_set_vga_gain_offset(priv, priv->bbvga[0]);
 	}
 
@@ -1058,7 +1058,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 		}
 	}
 
-	if (priv->byBBVGANew == priv->byBBVGACurrent) {
+	if (priv->byBBVGANew == priv->bbvga_current) {
 		priv->uBBVGADiffCount = 1;
 		return;
 	}
@@ -1072,7 +1072,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 		dev_dbg(&priv->pcid->dev,
 			"First RSSI[%d] NewGain[%d] OldGain[%d] Count[%d]\n",
 			(int)dbm, priv->byBBVGANew,
-			priv->byBBVGACurrent,
+			priv->bbvga_current,
 			(int)priv->uBBVGADiffCount);
 	}
 
@@ -1080,7 +1080,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 		dev_dbg(&priv->pcid->dev,
 			"RSSI[%d] NewGain[%d] OldGain[%d] Count[%d]\n",
 			(int)dbm, priv->byBBVGANew,
-			priv->byBBVGACurrent,
+			priv->bbvga_current,
 			(int)priv->uBBVGADiffCount);
 
 		bb_set_vga_gain_offset(priv, priv->byBBVGANew);
-- 
2.34.1

From e7dc405ffa8050eb8693086204c902a723392a62 Mon Sep 17 00:00:00 2001
Message-Id: <e7dc405ffa8050eb8693086204c902a723392a62.1696141471.git.opensource206@gmail.com>
In-Reply-To: <cover.1696141471.git.opensource206@gmail.com>
References: <cover.1696141471.git.opensource206@gmail.com>
From: Pavan Bobba <opensource206@gmail.com>
Date: Thu, 28 Sep 2023 20:30:34 +0530
Subject: [PATCH v4 3/3] staging: vt6655: Type encoding info dropped
 from variable name "byBBVGANew"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-staging@lists.linux.dev,linux-kernel@vger.kernel.org

variable name "byBBVGANew" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
v1 -> v2 : 1.cover letter added
           2.patches sent as attachments in a single mail for review

v2 -> v3 : patches sending in a series intead of attachments

v3 -> v4 : version info updated in patchset subject
 
 drivers/staging/vt6655/device.h      |  2 +-
 drivers/staging/vt6655/device_main.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 9ae7171d02ee..68bfadacfa7c 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -248,7 +248,7 @@ struct vnt_private {
 	/* For Update BaseBand VGA Gain Offset */
 	bool bUpdateBBVGA;
 	unsigned int	uBBVGADiffCount;
-	unsigned char byBBVGANew;
+	unsigned char bbvga_new;
 	unsigned char bbvga_current;
 	unsigned char bbvga[BB_VGA_LEVEL];
 	long                    dbm_threshold[BB_VGA_LEVEL];
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 6990129ceb10..b08fcf7e6edc 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -425,7 +425,7 @@ static void device_init_registers(struct vnt_private *priv)
 
 	if (priv->bUpdateBBVGA) {
 		priv->bbvga_current = priv->bbvga[0];
-		priv->byBBVGANew = priv->bbvga_current;
+		priv->bbvga_new = priv->bbvga_current;
 		bb_set_vga_gain_offset(priv, priv->bbvga[0]);
 	}
 
@@ -1053,12 +1053,12 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 
 	for (i = 0; i < BB_VGA_LEVEL; i++) {
 		if (dbm < priv->dbm_threshold[i]) {
-			priv->byBBVGANew = priv->bbvga[i];
+			priv->bbvga_new = priv->bbvga[i];
 			break;
 		}
 	}
 
-	if (priv->byBBVGANew == priv->bbvga_current) {
+	if (priv->bbvga_new == priv->bbvga_current) {
 		priv->uBBVGADiffCount = 1;
 		return;
 	}
@@ -1067,11 +1067,11 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 
 	if (priv->uBBVGADiffCount == 1) {
 		/* first VGA diff gain */
-		bb_set_vga_gain_offset(priv, priv->byBBVGANew);
+		bb_set_vga_gain_offset(priv, priv->bbvga_new);
 
 		dev_dbg(&priv->pcid->dev,
 			"First RSSI[%d] NewGain[%d] OldGain[%d] Count[%d]\n",
-			(int)dbm, priv->byBBVGANew,
+			(int)dbm, priv->bbvga_new,
 			priv->bbvga_current,
 			(int)priv->uBBVGADiffCount);
 	}
@@ -1079,11 +1079,11 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 	if (priv->uBBVGADiffCount >= BB_VGA_CHANGE_THRESHOLD) {
 		dev_dbg(&priv->pcid->dev,
 			"RSSI[%d] NewGain[%d] OldGain[%d] Count[%d]\n",
-			(int)dbm, priv->byBBVGANew,
+			(int)dbm, priv->bbvga_new,
 			priv->bbvga_current,
 			(int)priv->uBBVGADiffCount);
 
-		bb_set_vga_gain_offset(priv, priv->byBBVGANew);
+		bb_set_vga_gain_offset(priv, priv->bbvga_new);
 	}
 }
 
-- 
2.34.1

