Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C71774F64
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjHHXis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHHXir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:38:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCBA1BC3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:38:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe4f5290daso9717326e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 16:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691537924; x=1692142724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XL/aJYrmTYtFbyKt7NkdXnR+j6MZcj8vuh8kDfM55kQ=;
        b=hau5ipiOji3Z35M3o+B2EhSiT3vhSG32ps1e7SMmsFZOPWPYMqO9jUnZpillMK61tQ
         amQTRiYjKuTnkcleH4uur5wtyP2n88Ynmst49EPDYjCvnaTaWW9PG3v+rvXvK5CPmgzT
         89cJoTf8gqMxKp1+H46T2HcbVmdpl7UzvZyoIedfp0kYc+QTcSzc2abfJmJIgZPpsK2p
         lOA/dUC1nFaLhYk5Rk8LfAxjW3y4LEdc9zh/XDnHosKlRq3bUb1//NBMMOriqGpW/O1N
         +1cP8GASKQPFL9Hbc+1eDgSZd9p9zANlZbfUa+CaUOuLxf/xUa0BbrBCeoIq0dWb8tES
         Ag6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691537924; x=1692142724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL/aJYrmTYtFbyKt7NkdXnR+j6MZcj8vuh8kDfM55kQ=;
        b=X5ehzDPmPULccxiJPiEyyWkvUuNohTywXPjiWUUnN4GntqWwhcYVrBn9sv9m8uc4rG
         kDr3Wab5izYr0oh99FsDE4FakYaMiSsHByMfQNOOqzhsf4su14PGtVl8li4oYKADGU34
         vKUEx5NNtHasto7UzDqdKN46pljeyR39r4Hkgy9cqQcSh3LSnGwK4mdjhdp9HQPMUVYs
         sZJNUGcek0UVMhv1PtxJJ9UHA5H7yi/1S+i2OvlgAZHoaiikgTnwfbHTiqQochifkrB7
         eYW3jabpOaCfsJdjyLfiYRqGLAa8/gtGr6yR9c0/4nlPcwe6W9xP3sMEwlqHG6R/HynL
         zT7Q==
X-Gm-Message-State: AOJu0Yxia1iBCNT2MoNpi89kP20u4rtp1XpxPI4+Fn92jw4Ts9koaa+o
        Mx4xEWH2bPCBO6GvXhQZ6QUclg==
X-Google-Smtp-Source: AGHT+IFhDQQw1NdHeYoE74+wgUwY+C+dqGfEPmFdnSKj+Hh72wXrzzO/qs756gpW5BvUg6Is10+e3g==
X-Received: by 2002:a19:675d:0:b0:4fb:8aeb:d9be with SMTP id e29-20020a19675d000000b004fb8aebd9bemr663484lfj.30.1691537923961;
        Tue, 08 Aug 2023 16:38:43 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25598000000b004fe1d770527sm2031871lfg.309.2023.08.08.16.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 16:38:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 09 Aug 2023 01:38:28 +0200
Subject: [PATCH v10 1/2] dt-bindings: touchscreen: Add binding for Novatek
 NT36xxx ICs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-topic-nt36xxx-v10-1-dd135dfa0b5e@linaro.org>
References: <20230808-topic-nt36xxx-v10-0-dd135dfa0b5e@linaro.org>
In-Reply-To: <20230808-topic-nt36xxx-v10-0-dd135dfa0b5e@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691537921; l=2016;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=docRE+A1RRfEJ2+gebPyBMKJTscANW4TqtEvw4Sba8M=;
 b=0kDDydGb2y71toTHrMWJMtwZHfhugcjUnxMSZiFyq9UhHkWMIgTIGcbP2/qR8e2ADa/U1EoZ+
 /nrzU38MUMPBGGIrcZ8fDG0rB8ml+Ej2Y94uCGrNtuaWvrehqOaTukY
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Add binding for the Novatek NT36xxx series touchscreen ICs.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/input/touchscreen/nt36xxx.yaml        | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/nt36xxx.yaml b/Documentation/devicetree/bindings/input/touchscreen/nt36xxx.yaml
new file mode 100644
index 000000000000..d88b149602ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/nt36xxx.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/nt36xxx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT36xxx series touchscreen controller
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: novatek,nt36525-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vdd-supply:
+    description: Power supply regulator for VDD pin
+
+  vio-supply:
+    description: Power supply regulator on VDD-IO pin
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen@62 {
+        compatible = "novatek,nt36525-i2c";
+        reg = <0x62>;
+        interrupt-parent = <&tlmm>;
+        interrupts = <45 IRQ_TYPE_EDGE_RISING>;
+        reset-gpios = <&tlmm 102 GPIO_ACTIVE_HIGH>;
+      };
+    };
+
+...

-- 
2.41.0

