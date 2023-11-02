Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E8E7DF41B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376658AbjKBNm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376646AbjKBNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:42:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EF0197
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:42:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9d274222b5dso152100766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698932540; x=1699537340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5ij4W2R7Rk89TAWTRo2Z11H1sJFKrF9K18A1hdSCONQ=;
        b=fvelpO8V8Ce+Mv5BzLn5w/uMDmuAJBXgew3vs3uqw2uVNDpcV+PhUXg10eZEfD1CWA
         wu4AQg3IIoqU1riYwu1+R7waP6vrNFjDy3X7arws6xSUcQyao35psA0hWWG6X+Q8xFAm
         G/y/97Z+f1M3ya6Wi9chCm9mR9IfoR6f2uNYlGSrpf3unVPO6jKcf/B+mCCN2TjMB5UB
         EBXv1vciDRWygrhgfgS/o6GK+iqT5Pnb1wSnLoitk0pRwjcl4b1S2Q0GOhdquVgfBWuV
         BLsmkNLw1nTPnVnVYvoKd8PBKabBrjD4AxSNrpQnEEtIygb2GhIifLViKA4U15O1o0oF
         gzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932540; x=1699537340;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ij4W2R7Rk89TAWTRo2Z11H1sJFKrF9K18A1hdSCONQ=;
        b=p/6UV4A5KBf72EAhohWm1ub89V86inE+Yqdobcq7Z7uotFGb8HGWCiwh29zikcKyff
         IzoOiz4RN6Sq65vTkSfhN6ghEwEhtE4QZvdE+NLDXjby+mKL9bTj67gpQPnv+jJ0Ql23
         tcNxNYU/u9oz8QzIwvcBlKbcPshYAICP4QFjZG5Qt7cy6QpZmVVSM6W7EQXiP5S+hNR+
         5ysA/yOiNOSkH1rZ6ID+hX3YrZ0ArtXWeFwIpvAX10c7JeSjCcx1aZRP1Jn06cP7R2T3
         TBS3t+wMo5JLpAWFea9Vt1Q27pYLhT7HpwadeZyZr+IxtsLLhHMnEZjykNBF72oSWSvh
         4/NQ==
X-Gm-Message-State: AOJu0YzPyiCmT5suV3zm660rqVclnBdkz5ynGlQ26DCP4lnxQxLFANsN
        gDbNt1lri5Qjgdwrg4OJ7+Q=
X-Google-Smtp-Source: AGHT+IF6LP+ml1ogEFi5qh8KFdD9Bqg3MegxZWCzvRijCiVmpR9CqHGHL0atdCUWnRBs0neVN5QPqg==
X-Received: by 2002:a17:907:60ca:b0:9c7:4d51:af08 with SMTP id hv10-20020a17090760ca00b009c74d51af08mr4508255ejc.43.1698932540595;
        Thu, 02 Nov 2023 06:42:20 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j8-20020a170906278800b009be14e5cd54sm1153220ejc.57.2023.11.02.06.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:42:20 -0700 (PDT)
Message-ID: <bb5cac77-a705-738e-13ae-667ea87f1cb1@gmail.com>
Date:   Thu, 2 Nov 2023 14:42:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 3/4] drm/rockchip: rk3066_hdmi: Remove useless output
 format
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rk3066 hdmi output format is hard coded to RGB. Remove
all useless code related to colorimetry and enc_out_format.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index 0e7aae341960..f2b1b2faa096 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -23,8 +23,6 @@

 struct hdmi_data_info {
 	int vic; /* The CEA Video ID (VIC) of the current drm display mode. */
-	unsigned int enc_out_format;
-	unsigned int colorimetry;
 };

 struct rk3066_hdmi_i2c {
@@ -200,14 +198,7 @@ static int rk3066_hdmi_config_avi(struct rk3066_hdmi *hdmi,
 	rc = drm_hdmi_avi_infoframe_from_display_mode(&frame.avi,
 						      &hdmi->connector, mode);

-	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV444)
-		frame.avi.colorspace = HDMI_COLORSPACE_YUV444;
-	else if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV422)
-		frame.avi.colorspace = HDMI_COLORSPACE_YUV422;
-	else
-		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
-
-	frame.avi.colorimetry = hdmi->hdmi_data.colorimetry;
+	frame.avi.colorspace = HDMI_COLORSPACE_RGB;
 	frame.avi.scan_mode = HDMI_SCAN_MODE_NONE;

 	return rk3066_hdmi_upload_frame(hdmi, rc, &frame,
@@ -329,15 +320,6 @@ static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
 	struct drm_display_info *display = &hdmi->connector.display_info;

 	hdmi->hdmi_data.vic = drm_match_cea_mode(mode);
-	hdmi->hdmi_data.enc_out_format = HDMI_COLORSPACE_RGB;
-
-	if (hdmi->hdmi_data.vic == 6 || hdmi->hdmi_data.vic == 7 ||
-	    hdmi->hdmi_data.vic == 21 || hdmi->hdmi_data.vic == 22 ||
-	    hdmi->hdmi_data.vic == 2 || hdmi->hdmi_data.vic == 3 ||
-	    hdmi->hdmi_data.vic == 17 || hdmi->hdmi_data.vic == 18)
-		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_601;
-	else
-		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;

 	hdmi->tmdsclk = mode->clock * 1000;

--
2.39.2

