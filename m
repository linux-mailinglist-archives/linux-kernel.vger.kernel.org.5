Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233DC7A1F11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjIOMpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbjIOMp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:45:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190CF1A5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:45:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-502a4f33440so3397166e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694781921; x=1695386721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQKsjBFvt2/0L/1F7kjkJsmdL2N5EGcnErgcVOrwWbM=;
        b=SWLpz0NEfdsCLZKHQGhBETJNn8s6/HVA2gwabwLRnnGI5BthHRMTcRYIfXytemfFSD
         f45EIu1IClP5oKV2BbVJBUxmP43yFYM5Ku204ZoZH5Q1mDzNbYjTL0l7CSea0U5axxar
         2+am1ZbkAZB7G4muxYmxqbWgfAhJ13QuK21Vq48EIdC5GelExGqqPspCJsod2DpSBexL
         xHK5/xnZCNf+Y8yAybnKPXEKrT7WnwiH6La1CEDflke/swMPvzi6A8WPC64iWDYY7bwv
         YCRm1OhVKf1FkyIRGPCPJeNYNfIaWi/BoHAWXaAtmed41oqZ2kZsaexCWxOVvZD0cU4E
         Xuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694781921; x=1695386721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQKsjBFvt2/0L/1F7kjkJsmdL2N5EGcnErgcVOrwWbM=;
        b=s1wimHtt5lJ4YESSnOtz0o7J2JI38YH5CH+MqiRhSNh5t6SEkUWYmTBwk0ZhDWCVqE
         M6RJtwY9Whnui1Xi/WrB8Syo8k8kryTBV03d3MwKFV0FWGvrMTN9j5Lv5ZK2vJaUgT9J
         DueP66HsYRNddJpmPCqeFCqwbjvZYouW7beo07YunUVaeU4b5FA4wcjrifQS41T9y1G9
         pH7N6IMS7PPlaOcJqVeEd8S3+2n31IJ28TeaKnSB73gvJ1NS4BZLXmNFmWNRCesjx0tJ
         o9e9uPV8JhrKf3WrbaTk+YLJPtYtloq9WPOQ4lXFF1qdsuIdLjOLP2NN+hoUwTeDYdtN
         IEfQ==
X-Gm-Message-State: AOJu0Yz5x5XFIz9J15N9Ya1ObAU1zlNzVn/Fi+tVXXvb9P2hnomAI90J
        I9TY1FF8oPVNPKSd6paCILCM6w==
X-Google-Smtp-Source: AGHT+IEQc4h1ngKE2+VA6YGviDJVkrNplYwGZNRKiahgxgti51+UhFggRbJP8P7qeLRwC3QRRySPjA==
X-Received: by 2002:a19:6714:0:b0:4fd:faf0:6591 with SMTP id b20-20020a196714000000b004fdfaf06591mr1278486lfc.10.1694781921357;
        Fri, 15 Sep 2023 05:45:21 -0700 (PDT)
Received: from [10.167.154.1] ([2a00:f41:cbe:bc7d:62a6:5d09:5ba7:be5b])
        by smtp.gmail.com with ESMTPSA id f19-20020ac25333000000b004fe37199b87sm624752lfh.156.2023.09.15.05.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:45:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 15 Sep 2023 14:45:16 +0200
Subject: [PATCH v4 2/3] dt-bindings: power: supply: Document Mitsumi MM8013
 fuel gauge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-mm8013-v4-2-975aecd173ed@linaro.org>
References: <20230621-topic-mm8013-v4-0-975aecd173ed@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v4-0-975aecd173ed@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694781917; l=1502;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+uF0adwPQhjp9KC+P9UNR+pGm2F9OFhDZ4dy2nzuHuQ=;
 b=U5pry/nVMjoyOMh1xT2s8aR7A29Z8jFXV0S9o4qwUXQLL9gZW3+Ak2PhyqkWAUp0nNrxlytTv
 FGPps522HLrClcXhb2NAq+JYAZyH6NCq/za/WFoQxqrpWJBooJ1RxlY
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mitsumi MM8013 is an I2C fuel gauge for Li-Ion cells. The partial
datasheet is available at [1]. Add bindings for this chip.

[1] https://www.mitsumi.co.jp/latest-M/Catalog/pdf/battery_mm_8013_e.pdf

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/power/supply/mitsumi,mm8013.yaml      | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml b/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
new file mode 100644
index 000000000000..6865640cbdfa
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/mitsumi,mm8013.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mitsumi MM8013 fuel gauge
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: mitsumi,mm8013
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
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@55 {
+        compatible = "mitsumi,mm8013";
+        reg = <0x55>;
+      };
+    };

-- 
2.42.0

