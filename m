Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C877783D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjHVKKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjHVKJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:09:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9377718B;
        Tue, 22 Aug 2023 03:09:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26d49cf1811so2021872a91.0;
        Tue, 22 Aug 2023 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692698997; x=1693303797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpAcRisUyrskcWS9AV1ql1Z9KFMGwKdSa1ZIJWKbDtE=;
        b=di/waxyU1RwzQOGCQUjWPIcmGm7nMxFb+Crsiw0HiH7uQg6JdWYPXH/zipzX2ufxYA
         xgCh6OBoTadk39EKFNSbkLCXyg8RAaue/3nMYWljlciGnw6FKpvloIJWdkk8CYNnECuh
         8VfIKCNBCyd+BaVN2kF634O289R3duwAU72vo5u/mO1RVN0UljuufG34VFcBaYoxGSOM
         umdVCGzy1R4jejs7DX6LNhdyz8vZJzV4I4io4O6eB+N9LJzecNWOrlfTFvOr8/ayMDVS
         mHbSIqc9tOWPqkW7mwhnAYyftFuVMdnTREu+KSv3BLU1E9vWMB2H7ytzARsPhkvVm9Il
         zsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692698997; x=1693303797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpAcRisUyrskcWS9AV1ql1Z9KFMGwKdSa1ZIJWKbDtE=;
        b=YPY1iXatFyhjdhfEc/7/XtEKJ1janWOjKeYiwAZN7c98Z00eHY+NRbkhQE/11y0krk
         mgYILu0PWHWOGJ3CUV2j4lyyjZJSjkZNl6rFj+zWLiflB/Gpi1Kq1ne/Q0O7J7405yYg
         c1UewlKqKmSEjtVga64z/fhu7xdTCjhTHT2tNY/kYl9KUecv2Y/UiCYpGnmOIR551H8m
         kA741ejhsS4OVOTMIgJGfypBXYX/GGpCc2LNJaFHg4d1fbvWl7vt07nCTRZ+6c9RxA8M
         ppNkBw0aXo/Uf7raKfUv1f0skc0doHlKLu9qWWy9S9F8P7zErdwlGgfnCUQaNUkiEsWc
         tAUw==
X-Gm-Message-State: AOJu0YzX8swPs9kXkVDhN+3XqppWKefwvsqWh53XLui+mC95GJ8DLSGv
        HXIFWCR8eg01sK4bvz33Dc0=
X-Google-Smtp-Source: AGHT+IF4shcelW6ONoQrgnmBOad91csKV+H7SubrAKxl9uy8OFFTv+GX3CRlybnzf5XbrvR+aJfwxw==
X-Received: by 2002:a17:90a:3ec1:b0:26d:4642:1bd7 with SMTP id k59-20020a17090a3ec100b0026d46421bd7mr6180562pjc.34.1692698996974;
        Tue, 22 Aug 2023 03:09:56 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090a948a00b00263cca08d95sm9278975pjo.55.2023.08.22.03.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 03:09:56 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: rtc: Add Nuvoton ma35d1 rtc
Date:   Tue, 22 Aug 2023 10:09:46 +0000
Message-Id: <20230822100948.1366487-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822100948.1366487-1-ychuang570808@gmail.com>
References: <20230822100948.1366487-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add documentation describing the Nuvoton ma35d1 rtc controller.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/rtc/nuvoton,ma35d1-rtc.yaml      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml b/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
new file mode 100644
index 000000000000..5e4ade803eed
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nuvoton,ma35d1-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Real Time Clock
+
+maintainers:
+  - Min-Jen Chen <mjchen@nuvoton.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    rtc@40410000 {
+        compatible = "nuvoton,ma35d1-rtc";
+        reg = <0x40410000 0x200>;
+        interrupts = <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clk RTC_GATE>;
+    };
+
+...
-- 
2.34.1

