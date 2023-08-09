Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C665A775328
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjHIGtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjHIGtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:49:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C65710CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:49:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686f6231bdeso1720613b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1691563761; x=1692168561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSxoEalAGdQsMgkyXr+DBsCCZtt194NCGpkdEPIQdF4=;
        b=nzhGTILkJT5+l8QPeo91E6wC247yyfMld38UGw/7ItmMbacPjCes0j5i1bE/L7jofs
         +WD/bH/wcAUypfTxOSUh4bl8wj9mZ283jiwtwSyf6rh5zvhhXN8su+S6uIKj315rvwGs
         2o6S4RZRPmsvNck4X0t1l73meTlydyDPHKDf4/ZQZl1yyo6T4D36Vf5lXtUCy4dLSvg0
         124N8h03j/jEI2RwHEAsns4Lsu7gsJyrfjNHmUgNkbQ3NS/axqIl4zD5kewlfGxOZcEn
         HrsBB48w+JckTAVkfZSSRUXRoVoP+7bTe1DGk1EHEcYRuy3vuQ4atP0Res2QyYojVjNG
         Dopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563761; x=1692168561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSxoEalAGdQsMgkyXr+DBsCCZtt194NCGpkdEPIQdF4=;
        b=erHTXf9Ie1R9HRoKCxuPxbVLCxIXZ/j9Trcg8ouQAjTkGEUOH4LNZQDk36Ulu3zy9r
         AUCrejBqEeIvyGDIMfBZz2EriHTAtOAfZ6MkShF1XnD8tAo86q+FwbCE3EpnQE5CwKKZ
         ztoboCaDqLNQC+LONUY760/WJHj5/gLTj5Avhscdbs4hVy7xVfCDDWt+TOi67J5GLe8W
         ahSZQYjQBU/Ek3WV2mxinYdmuPSFAvPP/5Cq0EMMs6Bgcmb5tE1BoIJwmWcICecnGIEy
         L3sHM/kjdcOIiY3KeGfpt1/yvhFkTx0sCE1E0uW0vVYu+ua3r+eIjvn48BqsRMly/W/v
         VH8w==
X-Gm-Message-State: AOJu0YzmH3vAhYmMdnUV6WfUxOL/dXyVm1Q4ONRpFPTTkozLcgGcgGNp
        Sn8Kmq2VTRzxEy5sPwFf1LpHDkoSVWPK/Pl0UDMQWQ==
X-Google-Smtp-Source: AGHT+IGI5A4pjVSCy2uK7iAMDeJrl/FEiuYDpouwWf3ZO5OIbt/6HgAQQMdWwpkeSY16eZs2rOx2tA==
X-Received: by 2002:a05:6a00:d82:b0:677:3439:874a with SMTP id bf2-20020a056a000d8200b006773439874amr1919581pfb.3.1691563760719;
        Tue, 08 Aug 2023 23:49:20 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id u6-20020a62ed06000000b006833bcc95b0sm9184161pfh.115.2023.08.08.23.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 23:49:20 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: arm: qcom: add sc7180-lazor board bindings
Date:   Wed,  9 Aug 2023 14:49:06 +0800
Message-Id: <20230809144516.v3.1.I7a950de49ec24b957e90d7fe7abd5f2f5f2e24c3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809064908.193739-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20230809064908.193739-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce more sc7180-lazor sku and board version configuration,
add no-eSIM SKU 10 for Lazor, no-eSIM SKU 15 and 18 for Limozeen,
add new board version 10 for audio codec ALC5682i-VS.

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
---

Changes in v3:
- correct corresponding of new board and new sku

Changes in v2:
- add new entry rev9 with Parade bridge chip
- correct newly create dts files

 .../devicetree/bindings/arm/qcom.yaml         | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 450f616774e0..3da04223b03f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -470,6 +470,11 @@ properties:
           - const: google,lazor-rev8
           - const: qcom,sc7180
 
+      - description: Acer Chromebook Spin 513 (rev9)
+        items:
+          - const: google,lazor-rev9
+          - const: qcom,sc7180
+
       - description: Acer Chromebook Spin 513 (newest rev)
         items:
           - const: google,lazor
@@ -491,6 +496,11 @@ properties:
           - const: google,lazor-rev8-sku2
           - const: qcom,sc7180
 
+      - description: Acer Chromebook Spin 513 with KB Backlight (rev9)
+        items:
+          - const: google,lazor-rev9-sku2
+          - const: qcom,sc7180
+
       - description: Acer Chromebook Spin 513 with KB Backlight (newest rev)
         items:
           - const: google,lazor-sku2
@@ -512,9 +522,16 @@ properties:
           - const: google,lazor-rev8-sku0
           - const: qcom,sc7180
 
+      - description: Acer Chromebook Spin 513 with LTE (rev9)
+        items:
+          - const: google,lazor-rev9-sku0
+          - const: google,lazor-rev9-sku10
+          - const: qcom,sc7180
+
       - description: Acer Chromebook Spin 513 with LTE (newest rev)
         items:
           - const: google,lazor-sku0
+          - const: google,lazor-sku10
           - const: qcom,sc7180
 
       - description: Acer Chromebook 511 (rev4 - rev8)
@@ -526,9 +543,16 @@ properties:
           - const: google,lazor-rev8-sku4
           - const: qcom,sc7180
 
+      - description: Acer Chromebook 511 (rev9)
+        items:
+          - const: google,lazor-rev9-sku4
+          - const: google,lazor-rev9-sku15
+          - const: qcom,sc7180
+
       - description: Acer Chromebook 511 (newest rev)
         items:
           - const: google,lazor-sku4
+          - const: google,lazor-sku15
           - const: qcom,sc7180
 
       - description: Acer Chromebook 511 without Touchscreen (rev4)
@@ -545,9 +569,16 @@ properties:
           - const: google,lazor-rev8-sku6
           - const: qcom,sc7180
 
+      - description: Acer Chromebook 511 without Touchscreen (rev9)
+        items:
+          - const: google,lazor-rev9-sku6
+          - const: google,lazor-rev9-sku18
+          - const: qcom,sc7180
+
       - description: Acer Chromebook 511 without Touchscreen (newest rev)
         items:
           - const: google,lazor-sku6
+          - const: google,lazor-sku18
           - const: qcom,sc7180
 
       - description: Google Mrbland with AUO panel (rev0)
-- 
2.34.1

