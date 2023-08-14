Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC79A77BE78
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjHNQy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjHNQx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096D9E65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so6721771e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692032033; x=1692636833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8+eJTPnyETKajv3kjkJ9QGjzhmOtp44mGAz4WudHrw=;
        b=UbnaIIChKba/SW5Q0iIaePnMaItUHUiq22hCesh+zrPEAXEiJKV6c/GECfdJdp0Co0
         OeGu/nH8ky6T86yQ3WwKvVwQCJpsPGqm8cG85MgdvEoap6ifps4ERa4Xh2vdRhzwAROZ
         WwzCRfqY6flwBdcO8+8kNSNQuCv6XKGaAHs8Rl1DXEHEiUB9kAOTQqUtIcYVlvrNUr4D
         dhx6+8/U9d26tu7/ib/M+9325+nju/0tkabwzfP2yjSsdmHlLLNl9WlLzsOWL5rYR+Xh
         itcBCQKVbrEqV/vpudpMVrmXFMGM8smnGmxMM0dhyWuZIUC/LxBCK7MK9f4YrH9Edypc
         Robw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032033; x=1692636833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8+eJTPnyETKajv3kjkJ9QGjzhmOtp44mGAz4WudHrw=;
        b=JAfuFVG0KMfbuOBu65klP+8CWgIqmpBw3f4TWjK1DY1mDr99V2fs6Ji6qjBNxHq4dr
         HxXhjwGjQutQdKsF0TF/zLSE9TFg2VlNTbB2mPDLzII5ixYcl/us61826kNGNXCEC4ID
         8Z+8EabyW0fbwl+emGEHENHAM5GRV1g98sbRJaMlnT9zwMkUXXbnsaATXy2aew0WWGCM
         cAkGGC1lT29BuZNj6llNusc3zSSbyCS7uQLXFmvhO4tu8oYC3jKu6G+rcWpnjusc6m8t
         FKpOYxSJ1qeg/ZKHs4jZDInk5qt+gDj4Y1r88ichwxY4C8k3AIud4+k3E4JvXv4RNsuI
         ribw==
X-Gm-Message-State: AOJu0Yx3U/E4Afnk8odLsn7akvyq2ffl4xUM24vZ5o+XbWVoXxQPdueE
        xfIWEibWPZRwJv9BoXIhGpmljw==
X-Google-Smtp-Source: AGHT+IGxc0GzrDhqGfipgNtICmjoOuUEsQWYG95Pf7zoYm40zrvanprt5arjD5R1fmIy4vx+43LoEw==
X-Received: by 2002:a05:6512:214e:b0:4fd:f827:30b with SMTP id s14-20020a056512214e00b004fdf827030bmr6265965lfr.52.1692032033054;
        Mon, 14 Aug 2023 09:53:53 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 16/22] dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
Date:   Mon, 14 Aug 2023 17:52:46 +0100
Message-Id: <20230814165252.93422-17-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Komal Bajaj <quic_kbajaj@quicinc.com>

This patch adds bindings for secure qfprom found in QCOM SOCs.
Secure QFPROM driver is based on simple nvmem framework.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/qcom,sec-qfprom.yaml       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
new file mode 100644
index 000000000000..9b133f783d29
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/qcom,sec-qfprom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc, Secure QFPROM Efuse
+
+maintainers:
+  - Komal Bajaj <quic_kbajaj@quicinc.com>
+
+description:
+  For some of the Qualcomm SoC's, it is possible that the qfprom region is
+  protected from non-secure access. In such situations, the OS have to use
+  secure calls to read the region.
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,qdu1000-sec-qfprom
+      - const: qcom,sec-qfprom
+
+  reg:
+    items:
+      - description: The secure qfprom corrected region.
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      efuse@221c8000 {
+        compatible = "qcom,qdu1000-sec-qfprom", "qcom,sec-qfprom";
+        reg = <0 0x221c8000 0 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        multi_chan_ddr: multi-chan-ddr@12b {
+          reg = <0x12b 0x1>;
+          bits = <0 2>;
+        };
+      };
+    };
+
-- 
2.25.1

