Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38347CCBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbjJQTGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbjJQTFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:05:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E339C109
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:05:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso9379069a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697569548; x=1698174348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4DYHyP5rpJlCrGLu/7YVXYPDawqI0/vUMpje/5y6E4=;
        b=F3Dzh9O5loghM9/63y5qKCEjs50agFE3KNtQITEcATMR6zxbZK2FyBfTkZqKUboLlZ
         ZlTDjKy9vVG1y3u9sNX7lD0CIEVdP3Nz9nqA/qW1xCEYihg7eJqeSETW7jixk5uwja+M
         OfEIx+pg4sDYuyKoYol+Xg2tVtIFa70VVvl/nB2dhryg5xpl2YaA1CgmYmFQMaJfzaZd
         kDZt77hfTWFN/eB+RTZaNyeAPhv4olQgLLGtMsUYr0ex6+zXTaKwyptAfaBDtC4j7mIF
         y3PAQyIT3ZI1N3XaC6JB6eVcr63t6TU/QYo+4Vh7CGKYVjJOST+4IaDwfHrUnrvD75DP
         RmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569548; x=1698174348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4DYHyP5rpJlCrGLu/7YVXYPDawqI0/vUMpje/5y6E4=;
        b=sXs5R+VsIjy+pGSz0qu80Vyn3M5LAG8tHtYutXl/egTeuYdLtYQdoDIlasIKrKZpQL
         Ch08Xcw3dvsUbHIIBvyI1yzN9sUx3kuYNVHr80pTGiRRUlac6xAHpTx1SNwcor4Lqmcy
         rCO7Gvsw46Yl076Vi/TwvJp0ZH+VQnd5Idwdr8zDF2baddez6jLym/NsVElmUY37pcPM
         7hD/GxQH8fGUqBob9mtxCZhmJUSUxZbomUTMdwx1/w3rWThMFgrsZE4k5sEpOpSiFUnS
         UYTs72jq40j5hnp8TQZsMSA++Nuz9v+ZW2D9cehM4BXQNAuVZk+cOiPsprc5m+o5Pt8B
         LFjw==
X-Gm-Message-State: AOJu0Ywz7MVR60vtseeMieFhppso8d6gfkTikmecajhBB+7yMVxonFvO
        zAfIGtHVndR252HIFbcblDTghQ==
X-Google-Smtp-Source: AGHT+IE1d8gzvI8UJeLw/gO6durUM9+szimEzBZasfn/1pv7K2XCfq9TUaKMIAHdmRwjNmbGs2YMjQ==
X-Received: by 2002:a05:6402:5202:b0:53e:f9ef:ca6b with SMTP id s2-20020a056402520200b0053ef9efca6bmr2682060edd.7.1697569547959;
        Tue, 17 Oct 2023 12:05:47 -0700 (PDT)
Received: from ryzen9.fritz.box ([2a01:2a8:8f03:b001:fe65:a70:2777:ab31])
        by smtp.gmail.com with ESMTPSA id bq14-20020a056402214e00b00537963f692esm1637990edb.0.2023.10.17.12.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:05:47 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dunlap@infradead.org,
        e.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, ames.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v5 1/5] dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for mt8192
Date:   Tue, 17 Oct 2023 21:05:41 +0200
Message-ID: <20231017190545.157282-2-bero@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017190545.157282-1-bero@baylibre.com>
References: <20231017190545.157282-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add LVTS thermal controller definition for MT8192.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../thermal/mediatek,lvts-thermal.h           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index 8fa5a46675c46..5e9eb62174268 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -26,4 +26,23 @@
 #define MT8195_AP_CAM0  15
 #define MT8195_AP_CAM1  16
 
+#define MT8192_MCU_BIG_CPU0     0
+#define MT8192_MCU_BIG_CPU1     1
+#define MT8192_MCU_BIG_CPU2     2
+#define MT8192_MCU_BIG_CPU3     3
+#define MT8192_MCU_LITTLE_CPU0  4
+#define MT8192_MCU_LITTLE_CPU1  5
+#define MT8192_MCU_LITTLE_CPU2  6
+#define MT8192_MCU_LITTLE_CPU3  7
+
+#define MT8192_AP_VPU0  8
+#define MT8192_AP_VPU1  9
+#define MT8192_AP_GPU0  10
+#define MT8192_AP_GPU1  11
+#define MT8192_AP_INFRA 12
+#define MT8192_AP_CAM   13
+#define MT8192_AP_MD0   14
+#define MT8192_AP_MD1   15
+#define MT8192_AP_MD2   16
+
 #endif /* __MEDIATEK_LVTS_DT_H */
-- 
2.42.0

