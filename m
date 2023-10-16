Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCCC7CB6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjJPXBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjJPXBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:01:03 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E42B0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:01:00 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a877e0f0d8so13545297b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697497260; x=1698102060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izdWRaFanHQ8azSd91/9giaIXLaVsk5MY9ErGFWUe5M=;
        b=itSkmgYO0LkkoyZhZxW5jzhjRs2G8SJjUwuWcI9VCedQGd+wUhpbeW5B+mVTBQDPPT
         85mVTGyZja15ifCvnkk9KY961jWCkfTfdrNTEBrXNFRfEl/QtrHbwieDqZdQuzl03z0B
         NR2Q6NRboW5WvsnnFbAnBzBl5qGG2pY3cOrzqti0VKZjPIMAKpWn+zHGfo927LIvBOGi
         Q/PpvFRa//RkR3+poY/U5k+oD6uNauWh/6N5UlEf2kAlpEhT6BY3NMxLPYOynaOoCiTv
         a5lHnrtOOqxPYiuc9AGRimM/4crBJrH+tdaIoLNd7cGxYYaPKXC+ZhZLHB5gmH8jm91C
         D7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697497260; x=1698102060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izdWRaFanHQ8azSd91/9giaIXLaVsk5MY9ErGFWUe5M=;
        b=oH+boO9Uw45NpKq6bY46OcbqnbiNexxX5tNT2cmcdDzBofddFu3vcO/Z/AseY0OSns
         EPyyhlEgtUgdKDu814uD+v1zTy4Ui0+m7dxDBl3DM+5rsSXXhLFrjsxNKX9AQST9KSlN
         VhKuOLq4hU0/Ujc48oDyghimB5AjtxWclvD+0xFAMNh68H/CEqepXET1RaxWLvmU+K4V
         9+B6+2MC6IeYX5lWIFi6psUYH0mISIB98uOkoIeCLGQizBV/yy2VASz6STTJNXIcoNjR
         VCe7QxFf5dgaLeSqkUrXDm+TtoxEMCBF9/E1oR0EXrzsqUFGpUQ6q/ZC/UIpqadM5aR1
         Tqxg==
X-Gm-Message-State: AOJu0YxFyXQRFXwtnvTStTIjKRG4CUQIhMNVCdR6tKskuobSzeWlI4dU
        JbFZJUrMTBn5EbCOZWBBxMs=
X-Google-Smtp-Source: AGHT+IGrVAqh6QjbMlQ3vwhEyVA44SEHSnxHA6AsEjAtj9K68hmeeE0LdYwAZbDF0IhlVXgahW6Giw==
X-Received: by 2002:a81:a00c:0:b0:5a7:fcad:e865 with SMTP id x12-20020a81a00c000000b005a7fcade865mr141193ywg.2.1697497259815;
        Mon, 16 Oct 2023 16:00:59 -0700 (PDT)
Received: from gilbert-PC ([105.112.31.148])
        by smtp.gmail.com with ESMTPSA id m5-20020a81d245000000b005a815346d95sm91339ywl.71.2023.10.16.16.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 16:00:59 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 2/4] staging: vt6655: Rename variable byCurrentCh
Date:   Mon, 16 Oct 2023 23:58:55 +0100
Message-Id: <cd4c073d0e67e2ce6ed9f38a7add9bbd2fe760ce.1697495598.git.gilbertadikankwu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697495597.git.gilbertadikankwu@gmail.com>
References: <cover.1697495597.git.gilbertadikankwu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove byte Type encoding "by" from variable name and replace camelcase
with snakecase.

Mute checkpatch.pl error:

CHECK: Avoid CamelCase: <byCurrentCh>

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/vt6655/channel.c | 12 ++++++------
 drivers/staging/vt6655/device.h  |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index c11bc2dbc356..7b864136a0a8 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -82,7 +82,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 {
 	bool ret = true;
 
-	if (priv->byCurrentCh == ch->hw_value)
+	if (priv->current_ch == ch->hw_value)
 		return ret;
 
 	/* Set VGA to max sensitivity */
@@ -100,7 +100,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 	 * it is for better TX throughput
 	 */
 
-	priv->byCurrentCh = ch->hw_value;
+	priv->current_ch = ch->hw_value;
 	ret &= RFbSelectChannel(priv, priv->rf_type,
 				ch->hw_value);
 
@@ -117,9 +117,9 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 
 		/* set HW default power register */
 		VT6655_MAC_SELECT_PAGE1(priv->port_offset);
-		RFbSetPower(priv, RATE_1M, priv->byCurrentCh);
+		RFbSetPower(priv, RATE_1M, priv->current_ch);
 		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWRCCK);
-		RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
+		RFbSetPower(priv, RATE_6M, priv->current_ch);
 		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWROFDM);
 		VT6655_MAC_SELECT_PAGE0(priv->port_offset);
 
@@ -127,9 +127,9 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 	}
 
 	if (priv->byBBType == BB_TYPE_11B)
-		RFbSetPower(priv, RATE_1M, priv->byCurrentCh);
+		RFbSetPower(priv, RATE_1M, priv->current_ch);
 	else
-		RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
+		RFbSetPower(priv, RATE_6M, priv->current_ch);
 
 	return ret;
 }
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index b166d296b82d..b3ac6237010b 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -239,7 +239,7 @@ struct vnt_private {
 	bool bIsBeaconBufReadySet;
 	unsigned int	cbBeaconBufReadySetCnt;
 	bool bFixRate;
-	u16 byCurrentCh;
+	u16 current_ch;
 
 	bool bAES;
 
-- 
2.34.1

