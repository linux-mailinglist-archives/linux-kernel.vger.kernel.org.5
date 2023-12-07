Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B576D8088FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjLGNQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjLGNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:16:50 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC943D54
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:16:55 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9ee6fed3eso10695711fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701955014; x=1702559814; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rk8qsAP+TFlPc9+aBIEsrkcMIIW7Ca+8Wo1Dz8GCExE=;
        b=LbfK+72Gt2SbmJoOkN2vsWmUvzzTgxk+bPDsRFvAAnWQDrs1YLLS/nE/OgphH8ZnY0
         UC6RnjxS2kceWabXUSOkXvFlsLFdJ9kQD7t6Rqd7UHXVMtdXofMyU1K+B57ULbWaRCJN
         BOsS1jJyDUQVTvR21TR964oxekKsYD3Ci107+rrtMc+igYxctK/lgrhgFl4Dc4h5FEm0
         e6ZAiZakelMz+FL4+KXLzDU/GkZDzhGQeQ6gg3pGvQnf5WWiuMIJ55jKjC1ZvVefoJLL
         M4YEG+XpOJ//Kqd8F6O0AAImsaJT36HdkyEzVMzQfodGrNZXMMmy/Cx9+f8Ddwjg1hSV
         JMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955014; x=1702559814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rk8qsAP+TFlPc9+aBIEsrkcMIIW7Ca+8Wo1Dz8GCExE=;
        b=NzN4At0qriNDzxMThOZLM7+UNqI1AgYoI4xrL23GUrBzBx6xQf1PzNtIuOA2GQqPV/
         iNttQjBySc7b+zPyKxl/TYJlJh2E9iaZ+3Ti7ZBKnVxrBMBriT12RR4V11jKiQjHZlRf
         tZEZ80Ycd6eaX8eRk2jf7Fn0vd26yTlSnL2NRnsJZEvqcHvwDclnh27b7zYdlk6dOxV2
         WW2XUYkiQ2qFhLEwcb4oEwaOMwKKbiii8e6KOwxhznPozUkOzbxCqAd+NC83e37AfmtG
         BxIm+ZsKlP/EHqFN5liQ3C61o/UkGcRKnTFlcfIX4cXnIA4YfZvwi9aK8lQbitAorMUE
         lpiA==
X-Gm-Message-State: AOJu0Yz0iDxaPo3yyQJegPSTPKDOl6cvkETaJ9yS5VMG2PhurL6YzkrF
        pNjGDPWVSr0CdAAuYuHOmEfV6w==
X-Google-Smtp-Source: AGHT+IFGDrNGI3ZLhjzr4c4hGQgz6xvhbmIM3ZCtrclnigWgEf/f2pmFXpCsGhKpLrzQPADENTmIbg==
X-Received: by 2002:a05:651c:2129:b0:2ca:2425:e069 with SMTP id a41-20020a05651c212900b002ca2425e069mr2075467ljq.85.1701955014160;
        Thu, 07 Dec 2023 05:16:54 -0800 (PST)
Received: from [127.0.1.1] ([82.79.186.233])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906040800b00a1d01b11498sm815233eja.24.2023.12.07.05.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:16:53 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Thu, 07 Dec 2023 15:16:41 +0200
Subject: [PATCH 1/2] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Document X1E80100 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-x1e80100-phy-combo-v1-1-6938ec41f3ac@linaro.org>
References: <20231201-x1e80100-phy-combo-v1-0-6938ec41f3ac@linaro.org>
In-Reply-To: <20231201-x1e80100-phy-combo-v1-0-6938ec41f3ac@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=+KllDdHtSqAPF3nrZrVao8XwpqtX0txm4oMk2jjIl7w=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlccXA4kvy/jYG73+UFQnfH+xstGVNl/jY15osx
 9jCCD09aIeJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXHFwAAKCRAbX0TJAJUV
 VgN8D/99psDcOee6DbE+I1kLhwpqH/rhcAkgSWsOMChYH/kkP972vTxtQZhdmzH39ZGuM5DDjy+
 tKUhmMICnG3HRw5QqbZWZMQmUi5e5xhO8wUBF+uEFrABJyGPlWvoFqBzv21SMmtMyBTGlT073kd
 TTrfZHTLlNMBB1ByIJ2ZVfUKiV6m89E4BBfOs3Fl3NPEIYkKI783FxsB6iu+tmLLRRcLHCevzCx
 x3eRCnPwAUld1PHMGKNykTm50AZ6HN98BugWJX++Y8Y44HqnuwVwpnytwCNHJbjFby9lX9uHEwT
 AhFuwpx9ptyFHuDbVk/67ZLAtC2t36M8W4EzJDCW8Jebz3w4UHoeQvcKTG9SY7newf7kCJ2lV3r
 FZ+myR1Ejhe8iITQnJECwIoXrWxcOR6j6/4GMVZZ4NdMfZI/4Mw3w4AdPGzV/SMqxlckATQtvLr
 EBK8IlOvSDWhPqTfb7ZIgps1+znnnZDO6HfbxgDMEZZap5SjTIErUAIXu5V7p/KuW5hzTKX2tmn
 +GLNiSXhCuCf57PG6WW7ptp+o+XMJxOOSobstX/6v7VWBLbNaYlTeJci6I94neFaJCmMKZhzNGg
 aZLB/qXKjQlccB6HjeCC6M+Lk80en4HkYBHj9OM3H5BtOmL3ofFslIDiaOVMycA9bulguFUJTGg
 d0IHYQAOT5pArVw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the X1E80100 compatible to the list.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index ae83cb8cb21f..159a4a37dec3 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -28,6 +28,7 @@ properties:
       - qcom,sm8450-qmp-usb3-dp-phy
       - qcom,sm8550-qmp-usb3-dp-phy
       - qcom,sm8650-qmp-usb3-dp-phy
+      - qcom,x1e80100-qmp-usb3-dp-phy
 
   reg:
     maxItems: 1
@@ -130,6 +131,7 @@ allOf:
             - qcom,sm6350-qmp-usb3-dp-phy
             - qcom,sm8550-qmp-usb3-dp-phy
             - qcom,sm8650-qmp-usb3-dp-phy
+            - qcom,x1e80100-qmp-usb3-dp-phy
     then:
       required:
         - power-domains

-- 
2.34.1

