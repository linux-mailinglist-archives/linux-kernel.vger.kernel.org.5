Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9F87D2065
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 01:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjJUXMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 19:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUXMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 19:12:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF96A3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:12:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32daeed7771so1394341f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697929963; x=1698534763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhZlYF/jnKgWZIepjn1KYt9HmSq9ZfWEq3tbhcGSt/s=;
        b=AnKsR+XYzJUFsOQg6c9GKTrSHCkEaR6Q452Oh+Io+wI5nvBLplzbtzUzYzzwCZsqfF
         sWnmmuPKvS6bL4DwFgmq5g1GC/bbGSca2OvfaiuqPgLAcHbXnHGLHx0ifDibdmHiXgP8
         iS6URaCwdc2EH8cGghZb3eTDxFf6oWz8iFjO9e+T064RmSiJs5aOZlcN+1xdL3FKUvrv
         5s9LNIcKAF0e0IZxWlCTbdTAmuMcd7123Y0bc8owGFLD03NgooGeDD4uyiAr2IMBytgi
         lpw6i8b+S9XNuVVCXFXoRQCYw/bV7KydlTxrg8nzOJ2lqYqaLw+1qt1fhSROfO7eNjzQ
         WRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697929963; x=1698534763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhZlYF/jnKgWZIepjn1KYt9HmSq9ZfWEq3tbhcGSt/s=;
        b=Et4jpfRyY9/GEsNwEpeYMMd+19f4Vj61mkjgT5iOPwGEOiqtBF+yuoIphRTySTNWaN
         8fA1b6ztDpZ9jcPkmzz8XkLK4ZTfqcjL0eaQ3Vh0JOKJu9t4wKSFs88vUbVqMJYduJwS
         nasLWE+XTzIdG7ha42Lbav4eAHKu8l9/SgwTzXPhiArfMmLbxxpXCo13e0Mu29iP65Jd
         z05fDiRsJ+jSXOJ6FS/qigDt3Wep2s2554xWFSN8Rg4qf6v59pjU+XiJzVy0krlTh5F+
         0b1IpXRQHypOZ9fDnGBcCo0oQqrc7w2oO1ywooRcFRysA9vZuHk5t5wbP41RaXOf9OoI
         s2jw==
X-Gm-Message-State: AOJu0YyB6dRJoY+46ZRGEq++Mise44DuzPfcTxTrynVfxdayP9PYV6F9
        u36Zu0n8BH09/hMRb2o1OO/PkbfA7smRH7/E
X-Google-Smtp-Source: AGHT+IEtkBK3neciFc03aUIrVOh+Ut2pheeqyddpfYeI8zbfLK+uF4rgtfVrgFu0Fw79p9G5On00xQ==
X-Received: by 2002:adf:fd90:0:b0:32d:8a32:3b2f with SMTP id d16-20020adffd90000000b0032d8a323b2fmr3722833wrr.16.1697929963123;
        Sat, 21 Oct 2023 16:12:43 -0700 (PDT)
Received: from gilbert-PC ([105.113.89.119])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4ac7000000b0032dde679398sm4508262wrs.8.2023.10.21.16.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 16:12:42 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 1/5] staging: vt6655: Rename variable byCWMaxMin
Date:   Sun, 22 Oct 2023 00:12:27 +0100
Message-Id: <ed8ff47e7ee3a03d8c8c3cc43b4773bb1eb01f16.1697927812.git.gilbertadikankwu@gmail.com>
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
	CHECK: Avoid CamelCase: <byCWMaxMin>

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/vt6655/card.c   | 16 ++++++++--------
 drivers/staging/vt6655/device.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index bec39c72d540..08e50311f7ba 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -184,7 +184,7 @@ static void s_vCalculateOFDMRParameter(unsigned char rate,
  */
 bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 {
-	unsigned char byCWMaxMin = 0;
+	unsigned char cw_max_min = 0;
 	unsigned char bySlot = 0;
 	unsigned char bySIFS = 0;
 	unsigned char byDIFS = 0;
@@ -197,14 +197,14 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		bySlot = C_SLOT_SHORT;
 		bySIFS = C_SIFS_A;
 		byDIFS = C_SIFS_A + 2 * C_SLOT_SHORT;
-		byCWMaxMin = 0xA4;
+		cw_max_min = 0xA4;
 	} else if (bb_type == BB_TYPE_11B) {
 		vt6655_mac_set_bb_type(priv->port_offset, BB_TYPE_11B);
 		bb_write_embedded(priv, 0x88, 0x02);
 		bySlot = C_SLOT_LONG;
 		bySIFS = C_SIFS_BG;
 		byDIFS = C_SIFS_BG + 2 * C_SLOT_LONG;
-		byCWMaxMin = 0xA5;
+		cw_max_min = 0xA5;
 	} else { /* PK_TYPE_11GA & PK_TYPE_11GB */
 		vt6655_mac_set_bb_type(priv->port_offset, BB_TYPE_11G);
 		bb_write_embedded(priv, 0x88, 0x08);
@@ -218,11 +218,11 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 			byDIFS = C_SIFS_BG + 2 * C_SLOT_LONG;
 		}
 
-		byCWMaxMin = 0xa4;
+		cw_max_min = 0xa4;
 
 		for (i = RATE_54M; i >= RATE_6M; i--) {
 			if (priv->basic_rates & ((u32)(0x1 << i))) {
-				byCWMaxMin |= 0x1;
+				cw_max_min |= 0x1;
 				break;
 			}
 		}
@@ -260,9 +260,9 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 
 		bb_set_short_slot_time(priv);
 	}
-	if (priv->byCWMaxMin != byCWMaxMin) {
-		priv->byCWMaxMin = byCWMaxMin;
-		iowrite8(priv->byCWMaxMin, priv->port_offset + MAC_REG_CWMAXMIN0);
+	if (priv->cw_max_min != cw_max_min) {
+		priv->cw_max_min = cw_max_min;
+		iowrite8(priv->cw_max_min, priv->port_offset + MAC_REG_CWMAXMIN0);
 	}
 
 	priv->byPacketType = CARDbyGetPktType(priv);
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 2b5f9bf6aa5d..8ff28e4e72a4 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -185,7 +185,7 @@ struct vnt_private {
 	unsigned char byDIFS;
 	unsigned char byEIFS;
 	unsigned char bySlot;
-	unsigned char byCWMaxMin;
+	unsigned char cw_max_min;
 
 	u8		byBBType; /* 0:11A, 1:11B, 2:11G */
 	u8		byPacketType; /*
-- 
2.34.1

