Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F06E7FECB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbjK3KUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjK3KUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:20:06 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8228A10E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:20:10 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b4744d603so6216585e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701339609; x=1701944409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxpSuXDoom2RWs6bn/SJPon0BVz9GrlE7SEKe7RDhZw=;
        b=PepdqaZc6ocdLjexCseRnx+nXesW5bN+OCwhMYppyH87SvGCdonWZR4vsX6xJdvE80
         /tKx7cJkzlFNLStSmPV6XcpxTWZMmzOpNSgZye0UcHgt9CKdXRXA2uAR04Ae1JXfGwBR
         0/hL3ijyC9aig/eYoYkfY7ikGAHRXd0yekc3D9IvXMSUS0xNSWN4W0CtxaQr2l+aO9SU
         gx7pI4xqVElBXesw9+H5JFAeQ0V5N9YA+VQRjspg4Gm4/2j7Uxtfld6ymcmP1WbrDoFX
         nI57iZ8monmZ9A0M1fygcDuR2v7D7qrTgHnmIVgw768seVL8BPnYUYtDkjSqUBmIBmyS
         5PaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701339609; x=1701944409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxpSuXDoom2RWs6bn/SJPon0BVz9GrlE7SEKe7RDhZw=;
        b=M0/r1M0QIbeWL7dMu0nZzm+obbwcsgP5UWhiFri/0ear7Cr/KUZC0eiMH6KRJZI5L9
         Zmj6YgrFw8LkOmPI+JZ2w7I/aKX6h5C6PFtmkx/l+5GxkTsxTJPXQiIw9mQGFkyWnEPL
         fkNVOzaqh3OcI2jlY412AAaPWYugvy75mR3wxJzvRDS4IIArwn0n2uk9Rs0Et5kjJbi/
         Gij1Xt95CFnuMvk/p5/0QxyPHt4iYMQQbbG4gwyVt0LL712tAixaW37mt4KjVayS4pa1
         vjcy1o/pIqM/WcMtr0MxP9Ws4CpBp9U9+MmdnGsByT6VGACsf031wYUjDV9vDR9Vb95T
         WoHQ==
X-Gm-Message-State: AOJu0Yw12vcZ0y+Iq1/rt1nh6tn0tZSK30iVeWiBEKXj/TY/NVE2DQJZ
        AO52J33k2FU4hy5bnxXXtb0A8w==
X-Google-Smtp-Source: AGHT+IFvSq0HzK0KCOH3t/clnOaFqIB0qH//d75BhbjKhD9d/LdCdNhxIbKCcvs6M00kRsESFk/ABQ==
X-Received: by 2002:a05:600c:4ec7:b0:40b:4b2d:8d0f with SMTP id g7-20020a05600c4ec700b0040b4b2d8d0fmr5953806wmq.31.1701339608890;
        Thu, 30 Nov 2023 02:20:08 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c1d0a00b00407460234f9sm1465217wms.21.2023.11.30.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 02:20:08 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 30 Nov 2023 11:19:56 +0100
Subject: [PATCH v5 1/8] dt-bindings: arm: qcom: document SM8650 and the
 reference boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-topic-sm8650-upstream-dt-v5-1-b25fb781da52@linaro.org>
References: <20231130-topic-sm8650-upstream-dt-v5-0-b25fb781da52@linaro.org>
In-Reply-To: <20231130-topic-sm8650-upstream-dt-v5-0-b25fb781da52@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UZ2eQGqqiWNvOpQYnbzT/mou5C8lbL9c01Zc1IvQLo0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlaGHT6UXMFtSyF/Y9ks3UcDiouJZ1XQKWxvLADOZS
 ixcz0+uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWhh0wAKCRB33NvayMhJ0TkpD/
 0ZnZ2ATiQ3lIgyTjRSBt/o0+D0tkEjAKuXVf19z8H8f88KMsGKcqy/iDN4TahQdIOBi01At588y3le
 2dhTrdNEdyoCPVIEQOxUsRlZdHvFQ13v4kIXCuL8VxAYRZUU37NT7K4qiwfDXchY0PdBZ9CNDoTB77
 gYpc7wWTOHSRh19li6r7a2qxoO0FR/ryIIwhm0sAw3VgZ73XtlDU5FT1Wvpxpa66THlK8Zy5nnFK//
 S9BtGDD+0w2fgCeuz4u6iD2Q35U8RMeb5igiWtzqJb581BV1Dsn8gX9j5lW9vSwHut939wxLWpS9AS
 9BFtJt6DlU9rodf9Qkwke0RWOCdqXfWKTkk/DcCYY1POcILZN/I1FKZGW0fhPa4ZJv9VTVZogVhB45
 F5Y3VQDY5xR2B1JxpBGK6be6UHhaoUSMeJqZXUcOqkvw+fZMy2FTiqfZX39LGyehm+ykVwUKOXQeer
 D93nF9Tp9tsNEkXgxReWcx87VdYuzWC07adnnYGmyMovMqLi7z7ZuKJV0Ql4epxuDqQ9qZj6XQsnMK
 1F9dLWoxN6STWoBPJlqx4D+sPvdPFLZ3PIgO1DD1toBZXSHfEXJeihylzFv0UQsNIknCWicGQsyxwl
 lSWs/QD6SFfOMmKNYeixzP9VMUMDu9xnzxFGq71LNMjBDWMPDigHBQH4bi+Q==
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

Document the SM8650 SoC and based MTP (Mobile Test Platforms) and QRD
(Qualcomm Reference Device) boards.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 88b84035e7b1..c5b6518973d8 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -87,6 +87,7 @@ description: |
         sm8350
         sm8450
         sm8550
+        sm8650
 
   The 'board' element must be one of the following strings:
 
@@ -1044,6 +1045,12 @@ properties:
               - qcom,sm8550-qrd
           - const: qcom,sm8550
 
+      - items:
+          - enum:
+              - qcom,sm8650-mtp
+              - qcom,sm8650-qrd
+          - const: qcom,sm8650
+
   # Board compatibles go above
 
   qcom,msm-id:

-- 
2.34.1

