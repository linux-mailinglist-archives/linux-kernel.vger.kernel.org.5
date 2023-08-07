Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC237727E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjHGOfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjHGOfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:35:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544010F3;
        Mon,  7 Aug 2023 07:35:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-977e0fbd742so631679266b.2;
        Mon, 07 Aug 2023 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691418936; x=1692023736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTMdpVu9zcROFMVsz6T+C+h5mIKmLtZWdHwxQBCPR5I=;
        b=KUaH/j2FWhExXriqrgGp81CVqFpEVbCRXw9lnyy+yw1JSm5hZeS+F54n636UGRJVCN
         2zvlFL2tEiwc2qS/7d/rxTLwAw8kBI2y3yCFhNukIRH8uM5t+SRwbTsnFD54N7NG8RGH
         KpntJwT+9KcreOlQCoNTb61JEIX7VdcgaBpqoVG56+JyoVO5Kp4G/Qy4xm2VH2XrO+El
         JY09CQ7/yM6L4rNf0QGu4GDeE3CFatQO47ZhwNYoG/trkEiEb5LPe/VfprY0p+xvhndY
         Htc5Ow23M+m/40pBS2hnFNshKoPImXIe6rwxM9c7WLvX8hgP5Y+UBFCL58InhqIPniYM
         F5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691418936; x=1692023736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTMdpVu9zcROFMVsz6T+C+h5mIKmLtZWdHwxQBCPR5I=;
        b=Pzu/ueSefg0qhTIDuiVGXAEuQXx2dSOyU0niaZHgElzwJZ7VmeYO+blXdAREgJpVPn
         /O2AMsIPcETSHPeK3bvusJLouckdwAkVUkm0kGmeyZ5AjkMmcfGvOcd5eVHYOVvGOCGi
         EBNmsJmgkDoM8Zz9woDMpn4IJA7uXw5e0QfNIF8tA8mJtypG4teFxlKtwPEk08/O159K
         O2Gxgs/t+UaSlwnne3/+gbR9f2IMMVRGTflXf1JV0Bvf9bUglmsNhKxfK9WKUogZsl0h
         jsiIs7qFZhPl2DOkQkqt9AoMGQs4qUOpU5SrBqGsgwjQF4LLnp/Ufk9qd8Wacai5Z3zB
         2xoQ==
X-Gm-Message-State: AOJu0Yx3VBjvamtptyoU4zaKjnWzcj1PkFzu+6iKuhNHRdlIInMJzITA
        UKYp/d9Jzg3fNFnJN8XMSksSS3CkerrL7A==
X-Google-Smtp-Source: AGHT+IGQ1lqLcjO4Et6eFn4qj6/uvvM6vC3EoXEaBwbhdywyvi3G+qSDQy3V4lA/QsqxymJGrvt1JA==
X-Received: by 2002:a17:906:32c6:b0:997:870d:e8fa with SMTP id k6-20020a17090632c600b00997870de8famr7811483ejk.1.1691418935876;
        Mon, 07 Aug 2023 07:35:35 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906504300b0099329b3ab67sm5323292ejk.71.2023.08.07.07.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:35:35 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] drm/tegra: output: hdmi: Support bridge/connector
Date:   Mon,  7 Aug 2023 17:35:14 +0300
Message-Id: <20230807143515.7882-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807143515.7882-1-clamor95@gmail.com>
References: <20230807143515.7882-1-clamor95@gmail.com>
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

From: Maxim Schwalm <maxim.schwalm@gmail.com>

Some Tegra device-trees may specify a video output graph, which involves
MHL bridge/simple bridge and/or connector framework. This patch adds
support for the bridge/connector attached to the HDMI output, allowing
us to model the hardware properly.

Inspired by: 29efdc2 ("drm/tegra: output: rgb: Support LVDS encoder bridge")

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS TF T30
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # ASUS P1801-T T30
Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101 T20
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201 T30
Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/hdmi.c | 44 +++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 6eac54ae1205..a5b12b169e57 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -19,6 +19,7 @@
 #include <soc/tegra/common.h>
 #include <sound/hdmi-codec.h>
 
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_debugfs.h>
@@ -1544,26 +1545,47 @@ static int tegra_hdmi_init(struct host1x_client *client)
 {
 	struct tegra_hdmi *hdmi = host1x_client_to_hdmi(client);
 	struct drm_device *drm = dev_get_drvdata(client->host);
+	struct drm_connector *connector;
 	int err;
 
 	hdmi->output.dev = client->dev;
 
-	drm_connector_init_with_ddc(drm, &hdmi->output.connector,
-				    &tegra_hdmi_connector_funcs,
-				    DRM_MODE_CONNECTOR_HDMIA,
-				    hdmi->output.ddc);
-	drm_connector_helper_add(&hdmi->output.connector,
-				 &tegra_hdmi_connector_helper_funcs);
-	hdmi->output.connector.dpms = DRM_MODE_DPMS_OFF;
-
 	drm_simple_encoder_init(drm, &hdmi->output.encoder,
 				DRM_MODE_ENCODER_TMDS);
 	drm_encoder_helper_add(&hdmi->output.encoder,
 			       &tegra_hdmi_encoder_helper_funcs);
 
-	drm_connector_attach_encoder(&hdmi->output.connector,
-					  &hdmi->output.encoder);
-	drm_connector_register(&hdmi->output.connector);
+	if (hdmi->output.bridge) {
+		err = drm_bridge_attach(&hdmi->output.encoder, hdmi->output.bridge,
+					NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+		if (err) {
+			dev_err(client->dev, "failed to attach bridge: %d\n",
+				err);
+			return err;
+		}
+
+		connector = drm_bridge_connector_init(drm, &hdmi->output.encoder);
+		if (IS_ERR(connector)) {
+			dev_err(client->dev,
+				"failed to initialize bridge connector: %pe\n",
+				connector);
+			return PTR_ERR(connector);
+		}
+
+		drm_connector_attach_encoder(connector, &hdmi->output.encoder);
+	} else {
+		drm_connector_init_with_ddc(drm, &hdmi->output.connector,
+					    &tegra_hdmi_connector_funcs,
+					    DRM_MODE_CONNECTOR_HDMIA,
+					    hdmi->output.ddc);
+		drm_connector_helper_add(&hdmi->output.connector,
+					 &tegra_hdmi_connector_helper_funcs);
+		hdmi->output.connector.dpms = DRM_MODE_DPMS_OFF;
+
+		drm_connector_attach_encoder(&hdmi->output.connector,
+					     &hdmi->output.encoder);
+		drm_connector_register(&hdmi->output.connector);
+	}
 
 	err = tegra_output_init(drm, &hdmi->output);
 	if (err < 0) {
-- 
2.39.2

