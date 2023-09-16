Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFD87A3036
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbjIPMjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbjIPMjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:39:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF21CED;
        Sat, 16 Sep 2023 05:39:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-502defbb0c3so5005488e87.0;
        Sat, 16 Sep 2023 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694867942; x=1695472742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nieLmXIKnfkthdI8h0lUoH7VKVpFKo/h00FyBK08R40=;
        b=RgZRIzAuQ4s6Xgali18E5fanTzIhz4xRh+yxU+V7xV1TjIIbsvOm8JfqHffcUmnAUH
         Rzrz9878DpKNex4p4Z0uU2Fg6KmX3n340tPYJHQmuDrYdegzB2/pi62+45dUofpnTjGF
         qvPJWdYvdNoy/enuKwLpk4FWVzNRSt9vdRnnXZwfjst3XvVqXxhO9N2EnQDtX58QMcFx
         9MroYpz7xZftxZvNFXqzX8IxD1y6pEWc6202dVDUx76wABnX3cyyMiVbjM/OLjJ4wj5P
         bbUSte9tmnQ23D3Ni0ABsIMzdosWO/47dA6xmhw5smwN2/FHpvncl5ClYH0Wou9TlOAZ
         6KvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694867942; x=1695472742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nieLmXIKnfkthdI8h0lUoH7VKVpFKo/h00FyBK08R40=;
        b=NqWPMCp1zUQ0HzMKnf488NxPyLfXvIUhJJmsj1lWS9Wyb1XJURsKZ6TnXPGDXp1OkM
         TPIetcwR/SzfjtpiLR162p7pL8g4pTeOgXr2IKUu4lPafDEEAwnopDpIGx5lCEbIGX8m
         sAdG/pTkTHE2VqXIWmh1yrYLqTER9PLy2GVpGM/ts1hvS9auDEQ5D2Vv1esDipKAjSKn
         k0+4BymhRgs/F+ZWH25i9mMsXMemP52FMfWWc/pgZyYnPrpxeASWUI0QDASsqyyiD9kp
         MzTOuO3jZ7owiapSrkuUsET05hCpOBK2ab45ZuU4bGdMFFCllFQzEHUDqaHscKm2QArG
         Kraw==
X-Gm-Message-State: AOJu0Yz4KGvaadPCZCGt++MO82o2yjYfHsxENQCgQQG3T/2R04XX3HWT
        zwd2RsBHA/rBf1wA6djZtPU=
X-Google-Smtp-Source: AGHT+IH/qxwqx8+EhczONsEZzFXbPcYDeP3F71DAK4QPw1NoWKyfQ+3paOogF1UI8wcNqMcQmmbhmw==
X-Received: by 2002:a05:6512:3e05:b0:503:3b5:a65 with SMTP id i5-20020a0565123e0500b0050303b50a65mr1457882lfv.31.1694867942097;
        Sat, 16 Sep 2023 05:39:02 -0700 (PDT)
Received: from localhost.localdomain ([77.134.181.150])
        by smtp.gmail.com with ESMTPSA id bo6-20020a0564020b2600b0052284228e3bsm3474064edb.8.2023.09.16.05.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 05:39:01 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/7] dt-bindings: iio: Add KX132-1211 accelerometer
Date:   Sat, 16 Sep 2023 14:38:47 +0200
Message-Id: <735004c624082aead6e08ae37ea4fc086b11cf86.1694867379.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1694867379.git.mehdi.djait.k@gmail.com>
References: <cover.1694867379.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the kionix,kx022a.yaml file to support the kx132-1211 device

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 .../devicetree/bindings/iio/accel/kionix,kx022a.yaml | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
index 986df1a6ff0a..034b69614416 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
@@ -4,19 +4,21 @@
 $id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ROHM/Kionix KX022A Accelerometer
+title: ROHM/Kionix KX022A and KX132-1211 Accelerometers
 
 maintainers:
   - Matti Vaittinen <mazziesaccount@gmail.com>
 
 description: |
-  KX022A is a 3-axis accelerometer supporting +/- 2G, 4G, 8G and 16G ranges,
-  output data-rates from 0.78Hz to 1600Hz and a hardware-fifo buffering.
-  KX022A can be accessed either via I2C or SPI.
+  KX022A and KX132-1211 are 3-axis accelerometers supporting +/- 2G, 4G, 8G and
+  16G ranges, variable output data-rates and a hardware-fifo buffering.
+  KX022A and KX132-1211 can be accessed either via I2C or SPI.
 
 properties:
   compatible:
-    const: kionix,kx022a
+    enum:
+      - kionix,kx022a
+      - kionix,kx132-1211
 
   reg:
     maxItems: 1
-- 
2.30.2

