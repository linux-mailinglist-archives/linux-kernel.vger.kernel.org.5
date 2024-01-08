Return-Path: <linux-kernel+bounces-19093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA208267E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3920C281ACA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AB879CC;
	Mon,  8 Jan 2024 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBf0z4dd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9305B79D8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 06:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dbbc637df7so1263990a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 22:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704694081; x=1705298881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMSqJnJNR3cyrW6XV2nDwhDWgR56IWMyrQ77a78UbYg=;
        b=MBf0z4ddn4LKHlPYq2RVn8p6E7sppMTwb4yMEOgyNZWZzvn+FDE+HIlqkl9Q/NA76e
         3xN1GfUoKZ3Db8zbQ2/Istt1pjaiB8/CUfWSAlVHEgoJwgH8+3c8YEbrB3kX7LJk3R85
         0ysXKJqVywWEJpuSrdu9X0tLsSo8ikScCg4jrzBSpFo2KmIaOXXxbw0yfofUaZ5rBPS5
         HqXLKOqR+PVfWOU+mjPujN1EbDm6KU7lTgxameOhaaxl7B/9G/9lwk513FCyx7pIsWf/
         MlK8P85fRYKNfsmx0//hjtrF+jQOq5N7j21r+rFj0ntbMIPW/AmhSHvIddpFvjABSEwc
         jBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704694081; x=1705298881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMSqJnJNR3cyrW6XV2nDwhDWgR56IWMyrQ77a78UbYg=;
        b=AHVNzNNJyT6YNVzU2joBZNd60UbqAHSfZtntVOmMboTKNZzXssu9gw8G5Oo6hk8+Xm
         pyRBcrS6CEspKCTKHAiE9itkDiTQTmXqtwcuR/btUALRZnkcWeTVGFI4+52OB4vgGb8T
         OB5ho0qklE0UOFQWLgkgsQH4CEjF4stwjYpLE35PEt2w/DjnhDAHgU485RIcARROFhB/
         AxPrHgSlm6hnxzWYGfz84K1O/K5ySv/59johp/nuxxasq0LTnbbIZ/HKhHqZz+P9i5LO
         s3/hoQ8oJk4uXwWlN13nWiIbvNUmDaEziap9kwQUMd/vNGkmHJJnVvrDHjeWhxz37lpj
         iqZw==
X-Gm-Message-State: AOJu0YwvdFnT/a9zUy7ht2wXzQ6cB+WaYVTXMQtzi1DYKt2gGI/LX0Pa
	sJ66H7RNo7VDoV0tZtp4lqkF1uT4zbgHDQ==
X-Google-Smtp-Source: AGHT+IGfh/w/5Ie/jBa2rokFbGNWowia4g9QDgw0B+11BzOtzrq/dSgWB4nrSjrebygsSQphb37jkg==
X-Received: by 2002:a05:6358:2917:b0:174:f7a9:bece with SMTP id y23-20020a056358291700b00174f7a9becemr2846512rwb.5.1704694081510;
        Sun, 07 Jan 2024 22:08:01 -0800 (PST)
Received: from mgyee-VirtualBox ([47.152.33.114])
        by smtp.gmail.com with ESMTPSA id x68-20020a636347000000b005ce6b79ab6asm5293141pgb.82.2024.01.07.22.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 22:08:01 -0800 (PST)
From: Matthias Yee <mgyee9@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Matthias Yee <mgyee9@gmail.com>
Subject: [PATCH] staging: vt6655: fixed check alignment of open parenthesis in card.c
Date: Sun,  7 Jan 2024 22:02:07 -0800
Message-Id: <20240108060207.92348-1-mgyee9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a coding style issue.

Signed-off-by: Matthias Yee <mgyee9@gmail.com>
---
 drivers/staging/vt6655/card.c | 74 +++++++++++++++++------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 36183f2a64c1..688c870d89bc 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -81,9 +81,9 @@ static void vt6655_mac_set_bb_type(void __iomem *iobase, u32 mask)
  * Return Value: none
  */
 static void calculate_ofdmr_parameter(unsigned char rate,
-				       u8 bb_type,
-				       unsigned char *tx_rate,
-				       unsigned char *rsv_time)
+				      u8 bb_type,
+				      unsigned char *tx_rate,
+				      unsigned char *rsv_time)
 {
 	switch (rate) {
 	case RATE_6M:
@@ -288,7 +288,7 @@ bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type)
  * Return Value: none
  */
 bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
-		    u64 bss_timestamp)
+		     u64 bss_timestamp)
 {
 	u64 local_tsf;
 	u64 tsf_offset = 0;
@@ -297,7 +297,7 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
 
 	if (bss_timestamp != local_tsf) {
 		tsf_offset = card_get_tsf_offset(rx_rate, bss_timestamp,
-						local_tsf);
+						 local_tsf);
 		/* adjust TSF, HW's TSF add TSF Offset reg */
 		tsf_offset =  le64_to_cpu(tsf_offset);
 		iowrite32((u32)tsf_offset, priv->port_offset + MAC_REG_TSFOFST);
@@ -321,7 +321,7 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
  * Return Value: true if succeed; otherwise false
  */
 bool card_set_beacon_period(struct vnt_private *priv,
-			  unsigned short beacon_interval)
+			    unsigned short beacon_interval)
 {
 	u64 next_tbtt;
 
@@ -586,61 +586,61 @@ void card_set_rspinf(struct vnt_private *priv, u8 bb_type)
 
 	/* RSPINF_a_6 */
 	calculate_ofdmr_parameter(RATE_6M,
-				   bb_type,
-				   &byTxRate,
-				   &byRsvTime);
+				  bb_type,
+				  &byTxRate,
+				  &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_6);
 	/* RSPINF_a_9 */
 	calculate_ofdmr_parameter(RATE_9M,
-				   bb_type,
-				   &byTxRate,
-				   &byRsvTime);
+				  bb_type,
+				  &byTxRate,
+				  &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_9);
 	/* RSPINF_a_12 */
 	calculate_ofdmr_parameter(RATE_12M,
-				   bb_type,
-				   &byTxRate,
-				   &byRsvTime);
+				  bb_type,
+				  &byTxRate,
+				  &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_12);
 	/* RSPINF_a_18 */
 	calculate_ofdmr_parameter(RATE_18M,
-				   bb_type,
-				   &byTxRate,
-				   &byRsvTime);
+				  bb_type,
+				  &byTxRate,
+				  &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_18);
 	/* RSPINF_a_24 */
 	calculate_ofdmr_parameter(RATE_24M,
-				   bb_type,
-				   &byTxRate,
-				   &byRsvTime);
+				  bb_type,
+				  &byTxRate,
+				  &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_24);
 	/* RSPINF_a_36 */
 	calculate_ofdmr_parameter(CARDwGetOFDMControlRate((void *)priv,
-							   RATE_36M),
-				   bb_type,
-				   &byTxRate,
-				   &byRsvTime);
+							  RATE_36M),
+				  bb_type,
+				  &byTxRate,
+				  &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_36);
 	/* RSPINF_a_48 */
 	calculate_ofdmr_parameter(CARDwGetOFDMControlRate((void *)priv,
-							   RATE_48M),
-				   bb_type,
-				   &byTxRate,
-				   &byRsvTime);
+							  RATE_48M),
+				  bb_type,
+				  &byTxRate,
+				  &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_48);
 	/* RSPINF_a_54 */
 	calculate_ofdmr_parameter(CARDwGetOFDMControlRate((void *)priv,
-							   RATE_54M),
-				   bb_type,
-				   &byTxRate,
-				   &byRsvTime);
+							  RATE_54M),
+				  bb_type,
+				  &byTxRate,
+				  &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_54);
 	/* RSPINF_a_72 */
 	calculate_ofdmr_parameter(CARDwGetOFDMControlRate((void *)priv,
-							   RATE_54M),
-				   bb_type,
-				   &byTxRate,
-				   &byRsvTime);
+							  RATE_54M),
+				  bb_type,
+				  &byTxRate,
+				  &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_72);
 	/* Set to Page0 */
 	VT6655_MAC_SELECT_PAGE0(priv->port_offset);
-- 
2.34.1


