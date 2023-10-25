Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDA47D62B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjJYH3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjJYH3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:29:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D5E182
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:29:44 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40859c466efso31309715e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698218983; x=1698823783; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx8IlXiAIz+L/8v+7piI1N8I5OaioAed75m9CEhnWTA=;
        b=WenC67Y4VvDnxSFzOLv4ALAE1hRVwviPLNn5cA4Ndis8EO23iatv7mV6GFBZYkFH/V
         p+8TlDdVQ+VtJbtjePDRtB9Da64RXkowbKJOdznLpOAW3utmDdxou9BDN8rBidmHEIu/
         vvyDTYXU7eXt+tAhOARgEAOrz4RbyD9yYepOp5KUfd+VB4VEprueZyDiYPd3SF3kxHx4
         kCIi2THuHHsXg0cY4k6KQnY2wFvnrT99s7zMlfRoVDnXVftb9KyhDPULB+ITn2ny9WFM
         qHFfech/JH6BSQ+Bg1CEfe4zhiItPBwBzPvcPQRAar89VFc33C3ye0paIWuw2f+1BcQ7
         Nf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698218983; x=1698823783;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mx8IlXiAIz+L/8v+7piI1N8I5OaioAed75m9CEhnWTA=;
        b=rRmuEAI5CvkKHM75oTPArKzJFNT1i4T/npLM5TTorzsb1ULrs/tjw+zqQ+dtqenmCX
         Z1kXBV+1EsPJ+u3bGNyfhaNbQsNKEL3uno8OErX/YtCsBnhmbqn3eg65dyXQLDbdWBh5
         r/k1xrgieR005Jt/EHVDAC1m807nNfFLcsBA2ueBnFpob9VaPiqbj2Mrf57Roc5jYsRl
         VazGIuHcVtTHe0XUmZ3iAsaJn1GqBIEAX3nUkUQu4LzyF/UgObhRR5l2F6F1pWQacl2j
         1wcUMEdKORiGTwN8V8/R8CgVLQ/63w8A2lwOCgWpfh7Xk1X+P6/51G+dU8Wz3um8a+sW
         bzfw==
X-Gm-Message-State: AOJu0Yw+VcjZBLjlx7ziUhQxE3/4irfszomBHRxiZn3R2UrAdQYI9iB3
        0mCZFHqvdYUBXjYD+fI0qgsq1Q==
X-Google-Smtp-Source: AGHT+IFN5mFuPW14bv86l1Vsoyp/x0jnZX72hYe92hmdCXQSsFSxDIaqaDCZEu9HzA/Yy+g2Q6zaRg==
X-Received: by 2002:a05:600c:468d:b0:409:ca6:d79d with SMTP id p13-20020a05600c468d00b004090ca6d79dmr3563471wmo.18.1698218982647;
        Wed, 25 Oct 2023 00:29:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c05ca00b004083729fc14sm18296389wmd.20.2023.10.25.00.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:29:42 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:29:41 +0200
Subject: [PATCH] dt-bindings: mmc: sdhci-msm: document the SM8560 SDHCI
 Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-sdhci-v1-1-e644cf937321@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOTDOGUC/x3NPQ6DMAxA4asgz7Xk8BfEVaoOaWLAAyGKKUJC3
 L0R47e8d4FyFlYYqwsyH6KyxQLzqsAvLs6MEoqhproxZHrctyQedR36jvCXdM/sVvxKDBJnRQ2
 LF2xcayeyA1nHUFIp8yTns3l/7vsPPqlhMHYAAAA=
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Lp3aRQCBhCwDMKgoBNmH8yh9tFS8RCfk68sTwAA5uDA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMPllkefyT4L6D+1VxS5Ucjjq0DIWvEoqE2oBsed
 sq8T96GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjD5QAKCRB33NvayMhJ0fScD/
 9kK5I7YhZUaNpUzQVrbRuUI0ymazzepsuA6HAZI+fWkqIEXL669t+GkL87G4XJ5l9/D4+jrNnD+rSz
 RsxlPoZejBBHS7LDdg4zt6cietq0geSiD6Om0u9enxAm1cQROV8LFefIodN1CnlH3aqjgWNgGqqXbP
 YaGdrkoGwP+KDe/FSSipEJEJ2DQiB54LCPmumTvofHkETlT7X/b/T+A24ULLRfnrF6tXeZXWiys6LC
 FAwtHwxuZdjwBcrlzHo2MYQmT4U+TmSmT5vcHB3niP4LZggBeYiWeWkxTyNNCZuec9/NbnX8qR5kzq
 x8+JUdw1QUlX0qj/8vZiPvgUKrTBlSQ/pl/SyaqQ2n2MfVsQ5ZmO7AmbxxhlgS1VWln9vcLEQdhFPJ
 1QSRMAS0PjaP1DcckK4ckunF1KYH2s4a1krz40iKcjahm9lzDWQARG2/bT1juyapA0j/0JbGYghuYZ
 Ck5Cz9+zgRzJNATyL2ChPXIyfi+9gAbeqCiiFHmhWrH1dXqT5tPSMmg1syPiEZi0kjnxd3rOasvuAJ
 hF+P+6k2WNicL4MnhEV0VNcrKNYE/O74JiVnKp9bgvHuupErSoy1tbrQvohNVdz5J+V7OYfZsAK2Ye
 Ph4e/Y7iKtkqqYSYvXzBkkCmcLOu1SC+deAEo2KW+ZsLMR7xxKHGcjTuJ1Ug==
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

Document the SDHCI Controller on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 69a213965089..86fae733d9a0 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -58,6 +58,7 @@ properties:
               - qcom,sm8350-sdhci
               - qcom,sm8450-sdhci
               - qcom,sm8550-sdhci
+              - qcom,sm8650-sdhci
           - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
 
   reg:

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-sdhci-3a47f07807ae

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

