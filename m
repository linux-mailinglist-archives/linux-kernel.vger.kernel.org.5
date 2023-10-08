Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E637BCFB7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 21:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344573AbjJHTCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 15:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbjJHTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 15:02:14 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0435DC5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 12:02:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d865854ef96so4016559276.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696791732; x=1697396532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YMBpvB4vbL5Efat4/kh1MV0BaPqzgW8QeCF16EFudw=;
        b=Z08Eadp8PUrMA9rtqZj1mAZFkrYZ2RII01+ixDDCQ4c2jMArYR8XN/gesRj6QzlSdp
         6Spn1ZN+p1eteaQNDMdWAlipz+7GtD9wZfpUXowIFoe/z52pDAeNUMMpODK4u9+bXIXO
         7ciEQiMZgYlZknBo7PXNua+Q1KZKkyGnOHaImqBkC/OsgvTBtKzI8CGqq2RqhIwmY+UD
         Rg9QHuhfHTs/cIpEZkwb3zXUV5NqnZcgIRlZ6rRpTJg5BmZblKJzd3dCrfZONGPoYtyt
         whxtb3Z59tmEKjQKLpR3RTeTtQqX3wSRl93e4kCEjHbT082jAokqhfH2i4Do/vhJzAzm
         BXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696791732; x=1697396532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YMBpvB4vbL5Efat4/kh1MV0BaPqzgW8QeCF16EFudw=;
        b=ROWhb2MzeczPgChZIf23SH3cwM/jNmTn+4feuH6lQpK8Xk203rjvTY7TrsBkh+NF0E
         fKbWzUd+H8ycwLKHEnSCrnvWOgAsbQAENXqGAN7f3pRpi0S8ejgdExgkBPS7ERsf5ocA
         WftMQfcLmFYr1y+O6t0LZKdGuQtxD8eIuYZr7VwBJA8UYLT+9stuScf0e96UtUhphfHW
         2F4UE4cUS81tf2BC/gc1ZKNjasAGl6BkgjVJLdxzZWmRU5iYtJGejTbFShNl6uSNqe7l
         T5GdVn3TN4js8elxqIBBTCJWZio7lAHdNHr2a9yoo45cgnuw/Wc4uhTl4B82PRFOf//H
         npIg==
X-Gm-Message-State: AOJu0Ywu6p0nCC3Xv+tr1CmF2HMxYJuVFMdRAxi3X68Tw9DkkyrwVAYP
        63JFrhzaRZVGYEvBcoBNvLo=
X-Google-Smtp-Source: AGHT+IHE69JZuGq9AhxumHwdA7Dhq3dH9ML6x62VYVOQ2H8HYtcZr1l+VE0dqLjwoxDFfDhibd4q/w==
X-Received: by 2002:a25:f309:0:b0:d81:5240:679f with SMTP id c9-20020a25f309000000b00d815240679fmr10666287ybs.16.1696791732109;
        Sun, 08 Oct 2023 12:02:12 -0700 (PDT)
Received: from ubuntu.. ([223.178.246.252])
        by smtp.gmail.com with ESMTPSA id g12-20020a63be4c000000b00577e62e13c5sm6018165pgo.32.2023.10.08.12.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 12:02:11 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH v5 3/3] staging: vt6655: Type encoding info dropped from variable name "byBBVGANew"
Date:   Mon,  9 Oct 2023 00:31:50 +0530
Message-Id: <abb105b822090a82ef081b2e28705bf14b8ce058.1696791459.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696791459.git.opensource206@gmail.com>
References: <cover.1696791459.git.opensource206@gmail.com>
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

variable name "byBBVGANew" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
v1 -> v2 : 1.cover letter added
           2.patches sent as attachments in a single mail for review

v2 -> v3 : patches sending in a single mail intead of attachments

v3 -> v4 : version info updated in patchset subject

v4 -> v5 : sending all patches in a series

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

