Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782847D63BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjJYHoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjJYHoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:44:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5826E1BF5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:34:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32db188e254so3717050f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219272; x=1698824072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVlwiJkgEOptZyxgmNkYyImFRkPkiQTz9Ix32yztC1Q=;
        b=z8ix1Ck2fa8YzN2xhqPKqa+BUKyJIXVyd1DPRZMSfqaGgVWBNHyEDjIdokUUwKEnZD
         MYmuSDdGb/t9yyMgTZK0Y5y0UJzs+KhZhvSiDsoG+asoNA+F1JkJY6P30CTkSDE0R7+C
         j6nBStyGJEgEyRCtmKgz9XpP/7r9oXprsFV7x60Re9OvQdS72kRAsWhksu0ssc+NiOaD
         4QbdlTQJzOFNbcGBRVSnI3KlPvhfaClh34sIc/Vv27m0IeyAEiGuOdKft+X8ymDS1OFw
         ZGcuWlr1/sFfUcDF0uJxbqPioK99VbDh2gk1V7SUxNvnNSB/ceQxu936oFUezFYhRXnb
         b1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219272; x=1698824072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVlwiJkgEOptZyxgmNkYyImFRkPkiQTz9Ix32yztC1Q=;
        b=wK4FNHnahMlN0bbxlyeznJ85B9LlUaNaktmyCAo2fmTlIIb0nJUTUu3enbo7++qTBK
         CDwPmOY1kVyVOpdXagk9At71SBKtzraK9pybY91cTdmS0u6bTjnIWW+hd4utxZIIXpiY
         NtHLBCPnz/BawhY4xklhoC52p3K7d1Kfa3Rz+ozNu32TPLAefAd4ffSUXcc3n6DGbh+g
         9cTKj5LJy8Ljov4EtSZVV3xEZk2Xvmgs5X9QJ3M/UfcxIQPcqeY0fMdKSRAp44FsG3Nt
         XY75WMhFt10St23h2T3f2zwrl44qLd/C6rMU4oHCbfQmaP7O6JSI9Y4yWY+eG91jWvBR
         wm1g==
X-Gm-Message-State: AOJu0Yyj3Ln0LQt8ddyDF7jHVtOgabc2o+D9sKfC5cMsk6v69mx9/gR1
        oUzZQRkZqmpNZbbMnBL8JvUhmQ==
X-Google-Smtp-Source: AGHT+IHAGjKxePRM19PhYeF3oCHG3b9njF0cJVMtL4PGOHKkoPvn68B6+gWqFkZVzVFHyq/HzEnKkQ==
X-Received: by 2002:a5d:4e06:0:b0:32d:a686:dedf with SMTP id p6-20020a5d4e06000000b0032da686dedfmr9812039wrt.57.1698219271597;
        Wed, 25 Oct 2023 00:34:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4ac7000000b0032dde679398sm11431392wrs.8.2023.10.25.00.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:34:31 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:34:24 +0200
Subject: [PATCH 2/7] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: document
 the SM8650 QMP PCIe PHYs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-phy-v1-2-6137101520c4@linaro.org>
References: <20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Yg0TVyiYsosBLzL1a2yrBPOz0lVUOibz3FSYURBPVy8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMUCUf8sE0aibMiV0kIEPpnQdLNqym/SMs4a7+z3
 YBq+aDaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjFAgAKCRB33NvayMhJ0dorD/
 4ge+60cPByERIZrdK4nSqpOR2twsY54BM1cNi25fPEnXeQ1WZ48honBLxai5rHSee554jueYW5JoUq
 pLIrM8s36DszEGrAc7S60rQ1yHLiuCYqHPN9Ctdz39xLourEQx7rxtvaGcvZh85rnQm/n0/fhTYox4
 ea4YoTlsV5tUYKEiAh8pkN1/ZDBirFWFKOO+UTUhDDnum0+yxZyvsRGYmzkH5TyFV+sK+hjJWGRKwM
 Z3oyrcHMuoVME4Wr0LQw3gRWv2XBiuYy4vScNd2OpZx4pIRJriM7LHuZRAAlAPAWQl7WOb5l1hTkl4
 BkcTbH0K95N9uQ7QoY9vyEFb/cM4pUfDNU+WRbZW3DVtlMI1tjTHW9waNKGKPClmAHkIPeMUefND1r
 VYZ5eB8eMb5RQufIECd5EoDRS1fsdx+9SLwVLQ5DdiyO3MOuu5U1dm1sakb1RZ8QGPlV5HZCpYaI+1
 UZ8sXCyaa3UDaRWk7P4ecZzkXEuIojHzrWxgdjdhVvBPkyqexJXjD/jsVCX/absJmtcij54THx7WgT
 UMkw/22VomDx7hl2h6OaGnFqN2s5JH++RpeaKOK4q7v2HOgMNU76wPZjOIOSMBq5OZj8cRoHh0+Q/i
 FjKnCAZLpcsrnefQvYx5EuS4L9qO4BXNd6CQyMlA7hOMuVKz6Qk9xy6NXWLA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the QMP PCIe PHYs on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 2c3d6553a7ba..6c03f2d5fca3 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -36,6 +36,8 @@ properties:
       - qcom,sm8450-qmp-gen4x2-pcie-phy
       - qcom,sm8550-qmp-gen3x2-pcie-phy
       - qcom,sm8550-qmp-gen4x2-pcie-phy
+      - qcom,sm8650-qmp-gen3x2-pcie-phy
+      - qcom,sm8650-qmp-gen4x2-pcie-phy
 
   reg:
     minItems: 1
@@ -147,6 +149,8 @@ allOf:
               - qcom,sm8450-qmp-gen3x2-pcie-phy
               - qcom,sm8550-qmp-gen3x2-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
+              - qcom,sm8650-qmp-gen3x2-pcie-phy
+              - qcom,sm8650-qmp-gen4x2-pcie-phy
     then:
       properties:
         clocks:
@@ -189,6 +193,7 @@ allOf:
           contains:
             enum:
               - qcom,sm8550-qmp-gen4x2-pcie-phy
+              - qcom,sm8650-qmp-gen4x2-pcie-phy
     then:
       properties:
         resets:

-- 
2.34.1

