Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702447F538E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjKVWoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjKVWoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:44:09 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0375D46;
        Wed, 22 Nov 2023 14:44:04 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-35b144ba935so928135ab.1;
        Wed, 22 Nov 2023 14:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693044; x=1701297844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZkFDdPjcBcVfp1fm2YjqN5xwGDpseg/uIenoFVR2Lw=;
        b=PqJ8J//CYG7OqrfMHlaU80SyQR0Ibc0VReS3lhg6YruHvxGbYjhtslfwuJZ91OAAW7
         c38ggd9RIP86rzR88t3Af2fb5ZRMqqvlqJggvgED0NgXfxdT1nwPyyikmsA66B7KGdA5
         RkqIwX12PkQSoQdIZeaBtbt346srNmwxeZJ1wW8nupgU4FzkkBoRvu4rTteofLhBPvoS
         FGzM6umGue8oiA9wOP1bz7Xk91spfJIQ5bi1lD6jzCOQiMxRa0L6OIQtCvWt+dLgAI5C
         ly2yp/WdbQnquea3M3/jt4ekbGuQrCbOurcJOin5yWMMeXnT2qkiKPb6DHeo48KvxSuk
         Z7sA==
X-Gm-Message-State: AOJu0Yw+7VuXlEsDdluAbsUWQFR9Yu+80ufpj+uq2anLvPELUqnkSaXj
        MdQFwa5Ol38garo4EItHDw==
X-Google-Smtp-Source: AGHT+IF6fTuuPgt0NRPsUDTeD8Nz/gX1NLKQZPb1BbfDD8amxSiKaZQV+46egIs8xYOWZBv4J5wfrw==
X-Received: by 2002:a05:6e02:1044:b0:35a:a534:916a with SMTP id p4-20020a056e02104400b0035aa534916amr2886625ilj.6.1700693044054;
        Wed, 22 Nov 2023 14:44:04 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id be5-20020a056e02304500b00357f979d56csm182648ilb.12.2023.11.22.14.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:44:03 -0800 (PST)
Received: (nullmailer pid 2808775 invoked by uid 1000);
        Wed, 22 Nov 2023 22:44:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: reset: qcom: drop unneeded quotes
Date:   Wed, 22 Nov 2023 15:43:52 -0700
Message-ID: <20231122224352.2808435-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unneeded quotes over simple string values to fix a soon to be
enabled yamllint warning:

  [error] string value is redundantly quoted with any quotes (quoted-strings)

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/reset/qcom,aoss-reset.yaml     | 10 +++++-----
 .../devicetree/bindings/reset/qcom,pdc-global.yaml     |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.yaml b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.yaml
index d92e2b3cc83f..24beb712b56d 100644
--- a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.yaml
@@ -18,17 +18,17 @@ properties:
     oneOf:
       - description: on SC7180 SoCs the following compatibles must be specified
         items:
-          - const: "qcom,sc7180-aoss-cc"
-          - const: "qcom,sdm845-aoss-cc"
+          - const: qcom,sc7180-aoss-cc
+          - const: qcom,sdm845-aoss-cc
 
       - description: on SC7280 SoCs the following compatibles must be specified
         items:
-          - const: "qcom,sc7280-aoss-cc"
-          - const: "qcom,sdm845-aoss-cc"
+          - const: qcom,sc7280-aoss-cc
+          - const: qcom,sdm845-aoss-cc
 
       - description: on SDM845 SoCs the following compatibles must be specified
         items:
-          - const: "qcom,sdm845-aoss-cc"
+          - const: qcom,sdm845-aoss-cc
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/reset/qcom,pdc-global.yaml b/Documentation/devicetree/bindings/reset/qcom,pdc-global.yaml
index ca5d79332189..f514363aa474 100644
--- a/Documentation/devicetree/bindings/reset/qcom,pdc-global.yaml
+++ b/Documentation/devicetree/bindings/reset/qcom,pdc-global.yaml
@@ -18,16 +18,16 @@ properties:
     oneOf:
       - description: on SC7180 SoCs the following compatibles must be specified
         items:
-          - const: "qcom,sc7180-pdc-global"
-          - const: "qcom,sdm845-pdc-global"
+          - const: qcom,sc7180-pdc-global
+          - const: qcom,sdm845-pdc-global
 
       - description: on SC7280 SoCs the following compatibles must be specified
         items:
-          - const: "qcom,sc7280-pdc-global"
+          - const: qcom,sc7280-pdc-global
 
       - description: on SDM845 SoCs the following compatibles must be specified
         items:
-          - const: "qcom,sdm845-pdc-global"
+          - const: qcom,sdm845-pdc-global
 
   reg:
     maxItems: 1
-- 
2.42.0

