Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935C17FB464
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbjK1IhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbjK1IhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:37:16 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56542D51
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:37:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507c5249d55so7804106e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701160638; x=1701765438; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGKLjx3luJGU+DnwzUn3Qi9imxdPkVHML+rqCOmAtck=;
        b=y8msmTu/0ijVSnrlmJDVYaHkGc+qOWK5/G4fc+LtaQ2v/Hv7wuWO+K8EHachk8s2+N
         /eAWN50FM/0xBECm5Tn11nLhXEKfwV3d0LkmLkynTwv4gaW/G5/TMk6jEkGALs1LYmmx
         VIbPSjGY8lCxJh4YO+Mw93Vt0ZcX8Zzl8vuprZdOgqIn8F0UiJtX8GWHM2bCpgjEAQLo
         2xcGOskquJyRAOgVAr4QvuvAb6S7r1nyXMjAC+MIiqB5Pxvr26pzAv4ObluSSLf/oOdZ
         y5r77Uj0zZH0fm1jWfAziytFhR4H43N9amS+fRfDrT8bOPNVS7hky1wkU62p4zbhQfJ5
         IEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701160638; x=1701765438;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGKLjx3luJGU+DnwzUn3Qi9imxdPkVHML+rqCOmAtck=;
        b=pANWpv0kUnceN51WuoSOrQTzL5konXxACWkFaVdkgQdqNW1Ck+ADUjAC2BPjoxisp2
         3Q75GzSdGddi0pOwqT8eU2U2lpd+1kvFYKocnOOpK4w9ZZbYwI0u7I4YL3NsB3ARV7UP
         JWTdr82J6YEKHH2Zb1soUOeVO0W2HBtk8ZEcko/yfj+1GFHxXPhg9GK0M+vasgLsQyjv
         YKzs3289fOPJjSak3XIdnTqnUZLKhcJU945gwhBOlaShJS1ZJz7kHSg/1G3R3DnYF+K9
         FbbQ/VkG5g4JQa4lDW9593WnV0chwKTlzYco8rlLIdHxuSnMh3bTZ5XWvSq2GUKX/6Mo
         pkLA==
X-Gm-Message-State: AOJu0YwTI8NtGm5Ok1K0XcaMIzEKlB+To74+6P3FEf0QvHBC7IxwgljE
        9BWiIaLXMCuA5ZDbwHwPDcXLig==
X-Google-Smtp-Source: AGHT+IGV9g8Gt0GdX7z42ch7sDJF6Eu8IzKDEWg0GGo3YxYJjiALZKGhZW5/q4ocv0/V3tt/PsVvSQ==
X-Received: by 2002:a05:6512:4022:b0:509:4ae3:465b with SMTP id br34-20020a056512402200b005094ae3465bmr12923505lfb.8.1701160638511;
        Tue, 28 Nov 2023 00:37:18 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b0040b4b2a15ebsm1853454wmq.28.2023.11.28.00.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:37:18 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 28 Nov 2023 09:37:15 +0100
Subject: [PATCH RESEND v2] dt-bindings: thermal: qcom-tsens: document the
 SM8650 Temperature Sensor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-topic-sm8650-upstream-bindings-tsens-v2-1-8a21f61130a5@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9N+6dBAkFtncfZi6ZHXGSHcpyq1NPV2HQpTLMM/rMdA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlZaa9KgSozkm2ZH1Xcfu/rkLseV0mf3PJhCPUInPW
 pXh1t4WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWWmvQAKCRB33NvayMhJ0f/GD/
 960lAxxbkUmvvPIT14Hh+ln9cs81E0R+EQ02UdLYQ+EGUeC/sLDsR18EHMxrHWDj3at63o9c4nVh9A
 /iqanWFHRlFcFrDTLxZpeqxaJCMAKGm6wqYrBl8Q9QEG8Yf+THxAldSWQZOKNDGdgqo1SKVWtUkaZm
 PcoQKZ7yYny0+2vNpwgX3ILw4f9UUGYjkDHCzrb4h9nrAnpPo+21skempCfvqTGA0UlIv34S61XrwJ
 xJUqNbz5LyIZL36Z9IqZP8wspF7isX6wl9lnojvoX/enIKPVBS7T19IrGOW8y0fQj3te0LVBCqqfsu
 vswBcJtKDhZFAqsY1pUdfbel5w4SSRgHkRatNlp+XrXbSHYCHeGVTNJKnoyGYOPHf6AL17p1mh484x
 0EDJhxe7BjslPA0/yf3Ho0miPbneu33Jbjc5fku7CBnYeHPghgxZN00biJRIFWV6vpo+uQLOk3gfoS
 t7FYCTPLLnwu60BO/ugC7ZYYO2rrMQhSy6ZVLoY7VcY7HCSdmAt4dg2IpRJZHKJuWUn145P/lvCdd5
 P1PdsTTuG2VZ2EnxCqjHaLioI2w5TqNbUqsJy5LaHjElHXlBJXokPCV3BHMVs1R2jTRV7OeBBFya/e
 SIJe+eoGV0OxIt2kux8bdoXtoAis0S11Fb/+A/bg7rlLJDAvOeSL4i32GXOA==
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

Document the Temperature Sensor (TSENS) on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
Changes in v2:
- Fixed typo in subject
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-tsens-v1-1-09fdd17b1116@linaro.org
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 437b74732886..99d9c526c0b6 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -66,6 +66,7 @@ properties:
               - qcom,sm8350-tsens
               - qcom,sm8450-tsens
               - qcom,sm8550-tsens
+              - qcom,sm8650-tsens
           - const: qcom,tsens-v2
 
       - description: v2 of TSENS with combined interrupt

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-tsens-4e748933642e

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

