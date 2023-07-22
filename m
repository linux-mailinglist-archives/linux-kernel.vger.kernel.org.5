Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2AE75DC24
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGVLzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGVLzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:55:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128382D47
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:54:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso25828455e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690026886; x=1690631686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02nknKMJYKlDUsZ+YqcOCSB4hUZzBMytrcBqER2E3Do=;
        b=umiYYc/aB79bh3drCR+5MHqjugR24HGF2bX6eebpo10/T5g1KdLjrFKA9OZsFVoQvG
         0W6mbXmvzfG5Z+NZyJ14nhs198h4uDwOXKBP7oWxSPVGBnxb06jURRyvhP+sVoVpk1X6
         dafrfaNRCd7Em/sC5tVbcRLq0wHnQkdzB8yV7tSYeinLE2N1xMdDxhwP+VjKZJjoXhPw
         iO7yFefbiOju0bALua9+h18ZdzL/VXQb8I/nNUY3Qz1PqeiJECNPM1uI1emjgNCB2d8I
         6ruDO1BRhg+bvQsJq2cQe4W8xKinaWsj+hA7vjZsvcjCXEPbBTpCPqqwxWTFdpxZG/lA
         pAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690026886; x=1690631686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02nknKMJYKlDUsZ+YqcOCSB4hUZzBMytrcBqER2E3Do=;
        b=UREV1R1zKY4sok5PbufFGfkKuFchtqq97Or4pGLUWAhdjVMl2FpKrsWf3/Uwyg23j8
         BqrAqWBkrULwUBpfSIFYtKMvShC0ZfdmPpMfdYBaq/x5JCluoMlzbQkJjttilBUV2oEH
         MX5KJdhU6YMWqS4vlvtj/jcXqOj9G4DgvJA96TAyNdwajo0GLdCxVyxypZALusr1pYct
         Is49MPnSjaxbInh3C0nzEjoWfsN9o0k27LlkEkNDz2WKQ4DjVtpm0G5NcpFVySqlyh8g
         hyTVV0w7v5rVJtCHh3bHBMCKsMA+EomosHcdTs57lpHIcmgrCV9zFs+osxmIVcySEIHR
         XJCQ==
X-Gm-Message-State: ABy/qLaCPaUJwfGzkmRUcwgDv6fKlOnhLxrNDtzbVqhl1dHCHL/AAlBR
        0IIDz21q1UnQALg5fdV+YownyA==
X-Google-Smtp-Source: APBJJlFx0RAbdgVsEAvPtj2sTHjoNfSYVpuccjeLCL0FmCVV3bneOPClpiWLn8F3WdkbgnpvEW1zmg==
X-Received: by 2002:a05:6000:10c:b0:315:a1d5:a3d5 with SMTP id o12-20020a056000010c00b00315a1d5a3d5mr3843614wrx.22.1690026886543;
        Sat, 22 Jul 2023 04:54:46 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o8-20020adfeac8000000b003143b7449ffsm6726496wrn.25.2023.07.22.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 04:54:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] media: dt-bindings: samsung,exynos4212-fimc-is: replace duplicate pmu node with phandle
Date:   Sat, 22 Jul 2023 13:54:39 +0200
Message-Id: <20230722115441.139628-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIMC IS camera must access the PMU (Power Management Unit) IO memory
to control camera power.  This was achieved by duplicating the PMU node
as its child like:

  soc@0 {
    system-controller@10020000 { ... }; // Real PMU

    camera@11800000 {
      fimc-is@12000000 {
        // FIMC IS camera node
        pmu@10020000 {
          reg = <0x10020000 0x3000>; // Fake PMU node
        };
      };
    };
  };

This is not a correct representation of the hardware.  Mapping the PMU
(Power Management Unit) IO memory should be via syscon-like phandle
(samsung,pmu-syscon, already used for other drivers), not by duplicating
"pmu" Devicetree node inside the FIMC IS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../media/samsung,exynos4212-fimc-is.yaml         | 15 ++++++++++-----
 .../devicetree/bindings/media/samsung,fimc.yaml   |  5 +----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml b/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
index 3691cd4962b2..3a5ff3f47060 100644
--- a/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
@@ -75,13 +75,20 @@ properties:
   power-domains:
     maxItems: 1
 
+  samsung,pmu-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Power Management Unit (PMU) system controller interface, used to
+      power/start the ISP.
+
 patternProperties:
   "^pmu@[0-9a-f]+$":
     type: object
     additionalProperties: false
+    deprecated: true
     description:
       Node representing the SoC's Power Management Unit (duplicated with the
-      correct PMU node in the SoC).
+      correct PMU node in the SoC). Deprecated, use samsung,pmu-syscon.
 
     properties:
       reg:
@@ -131,6 +138,7 @@ required:
   - clock-names
   - interrupts
   - ranges
+  - samsung,pmu-syscon
   - '#size-cells'
 
 additionalProperties: false
@@ -179,15 +187,12 @@ examples:
                  <&sysmmu_fimc_fd>, <&sysmmu_fimc_mcuctl>;
         iommu-names = "isp", "drc", "fd", "mcuctl";
         power-domains = <&pd_isp>;
+        samsung,pmu-syscon = <&pmu_system_controller>;
 
         #address-cells = <1>;
         #size-cells = <1>;
         ranges;
 
-        pmu@10020000 {
-            reg = <0x10020000 0x3000>;
-        };
-
         i2c-isp@12140000 {
             compatible = "samsung,exynos4212-i2c-isp";
             reg = <0x12140000 0x100>;
diff --git a/Documentation/devicetree/bindings/media/samsung,fimc.yaml b/Documentation/devicetree/bindings/media/samsung,fimc.yaml
index 79ff6d83a9fd..530a08f5d3fe 100644
--- a/Documentation/devicetree/bindings/media/samsung,fimc.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,fimc.yaml
@@ -236,15 +236,12 @@ examples:
                      <&sysmmu_fimc_fd>, <&sysmmu_fimc_mcuctl>;
             iommu-names = "isp", "drc", "fd", "mcuctl";
             power-domains = <&pd_isp>;
+            samsung,pmu-syscon = <&pmu_system_controller>;
 
             #address-cells = <1>;
             #size-cells = <1>;
             ranges;
 
-            pmu@10020000 {
-                reg = <0x10020000 0x3000>;
-            };
-
             i2c-isp@12140000 {
                 compatible = "samsung,exynos4212-i2c-isp";
                 reg = <0x12140000 0x100>;
-- 
2.34.1

