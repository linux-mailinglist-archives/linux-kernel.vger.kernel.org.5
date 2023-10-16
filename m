Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7357CB6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjJPXBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjJPXA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:00:58 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA59E95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:00:56 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7b91faf40so61634117b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697497256; x=1698102056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvY9x6aBvA5MhVJoRQNQEJ+7ebQbs2N9TXM39yrfeHo=;
        b=RCg+H7rOf7XUbhcJot1dUktuZjxdMk3FSaXg3FTYN3EncGULLdh4aHjtLOFCVa51UY
         NXlngkxkk3C28lRoOTcL/YjoBl9PPe4Nh4zrFaO0gcyreEMzxOSFlDLzZGBzBvkNbJMa
         OQsYxlR7c9RK7xu0Ge7dv1JVw+C1n0NOly6QaDH6oF8iSJvMCf1OF78F9KAx7I/+tLwP
         fh0DY2Dc5svyUz8Yjr1HhMMfv90HUOvGgA5Y9pei/HEdEPPpA48TbcJjkka2AzVpiY4s
         HuryKhJO3tCpeP0XK70BGxaH78/uevPOoFJ5Q2Xj34IPEVbAUG8BDRiygvwykb4w5kDR
         Ssxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697497256; x=1698102056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvY9x6aBvA5MhVJoRQNQEJ+7ebQbs2N9TXM39yrfeHo=;
        b=dja20R+f9ilNlqdxZozkMjz52uugjPSTAp12K3TXPPoeTdNSbkrvXlQDDntns0R5ga
         NeDNHJMyiUsap5KdF/ag+UJbVvt2H3UfXLFvD8XbwSDMvU7uyqo5Cm6GIT3IPMbePj3G
         DcbhOmpz3d4ppr/HlaGy3Z9+9y+rZ/wRyubVdRL4qMWQsU/knSgWkDsKiqkFPpv28Ylz
         3qFdT1U3j2U7BLnAupzJHuBfFBAikosU9eCr4ADXGeepu8atHWkKHHKn6PibPx3XDw+F
         u1Adbgp53q4pdDQ0gZLc8ILBPnCVc1oxcRbJaMWsoANVs9OhSRcG5rLS5BEMdJr0lqAJ
         iSsw==
X-Gm-Message-State: AOJu0YzugXuRQPqA5Wm16wQogKkd6f4P/e1jguE+Ht10kF/9bGkBB1f+
        b+AyMr8jvp/ZnXMgPyIXeas=
X-Google-Smtp-Source: AGHT+IHjqvoXh40B/Ns6QYkyASI6g7L5vFNMOPQNBGRRK9uL0NQ3Y0shU76D60JmzTdPjFPMIkNyEw==
X-Received: by 2002:a05:690c:84:b0:5a7:bc5d:125e with SMTP id be4-20020a05690c008400b005a7bc5d125emr622974ywb.38.1697497256042;
        Mon, 16 Oct 2023 16:00:56 -0700 (PDT)
Received: from gilbert-PC ([105.112.31.148])
        by smtp.gmail.com with ESMTPSA id i195-20020a816dcc000000b005a7f676f305sm88672ywc.106.2023.10.16.16.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 16:00:55 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 1/4] staging: vt6655: Rename variable bUpdateBBVGA
Date:   Mon, 16 Oct 2023 23:58:54 +0100
Message-Id: <9bd935c464671db2654c654964812cc48f4603d3.1697495598.git.gilbertadikankwu@gmail.com>
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

Remove bool Type encoding "b" from variable name and replace camelcase
with snakecase.

Mute checkpatch.pl error:

CHECK: Avoid CamelCase: <bUpdateBBVGA>

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/vt6655/baseband.c    | 2 +-
 drivers/staging/vt6655/channel.c     | 2 +-
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 7d47b266b87e..f7824396c5ff 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2087,7 +2087,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		/* {{ RobertYu: 20050104 */
 	} else {
 		/* No VGA Table now */
-		priv->bUpdateBBVGA = false;
+		priv->update_bbvga = false;
 		priv->bbvga[0] = 0x1C;
 	}
 
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index 6ac7d470c041..c11bc2dbc356 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -86,7 +86,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 		return ret;
 
 	/* Set VGA to max sensitivity */
-	if (priv->bUpdateBBVGA &&
+	if (priv->update_bbvga &&
 	    priv->bbvga_current != priv->bbvga[0]) {
 		priv->bbvga_current = priv->bbvga[0];
 
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 68bfadacfa7c..b166d296b82d 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -246,7 +246,7 @@ struct vnt_private {
 	unsigned char byAutoFBCtrl;
 
 	/* For Update BaseBand VGA Gain Offset */
-	bool bUpdateBBVGA;
+	bool update_bbvga;
 	unsigned int	uBBVGADiffCount;
 	unsigned char bbvga_new;
 	unsigned char bbvga_current;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index b08fcf7e6edc..b654fc24d725 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -179,7 +179,7 @@ device_set_options(struct vnt_private *priv)
 	priv->byBBType = priv->opts.bbp_type;
 	priv->byPacketType = priv->byBBType;
 	priv->byAutoFBCtrl = AUTO_FB_0;
-	priv->bUpdateBBVGA = true;
+	priv->update_bbvga = true;
 	priv->preamble_type = 0;
 
 	pr_debug(" byShortRetryLimit= %d\n", (int)priv->byShortRetryLimit);
@@ -423,7 +423,7 @@ static void device_init_registers(struct vnt_private *priv)
 	/* initialize BBP registers */
 	bb_vt3253_init(priv);
 
-	if (priv->bUpdateBBVGA) {
+	if (priv->update_bbvga) {
 		priv->bbvga_current = priv->bbvga[0];
 		priv->bbvga_new = priv->bbvga_current;
 		bb_set_vga_gain_offset(priv, priv->bbvga[0]);
@@ -1040,7 +1040,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 	long dbm;
 	int i;
 
-	if (!priv->bUpdateBBVGA)
+	if (!priv->update_bbvga)
 		return;
 
 	if (priv->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
-- 
2.34.1

