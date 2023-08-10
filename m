Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCD7773F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjHJJOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjHJJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:13:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B392A2D41
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:13:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5231f439968so851179a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691658794; x=1692263594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXtGVjQOMnic1+0ei+lZLPytdxhtK171VprnemCbHig=;
        b=cg6oXYkJ1EEcITsyqXe57SyZm+KYFc6S4rQMLzpAexMoHNj1gI81VjfWpuPjP/g354
         siPiscVUA3VXZRWgdQIOU4GjMK/+ABhuv+iQUGV4pBud5d+EPmOPRHgUytm9aatVj5Zh
         vmkh2tYOfHzKer69WVpJP3FJOu84r0N4p2F+dxRLUsSEDKX64g3vlZzeFQcieD25rfG5
         +FNjSnjV4Mr5X5+/3CRgXL5D7gxcGs14XhKLkBDyIR7G/JBUgONESsS/KokXoeBpUap3
         p7WaXyos7ZoPK2w35GJJP7l0tPM4S8c8Kl6cK6bh0XSIHFyylS3Lt/FhK40yg2Zq4+W/
         pryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658794; x=1692263594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXtGVjQOMnic1+0ei+lZLPytdxhtK171VprnemCbHig=;
        b=BJ7hkKXahl/6epNLUhbxUtl4TkwqwlmJCyxiOK/uEFC7s00L8nBcpya3mMUVG5JhzY
         gVFoYyFM1SbHEopGMpzFDB7meGc4ixN7mhGKxKZXdK4QBUO/qtP4lIRgIRuIFDC/YEfv
         EBkaWl4DKv1XX9gAfvdYOYcEAfGF/S4ctqr8n2+OjQBkyq26qxQdPtoQyiguhXRWNj4p
         kq8KDKAr3qT37e5mF5JhTWotPq+GL6XzzVL/4kd+sNO8/kGpeH4jril5aq4/ub01kWf6
         in2ceOvRLO9k60nf/tFsTlXbbhjVdWT4tvJWfF/iGTyxxF/ztwKIqDSyR7afOX8qfsAG
         ux1A==
X-Gm-Message-State: AOJu0YyqJ9P/cXfeI3A8BpxF/eDaLDWbXUYvb/2yoZMRXjaEbueJNBf8
        /HKg8NoDEnxB1AcvtlIkho2YBA==
X-Google-Smtp-Source: AGHT+IFGeEvXqMvDY3+sQ3I/t8okkCSs/dqOrA9AWjerSX9C5S3HbS/ruj8SGoKA/0hkHxQUZ30KEQ==
X-Received: by 2002:a17:906:18d:b0:97d:ee82:920a with SMTP id 13-20020a170906018d00b0097dee82920amr1723205ejb.74.1691658794233;
        Thu, 10 Aug 2023 02:13:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id o16-20020a170906861000b0099bd5d28dc4sm643984ejx.195.2023.08.10.02.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:13:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] phy: amlogic: meson-g12a-usb2: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:13:10 +0200
Message-Id: <20230810091310.70231-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'soc_id' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  phy-meson-g12a-usb2.c:322:17: error: cast to smaller integer type 'enum meson_soc_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/amlogic/phy-meson-g12a-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
index a628c59e5cf0..0e0b5c00b676 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
@@ -319,7 +319,7 @@ static int phy_meson_g12a_usb2_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	priv->soc_id = (enum meson_soc_id)of_device_get_match_data(&pdev->dev);
+	priv->soc_id = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	priv->regmap = devm_regmap_init_mmio(dev, base,
 					     &phy_meson_g12a_usb2_regmap_conf);
-- 
2.34.1

