Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C97BCBAA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 04:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344341AbjJHCL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 22:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344339AbjJHCLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 22:11:22 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93595E4
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 19:11:20 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3525e6dc5dfso13647875ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 19:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696731080; x=1697335880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbnPHj6dfD4POVO9hdle6v6s7g3Ty0sBecHZs7nG93U=;
        b=XNO3/Np7EWbiKpmBfZyqn9im2ibIkz1U/+pj9bWtdGog8xZ6o2Fhquw82HlJu83d7U
         qciV2Oy/h1eeKjKT9q1bObfhKZkEt/+fpEoVUTHsqf7d3Mg8iNIl9Xg73FT4SX/m/zQn
         3AYXXyxA7jNImrXiJsgucn81641iTVM3ERj9xPaD5pN+7E1bOb++cvfpHqff+4mTtpmi
         1EDMUQ06nKz6WyLT9546dr88Qv6jhaox4r7wRQa+IgRcsDWLFVpa/iA+MjGnzrXV3U3u
         SZrLqhj+ZcNfj3XmumcuR0a7t0kH1MqBo++ekn4fHtKlI2H0OJbSaYUn4mOBtCSNfaCm
         ywwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696731080; x=1697335880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbnPHj6dfD4POVO9hdle6v6s7g3Ty0sBecHZs7nG93U=;
        b=ZWnUUCH9rFOM/2HU/adGY583A/KZawz18/OZW0ToWZl8i29m3XB3GXhH7BdcV/ulVx
         Ki+lq4Y/dUUI09qUHfSUzpS+wsxEwHgjU3jdW/VHw3Ocrb2CbjF2YJzSwAAmYk/5Iy7n
         YvFrLJZWx4J5a6TqlpadLlOFmdHeu8j4s33o6B2TO5EuDxeIwDQnCTO6lFr04ec95OXx
         T/RewpI0hl72aPVGXnuBbRTMVPSFZMRcu5z3jknEjkzP7wltKHVCWnOf0ywfiOMr22L+
         PuthxUnn1YodbjCaes/IEGFuZ0Wp6azztD907putbxDh0yTGStCHgnq0jYGIuwq5Q6gs
         DlUA==
X-Gm-Message-State: AOJu0YxSSz9BzB0AfIwqXQT9w5VxWyfJ5DgxOHnRpdeyxiLFSJP1MyMY
        p9oUx4/NETQn3UHWzAdJHds=
X-Google-Smtp-Source: AGHT+IF1fg42gRk2D/9js+L+MQbF1lgNaOSnLSGB8BsY+P6pBsEo1vzpDZjud13AIAAqame94hYmgA==
X-Received: by 2002:a05:6e02:12e3:b0:34d:ff6c:3e22 with SMTP id l3-20020a056e0212e300b0034dff6c3e22mr16419973iln.20.1696731079799;
        Sat, 07 Oct 2023 19:11:19 -0700 (PDT)
Received: from ubuntu.. ([223.178.246.252])
        by smtp.gmail.com with ESMTPSA id x8-20020aa784c8000000b00690fdeb5c0dsm3746125pfn.2.2023.10.07.19.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 19:11:19 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Pavan Bobba <pavanbobba206@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH
Date:   Sun,  8 Oct 2023 07:40:55 +0530
Message-Id: <e7dc405ffa8050eb8693086204c902a723392a62.1696729776.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696729776.git.opensource206@gmail.com>
References: <cover.1696729776.git.opensource206@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable name "byBBVGANew" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
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

