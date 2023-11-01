Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8752C7DE703
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347757AbjKAU1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjKAU1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:27:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42643F7;
        Wed,  1 Nov 2023 13:27:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso305802a12.1;
        Wed, 01 Nov 2023 13:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698870445; x=1699475245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhBw4zCHxGGAZvnSQ/49rcOK9zH+oVCUcbaWsyj5PLQ=;
        b=QagpTg3d1wCwobzHFIfOqTb8LnyW3Y1DntrHQ9yjzVDjSbM83/Qd73GOvXu+EGnVcN
         qhnICw4nXcFwtoMJ80FF3IFuC8pgaeQ6URZyvnsCCKvIiHOYUKvdIdzqV2f+GaBSGpRn
         GtTOv5ypx/pGMOAJ/3+mqnu0qlhghj3ROyn2AFyZBShSw7c8G5xqeUqqKE+1LS5xeuXb
         MxvjdWNvS9ZK7wXDHmgiHUg1Tb7j3uo0SDYwQlCr7rMgq0p6mgRsl0VlZ4TOur/Pe5Hf
         DJPkUo3/RWzG5t9OlQQUvHb+pHA3yRcku9z1T6sXV1Hj91TPIWUwkTKxyIFucYgUqlzl
         q66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698870445; x=1699475245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhBw4zCHxGGAZvnSQ/49rcOK9zH+oVCUcbaWsyj5PLQ=;
        b=iYBuLZg6RSk4ugqjf+2tN/o/AXehio1npE0mCO7ZHCyc16SoxqWSZ4rIzVQ6885a3x
         nZgGNEG0BQWDaqsHQz1wLpxYU7a+56/pHugUwm1+rt0wv47oCuyeskdvO0wQLynFRE3k
         Rf5tep1yVIbDbe4K8q6P15NW52lYVCKuRF70gU0sLBrADSU7lmA2e6gAVmBKuogIPHBl
         jL7NY3RU9nEFg3FjjVz0vWxirf5HEY+jCcMFSXCduRfcLNN3YybsYeS2bBFbJUi+rkK6
         msGAT4qf1j6hk19ccvrpuKHoUN7aUBWyoSPvjWNdGbjNNBK8IbqVpVe+0LFPHuvyaggi
         wjBA==
X-Gm-Message-State: AOJu0YwWCVTabZq1Wn43g2iE9Zhg+2+ruutFqusEgtcOOFXhjWnL8QJF
        a/Wq7uK7ryObhKiywXKeNv0=
X-Google-Smtp-Source: AGHT+IH3m98qMxRNrqqMHjiPpurQVJeS6J2iiyPRB7gNPWXSgLO1DsiGtkzwCSYC3Cbro12FdEFuhA==
X-Received: by 2002:a17:907:3f07:b0:9d3:8d1e:ce9 with SMTP id hq7-20020a1709073f0700b009d38d1e0ce9mr2793517ejc.20.1698870445398;
        Wed, 01 Nov 2023 13:27:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3664:f152:da56:1dc5:79c])
        by smtp.gmail.com with ESMTPSA id b8-20020a170906038800b009b64987e1absm325857eja.139.2023.11.01.13.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:27:25 -0700 (PDT)
From:   Nik Bune <n2h9z4@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        skhan@linuxfoundation.org, juhosg@openwrt.org
Cc:     Nik Bune <n2h9z4@gmail.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: watchdog: qca,ar7130-wdt: convert txt to yaml
Date:   Wed,  1 Nov 2023 21:27:22 +0100
Message-Id: <20231101202722.48056-1-n2h9z4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert txt file to yaml. Add maintainers from git blame. Drop qca,ar9330-wdt from example of compatible property and leave only qca,ar7130-wdt, as description of property mentioned must be qca,ar7130-wdt.

Signed-off-by: Nik Bune <n2h9z4@gmail.com>
---
 .../bindings/watchdog/qca,ar7130-wdt.yaml     | 33 +++++++++++++++++++
 .../bindings/watchdog/qca-ar7130-wdt.txt      | 13 --------
 2 files changed, 33 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/qca,ar7130-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/qca-ar7130-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/qca,ar7130-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qca,ar7130-wdt.yaml
new file mode 100644
index 000000000000..82040ca10eda
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/qca,ar7130-wdt.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/qca,ar7130-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Atheros AR7130 Watchdog Timer (WDT) Controller
+
+maintainers:
+  - Gabor Juhos <juhosg@openwrt.org>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    const: qca,ar7130-wdt
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@18060008 {
+        compatible = "qca,ar7130-wdt";
+        reg = <0x18060008 0x8>;
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/qca-ar7130-wdt.txt b/Documentation/devicetree/bindings/watchdog/qca-ar7130-wdt.txt
deleted file mode 100644
index 7a89e5f85415..000000000000
--- a/Documentation/devicetree/bindings/watchdog/qca-ar7130-wdt.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-* Qualcomm Atheros AR7130 Watchdog Timer (WDT) Controller
-
-Required properties:
-- compatible: must be "qca,ar7130-wdt"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-
-Example:
-
-wdt@18060008 {
-	compatible = "qca,ar9330-wdt", "qca,ar7130-wdt";
-	reg = <0x18060008 0x8>;
-};
-- 
2.34.1

