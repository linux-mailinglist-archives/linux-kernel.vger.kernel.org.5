Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA77ACB99
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjIXT0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjIXT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:26:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1699BFA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c3c8adb27so637270066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695583575; x=1696188375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6KY3l38JJQzo0U3VJY6BsoHFoiqXvY2L3IXiGvOPS0=;
        b=YG/YrdAndp68NbzADNKsQ8L+51MCw/VI+NV3DxWnLt7OTCCS8Zs7ttfZrO4EGTa6Jk
         x9/IEuLfHMe39XKXudCXMTadRfJ7Ya/8lPsB+LlfpSCnwGANuStbXzB+mkyi1Pr1KGQo
         +nsRzQkYWYSvBi9yNk2SDqdAq3h7VFYfhROxp/2rGZm5sfm+vFDmKrJlCV+vfUwclwhq
         myN22M1kguKgDDTWcJYB77FA+FIyhAiuRZrJwIpW62N75kmJ6WIZGZnBR1FPWrdKg+sM
         T3cjctknNTiY62iTHnneIR24cMeoAu5cgLvaLKpdOn+RSiz3PAXJBtv2wTytJbxg+hWs
         xGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695583575; x=1696188375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6KY3l38JJQzo0U3VJY6BsoHFoiqXvY2L3IXiGvOPS0=;
        b=gPPeSGxhPSwsB4Hsp/hW6GM4kursh/hJDwBfDwHQef4xmWiIyson/CwM9zNqdnY/28
         MseK8mwr5cIlQBKWN6OQsVqxaQkBujOc8UEJAwcOqUt39sOF2481jTWf6IECBWjzW8oE
         4jBlA7eQDzc9SMkXL8d6IA8VLKpkK3UThv3MSnV2lk5BcfZoGqf78NNRAyaDdtK+duHI
         bmYUQJvTxztxsu6xd4FE2wJ+BPt8gWeUYgDuzzgepa1241DnI11Z53Bl1CAaTke7JKJT
         UO/vE71d1M0QSTIU+qq1u5YF+mn90+493k4uY5ED7ZVpQoizJmcQhV76A6cBlJRZ/8qK
         gXVw==
X-Gm-Message-State: AOJu0YxCcq+TclZXTsqKdWpVkA5FHdoPZ6MxjTU/RznmSlRB3rgeVs84
        LgaqJXtQ/4kfjPoAXCizEoE=
X-Google-Smtp-Source: AGHT+IF4uX/JM0VD6gvHTuHkWGbsMKKjWVglfewHDhBluusXbQjwKroAN2PZ5soeZgKDAFdDgJwZ1Q==
X-Received: by 2002:a17:906:3010:b0:9ae:513d:de22 with SMTP id 16-20020a170906301000b009ae513dde22mr4045355ejz.56.1695583575563;
        Sun, 24 Sep 2023 12:26:15 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b0099d0c0bb92bsm5317632eje.80.2023.09.24.12.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:26:15 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 3/7] drm/sun4i: dw-hdmi: Switch to bridge functions
Date:   Sun, 24 Sep 2023 21:26:00 +0200
Message-ID: <20230924192604.3262187-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
References: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
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

Since ddc-en property handling was moved from sun8i dw-hdmi driver to
display connector driver, probe order of drivers determines if EDID is
properly read at boot time or not.

In order to fix this, let's switch to bridge functions which allows us
to build proper chain and defer execution until all drivers are probed.

Fixes: 920169041baa ("drm/sun4i: dw-hdmi: Fix ddc-en GPIO consumer conflict")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 114 +++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h |   5 ++
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 8f8d3bdba5ce..93831cdf1917 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -8,14 +8,82 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_of.h>
 #include <drm/drm_simple_kms_helper.h>
 
+#include <media/cec-notifier.h>
+
 #include "sun8i_dw_hdmi.h"
 #include "sun8i_tcon_top.h"
 
+#define bridge_to_sun8i_dw_hdmi(x) \
+	container_of(x, struct sun8i_dw_hdmi, enc_bridge)
+
+static int sun8i_hdmi_enc_attach(struct drm_bridge *bridge,
+				 enum drm_bridge_attach_flags flags)
+{
+	struct sun8i_dw_hdmi *hdmi = bridge_to_sun8i_dw_hdmi(bridge);
+
+	return drm_bridge_attach(&hdmi->encoder, hdmi->hdmi_bridge,
+				 &hdmi->enc_bridge, flags);
+}
+
+static void sun8i_hdmi_enc_detach(struct drm_bridge *bridge)
+{
+	struct sun8i_dw_hdmi *hdmi = bridge_to_sun8i_dw_hdmi(bridge);
+
+	cec_notifier_conn_unregister(hdmi->cec_notifier);
+	hdmi->cec_notifier = NULL;
+}
+
+static void sun8i_hdmi_enc_hpd_notify(struct drm_bridge *bridge,
+				      enum drm_connector_status status)
+{
+	struct sun8i_dw_hdmi *hdmi = bridge_to_sun8i_dw_hdmi(bridge);
+	struct edid *edid;
+
+	if (!hdmi->cec_notifier)
+		return;
+
+	if (status == connector_status_connected) {
+		edid = drm_bridge_get_edid(hdmi->hdmi_bridge, hdmi->connector);
+		if (edid)
+			cec_notifier_set_phys_addr_from_edid(hdmi->cec_notifier,
+							     edid);
+	} else {
+		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
+	}
+}
+
+static int sun8i_hdmi_enc_atomic_check(struct drm_bridge *bridge,
+				       struct drm_bridge_state *bridge_state,
+				       struct drm_crtc_state *crtc_state,
+				       struct drm_connector_state *conn_state)
+{
+	struct drm_connector_state *old_conn_state =
+		drm_atomic_get_old_connector_state(conn_state->state,
+						   conn_state->connector);
+
+	if (!drm_connector_atomic_hdr_metadata_equal(old_conn_state, conn_state))
+		crtc_state->mode_changed = true;
+
+	return 0;
+}
+
+static const struct drm_bridge_funcs sun8i_hdmi_enc_bridge_funcs = {
+	.attach = sun8i_hdmi_enc_attach,
+	.detach = sun8i_hdmi_enc_detach,
+	.hpd_notify = sun8i_hdmi_enc_hpd_notify,
+	.atomic_check = sun8i_hdmi_enc_atomic_check,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+};
+
 static void sun8i_dw_hdmi_encoder_mode_set(struct drm_encoder *encoder,
 					   struct drm_display_mode *mode,
 					   struct drm_display_mode *adj_mode)
@@ -99,6 +167,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_hdmi_plat_data *plat_data;
+	struct cec_connector_info conn_info;
+	struct drm_connector *connector;
 	struct drm_device *drm = data;
 	struct device_node *phy_node;
 	struct drm_encoder *encoder;
@@ -187,18 +257,57 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 
 	plat_data->mode_valid = hdmi->quirks->mode_valid;
 	plat_data->use_drm_infoframe = hdmi->quirks->use_drm_infoframe;
+	plat_data->output_port = 1;
 	sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
 
 	platform_set_drvdata(pdev, hdmi);
 
-	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
+	hdmi->hdmi = dw_hdmi_probe(pdev, plat_data);
 	if (IS_ERR(hdmi->hdmi)) {
 		ret = PTR_ERR(hdmi->hdmi);
 		goto err_deinit_phy;
 	}
 
+	hdmi->hdmi_bridge = of_drm_find_bridge(dev->of_node);
+
+	hdmi->enc_bridge.funcs = &sun8i_hdmi_enc_bridge_funcs;
+	hdmi->enc_bridge.type = DRM_MODE_CONNECTOR_HDMIA;
+	hdmi->enc_bridge.interlace_allowed = true;
+
+	drm_bridge_add(&hdmi->enc_bridge);
+
+	ret = drm_bridge_attach(encoder, &hdmi->enc_bridge, NULL,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret)
+		goto err_remove_dw_hdmi;
+
+	connector = drm_bridge_connector_init(drm, encoder);
+	if (IS_ERR(connector)) {
+		dev_err(dev, "Unable to create HDMI bridge connector\n");
+		ret = PTR_ERR(connector);
+		goto err_remove_dw_hdmi;
+	}
+
+	hdmi->connector = connector;
+	drm_connector_attach_encoder(connector, encoder);
+
+	if (hdmi->quirks->use_drm_infoframe)
+		drm_connector_attach_hdr_output_metadata_property(connector);
+
+	cec_fill_conn_info_from_drm(&conn_info, connector);
+
+	hdmi->cec_notifier = cec_notifier_conn_register(&pdev->dev, NULL,
+							&conn_info);
+	if (!hdmi->cec_notifier) {
+		ret = -ENOMEM;
+		goto err_remove_dw_hdmi;
+	}
+
 	return 0;
 
+err_remove_dw_hdmi:
+	drm_bridge_remove(&hdmi->enc_bridge);
+	dw_hdmi_remove(hdmi->hdmi);
 err_deinit_phy:
 	sun8i_hdmi_phy_deinit(hdmi->phy);
 err_disable_clk_tmds:
@@ -216,7 +325,8 @@ static void sun8i_dw_hdmi_unbind(struct device *dev, struct device *master,
 {
 	struct sun8i_dw_hdmi *hdmi = dev_get_drvdata(dev);
 
-	dw_hdmi_unbind(hdmi->hdmi);
+	drm_bridge_remove(&hdmi->enc_bridge);
+	dw_hdmi_remove(hdmi->hdmi);
 	sun8i_hdmi_phy_deinit(hdmi->phy);
 	clk_disable_unprepare(hdmi->clk_tmds);
 	reset_control_assert(hdmi->rst_ctrl);
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index ab80d52a70bb..18ffc1b4841f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -7,6 +7,7 @@
 #define _SUN8I_DW_HDMI_H_
 
 #include <drm/bridge/dw_hdmi.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_encoder.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
@@ -178,9 +179,13 @@ struct sun8i_dw_hdmi_quirks {
 };
 
 struct sun8i_dw_hdmi {
+	struct cec_notifier		*cec_notifier;
 	struct clk			*clk_tmds;
+	struct drm_connector		*connector;
 	struct device			*dev;
+	struct drm_bridge		enc_bridge;
 	struct dw_hdmi			*hdmi;
+	struct drm_bridge		*hdmi_bridge;
 	struct drm_encoder		encoder;
 	struct sun8i_hdmi_phy		*phy;
 	struct dw_hdmi_plat_data	plat_data;
-- 
2.42.0

