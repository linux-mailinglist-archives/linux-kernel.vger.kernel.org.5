Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977DA7FB7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344463AbjK1K2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjK1K2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:28:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1B219AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:25:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CADC433CA;
        Tue, 28 Nov 2023 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701167154;
        bh=49oNkv+eu8/9sfrO1BY+OxAGBqGgL52MLLkCN1HQuy0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=czeAh0Sn3LJXVE9DdOC9E2o8aegC2m3C4MaUobLgw6Pd6EkHcizemTiiBbF4a03uk
         grRn7WuJuXlgpZy9PLGYXE6U+GmVkgw2TDBoN8+m5ZtSlgJJUHzDA9FmGrdE0yJKcV
         J6OA4UFxzw4trrdDFldRDqPm9erovqqmxUN+Y7IzuOUtn6ii7ufBeM/Vz0MkrtI/RT
         tv2uFwYQ7r23BOfvVYTVkrdVk/LYMJNnFv612PmwReMwL+2sJ9Q1R10aq3SmhEXLj+
         EiKHPqRQtiaUm2/+ty8151Gf88jU+30dYyolUOjfCTB0IQ7NAO7VASoiZyIp27+tzV
         riF3z0KvlzyJw==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Tue, 28 Nov 2023 11:24:43 +0100
Subject: [PATCH v4 32/45] drm/rockchip: inno_hdmi: Remove useless enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-kms-hdmi-connector-state-v4-32-c7602158306e@kernel.org>
References: <20231128-kms-hdmi-connector-state-v4-0-c7602158306e@kernel.org>
In-Reply-To: <20231128-kms-hdmi-connector-state-v4-0-c7602158306e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=mripard@kernel.org;
 h=from:subject:message-id; bh=49oNkv+eu8/9sfrO1BY+OxAGBqGgL52MLLkCN1HQuy0=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmp+y+5XF8fLPQ3KnC9q1aMzJ1tJ+e4XzimdGPP5Y4Ws
 32b59xZ2VHKwiDGxSArpsgSI2y+JO7UrNedbHzzYOawMoEMYeDiFICJ+Gxn+KcVdules+vTiJqP
 ur9nPGbeeIjRnkt3fdkSlz1S98zPT0tk+O8wS3MPn33hTjPbDTccXZ9IXJtm93px6YKX0y/vzFy
 hv4oNAA==
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

The CSC_* enum has no users left, so let's remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index c342bc8b3a23..f05417c6b637 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -66,15 +66,6 @@ static struct inno_hdmi *connector_to_inno_hdmi(struct drm_connector *connector)
 	return container_of(connector, struct inno_hdmi, connector);
 }
 
-enum {
-	CSC_ITU601_16_235_TO_RGB_0_255_8BIT,
-	CSC_ITU601_0_255_TO_RGB_0_255_8BIT,
-	CSC_ITU709_16_235_TO_RGB_0_255_8BIT,
-	CSC_RGB_0_255_TO_ITU601_16_235_8BIT,
-	CSC_RGB_0_255_TO_ITU709_16_235_8BIT,
-	CSC_RGB_0_255_TO_RGB_16_235_8BIT,
-};
-
 static const char coeff_csc[][24] = {
 	/*
 	 * YUV2RGB:601 SD mode(Y[16:235], UV[16:240], RGB[0:255]):

-- 
2.41.0

