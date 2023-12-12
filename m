Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E966F80E86C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346095AbjLLKAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjLLKAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:00:43 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0A7D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:00:49 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so51749935e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702375248; x=1702980048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cUVZQ/IYwAI6WZvMPjmfLWkKuvHpVKeTYMRhyrONudY=;
        b=Q6L/gxFb3FmCJ9Rc62yUUHCz1fi1AaxVY2RTavt3qOAr5vqjyj2QUBTBJx8cntZ+5K
         rfDb9ZN4f9j2sqfO3BEs4oE+gPa/YNgT4U9klHtugGCXvX9LOC+8GhhhJXqvI87IMOoG
         h8mUxTKwjFgC92zz0c7KMW0jZXVOYAY9TIhrl5QN3ZZ9xpwNGRQKtg90lN2lrmRgSvuW
         +ogppDyQcpl4L3mSlc8rY0w/2Va21k0KgLIoxjJ2JG3oudl3DK2BgjL+CCCs7/2h1L1W
         K/6FqI6LKG0WsddRus/6tVzixDjTuTJDO39jBQDtLGKU78FfrUWscYCBdNQsoDp8NMtT
         6Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702375248; x=1702980048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUVZQ/IYwAI6WZvMPjmfLWkKuvHpVKeTYMRhyrONudY=;
        b=awCw+fJVEuQQirzqO/yKexep9SIi/2X2xHjVz4eU2/nJ6x3I3oJuJJ5hmz/NDzLNnl
         3NALFEaX+ty9FtdZ4zTjDLm+wfVXKfY69vqsBXqor0Qp/t4M0Gc9wsX7fol6EIL8sERr
         3/YMR+hGFWOtIxWnv83B0jXpZR18qzB9VSCBu2DUkFZetIqtzU7DVQkuAgEqvzRcyn8F
         H2T8vcL8fpWKECMvTcDD2NbasuLwTqrNb7GX0u6ZtnNbCcFqniHgV0ev7CKg5ZYHiEiw
         u6uk/m+FsSvbOaOt74m0thblz433ZX/pNoACaxa1C81/GsF2FC370MVWrOJVXQZPwlQy
         X1LQ==
X-Gm-Message-State: AOJu0Yzxx/GhD5yu9XCwojFef/Z/gQ4v0Koqf6yK/IRGE7v7kpMWMjlP
        RamwBUdhpKz71sU46+svN+sXjw==
X-Google-Smtp-Source: AGHT+IFr6GVYhaWHcireeD6R68VAGZ8agMs3iKkgcn39PwSI6e2bDEDPtZaXJL46wJHckm3gPKZT3w==
X-Received: by 2002:a05:600c:6020:b0:40c:370d:71fc with SMTP id az32-20020a05600c602000b0040c370d71fcmr2490188wmb.85.1702375247780;
        Tue, 12 Dec 2023 02:00:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id az27-20020a05600c601b00b0040c34e763ecsm14918912wmb.44.2023.12.12.02.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:00:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: crypto: qcom-qce: constrain clocks for IPQ9574 QCE
Date:   Tue, 12 Dec 2023 11:00:43 +0100
Message-Id: <20231212100044.26466-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding marks several devices as compatible with IPQ4019 QCE.  They have
different number of clocks, thus the fallback does not define the
clock constraints per variant and each specific compatible should have
its clocks in if:then: section.

Add missing clocks description for IPQ9574 QCE.

Fixes: 1f5ce01d5d71 ("dt-bindings: crypto: qcom-qce: add SoC compatible string for ipq9574")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index eeb8a956d7cb..6435708da202 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -97,6 +97,7 @@ allOf:
               - qcom,crypto-v5.4
               - qcom,ipq6018-qce
               - qcom,ipq8074-qce
+              - qcom,ipq9574-qce
               - qcom,msm8996-qce
               - qcom,sdm845-qce
     then:
-- 
2.34.1

