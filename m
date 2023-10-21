Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF99F7D2066
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 01:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjJUXM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 19:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjJUXMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 19:12:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD932DF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:12:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4083f613272so17400735e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697929970; x=1698534770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgihYbweOv461mq7krCIfGB4Er0uLAixEkR4tcljzVg=;
        b=F0/PbgBOoNmtPxAAkbI412y2I6e5Iw7JAjdN/E5ShX6SdxiPgduNOWmoSQPq2Hd4C/
         ry/F+6EwZHVkNSEDbiYhX5whJDWLH3fNmUkqVn7tAvT7YziRoswrbDWzu0V+nksUGzxU
         O2B2WnQrZ9fOJHgbQzL0vm4cy0pZzGxnWTZ90iNPCn1qg4bhawISABtvpo0jj9V+oPOk
         BltYODPRPZN04qmATfXeyh4qPuZoK7BbQzYWNeW3/RUs2RCicu8wSavov010XIp8ORqh
         SkNHmoYrX8D7U3SVbcW6H8qTRXJhCPAAdHllJa36O13X3iPFM6FA6+bMfqBvkERWJuW3
         zDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697929970; x=1698534770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgihYbweOv461mq7krCIfGB4Er0uLAixEkR4tcljzVg=;
        b=pvwevEMBmUVDIXOfsPQ/SsIEy+6TtpAHfv5oFfuPQTnDkp1Zi0Uai6KrpJkz3Rv+U2
         vY5sLnEhdUdWV8OzXJJdASb9NdHYcmwdCtB2GhFLIquMV28qnQjTpJ61LWoTRpJyC9+J
         mbBXfdFTkPswfFmPMmyzMl9Td4OUsJEWSLg3ORMSucb8GX3dJ1bWFIoHHilTrOLd62gX
         BdRf3DiRwGEOie/RjgMFLXPdEVzBoJfxjXlJ+5Xx8BeJhzsRvY3EWm1N6SqyOcTw+sJC
         n8Lx3WxD9E48ugK8HKay1vmm6VAaSBllt8BrVRn3t5/tfZHhN08Yj9HZ6l1ZjqvMoT+d
         cwCA==
X-Gm-Message-State: AOJu0YxeOZGASXlDCkdv1NTGAxFlQEAwhROXPj/sohjW2sMrwJZ5eD6Z
        Y1b1z4zMehArUvmAF1jcxlR6kjZm34qMwh8H
X-Google-Smtp-Source: AGHT+IF4yQPxDHy4u8fqqIQ6nGdZZ81GvcnTqBDt2CrhddFLnIFOB5WS+xWsqX4tsoiJEyQmEmgW5g==
X-Received: by 2002:a05:600c:1396:b0:404:7659:ba39 with SMTP id u22-20020a05600c139600b004047659ba39mr4016012wmf.16.1697929969850;
        Sat, 21 Oct 2023 16:12:49 -0700 (PDT)
Received: from gilbert-PC ([105.113.89.119])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d6987000000b003232380ffd7sm4511073wru.102.2023.10.21.16.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 16:12:49 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 3/5] staging: vt6655: Rename variable bySIFS
Date:   Sun, 22 Oct 2023 00:12:29 +0100
Message-Id: <f75f308f187fa9a9e14bf25db006131e2dcda43b.1697927812.git.gilbertadikankwu@gmail.com>
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
	CHECK: Avoid CamelCase: <bySIFS>

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/vt6655/card.c   | 16 ++++++++--------
 drivers/staging/vt6655/device.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index b5a87837995f..48e571badfb1 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -186,7 +186,7 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 {
 	unsigned char cw_max_min = 0;
 	unsigned char slot = 0;
-	unsigned char bySIFS = 0;
+	unsigned char sifs = 0;
 	unsigned char byDIFS = 0;
 	int i;
 
@@ -195,20 +195,20 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		vt6655_mac_set_bb_type(priv->port_offset, BB_TYPE_11A);
 		bb_write_embedded(priv, 0x88, 0x03);
 		slot = C_SLOT_SHORT;
-		bySIFS = C_SIFS_A;
+		sifs = C_SIFS_A;
 		byDIFS = C_SIFS_A + 2 * C_SLOT_SHORT;
 		cw_max_min = 0xA4;
 	} else if (bb_type == BB_TYPE_11B) {
 		vt6655_mac_set_bb_type(priv->port_offset, BB_TYPE_11B);
 		bb_write_embedded(priv, 0x88, 0x02);
 		slot = C_SLOT_LONG;
-		bySIFS = C_SIFS_BG;
+		sifs = C_SIFS_BG;
 		byDIFS = C_SIFS_BG + 2 * C_SLOT_LONG;
 		cw_max_min = 0xA5;
 	} else { /* PK_TYPE_11GA & PK_TYPE_11GB */
 		vt6655_mac_set_bb_type(priv->port_offset, BB_TYPE_11G);
 		bb_write_embedded(priv, 0x88, 0x08);
-		bySIFS = C_SIFS_BG;
+		sifs = C_SIFS_BG;
 
 		if (priv->short_slot_time) {
 			slot = C_SLOT_SHORT;
@@ -233,7 +233,7 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		 * bcs TX_PE will reserve 3 us hardware's processing
 		 * time here is 2 us.
 		 */
-		bySIFS -= 3;
+		sifs -= 3;
 		byDIFS -= 3;
 		/*
 		 * TX_PE will reserve 3 us for MAX2829 A mode only, it is for
@@ -242,9 +242,9 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		 */
 	}
 
-	if (priv->bySIFS != bySIFS) {
-		priv->bySIFS = bySIFS;
-		iowrite8(priv->bySIFS, priv->port_offset + MAC_REG_SIFS);
+	if (priv->sifs != sifs) {
+		priv->sifs = sifs;
+		iowrite8(priv->sifs, priv->port_offset + MAC_REG_SIFS);
 	}
 	if (priv->byDIFS != byDIFS) {
 		priv->byDIFS = byDIFS;
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index a63a8ddb7ff1..e6669c5f0b8b 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -181,7 +181,7 @@ struct vnt_private {
 	unsigned int	uCwMin;   /* Current CwMin */
 	unsigned int	uCwMax;   /* CwMax is fixed on 1023. */
 	/* PHY parameter */
-	unsigned char bySIFS;
+	unsigned char sifs;
 	unsigned char byDIFS;
 	unsigned char byEIFS;
 	unsigned char slot;
-- 
2.34.1

