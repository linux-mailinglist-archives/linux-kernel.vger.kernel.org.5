Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4B57DF419
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376636AbjKBNmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376635AbjKBNmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:42:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F70188
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:42:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so1580958a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698932526; x=1699537326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lK/vWnmM0KVaM6vCg3VvvClqSJH14OWzepShm2ndJ8I=;
        b=A6mE6ntvC9vlzZR47HhVci31Isma4vrFimhXY7SYGw2wBqrmN8y54wQ2U4J3L9jtFU
         uCPbXvUmYMhV8tAYPtv41H5MzvXnBv1t2c0f43P0Ekg9wP6iHNkiMhjnBlTShoW5J+2t
         zejFycYglfYZYJpoeSVMxs5WKlANe5Ui6mqUJKwY5+O/4W6G2osA0uoxFX8mQ4q0S6sG
         f3mtqHroQqhQ/cH4UXgW0NQbijJi/pCGvs/ciOoZTFN4TWgFHytjBPpGX5fBuuz/HrDw
         rk/tCi4g+qYS0/FXBzq5wzC5T3SFzv1olvIds9Beq6z1/Z5jO5a0SkFrHf3r06r89rUW
         Ilow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932526; x=1699537326;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lK/vWnmM0KVaM6vCg3VvvClqSJH14OWzepShm2ndJ8I=;
        b=FL0wx2oy+NxImGbiHkHaaumLb754dn/Ffdjd7kEDeYSdsgVZdGEnZuGpDy7HEHfWQn
         A5EBcKISkmwqNMzqK4zF5IMETS+TKBLsKj7dokdv6dQ4RCYJyp4J5w76hfURNo7byLZO
         0VppvMi7VOvKCCndYmbHF2Ux+gi1+wP/rlKwcJ52LZ0qucI0CosYnCqNJDMxEGOVebr0
         PUvtXBoLiyCRqGHTuij/8ZUyz37cLLqpqKZvDBcuUxEKxsIcEBzV86ILfiJoYlkVBvPz
         OiB861sMpkLrcAkKzW0j4ZH9slgxtubTIKL37CObNF5sSqkj8UNlp4Xpb1wz4LgvBRnG
         sSpw==
X-Gm-Message-State: AOJu0YxmBH0nBlfu+Ldvqtw0ho6zhK2C9Oud6UQWZS6veD/Iy0bJ3BES
        ejBkt0y3mKEfVIB+Q4REzqg=
X-Google-Smtp-Source: AGHT+IGV7tL5vnuqy+ywj5JlmDgSzOHEisn1VYUrvxqfFveF+L1CIsGQpPMLlZCZMZDql2U/Dza06A==
X-Received: by 2002:a50:9544:0:b0:543:595a:8280 with SMTP id v4-20020a509544000000b00543595a8280mr7749934eda.37.1698932526017;
        Thu, 02 Nov 2023 06:42:06 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q32-20020a05640224a000b0054130b1bc77sm2347915eda.51.2023.11.02.06.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:42:05 -0700 (PDT)
Message-ID: <034c3446-d619-f4c3-3aaa-ab51dc19d07f@gmail.com>
Date:   Thu, 2 Nov 2023 14:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/4] drm/rockchip: rk3066_hdmi: Switch encoder hooks to
 atomic
To:     hjc@rock-chips.com, heiko@sntech.de
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cda574be-4f33-b66d-eb14-92c2b31d241e@gmail.com>
Content-Language: en-US
In-Reply-To: <cda574be-4f33-b66d-eb14-92c2b31d241e@gmail.com>
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

The rk3066_hdmi encoder still uses the non atomic variants
of enable and disable. Convert to their atomic equivalents.
In atomic mode there is no need to save the adjusted mode,
so remove the mode_set function.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 35 +++++++++++++-------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index 5c269081c691..0e7aae341960 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -55,7 +55,6 @@ struct rk3066_hdmi {
 	unsigned int tmdsclk;

 	struct hdmi_data_info hdmi_data;
-	struct drm_display_mode previous_mode;
 };

 static struct rk3066_hdmi *encoder_to_rk3066_hdmi(struct drm_encoder *encoder)
@@ -387,21 +386,21 @@ static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
 	return 0;
 }

-static void
-rk3066_hdmi_encoder_mode_set(struct drm_encoder *encoder,
-			     struct drm_display_mode *mode,
-			     struct drm_display_mode *adj_mode)
+static void rk3066_hdmi_encoder_enable(struct drm_encoder *encoder,
+				       struct drm_atomic_state *state)
 {
 	struct rk3066_hdmi *hdmi = encoder_to_rk3066_hdmi(encoder);
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+	int mux, val;

-	/* Store the display mode for plugin/DPMS poweron events. */
-	drm_mode_copy(&hdmi->previous_mode, adj_mode);
-}
+	conn_state = drm_atomic_get_new_connector_state(state, &hdmi->connector);
+	if (WARN_ON(!conn_state))
+		return;

-static void rk3066_hdmi_encoder_enable(struct drm_encoder *encoder)
-{
-	struct rk3066_hdmi *hdmi = encoder_to_rk3066_hdmi(encoder);
-	int mux, val;
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	if (WARN_ON(!crtc_state))
+		return;

 	mux = drm_of_encoder_active_endpoint_id(hdmi->dev->of_node, encoder);
 	if (mux)
@@ -414,10 +413,11 @@ static void rk3066_hdmi_encoder_enable(struct drm_encoder *encoder)
 	DRM_DEV_DEBUG(hdmi->dev, "hdmi encoder enable select: vop%s\n",
 		      (mux) ? "1" : "0");

-	rk3066_hdmi_setup(hdmi, &hdmi->previous_mode);
+	rk3066_hdmi_setup(hdmi, &crtc_state->adjusted_mode);
 }

-static void rk3066_hdmi_encoder_disable(struct drm_encoder *encoder)
+static void rk3066_hdmi_encoder_disable(struct drm_encoder *encoder,
+					struct drm_atomic_state *state)
 {
 	struct rk3066_hdmi *hdmi = encoder_to_rk3066_hdmi(encoder);

@@ -449,10 +449,9 @@ rk3066_hdmi_encoder_atomic_check(struct drm_encoder *encoder,

 static const
 struct drm_encoder_helper_funcs rk3066_hdmi_encoder_helper_funcs = {
-	.enable       = rk3066_hdmi_encoder_enable,
-	.disable      = rk3066_hdmi_encoder_disable,
-	.mode_set     = rk3066_hdmi_encoder_mode_set,
-	.atomic_check = rk3066_hdmi_encoder_atomic_check,
+	.atomic_check   = rk3066_hdmi_encoder_atomic_check,
+	.atomic_enable  = rk3066_hdmi_encoder_enable,
+	.atomic_disable = rk3066_hdmi_encoder_disable,
 };

 static enum drm_connector_status
--
2.39.2

