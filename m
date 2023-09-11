Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5105279BDE0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbjIKWJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjIKJCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:02:48 -0400
Received: from out-219.mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29AFCCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:02:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694422961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekcF3Bi8RuigTkjZz8yzaTQ4wC4D41rIRScarwtkG1A=;
        b=Rx1r9SCTGSwY+YD2ad9mfOyDPYx1WNVtFqwZXiCvMHLHoy8kAJe697YPbr/Mp2BpRHLik5
        /DOx4El0C+uDkEI9kDmJTmfzQ8/UB5TQ3HZkDIotigbp+PKxMp2QokuMq0prVCfGGroD+M
        CFuwGn1sezZV47xjpD0lo/UfDowOnsYoYD47rHXsdXKKqVesf8qaeniH//MCFpTufLsFOe
        QE9zywaXZtjq/REHTCCXNYAnTFQxXMSjFnIbI9MUrUjZD/NRHNbt38ZE9YIaG9k/ilE+XD
        Rl7F4KRQNQTS1uuY5BUd84Nx2ugwIFwwGWLJZeS+a+3vAthZ5oIs3h8cVNfSIA==
From:   John Watts <contact@jookia.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, John Watts <contact@jookia.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/8] drm/panel: nv3052c: Add SPI device IDs
Date:   Mon, 11 Sep 2023 19:02:00 +1000
Message-ID: <20230911090206.3121440-3-contact@jookia.org>
In-Reply-To: <20230911090206.3121440-1-contact@jookia.org>
References: <20230911090206.3121440-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI drivers needs their own list of compatible device IDs in order
for automatic module loading to work. Add those for this driver.

Signed-off-by: John Watts <contact@jookia.org>
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
2.42.0

