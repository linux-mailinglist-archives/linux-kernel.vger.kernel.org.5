Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A957D92B2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345673AbjJ0IxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345682AbjJ0Iwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:52:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEA010EB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:38 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5b837db1b26so1430093a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396758; x=1699001558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtKdN8gUg9+lMym9YqfmjhQ5Z4QidptzAJvqHwUlM7g=;
        b=Kc4k0tiqeG7bK7EyduXOaqeyQvRqI1UDiZwXxkNQZdcNC4pY5TcP/btiMn980BzRgH
         sXNz7i9PjO96qlcKA9Lnc+hsHiWfDg//qzvn48U8CKGky4qr9hzltIPZNNENXv9olTL/
         Y5VK3G52KKH2jW8EltDOAFnAhAKB3nIRTU1KppMTVS/Dl82j9dmzeyD1AATfO3y/yXYH
         FNn7pYpiTAgTrH4jQz8XKb2F60OYw0zoYLhAYGatk5Cn2QY5SbDmM0v6UajFTs47BBQt
         E2xMOnRYUuHbjXOkTJacykEWm3elVtm4N8h2j7cu3c7EQS3lhz7wN0UjJE0d0iHIRTco
         OpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396758; x=1699001558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtKdN8gUg9+lMym9YqfmjhQ5Z4QidptzAJvqHwUlM7g=;
        b=O1p9kvRRBrIiz5B0zDlqDUqIG+bIzN8NDqHAAjRYFnPQzArMN/3X0X7ySopH9NeSZ6
         CuDQ70UIULabqTpNSxFmfndeCpZlB7S6gOj/TRAT8iV0jc6ezq/k0MbwvVHVm5bweePq
         MmupiF1VBSn7d0hCFMoHTcvNPbH8/pG5yOuEhqCxbjYgSWLUEK71MHP6sRz5y/X5CONU
         5K7NvChy5wJBsrsEKVOnYxAqiwQAqz5dVGBUwS2RS2kZJoB5c9PqlZTtxSM5sUaKhTvz
         n+mnaQKYhGlQTo92zT4WnOWk7UJATrapAzcuFomyYhJoEtV5QByyUhrw0a6Ty+rTQL4p
         9iQg==
X-Gm-Message-State: AOJu0Yzp9NeBNV7JZmpsevhaik5vNU9Z2cEHbWHw5Kb55gSahZetqOli
        Z7BoqGEIryU8mnKNqH0lcaf74fUuOLU=
X-Google-Smtp-Source: AGHT+IHBCLzZpU6n8om3D/dn92DIeV8MgVjACdnbzcVk1bkmBb9Gh079jTRRKZd4w9ssolNOPTQvrg==
X-Received: by 2002:a05:6a20:c19a:b0:16b:ff2c:c42c with SMTP id bg26-20020a056a20c19a00b0016bff2cc42cmr2092003pzb.62.1698396757804;
        Fri, 27 Oct 2023 01:52:37 -0700 (PDT)
Received: from ubuntu.. ([122.174.106.169])
        by smtp.gmail.com with ESMTPSA id h12-20020a63b00c000000b0055c178a8df1sm698825pgf.94.2023.10.27.01.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:52:37 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 10/10] staging: vt6655: Type encoding info dropped from variable name "byRxRate"
Date:   Fri, 27 Oct 2023 14:21:59 +0530
Message-Id: <16d6e4f4fbf643b45a9e2e5b4c48c93450543ecc.1698396278.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698396278.git.opensource206@gmail.com>
References: <cover.1698396278.git.opensource206@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable name "byRxRate" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c | 12 ++++++------
 drivers/staging/vt6655/card.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index ebb96b4c9406..350ab8f3778a 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -278,8 +278,8 @@ bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type)
  *
  * Parameters:
  *  In:
- *      priv         - The adapter to be sync.
- *      byRxRate        - data rate of receive beacon
+ *      priv            - The adapter to be sync.
+ *      rx_rate         - data rate of receive beacon
  *      qwBSSTimestamp  - Rx BCN's TSF
  *      qwLocalTSF      - Local TSF
  *  Out:
@@ -287,7 +287,7 @@ bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type)
  *
  * Return Value: none
  */
-bool card_update_tsf(struct vnt_private *priv, unsigned char byRxRate,
+bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
 		    u64 qwBSSTimestamp)
 {
 	u64 local_tsf;
@@ -296,7 +296,7 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char byRxRate,
 	local_tsf = vt6655_get_current_tsf(priv);
 
 	if (qwBSSTimestamp != local_tsf) {
-		qwTSFOffset = CARDqGetTSFOffset(byRxRate, qwBSSTimestamp,
+		qwTSFOffset = CARDqGetTSFOffset(rx_rate, qwBSSTimestamp,
 						local_tsf);
 		/* adjust TSF, HW's TSF add TSF Offset reg */
 		qwTSFOffset =  le64_to_cpu(qwTSFOffset);
@@ -708,11 +708,11 @@ unsigned char card_get_pkt_type(struct vnt_private *priv)
  *
  * Return Value: TSF Offset value
  */
-u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2)
+u64 CARDqGetTSFOffset(unsigned char rx_rate, u64 qwTSF1, u64 qwTSF2)
 {
 	unsigned short wRxBcnTSFOffst;
 
-	wRxBcnTSFOffst = rx_bcn_tsf_off[byRxRate % MAX_RATE];
+	wRxBcnTSFOffst = rx_bcn_tsf_off[rx_rate % MAX_RATE];
 
 	qwTSF2 += (u64)wRxBcnTSFOffst;
 
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index caf72892c1cd..19689a291f5b 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -48,13 +48,13 @@ void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 			 unsigned short wBeaconInterval);
 u64 vt6655_get_current_tsf(struct vnt_private *priv);
 u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short wBeaconInterval);
-u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2);
+u64 CARDqGetTSFOffset(unsigned char rx_rate, u64 qwTSF1, u64 qwTSF2);
 unsigned char card_get_pkt_type(struct vnt_private *priv);
 void CARDvSafeResetTx(struct vnt_private *priv);
 void CARDvSafeResetRx(struct vnt_private *priv);
 void CARDbRadioPowerOff(struct vnt_private *priv);
 bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type);
-bool card_update_tsf(struct vnt_private *priv, unsigned char byRxRate,
+bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
 		    u64 qwBSSTimestamp);
 bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 			  unsigned short wBeaconInterval);
-- 
2.34.1

