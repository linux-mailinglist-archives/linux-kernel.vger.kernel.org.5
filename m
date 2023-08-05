Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57936771147
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjHESF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjHESFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:05:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EEB198E;
        Sat,  5 Aug 2023 11:05:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-317c1845a07so2448743f8f.2;
        Sat, 05 Aug 2023 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691258745; x=1691863545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui9mFi+8YpeTm0k09SoqGWMWxqwLX8g/SM0GMtVVuxo=;
        b=JXaio9I8DD4b5kA/e3J4i8BugFtaIhTeAsqI8YpbFje4l002vWoSJ8cMKU0hUZuEmx
         lJAOUXG/CbuqOiK9JDZTQ473fZqnNUUQRQZYrGhXaFfFddAtxYbXuvYdP4MUOkxQVpCG
         6k6GEhMUUMZw+XmGLr874mRvlbYTfED9V1LBPWg0EqkDvmmI9ce4MBY+N6pZa1lcQNdU
         tR4H3XCjWUe/PW7LQiz97Swp4uEEos7FS9Z7u18Zjm1kVlHGpx/tx/NPI5jN2g5bkxQz
         hbiHrAB7ihoLl3P2ybOtQlJLx4Ha62sof5/RxtfZL1sivlBqdiis7qyRd3rRo0eCwJD4
         gekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691258745; x=1691863545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ui9mFi+8YpeTm0k09SoqGWMWxqwLX8g/SM0GMtVVuxo=;
        b=Oiqar5noBvy7BH68wzZIJzSKEmvrNtjKUJG5ACh7Fk8etRTRVXWl/vefCqsNyRNyMB
         BVdoHgPlWC0XxHKmCCspeJc7eVRtgycMihAtjmqXOMLh15LA7vooYfJ8YmlIu/X1oEvE
         8Jen0FLfWHeyJYbzxYRfTKswTjsLSAup8ClchpXqkZPbhCSAtnTaTe/QSCl3AYRXsmEg
         tIgEg96gjBw7mreelP5EqnKd1SQWT2XBa6lopVDcD29+Z8bnnSEZaFdFRbGMJGuR6tJa
         3NnCgqty3bhU02xPvtXwhVUJjSHe4sZlnwIt0wz3CmuGk/O0Khk6SLrlPWwgXGSG4Ipy
         K7JQ==
X-Gm-Message-State: AOJu0YyXUyzeU4AYKKplGnK4X5RhkRhGbKiCV3lHvxuOlPQGbplE2xvm
        URMJDc/Bo3Cswqz9eJSpor/guq1o61dPyw==
X-Google-Smtp-Source: AGHT+IH52KbShgZ7/MyYYljmA/7meZEjQcL6qqHPDeWo7emmXLPpHbnsfG22wPwvuhUIyNpA/ptA7Q==
X-Received: by 2002:a5d:4b43:0:b0:317:5d3d:d37c with SMTP id w3-20020a5d4b43000000b003175d3dd37cmr2878909wrs.24.1691258744489;
        Sat, 05 Aug 2023 11:05:44 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6104000000b003176aa612b1sm5710402wrt.38.2023.08.05.11.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 11:05:44 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v1 2/5] ASoC: dt-bindings: Add schema for "allwinner,sun20i-d1-codec-analog"
Date:   Sat,  5 Aug 2023 21:05:02 +0300
Message-Id: <20230805180506.718364-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230805180506.718364-1-bigunclemax@gmail.com>
References: <20230805180506.718364-1-bigunclemax@gmail.com>
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

Add a DT schema to describe the analog part of the Allwinner D1/T113s
internal audio codec.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 .../allwinner,sun20i-d1-codec-analog.yaml     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun20i-d1-codec-analog.yaml

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun20i-d1-codec-analog.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun20i-d1-codec-analog.yaml
new file mode 100644
index 000000000000..7586076b9bc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun20i-d1-codec-analog.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/allwinner,sun20i-d1-codec-analog.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner D1 Analog Codec
+
+maintainers:
+  - Maksim Kiselev <bigunclemax@gmail.com>
+
+properties:
+  compatible:
+    const: allwinner,sun20i-d1-codec-analog
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    codec_analog: codec-analog@2030300 {
+        compatible = "allwinner,sun20i-d1-codec-analog";
+        reg = <0x02030300 0xd00>;
+    };
+
+...
+
-- 
2.39.2

