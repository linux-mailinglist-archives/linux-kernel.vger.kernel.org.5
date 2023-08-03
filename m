Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7714976E8E6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjHCM4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjHCM4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:56:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6831E1BFA;
        Thu,  3 Aug 2023 05:56:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bc512526cso136363766b.1;
        Thu, 03 Aug 2023 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691067401; x=1691672201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URREHQ1r+MSAWUHUkSxrrs5y2J4iL4+n921gyyB66cM=;
        b=XKu5o9NWoW7m4U7yG+xAbDn5ABmuj1fG0pgYD4xZYZzG+txUiv0G4L+2aK1kc3Leck
         TnRX0su/NtLDMucmylP84PDlJ4ap16wRRizKxi2ROiHjQEXQ35ZkHEjeRuoGZdmUnXmS
         SnfVeGbz10iOtsd8HtRiifhAlJUzZh4cjoKo1WL/bLIvS+jT6D2zWEYwZreHSq5LJxIu
         cP7WxrIi7oLzqUuv+FY8MDg/G4gqQgNd2AaNgBrZ+bffyCdcxV6+dXWocazSci2egi7J
         uEVDjiaWK3STdvhApwOajgUuTqX2GxD98+aR4qHKPe/j/1/TP4rvTbSfY9zw1iPr3i4V
         cbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067401; x=1691672201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URREHQ1r+MSAWUHUkSxrrs5y2J4iL4+n921gyyB66cM=;
        b=Hn43Xp9RqarEnHemBOSVKQnBnMBE0LdudypObgiP0abgn5ZVY6hWDWHjwvavXUUkqG
         MflI1dA99/o20DOACFXX3rvdWzM3lUwdLDQrpne/8eKQjIIC6b+gNM1UZ2RoUZyTj1Sb
         uP43Fd4X/uV1Xm2NECgduFerhE2uBLkqEmRtfjYN5zUyyK9Le1v94HlhbovOKcfNl/3D
         z+bhZ6tsX8k0SRDX784F4AqQpIDAjgpPHrXwokt1kAb2hLzmRJAK5AL1PQGz+7IWZEM6
         XwUJvpg3clMmTFecupA6KGgvEejPsD5+5a2OVaqEZveuefKnuOu9vwf3WgGjMxCu/9tz
         BeGg==
X-Gm-Message-State: ABy/qLZClG9UTkJt0Owi98zQ6kwH+Y8e6oXOJu8XvpOPUB0hdjs3qbSY
        86iJg5BBUhrhiDxSruCcKSM=
X-Google-Smtp-Source: APBJJlFrWUU9vzzPxPAo/SXdGKz0XYLIlcaE++tyyvcWxmQS0q6f/EfX5c+Vzb0iYUANdZMEOacoRw==
X-Received: by 2002:a17:906:24f:b0:96f:1f79:c0a6 with SMTP id 15-20020a170906024f00b0096f1f79c0a6mr8351705ejl.70.1691067400758;
        Thu, 03 Aug 2023 05:56:40 -0700 (PDT)
Received: from colla-nuc.fritz.box (host-79-26-241-62.retail.telecomitalia.it. [79.26.241.62])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090685d600b00992ed412c74sm10399376ejy.88.2023.08.03.05.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 05:56:40 -0700 (PDT)
Received: from colla-nuc.fritz.box (localhost [127.0.0.1])
        by colla-nuc.fritz.box (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 373Cud8j207736;
        Thu, 3 Aug 2023 14:56:39 +0200
Received: (from colla@localhost)
        by colla-nuc.fritz.box (8.15.2/8.15.2/Submit) id 373Cuda4207735;
        Thu, 3 Aug 2023 14:56:39 +0200
From:   Andrea Collamati <andrea.collamati@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrea Collamati <andrea.collamati@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: iio: dac: add mcp4728.yaml
Date:   Thu,  3 Aug 2023 14:56:34 +0200
Message-Id: <d93dd116cfa7f958c038c0c62993071ea48451d2.1691066050.git.andrea.collamati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1691066050.git.andrea.collamati@gmail.com>
References: <cover.1691066050.git.andrea.collamati@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for MCP4728

Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
---
 .../bindings/iio/dac/microchip,mcp4728.yaml   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
new file mode 100644
index 000000000000..99831d7f1c16
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4728.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP4728 DAC
+
+maintainers:
+  - Andrea Collamati <andrea.collamati@gmail.com>
+
+description: |
+  MCP4728 is a quad channel, 12-bit voltage output
+  Digital-to-Analog Converter with non-volatile
+  memory and I2C compatible Serial Interface.
+  https://www.microchip.com/en-us/product/mcp4728
+
+properties:
+  compatible:
+    const: microchip,mcp4728
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: |
+      Provides both power and acts as the reference supply on the MCP4728
+      when Internal Vref is not selected.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@60 {
+            compatible = "microchip,mcp4728";
+            reg = <0x60>;
+            vdd-supply = <&vdac_vdd>;
+        };
+    };
-- 
2.34.1

