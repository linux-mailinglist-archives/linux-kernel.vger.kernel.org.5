Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BB580734A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442314AbjLFPFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442302AbjLFPFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:05:15 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2617CB5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:05:21 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-332fd78fa9dso792693f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 07:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701875119; x=1702479919; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwMf7u3p+RDwOM148aayiXMLKhs7CLyC1S19yofYD4k=;
        b=gbxEfaVsmGL+nnmZc76/sZqBIMNdLzVRh0CPgYb27gtd3EQ1SCKi/eYbl4MKhWrd3v
         qiXO36nUN+QC2fXHViUcjpj3g50gtmrbwS4EfsbTQsASluESePe3PFILigu2lVsGU2rn
         NhjqK0QuqJ9TaH2QrxzWV6Yi6/tK5jzd8ReEOV5l16yxra76eeu/XcZJsj3i8HzovqIB
         dYoVxnN8oF3TAN9jID+TMZ5W73VZuukpZjLt8iTGiEiNY7uyn3PqLworGVmhvwRPXIJX
         Un7cBe2a4ItvFmDXkZ4kcyWGUySEzmTgrEefnc4+DWpJeCjRcHBWuMLMBRwsdh/1s3iN
         YOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875119; x=1702479919;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwMf7u3p+RDwOM148aayiXMLKhs7CLyC1S19yofYD4k=;
        b=P16b5Dg0/gBDTz2tiq5snCwKSdZJ98rG5ZgMatvI4T0PXKqROIajN4q7j2G6m4cDaD
         x4jcMx7qqnkLI/GUAqw6mqR3nf45l0q4Idfah2XUCvf3EM2b1t6u+OqMK5sAZxJDzTYg
         U8NZPM8d4TtVn3Kr5AALEovi32InItYykQQOHH8OqOfk9nXCyQDRIOcTVUiLpSgcXMu0
         lsCLAELoc0tcEDdMEQJjMjeNB7W484L7Mz2oXma7S2Lyiudw9o5mec4zL/85pbaniCw5
         ISdec6BDD7yTqbjAegvYXxm5l6MsN2EIXbqSnXJKvfCIhVTl1D8C35Z0gWQ01R41/wFX
         72oA==
X-Gm-Message-State: AOJu0YzZrCOrOlHfT2LiLabYDjS6bQUtxgAgGZl5J/YgrPy/CQ36tDL6
        mo7YXNKox5l3usn5i/au6WLjVbVDHycJ7eyZpYs=
X-Google-Smtp-Source: AGHT+IHxmKeit4iuxsVLMovMf5KGrF2Z3fWMEQdwveHfUOweVd3Xp0JZ1c0kBbI5qx1jEzp8P/Navw==
X-Received: by 2002:a5d:564a:0:b0:333:387b:687a with SMTP id j10-20020a5d564a000000b00333387b687amr280196wrw.199.1701875119471;
        Wed, 06 Dec 2023 07:05:19 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o14-20020a056000010e00b00333359b522dsm12772792wrx.77.2023.12.06.07.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:05:19 -0800 (PST)
Date:   Wed, 6 Dec 2023 18:05:15 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/bridge: nxp-ptn3460: simplify some error checking
Message-ID: <04242630-42d8-4920-8c67-24ac9db6b3c9@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c_master_send/recv() functions return negative error codes or
they return "len" on success.  So the error handling here can be written
as just normal checks for "if (ret < 0) return ret;".  No need to
complicate things.

Btw, in this code the "len" parameter can never be zero, but even if
it were, then I feel like this would still be the best way to write it.

Fixes: 914437992876 ("drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is not really a bug fix but I added a Fixes tag because I don't
want people to pull my other commit without also applying this.

 drivers/gpu/drm/bridge/nxp-ptn3460.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index 9b7eb8c669c1..7c0076e49953 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -54,15 +54,15 @@ static int ptn3460_read_bytes(struct ptn3460_bridge *ptn_bridge, char addr,
 	int ret;
 
 	ret = i2c_master_send(ptn_bridge->client, &addr, 1);
-	if (ret <= 0) {
+	if (ret < 0) {
 		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
-		return ret ?: -EIO;
+		return ret;
 	}
 
 	ret = i2c_master_recv(ptn_bridge->client, buf, len);
-	if (ret != len) {
+	if (ret < 0) {
 		DRM_ERROR("Failed to recv i2c data, ret=%d\n", ret);
-		return ret < 0 ? ret : -EIO;
+		return ret;
 	}
 
 	return 0;
@@ -78,9 +78,9 @@ static int ptn3460_write_byte(struct ptn3460_bridge *ptn_bridge, char addr,
 	buf[1] = val;
 
 	ret = i2c_master_send(ptn_bridge->client, buf, ARRAY_SIZE(buf));
-	if (ret != ARRAY_SIZE(buf)) {
+	if (ret < 0) {
 		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
-		return ret < 0 ? ret : -EIO;
+		return ret;
 	}
 
 	return 0;
-- 
2.42.0

