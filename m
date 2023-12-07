Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DA2808D21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443766AbjLGPyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443785AbjLGPxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:53:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5AF2D4E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:51:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF4FC433BD;
        Thu,  7 Dec 2023 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701964279;
        bh=1We2UZx5ZDbQPKfDfMqOP+mc5xLMdSsl/KcWM2D6+wE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=SHyNH22fXWqD6K2WzHGm1reK1De82pQc69qwhJMSx7w4vrWXRCxnZ//ya/DmJPGAU
         PcuGwVUYVOVt7VEDmNQDQipQKdSJP684ypbtURJqCDkUMx/TVp8fav4YrPR/aYeKUo
         VlIqK9qnKKHXRkHFLxZy6vJEuFXpS5vIm3jqjMHAuyvp0up6n2Siqu9upgOo+N0fN0
         Fwqyuv/ZQC/bMHEZl6f0A404XA/5MennZHMYJR2IlytxuvOW1M5gUkntVT2YOpiYbj
         4ffjBsfZ/Mwz4+HUxmuqKhGbYV13Y4Dj5k1ZlW39eeaNAngloVZ0f9PApkRzOOVje/
         0UCnH4oyIotPA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 07 Dec 2023 16:50:01 +0100
Subject: [PATCH v5 38/44] drm/rockchip: inno_hdmi: Remove unused drm device
 pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-kms-hdmi-connector-state-v5-38-6538e19d634d@kernel.org>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
In-Reply-To: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1We2UZx5ZDbQPKfDfMqOP+mc5xLMdSsl/KcWM2D6+wE=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmFL9s8+Dfstffv7H7r3v14If+W1xOkXxy6K77CsefG/
 kkF2x6e7yhlYRDjYpAVU2SJETZfEndq1utONr55MHNYmUCGMHBxCsBEGOIZGVby29hO4uf+e8NG
 Q+LRtfWN+31drrV7nZsl+iL8t4SnmjHD/5j+5qM57WtWC2rf4daOUtnK+e2c5J/rGszCn5Z8W+i
 7jBsA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_dev field in the inno_hdmi struct stores a pointer to the DRM
device but is never used anywhere in the driver. Let's remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 77b530f377c0..0f3ec6eaf270 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -39,7 +39,6 @@ struct inno_hdmi_i2c {
 
 struct inno_hdmi {
 	struct device *dev;
-	struct drm_device *drm_dev;
 
 	int irq;
 	struct clk *pclk;
@@ -648,7 +647,6 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 		return -ENOMEM;
 
 	hdmi->dev = dev;
-	hdmi->drm_dev = drm;
 
 	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdmi->regs))

-- 
2.43.0

