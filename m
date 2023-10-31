Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658447DD6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 21:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjJaUQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 16:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjJaUQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 16:16:10 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1611BF3;
        Tue, 31 Oct 2023 13:16:08 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso89607461fa.0;
        Tue, 31 Oct 2023 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698783366; x=1699388166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tr19e9gv31OTc0mDwGXJDeruCxSwIiXl36Q8XiuObzo=;
        b=QtrLEpzSEk252CqqLzZeRtOad3h3QL8unE5fzF9/2I4KCVWlHuXeaXqi+TVieN9QiL
         YGF9J1IFyYrToS+0vSuXd69LOq0buZjOx6BgwBv3uUzxBbMUHAwRhoeBuyD8dVIBmQsy
         ItOvyjmexquqw5tfTbnhG7ah/76qeYhXxvAxfw2RElKiubQ0R8YecVECZpYfdCHFgqZI
         FbqPNKdGtKzGmlArS6vAQ01aaB6AM9imK6tFYNP/IGyl7f8V+4bZZzB/n708vualW+1o
         Uc9/fOoPZ+IfzXu/3QRjabRWGOPdbLmxlDB6S2Temj99HXW8/2Do/2Y18cAd06CrUtTH
         ku1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698783366; x=1699388166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tr19e9gv31OTc0mDwGXJDeruCxSwIiXl36Q8XiuObzo=;
        b=mje293xtVywUCNHMsZ0W7YD6LcHxm4uquMisBJDYDL0cO/48NcHTyqFtWrsaUofl0l
         emr54qYlRV8MG3s2wj6hlOGAKzk6BHWUNwPG0yGmMyhBotrDKBbHFDwtJVQYiY3FSE7D
         ej4WVNSwQna8MeeFlHePBWBW9tqGYjOB5yrhWbIlCBrXXXcOim7Ffo9efBjrb/k+uWiM
         xOBSnTrmN/YnC11pJKQ4L2OnsYra0qIv9OqyW9hT91q3CKP5No8YicG/6oY6dSxCARpq
         iJ+5upNQzeq5PQALnK90XZHXO7nJJCa9GqkWH6apNQpS+focMinpuFIk1qwa+2kvhU/6
         xMOA==
X-Gm-Message-State: AOJu0YxcL3Ghy+eadDkdJWJixgEfCKd2SO/Gp4r4qAVsEtGmkkR5vzY7
        /ttUD2Gnq/RkkaPZ0AyqKWk=
X-Google-Smtp-Source: AGHT+IEM57jvgzys/NWgC6l16I7lrfw7JpLgmsLDm/p+GDEwg1yosJo+9qd/8geccBmcinPWfCBwzw==
X-Received: by 2002:ac2:4555:0:b0:507:9a12:b655 with SMTP id j21-20020ac24555000000b005079a12b655mr9585633lfm.23.1698783365935;
        Tue, 31 Oct 2023 13:16:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3664:41b4:2058:a492:5d22])
        by smtp.gmail.com with ESMTPSA id ec20-20020a0564020d5400b0053fa13e27dcsm66388edb.48.2023.10.31.13.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 13:16:05 -0700 (PDT)
From:   Nik Bune <n2h9z4@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        skhan@linuxfoundation.org, juhosg@openwrt.org
Cc:     Nik Bune <n2h9z4@gmail.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: qca,ar7130-wdt: convert txt to yaml
Date:   Tue, 31 Oct 2023 21:16:02 +0100
Message-Id: <20231031201602.28827-1-n2h9z4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert txt file to yaml.
Add mainteiners from git blame. 

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

