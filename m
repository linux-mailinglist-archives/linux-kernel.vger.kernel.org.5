Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84780805452
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345134AbjLEMgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345111AbjLEMgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:36:39 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C0010F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:36:45 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so4437880b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701779805; x=1702384605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5mNmjMPCqBbX4f2kZl/QjTxGMwPMe3/nj+TBHAFfXI=;
        b=lfRw47qVs5//F5mPPuD2CxprZN7n8ax8K0ptR5x04JM0MEwLqmuX/X24dWRawMmTkG
         ShsLYCWxaobNDdDNzZPvq9gac8U0kDsx9MkNqbcv0mlVlTy0oa5lPKEyveYqYUQuPTLL
         OtG4Wb41JwU2TOvRg91XCgB/rCnuWtQbtsmMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701779805; x=1702384605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5mNmjMPCqBbX4f2kZl/QjTxGMwPMe3/nj+TBHAFfXI=;
        b=oqV9OULEIJgjIR7Ys0AvsBvoGYRw4uIjjQUJ+1LD5SHzN8LhEE7GZHOKuVzFywUGyE
         CWm1X4Vq4qLhkFaOD7vyNUSOua+UI8d6LbRRBFAh5kzRRtUIAURa9XuRscHilwTR19PU
         ZIsBV71Pew3/eXFMMyVD7QsYmbAf2EaeCxhmB/m7Odhgj7R3rUDjofiA09IQSGBFwgt7
         FgOF0drjKyugxcIyhkpUaIciISX9EIIKlDNn/ON3wCRcOW2jkquRYr6Hn4C1yb9CTsAi
         AQd958jTEbTmjvVHMRdsKDUwO4kODgJvs1a+BeOvnpuyKQE3FEVPnx+fZBBdljaJaAPt
         ufQA==
X-Gm-Message-State: AOJu0Yx3kpRPq0e9vOaCtz14cUglILN28HqGCmhrTnZLT1FkqZPQxoQ2
        CG47ITH8zhjij12DfKJ8FRyuaA==
X-Google-Smtp-Source: AGHT+IE/D6fPLH75eLG9HpAcEh5urre5KQHQWGFui4XsKp47sqHxc/gbp1W0L6LtW1vVgO8lr3xT+A==
X-Received: by 2002:a05:6a00:420f:b0:6ce:2731:47b4 with SMTP id cd15-20020a056a00420f00b006ce273147b4mr1403242pfb.20.1701779805324;
        Tue, 05 Dec 2023 04:36:45 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:433d:45a7:8d2c:be0e])
        by smtp.gmail.com with ESMTPSA id p26-20020aa7861a000000b006ce7abe91dasm285115pfn.195.2023.12.05.04.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 04:36:45 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH 1/4] drm/panel-edp: Add powered_on_to_enable delay
Date:   Tue,  5 Dec 2023 20:35:34 +0800
Message-ID: <20231205123630.988663-2-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231205123630.988663-1-treapking@chromium.org>
References: <20231205123630.988663-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support of powered_on_to_enable delay as the minimum time that
needs to have passed between the panel powered on and enable may begin.

This delay is seen in BOE panels as the minimum delay of T3+T4+T5+T6+T8
in the eDP timing diagrams.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/panel/panel-edp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 825fa2a0d8a5..819fe8115c08 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -70,6 +70,21 @@ struct panel_delay {
 	 */
 	unsigned int hpd_absent;
 
+	/**
+	 * @powered_on_to_enable: Time between panel powered on and enable.
+	 *
+	 * The minimum time, in milliseconds, that needs to have passed
+	 * between when panel powered on and enable may begin.
+	 *
+	 * This is (T3+T4+T5+T6+T8)-min on eDP timing diagrams or after the
+	 * power supply enabled until we can turn the backlight on and see
+	 * valid data.
+	 *
+	 * This doesn't normally need to be set if timings are already met by
+	 * prepare_to_enable or enable.
+	 */
+	unsigned int powered_on_to_enable;
+
 	/**
 	 * @prepare_to_enable: Time between prepare and enable.
 	 *
@@ -216,6 +231,7 @@ struct panel_edp {
 	bool prepared;
 
 	ktime_t prepared_time;
+	ktime_t powered_on_time;
 	ktime_t unprepared_time;
 
 	const struct panel_desc *desc;
@@ -455,6 +471,8 @@ static int panel_edp_prepare_once(struct panel_edp *p)
 
 	gpiod_set_value_cansleep(p->enable_gpio, 1);
 
+	p->powered_on_time = ktime_get_boottime();
+
 	delay = p->desc->delay.hpd_reliable;
 	if (p->no_hpd)
 		delay = max(delay, p->desc->delay.hpd_absent);
@@ -579,6 +597,8 @@ static int panel_edp_enable(struct drm_panel *panel)
 
 	panel_edp_wait(p->prepared_time, p->desc->delay.prepare_to_enable);
 
+	panel_edp_wait(p->powered_on_time, p->desc->delay.powered_on_to_enable);
+
 	p->enabled = true;
 
 	return 0;
-- 
2.43.0.rc2.451.g8631bc7472-goog

