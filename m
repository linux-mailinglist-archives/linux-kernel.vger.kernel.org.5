Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3CE7E4A11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbjKGUqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjKGUq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:46:26 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D617F10DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:46:23 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2ec9a79bdso4213259b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699389983; x=1699994783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91MByGmQVl2taa6i/AdbRt3neF5iZF/QU7vQ/CbO+ic=;
        b=QMWK1Y2sL1M8kS8g8pkP6ydMYFQ+WRaw58mPq7S/x6YIy0XyxA506a0M/nmHlD0YqV
         4z2ZArku/fMtQqAv8aVQfBW5gWpSWRMQT+Km9PIBB/BNMDq7kaWstvAKbrLmbBKy60C9
         WXRC3dw9Llgya3yRDkXQNlvgTI4we0+HqKpv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699389983; x=1699994783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91MByGmQVl2taa6i/AdbRt3neF5iZF/QU7vQ/CbO+ic=;
        b=P+7KNXn1v8DNMPGZ8tPmOmU+WlsDhe/+xUTAf1yLlOeB1gF7twjWt9bcolpyh+MFvU
         ecSv2vynUQ+O0mntjaqWYMH1SELqlEq4c2p7MiHcyzlkjc7OOXEHVJjFMjoJUk+NM8Wp
         zmsVzykd/wN+TCn5bQRXvJ3V32NHw35xxsAhcUBRqzHoUTSX9dTDYOTqSuj1LqfnyJXf
         0txqQ3JEuKqqUa5VvXmUnXCk/CM9PrhMuFT4LYHQ4piFYNzvE+vN1jo9VoTpPBTGCDsf
         mXwfyw/Ef/ghARuo7VDBQk03yWxgJViYNRPr2/PifxmDJN9fh2wyN+SmIiCkg/NVFWDY
         xKQw==
X-Gm-Message-State: AOJu0Yw+94xQQTuyDYbvf16Wz7j3em70ZqSFrgyqlD/3+PZfu7RwQsoX
        /kPLLc1WdriHZiPhO88AbncdvQ==
X-Google-Smtp-Source: AGHT+IHOdRvi2sA6xJA8wOXbmKn0wVvuBxDWH43DQAj9SH8vpgSEQnHazF4kXFckivDZv66HPcNLEA==
X-Received: by 2002:a05:6870:2423:b0:1e9:b025:cf88 with SMTP id n35-20020a056870242300b001e9b025cf88mr4646934oap.36.1699389983229;
        Tue, 07 Nov 2023 12:46:23 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:586c:80a1:e007:beb9])
        by smtp.gmail.com with ESMTPSA id e7-20020a630f07000000b005ab46970aaasm1750211pgl.17.2023.11.07.12.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 12:46:22 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v6 5/5] drm/panel-edp: Avoid adding multiple preferred modes
Date:   Tue,  7 Nov 2023 12:41:55 -0800
Message-ID: <20231107204611.3082200-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231107204611.3082200-1-hsinyi@chromium.org>
References: <20231107204611.3082200-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a non generic edp-panel is under aux-bus, the mode read from edid would
still be selected as preferred and results in multiple preferred modes,
which is ambiguous.

If both hard-coded mode and edid exists, only add mode from hard-coded.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
no change.
---
 drivers/gpu/drm/panel/panel-edp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index c0c24d94c3a0..006939cc3fee 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -589,6 +589,7 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 {
 	struct panel_edp *p = to_panel_edp(panel);
 	int num = 0;
+	bool has_hard_coded_modes = p->desc->num_timings || p->desc->num_modes;
 	bool has_override_edid_mode = p->detected_panel &&
 				      p->detected_panel != ERR_PTR(-EINVAL) &&
 				      p->detected_panel->override_edid_mode;
@@ -599,7 +600,11 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 
 		if (!p->edid)
 			p->edid = drm_get_edid(connector, p->ddc);
-		if (p->edid) {
+		/*
+		 * If both edid and hard-coded modes exists, skip edid modes to
+		 * avoid multiple preferred modes.
+		 */
+		if (p->edid && !has_hard_coded_modes) {
 			if (has_override_edid_mode) {
 				/*
 				 * override_edid_mode is specified. Use
@@ -616,12 +621,7 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 		pm_runtime_put_autosuspend(panel->dev);
 	}
 
-	/*
-	 * Add hard-coded panel modes. Don't call this if there are no timings
-	 * and no modes (the generic edp-panel case) because it will clobber
-	 * the display_info that was already set by drm_add_edid_modes().
-	 */
-	if (p->desc->num_timings || p->desc->num_modes)
+	if (has_hard_coded_modes)
 		num += panel_edp_get_non_edid_modes(p, connector);
 	else if (!num)
 		dev_warn(p->base.dev, "No display modes\n");
-- 
2.42.0.869.gea05f2083d-goog

