Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E127808D44
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjLGQLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjLGQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:10:57 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4F212D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:11:03 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9e1021dbd28so144146066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701965461; x=1702570261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXMGWx05Oqhgl5suufkTuT8kZBkK433+J40SP+lUHbM=;
        b=cnIq84J8SbgPnPG1J121gJudWFBv66DJ8jtMQ/fWftW8fuWwXez25NFxYwDwJC631w
         6QjEz3y7hkkcvG6ZrOo3vyViJbyWjQ6i2WJHEdVsgVrql3f2Urwo8mtoN81WY8nmSQi8
         qeixsxxAKP1ueJyCAyQPYs/qcv3BjhsyRlVbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701965461; x=1702570261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXMGWx05Oqhgl5suufkTuT8kZBkK433+J40SP+lUHbM=;
        b=Ne5W4nvK8Wp0Bxbn65x7FhoAoHmQaNsVqMtlhHz7HjyYkLVzdsWlecqEBPTuVbD3qB
         KzCzb+lnicYbkO5rl45kYizykOQj7hIzjsPKk4hXh3JbV5qcglhaePYYh5bS8mhhRJoo
         BBPzj47CNww7mzSw/dkITW/PdH0Lnu4l6Bf1JW+Aw2lOhumAOarTBDlm7Oa8M8fHmyBi
         91SwEoXyHpQlgIWRVylxVeIBcT3Sg9YXwLjIWmlewiMv0bOcSKGsJQiIKEWes+/N7kL8
         VG2/m3H6o3l3EH5T3xJC6DUZSr+JSNHzL7Sw8jLR2ctdErfxWavjzOkmVrxPZ96NwNFi
         hCuA==
X-Gm-Message-State: AOJu0Yy0sW0a4Tl4BGpgavOKz90BaFfaVlK00apgd9353ZgGGTn3YrhV
        u9MQv3IhfJHoUT0BV+0r+K8ZEBVPRam6KPEtuFB0EA==
X-Google-Smtp-Source: AGHT+IGs6KP73vU1SUU/HRyy8dMywzlKbx8fMvag5ZyzuitZ0Tn8jejydHX1ZR3GalG7y7zCNBbq7A==
X-Received: by 2002:a17:906:e8b:b0:a1d:7f40:bebe with SMTP id p11-20020a1709060e8b00b00a1d7f40bebemr1678683ejf.126.1701965461446;
        Thu, 07 Dec 2023 08:11:01 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:9bf:959c:3c66:46c2])
        by smtp.gmail.com with ESMTPSA id k19-20020a170906681300b009a193a5acffsm989730ejr.121.2023.12.07.08.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:11:01 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: samsung-dsim: check the return value only if necessary
Date:   Thu,  7 Dec 2023 17:10:43 +0100
Message-ID: <20231207161056.183442-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was useless to check again the "ret" variable if the function
register_host() was not called.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/bridge/samsung-dsim.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index be5914caa17d..98cd589e4427 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -2020,11 +2020,11 @@ int samsung_dsim_probe(struct platform_device *pdev)
 	else
 		dsi->bridge.timings = &samsung_dsim_bridge_timings_de_high;
 
-	if (dsi->plat_data->host_ops && dsi->plat_data->host_ops->register_host)
+	if (dsi->plat_data->host_ops && dsi->plat_data->host_ops->register_host) {
 		ret = dsi->plat_data->host_ops->register_host(dsi);
-
-	if (ret)
-		goto err_disable_runtime;
+		if (ret)
+			goto err_disable_runtime;
+	}
 
 	return 0;
 
-- 
2.43.0

