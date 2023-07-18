Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB00E7581AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjGRQHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjGRQHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:07:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7E0FD;
        Tue, 18 Jul 2023 09:07:00 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so9567078e87.3;
        Tue, 18 Jul 2023 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689696419; x=1692288419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YeCwq3NAvGKoLBdtM+ZqWilWIkfGP+nzxQkw03W43jw=;
        b=py923FTwOMCDnC8JmqUXd3moipT/chxFwEuQOS01u03mcDZH+qM63VBPcE6kTHeR+e
         Zbw6ldttWJTYJnoRJWtbN76grxXk9zv8FoV3CTN498ENNbKkdzg1485yC300ux/X0m0h
         m3ChdyXUdR4UJeV7O/ZwT2sTeyNjvi02FIFhp8ipq2hyJPaKU9Ryx9OoBkXJ6trsCGwP
         57kOg+608pEaaCZ6o4E1yBJYaLmUvuscPCnkwQs+SEPWZAfhr6UxUa1qVGKm4IblM9ol
         ttJyO6vUDGl8ZPoveKyRKqEhf2+LGMohTbBrECAiHfwLqrzyzzQeiaB73PzlyXeIrhrN
         OGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689696419; x=1692288419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YeCwq3NAvGKoLBdtM+ZqWilWIkfGP+nzxQkw03W43jw=;
        b=QIGJnGL6NVFj38Im9HMvkLFY0EGe/NEWUZexKyCzBTRuecgy9YJIITdIbg+siV275o
         fQD4qct/WU4eq05mRWHtxFFeG7IKq5AM9HsYMFJlIznkgBW3lRttijrTMu5fKPD+8OWb
         RWVoVJ5yx94B2c4p/HQJzGJBwgWyHIL4kI+ELE4q2hI+g5o01R9uRQ40LDA4RHO6K5oE
         RJn8GKY7vYTedIVbeCeXBIpVV0sKN9l2smx9uecI85jjtVFMS5Hv6W2ysACcUGLxbW/N
         adQQytqW6jRAhIakqsgIbvnK1dP24dQ3zOcFDR6k9LdYCFnVzsz3/s/gOzAtV6yD1Imp
         4D2A==
X-Gm-Message-State: ABy/qLbeEJZk0yKKyGg4+ra8WZVGtWz16ha4/tPeM5WlWjzsLyffvFom
        FSD7wN2esy/T9wIbX1AsTyg=
X-Google-Smtp-Source: APBJJlGwZIxXAsQCBhJaH60JYKMhPq73Lnu4wRDlLMiwDgHkggowOkoPweRz7w2RTlM4XaD52WJJbw==
X-Received: by 2002:a05:6512:1ca:b0:4f8:70f8:d424 with SMTP id f10-20020a05651201ca00b004f870f8d424mr10354189lfp.65.1689696418378;
        Tue, 18 Jul 2023 09:06:58 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id t14-20020ac24c0e000000b004f86aef886asm502295lfq.54.2023.07.18.09.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 09:06:58 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/3] dt-bindings: nvmem: convert U-Boot env to NVMEM layout
Date:   Tue, 18 Jul 2023 18:06:50 +0200
Message-Id: <20230718160652.26756-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

Use "nvmem-layout" and drop unused "mac" label while at it.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/nvmem/layouts/nvmem-layout.yaml    |  1 +
 .../nvmem/{ => layouts}/u-boot,env.yaml         | 17 +++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)
 rename Documentation/devicetree/bindings/nvmem/{ => layouts}/u-boot,env.yaml (87%)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
index 3b40f7880774..382507060651 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -21,6 +21,7 @@ oneOf:
   - $ref: fixed-layout.yaml
   - $ref: kontron,sl28-vpd.yaml
   - $ref: onie,tlv-layout.yaml
+  - $ref: u-boot,env.yaml
 
 properties:
   compatible: true
diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
similarity index 87%
rename from Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
rename to Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
index 36d97fb87865..ebe3b71ba155 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
+$id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: U-Boot environment variables
@@ -72,11 +72,14 @@ examples:
         };
 
         env: partition@40000 {
-            compatible = "u-boot,env";
             reg = <0x40000 0x10000>;
 
-            mac: ethaddr {
-                #nvmem-cell-cells = <1>;
+            nvmem-layout {
+                compatible = "u-boot,env";
+
+                ethaddr {
+                    #nvmem-cell-cells = <1>;
+                };
             };
         };
     };
@@ -92,9 +95,11 @@ examples:
             label = "u-boot";
 
             partition-u-boot-env {
-                compatible = "brcm,env";
+                nvmem-layout {
+                    compatible = "brcm,env";
 
-                ethaddr {
+                    ethaddr {
+                    };
                 };
             };
         };
-- 
2.35.3

