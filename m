Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD52786E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbjHXLeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbjHXLdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:33:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AD119AA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:33:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31977ace1c8so5863746f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692876816; x=1693481616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijL9XhwjGXgvTsziQU1R0Sp8EVefJrVWDew+ILjeQSQ=;
        b=iMJdQlCNmWcU3CD97Rf6JU8z5W97p8+IqbrQlDhM13RINBrFpC56uJWD20HHCWbiT7
         VEBPJB0v1vMaWVWhWSOe9i2oEtgZp9wDUpeICcOi7bAukZAWh6ReQZ8wzxdogFpTEIk4
         lv+qvKyd/GK8Fu1NEm4U1QbD1q6wr9l6wioRtNl7it2hCVltRVUtWLXQ3IdFr4g3n2Pm
         tk0c+37iqGy28JYQOPGbHLU61Um3Ouz5W6hAbIUdlIQrCkS4K6f4C9vn2fQ1AA/d7tZD
         mqmMAIsOpwhx2JYguIal7FxLaI3rmjYiw0QsqILibFSAoPYmpZO7/l/IpojJyR7kRQKK
         iJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876816; x=1693481616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijL9XhwjGXgvTsziQU1R0Sp8EVefJrVWDew+ILjeQSQ=;
        b=X1Gjjf1kHSKJvD5ZBHA/Mr0c54uUXLhM7KGLET7g98hNCoxbf2WWO0Y838+n1hkApJ
         4QtL4dG3T7HkHzIKvPwRi6w9xFCLkU+fHtPK126OoXCR5FfiHGjnDZ1ULOWjA6VDLBxI
         AGdEmMrb6SOXAV4bGVKidXDTMwjdi2YUJN/Hs580rzIGDGYH26d6b0BbReFf6O2sBNIa
         I1r88ovIopbv+VM1hwtcLmIQWX3pQDaRQjn8aroBokQaU5zFayWh+H4v8djl/TtwEJXN
         9oc9mQxQrC9NXjJ8MnyrpPZ7yzTyiP9BQY6Q8XvsYnUzpMCPSRakH3U/jRtgxmcY0pu3
         HXRA==
X-Gm-Message-State: AOJu0YwiO52AsjEj/Gxwgjc+o1XLnLBku74wU5XPH3TtO2eCrI9C9L6W
        AABv6+gDfBkFmT7z5ArfO9GSdg==
X-Google-Smtp-Source: AGHT+IGG8oNcZ7PNzYH79eqZ9d04xNwDLH2FikclwMSWDu0S2fyqA6VpVAlcFGLik7H8W8dly+XjdA==
X-Received: by 2002:adf:e601:0:b0:31a:ea9a:b602 with SMTP id p1-20020adfe601000000b0031aea9ab602mr11098109wrm.1.1692876816537;
        Thu, 24 Aug 2023 04:33:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d65cb000000b003179d7ed4f3sm22063938wrw.12.2023.08.24.04.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:33:36 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 24 Aug 2023 13:33:24 +0200
Subject: [PATCH v2 5/7] dt-bindings: crypto: qcom,prng: document SM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-topic-sm8550-rng-v2-5-dfcafbb16a3e@linaro.org>
References: <20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org>
In-Reply-To: <20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=870;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ICXotOUiTdh5yjHcK9RlGWMhy0USQET7mt90sU485TY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk50AIud6LxUXIggA7N47tLDhf4/3Qgaw3POkNWrrb
 PEfr69OJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOdACAAKCRB33NvayMhJ0fI7EA
 CsYFJIthQE/UJ3/C+CL06/Y+7Xg4P0ykAaPXPvxSYmA6hREwCcGNREB/udwl69waRFAG/hHnLKYb2Z
 Cr2UTTBTBGFUCLs+hvYbgXhhkVYRW8L+SvEnlDjy79P030fyK4H1yZ3i8QWv7S+oiapiX9vyyZQihY
 5aych1befV9pXMZO9zflpHL2Hd6lIzebocakACS9atnldHkVJBrN47stdAhlRkrbIcvIDtUYNvRh5X
 NMF57oBl31Sj6JiMXLGJws26j9nou0iw5ASjyHRIH7IKzFiN3Sr4DdYFlWi0T6z7kXBiHT1s4SfEf6
 fpOfoMivg3vkSpIn9frvRNvkxvl7uMKIMh9bPoFAXAxXQTR5fxV5MzDv0kjRGtEYsN1Xk6jF7iBS3D
 BxRz5iHHHRrdNp/u5jZzjY8cSu8HQJTST+PHYHOSgLrFbH4i8ZeI0MSfPTo881EZ1xCCIqlZ2UCTlK
 FiMnY/D7Zx60aGD0fgZ4V9X+MxfCwt+hQKgdV3s8z1LA9sB90lHxKc8H6i7wxIHleFXElNnID44F48
 ejr4WNampBZABp1T1PrptIbFEKbYl6q2fAndj3Bk0dgGUmwI+8p8cCewJZytqO+PYF7iZ8xSKfQGwc
 glAJOn4f+xoL937fGnbgFA/eofRU7zBbTD4qV2wTZM9jC/MKResTiD9BaR5A==
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

Document SM8550 compatible for the True Random Number Generator.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index 4245c9e424a3..633993f801c6 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -16,7 +16,9 @@ properties:
           - qcom,prng  # 8916 etc.
           - qcom,prng-ee  # 8996 and later using EE
       - items:
-          - const: qcom,sm8450-trng
+          - enum:
+              - qcom,sm8450-trng
+              - qcom,sm8550-trng
           - const: qcom,trng
 
   reg:

-- 
2.34.1

