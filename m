Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CFF7939B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbjIFKXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjIFKXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:23:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C9E10C7;
        Wed,  6 Sep 2023 03:23:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c93638322so165423066b.1;
        Wed, 06 Sep 2023 03:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693995794; x=1694600594; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZWBPxhVCOsxoJcgbv+qtk7+SgbhMxfWQyvWdVO7bh8=;
        b=FFK76u+uQ0nQc67Jn821N38zlxT1DSLVN1jNtWzATH5zFUjBqaqL4oqj2m7svhhf/h
         +XhY+vf2iZtLtF4njm6b0cF7x5YNW7/6q0PTjJleSE9hKBizLGq6WecmCVSGWydqzjCV
         CgHc1tvESSKXZkRmzHdJa5EF1twAWALswVx3ckDbCRBIMvR/gSTpa9QQw01GiW+eBvij
         Natjl6WAkHgNrR0l5aXsHXXPx9FC5ldI7iHPgAuJZSYT8OgkbRVBBU/uGLUEeiefk8SW
         IisP2qUmbZTmg+oLTLhKIQBghSqZYRDsbzmzdvdE0gKoWTME1tK7uKmvIrHSOw5cWdq6
         7umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995794; x=1694600594;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZWBPxhVCOsxoJcgbv+qtk7+SgbhMxfWQyvWdVO7bh8=;
        b=PnPpwdV+kbuyct7R3UKnnngpFouu8A+hq+7Ziw+luKQXr7bstTNN3sdhbTkwpUNteJ
         owqfEWHSnj7jB/XO3P8XB41viv8DarkzsC3y/SYL1zrCSbtsaoNluaKJ7JqiB2BEtKFb
         zDaHyRITQlO8Ubs4LyKxZDX3PKS2t+hODZ/Fyqo0bqGUa/mGWFIRMLo4txReJaNHwU2l
         Vj9W+2Gtt/W31OQLcxk+yoF53bvTM/AfHyRLIMPrnTfw2u6lltbbH655q1NO4d+lcLiu
         NGV+9CSz1+5mjj2kJ4lwDjK9ei0QYj0ZrxEDcpxHy0a1+UzaU9esWgSdZ69uBefx6BTp
         nr6w==
X-Gm-Message-State: AOJu0YylVwvoRtRRHxYSZr6oaUJd7t3w3Cw9ejRZgrpEI/7W17PeFeL+
        ZJvRKDthqfZofacvQY+1oB4=
X-Google-Smtp-Source: AGHT+IFx0mC4Xbco4rlZ7XByuON+00iGUoAFXkzjRIL77gf564Gt1kOErv2MaeY+irDmq6jBu+D8QQ==
X-Received: by 2002:a17:906:3003:b0:9a1:eb4f:56f with SMTP id 3-20020a170906300300b009a1eb4f056fmr2743807ejz.13.1693995794050;
        Wed, 06 Sep 2023 03:23:14 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id ti10-20020a170907c20a00b0099ba3438554sm8796283ejc.191.2023.09.06.03.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:23:13 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 06 Sep 2023 12:23:10 +0200
Subject: [PATCH] dt-bindings: rtc: mcp795: convert to YAML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-topic-rtc_mcp795_yaml-v1-1-de75c377b5b0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAA1T+GQC/x2N0QrCMAwAf2Xk2UA7mVp/RWR0aXSBrivplI2xf
 7f4eAfH7VBYhQvcmx2Uv1JkThXsqQEafXozSqgMrWnPxpkLLnMWQl2onyhfXddvfoporelu7Fw
 IPkBtB18YB/WJxlqnT4xVZuWXrP/Z43kcP0Wwq0V8AAAA
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Bartczak <emilbart@gmail.com>,
        Josef Gajdusek <atx@atx.name>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693995793; l=2042;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=9ko05aqIIjfOvWPhUwKxVzx6c+panpqNTxCBtlFb5Gk=;
 b=J9Wm3ocyg3hoVNa3uW/4O8NAfho6vm2xY+gQvzrtb6GtRwp3AIFLZu6giQZBKeWbBJz4yQKrG
 7ssnUC5FlFTDj4cm5s7XYkCoe3vhggCG9XTVRQYj/E9N8qnZcXaUWPu
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MCP795 bindings from text to YAML format to support bindings
validation.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
YAML is the preferred format for dt-bindings, which allows validation.
---
 .../devicetree/bindings/rtc/maxim,mcp795.txt       | 11 -------
 .../devicetree/bindings/rtc/maxim,mcp795.yaml      | 35 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt b/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
deleted file mode 100644
index a59fdd8c236d..000000000000
--- a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-* Maxim MCP795		SPI Serial Real-Time Clock
-
-Required properties:
-- compatible: Should contain "maxim,mcp795".
-- reg: SPI address for chip
-
-Example:
-	mcp795: rtc@0 {
-		compatible = "maxim,mcp795";
-		reg = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/maxim,mcp795.yaml b/Documentation/devicetree/bindings/rtc/maxim,mcp795.yaml
new file mode 100644
index 000000000000..77e465747d43
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/maxim,mcp795.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/maxim,mcp795.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MCP795 SPI Serial Real Time Clock
+
+allOf:
+  - $ref: rtc.yaml#
+
+maintainers:
+  - Josef Gajdusek <atx@atx.name>
+
+properties:
+  compatible:
+    enum:
+      - maxim,mcp795
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
+    rtc@0 {
+        compatible = "maxim,mcp795";
+        reg = <0>;
+    };
+...

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230906-topic-rtc_mcp795_yaml-11058e99ddad

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

