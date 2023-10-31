Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A037DC5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjJaFfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjJaFfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:35:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1BDE8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:11 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc5b6d6228so10223945ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698730491; x=1699335291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p28HpRJ0uHM3u6HlKt1DCOmKGbpUgNk8pFmoEPtkATw=;
        b=TFLBX5TrBXTQsqK8IEoEJ+LyxvzQKMqGU+3YIQLhZAbB0so1WIDD4Yw820ImhvI8uc
         lIuwFTVSYUEXNFJjvVFm+PK5Bb5BTjGbMZZmMJwhj3dnTc+1bt3KD6n9q9x/8vNTtXZ/
         RR42Lx4/hS0u8VAcX6vzbmgy33UEdFabBASFjEUTYNxb1Yr39VVTGW09n6VVBUowCAcN
         iIUXOXmwumnIAZjvKg3ivpNchUKKzAwo42o+xeAmsmEdCEEPGwmkesTWqpOIk2f9CouM
         ZfIizs33hxvREHMtEqk8+eE2aEjPBW2K7H4fCSbGuF+baay7o1dka4/Cv5xCkHqGXxnr
         KICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698730491; x=1699335291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p28HpRJ0uHM3u6HlKt1DCOmKGbpUgNk8pFmoEPtkATw=;
        b=D8UOkB2+crdShwIlTxOWqIefAIoJiP/prN9BDdCIkTdZKKV0wyUG6qsQCvbp/yoqSp
         82sOlSr3Ab6c5JIchGoDzwOpQGU/om5JMTOMMHU7IQh536pi1EoTXSHKheIEApZFzX02
         +dPaojvWoik5DADFKCiDFmfYitLccwkEP+wXi0F6413fAnHVJTQ0DVDzZPQP50PSNkex
         PF4kTmXCM38jcYn7hpP/jS/j7MWwLomPfYjGk668VtF1MMxsDKhvoOTqatiqcyLx/+OX
         nAcyRzYriuhX0GXXG8VEObzHYW6qYULQGrvHPwe88db0ZSnITDf+WWTprOmt6NSDuU3U
         H0ng==
X-Gm-Message-State: AOJu0Yxdt4fe+1Ef4syWPb3aAXr/VJykYPRNc9qV8gM72GH05HzDsYQC
        tIlnpZ4++UzCTQPU1FTmbdk=
X-Google-Smtp-Source: AGHT+IE1b72lCFy8rRt0QaqY4nBA1jDtfPcq+rCVkRoLUN6ke3E8xqHKFYnJb3c31TrlflWF0+FlNg==
X-Received: by 2002:a17:902:f34d:b0:1c9:d0a0:ee88 with SMTP id q13-20020a170902f34d00b001c9d0a0ee88mr7802008ple.62.1698730491447;
        Mon, 30 Oct 2023 22:34:51 -0700 (PDT)
Received: from ubuntu.. ([122.182.231.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001c0a414695bsm422211pld.43.2023.10.30.22.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:34:51 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 05/11] staging: vt6655: Type encoding info dropped from variable name "wBeaconInterval"
Date:   Tue, 31 Oct 2023 11:04:28 +0530
Message-Id: <a8aa6227fb8dadfdebb0a6ab74cff9730358c765.1698730318.git.opensource206@gmail.com>
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

variable name "wBeaconInterval" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c   | 26 +++++++++++++-------------
 drivers/staging/vt6655/card.h   |  8 ++++----
 drivers/staging/vt6655/device.h |  2 +-
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index bfd02a869d64..c18cbf0aad75 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -314,24 +314,24 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
  * Parameters:
  *  In:
  *      priv         - The adapter to be set.
- *      wBeaconInterval - Beacon Interval
+ *      beacon_interval - Beacon Interval
  *  Out:
  *      none
  *
  * Return Value: true if succeed; otherwise false
  */
 bool card_set_beacon_period(struct vnt_private *priv,
-			  unsigned short wBeaconInterval)
+			  unsigned short beacon_interval)
 {
 	u64 qwNextTBTT;
 
 	qwNextTBTT = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
 
-	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
+	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, beacon_interval);
 
 	/* set HW beacon interval */
-	iowrite16(wBeaconInterval, priv->port_offset + MAC_REG_BI);
-	priv->wBeaconInterval = wBeaconInterval;
+	iowrite16(beacon_interval, priv->port_offset + MAC_REG_BI);
+	priv->beacon_interval = beacon_interval;
 	/* Set NextTBTT */
 	qwNextTBTT =  le64_to_cpu(qwNextTBTT);
 	iowrite32((u32)qwNextTBTT, priv->port_offset + MAC_REG_NEXTTBTT);
@@ -764,11 +764,11 @@ u64 vt6655_get_current_tsf(struct vnt_private *priv)
  *
  * Return Value: TSF value of next Beacon
  */
-u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short wBeaconInterval)
+u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short beacon_interval)
 {
 	u32 beacon_int;
 
-	beacon_int = wBeaconInterval * 1024;
+	beacon_int = beacon_interval * 1024;
 	if (beacon_int) {
 		do_div(qwTSF, beacon_int);
 		qwTSF += 1;
@@ -785,21 +785,21 @@ u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short wBeaconInterval)
  * Parameters:
  *  In:
  *      iobase          - IO Base
- *      wBeaconInterval - Beacon Interval
+ *      beacon_interval - Beacon Interval
  *  Out:
  *      none
  *
  * Return Value: none
  */
 void CARDvSetFirstNextTBTT(struct vnt_private *priv,
-			   unsigned short wBeaconInterval)
+			   unsigned short beacon_interval)
 {
 	void __iomem *iobase = priv->port_offset;
 	u64 qwNextTBTT;
 
 	qwNextTBTT = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
 
-	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
+	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, beacon_interval);
 	/* Set NextTBTT */
 	qwNextTBTT =  le64_to_cpu(qwNextTBTT);
 	iowrite32((u32)qwNextTBTT, iobase + MAC_REG_NEXTTBTT);
@@ -815,18 +815,18 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
  *  In:
  *      priv         - The adapter to be set
  *      qwTSF           - Current TSF counter
- *      wBeaconInterval - Beacon Interval
+ *      beacon_interval - Beacon Interval
  *  Out:
  *      none
  *
  * Return Value: none
  */
 void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
-			 unsigned short wBeaconInterval)
+			 unsigned short beacon_interval)
 {
 	void __iomem *iobase = priv->port_offset;
 
-	qwTSF = CARDqGetNextTBTT(qwTSF, wBeaconInterval);
+	qwTSF = CARDqGetNextTBTT(qwTSF, beacon_interval);
 	/* Set NextTBTT */
 	qwTSF =  le64_to_cpu(qwTSF);
 	iowrite32((u32)qwTSF, iobase + MAC_REG_NEXTTBTT);
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index f84e4190a2ac..1758a95f3ab0 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -43,11 +43,11 @@ void card_set_rspinf(struct vnt_private *priv, u8 bb_type);
 void CARDvUpdateBasicTopRate(struct vnt_private *priv);
 bool CARDbIsOFDMinBasicRate(struct vnt_private *priv);
 void CARDvSetFirstNextTBTT(struct vnt_private *priv,
-			   unsigned short wBeaconInterval);
+			   unsigned short beacon_interval);
 void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
-			 unsigned short wBeaconInterval);
+			 unsigned short beacon_interval);
 u64 vt6655_get_current_tsf(struct vnt_private *priv);
-u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short wBeaconInterval);
+u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short beacon_interval);
 u64 card_get_tsf_offset(unsigned char rx_rate, u64 qwTSF1, u64 qwTSF2);
 unsigned char card_get_pkt_type(struct vnt_private *priv);
 void CARDvSafeResetTx(struct vnt_private *priv);
@@ -57,6 +57,6 @@ bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type);
 bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
 		    u64 bss_timestamp);
 bool card_set_beacon_period(struct vnt_private *priv,
-			  unsigned short wBeaconInterval);
+			  unsigned short beacon_interval);
 
 #endif /* __CARD_H__ */
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index d9ee0b7401fe..fadbfccf42de 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -281,7 +281,7 @@ struct vnt_private {
 
 	unsigned char abyEEPROM[EEP_MAX_CONTEXT_SIZE]; /* unsigned long alignment */
 
-	unsigned short wBeaconInterval;
+	unsigned short beacon_interval;
 	u16 wake_up_count;
 
 	struct work_struct interrupt_work;
-- 
2.34.1

