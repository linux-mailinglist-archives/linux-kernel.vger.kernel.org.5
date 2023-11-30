Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BAC7FF301
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346152AbjK3O6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346145AbjK3O6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:58:21 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CCF1A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:58:27 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ffb5a4f622so141570866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701356306; x=1701961106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJgElm+2FKgOiklOOlflaWJ/HuIwIWorSVJS04oX4jw=;
        b=R0U85/pecA9j/yCPCDmWFg3tN+okjwsQW1/PKjWB/mU7gYk33oN2vnNunD5oIcvcTs
         AMwPbS9Uz8zrE61ilPsR7ePJKxLDthFe1IHiSaAy5Qgx1k/nJLGDfQTWWQfU+BOkCg58
         ixWUDPLL2LY024BJrA1zhWkX4fAym01TBLX/cKsmqGUDbSUEGdP96ghkaPcH32AIMtXh
         D/6dlNBL4nn2NkcKCu3ek5wyCA/6MwZIV/taliob/5Qpnfrzse8sQOY/C3WkNYHCkbbl
         X4bY744CYpqo1xesBgoiUHN+oi9EkSTlPJgyfHPAah9LDCVM1OM9fTwVQbkw5ySPeBPt
         R4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701356306; x=1701961106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJgElm+2FKgOiklOOlflaWJ/HuIwIWorSVJS04oX4jw=;
        b=nb3er/L0BUnAh0x9UNUQMrIJ2pM98DD8q8jPUeIFD1pQCX8pk816pDwjuNYrbJQBcP
         MWsiUtuwaLW73HwZrv7nZjv9cPJ1JlD/R2IbwjPHcCFZ58nlttqvXaEvLalcOtTWoFvn
         WOGvPdre+l95/iV6gCxAP38N4VSWOAb7mns2kEjJlaQwhiu5SBWYTHG7X4BaxEJtaBZD
         XJZE1Z1URzc9Qw6O4z0XTEkBcGpOyCMe9PL8BUkPQSI9EOP3n6Rl5Q2/tXVZUJM8WrWu
         q1Dde0/muhX3oAW5kinh904BbQZEs+9uorZZi4QCfKjdRg23q05amL8kX2HH3KyKHINF
         Rvuw==
X-Gm-Message-State: AOJu0YyxvejFSAtG/5VjS71J+wT+jOuKWiyKoHCNbaGlUAYxaOX6H3j4
        5exx4DWg21hh+P91VHXd6cre/w==
X-Google-Smtp-Source: AGHT+IEdc5RzXaFURAU5ct3kKx68yGncfwaVGga3c8YgiCbhZDEGnA9sVFWsFTJbCANEViMYDg3Qog==
X-Received: by 2002:a17:906:eb01:b0:9ff:53b6:f951 with SMTP id mb1-20020a170906eb0100b009ff53b6f951mr14942949ejb.23.1701356306058;
        Thu, 30 Nov 2023 06:58:26 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090640c500b009e50ea0a05asm756753ejk.99.2023.11.30.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:58:25 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 30 Nov 2023 15:58:21 +0100
Subject: [PATCH 1/3] dt-bindings: soc: qcom: stats: Add QMP handle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-topic-ddr_sleep_stats-v1-1-5981c2e764b6@linaro.org>
References: <20231130-topic-ddr_sleep_stats-v1-0-5981c2e764b6@linaro.org>
In-Reply-To: <20231130-topic-ddr_sleep_stats-v1-0-5981c2e764b6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701356302; l=1104;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=L/mYPSgVkQwlDWwgGCvsNga37g+6iaiq7t+BzLPdK7I=;
 b=u8N2CiHIzoLaEuBNc2Ib2FMbPuylVaP8j1vXJq18nkVLtgx4wKQyBeLNjMjamEX2RVstAuZZS
 Vig5YSRSe0gBB29M/aSZzjgbcOI+1kcdqSPJggbLSturZQ9MPss/3Re
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stats can be expanded by poking the Always-On Subsystem through QMP.
Allow passing a QMP handle for configurations that support it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml
index 96a7f1822022..686a7ef2f48a 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml
@@ -31,10 +31,24 @@ properties:
   reg:
     maxItems: 1
 
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM
+
 required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            const: qcom,rpmh-stats
+    then:
+      properties:
+        qcom,qmp: false
+
 additionalProperties: false
 
 examples:

-- 
2.43.0

