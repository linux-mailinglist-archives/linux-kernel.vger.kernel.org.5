Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D3E772532
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjHGNNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjHGNNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:13:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9FAE43
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:13:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so22308495e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691413980; x=1692018780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW8bAZOpofrAZ+E1cERRtB886PDebwGsovf/Pz2sHNY=;
        b=NBFvLuOfuqii+YsiP6fAqg2jYNwaUOzi+zy+p6hiHsBwUqsGaqC+jifC8WkeFzHJ3p
         9bGi50BRrixhKZ/AGczbT2D3DNDVj03v9oFDRRHS2WkCOxSgt0ReT/fFhGpFPPQaiYse
         HjxvkP/NPV8DohAp7J6hq4SeaAVItFAQMsVt+SfbSHFhqvYCiX33LEnBwSQkefvkpPrQ
         yAG2arWbsqrzYzjfXZ0MuU6zVyGjf0a83K1Qw76IAac7k0Q0bdpmgA3og9NEk19823Rs
         PFfEj+kknB+PamtZqAc8GhCIC/I8vL8fk56b6X5XQc+PMdXeDdJWaaRsa4824aUoVD8b
         8PLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413980; x=1692018780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZW8bAZOpofrAZ+E1cERRtB886PDebwGsovf/Pz2sHNY=;
        b=OncN8n4vDSZcTKwoSnX33VPLeATe64FAC9ZTWd/uLOmwQvRzxtHtlCbHmtfQgoHpd5
         LdOd7+m+dpfeZDYtym7H93srZEwNYa3tZOJPv1sX/AgbHK8kGK8ZFGEyUgOFAel0cFFb
         hLEE05tfg+MNcbGeImo6G1lGt7UCxkirm9j+ejTwRrAhQiKE9TDR9nDwPe8r/igTNhDW
         JOMHCX1dtvGx+gizn6BtEMXUIY/cX/T1zlEa4Ux9RHDvNxz4rLN8BNLt66N6xyQX77w4
         xCsyzGw8IIWxaQcyRyVs+PFlO5fcIML4uDexF29fio9eH7JQ1nB3BWLX11rNVNkj1H1d
         ZlQQ==
X-Gm-Message-State: AOJu0Yw1rvgSRTUSlv6rhVUt/cbC0t9maBVjce3UFJr3FDBhPc/iA9FN
        8OxvCczEYnQM+f9LGve5U2/w1g==
X-Google-Smtp-Source: AGHT+IFgUw/IsPxcji669Ya7tWBBXSklfkr9EK6+mKTk1ImVlXR/2gF4Mefli/6npyXEZ+Id6V2QeA==
X-Received: by 2002:a1c:f60b:0:b0:3fa:991c:2af9 with SMTP id w11-20020a1cf60b000000b003fa991c2af9mr5860825wmc.16.1691413980429;
        Mon, 07 Aug 2023 06:13:00 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4489000000b0031411b7087dsm10618428wrq.20.2023.08.07.06.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:13:00 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] media: dt-bindings: samsung,exynos4212-fimc-is: replace duplicate pmu node with phandle
Date:   Mon,  7 Aug 2023 15:12:54 +0200
Message-Id: <20230807131256.254243-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add Rb tag.
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

