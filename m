Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6699C7FB7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344381AbjK1K2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjK1K1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:27:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27411272C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:25:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEC4C433C9;
        Tue, 28 Nov 2023 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701167142;
        bh=612NFeh5NOImp0JEmAQppe78uklCbIwDoN+fmJSIsz0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=AXCbVrahNOyYPaCP7KvVfnt/lQ+45UqHlD/+LNjqAOQUSUfvLSuiw4TjyF07eU2Ed
         4gyLkJVh2cLzA7nIJ13kPGaM6OZ/0EnpqPP3aSnYLIWd/0jkWfB58uDIuUfTaDzLzQ
         G6MDk31XIs3t47aCNy7whCaeTvzSrASGVWqQcrNZlfnGnnu/6VWhWkZ3i1RqnlYdAh
         S7ZtjNKRDhfdsMq+4tBnLj/7A+WdGa+Gi3YJC9GK4PWEK0vCkrMcjgj6R/64gLVGoZ
         954YgYGJmwnpi9Jt10KQBUzBKD0UMNjFfJJdprzUNoOYCgHOudtlBv3DI8eIkcsh49
         ViXHYRibXL0eQ==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Tue, 28 Nov 2023 11:24:39 +0100
Subject: [PATCH v4 28/45] drm/rockchip: inno_hdmi: Remove unneeded has
 audio flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-kms-hdmi-connector-state-v4-28-c7602158306e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=mripard@kernel.org;
 h=from:subject:message-id; bh=612NFeh5NOImp0JEmAQppe78uklCbIwDoN+fmJSIsz0=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmp+y/1HmmwYJ3OvvSsUKBFpVXstaQ1UnKLJQ0Oan49a
 f/psnBeRykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACaiMJeRoSX/ld6ND45pIcWn
 WyMO55yOX6BzI6Nhmfx57/U5UU1hKYwM3a+8NDkiLjh5zZFNy1u76tGdyvyZouy6IqdeOJfM3Gj
 ABwA=
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

The sink_has_audio flag is not used anywhere in the driver so let's get
rid of it. It's redundant with drm_display_info.has_audio anyway.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 294f0d442c0c..3908dc09d85f 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -28,7 +28,6 @@
 #include "inno_hdmi.h"
 
 struct hdmi_data_info {
-	bool sink_has_audio;
 	unsigned int enc_in_format;
 	unsigned int enc_out_format;
 	unsigned int colorimetry;
@@ -554,7 +553,6 @@ static int inno_hdmi_connector_get_modes(struct drm_connector *connector)
 
 	edid = drm_get_edid(connector, hdmi->ddc);
 	if (edid) {
-		hdmi->hdmi_data.sink_has_audio = drm_detect_monitor_audio(edid);
 		drm_connector_update_edid_property(connector, edid);
 		ret = drm_add_edid_modes(connector, edid);
 		kfree(edid);

-- 
2.41.0

