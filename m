Return-Path: <linux-kernel+bounces-19127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A20C826863
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E8B1F21C01
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F22B8BE7;
	Mon,  8 Jan 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sln+JtUK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991A8BE3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c6ce4dffb5so187794a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 23:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704697493; x=1705302293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6sSAKpruQX8lttWXhhug8z0ilcSqfSAidtdqmlvVdrE=;
        b=Sln+JtUKXyu5sffQP6/N5gEfRCfBovZyTKySb2T786CE81Y3C3/U3ALhVWCf54Hexk
         +6vb2OCr+5qPR26uJ/zLj563RGHxk8Arp6jdeFOL8F0ayMni90pVpBJYQ9ydanqsU5Bk
         fv0+DjGm/kcNs7XZMFc2yLbcl8f3yg5Q07tw4uQ3ZCwvwENUMou/gOsUq5V1Cit3g3FI
         xSgCdIcUr7M3J828t6KWQ+vRGg7Qke6p+ekDH/gAKML3qPeyWGfSoxnYEXbtfQFhClSp
         S4OvRWoncNdzUfgfB8ZiWM/dDQ6A07lOjgpfc3l6Z2ENDHlSwG8+oCxf/cNrQ6GSCkDx
         oPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704697493; x=1705302293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sSAKpruQX8lttWXhhug8z0ilcSqfSAidtdqmlvVdrE=;
        b=LhXTf5Ny27OVImjSi4IDokk8qht6ziTLQ7v6K9YUJSzgWIoedQGbF5p/XtfKeL2Iha
         MqTMuMxy4PG1h+gfPcrP7gkVS+k1s6UYMaOHrGuVCnS/P/rm3fgjjvPvXqej+1Qp2ezC
         Fqb93mglYKb4g01B8ZOnWEbp+ZSApnUmhxPwDoNox8tPWiUNrvC+PrVU1CXMfqniIoXu
         QoGcDRK6bNypsrK3UPzWpNYdp92ZxajJPIIQfxn6gNx90rtD4GTVdfCLgn6neHwn4WKB
         Zd3tLhSfaGBnwhqsibdMDgWlR7RpJrVvCgg3g94ibmOtsde1vW1uDIlBoUKPXTfL507y
         e8WQ==
X-Gm-Message-State: AOJu0Yxu0c4zwOKZoIZeAibLj3pkY7azLnZPR963MxjbXPwP2QHsBCsS
	gx7LeimZWU3Z0RAdN0v4VA0=
X-Google-Smtp-Source: AGHT+IHB0dpzM74fBXkcy24dZ4AeYSJRkY3tNKNY6HZg2QeqwZUy5yybQzYsQOkGPn6JRUUZFsdPrA==
X-Received: by 2002:a05:6a20:3d8c:b0:199:4532:3a6 with SMTP id s12-20020a056a203d8c00b00199453203a6mr869389pzi.16.1704697492796;
        Sun, 07 Jan 2024 23:04:52 -0800 (PST)
Received: from mgyee-VirtualBox ([47.152.33.114])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b001c9db5e2929sm5496312plh.93.2024.01.07.23.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 23:04:52 -0800 (PST)
From: Matthias Yee <mgyee9@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Matthias Yee <mgyee9@gmail.com>
Subject: [PATCH v2] staging: vt6655: fixed check alignment of open parenthesis in card.c
Date: Sun,  7 Jan 2024 23:03:10 -0800
Message-Id: <20240108070310.2942-1-mgyee9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjusted whitespace to fix checkpatch warning Alignment Should Match
Open Paranthesis.

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


