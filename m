Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316107D40DE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjJWU0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjJWU0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:26:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E39D68;
        Mon, 23 Oct 2023 13:26:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so554008366b.3;
        Mon, 23 Oct 2023 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698092797; x=1698697597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A009epGh9BGNMcw+mtBy+K3MSkhtuedVQ3bAIozMsTc=;
        b=TxGEJWaUu5xb+4JhfT6VjZpY1UUjmXI6vixcYl50GzPJfyYui2usTLVRM0LjFr7hfy
         uJnIG0LevAHgkOvq7Dnpv2dQa/C5K1eIRgekqoAt84XLCxIADRtZ/VkjQxVJZZVj9Qo7
         vD9DjoCUi6tDRK7WYJgqGFXTyS1KQGfw/0x8VF9jU/2ikQzQ0QoAw/ahmzeki6gygyKi
         cQYIkBd0Ar6SEqxIQbYcT2bpyTwHl2gtV3gIEW9W+VfPgBGzXrv2pLjTPColplyd6tCq
         Xjzl4qk1p1tTMsNf8haAeEFZkfjPCJjNh9W4cVQN1wHmZkIt+adKCetmxsCuwKTCcU0Y
         8X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698092797; x=1698697597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A009epGh9BGNMcw+mtBy+K3MSkhtuedVQ3bAIozMsTc=;
        b=MMna3AH1yFjdjYXtDKQ3gnOfyoeG9yJI02KpNHiLgd3Ir871Oh4mXky6bjaapfsKJH
         h9Ob53AEJLDOIQpkCqlAzNA1/SlDt3l92QaQj5qcd3363KFXfCXvXGnCpVb28J6joYe/
         jMO5QAHyCmpdIoDxwD1W7yJfk/v6ktMoZfrfugW0ozYm1meMB3bHai5uEIieHhPNSgqE
         zYC6EECpASUtVe0ifOUcX/5W4/YbNhjbfqJsHw8r2ZB4FRFTxI8wtctyjdtl3Rw1R6Gb
         NBQDA3l3aPmZ9UwXOZ0F4dt4y+5ss9+7P0mvlAY0YF6YdQcLcIXGzcFsLWph11F1oliv
         MOrw==
X-Gm-Message-State: AOJu0YyE9vqBZkj5wLC2f664Wvqbg3xXRDg+iHEigoQ5+ZlbFbUJuLnH
        hYm2C8/CjCedCJn0UoMNEFE=
X-Google-Smtp-Source: AGHT+IE19jF6AT0z0G1sht98s/fssTiS2Znwx2H1e3VS3nh5vrSR5XtzBV3V4nmUbmQW4nyT9vXEMQ==
X-Received: by 2002:a17:907:9618:b0:9a2:139:f45d with SMTP id gb24-20020a170907961800b009a20139f45dmr7238702ejc.43.1698092797042;
        Mon, 23 Oct 2023 13:26:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3664:b198:95f4:ac2c:9085])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906088d00b0098ec690e6d7sm7113428eje.73.2023.10.23.13.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 13:26:36 -0700 (PDT)
From:   Nik Bune <n2h9z4@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        skhan@linuxfoundation.org, baruch@tkos.co.il
Cc:     Nik Bune <n2h9z4@gmail.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: watchdog: cnxt,cx92755-wdt: convert txt to yaml
Date:   Mon, 23 Oct 2023 22:26:22 +0200
Message-Id: <20231023202622.18558-1-n2h9z4@gmail.com>
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
Add maintainers list.

Signed-off-by: Nik Bune <n2h9z4@gmail.com>
---

Changes in v2 (according to review comments):
- Updated clocks property to have only maxItems without $ref and description. 
- Removed timeout-sec explicit definition, as it is defined in watchdog.yaml.

v1 patch: https://lore.kernel.org/all/20231022120328.137788-1-n2h9z4@gmail.com/

 .../bindings/watchdog/cnxt,cx92755-wdt.yaml   | 45 +++++++++++++++++++
 .../bindings/watchdog/digicolor-wdt.txt       | 25 -----------
 2 files changed, 45 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/cnxt,cx92755-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/cnxt,cx92755-wdt.yaml b/Documentation/devicetree/bindings/watchdog/cnxt,cx92755-wdt.yaml
new file mode 100644
index 000000000000..1844d7e026fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/cnxt,cx92755-wdt.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/cnxt,cx92755-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Conexant Digicolor SoCs Watchdog timer
+
+description: |
+  The watchdog functionality in Conexant Digicolor SoCs relies on the so called
+  "Agent Communication" block. This block includes the eight programmable system
+  timer counters. The first timer (called "Timer A") is the only one that can be
+  used as watchdog.
+
+allOf:
+  - $ref: watchdog.yaml#
+
+maintainers:
+  - Baruch Siach <baruch@tkos.co.il>
+
+properties:
+  compatible:
+    const: cnxt,cx92755-wdt
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@f0000fc0 {
+        compatible = "cnxt,cx92755-wdt";
+        reg = <0xf0000fc0 0x8>;
+        clocks = <&main_clk>;
+        timeout-sec = <15>;
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt b/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt
deleted file mode 100644
index a882967e17d4..000000000000
--- a/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Conexant Digicolor SoCs Watchdog timer
-
-The watchdog functionality in Conexant Digicolor SoCs relies on the so called
-"Agent Communication" block. This block includes the eight programmable system
-timer counters. The first timer (called "Timer A") is the only one that can be
-used as watchdog.
-
-Required properties:
-
-- compatible : Should be "cnxt,cx92755-wdt"
-- reg : Specifies base physical address and size of the registers
-- clocks : phandle; specifies the clock that drives the timer
-
-Optional properties:
-
-- timeout-sec : Contains the watchdog timeout in seconds
-
-Example:
-
-	watchdog@f0000fc0 {
-		compatible = "cnxt,cx92755-wdt";
-		reg = <0xf0000fc0 0x8>;
-		clocks = <&main_clk>;
-		timeout-sec = <15>;
-	};
-- 
2.34.1

