Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C87B7E8CFA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 23:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjKKWGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 17:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKWGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 17:06:23 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E722B3253;
        Sat, 11 Nov 2023 14:06:19 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso3325865276.2;
        Sat, 11 Nov 2023 14:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699740379; x=1700345179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hJkPGfx6uQ2uiI9j9uHbGyC/BkU4D9ZtAgnm+lv0hko=;
        b=nqlNbjG/5gxLhYlytodur4QjbCOUyl/rCSLIg5v+WZSCKuN1Hcvg+9WpVGdpzdrmvk
         QpFcCBNeavO53rPmhmFU8q/6kMLj3E10M/5KCYEEQponcsi58syoR9IB9EhvAUnza9KW
         bX1GxW+hl3CnDR2MWaJD1zB9/6MkzmRTf9DjBnnoiJ6JmPi+H0oplR8sI4/yB6omE+tZ
         ppb7rpPwKQisiQAlxRxvH6ledO+LnPv+Nx5fN5U8U8nFPjYEuHHB8wElq/0daJO4rAdp
         Ru/dpGDoRPCHzL6+9vSiKhKuG7QUIWOZaWqi66bR3fiLKzkj6y84syGiQf78AZN+KAuP
         JoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699740379; x=1700345179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJkPGfx6uQ2uiI9j9uHbGyC/BkU4D9ZtAgnm+lv0hko=;
        b=IeUTpb5brrK3ePJU5RXXNJlhe46GGOtmTCs0eZit5DC2NVWiRhMg3Icpfs8tVN2LmW
         XXh1niXpnvJbGte7ARLdlxTQDhTkBv0BwFF/eGfFwAt8NCjDsN7RUt269g2lXfvqIHVg
         WVUgRVyJC7CADfSzIeH9O0mEQAeL/ycPAD6NHUU2Bp88d0aBE3WMEVmVgkF7WHvSef6c
         47zlOzmAxntj31/e12WHyBFUm33oq3DUweLXgoMMz4lmprYNL6FZH8bY7/lqzVLxm8xH
         ZgyQtr7NMXCef6TTUbH4WEZaZ7kdkg6CG9jWnEhhMzFJ1f1G2BljLuE0BNxrzgdYA8NP
         qKAg==
X-Gm-Message-State: AOJu0Yw+Mct6+9Sv6FZtanjyRXQ4zvGHEBiCZpt309EM/2kIg+Cbvaiv
        sxrlPmtHzYqebIyFIz2LwFxAZSTZuiVKHg==
X-Google-Smtp-Source: AGHT+IELHKUUAwNwg+un5G6Qx/qrkNwRUzKTFVKf16yN8au1z0gTkO2DbjshIHlDLu1XisiHs5B1xA==
X-Received: by 2002:a25:da51:0:b0:d9a:b48c:7d96 with SMTP id n78-20020a25da51000000b00d9ab48c7d96mr2906791ybf.1.1699740379111;
        Sat, 11 Nov 2023 14:06:19 -0800 (PST)
Received: from localhost.localdomain (bras-base-ktnron0692w-grc-13-174-95-13-129.dsl.bell.ca. [174.95.13.129])
        by smtp.gmail.com with ESMTPSA id z10-20020ac8710a000000b004196a813639sm758558qto.17.2023.11.11.14.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 14:06:18 -0800 (PST)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abdel Alkuor <alkuor@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: temperature: Add AMS AS6200
Date:   Sat, 11 Nov 2023 17:05:01 -0500
Message-Id: <7e108db19cd9ad19b6413f65099280c010325a91.1699740057.git.alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as6200 is high accuracy temperature sensor of -/+ 0.4C degree
with a range between -40C to 125C degrees

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
 .../bindings/iio/temperature/ams,as6200.yaml  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
new file mode 100644
index 000000000000..97a73b92a789
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/ams,as6200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS AS6200 Temperature Sensor
+
+maintainers:
+  - Abdel Alkuor <alkuor@gmail.com>
+
+description: |
+  https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
+
+properties:
+  compatible:
+    const: ams,as6200
+
+  reg:
+    maxItems: 1
+
+  interrupts:
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temperature-sensor@48 {
+            compatible = "ams,as6200";
+            reg = <0x48>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
+        };
+    };
+...
-- 
2.34.1

