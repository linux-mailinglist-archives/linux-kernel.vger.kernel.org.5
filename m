Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956877E921A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjKLSqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 13:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjKLSqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:46:11 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20201FF6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:46:07 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso3752335276.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699814767; x=1700419567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0UezdLYD5scNL5kYSvTIK/LGcnTqVfERy2ExLqUR88=;
        b=VCKr8s05r+s7F1MKoBjoD9X5Yju/zxitaUofUYbxEcZRUVgOW5BfpPbmegldxh6aUv
         U0HdQ4gEfBsJ4rb7HgTCfT+Kp948hd+DZIun+JuZ4CBlFJXP0iDV19GWcH+juCKOX1z4
         wnuXMsKM+Du/f4T7Qwti/Jk4C2EDFBYgW6ZioMx0fuskJBDIqHYcVA2ceilM7WTYRSnG
         l/S+5GoC0Rkj+5NzXUltr1HzbsC0lVlkehEODlkdnOomVpQCF0mH0D9WMZ0+7QqsfJ8Z
         2kOdHBp2KVc/vCQ5JflzJ48q3QkyUwVJQKP9w9uN8ddnoIilwW64BmOCVnSQgAtH/IMA
         ISTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699814767; x=1700419567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0UezdLYD5scNL5kYSvTIK/LGcnTqVfERy2ExLqUR88=;
        b=tgzfiXsUF2Q7yFmrOTLIKQA+UXbC85ENRIwtWJVo27aSiFBWsnlEQofX5KsO9Q64xI
         Ej0P8XONeMPfT+o8eNqaApriDXAn2RMRrQevKYd6tjbjCuV25TwStTMBcR7MRIsSMVAM
         xxiAugricdWvM5UpNYjDnWAFDHp96VfC678yc9RvWD4gF7UdR2zDOW8Gd+cjiDISWwVU
         NgqjEiSuVMKAIPa3S/LleNMcnTW2BSyYBgyACZRz4MUklMYz4+e854SzWAR8Xw9D1KdH
         5mu0J8dm0e5c3WTwSIXhRF1rh3dX3U+7BjAUBKiTYKT7N4ZKIEzZajGWYfP/8yTnE6V5
         0fOg==
X-Gm-Message-State: AOJu0Yz8CLqZjN/BwdrsGlgEL68WGilv0UrI1syxQ677UA5fmSIT7i02
        BqRm90uue2fa5OlHyzJKeXHAKQ==
X-Google-Smtp-Source: AGHT+IGzMDV42Dc+z6kVlgJlDpbc3rB95mpnZwob8pQsfQOsfIb2nXUi2vL3ixJhYc5tnfaiJtoJ4A==
X-Received: by 2002:a25:33c6:0:b0:daf:6259:43d8 with SMTP id z189-20020a2533c6000000b00daf625943d8mr2987278ybz.36.1699814766920;
        Sun, 12 Nov 2023 10:46:06 -0800 (PST)
Received: from krzk-bin.. ([12.161.6.170])
        by smtp.gmail.com with ESMTPSA id o17-20020a258d91000000b00d995a8b956csm1104185ybl.51.2023.11.12.10.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 10:46:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: PCI: qcom: adjust iommu-map for different SoC
Date:   Sun, 12 Nov 2023 19:45:56 +0100
Message-Id: <20231112184557.3801-1-krzysztof.kozlowski@linaro.org>
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

The PCIe controller on SDX55 has five entries in its iommu-map, MSM8998
has one and SDM845 has sixteen, so allow wider number of items to fix
dtbs_check warnings like:

  qcom-sdx55-mtp.dtb: pcie@1c00000: iommu-map: [[0, 21, 512, 1], [256, 21, 513, 1],
    [512, 21, 514, 1], [768, 21, 515, 1], [1024, 21, 516, 1]] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 8bfae8eb79a3..14d25e8a18e4 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -62,7 +62,8 @@ properties:
     maxItems: 8
 
   iommu-map:
-    maxItems: 2
+    minItems: 1
+    maxItems: 16
 
   # Common definitions for clocks, clock-names and reset.
   # Platform constraints are described later.
-- 
2.34.1

