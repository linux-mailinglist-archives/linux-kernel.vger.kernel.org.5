Return-Path: <linux-kernel+bounces-20095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15B7827935
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED6128443E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539C055C30;
	Mon,  8 Jan 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD/7AL24"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5C754BD5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so2413864f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 12:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704746288; x=1705351088; darn=vger.kernel.org;
        h=content-transfer-encoding:running:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qk8DV8xOiqw0q8KdiSyUG8alGH4xQIsQzu0Gj64hSoU=;
        b=YD/7AL249SE3GB/sXj2CQi1YQY59H6AmpBtoX6Eq16ELr+lEi9alJfdiub7U1GqrfB
         8438GjkpEjCsj9DyNVAAJCR724npfTRIWRgKvQUpgcATjgp8IggnoyVng3i5LiG+zgPi
         v5EKAJGE8Xc7MhIcE5ouXoTSRVli1nlAjMq4CMSzFp+yCj3CnDUMA4LuQllEckYeMlJM
         aIU/5BkjxlyAQsm9qXF78F9pHN1YzULgoiR1bewt+c0ujdqyu+YIJ3je5v/9QZsWQbOS
         DpCAkAZTc/0VjChXhP/Q00pV3ojo+JADoTbBnZxxiSwDGpgHiW9ezCgamFROcQ8Yzt9O
         Ci1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704746288; x=1705351088;
        h=content-transfer-encoding:running:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk8DV8xOiqw0q8KdiSyUG8alGH4xQIsQzu0Gj64hSoU=;
        b=iueIse7nL5fvlJ9HMROTf4LLwxaNcLOtPrcqnVJwlHEWGOU6Nq6T8ZosdQUeeeOfDA
         np178JC87oQ1g2iM2rXtWGuDhTFcE+y5WlLv5cUKLXKRHxsPuV0Xe8BsQQwHHdsa5OST
         V2GeQjVqtysl8cDwWoxGIAXJKOjoz/wYCXhovC0mQtaLGFLsRF4ONId3e8YuxXUo5Qok
         SzaGo+pvPqaGb3Tf+OYXMRKTeEcUWkzt9nyOa7H4NptfAqZ7qbcCEDst1ybCLd3FIqRV
         ti4ur++OAp9pb+/a4LzeheJF9hRE++SlLG7KC0nJmCmiMEIL0ZlXx1Dp5IKP+9HIyT4I
         u+dw==
X-Gm-Message-State: AOJu0YxjOMcwQm03/ECJ0Q7DTaZ2u676kMiqqGrYXGg1NI+/r7RU49j0
	YmlV73e25iQQWU7ZGIRVJzk=
X-Google-Smtp-Source: AGHT+IGaUmAt3ND/9w0B6jj5u4cPNpraZpClxzC8ID7Ztpm0RaVJOXNCQAZyWoonwTjDcjg//n7CRw==
X-Received: by 2002:a5d:6683:0:b0:336:67ef:436e with SMTP id l3-20020a5d6683000000b0033667ef436emr2376wru.147.1704746287973;
        Mon, 08 Jan 2024 12:38:07 -0800 (PST)
Received: from ubuntu2004.cynet.local (vpn1382.cynet.com. [84.110.53.106])
        by smtp.gmail.com with ESMTPSA id b15-20020adfe30f000000b003367a51217csm547245wrj.34.2024.01.08.12.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:38:07 -0800 (PST)
From: arielsilver77@gmail.com
To: forest@alittletooquiet.net,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	SilverPlate3 <arielsilver77@gmail.com>
Subject: [PATCH] fixing sparse warnings about a dangerous cast and possible bad endianness. 
Date: Mon,  8 Jan 2024 22:37:14 +0200
Message-Id: <20240108203714.34820-1-arielsilver77@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Running: 'make M=drivers/staging/vt6655 C=2' causes sparse to generate few warnings. 
Content-Transfer-Encoding: 8bit

From: SilverPlate3 <arielsilver77@gmail.com>

---
 drivers/staging/vt6655/card.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 350ab8f3778a..8290dc5a0398 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -292,14 +292,16 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
 {
 	u64 local_tsf;
 	u64 qwTSFOffset = 0;
-
+	__le64 le_qwTSFOffset = 0;
+	
 	local_tsf = vt6655_get_current_tsf(priv);
 
 	if (qwBSSTimestamp != local_tsf) {
 		qwTSFOffset = CARDqGetTSFOffset(rx_rate, qwBSSTimestamp,
 						local_tsf);
 		/* adjust TSF, HW's TSF add TSF Offset reg */
-		qwTSFOffset =  le64_to_cpu(qwTSFOffset);
+		le_qwTSFOffset = cpu_to_le64(qwTSFOffset);
+		qwTSFOffset = le64_to_cpu(le_qwTSFOffset);
 		iowrite32((u32)qwTSFOffset, priv->port_offset + MAC_REG_TSFOFST);
 		iowrite32((u32)(qwTSFOffset >> 32), priv->port_offset + MAC_REG_TSFOFST + 4);
 		vt6655_mac_reg_bits_on(priv->port_offset, MAC_REG_TFTCTL, TFTCTL_TSFSYNCEN);
@@ -324,6 +326,7 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 			  unsigned short wBeaconInterval)
 {
 	u64 qwNextTBTT;
+	__le64 le_qwNextTBTT;
 
 	qwNextTBTT = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
 
@@ -333,7 +336,8 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 	iowrite16(wBeaconInterval, priv->port_offset + MAC_REG_BI);
 	priv->wBeaconInterval = wBeaconInterval;
 	/* Set NextTBTT */
-	qwNextTBTT =  le64_to_cpu(qwNextTBTT);
+	le_qwNextTBTT = cpu_to_le64(qwNextTBTT);
+	qwNextTBTT = le64_to_cpu(le_qwNextTBTT);
 	iowrite32((u32)qwNextTBTT, priv->port_offset + MAC_REG_NEXTTBTT);
 	iowrite32((u32)(qwNextTBTT >> 32), priv->port_offset + MAC_REG_NEXTTBTT + 4);
 	vt6655_mac_reg_bits_on(priv->port_offset, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
@@ -796,12 +800,14 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 {
 	void __iomem *iobase = priv->port_offset;
 	u64 qwNextTBTT;
+	__le64 le_qwNextTBTT = 0;
 
 	qwNextTBTT = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
 
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 	/* Set NextTBTT */
-	qwNextTBTT =  le64_to_cpu(qwNextTBTT);
+	le_qwNextTBTT = cpu_to_le64(qwNextTBTT);
+	qwNextTBTT = le64_to_cpu(le_qwNextTBTT);
 	iowrite32((u32)qwNextTBTT, iobase + MAC_REG_NEXTTBTT);
 	iowrite32((u32)(qwNextTBTT >> 32), iobase + MAC_REG_NEXTTBTT + 4);
 	vt6655_mac_reg_bits_on(iobase, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
@@ -824,11 +830,13 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 			 unsigned short wBeaconInterval)
 {
+	__le64 le_qwTSF = 0;
 	void __iomem *iobase = priv->port_offset;
 
 	qwTSF = CARDqGetNextTBTT(qwTSF, wBeaconInterval);
 	/* Set NextTBTT */
-	qwTSF =  le64_to_cpu(qwTSF);
+	le_qwTSF = cpu_to_le64(qwTSF);
+	qwTSF = le64_to_cpu(le_qwTSF);
 	iowrite32((u32)qwTSF, iobase + MAC_REG_NEXTTBTT);
 	iowrite32((u32)(qwTSF >> 32), iobase + MAC_REG_NEXTTBTT + 4);
 	vt6655_mac_reg_bits_on(iobase, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
-- 
2.25.1


