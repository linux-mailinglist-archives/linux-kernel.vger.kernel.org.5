Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3A17F9264
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjKZK4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZK4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:56:34 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CBAB6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:56:40 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ffef4b2741so432536866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700996199; x=1701600999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I3GW50siPE3V/OZVTf7EbN7pnDFJwfRoAQudNo2WQ48=;
        b=XP6Sdp3cduK1+XQIkEtc8Aw33QHLkMEsvn+BTGWYQxYL9XKN3Qav/fK0Lbq+4sjMMK
         gTlruFRE60Ss2mdeJ+LhY8kOaLTLUtgzOFX6jI5bUweF2BfxkFDCX+/tCbO8blotVuQY
         50PH2GupGZjsbiPDBhjfB1SbSv9IwnIkK+pZ7kiOUwSr+Ztmy0puMEBT9JlBdMkRlERZ
         rMMpckcSmB5Zy78xXVrdmKSt/kO8VXdlSX97Fpu5WuL+cN7RGw8GLKOnwxkAxDsm33T4
         r69r77CnPvzrlvJp7kakv2Pae8uiew1DndA3j1hZ1OQREyFHRgCzCdKvE8nf+yxww7U4
         Lyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700996199; x=1701600999;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3GW50siPE3V/OZVTf7EbN7pnDFJwfRoAQudNo2WQ48=;
        b=Plgk0iqR7B8ifk1xDq7EZ827E1KiiFcsOOrxEZrA9uuZhCLMRPx0NXbTeKkEz6FMoi
         CiXu9sCnKAoPNCbqUQglTFdGPk1FS5OcncEGIVzXank9sLRfu1Nd3975N+bWGJBHn2r9
         7Wv4vvysWTg1+OxZJCnMFf2LWnIArzGVo960kEAM+oYH5VfJ0Dhhhmo4xFV08KsGnZ5n
         XHNUtjVVWbUm3yVYxbjoeti1hbEGFNumzZQTP7ltBMmXSLlnXdQXSZwUhnt6qq9InhrB
         WO2iMMwu9IdBwFBVbwVZzKzayJWrXZg+dZ1WSA4BW2Z2j23J+U9Ef6LQ9ZK/SLGCZ1Cg
         C+LA==
X-Gm-Message-State: AOJu0Yy7aDbXEC5useJiKlF4bKb7PigDC2T/d8cbSegOm4ZmS28jUC+c
        iwU8CqsTg7FMx17YJVyTx0Q=
X-Google-Smtp-Source: AGHT+IHyK6mjmTRZ1o7XFvGUgHdwO4eWCrwMMAGqlF4KESwgSObaJJInGnzGUjM2H/elSkwoTRxo2g==
X-Received: by 2002:a17:906:209e:b0:a0a:f9af:c159 with SMTP id 30-20020a170906209e00b00a0af9afc159mr3795403ejq.25.1700996198924;
        Sun, 26 Nov 2023 02:56:38 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r21-20020a170906351500b00a0bd234566bsm1763175eja.143.2023.11.26.02.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 02:56:38 -0800 (PST)
Message-ID: <eef4e548-0b5f-4ae5-725e-1cf706322a14@gmail.com>
Date:   Sun, 26 Nov 2023 11:56:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/3] drm/rockchip: inno_hdmi: Switch encoder hooks to
 atomic
To:     hjc@rock-chips.com, heiko@sntech.de
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org
References: <2601b669-c570-f39d-8cf9-bff56c939912@gmail.com>
Content-Language: en-US
In-Reply-To: <2601b669-c570-f39d-8cf9-bff56c939912@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inno_hdmi encoder still uses the non atomic variants
of enable and disable. Convert to their atomic equivalents.
In atomic mode there is no need to save the adjusted mode,
so remove the mode_set function.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V1:
  Combined patches
  Include drm_atomic.h
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 46 ++++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index cc48cbf85f31..535cca30c256 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -5,6 +5,13 @@
  *    Yakir Yang <ykk@rock-chips.com>
  */

+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_of.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
+
 #include <linux/irq.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -16,12 +23,6 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>

-#include <drm/drm_atomic_helper.h>
-#include <drm/drm_edid.h>
-#include <drm/drm_of.h>
-#include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
-
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_vop.h"

@@ -62,7 +63,6 @@ struct inno_hdmi {
 	unsigned int tmds_rate;

 	struct hdmi_data_info	hdmi_data;
-	struct drm_display_mode previous_mode;
 };

 static struct inno_hdmi *encoder_to_inno_hdmi(struct drm_encoder *encoder)
@@ -491,26 +491,27 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 	return 0;
 }

-static void inno_hdmi_encoder_mode_set(struct drm_encoder *encoder,
-				       struct drm_display_mode *mode,
-				       struct drm_display_mode *adj_mode)
+static void inno_hdmi_encoder_enable(struct drm_encoder *encoder,
+				     struct drm_atomic_state *state)
 {
 	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;

-	inno_hdmi_setup(hdmi, adj_mode);
+	conn_state = drm_atomic_get_new_connector_state(state, &hdmi->connector);
+	if (WARN_ON(!conn_state))
+		return;

-	/* Store the display mode for plugin/DPMS poweron events */
-	drm_mode_copy(&hdmi->previous_mode, adj_mode);
-}
-
-static void inno_hdmi_encoder_enable(struct drm_encoder *encoder)
-{
-	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	if (WARN_ON(!crtc_state))
+		return;

+	inno_hdmi_setup(hdmi, &crtc_state->adjusted_mode);
 	inno_hdmi_set_pwr_mode(hdmi, NORMAL);
 }

-static void inno_hdmi_encoder_disable(struct drm_encoder *encoder)
+static void inno_hdmi_encoder_disable(struct drm_encoder *encoder,
+				      struct drm_atomic_state *state)
 {
 	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);

@@ -531,10 +532,9 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 }

 static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
-	.enable     = inno_hdmi_encoder_enable,
-	.disable    = inno_hdmi_encoder_disable,
-	.mode_set   = inno_hdmi_encoder_mode_set,
-	.atomic_check = inno_hdmi_encoder_atomic_check,
+	.atomic_check	= inno_hdmi_encoder_atomic_check,
+	.atomic_enable	= inno_hdmi_encoder_enable,
+	.atomic_disable	= inno_hdmi_encoder_disable,
 };

 static enum drm_connector_status
--
2.39.2

