Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB9876FDF0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjHDJ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjHDJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:58:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3588F46AB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:58:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686f74a8992so343366b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1691143127; x=1691747927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cD6ITsXeVuEg9+MIVpUVcL3DXiDOTFej6WZmWLdSgHM=;
        b=1L4nCuBre4Xm7R36jxYqS9XfkV2yQfMYQigBZ03KeJmkJiOENba0cB7W7S1oSYbnaV
         EtcjblXX8WY9wTjNRDpFQF4qSInPoNzyBwwX4BBZYiqX6AQiSss3U/XMtrM8OsH8gI6H
         pIOGN6HKLMcwDPpQ52N2dEmiOaSYp7b/ba3+qx/bt6mAeQV34bOISjU2Epc8eTKHE/n9
         zHhvkkGJmBWXSYxOJUGidiQhspLALs93ZhmDsWMPWsqb60JN/PonpCREVlTm/Jy7sgNM
         6ZvOov6Xux7FBzhxI8ocsyI6YVb2A63vvGG0zlNgR5piuXJ/IOCBbOlt2H3gpLd01fV7
         3uTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143127; x=1691747927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cD6ITsXeVuEg9+MIVpUVcL3DXiDOTFej6WZmWLdSgHM=;
        b=OtNipXDrNw1oTBV7QwpFzv50NetI12jtlipFHJarVRDtNbx34/cWp9MyvMnf/gkwIM
         uz2BsE/Ytk7jpABrL5q+nzmp6ns7boCnvmV/H/0bDPjM2qoHD9Vwlu4qZPgQgj0qOe8I
         ogh96jtWtHPEk6/YPf91QqVxAn4jH/eKyHvq/orExz/76XGx23MlU9B8KsF8iP4PCQBI
         tfG55jIwtMXnqsbe/+8Dw/bAWylUXKsXWcGAzG/p6C+S0YTMtcPIFvESYBvpO4rYWL2t
         hlJNYwmNsz+FvdKCZIVbnAsJJUky0b/vW3uKhpXmo0SEmTBoYRw4scp/82AofjN6JBY4
         n/vA==
X-Gm-Message-State: ABy/qLafnfhRlwXsOSgAE/I7syQkFdZ6+/p+/hzynex46OgSHLh/XdHz
        wf06Bwqyum+vn6iNypQdd4Ugz4D1ixyHKxNTp5623g==
X-Google-Smtp-Source: APBJJlGeCPBAgCYNRHWxBPvfSNZ141tkkZTOVMFQ/knB1Jfu1GNfS1uj4Q3KixxrVdn+v7KYdHaRzw==
X-Received: by 2002:a05:6a00:419a:b0:67d:308b:97ef with SMTP id ca26-20020a056a00419a00b0067d308b97efmr21324447pfb.2.1691143127489;
        Fri, 04 Aug 2023 02:58:47 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id i2-20020aa787c2000000b0067b643b814csm1259949pfo.6.2023.08.04.02.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 02:58:47 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: arm: qcom: add sc7180-lazor board bindings
Date:   Fri,  4 Aug 2023 17:58:34 +0800
Message-Id: <20230804175734.v2.1.I7a950de49ec24b957e90d7fe7abd5f2f5f2e24c3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

Changes in v2:
- add new entry rev9 with Parade bridge chip

 .../devicetree/bindings/arm/qcom.yaml         | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 450f616774e0..dce7b771a280 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -470,6 +470,11 @@ properties:
           - const: google,lazor-rev8
           - const: qcom,sc7180
 
+      - description: Acer Chromebook Spin 513 Parade bridge chip (rev9)
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
 
+      - description: Acer Chromebook Spin 513 Parade bridge chip with KB Backlight (rev9)
+        items:
+          - const: google,lazor-rev9-sku2
+          - const: qcom,sc7180
+
       - description: Acer Chromebook Spin 513 with KB Backlight (newest rev)
         items:
           - const: google,lazor-sku2
@@ -512,11 +522,26 @@ properties:
           - const: google,lazor-rev8-sku0
           - const: qcom,sc7180
 
+      - description: Acer Chromebook Spin 513 Parade bridge chip with LTE (rev9)
+        items:
+          - const: google,lazor-rev9-sku0
+          - const: qcom,sc7180
+
       - description: Acer Chromebook Spin 513 with LTE (newest rev)
         items:
           - const: google,lazor-sku0
           - const: qcom,sc7180
 
+      - description: Acer Chromebook Spin 513 Parade bridge chip with LTE no-esim (rev9)
+        items:
+          - const: google,lazor-rev9-sku10
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with LTE no-esim (newest rev)
+        items:
+          - const: google,lazor-sku10
+          - const: qcom,sc7180
+
       - description: Acer Chromebook 511 (rev4 - rev8)
         items:
           - const: google,lazor-rev4-sku4
@@ -526,6 +551,11 @@ properties:
           - const: google,lazor-rev8-sku4
           - const: qcom,sc7180
 
+      - description: Acer Chromebook 511 Parade bridge chip (rev9)
+        items:
+          - const: google,lazor-rev9-sku4
+          - const: qcom,sc7180
+
       - description: Acer Chromebook 511 (newest rev)
         items:
           - const: google,lazor-sku4
@@ -545,11 +575,36 @@ properties:
           - const: google,lazor-rev8-sku6
           - const: qcom,sc7180
 
+      - description: Acer Chromebook 511 Parade bridge chip without Touchscreen (rev9)
+        items:
+          - const: google,lazor-rev9-sku6
+          - const: qcom,sc7180
+
       - description: Acer Chromebook 511 without Touchscreen (newest rev)
         items:
           - const: google,lazor-sku6
           - const: qcom,sc7180
 
+      - description: Acer Chromebook 511 Parade bridge chip no-esim (rev9)
+        items:
+          - const: google,lazor-rev9-sku15
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 no-esim (newest rev)
+        items:
+          - const: google,lazor-sku15
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 Parade bridge chip without Touchscreen no-esim (rev9)
+        items:
+          - const: google,lazor-rev9-sku18
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 without Touchscreen no-esim (newest rev)
+        items:
+          - const: google,lazor-sku18
+          - const: qcom,sc7180
+
       - description: Google Mrbland with AUO panel (rev0)
         items:
           - const: google,mrbland-rev0-sku0
-- 
2.34.1

