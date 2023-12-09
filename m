Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCFD80B569
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjLIRKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIRKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:10:36 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C8410EA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:10:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so8660453a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702141840; x=1702746640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v5RWH25pS49A9wtTwrglnRYxNRiRU2sSwkBOk9D2iEI=;
        b=B90zPIvJJWTu2UV8UsC9lgQE2bHVlJNfTp842hXzJHhhAnnF4NDq9h4cE7erM+Moag
         vCtrl/lW5CkC3l1lcmGw9v6B3fK3RWzbo1FONcAEw+kZTh2gSJ66IHGnGxHsm/ySi4aw
         jHjT3ww/SNA5bfMJwbcxJxP3qqDzvFlQmZ1hI3rxr0MTQEQS5vXuz51V184EDQuiBEps
         Sr4EqgtJO8IyIYJD3h2y2koiAWEkCLV15v4wbxVXuWNaPI5vrbnpUFF0EX2ULSvo7T02
         wbCN96lMIQfl6k/Jo+LUefaxuyBmFOtGHUVt7Bgfk0PF1UuMUt9hovBmue4EzTQ1c/Qx
         B96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702141840; x=1702746640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5RWH25pS49A9wtTwrglnRYxNRiRU2sSwkBOk9D2iEI=;
        b=XHgblkFgVKV6ba9hEKvQyB9wgILERit9836CGBH057rtpZthEW+2d8n+GHmkO6++HI
         5RONCXVrT0Z/edzuJ8R2TZ+bLZof44VRrJLbv5tuDKPO90nZteP/VsaSS8GQpfw1M/Nh
         LeLnPdbrTeKcga6sHsxSDRdOQWNwA3YmYC7Q4f1CptDMaCTN20gy2dScCXTkYUiqMjYB
         xtc0HKG0rkLUAQ+L+kF/jUQReHyrsnQy7BvIKZa+9Kegbn+0tSVT9k7TFYu/XzvDKzpP
         sa7zgmdcB1czp4gJYEc92I/1rfSzqQ4rasXSkWgeg3ngehlISxNuqoLD0568Ww/OWL3h
         1rcg==
X-Gm-Message-State: AOJu0Yzszwk+W18CuVqHYiNqDszL1T5WHkcbmRjHwEiA68A9pqwIJ/Pr
        k+xSqM/mtwdL7N7tA54FNkGWJg==
X-Google-Smtp-Source: AGHT+IGN48qr0TD6bf2QcADaZTbl9FnlB1gwoIQfpu2bc0k57aGc/i7eP0yBpt6pqz0CkB2Q901+DA==
X-Received: by 2002:a17:907:9486:b0:a1d:c376:216b with SMTP id dm6-20020a170907948600b00a1dc376216bmr2408908ejc.45.1702141840368;
        Sat, 09 Dec 2023 09:10:40 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vs5-20020a170907a58500b00a0a8b2b74ddsm2430029ejc.154.2023.12.09.09.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:10:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mmc: synopsys-dw-mshc: add iommus for Intel SocFPGA
Date:   Sat,  9 Dec 2023 18:10:13 +0100
Message-Id: <20231209171013.249972-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DW MSHC node in Intel SocFPGA ARM64 DTS has iommus property, so
allow it to silence dtbs_check warnings:

  socfpga_n5x_socdk.dtb: mmc@ff808000: Unevaluated properties are not allowed ('iommus' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I assume the DTS represents the hardware, thus iommus is real.
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
index b13b5166d20a..a6292777e376 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
@@ -35,6 +35,9 @@ properties:
       - const: biu
       - const: ciu
 
+  iommus:
+    maxItems: 1
+
   altr,sysmgr-syscon:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
@@ -62,6 +65,7 @@ allOf:
         altr,sysmgr-syscon: true
     else:
       properties:
+        iommus: false
         altr,sysmgr-syscon: false
 
 required:
-- 
2.34.1

