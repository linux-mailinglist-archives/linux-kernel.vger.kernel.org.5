Return-Path: <linux-kernel+bounces-21403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DF1828EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221A02881CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA943D99B;
	Tue,  9 Jan 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTZm/0JM"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722993D0BF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9344f30caso2384254b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 13:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704834020; x=1705438820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8PqrYznF1h7v69mQzJDRBaSVcYJ8q1B41izZsnQE+ww=;
        b=nTZm/0JMG94cwNa17aEDolbq6Fb2gd0mtBGEAFA+eMZZTI+PCi82A5vsc663z421Uq
         ZInb3OQ0zxqnFYkwHVVhOYhpw/67aFHL3S46a6SCBScv3zyBDcJCw9ufRuaeohMHPctz
         at0ElO5AnW6T3hUXHH6EClseTrWYIpzIIetZ0n2kWNS1HzHoQi0UoVpK28Aao5uwzmYD
         0sinRuGBwvG1RphiRKLcx6G7lTORZ+Tu+AhhaQhH98l5fvuE7EkXLpjAIK2d8r7k6fR5
         WWNQSadgjAtvGNrxaDiwXf9J6GizDtrzkSSY/FGUWFJrDqH/eaMng2IwVuy5LG60lZNg
         td5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704834020; x=1705438820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PqrYznF1h7v69mQzJDRBaSVcYJ8q1B41izZsnQE+ww=;
        b=lQOJnELDvFTmv6VD1VAOtQCuy1O/a35uO445kQ3qflsvgih3RCH+OW9WTcwBAsQpsr
         KqKYtGMUO15vUf2mLJnNZ5FzzLoQiIOGH4L23b+9O2KiI/0IAvN+6G++CfMLPG02r3Q1
         wvcJTFf0OvXvFRIGcbsMfMe0xRcUQpfbwQ4+7FvnQjHRvaG9iJ82UFFyodOFELOcLwhF
         Tj1Fm1tZFCN8MkdmjNpKq4KCR8Yl81o9c387f7hHJWOW03wnXoosLNZCxlROL+thTbg3
         aD+ilC+2zFe9dHpwe0Lc+ZMxgb9fWpJsA74AU0mSqhTIrMm6wy2WsOawI9l3pxOeHjQy
         Snfg==
X-Gm-Message-State: AOJu0Yw2ibEnXC9pbmC2TkaEJhlWWvuAID0Rqk68OstlSLFrQbpNA7wp
	xi81mLxH+iwTseeFQkrUg1LMZ/1WmBg=
X-Google-Smtp-Source: AGHT+IE4DTMizSI5cvANtWuvK4vp2JHfIx6I9Yyd+sgqEaxMIBxIYt4cFXle72kQpfKhrZny2eCb7g==
X-Received: by 2002:a05:6a00:23c4:b0:6da:345f:6a63 with SMTP id g4-20020a056a0023c400b006da345f6a63mr139690pfc.5.1704834019628;
        Tue, 09 Jan 2024 13:00:19 -0800 (PST)
Received: from mgyee-VirtualBox ([47.152.33.114])
        by smtp.gmail.com with ESMTPSA id fh12-20020a056a00390c00b006d0d90edd2csm2109554pfb.42.2024.01.09.13.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 13:00:19 -0800 (PST)
From: Matthias Yee <mgyee9@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	Matthias Yee <mgyee9@gmail.com>
Subject: [PATCH v2] staging: vt6655: fix open parentheses alignment
Date: Tue,  9 Jan 2024 12:59:34 -0800
Message-Id: <20240109205933.3221-1-mgyee9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjusted whitespace to fix checkpatch warning Alignment Should Match Open Parenthesis.

Signed-off-by: Matthias Yee <mgyee9@gmail.com>
---
Changes in v2:
- line wrapped commit message
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


