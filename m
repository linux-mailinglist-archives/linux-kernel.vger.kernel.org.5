Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FEB7DC5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjJaFff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjJaFfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:35:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F389FEE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cac80292aeso35438365ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698730495; x=1699335295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G104GsQN9SGsp6hJmguf5vfKPskMi7nlpROtr8cSfdI=;
        b=JjIOkllJivafo6N2TLrDIRAGWfOr+F7gToDNRMIcg4tPQEArIrMa1lFfqXI2vOQdfr
         DLcwQ0MshNBlnD3cANmixy3L8zZvlOsbVVPPTRX4PF7ga5VS5MWk+35wspC/CISIJs8u
         FRvijasQ1K1W+5rbceaIh/C5ZRHPdHVWQlXhvS844psKPqzlGnwktCeBCa8xre100eeA
         TaByzlmUDFjLMlIFHyu9j6STfUl3lrGtcnE9Fwwnd2RN4RxOEXYyoK6TK4HY2lzvi0Lz
         5IGKwbIms4Ps6xnQNV10OimVOhmUfb2t00yjaDQFQ5ipj2roC1by1ApzShNyyM1/W7DP
         peeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698730495; x=1699335295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G104GsQN9SGsp6hJmguf5vfKPskMi7nlpROtr8cSfdI=;
        b=Pf6t3BoGRrj4ed3gfKm2wnvP3Z+iK9lkaLWDcyyVZEVgd30c6xexMi7usso1HRbGMQ
         KutlS/IZjbmql3VIKG/0/5MJ2t6Xc2CJl+8PdRMBx9wcwusP/s832icCWorGpDdY9ThR
         UI7x4TBA8ZluqhwrCwzK3T1v16p7qD/d7hFAf/+SyX1ybiASOKkahzdVePvNr4nc/b5F
         yKUpcsChxkERCw7xee6DbyGt6tYPfvyCtH3X5z4Lk1JtnAFOuAdV9MLOtfJHxfPnmlI7
         muqB4/h5w22qTKnqSkh2os58qcUugTEEWAq2xiw3IA77VU6A+sZOIa/fK4dPDKnK0lqs
         sBrw==
X-Gm-Message-State: AOJu0YyGISgxCWGZmBP1lmixXoSxCnXeI84aNH7EuNf9/dwldkaxM0Nj
        yKNy3OFilN9tk4W299TSzoWkoNOpbsU=
X-Google-Smtp-Source: AGHT+IH9/yJcBmPwdhclpwrea7KIAb6q18lJkHULMiD5VW3kVUkEYsUTqaEDl1tidEC9v0Xi0mL48Q==
X-Received: by 2002:a17:902:f213:b0:1c9:da1a:8b14 with SMTP id m19-20020a170902f21300b001c9da1a8b14mr8310243plc.1.1698730495171;
        Mon, 30 Oct 2023 22:34:55 -0700 (PDT)
Received: from ubuntu.. ([122.182.231.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001c0a414695bsm422211pld.43.2023.10.30.22.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:34:54 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 07/11] staging: vt6655: Type encoding info dropped from function name "CARDqGetNextTBTT"
Date:   Tue, 31 Oct 2023 11:04:30 +0530
Message-Id: <8e142b33245e6933fb178080b0b14371939a84e6.1698730318.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698730318.git.opensource206@gmail.com>
References: <cover.1698730318.git.opensource206@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

function name "CARDqGetNextTBTT" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c | 10 +++++-----
 drivers/staging/vt6655/card.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index e4b40125b094..716fd3632508 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -12,7 +12,7 @@
  *      CARDbIsOFDMinBasicRate - Check if any OFDM rate is in BasicRateSet
  *      card_get_tsf_offset - Calculate TSFOffset
  *      vt6655_get_current_tsf - Read Current NIC TSF counter
- *      CARDqGetNextTBTT - Calculate Next Beacon TSF counter
+ *      card_get_next_tbtt - Calculate Next Beacon TSF counter
  *      CARDvSetFirstNextTBTT - Set NIC Beacon time
  *      CARDvUpdateNextTBTT - Sync. NIC Beacon time
  *      CARDbRadioPowerOff - Turn Off NIC Radio Power
@@ -327,7 +327,7 @@ bool card_set_beacon_period(struct vnt_private *priv,
 
 	next_tbtt = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
 
-	next_tbtt = CARDqGetNextTBTT(next_tbtt, beacon_interval);
+	next_tbtt = card_get_next_tbtt(next_tbtt, beacon_interval);
 
 	/* set HW beacon interval */
 	iowrite16(beacon_interval, priv->port_offset + MAC_REG_BI);
@@ -764,7 +764,7 @@ u64 vt6655_get_current_tsf(struct vnt_private *priv)
  *
  * Return Value: TSF value of next Beacon
  */
-u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short beacon_interval)
+u64 card_get_next_tbtt(u64 qwTSF, unsigned short beacon_interval)
 {
 	u32 beacon_int;
 
@@ -799,7 +799,7 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 
 	next_tbtt = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
 
-	next_tbtt = CARDqGetNextTBTT(next_tbtt, beacon_interval);
+	next_tbtt = card_get_next_tbtt(next_tbtt, beacon_interval);
 	/* Set NextTBTT */
 	next_tbtt =  le64_to_cpu(next_tbtt);
 	iowrite32((u32)next_tbtt, iobase + MAC_REG_NEXTTBTT);
@@ -826,7 +826,7 @@ void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 {
 	void __iomem *iobase = priv->port_offset;
 
-	qwTSF = CARDqGetNextTBTT(qwTSF, beacon_interval);
+	qwTSF = card_get_next_tbtt(qwTSF, beacon_interval);
 	/* Set NextTBTT */
 	qwTSF =  le64_to_cpu(qwTSF);
 	iowrite32((u32)qwTSF, iobase + MAC_REG_NEXTTBTT);
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index 1758a95f3ab0..ab1193799239 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -47,7 +47,7 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 			 unsigned short beacon_interval);
 u64 vt6655_get_current_tsf(struct vnt_private *priv);
-u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short beacon_interval);
+u64 card_get_next_tbtt(u64 qwTSF, unsigned short beacon_interval);
 u64 card_get_tsf_offset(unsigned char rx_rate, u64 qwTSF1, u64 qwTSF2);
 unsigned char card_get_pkt_type(struct vnt_private *priv);
 void CARDvSafeResetTx(struct vnt_private *priv);
-- 
2.34.1

