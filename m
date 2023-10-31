Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DED67DC5F6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjJaFfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjJaFfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:35:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02128E4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc5b6d6228so10223805ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698730489; x=1699335289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvaPVxqSXSqOgVBO3lNlv/s8zA4GhoxNEgdJessNhBc=;
        b=ODPNU0lyEwQnJyWvmARgG9RGhanqhmp2QcdSwYJCzyP2ck+5/76MgZGGNN5fD6XaVo
         WbxwjCc8wkb8AxvI/uJaPa628VkT9dDrHWeCwYRLgZcNtcPnjv/Icq4i//kSee1K36Q9
         uX8T75huWoxCPw4wDqWknq4ORXIIj043UqUr0fbReTr5K7PMYrqOk+qV6WhEPSS59B3e
         uYGy3VtxDwypZ5cLZNsAgFzZwH6zynOPDTgXQfAnZ37bc32Cvyu8bTAN11o8rLsyY4T6
         64aqggOyagZqhZoYrFHUS0LJbOyjRDsYXqWxnbbThULwpVGyZLt7cRL+L+Y4AkF1J+bp
         1mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698730489; x=1699335289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvaPVxqSXSqOgVBO3lNlv/s8zA4GhoxNEgdJessNhBc=;
        b=Olx9tlbxbuv4KOf9RR6lvqrPMkZEp55Wm7Jyl+9F36OysV2jORy9355GP6/v6N30gE
         xtfTWWoFK+gAZFuXkyE26bzC8nNuBxpm9gL3LGSVUk03ok9Lir1Tw2eHIjLuiNZ0kTuj
         ruQHAvekGcmr1on8QrdBDuy6DS7vIg/0An5K90Jj/Nma+/YJpGiBECREcj1wUWxiH8YN
         NPlL/X8ibhCVB/bluvqfEjr4rR7TZTVcBxhIZmv/mF6flUyo7pNw5z+XfDEM2aUrKnqf
         vGBw8bffql93XS93LBiY1QPeGCK6mjqNuz1bmeid3JnglCF3QwVKTUBuf5a3A86Tv5oq
         vGVw==
X-Gm-Message-State: AOJu0YzIjyjwy6kmV29pJuzPzc6GWH8nmCltCSafFnWeZBNM4QZ8CiZS
        16m5ewbR2in3duBpWPWtVHmPR/ryNNE=
X-Google-Smtp-Source: AGHT+IFjkiiRbzMPbFkKbw0UuSWWbioMLoHDJ/cfzLo6pWToKmnfFAG+8B8wy0zBcpRjo5gUE7Es7g==
X-Received: by 2002:a17:903:245:b0:1ca:e05a:93a2 with SMTP id j5-20020a170903024500b001cae05a93a2mr11395438plh.32.1698730489442;
        Mon, 30 Oct 2023 22:34:49 -0700 (PDT)
Received: from ubuntu.. ([122.182.231.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001c0a414695bsm422211pld.43.2023.10.30.22.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:34:49 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 04/11] staging: vt6655: Type encoding info dropped from function name "CARDbSetBeaconPeriod"
Date:   Tue, 31 Oct 2023 11:04:27 +0530
Message-Id: <8d4c10ac86f80bb46d5cb1f18079276c3326e5dd.1698730318.git.opensource206@gmail.com>
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

function name "CARDbSetBeaconPeriod" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c        | 2 +-
 drivers/staging/vt6655/card.h        | 2 +-
 drivers/staging/vt6655/device_main.c | 2 +-
 drivers/staging/vt6655/rxtx.c        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 1edf65e2adcf..bfd02a869d64 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -320,7 +320,7 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
  *
  * Return Value: true if succeed; otherwise false
  */
-bool CARDbSetBeaconPeriod(struct vnt_private *priv,
+bool card_set_beacon_period(struct vnt_private *priv,
 			  unsigned short wBeaconInterval)
 {
 	u64 qwNextTBTT;
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index df1b9a7c1f21..f84e4190a2ac 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -56,7 +56,7 @@ void CARDbRadioPowerOff(struct vnt_private *priv);
 bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type);
 bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
 		    u64 bss_timestamp);
-bool CARDbSetBeaconPeriod(struct vnt_private *priv,
+bool card_set_beacon_period(struct vnt_private *priv,
 			  unsigned short wBeaconInterval);
 
 #endif /* __CARD_H__ */
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 7d297526e653..2e2a8da571ab 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1537,7 +1537,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 			card_update_tsf(priv, conf->beacon_rate->hw_value,
 				       conf->sync_tsf);
 
-			CARDbSetBeaconPeriod(priv, conf->beacon_int);
+			card_set_beacon_period(priv, conf->beacon_int);
 
 			CARDvSetFirstNextTBTT(priv, conf->beacon_int);
 		} else {
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 522d34ca9b0f..5e5ed582c35e 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1456,7 +1456,7 @@ int vnt_beacon_enable(struct vnt_private *priv, struct ieee80211_vif *vif,
 
 	CARDvSetFirstNextTBTT(priv, conf->beacon_int);
 
-	CARDbSetBeaconPeriod(priv, conf->beacon_int);
+	card_set_beacon_period(priv, conf->beacon_int);
 
 	return vnt_beacon_make(priv, vif);
 }
-- 
2.34.1

