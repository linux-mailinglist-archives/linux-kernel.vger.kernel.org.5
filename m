Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2A7D6289
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjJYH1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjJYH1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:27:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3250DE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:27:39 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso76311861fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698218858; x=1698823658; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8AvfCjICBvqGXl1CJCJu3/DA9/DX1PEtzN6VBP43gSU=;
        b=oCOjftM9BpkeFU1tl2P05Zb2UegD4r6+E3OpDKbMxTU4U6T1r+20SDaK2rT/ujX5jM
         OV16YMVOLdbqiAbtUaGxt7zIXqkDPTaovRKZOYGVy6vDWJl5Lu8riCt1dOqJz7TjeGvX
         ZjP9cPGMMhUU2Y68NtPsG3SwkYnGyHdL3QHN0r6AxSuFvBMpnpJBMqE3tdImN/szerXV
         Wox+OJLPqs6zvIVV2mRi9o1rQWLLLPWJss66wEK/MphhX+ovMrB5/6Bm37AH5xnOvKLq
         5nvT8qPHCAtHqrRpN6w/OGluzwokSpwJ6XuisPTv6TJgl7GNgZt+dNwlbiXrtzwiHklb
         YI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698218858; x=1698823658;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AvfCjICBvqGXl1CJCJu3/DA9/DX1PEtzN6VBP43gSU=;
        b=xJc599ti+tdiZcCDnoGydAm+Iysf5tY/WdsxPxRwX/OVu+dZ5IpFnPodPSITy7Xevs
         ASivHYWjoLwL6CjoLKq32UFRbNLavHdJlTQljmhUz6sSrb9rkLreetFV7YmDEv4lTYlK
         ie63k7t9kIYP7owkLpU6nEKB5Ts5QPvJ1w/fGUAvrAsKbmGPasekOGRoJD6GwUhIwSpa
         YEkvWZRVG/v8ELUmGR3CxI1obN8M6V40KsILWAN8IpcwY3f4wIuXrkWPw7B6gFf5See6
         ZVcao2GNXvmSIRBVboSx/nsJDSAskZ4HFieqjvDAW+28pVtIKLXRkJnGgBnuszWNrzGI
         w7gw==
X-Gm-Message-State: AOJu0YyvJw1BLbW9PPcBbxsE5CH6rBCKFiwCD/u6UJraMrV3rxGUQkKV
        IsyAlVq/2QLM+iTq64tvdQEjIA==
X-Google-Smtp-Source: AGHT+IFTTWZe9xgkUzYAAHAu1eGgPcFieZ/HoLmGBfhiwiQakLeiuEnEp4LDajlcYtaV26uVRQp2KQ==
X-Received: by 2002:a2e:b4ba:0:b0:2c5:b87:39bc with SMTP id q26-20020a2eb4ba000000b002c50b8739bcmr9689593ljm.1.1698218857832;
        Wed, 25 Oct 2023 00:27:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fm12-20020a05600c0c0c00b004030e8ff964sm18759623wmb.34.2023.10.25.00.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:27:37 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:27:36 +0200
Subject: [PATCH] dt-bindings: qcom,pdc: document the SM8650 Power Domain
 Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-pdc-v1-1-42f62cc9858c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGfDOGUC/x3NMQ6DMAxA0asgz1iKA4lor4I6QGKoB0IU06oS4
 u5EHd/y/wnKRVjh2ZxQ+Csqe6qgtoHwntLKKLEarLEdGfJ47FkC6jZ4Z/CT9Sg8bThLipJWxRw
 DDt1Crp+9sw+CGsqFF/n9J+Prum5LJXbPdAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=7yFCHMkxyK/fQuUFvR7qRoCu3GwPytc64QaiGrwMCII=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMNohLUy+rUQIgj3FuVa2ZPpbxO8YQjWVXU9jLFU
 nH1nn22JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjDaAAKCRB33NvayMhJ0XijEA
 ChTg2dyqVAO8WXJwOZhbD2Zdbg1PaGATTaquKnoUFvHqFDscacPyHD30HTfcL1utJMFuNVFpveNJPQ
 oIGyJra19uWfEiIxNIqAjzz8ng9nwgxxbL0W/IuTMmlvy7hkPXJlAo59vNKYbkENw9tgBdXVak8cCz
 Ck0/D+5Td6UFuICFDpXAYZuezuhQPCT/pM2SLpGgkQJWUNJBa630RrUPpf3GT4HKA918ZTl9QLGvTG
 YvF6mRb4rb+QwfEWqpFxiOUnSzR+MPv8ta5T1jH4ZFDsgLg7dxO2Q9tppeTXDgusMt2Er21svNfsPO
 D7JZ0PKOW0/3gUpYesGC3kUY/RQ4Y7z+M04H0YPe/e8r1ib7k4qPHlYGKoh2xPNldSKJ4EfsdTgVWP
 bLENfvFWm0un3+vilnV64xrU6gqJO6Yyne5CtQdPUj3J2wLkG3xprckDTjo4sw6YZJmrv/uJlWgb8b
 jtmq9G+uEvamV6R4u5xe54QX5UQrGJBEBWimmI8GTFiebvmhFJ8tOZsH2oyPzndGhRPzNIJx1MTf0d
 jaRoqJdCwiAPOnGNJpGlyh3Vm6Ob0FnrNPO7QpkmaXcR6lWk+9HKtD2OfiojRq+VKZFajtv0UbyPoY
 ptNIuZxwiOlxfeD6AgYBV54fneSAEwvwdgjl3lO+UjT2AxRI3Era5gpjd7WQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Power Domain Controller on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 8473afffce63..c8a18bb25842 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -42,6 +42,7 @@ properties:
           - qcom,sm8350-pdc
           - qcom,sm8450-pdc
           - qcom,sm8550-pdc
+          - qcom,sm8650-pdc
       - const: qcom,pdc
 
   reg:

---
base-commit: 4830854409466173b786a2d738d78f701d880cc5
change-id: 20231016-topic-sm8650-upstream-bindings-pdc-83f154b65291

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

