Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09937A8718
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbjITOhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbjITOg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:36:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27A8E50;
        Wed, 20 Sep 2023 07:36:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C56C433A9;
        Wed, 20 Sep 2023 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695220602;
        bh=cewGjSfrxsWvWPkrDxnbvQOKsF0K1kZ/Vi1wxjvWMJU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pE+ag+5Yn7c2nYuj40N7SFctWUKMFs0tKR5WUX66n0vaipiYu4+iREdYGDUd3kdyn
         67+PuQ549klOAWsPYbWHzsJZFc/UJP256VAlVpzGy3vO5g4xebRWgGpHIr6I9OM/rP
         BHAV8iKU1w5Jd1O+OzUCwQe8/JSOugxUxHBVNXugPRDU6E/5N2DLr29oqUL4kUQEcB
         W7pueG1VYtj4+1TcVtXOmRMNW6DTeyrktRbtWZ2u2vJt5VLQFqxBUZseQ6TScASbDt
         0qCjQKDOBkxRNQg4RBuYZ/TukKVayxg8Vv/+WCY77qIXEkQtS5L++68v5145EfiNvh
         LSGuzPqjr+0DQ==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Wed, 20 Sep 2023 16:35:36 +0200
Subject: [PATCH RFC v2 21/37] drm/rockchip: inno_hdmi: Remove useless input
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230920-kms-hdmi-connector-state-v2-21-17932daddd7d@kernel.org>
References: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
In-Reply-To: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3445; i=mripard@kernel.org;
 h=from:subject:message-id; bh=cewGjSfrxsWvWPkrDxnbvQOKsF0K1kZ/Vi1wxjvWMJU=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnczFZVPcu5FRuFbfgW5XyJcUpa4zth9R/54un7Qt2Ot
 H08dKKlo5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABORt2FkOHqV+9zirONiEoqF
 Ud7bNxoFVq0wVpawfKT9x/zHDBfjPwz/Pe/ca+BlPH8iOKec/5DgvZtXdkxoP2m3SI6Pe9+P39M
 5OQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has a lot of logic to deal with multiple input formats, but
hardcodes it to RGB. This means that most of that code has been dead
code, so let's get rid of it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 39 +++++++++---------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 3908dc09d85f..e0696ab16da3 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -28,7 +28,6 @@
 #include "inno_hdmi.h"
 
 struct hdmi_data_info {
-	unsigned int enc_in_format;
 	unsigned int enc_out_format;
 	unsigned int colorimetry;
 };
@@ -328,47 +327,30 @@ static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
 		v_VIDEO_INPUT_CSP(0);
 	hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL2, value);
 
-	if (data->enc_in_format == data->enc_out_format) {
-		if ((data->enc_in_format == HDMI_COLORSPACE_RGB) ||
-		    (data->enc_in_format >= HDMI_COLORSPACE_YUV444)) {
-			value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
-			hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
+	if (HDMI_COLORSPACE_RGB == data->enc_out_format) {
+		value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
+		hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
 
-			hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
-				  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
-				  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
-				  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
-			return 0;
-		}
+		hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
+			  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
+			  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
+			  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
+		return 0;
 	}
 
 	if (data->colorimetry == HDMI_COLORIMETRY_ITU_601) {
-		if ((data->enc_in_format == HDMI_COLORSPACE_RGB) &&
-		    (data->enc_out_format == HDMI_COLORSPACE_YUV444)) {
+		if (data->enc_out_format == HDMI_COLORSPACE_YUV444) {
 			csc_mode = CSC_RGB_0_255_TO_ITU601_16_235_8BIT;
 			auto_csc = AUTO_CSC_DISABLE;
 			c0_c2_change = C0_C2_CHANGE_DISABLE;
 			csc_enable = v_CSC_ENABLE;
-		} else if ((data->enc_in_format == HDMI_COLORSPACE_YUV444) &&
-			   (data->enc_out_format == HDMI_COLORSPACE_RGB)) {
-			csc_mode = CSC_ITU601_16_235_TO_RGB_0_255_8BIT;
-			auto_csc = AUTO_CSC_ENABLE;
-			c0_c2_change = C0_C2_CHANGE_DISABLE;
-			csc_enable = v_CSC_DISABLE;
 		}
 	} else {
-		if ((data->enc_in_format == HDMI_COLORSPACE_RGB) &&
-		    (data->enc_out_format == HDMI_COLORSPACE_YUV444)) {
+		if (data->enc_out_format == HDMI_COLORSPACE_YUV444) {
 			csc_mode = CSC_RGB_0_255_TO_ITU709_16_235_8BIT;
 			auto_csc = AUTO_CSC_DISABLE;
 			c0_c2_change = C0_C2_CHANGE_DISABLE;
 			csc_enable = v_CSC_ENABLE;
-		} else if ((data->enc_in_format == HDMI_COLORSPACE_YUV444) &&
-			   (data->enc_out_format == HDMI_COLORSPACE_RGB)) {
-			csc_mode = CSC_ITU709_16_235_TO_RGB_0_255_8BIT;
-			auto_csc = AUTO_CSC_ENABLE;
-			c0_c2_change = C0_C2_CHANGE_DISABLE;
-			csc_enable = v_CSC_DISABLE;
 		}
 	}
 
@@ -443,7 +425,6 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 	struct drm_display_info *display = &hdmi->connector.display_info;
 	u8 vic = drm_match_cea_mode(mode);
 
-	hdmi->hdmi_data.enc_in_format = HDMI_COLORSPACE_RGB;
 	hdmi->hdmi_data.enc_out_format = HDMI_COLORSPACE_RGB;
 
 	if ((vic == 6) || (vic == 7) ||

-- 
2.41.0

