Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3073B7BCBAD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 04:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbjJHCLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 22:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344297AbjJHCLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 22:11:19 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB68E9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 19:11:18 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79f909071c3so145882439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 19:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696731077; x=1697335877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXHgrXhZFzgapXNvMU3dUuHbHovI6TQ/QGyf0MdOP1Q=;
        b=gfYdW/xYx++7aci5+X53Z/8v5IMLDrt/GapHd27OcrA/X7YGBGGNWKf9ffxglhaPm7
         pnx1PcQnD4TUvVk9V16gApNO7+Vvv7YxPr2dh8MBcMKdVGzG67FwWH7+CSUGftyGLfzX
         YXSioRDa4dXotYV9uo8DwYRRQzAjrA4EBSNpQ+wcXjYEDVGICpteYk7Fogcgu2NxedQE
         LPY+d8sx83Xj7W74/SJBKAz+LHvQcHXljFROPrssNCD3yhEv/HjUREp0xX8s+JshBikQ
         g3qCKyzxheqJXdsTgujyP1T7AWG/RlaojBAv0JAP/qHl0TztHqq2CQjNeuQVNv8Ls8j0
         jBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696731077; x=1697335877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXHgrXhZFzgapXNvMU3dUuHbHovI6TQ/QGyf0MdOP1Q=;
        b=FdvHzaDzoklq5tstwgubK3uWgYiVSvnAVGvYXwQVSqNMp7wiSkBUs8QguXmqUcs40e
         dpsMIL1Eg3jwPO574K26m07MQLwZcEMFql0O2iEnAUE1g2Laz3wO3paY3H7j7W4uMagG
         h66bV+6j03VRNzEgYSN1yUfNepMG7uhHv7gX5X8RQ61ppIVjVbhVbCyoqUdTB10u1iZz
         sy2h6cFzOwczwK2LXj+ORNg3W2VOP29zkxJMRcc5GX6YVimL1E1pyQ409w2LO8bLprEY
         1HmgVRwe+ToEDaNCTdLXEtBMOZoH3Nus5N3fZzj0us/bN59XF51aFpUqbWfgT1YGGT3s
         OE+Q==
X-Gm-Message-State: AOJu0Yx8Bw4gsDlMEJ4JraZyzwVSj3OzAz1bypSGWcElszSIU6vE/IGg
        Vn+Xl4czAupssikmMIg+QOXZ1Ga7R0k=
X-Google-Smtp-Source: AGHT+IGn9RTWMsfxsnp6EnAnErexE1tZ7hMbJXXNYaPVtDuC/hUmU6I3AcRxCVlpkrnquAcMNpyGBw==
X-Received: by 2002:a05:6e02:1786:b0:351:22a2:bbe7 with SMTP id y6-20020a056e02178600b0035122a2bbe7mr17345623ilu.0.1696731077580;
        Sat, 07 Oct 2023 19:11:17 -0700 (PDT)
Received: from ubuntu.. ([223.178.246.252])
        by smtp.gmail.com with ESMTPSA id x8-20020aa784c8000000b00690fdeb5c0dsm3746125pfn.2.2023.10.07.19.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 19:11:17 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Pavan Bobba <pavanbobba206@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH
Date:   Sun,  8 Oct 2023 07:40:54 +0530
Message-Id: <d40eb60e6cccf2b5432904abb74bc009fac5e2e1.1696729776.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696729776.git.opensource206@gmail.com>
References: <cover.1696729776.git.opensource206@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable name "byBBVGACurrent" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
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

