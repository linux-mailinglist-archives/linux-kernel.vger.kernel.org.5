Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D8D785953
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjHWN3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbjHWN3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:29:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD89E75
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so7106093a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797293; x=1693402093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8+eJTPnyETKajv3kjkJ9QGjzhmOtp44mGAz4WudHrw=;
        b=DV9faGBEGi3t/RtFOYJzqFiJa6huNAW5aKdLZkyq9G328ZQ2C0fjDWwl3/dOXB7JNF
         9Iw317V+/QN6vJNiIonowajBWaIvekxNuCqFEAY2RhWIt4d/ilj3Ic5sEW1K/Tc1WYY6
         da/LrbX7pW0ZF5457FiG8RV4sAd3L7VuTzaXFDmCzoxVkPOfIQBQA+mxUNU5cAzHi7j0
         9SGwnNcHd6ErLeMkHeqF5EH6ZvrQjqA4YiF0mrYVpwMND/RDsc+DjwxJpd5xNky6FF3O
         HqaVUKgHmt87kIDVrigyoVHihxEoa5dej1REtpGVGDNOLdefXfsCOo+/k8w7JVtlfRGX
         jOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797293; x=1693402093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8+eJTPnyETKajv3kjkJ9QGjzhmOtp44mGAz4WudHrw=;
        b=PwHGcYJqQg9BESCy1Q+VdJ2oAZnO8WNrAHVgUPD6bfHguDC8ywF87sNZlVKHG0Xc6X
         42jD7BvYiDDdWZ8k47ltoOgO+sImMKBWLvQBtJs38zZAw3EpKeDnt9Fc0hgRxdZMsblp
         bpuUssqahdtXn6OkviKBhreTvHmISju053poITA7peLS+SoUOuKEOP4OIOjRm9J6ACwx
         MHnKANTX78eVBDDGlIR4UEc/p1ToJG9yn4SY9NATWB7HaC99sWNsqUx3e9BaQaJufveH
         76Di0IwE19R08nlgceLVyMoczKlqKqlcJtGysYRLngtw1McL6a+Ed0tSFUYKhmjeGLt8
         sd7w==
X-Gm-Message-State: AOJu0YwS47z7VTE7A50C9+Qiz9L87CjK9qO8tnC0k00xf7hWmDppj6T7
        2Sr189rPyFRBgEDhoCEZkAY9HA==
X-Google-Smtp-Source: AGHT+IGcEOiJK2kPaV2ula+/PI8qLpMVgagQVY8AQGuFgQI0x2JC/DvyQv4FgUucWA0Q7FaJ+7Kwmw==
X-Received: by 2002:a17:906:1019:b0:9a1:db97:62a1 with SMTP id 25-20020a170906101900b009a1db9762a1mr1725922ejm.46.1692797293579;
        Wed, 23 Aug 2023 06:28:13 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:12 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 16/22] dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
Date:   Wed, 23 Aug 2023 14:27:38 +0100
Message-Id: <20230823132744.350618-17-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=DsqCOrq1YrBbuJPmCDCb4/fu9KoE4iOYNaHyeQKAssM=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glJKBg0O/6R2P9mKWwOqMjI1N0EUQd2GZjJi ToHHrnLduOJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJSQAKCRB6of1ZxzRV NzwuB/9Dt6mJ6dC63sWx2q0+uc4PzrnVeVK7E0TXmnY25ikDmKb+eIYfBXLNzkTie35IpJDK7Pl RBLuOomT2LyKf2HpwsyW19vM+MFy1yOM6LtKD3xMR9sYzbdtPW2FuLEqTqFcvZ++J9i4YSI0DZI Z4UWvw6Yvm9KmgpoYYwXS7LJK/mIm7rW0IU3D4vQ9YDH9wHFK56tJP9UJ9NLhEmjoiicyyWUJJZ 2lzHG+knxjcPIn6DKTbpTbqSrKc9BMvuN35ZPsXd9IxuZKhXw6E2MD0GP/2GG5+E6lWY9DHX4ZQ g+T6nJ//8ikfYQGkbuE2m0xxK7eQSomszwiBWto6CmJYxsgw
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

