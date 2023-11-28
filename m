Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88C67FB486
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344200AbjK1Inx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjK1Inw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:43:52 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9304E7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:43:57 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32faea0fa1fso2922722f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701161036; x=1701765836; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4bAL9wCzZrXyWtxL7zNG9vKSMElpc631V0JZdvT/8cE=;
        b=n8DEtSpbP4Lc12SncjYLjFAKhEcQacRIdvIipccCExHuZgK9eUVTY3X2i4pmLw+EuW
         SK/fel6OTf/1olZnKC9vU7lZA46w2/EghjfQ52XkQUIaBoKie+tItiLJUqgrVU0N291h
         Bc7yFGRP6QyaTiwp/KWCttxDHvLcfsOMDINZJsi1hdpVhHgTBzh2LQuwyPMkpjAhPKv1
         EFtCY5lVA1kZcpngSUuFhjRJ5H9uXO2HuKAjTdAt5RrK8QrKDIS11i7XfJ1ZX7MYYZZt
         nhf8iGY1qAJ6AknZxijfFPgnDzpahKy1lOVgvA0/7Uo6kpm5vs2qOBdx4CwceQQgrTOq
         zOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161036; x=1701765836;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bAL9wCzZrXyWtxL7zNG9vKSMElpc631V0JZdvT/8cE=;
        b=no/I7AY53n5VbsolobiEtoAQOmBS8DBloTTEU9Zbb5B5uucS5BD/vSVHF8UiNDI5CL
         LhgOgvobCntgplpTiEaELniERVz7h/YiCXwqBAMp7SJwaioBpYQY4Alot8jE83AdT4MO
         OmbBsQbkymbI4Ni5PtOlBD4Fuybhl6bCCAcWzTikPYqRGLtxmvpJTaAdaO26tRqEdf35
         eeVlj0gWyM+mZIJficxVRoJF38jA6/DGYr/8uq/2dt+Z7690Y9eVcUhBBzzNzfzpDk5z
         4fKQkVtBEm1Shdi+KC24JrqzWHxE5nAbQQvroVe/CS+q/DlkoZdQLMEfUYDS3E/0fWcb
         XZrA==
X-Gm-Message-State: AOJu0YxsGsxvb9qgJfOucVJdXsRBVqrdyfIM/hyJK83619TFFNDRbcaV
        r69a17XUITMJsa1HcA3s21YcLfwPY65WW/i5jStheUbv
X-Google-Smtp-Source: AGHT+IGLKX2x9ZeYgdGvBXnmFO0RbxBreqNPQu++FMoxAjnczCD7QKz1LViCkE3nfFkXvajqCdiNkw==
X-Received: by 2002:a5d:64e3:0:b0:333:47e:4cf4 with SMTP id g3-20020a5d64e3000000b00333047e4cf4mr4189105wri.15.1701161036204;
        Tue, 28 Nov 2023 00:43:56 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b0040b45356b72sm7190730wmq.33.2023.11.28.00.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:43:55 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 28 Nov 2023 09:43:53 +0100
Subject: [PATCH v2] dt-bindings: PCI: qcom: document the SM8650 PCIe
 Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-topic-sm8650-upstream-bindings-pcie-v2-1-b72e2d13bcf1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEioZWUC/42NQQ6CMBAAv0J6dk1b0oqe/IfhgGWBTaRttkg0p
 H+3Eh/gceYws4mETJjEpdoE40qJgi+gD5VwU+dHBOoLCy11raSysIRIDtLcWCPhGdPC2M1wJ9+
 THxNERwjG4lma2jptGlFKkXGg1365tYUnSkvg9z5d1df++tr81V8VKJBY93aQzjT6dH2Q7zgcA
 4+izTl/AI6OQ63XAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=b9Lr7rRAqvBSJYXD0r7yOgr6vC6l7cqk9pw+NrXCzHI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlZahK9SITHC1qQaFOxJtM+0sSsIsMwuBf2G83PX8h
 OLS6Q1GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWWoSgAKCRB33NvayMhJ0b+5D/
 41siyPhaZtKiccO/sqXLqowxzzKa+Ces19XNGgAwfLwaCbu6s4lxoN8+AgoRYpekrVsPM+Kg6SPVgN
 WD0AXKfzhWV/C4m+Y4gbAKc35rv4YaHnGkc3ha0i0GvmJhmIpwFumze6mKrOtspdSfLWXsUJFj0OhH
 LMHrZg6KtsFSYga3psEwcpG6C3nWEg7eQquY+mC+m/xQN5gbtbGiJ2B+x2l7URNgzI95RXb/R8m5IP
 sqNqEQ/zp9niL3xsfIn6zv/0hzZLnk5+graX4LShvSDirqypjjmByL9s7724eqEOEFsRb6KmBa9qcD
 dP5zDeUYkdvR+KrKME/BxsYcicosx/6+RxtotofMWbWu2CxhW9Zf0CFMhlZpgwpYnCMfdTrB/9EH85
 cIaFxHtm/Efzdk8C0Pxmj90cwDCeT58AkjvLIG7hALtBrddaTdCWnORSVTwSL59ue4lW9r7s31c0jG
 5X4S3mfa2102SGgsTlhxXNaZ9V9mwZH64MiMdAXAtlN7TV8v4TEQAMiAoAsR+YGKJtbuok5A8RvFuM
 4SJbHRNweFIsY8RL+4NpC5HApIi/UtlN7AvNLirTTCwjI3aA4mWs6osKpIWnykIHNnGv46b/1Bxm8N
 ++YCs4kCxV4S7zsHDyWf+Ns7FOSo7+N/LWYkGkHdLsYzCS7ydat5FNN+mO8w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the PCIe Controller on the SM8650 platform by using the
SM8550 bindings as a fallback.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ
---
Changes in v2:
- Collected Reviews
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-pcie-v1-1-0e3d6f0c5827@linaro.org
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index eadba38171e1..af537732ded6 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -41,6 +41,10 @@ properties:
           - qcom,pcie-sm8450-pcie0
           - qcom,pcie-sm8450-pcie1
           - qcom,pcie-sm8550
+      - items:
+          - enum:
+              - qcom,pcie-sm8650
+          - const: qcom,pcie-sm8550
       - items:
           - const: qcom,pcie-msm8998
           - const: qcom,pcie-msm8996

---
base-commit: 48bbaf8b793e0770798519f8ee1ea2908ff0943a
change-id: 20231016-topic-sm8650-upstream-bindings-pcie-56e90536c258

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

