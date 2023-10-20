Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919597D0DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377109AbjJTK4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377051AbjJTK4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:56:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D48E8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:56:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40651a72807so5097895e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697799365; x=1698404165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRbaZ8Ef1/VZbZ1Yxpg4ZanC3ZxTD3DH0ZyYq9tLTZ8=;
        b=d+hd1qrNILTFjR/0SeUcj6Rll7b/BuymtKDBiYfUHu9bJMKRaw5HQinl1ei7eRhgd1
         /BJ7sRWk3S6MZ3EGqItbhK0JI/88HdlcKhdEyoq0LGFFVwVk6RfpQ2IdqVGaDOgoyyjG
         GCOao622pz6gWGyc4Kt13Y31It83PEIBI90yPYTfgyR4oh9hYUFhemOae3qerkO9YCXV
         6pyIgwvkKFy1V9mAg8FoDLlL6RiPjrVmyDJgHMQ7PJnyd8Os8RW7+qGBCrkUFS30fEHZ
         RyZ/KfmzqgEuvaN7iZa1APrdLQ4Dtnez+3tkN4fTFy7vJLZ57U8BcB6FWUw42u6R5A1J
         c5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799365; x=1698404165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRbaZ8Ef1/VZbZ1Yxpg4ZanC3ZxTD3DH0ZyYq9tLTZ8=;
        b=gFKMfU5vaxCphNBS4u1nmqpEUy6Lxn9tmQK+iZkot3EieSyC2nV+KvqLZNnKdmBYWm
         Kvl5yWewjxZaGtMzzutAkdMWRUzRo5cFM+hZxO8AGsZJi/VbP9RMUIBdM25WHjkz7Vhu
         gMwDtc89U6wGrozlH/tufNCYlgskA3qZ5c5yBH/7uo432RDxYQuuAcKR83BkedbIaq2d
         AKg8W7QL2LVngM9xCVBGUFOk+MmiI1vRjmt4oSSQytudjyc0jPFEe9bqCCd31pWyfLKC
         dnkxcAeW3apKkS0vf/6pFasrCCcYSSW68oO56KM/95sg4qMA3Ls+LMuDaO34aBGR2DUO
         jOPw==
X-Gm-Message-State: AOJu0Yx9uHqJCSITywEwqWFurSCkm1oHUr+sfJydqYX60eEGXopU4ubE
        4WQiY3iAhIrLaZz4BKwGrvdeXA==
X-Google-Smtp-Source: AGHT+IGi42aP8GCCjDqzsue+hg2+yJsIZ408/fc2DoT6sKJ1mgr20X2NyOHAsqYtdbIqRaMHmOqLvA==
X-Received: by 2002:a05:600c:1912:b0:401:b6f6:d90c with SMTP id j18-20020a05600c191200b00401b6f6d90cmr1253075wmq.35.1697799365203;
        Fri, 20 Oct 2023 03:56:05 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c420900b004065e235417sm6578937wmh.21.2023.10.20.03.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:56:04 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/6] dt-bindings: nvmem: move deprecated cells binding to its own file
Date:   Fri, 20 Oct 2023 11:55:42 +0100
Message-Id: <20231020105545.216052-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
References: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Support for old NVMEM fixed cells was deprecated in favour of
"fixed-layout". It's still part of the nvmem.yaml though and may be
unknowingly used by new bindings added without much of analyze.

To make it more difficult to accidentally support old syntax move its
binding to separated file with "deprecated" in its name.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/mtd/mtd.yaml          |  7 ++++-
 .../bindings/mtd/partitions/nvmem-cells.yaml  |  1 +
 .../nvmem/amlogic,meson-gxbb-efuse.yaml       |  1 +
 .../bindings/nvmem/amlogic,meson6-efuse.yaml  |  1 +
 .../bindings/nvmem/apple,efuses.yaml          |  1 +
 .../devicetree/bindings/nvmem/imx-ocotp.yaml  |  1 +
 .../bindings/nvmem/mediatek,efuse.yaml        |  1 +
 .../nvmem/microchip,sama7g5-otpc.yaml         |  1 +
 .../devicetree/bindings/nvmem/mxs-ocotp.yaml  |  1 +
 .../nvmem/nvmem-deprecated-cells.yaml         | 28 +++++++++++++++++++
 .../devicetree/bindings/nvmem/nvmem.yaml      |  9 ------
 .../bindings/nvmem/qcom,qfprom.yaml           |  1 +
 .../bindings/nvmem/qcom,sec-qfprom.yaml       |  1 +
 .../bindings/nvmem/qcom,spmi-sdam.yaml        |  1 +
 .../bindings/nvmem/rockchip,otp.yaml          |  1 +
 .../bindings/nvmem/rockchip-efuse.yaml        |  1 +
 .../nvmem/socionext,uniphier-efuse.yaml       |  1 +
 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml  |  1 +
 .../bindings/rtc/amlogic,meson6-rtc.yaml      |  1 +
 19 files changed, 50 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem-deprecated-cells.yaml

diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index b82ca03e969c..f322290ee516 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -43,7 +43,12 @@ patternProperties:
     deprecated: true
 
   "^otp(-[0-9]+)?$":
-    $ref: ../nvmem/nvmem.yaml#
+    type: object
+
+    allOf:
+      - $ref: ../nvmem/nvmem.yaml#
+      - $ref: ../nvmem/nvmem-deprecated-cells.yaml#
+
     unevaluatedProperties: false
 
     description: |
diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
index 5474d63268dc..9518281007af 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
@@ -19,6 +19,7 @@ maintainers:
 allOf:
   - $ref: /schemas/mtd/partitions/partition.yaml#
   - $ref: /schemas/nvmem/nvmem.yaml#
+  - $ref: /schemas/nvmem/nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
index e49c2754ff55..9801fe6f91b5 100644
--- a/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml b/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
index 84b3dfd21e09..b5cf740f96fa 100644
--- a/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
@@ -12,6 +12,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
index e0860b6b85f3..d3abdafdbca0 100644
--- a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
+++ b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
@@ -16,6 +16,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index 99e60d713dac..be1314454bec 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -16,6 +16,7 @@ description: |
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index 7ec2988b597e..cf5f9e22bb7e 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -16,6 +16,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
index a296d348adb4..cc25f2927682 100644
--- a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
+++ b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
@@ -16,6 +16,7 @@ description: |
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
index a9b822aeaa7e..f43186f98607 100644
--- a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem-deprecated-cells.yaml b/Documentation/devicetree/bindings/nvmem/nvmem-deprecated-cells.yaml
new file mode 100644
index 000000000000..951af28bbfb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nvmem-deprecated-cells.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/nvmem-deprecated-cells.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM old syntax for fixed cells
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Before introducing NVMEM layouts all NVMEM (fixed) cells were defined
+  as direct device subnodes. That syntax was replaced by "fixed-layout"
+  and is deprecated now. No new bindings should use it.
+
+patternProperties:
+  "@[0-9a-f]+(,[0-7])?$":
+    type: object
+    allOf:
+      - $ref: layouts/fixed-cell.yaml
+      - properties:
+          compatible: false
+    deprecated: true
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 9f921d940142..4fd015d402ce 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -46,15 +46,6 @@ properties:
       container may reference more advanced (dynamic) layout
       parsers.
 
-patternProperties:
-  "@[0-9a-f]+(,[0-7])?$":
-    type: object
-    allOf:
-      - $ref: layouts/fixed-cell.yaml
-      - properties:
-          compatible: false
-    deprecated: true
-
 additionalProperties: true
 
 examples:
diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 8740938c32eb..8c8f05d9eaf1 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
index 9b133f783d29..2ada2099946d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
@@ -16,6 +16,7 @@ description:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
index cd980def97b8..068bedf5dbc9 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -16,6 +16,7 @@ description: |
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
index 9c6eff788928..a44d44b32809 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
@@ -49,6 +49,7 @@ required:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
   - if:
       properties:
diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
index c5403e149080..b80fd8d1ae5b 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
index efccc5aacbe0..e27cbae2d63a 100644
--- a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
@@ -12,6 +12,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
index da3f1de7d281..af97eeb8316c 100644
--- a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
@@ -12,6 +12,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/rtc/amlogic,meson6-rtc.yaml b/Documentation/devicetree/bindings/rtc/amlogic,meson6-rtc.yaml
index 8bf7d3a9be98..3a4551253e3e 100644
--- a/Documentation/devicetree/bindings/rtc/amlogic,meson6-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/amlogic,meson6-rtc.yaml
@@ -13,6 +13,7 @@ maintainers:
 allOf:
   - $ref: rtc.yaml#
   - $ref: /schemas/nvmem/nvmem.yaml#
+  - $ref: /schemas/nvmem/nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
-- 
2.25.1

