Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1579F7D2064
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 01:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjJUXM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 19:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjJUXMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 19:12:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5EED78
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:12:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40790b0a224so16251915e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697929966; x=1698534766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vXZgyEKU5ol5cYhGlFd2UNXwc+nr6jp8jVrQ9cIWSU=;
        b=Um+3ao/sst+F1XnsSoAcIBo5bVE4mhgL0m5F043V5LgjIsZ+U5NkAsaJFsfgeuzFaQ
         VCUMuyxi7vdNYXkpb+1yKrM66OQuaCAh5XJ3cJ9PjLk9hzRRVMWejDZ0rMyDVd6mUjj+
         IyYE2/EW3bBm7cb1UYwTKgPLaOSfVydeDAoAXgoIt6icp5tufVjiq0EPUfuzbHTydsTo
         FHjP91lWvpOh375c64KZhu/FC1YcG3mXgsPfq6Q+PrBZLonVXdOU8NVISC0rx+ZnK8NY
         uKuGT5p89+Uv0RsESsV+7aRfIqSgs6CndE3cXOdBmwONqaWYrXEBaxKagUMNVh1+E9Ja
         dHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697929966; x=1698534766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vXZgyEKU5ol5cYhGlFd2UNXwc+nr6jp8jVrQ9cIWSU=;
        b=Ri1eAEzL/9gip5JxaXUSz4E8XwN/GUjhGYZsafmlgIf1Q50vTED7QhCs6ggMz+b23z
         Q0BmyxTL4aVftXH5efpOhtVoQ+EXRfr2WXmL7Kr7hzH3zI3T+V2fPHtPxFrE8scrt2Tv
         dqd1aTCpOJygULgswMygllWY3S3vZCA+gqEADQkdeQ3M9YylXlB5mL/Q/ZgipyUY2he3
         ZIcLOyuLb81Kwy9TUhcjXM+4u6NMXzJUlHsZ98fb5VHB2NLXM9DwGvz8PnNxZPdGtwEJ
         eXLtLJRCnMCukvGNJYovAaxcaSwmezX2PscP2vEL5fk4sHWmVGgpxtZNSVMY588XzvnI
         buAQ==
X-Gm-Message-State: AOJu0YwEkbGranodJq3JK+4opUi31XYppAs7LGEGSzLstQuBt7ckOIk1
        ZMfyeeCQ4olgHetpMw7nDMo=
X-Google-Smtp-Source: AGHT+IEOhz+zHqvkO1ijotRi7C69/N8MtDb5GnmyPn+9EKp78ZR1odKS5Dk+24cC4tmYTl3bYPfh+g==
X-Received: by 2002:a05:600c:3112:b0:401:bdf9:c336 with SMTP id g18-20020a05600c311200b00401bdf9c336mr4566240wmo.27.1697929966363;
        Sat, 21 Oct 2023 16:12:46 -0700 (PDT)
Received: from gilbert-PC ([105.113.89.119])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c499100b0040772138bb7sm10250760wmp.2.2023.10.21.16.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 16:12:46 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 2/5] staging: vt6655: Rename variable bySlot
Date:   Sun, 22 Oct 2023 00:12:28 +0100
Message-Id: <57a1a08fba23d8da8ed1411d84f31f074f510444.1697927812.git.gilbertadikankwu@gmail.com>
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
with snakecase.

Fix checkpatch.pl error:
	CHECK: Avoid CamelCase: <bySlot>

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/vt6655/card.c   | 16 ++++++++--------
 drivers/staging/vt6655/device.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 08e50311f7ba..b5a87837995f 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -185,7 +185,7 @@ static void s_vCalculateOFDMRParameter(unsigned char rate,
 bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 {
 	unsigned char cw_max_min = 0;
-	unsigned char bySlot = 0;
+	unsigned char slot = 0;
 	unsigned char bySIFS = 0;
 	unsigned char byDIFS = 0;
 	int i;
@@ -194,14 +194,14 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 	if (bb_type == BB_TYPE_11A) {
 		vt6655_mac_set_bb_type(priv->port_offset, BB_TYPE_11A);
 		bb_write_embedded(priv, 0x88, 0x03);
-		bySlot = C_SLOT_SHORT;
+		slot = C_SLOT_SHORT;
 		bySIFS = C_SIFS_A;
 		byDIFS = C_SIFS_A + 2 * C_SLOT_SHORT;
 		cw_max_min = 0xA4;
 	} else if (bb_type == BB_TYPE_11B) {
 		vt6655_mac_set_bb_type(priv->port_offset, BB_TYPE_11B);
 		bb_write_embedded(priv, 0x88, 0x02);
-		bySlot = C_SLOT_LONG;
+		slot = C_SLOT_LONG;
 		bySIFS = C_SIFS_BG;
 		byDIFS = C_SIFS_BG + 2 * C_SLOT_LONG;
 		cw_max_min = 0xA5;
@@ -211,10 +211,10 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		bySIFS = C_SIFS_BG;
 
 		if (priv->short_slot_time) {
-			bySlot = C_SLOT_SHORT;
+			slot = C_SLOT_SHORT;
 			byDIFS = C_SIFS_BG + 2 * C_SLOT_SHORT;
 		} else {
-			bySlot = C_SLOT_LONG;
+			slot = C_SLOT_LONG;
 			byDIFS = C_SIFS_BG + 2 * C_SLOT_LONG;
 		}
 
@@ -254,9 +254,9 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		priv->byEIFS = C_EIFS;
 		iowrite8(priv->byEIFS, priv->port_offset + MAC_REG_EIFS);
 	}
-	if (priv->bySlot != bySlot) {
-		priv->bySlot = bySlot;
-		iowrite8(priv->bySlot, priv->port_offset + MAC_REG_SLOT);
+	if (priv->slot != slot) {
+		priv->slot = slot;
+		iowrite8(priv->slot, priv->port_offset + MAC_REG_SLOT);
 
 		bb_set_short_slot_time(priv);
 	}
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 8ff28e4e72a4..a63a8ddb7ff1 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -184,7 +184,7 @@ struct vnt_private {
 	unsigned char bySIFS;
 	unsigned char byDIFS;
 	unsigned char byEIFS;
-	unsigned char bySlot;
+	unsigned char slot;
 	unsigned char cw_max_min;
 
 	u8		byBBType; /* 0:11A, 1:11B, 2:11G */
-- 
2.34.1

