Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3919C7B6B27
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbjJCOPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238344AbjJCOPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:15:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DAFD8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:15:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso7139185ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696342510; x=1696947310; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9v+iNE+u9bTRsIJyBuaCBXHWod9RBfcVVCIhChQsSk=;
        b=m/8qI3pUrNyJ/Vbkp46G10EIhNYE1IMstWVOmCwE/1W31wIw5Q1pzZ6sKH7m4cGv+i
         1z3jAHARt0v7A8J5slTRqFDjHOcNL/ZeW2aYwqxJpmF2ky/Tqxgrdh8JmO8B1ng3fAyj
         En9EoDSsMmPXiI/WeG/xYZkE5RKLgyHZdtIwOIQNXlqSQphU8dwO0nqpXALnZIHZyPea
         FU02vjHDiM5TbhIr9b0Z7lcyXKJyp2rLVHGnfZ880bmJd7YQr0Oo5BAoMVaKEyNPHRuV
         Vx440LO21TUbw1eS8EuPNkVMlIJ9o5VV4emiz18NtlGGcl1wzuPIJrWtA5QVH8UP/UUz
         lYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696342510; x=1696947310;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9v+iNE+u9bTRsIJyBuaCBXHWod9RBfcVVCIhChQsSk=;
        b=k2YoaZ3VnjU/DTSH3oCH1MwGKfXUWIt/PhMvqJ0FysAfydMJeXtbw0N7cv1doMwFkS
         c8+UtICiAbVAh7492N5W6EsFn7TYtNcZsUKtMTRiWlJyC94deC6qt3nHRm/NunzdtWxy
         JC4CidrLHTmhydqZTInq4oAgJ75vl5UkTkdHVksZuZFDTb0juIR/HPn00Ibdnn7YewT7
         B3hjgplq4CI2XUS7Jw8XH3dNXu1lWMA/w1w3+PeC6tnVhpCjfeTg7ypkdSmkAX0OH2wm
         z5uH1WpbFcF3hYyjRDeQ2DWcl0zUoGe4xoqVJ3bkhH6R+jsYMUSg2arto/PCMaMCP9Oq
         LChQ==
X-Gm-Message-State: AOJu0YyxIG2U48nM+lsonunrqAxCcnJRJERnvIqUrzxZMkB4QjbdWjfh
        HCOLjVrwj3eL5b8J3Bk4oIA=
X-Google-Smtp-Source: AGHT+IHxs5/BDTDUaITAY4AW0OV0U7AvIco1R2HMkxVBRStEDvAJEe2sVSVy4igVSEDSTwwyZbyMNg==
X-Received: by 2002:a17:902:db0c:b0:1c3:308b:ecb9 with SMTP id m12-20020a170902db0c00b001c3308becb9mr13528238plx.11.1696342510055;
        Tue, 03 Oct 2023 07:15:10 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([171.61.192.246])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902e99200b001c5f77e23a8sm1605803plb.73.2023.10.03.07.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:15:09 -0700 (PDT)
Date:   Tue, 3 Oct 2023 19:45:06 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Type encoding info dropped from arrary name
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
Subject: [PATCH 1/3] [PATCH 1/3] staging: vt6655: Type encoding info dropped
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
Subject: [PATCH 2/3] [PATCH 2/3] staging: vt6655: Type encoding info dropped
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
Subject: [PATCH 3/3] [PATCH 3/3] staging: vt6655: Type encoding info dropped
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

