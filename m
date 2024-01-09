Return-Path: <linux-kernel+bounces-20473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B49D827F73
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6001F26E4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF46929420;
	Tue,  9 Jan 2024 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACIjQdT1"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C129412
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336c9acec03so2538460f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 23:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704785229; x=1705390029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bRW6f7LUQYfWjCRgwYWsO/5FsENRkjYdjxy2rCg89lw=;
        b=ACIjQdT1a5sv7+bUf7duRq4+g7uVdEsZHijjRI7PtNlAEGIT1gr2Z8gPBnoYwkpA07
         cp4TlAFsg7yL8WaNJ7dSct1j7lsbHyN71rZUafGRbtqx6aItCzOK/hFeET7/YDwow8as
         SgGVuCBzFrLhNCqLJSHOYhkYZqQbNWx6A2/8TGRvt66emm239FRQEGuJXJ9N02m/4iZv
         sEYBoSJS4TGVFPbV1ulp5XTjAvMrJq4VMB6aDjWFDf6372pi61YRz2NXKG67GAXT0CVV
         4XsvbJHwVeeUvn2sORX0kNXRpDa8IOclOZ5cTyxNE2duZwXNfBdkW+t8R86/85Je+ub1
         mC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704785229; x=1705390029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRW6f7LUQYfWjCRgwYWsO/5FsENRkjYdjxy2rCg89lw=;
        b=l5gP0pBK3VNcGp6bdH1HtAvz73e9FyYaSuDLPOihbaz2PUqQ5E54o0Im0GUUs4CtiL
         b/YlTZ6MAFRITrSdXD/TqFTvi5uG/6L8U/6osMfyqA2tUZBjnqgU2KaaqDQUm6/ywclK
         ZWqVvV8MMQ2PO4oLZ1tNdDvSnKnSCmqwW6wivWs/Ubufqu10pMiNSt+tf7HtPh9oIDHd
         ca0qSR875y5nBgenGDEyG2U3UOpfwkChtc15i9XHtFSbaU4yKlGN+CdECHT4idi7Qe4S
         qTkRHnL5ucmS+JuLnb0JBRCoeTHSyFvLUxUgMdfZpjzYGsFLp/IOLFIut5KYMBzVINXJ
         /UAw==
X-Gm-Message-State: AOJu0YzuA5Qz6JM03Ku4Yb+ak/xBkW7xUKdjZ9Ts3gS6WSfkMTeH50fz
	B/Q4Y6tYuaEIKmq+GZGbcd0=
X-Google-Smtp-Source: AGHT+IGAxpPiw151mT7WmLfzqjytWXwgj2LbuMt/J3hFYKwhWsJOSy3LDfrlkS1v31uJsEO8Yi9M5Q==
X-Received: by 2002:adf:e2c6:0:b0:337:10cc:77f2 with SMTP id d6-20020adfe2c6000000b0033710cc77f2mr371013wrj.105.1704785228713;
        Mon, 08 Jan 2024 23:27:08 -0800 (PST)
Received: from ubuntu2004.cynet.local (vpn1382.cynet.com. [84.110.53.106])
        by smtp.gmail.com with ESMTPSA id c15-20020a056000104f00b00336cbbf2e0fsm1587409wrx.27.2024.01.08.23.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 23:27:08 -0800 (PST)
From: SilverPlate3 <arielsilver77@gmail.com>
To: forest@alittletooquiet.net,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	SilverPlate3 <arielsilver77@gmail.com>
Subject: [PATCH] Staging: vt6655: Fix sparse warning. Restricted cast.
Date: Tue,  9 Jan 2024 09:27:04 +0200
Message-Id: <20240109072704.44582-1-arielsilver77@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running 'make M=drivers/staging/vt6655 C=2'
causes sparse to generate few warnings.
This patch fixes the following warnings by ensuring le64_to_cpu
handles only __le64 values, thus dismissing chances of bad endianness.
* drivers/staging/vt6655/card.c:302:45: warning: cast to restricted __le64
* drivers/staging/vt6655/card.c:336:23: warning: cast to restricted __le64
* drivers/staging/vt6655/card.c:804:23: warning: cast to restricted __le64
* drivers/staging/vt6655/card.c:831:18: warning: cast to restricted __le64

Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
---
 drivers/staging/vt6655/card.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 350ab8f3778a..5dc2200466b7 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -292,6 +292,7 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
 {
 	u64 local_tsf;
 	u64 qwTSFOffset = 0;
+	__le64 le_qwTSFOffset = 0;
 
 	local_tsf = vt6655_get_current_tsf(priv);
 
@@ -299,7 +300,8 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
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
+	__le64 le_qwNextTBTT = 0;
 
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
@@ -825,10 +831,12 @@ void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 			 unsigned short wBeaconInterval)
 {
 	void __iomem *iobase = priv->port_offset;
+	__le64 le_qwTSF = 0;
 
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


