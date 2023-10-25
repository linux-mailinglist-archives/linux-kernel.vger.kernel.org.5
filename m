Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2A97D62B6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjJYHaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjJYHaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:30:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE59F198
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:30:08 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c59a4dcdacso16984161fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219007; x=1698823807; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=crclIHZgLMbk6m6cpstTsXFLirHjxlOQ97dZu+AQEPg=;
        b=HQRpv89jotuMJPEC41M6S8TnHYe1bxKtr9h8GbLZHTWtUGM5xRdhqTq9BFKc7IGsqH
         3t7QnPSSvubWX9bGZ6yAwADAwp/2m6n8OlhkUi2q6DS8poAdqnLSGC9melsIaoZ+rojf
         T9Q2kUt+ZQcRJDcTBXG22hRXc1Y4HBYPLk0n3h6za0y+deEtIHB+faC/r6EkoMkdnbWG
         xBVxN5oaA60hVRAmoGZ3cb4EO2apAgOL8Qe9Y8BMiWifRjP6kBBUSD7AvnJrvZ9o0RW6
         Zm4pU805MUMXGF3Hn9V26nkNa1r5mnKghO1o2AlRUgLDz6boi+KazW12IBn2QGBCC8qA
         oXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219007; x=1698823807;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crclIHZgLMbk6m6cpstTsXFLirHjxlOQ97dZu+AQEPg=;
        b=ZDlX/FHprq6s8JFA0iqjWQYURBgktrJhvnW82fAKLMHNJOp6UYeHAUNxq/Jvb0m99p
         U6fcWqqbPEveWinvTusV7AaOq2tzNhcYV3wAiHcTBmHZctr4O0u2xXkbeBev0rtbwkKY
         jgBze3LHb3aIyOurYNOaHb/r3e7VFvMNgmKfp7i586i13ejCYE/OY/4XciUtBUdPUhdC
         AwHeX2h4Wy+8QWP+OEf/orJwJXjnpbRj+bDoFAWiPzx2gu+6qKjgvSdnDJ5Ay27Ph2iB
         GImjy4anBtKk40iGLNMut/B5mbidRJbyo8HmJjRSO/5FbQBm02yluduJbXikXUCDzP/y
         BtJg==
X-Gm-Message-State: AOJu0YxXFAxR8Aojx6JA0UJ9STA/PqX8HxaMEUsvq+PNLbPHXSTBlRUZ
        HY9XOpW6bLbdNnbkpVAQ+UaqFA==
X-Google-Smtp-Source: AGHT+IGNvgspM4Ac9oCCHRA72EBa88NI0wqgIUNEgBol7/cvx/DQpMR2fSHGpGbzetKlClm/6tECUw==
X-Received: by 2002:a2e:b4a7:0:b0:2c0:2583:520e with SMTP id q7-20020a2eb4a7000000b002c02583520emr9144325ljm.41.1698219006582;
        Wed, 25 Oct 2023 00:30:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e16-20020adfef10000000b0032d8354fb43sm11530984wro.76.2023.10.25.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:30:05 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:30:04 +0200
Subject: [PATCH] dt-bindings: iommu: arm,smmu: document the SM8650 System
 MMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-smmu-v1-1-bfa25faa061e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPvDOGUC/x2NQQqDMBAAvyJ7diGJmIZ+pXjQZGP3kBiyKoL49
 4Yeh4GZG4Qqk8C7u6HSycJbbqD7Dvx3zishh8ZglBm00hb3rbBHSc6OCo8ie6U54cI5cF6liXT
 gK4zGO7d4GyO0UqkU+fpfPtPz/AADJwKZdQAAAA==
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=88P3e6NmMBveIZbiqKlF5tiz9ASGje5GZTyQzmMCUXo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMP9T9lepQxDL08IGQ9JeVjmsISz045nNadYrpz9
 sO8aoHqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjD/QAKCRB33NvayMhJ0X0qD/
 9T4nZKw68VFJfE0N4ULm8ESI/e+hScGEjyYZ9iF0DUN2vYUVaig66uLGwzHDbPNnyxTt2L76ZjmvFs
 z0eamZfWiQUwE5e2zvDwgApbGAkk4P+sl/xXgC+kOi9l8AuSzg57PUMJp6cFv0umq1liwg0lytXRpV
 tTQO331phmTLUsDQhDs7GcEJFBVPJNzsubZO3ZQzsOd7wwvSgHRZcLPBZ8HIDloiaIflsRoMuidyiZ
 AqRI+IZagSJcNj00QFwpC7lgipyEdmFHAR4fSW3Ckols4P4Uoqmda3L+9pxBKWSPoCRyw8JbmhkAif
 I8rEHT7+CrWRD3O4DhK/kMQuyPxaJenIqLm+UszbIL3AVjQXFHUVovsXk0XuPTwU3wb5qmm9zdQgb3
 +R9UEuC6rTxLoC6ECpwX/Yxg7ZobyxrzV+0+nW7pDZo490IiMKAmP6vZossoAMJdxmsPBqlmeo3fHA
 s6roGtDnBoClpTrvTHn50fdhB+qXHwu85ktjbf2Y0TWga78zkwzG8Wc6zDQCwXktDQHqmR/vSkgegF
 BI7iUjNQuwi4k0tfTPu/FBsuqUwo7ivqq1ipasKEGyVRpmP+TvZrZ9runFp5Qk6/iiV9Mq8oLMosUW
 d+zxF6FcxI82LJpGo3r+9l/ognTj0RhsvHGCpSfCeKsaxtnk4BlJF6LJWA6g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the System MMU on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index aa9e1c0895a5..157de0d0a24d 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -56,6 +56,7 @@ properties:
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
               - qcom,sm8550-smmu-500
+              - qcom,sm8650-smmu-500
           - const: qcom,smmu-500
           - const: arm,mmu-500
 
@@ -475,6 +476,7 @@ allOf:
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
               - qcom,sm8550-smmu-500
+              - qcom,sm8650-smmu-500
     then:
       properties:
         clock-names: false

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-smmu-7d52c88bc6ff

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

