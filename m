Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BD87886B6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244486AbjHYMMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244620AbjHYML4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:11:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4762105
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:11:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ff933f9ca8so1291953e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692965513; x=1693570313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhIkzsyTKm670j6OXVUadyYcO048MWKmieMFi0kdsqU=;
        b=oZ2Ey6AHeynFNLLoCwmcpV/iHUNu/GVg4qpIbNpwiA7oe1toexTbxTXhSQQD7/zQ98
         5MIGiFL1oH/UueBNsNFT/tSN4BR06ivWpe0xbrVCjctcGYbzzlWnWW9pNxjZY/WLY4lV
         AQFykQ78Qh0+ZsM6slzxVKSDWkm0Ht/v6+C8r2U3Qu0LTb6B5SNHymM90EK4PUbnXOkA
         yl1ZP2Tc64Iy9EebcB0I4Ih6gzuG3fqtoX3N2gfYi8ni/JPawTPxuxfi1UWX45qQ01Ue
         qZMvc5K/174DINLVkmoI62PtCDyU+xD6jl5GX/WiJxmqFCVfIuA+nhaBwV55ICa/9rLs
         D2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692965513; x=1693570313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhIkzsyTKm670j6OXVUadyYcO048MWKmieMFi0kdsqU=;
        b=VVZH3p+jMoQwFfd6OyqcMjAXb9t7ctC0icmuTRBTDiRcFc0N+aeiRZ+K10toe5DoXL
         W4KU/4bmZU3YzGsLap/2a0IwB9j2XYjIA/NkAsk+YL4qPc0k1MoNNznXMcqdTmRbO1fJ
         nAkO2093ILMF02yzb2Z05x4KBMp0HnKKcCJqLdYMjAFGexkZtbnXGH+E1q2aEamMOJLO
         mTMmM65ERWAHaFmMTP8VUsx5UMnAPGoxIPxoQV/5IprbTrDd4wEXmdJDczpbZWeMue+z
         7NFJYtKMSjjY76MvW0DSw3iq4ZFqav5S+fYSgQQghN02dPlEwTOpgEwfZXIrkdqcShC5
         /8Rg==
X-Gm-Message-State: AOJu0YxrfTL0NfX/Bu9AAgLmyCBvzvtv+mKSyEF0vpqtm0WnWsVULs9M
        5JzwA7H1jHGPKXOnaQiCqV+CZA==
X-Google-Smtp-Source: AGHT+IELNGy+ZJX03ObKjQP+MzDwqRIy5Q5gtBaOdGmbJfuToQbeiU29jbARS+FjeuGm36A8/pxAhw==
X-Received: by 2002:a05:6512:36d2:b0:500:9524:f733 with SMTP id e18-20020a05651236d200b005009524f733mr5221093lfs.20.1692965512717;
        Fri, 25 Aug 2023 05:11:52 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id l5-20020a056402124500b005222c6fb512sm952311edw.1.2023.08.25.05.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:11:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: display: panel: add common dual-link schema
Date:   Fri, 25 Aug 2023 14:11:40 +0200
Message-Id: <20230825121142.101759-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add schema with common properties shared among dual-link panel ICs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v3:
1. Re-phrase description of binding and ports (Laurent)
v3: https://lore.kernel.org/all/20230823081500.84005-1-krzysztof.kozlowski@linaro.org/

Changes since v2:
1. New Patch
v2: https://lore.kernel.org/all/20230502120036.47165-1-krzysztof.kozlowski@linaro.org/
v1: https://lore.kernel.org/all/20230416153929.356330-1-krzysztof.kozlowski@linaro.org/
---
 .../display/panel/panel-common-dual.yaml      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml b/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
new file mode 100644
index 000000000000..cc7ea3c35c77
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/panel-common-dual.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for Dual-Link Display Panels
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
+
+description:
+  Properties common for Panel IC supporting dual link panels.  Devices might
+  support also single link.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: First link
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Second link
+
+      "#address-cells": true
+      "#size-cells": true
+
+    required:
+      - port@0
+
+# Single-panel setups are still allowed.
+oneOf:
+  - required:
+      - ports
+  - required:
+      - port
+
+additionalProperties: true
-- 
2.34.1

