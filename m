Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE2751377
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjGLWQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjGLWQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:16:45 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8670919B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:16:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so124823351fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689200203; x=1691792203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6m3CTODGn0UWM9+Rqg0ugH9A7AU7fZ4SISWuI+6Sl4=;
        b=mkLczbqbzzrRQn2RyVkNaVNj3OI3BbGW5Le6Wh/rF5Ymm5H7qzgFdrilT9YUDZIp4u
         T7TEAhVgmdaqVGZlbZKsyOqvVW9sAe84fsVZ//6lH184KsXbGmB3vNpcIn1S5HD6JRSf
         yZk354Te+JdvgZSJa1vLDLoX0sZVpuizcj5EJXGM7f1LuBeyzZu6Yc3cqWnJ4FFCWTrS
         NUNRZuRF2zvMf8sax2QkC5d9foXld9dSIX6Bg5vdyTMjTMk6uFa5pltHcaqLM4nzrSOH
         O1jPX0Lx5/E024E1+KqKBHTlgqyuEgauk9nHCtDJh9PuNqyd2nZcdsG5jD/ZIMFxsRSF
         n34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689200203; x=1691792203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6m3CTODGn0UWM9+Rqg0ugH9A7AU7fZ4SISWuI+6Sl4=;
        b=EiwaIi2Yc+TWcd6wwWDX5N36nOApbLKiVKYraLWSWa9laEQHnOoJcbetxoh59lKEDQ
         a3t60Pv5lGcO4uhnRD3BQMHprvnmguRrgayvjqtbR7guJ0nPh3W3uDB6T+eRj4rk2NR8
         aHKuvGz1wHPIivd1+GtC1KKSWK/HXhi7ANIKJRjJAI8KxIFMjnYf+UMfcAbB41TDkYau
         xP8nlFFkl065FK73sZ/AYEasQDxzJ14tAf5DrcqhSnqyJF+kofaBdoEYMRk0eeAwp9Zg
         Ajggl4f+6LC08uVSKBenUhX30pH6CNXHjXzwGRCPl4ntwU4lTZ+qI7bHAwijd0KxgS9O
         B0wA==
X-Gm-Message-State: ABy/qLaiI3Q+UM48MioFBiY/hSCy5p/5PVhdfG1uyMZ6MQUv3YJRUsRZ
        VSMV4CZfFP9zVdJb6AVwQRzx2w==
X-Google-Smtp-Source: APBJJlFe+iB0Y2THx9p8X+1eWOfB5H55LoZR90PLwjI1D6WC7kB+FxTXJq3m7CAQ90tyxbcEeWPHSA==
X-Received: by 2002:a2e:2405:0:b0:2b6:e0d3:45b5 with SMTP id k5-20020a2e2405000000b002b6e0d345b5mr18223822ljk.3.1689200202746;
        Wed, 12 Jul 2023 15:16:42 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id b19-20020a2e8953000000b002b6e00a3e19sm1177774ljk.132.2023.07.12.15.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:16:42 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 13 Jul 2023 00:16:41 +0200
Subject: [PATCH v4 1/2] dt-bindings: mtd: Add SEAMA partition bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-seama-partitions-v4-1-69e577453d40@linaro.org>
References: <20230713-seama-partitions-v4-0-69e577453d40@linaro.org>
In-Reply-To: <20230713-seama-partitions-v4-0-69e577453d40@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This types of NAND partitions appear in OpenWrt and
U-Boot.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Drop false flagged cells etc.
ChangeLog v2->v3:
- Drop reference from partitions.yaml again
- Drop select: false
- Use unevaluatedProperties
ChangeLog v1->v2:
- Fix up the binding to be childless
---
 .../devicetree/bindings/mtd/partitions/seama.yaml  | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/seama.yaml b/Documentation/devicetree/bindings/mtd/partitions/seama.yaml
new file mode 100644
index 000000000000..4c1cbf43e81a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/seama.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/seama.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Seattle Image Partitions
+
+description: The SEAttle iMAge (SEAMA) partition is a type of partition
+  used for NAND flash devices. This type of flash image is found in some
+  D-Link routers such as DIR-645, DIR-842, DIR-859, DIR-860L, DIR-885L,
+  DIR890L and DCH-M225, as well as in WD and NEC routers on the ath79
+  (MIPS), Broadcom BCM53xx, and RAMIPS platforms. This partition type
+  does not have children defined in the device tree, they need to be
+  detected by software.
+
+allOf:
+  - $ref: partition.yaml#
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+properties:
+  compatible:
+    const: seama
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            compatible = "seama";
+            reg = <0x0 0x800000>;
+            label = "firmware";
+        };
+    };

-- 
2.34.1

