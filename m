Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA677B2095
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjI1PLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjI1PLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:11:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2937919E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:11:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c1ff5b741cso117862185ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695913867; x=1696518667; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbnPHj6dfD4POVO9hdle6v6s7g3Ty0sBecHZs7nG93U=;
        b=M+BO9Xz05Xw1cg8nY1PO7GcaSBBYDolpx+u5Xx7gpSXxfRjpzSyWfZKJao/FFR1ZAr
         9a2YQEUBCFGVAi4WDzoDBJobXcjIfDUq9EXnqpZXwWzk9DnYJAwiGGkqOMrkxOVNr31Z
         EjUZvDFN18GnsVc3rETYwrhlsbA654L7PwfIzxY4rN2zVx1ZWkHR0dOOv0MhKDOA3GB8
         fGyP5tMF9bLZcIv+uRgemu0WJFSiayo/eTu1Rz02ieFMiDp+KwMt/u7+WZDwpARALRoB
         J4I/jH+tZp7dZL9MgxHtAkA0PizQDBrf//Efj9SN58QOMbA0oF5bFpn8CoIDShzUgiLX
         AxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695913867; x=1696518667;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbnPHj6dfD4POVO9hdle6v6s7g3Ty0sBecHZs7nG93U=;
        b=YRScn5EYVqWIWJtgiios9e65ZTbrfYM0efZ2cD232IHQgtwGseijLQ8nt+Oeyz0zpP
         Vg0h/7UulIFkdnd+KVJG1PvquZrFrshjbMWeJcBRwJbXiUD9tzh2mkh+ln4Fun5fkCZm
         E81aytt8ev+Lj3/E7hjuVgxMOtEDFwnqXAjurSJictAGbV7clVZjvvhlzJql2v/LJYVb
         YhqnWXjkjSOBX8R2NKq8XcuorcgOnBwdbuJH5zowKATeQ30HqmFruqvTA9nMKCWKANj9
         MQxWiWvI55QKagmM7VqDTWmrFA/MNSeUQfsxy0sZlhRbZkKkyFMiRhLU68yknYIbkuwy
         rpow==
X-Gm-Message-State: AOJu0YzLhrJi1YAtuSSbAyRvDjjhJXjRAFyAfgoRv4FhB7FAewYufQU6
        M6kaQQkrkdxV1DKNBPNQi3k=
X-Google-Smtp-Source: AGHT+IEs4QhgG0H92IolHpdmhyl40mNKQzhUZ2Szyn4G4vNJW6lSOZns0f8c4L8n5KHTG9Gwm5+9yw==
X-Received: by 2002:a17:902:c3cd:b0:1c6:7ba:3a9a with SMTP id j13-20020a170902c3cd00b001c607ba3a9amr1492806plj.14.1695913867539;
        Thu, 28 Sep 2023 08:11:07 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([122.162.35.36])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001c72f51b84asm2207951pll.52.2023.09.28.08.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:11:07 -0700 (PDT)
Date:   Thu, 28 Sep 2023 20:40:54 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: vt6655: Type encoding info dropped from
 variable name "byBBVGANew"
Message-ID: <ZRWXfqKOIXb7JqJD@ubuntu.myguest.virtualbox.org>
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

