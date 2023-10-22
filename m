Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8817D21FD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjJVIzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 04:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVIzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 04:55:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A046FE8;
        Sun, 22 Oct 2023 01:55:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32daeed7771so1546253f8f.3;
        Sun, 22 Oct 2023 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697964919; x=1698569719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ssc4QYYiYfFrGCEeMacSQXcB+utJ/7KMp+ed9vgKRQ=;
        b=OZhyM/+4Gfu/BeaLZmh8MeQBTAkMqKT0JCUhLu6QNj9KhmA8rxz5gxZ8/a6ayAeloA
         YeKrxNIB/4TRSW0Xu+5uJUsgAbjVSqZtG121Dp/ZVd/UvjkZwH/2uUuSmtB4jnoyhlKX
         5LfebfPSaU7B63sAYjPrda1OSfMoeD16I2wj2sBcP1wk/eGzBT7KRjKbPwl6wk8dpBCk
         3/TP+CB6Xyw70ZP4ypMNVj1NlgK7IZ6Ef76k7FCYloxQy7uF+CCZkZLG0yhKQyAiEYNE
         3ww6RSF1FYXNk2wpb0l87wLRl1CwuQT26boIJWJEkoNBdTiTexxt+D0sv2A7lXFDdk/q
         6Vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697964919; x=1698569719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ssc4QYYiYfFrGCEeMacSQXcB+utJ/7KMp+ed9vgKRQ=;
        b=f2/LV8J8M3VGI0FnI7vuKkBkz9V0XJQCTDR+u1QOqpyzdhkSse6C0+iMjNfTmZ81Vg
         zkV4Dubi6I7KZJG+wOKPpCBLj1JxfbCGRoBPZVboSd26eOF8aOgp8Erd9IgUo/hnykeG
         AUd0lHWKNuotc9eoYfdltuBU0rhMo2n4UwmvScoRAKvmXbCnk0caMTnISISqEACzeVG+
         RN0dG2BvkJ8pJWseARCIoP7mFY8yYrMD80Kw0fATl6ONXRz0A6izwutPiZ60FhoL/VFo
         p3+RmScAzU3Ie9A5cegMhELsW2z98Z4MXZtTxpe4+4tk3G3cCj9rVvcqTfwNAjUm7cz4
         EjdQ==
X-Gm-Message-State: AOJu0Yw9sM/nK87fCLuMwBQYNH3vZHImSFtgwcdegiBRbwWFYOt7CpRk
        4sH/AaJhoBCXk38gKU+lbtaSGqfX0tw=
X-Google-Smtp-Source: AGHT+IFJ5J9DPyKj/lg2BW5Op5YdPB5iS1osFfI0ZCJ8QcyfzJaNAz5SzBucP3sfMsHKdI3wFazJwQ==
X-Received: by 2002:a5d:6408:0:b0:32d:9572:6469 with SMTP id z8-20020a5d6408000000b0032d95726469mr4387064wru.46.1697964918515;
        Sun, 22 Oct 2023 01:55:18 -0700 (PDT)
Received: from localhost.localdomain (141.red-88-10-53.dynamicip.rima-tde.net. [88.10.53.141])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d6843000000b003143c9beeaesm5245871wrw.44.2023.10.22.01.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 01:55:17 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2] dt-bindings: timer: add Ralink SoCs system tick counter
Date:   Sun, 22 Oct 2023 10:55:18 +0200
Message-Id: <20231022085518.792100-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML doc for the system tick counter which is present on Ralink SoCs.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
Changes in v2:
- Add Rob's Reviewed-by tag.

v1: https://lore.kernel.org/lkml/CAMhs-H_9kAdOfR-RaJWqAq6d3S3DXtKJqWy-EWCu0-ZjWKB9Sw@mail.gmail.com/T/#re9225265416ca8463c5f06d736f9834ae75efe0c

I am sending this with Rob's RB added since I ping for the v1 multiple
times without response. So I can be missing something or the patch is
lost for any reason. Thanks!

 .../bindings/timer/ralink,cevt-systick.yaml   | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml

diff --git a/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
new file mode 100644
index 000000000000..59d97feddf4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/ralink,cevt-systick.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: System tick counter present in Ralink family SoCs
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+properties:
+  compatible:
+    const: ralink,cevt-systick
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
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    systick@d00 {
+        compatible = "ralink,cevt-systick";
+        reg = <0xd00 0x10>;
+
+        interrupt-parent = <&cpuintc>;
+        interrupts = <7>;
+    };
+...
-- 
2.25.1

