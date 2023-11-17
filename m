Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269487EFB12
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjKQVvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjKQVvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:51:08 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F6120
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:51:05 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so2120427a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700257864; x=1700862664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+W2o/1Mm+Zk29DqmS4Z9iJYsZDg6ej8XviFhoNK3hc=;
        b=L5IWf03IL9pVt3mps0ACwg8Dx8JRxZ6SIf25UGzyTdL10K3cO5MC7gSLAt0dItVnSc
         68BOIZwukxfJxhd/u/8l4V37gQeW1J5Qr8yibcVhOjSL5kheHXiEcdsf7sWpR+cKqCAE
         /BkXp3kZOr2Zlgy/vFO08WObsuJSM0Om3Tb5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700257864; x=1700862664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+W2o/1Mm+Zk29DqmS4Z9iJYsZDg6ej8XviFhoNK3hc=;
        b=oSO16kSEoFDqhhkb9jQH9BK11SYxZ1FumraOimUaU2Hh9MmgUSIoBnzShFxcV0ZHhS
         PFLQrWW+BLX4WnDncqnx+oTz9kAA8iiIW0UbmfeGgzon/l8wZjCbgnDtoZ3yHqU6rilK
         Fsyh0IfdFzflR+KeVibuOqgLlOfULADut3eXBbAv0urXfuPeCu0y4wKiJqxOiSoMuyKV
         ZAlBTUuOKY3MdHwODPd3dlya0ZhabsDulIvGzDcQq0QOSsDIBTsGguMxloJ/vi1jSe5E
         +m8MXjDjB5ZC/Yap7QaCKY3BPXQ2N9xCIky0j+yvFR9emHzkb8h+RRBKKXdMWWcTFSFz
         GqZA==
X-Gm-Message-State: AOJu0YwI9FhQY1vBAusMSo5CQGc2/EtrTFB50BPZ7c8V0ZErsM2QfZvt
        xU3nI495C3PD1YN1uCMNJjXEbA==
X-Google-Smtp-Source: AGHT+IEoYZev4e+4BlmjL2DESxBNbWnVwfPVQGbvcEHXfE9mi8zXCgvFODYt3RwfTHBziPMiCXhH6g==
X-Received: by 2002:a17:90b:3014:b0:27d:8ad:c4e1 with SMTP id hg20-20020a17090b301400b0027d08adc4e1mr922828pjb.19.1700257864607;
        Fri, 17 Nov 2023 13:51:04 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:7ed:b095:f0ba:5801])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090aca0700b00256b67208b1sm3639587pjt.56.2023.11.17.13.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:51:04 -0800 (PST)
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
Subject: [PATCH v7 3/3] drm/panel-edp: Avoid adding multiple preferred modes
Date:   Fri, 17 Nov 2023 13:46:34 -0800
Message-ID: <20231117215056.1883314-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231117215056.1883314-1-hsinyi@chromium.org>
References: <20231117215056.1883314-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
v6->v7: no change
---
 drivers/gpu/drm/panel/panel-edp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 3e144145a6bd..825fa2a0d8a5 100644
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
2.43.0.rc0.421.g78406f8d94-goog

