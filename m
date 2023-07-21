Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB24275C870
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjGUNy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjGUNyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:54:24 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC522D46
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:54:21 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so29195541fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689947660; x=1690552460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yB40CTk1VoTOsNL9APWuoijg9dwI6heid/caMKUcao=;
        b=aAP8VECYu92wrobOqBpBNpmIFUNvAR/nfnMU/88jDpJKWa3Ww5LXfd5ktC0tPSLrGW
         iMumOseowq/MGRZQx9mJyhhWn7qKvT4o5uuOyNpANEvqDvdOVny4KFMyIL3qgMicm0LL
         5NooRLEEvvVvCJVVdYj/V8JxEiS4HGfWuRlNp2dAs8Qve3UFUVtwTiarrn0N1I2xJbHq
         o2LFoSX1oj62yCRG2ebJuoNnwvQ2LI/YL00gv41F447gUBjdsO8NDiTJYA/0Ooev9LZH
         A5Ny9yPdK9ZZhpAHsLD7HKn3DI5p7EGikeRIr4YOPeCmBv+60AaSAGBZqAPjgxPqmKNT
         0+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947660; x=1690552460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yB40CTk1VoTOsNL9APWuoijg9dwI6heid/caMKUcao=;
        b=R5nXlek248GKAAi2zvtJ0wz2g0Jzrnfs10b1ZjCgx7jnSqUQ7AynmhJmcEseU1JR1m
         LyP2g2kx2BfEKr/cumMWmcSLCnTn4Nn+QzVZiRcKWz8HBerkZB4J5AECYKWNQSZwra6b
         jTNSGZID9RC1v4R2fR0V7LvyckfutNXiOLt/NyiJ2+cL3pa6HyJsgfhEKI1kWaYt4+Ik
         gxik0e0W1NbVYVLchbWsYL6aY6RDgD0o7s0a+hc8p+Tt6vKrl0mk+vrgHer+0Xb/qV7Q
         LJZg3Phk2F/9U2/mFCKTfbmKJHlqYTW4NRY4VYIzmHAERPtRg0hp34xaL/48zBDqABff
         ZZ3A==
X-Gm-Message-State: ABy/qLY4NT+YcOJT+FjrNxmUMTj1Szz1wkXlaj9cpXCZHlrKk6tSRnBn
        QO7CNcga5HT6ApLbk590iJMgCw==
X-Google-Smtp-Source: APBJJlGvkGZ/eyJkBvEou8GLjCQESQdZgHtDY77OX6Fy01FgYk9HeTVo069nE1Cr0QUryqUXJy+HUw==
X-Received: by 2002:a2e:900e:0:b0:2b7:2066:10e1 with SMTP id h14-20020a2e900e000000b002b7206610e1mr1637876ljg.0.1689947659814;
        Fri, 21 Jul 2023 06:54:19 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id k21-20020a2e92d5000000b002b6ad323248sm953838ljh.10.2023.07.21.06.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:54:19 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Jul 2023 15:54:11 +0200
Subject: [PATCH 1/7] dt-bindings: interconnect: qcom: Introduce
 qcom,rpm-common
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-icc_bindings-v1-1-93e2bc728fb7@linaro.org>
References: <20230721-topic-icc_bindings-v1-0-93e2bc728fb7@linaro.org>
In-Reply-To: <20230721-topic-icc_bindings-v1-0-93e2bc728fb7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689947656; l=2578;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=nt1uBTOFn8HFHfToq9UbMDlyE9rJBF2MRr2jYaL8rVE=;
 b=YW5UEXDZFzVDW25hRSpv9KuzN4kQ6FywinJcWBIdsWF5IvuCOboqsdl/8XMI/+GjWYLlm0Mmy
 qZAGcUsX4SdDsL7ibPIbgcCmmrFR5U2B6zjPbzNTw1kqEuo1FOBAhM0
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current RPM interconnect bindings are messy. Start cleaning them
up with a common include.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interconnect/qcom,qcm2290.yaml        | 12 +++------
 .../bindings/interconnect/qcom,rpm-common.yaml     | 31 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
index f65a2fe846de..edee78c456b7 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
@@ -13,19 +13,16 @@ description: |
   The Qualcomm QCM2290 interconnect providers support adjusting the
   bandwidth requirements between the various NoC fabrics.
 
-properties:
-  reg:
-    maxItems: 1
+allOf:
+  - $ref: qcom,rpm-common.yaml#
 
+properties:
   compatible:
     enum:
       - qcom,qcm2290-bimc
       - qcom,qcm2290-cnoc
       - qcom,qcm2290-snoc
 
-  '#interconnect-cells':
-    const: 1
-
   clock-names:
     items:
       - const: bus
@@ -75,11 +72,10 @@ patternProperties:
 required:
   - compatible
   - reg
-  - '#interconnect-cells'
   - clock-names
   - clocks
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml
new file mode 100644
index 000000000000..87995b40a856
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,rpm-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description:
+  RPM interconnect providers support for managing system bandwidth requirements
+  through manual requests based on either predefined values or as indicated by
+  the bus monitor hardware. Each provider node represents a NoC bus master,
+  driven by a dedicated clock source.
+
+properties:
+  reg:
+    maxItems: 1
+
+  '#interconnect-cells':
+    oneOf:
+      - const: 2
+      - const: 1
+        deprecated: true
+
+required:
+  - '#interconnect-cells'
+
+additionalProperties: true

-- 
2.41.0

