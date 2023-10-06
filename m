Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0EE7BB604
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjJFLLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjJFLLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:11:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2AEF7;
        Fri,  6 Oct 2023 04:11:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5363227cc80so3285198a12.3;
        Fri, 06 Oct 2023 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696590686; x=1697195486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qqqheVrn2dvVzhKiqfN3c2tbsXwOeqR190xBlY1dKRs=;
        b=S/4/ZLCWN3x4hFUdObyDVuFvbSKxCO9ymgi9N3kqa7CmG6DtM+BTsxuBmtOzSoUQRd
         bSIeYw7Fgg7w4uEYf+wCSxxD3qEIQ0JrpyFOlRYMd/LqqQ15AjDAfbl+MGQeN3qlyEYN
         ZhVtaLAKYu6hnJ+F4ZYalAc4hH8ujB/5chSbeUAWPq/Ya+i0y9GgLzg7SJRZ+ROFt45+
         HcJXDjIVgwj89OMaPFW8KE1iigr+UEOonShita4kWKwd3tXSUWbxxjwTIFAjpkiaJB0Z
         IWyzhn1kdRc/Y6sxxYKLTD1r97BdTuHud6MBmzeXpCtxox/vxebb0SepfXJE9xbX7Afa
         FKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696590686; x=1697195486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqqheVrn2dvVzhKiqfN3c2tbsXwOeqR190xBlY1dKRs=;
        b=ig/3Piql10ING7OsL91Jdql3iB2QGZzqKxUDSnmfFayCwgtXFEGZevbDHv/i40uNFq
         3LoCn5XB71c93M46mgKBA4f/QY7u5LOOBtEBWrxNDrf32v511hOud26MXLR3itbXZjfD
         oS2SYnaz3h0Jhv9zdqbe4eoFO2bn9bDfXwjXzolezoiIL6FVdcvneTECeZbOxqf2uiVW
         Xx35iWRHOamY69QM6UHFQtbEyqdzsVbZGDuXWoRJHm7o4O7opuqXQvmkgJafldVVZ3pB
         EirTOdcHgcpXvYV3O0TA5OdevTLoXVik6oC+oSsP0LdXAd++53ilVk0nYbzSXa4eJpLx
         fqAQ==
X-Gm-Message-State: AOJu0Yy4JxS9dK4hjv+HOdDn0GZfHbNNfSR+AQFHi8/mfhdBaeiDTNXu
        UDkE28H3UlN8DUqpJxpT9VA=
X-Google-Smtp-Source: AGHT+IH9bdRhaUPtGb3TVkE1F7pYW0uRNFzODCbu7DYR3kgSW+gPF7F+RCLnreqWvUiBmACu8ExWag==
X-Received: by 2002:a05:6402:3448:b0:522:cef7:83c3 with SMTP id l8-20020a056402344800b00522cef783c3mr7927693edc.8.1696590686125;
        Fri, 06 Oct 2023 04:11:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3664:3943:fa67:3eb4:21c3])
        by smtp.gmail.com with ESMTPSA id bf14-20020a0564021a4e00b005362bcc089csm2354119edb.67.2023.10.06.04.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:11:25 -0700 (PDT)
From:   Nik Bune <n2h9z4@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        skhan@linuxfoundation.org, stwiss.opensource@diasemi.com
Cc:     Nik Bune <n2h9z4@gmail.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: da9062-wdt: convert txt to yaml
Date:   Fri,  6 Oct 2023 13:11:04 +0200
Message-Id: <20231006111104.11105-1-n2h9z4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert txt file to yaml.

Signed-off-by: Nik Bune <n2h9z4@gmail.com>
---
 .../bindings/watchdog/da9062-wdt.txt          | 34 ------------
 .../bindings/watchdog/da9062-wdt.yaml         | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
deleted file mode 100644
index 354314d854ef..000000000000
--- a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-* Dialog Semiconductor DA9062/61 Watchdog Timer
-
-Required properties:
-
-- compatible: should be one of the following valid compatible string lines:
-	"dlg,da9061-watchdog", "dlg,da9062-watchdog"
-	"dlg,da9062-watchdog"
-
-Optional properties:
-- dlg,use-sw-pm: Add this property to disable the watchdog during suspend.
-	Only use this option if you can't use the watchdog automatic suspend
-	function during a suspend (see register CONTROL_B).
-- dlg,wdt-sd: Set what happens on watchdog timeout. If this bit is set the
-	watchdog timeout triggers SHUTDOWN, if cleared the watchdog triggers
-	POWERDOWN. Can be 0 or 1. Only use this option if you want to change the
-	default chip's OTP setting for WATCHDOG_SD bit. If this property is NOT
-	set the WATCHDOG_SD bit and on timeout watchdog behavior will match the
-	chip's OTP settings.
-
-Example: DA9062
-
-	pmic0: da9062@58 {
-		watchdog {
-			compatible = "dlg,da9062-watchdog";
-		};
-	};
-
-Example: DA9061 using a fall-back compatible for the DA9062 watchdog driver
-
-	pmic0: da9061@58 {
-		watchdog {
-			compatible = "dlg,da9061-watchdog", "dlg,da9062-watchdog";
-		};
-	};
diff --git a/Documentation/devicetree/bindings/watchdog/da9062-wdt.yaml b/Documentation/devicetree/bindings/watchdog/da9062-wdt.yaml
new file mode 100644
index 000000000000..9911cc3068cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/da9062-wdt.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/da9062-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog Semiconductor DA9062/61 Watchdog Timer
+
+maintainers:
+  - Steve Twiss <stwiss.opensource@diasemi.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    enum: 
+      - dlg,da9061-watchdog
+      - dlg,da9062-watchdog
+
+  reg:
+    maxItems: 1
+
+  dlg,use-sw-pm:
+    type: boolean
+    description: >
+      Add this property to disable the watchdog during suspend.
+      Only use this option if you can't use the watchdog automatic suspend
+      function during a suspend (see register CONTROL_B).
+  
+  dlg,wdt-sd:
+    type: boolean
+    description: >
+      Set what happens on watchdog timeout. If this bit is set the
+      watchdog timeout triggers SHUTDOWN, if cleared the watchdog triggers
+      POWERDOWN. Can be 0 or 1. Only use this option if you want to change the
+      default chip's OTP setting for WATCHDOG_SD bit. If this property is NOT
+      set the WATCHDOG_SD bit and on timeout watchdog behavior will match the
+      chip's OTP settings.
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@fffffd00 {
+      compatible = "dlg,da9062-watchdog";
+      reg = <0xfffffd00 0x10>;
+    };
-- 
2.34.1

