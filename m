Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9E17D92B0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345815AbjJ0IxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345693AbjJ0Iwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:52:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457B01723
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so1819440b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396756; x=1699001556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvpMScDdDG387wBvMeNnvct2F1PCbiwjBCPhHD21wro=;
        b=WB155agJtdnVBeubsDeaSUd8RUtfOr2NRONEhtZ2TEvOhtcp8/aXxutecsrV/HedUc
         rhxgbTEwOfkYZsTeX27t8nQ3rzDk6PHrzdbVCO9dgY4LtOSaKjyNmGmZ4AcfKuTiTPV7
         OzhizQL4LpF5WB4LJB/RQY/Q/NUsT9cTpeSecmdHz2v7HBB8ROInIyqw4DLgivBv7bP0
         3eSNMUGhefR7CryXI+W06B78wrdsvigPr3DXTYIARbn6eJaam6orYtvlv5pB+AXEdA1P
         jLwCpqdyQp9DPNCDfgMpL6waDRSlzufR/rO2snWjXMAFnUN+SLOjzV1HMQX/X+4HYuVk
         N+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396756; x=1699001556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvpMScDdDG387wBvMeNnvct2F1PCbiwjBCPhHD21wro=;
        b=hh/k+23gwOEFqVKZFxNXIT/94B3rIiuUXRIKj11IwVBP3FnfNV3bypp04uZpYutB02
         vmowSirpIXAJQN/M2Z+jWJjaZste1sNrwcqEJSJx9Pq9aB2q1vX/n/vW0PqEpB1oz9gu
         1Bvadp2OvySU1MLlOAVU2ddpjuakmbuHqerdGDbBMMx6uxaDxYjaQQyJ1CmDMUrspWPh
         Z5jErJOyaCrh3jmR6YcsvPHasZwJ/V2OGDVjgnNiNs2Cmz8EgsBEJ4jvhcIgsKoSW6d3
         1v5QVWoBMAYBMv5QmVOX/XpRZHfyGfB8Q9o36PYXIyd+9B9TQ8XtDvXtSzC+3HlxOo8H
         6kPw==
X-Gm-Message-State: AOJu0Yx/p5oh9xSNcVB7ZFwGz3yDnbancgJmWMemDsSTYzgPdYbMdCi1
        XvbwWadc+WvWkwvrxh/G5F8=
X-Google-Smtp-Source: AGHT+IEaNgTqwV+EzUB+ZTPKQngqHaOIsZrmocG2meOJs90Ubs+MF253hzAaHpFMEBsysyQlJgcQ8Q==
X-Received: by 2002:a05:6a00:1504:b0:6be:5a1a:3bb8 with SMTP id q4-20020a056a00150400b006be5a1a3bb8mr2219989pfu.28.1698396755778;
        Fri, 27 Oct 2023 01:52:35 -0700 (PDT)
Received: from ubuntu.. ([122.174.106.169])
        by smtp.gmail.com with ESMTPSA id h12-20020a63b00c000000b0055c178a8df1sm698825pgf.94.2023.10.27.01.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:52:35 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 09/10] staging: vt6655: Type encoding info dropped from function name "CARDbUpdateTSF"
Date:   Fri, 27 Oct 2023 14:21:58 +0530
Message-Id: <926ec04bbfc69926cd1af92684fef392f2d6e04a.1698396278.git.opensource206@gmail.com>
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

function name "CARDbUpdateTSF" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c        | 2 +-
 drivers/staging/vt6655/card.h        | 2 +-
 drivers/staging/vt6655/device_main.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 56beaf6de488..ebb96b4c9406 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -287,7 +287,7 @@ bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type)
  *
  * Return Value: none
  */
-bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
+bool card_update_tsf(struct vnt_private *priv, unsigned char byRxRate,
 		    u64 qwBSSTimestamp)
 {
 	u64 local_tsf;
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index b36e276c699b..caf72892c1cd 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -54,7 +54,7 @@ void CARDvSafeResetTx(struct vnt_private *priv);
 void CARDvSafeResetRx(struct vnt_private *priv);
 void CARDbRadioPowerOff(struct vnt_private *priv);
 bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type);
-bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
+bool card_update_tsf(struct vnt_private *priv, unsigned char byRxRate,
 		    u64 qwBSSTimestamp);
 bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 			  unsigned short wBeaconInterval);
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 17a323800ce9..7d297526e653 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1534,7 +1534,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & (BSS_CHANGED_ASSOC | BSS_CHANGED_BEACON_INFO) &&
 	    priv->op_mode != NL80211_IFTYPE_AP) {
 		if (vif->cfg.assoc && conf->beacon_rate) {
-			CARDbUpdateTSF(priv, conf->beacon_rate->hw_value,
+			card_update_tsf(priv, conf->beacon_rate->hw_value,
 				       conf->sync_tsf);
 
 			CARDbSetBeaconPeriod(priv, conf->beacon_int);
-- 
2.34.1

