Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB197D92AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345706AbjJ0Iwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345645AbjJ0Iwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:52:32 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FECD5E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:28 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-586753b0ab0so995384eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396747; x=1699001547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9vPJ8qQN6Z7supl7z83Tc2/7ozVv2YV93L49yFOMOU=;
        b=X0wdQ8QJ6eJhm7KROpDF5gSp3UpSFKGL6kvo7mwbrWp5e6jC6OQTu750OeC16hrnKr
         1MpzSxbyggQ7Tu889t6g7BtJywsKxUYgdtxw8FXHCTAyX4iz9fO8ca2yij4Nb94bCGxy
         CMxlaKSphI7UcsqTHr2GYAZfdrXSm0KZHRaQ1TbkS+YTn+9nCJtwp3fmAQM78yVC0t50
         I6bKVVNLSIJumN8eUEYr2dosTxmQs9L6QbFixhUcvLCqLQgVeHUKNrFbZfam7PX5fiQ7
         iQqR7+v4v5CEDqTZ2w72awGSNV0J50FkSpdbq38l0KK9+RY29bMX/SvhMR8w5hljRb6W
         Npyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396747; x=1699001547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9vPJ8qQN6Z7supl7z83Tc2/7ozVv2YV93L49yFOMOU=;
        b=GrwW6zHh5+hdOpn72zdru8qKtxoYhi1uHLSn8eMfC+NwmYhmm+JDVFkjg0Qr/tEHrx
         /irty3IYCtbWUCZgSeAtt9hyGrAZ8W/3+/bwqlsWXTBDzdtVANdktRE4YMnpRYm1VjR+
         8ApTuuhyp19ATsngLapzrC4ThUrXW9ftyvZCm59htwl754MiA2P6V/kCBRQntB3Oz+8L
         e0/zcM4r1yyjrdD+9dqwDR5i4oH06fwa85P+JgMe+uzZdCWWZAABcEnmOdTFnItSau5U
         0QCvUhMCbZaSYTiO8NcjZ7wyP6TOBqBPVKDg655CUCDA021HjV03J3CRrY/pymPtP43+
         qLnA==
X-Gm-Message-State: AOJu0YwdxTRIim1ZDulKpAn/vhf+GSSiy1gdVqOnftKrkPkwgZn+bURT
        QV6m012lqLvZGo350Ep6Fc8=
X-Google-Smtp-Source: AGHT+IGdghsjyHgcQd3tYaCfqroNM9abXevTdYe8w/qEljxzK1P1QPX3fgFlhHJfHDY+L9j1WhnlhQ==
X-Received: by 2002:a05:6358:52c1:b0:168:e461:47c with SMTP id z1-20020a05635852c100b00168e461047cmr2801427rwz.18.1698396747363;
        Fri, 27 Oct 2023 01:52:27 -0700 (PDT)
Received: from ubuntu.. ([122.174.106.169])
        by smtp.gmail.com with ESMTPSA id h12-20020a63b00c000000b0055c178a8df1sm698825pgf.94.2023.10.27.01.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:52:26 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 05/10] staging: vt6655: Type encoding info dropped from function name "CARDbSetPhyParameter"
Date:   Fri, 27 Oct 2023 14:21:54 +0530
Message-Id: <66beb307ac7983b2aa82fa81f6f2362353209859.1698396278.git.opensource206@gmail.com>
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

function name "CARDbSetPhyParameter" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c        | 2 +-
 drivers/staging/vt6655/card.h        | 2 +-
 drivers/staging/vt6655/device_main.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 5fdfc4dc70cc..4f73da832b6a 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -182,7 +182,7 @@ static void calculate_ofdmr_parameter(unsigned char rate,
  *
  * Return Value: None.
  */
-bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
+bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type)
 {
 	unsigned char cw_max_min = 0;
 	unsigned char slot = 0;
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index 22dc359a6565..8c0d06da952f 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -53,7 +53,7 @@ unsigned char CARDbyGetPktType(struct vnt_private *priv);
 void CARDvSafeResetTx(struct vnt_private *priv);
 void CARDvSafeResetRx(struct vnt_private *priv);
 void CARDbRadioPowerOff(struct vnt_private *priv);
-bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type);
+bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type);
 bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
 		    u64 qwBSSTimestamp);
 bool CARDbSetBeaconPeriod(struct vnt_private *priv,
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 2152c6850e61..c6627c10a462 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1442,7 +1442,7 @@ static int vnt_config(struct ieee80211_hw *hw, u32 changed)
 		if (priv->byBBType != bb_type) {
 			priv->byBBType = bb_type;
 
-			CARDbSetPhyParameter(priv, priv->byBBType);
+			card_set_phy_parameter(priv, priv->byBBType);
 		}
 	}
 
@@ -1509,7 +1509,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 		else
 			priv->short_slot_time = false;
 
-		CARDbSetPhyParameter(priv, priv->byBBType);
+		card_set_phy_parameter(priv, priv->byBBType);
 		bb_set_vga_gain_offset(priv, priv->bbvga[0]);
 	}
 
-- 
2.34.1

