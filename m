Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D580B98A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 08:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjLJHFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 02:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJHFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 02:05:02 -0500
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE38EAD
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 23:05:08 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1702191407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZS40PCbIzK3auiYn/GXpJfpDi577RkWA9rQ5FOV0MBQ=;
        b=idqBuCtwTV2tcx9ahA3GUEOw4ViylPD307f5DeQP7rSBBGH3J1xqgdJPi6FVCgi4WK9d/x
        /C1NgXwG3E5GxB1uuOP7IFK+fiARSMJNe9nTDCwTBNubk/GMzkVeOE3wtcFcVbWwvIT+UK
        G+YQWr/sfeB028yEW9z0rh1Ox9NAH4NDZqeP9itPr58/DSaUXgNwmOiPB0lQ1YlMSpPlDs
        RLK9st8JUZaC6iR03JoeyWxl0UBTAZfQMRBeZ3yFiWNddhAvgqVI1ocpMJ40uIYzHOaEsv
        HTbCXv0is/P+ykYhY7HH9fTch5SacmkHPsUTcTHfNYDZEvr1YlS6JMhzhleIzg==
From:   John Watts <contact@jookia.org>
Date:   Sun, 10 Dec 2023 17:55:50 +1100
Subject: [PATCH RFC v5 2/7] drm/panel: nv3052c: Add SPI device IDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-fs035vg158-v5-2-d75adc75571f@jookia.org>
References: <20231210-fs035vg158-v5-0-d75adc75571f@jookia.org>
In-Reply-To: <20231210-fs035vg158-v5-0-d75adc75571f@jookia.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        John Watts <contact@jookia.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI drivers needs their own list of compatible device IDs in order
for automatic module loading to work. Add those for this driver.

Signed-off-by: John Watts <contact@jookia.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/panel/panel-newvision-nv3052c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 589431523ce7..90dea21f9856 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -465,6 +465,12 @@ static const struct nv3052c_panel_info ltk035c5444t_panel_info = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
 };
 
+static const struct spi_device_id nv3052c_ids[] = {
+	{ "ltk035c5444t", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, nv3052c_ids);
+
 static const struct of_device_id nv3052c_of_match[] = {
 	{ .compatible = "leadtek,ltk035c5444t", .data = &ltk035c5444t_panel_info },
 	{ /* sentinel */ }
@@ -476,6 +482,7 @@ static struct spi_driver nv3052c_driver = {
 		.name = "nv3052c",
 		.of_match_table = nv3052c_of_match,
 	},
+	.id_table = nv3052c_ids,
 	.probe = nv3052c_probe,
 	.remove = nv3052c_remove,
 };

-- 
2.43.0

