Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4004E7D2067
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 01:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjJUXNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 19:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjJUXNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 19:13:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DBF10C8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:12:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4079ed65471so16877665e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697929973; x=1698534773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaXhciQDtI63AcB9SDgDuqcYaairo+slB91oIneRn5o=;
        b=B4NoOF89IYWyMARdbh40zFRm0TvHH82Kth80Ewl8Zw1W0rO6thSgUKu6jWq0R1p9Px
         lwjb0WawpD5XKsF8lRpnGF0mr8JBfA6KENxWwfULRkNelKq5UudQZoO7NyuAMK/x1BkU
         KywKItCoAd+eVqONuDj1rHs5d3wAAT45plN6vhIy9+wW5ocw6ZaJKpRodm6LjIQIqQQ6
         8aduQP05QLGw4QURtU79RxK+qi8oYynD/T15E2O1eH30I3a4TwH0luQ7TGfuJtIm/lR5
         bvKVhx+toBh/K9oPH5FCNmy8hVL0HU1z6YhvnMsq/16M5rGvJfEk1ef/XuRlo/3qyiYf
         Mnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697929973; x=1698534773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaXhciQDtI63AcB9SDgDuqcYaairo+slB91oIneRn5o=;
        b=GP55unxdK2BVvvgAyX1IFj3YCzlDqyHTma7x2jQAr47iloCx2KD9tlNQN1Un3sTXDc
         +2xS0iGC0wQETREl9XFhsslg4dBjPqugWtUrQ3ZI4txMsaDz6XA8MRGhhIktcBHZiAZP
         K9vtLejyULl6hMyrrIevGEmKZANyWBAs9epieLI+/yNBvpCyrObDiLsy27qN6ZClXURs
         23WBFV2MGO/H7gHATcxAU6wlP7wOxKj5Vo/+WtIEVI/17nFg85RzNY3XnSjz+a0hm46y
         6zfvw7DscV/7a/wZph/JlHDJRgr6bvbSiHEX9EJ1vFy1gRhHoXFtyBCxx8footLp9Bjx
         zG/A==
X-Gm-Message-State: AOJu0YxUllNbkb8RKyJu2QCNJfyXkBsbQ7rhPUdPdB8g4slwIHE0XDEk
        otqHM+zP2j7r/lZPbkd2RVExyD9QpL4+qUBS
X-Google-Smtp-Source: AGHT+IE/j4x916pVyFkELwANRSWr6IFipb3aUbvMqTQ6Ci/25Qe3Yqq8DqkvkPJcBIyJrzdpu7dRMQ==
X-Received: by 2002:a05:600c:4fcb:b0:405:34e4:14e3 with SMTP id o11-20020a05600c4fcb00b0040534e414e3mr4167364wmq.3.1697929973438;
        Sat, 21 Oct 2023 16:12:53 -0700 (PDT)
Received: from gilbert-PC ([105.113.89.119])
        by smtp.gmail.com with ESMTPSA id ay10-20020a05600c1e0a00b00405442edc69sm7758919wmb.14.2023.10.21.16.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 16:12:53 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 4/5] staging: vt6655: Rename variable byDIFS
Date:   Sun, 22 Oct 2023 00:12:30 +0100
Message-Id: <f10775da0decdbbec33d38236cdf89bcd8ab591e.1697927812.git.gilbertadikankwu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697927812.git.gilbertadikankwu@gmail.com>
References: <cover.1697927812.git.gilbertadikankwu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove byte Type encoding "by" from variable name and replace camelcase
with snakecase

Fix checkpatch.pl error:
	CHECK: Avoid CamelCase: <byDIFS>

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/vt6655/card.c   | 18 +++++++++---------
 drivers/staging/vt6655/device.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 48e571badfb1..9c8648ea96be 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -187,7 +187,7 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 	unsigned char cw_max_min = 0;
 	unsigned char slot = 0;
 	unsigned char sifs = 0;
-	unsigned char byDIFS = 0;
+	unsigned char difs = 0;
 	int i;
 
 	/* Set SIFS, DIFS, EIFS, SlotTime, CwMin */
@@ -196,14 +196,14 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		bb_write_embedded(priv, 0x88, 0x03);
 		slot = C_SLOT_SHORT;
 		sifs = C_SIFS_A;
-		byDIFS = C_SIFS_A + 2 * C_SLOT_SHORT;
+		difs = C_SIFS_A + 2 * C_SLOT_SHORT;
 		cw_max_min = 0xA4;
 	} else if (bb_type == BB_TYPE_11B) {
 		vt6655_mac_set_bb_type(priv->port_offset, BB_TYPE_11B);
 		bb_write_embedded(priv, 0x88, 0x02);
 		slot = C_SLOT_LONG;
 		sifs = C_SIFS_BG;
-		byDIFS = C_SIFS_BG + 2 * C_SLOT_LONG;
+		difs = C_SIFS_BG + 2 * C_SLOT_LONG;
 		cw_max_min = 0xA5;
 	} else { /* PK_TYPE_11GA & PK_TYPE_11GB */
 		vt6655_mac_set_bb_type(priv->port_offset, BB_TYPE_11G);
@@ -212,10 +212,10 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 
 		if (priv->short_slot_time) {
 			slot = C_SLOT_SHORT;
-			byDIFS = C_SIFS_BG + 2 * C_SLOT_SHORT;
+			difs = C_SIFS_BG + 2 * C_SLOT_SHORT;
 		} else {
 			slot = C_SLOT_LONG;
-			byDIFS = C_SIFS_BG + 2 * C_SLOT_LONG;
+			difs = C_SIFS_BG + 2 * C_SLOT_LONG;
 		}
 
 		cw_max_min = 0xa4;
@@ -234,7 +234,7 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		 * time here is 2 us.
 		 */
 		sifs -= 3;
-		byDIFS -= 3;
+		difs -= 3;
 		/*
 		 * TX_PE will reserve 3 us for MAX2829 A mode only, it is for
 		 * better TX throughput; MAC will need 2 us to process, so the
@@ -246,9 +246,9 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		priv->sifs = sifs;
 		iowrite8(priv->sifs, priv->port_offset + MAC_REG_SIFS);
 	}
-	if (priv->byDIFS != byDIFS) {
-		priv->byDIFS = byDIFS;
-		iowrite8(priv->byDIFS, priv->port_offset + MAC_REG_DIFS);
+	if (priv->difs != difs) {
+		priv->difs = difs;
+		iowrite8(priv->difs, priv->port_offset + MAC_REG_DIFS);
 	}
 	if (priv->byEIFS != C_EIFS) {
 		priv->byEIFS = C_EIFS;
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index e6669c5f0b8b..264bb056c80c 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -182,7 +182,7 @@ struct vnt_private {
 	unsigned int	uCwMax;   /* CwMax is fixed on 1023. */
 	/* PHY parameter */
 	unsigned char sifs;
-	unsigned char byDIFS;
+	unsigned char difs;
 	unsigned char byEIFS;
 	unsigned char slot;
 	unsigned char cw_max_min;
-- 
2.34.1

