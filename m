Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3121786E08
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbjHXLeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbjHXLdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:33:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B977198B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:33:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c4d5bd69cso3681901f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692876814; x=1693481614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7JVgS4P+r3UmL+zEqqJ/GMQY1QC9tz8eDbv8910S9M=;
        b=V53f72SG/otue/+tuFudA5Q8YGHWoaxA7TQozk08FfxNYzkL6TRFZ5XYrWXm+tu917
         LHZXwhfDDX3PfUTOmDvQIESdsTA8k491RCtuRtr8+k+Nk/y8nx3qdVSjLlAPirGTLQhu
         oBnn/0R10TpyKHJmulWLYI7WWxxnQrhKe6y1xhF1UOhIObAFW4WN3dvV4eFp/quYUsmV
         aXhYBp38psQR7VXrWjHrkBM7Z6LgbPJuIScT2TlLcLFWTXS5jSDEeVRqEn1NdAigZ2TO
         Ux2GEPMK/6Cj4IHH8u9YzD3oEBF7f0KtDwZkop3QwK/nwNhQXkVhtSBATD5LIxIFZhZG
         7UFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876814; x=1693481614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7JVgS4P+r3UmL+zEqqJ/GMQY1QC9tz8eDbv8910S9M=;
        b=QgbWJ3i9HRbdjZaGhbVy7HMd9ibaNcWp1yqXgFsTMeR7mKyZL8UydwZhhWgnAA6nWG
         UPDceyK2vYSFvypnfEdr0sA5qOIk8ipzv4RGNXEseKPi2HnrBuuVsJDM1I+ga1EfVqJA
         urvUtl5uD/dIJ8kW+FjuMcLNlFacR1D28knOt0CuYm0qyr5nNfleAavLa7IyrFqkh+1O
         UYZoKFLbNuch01L+DH4Isb5ACh0KZ0qenCHIPrsRCG9js+aG/4TtdUUztBrtF6/MkgQu
         MDTQ/UzpqupkRUsnu9a0+N+EUPSOPLZC+GjXVm5lLZXuROIc5wHEZjLY7yzv/MP4KleE
         +ytw==
X-Gm-Message-State: AOJu0YwanpBevuE8l0ZfQ1V4uk9TAqPlReq9HS4jGvwoYtlt9Lk6X97T
        UJ1JTyC5B5XtnaawzPXfGLwhng==
X-Google-Smtp-Source: AGHT+IHf0MvesscCIVZNzz1z+yO4m4QsxlCrKzGMF4nH0xWogaqvZJyN56VfVspoOk4QUILlBU55nQ==
X-Received: by 2002:adf:e886:0:b0:31a:d716:fd7e with SMTP id d6-20020adfe886000000b0031ad716fd7emr10256024wrm.71.1692876813920;
        Thu, 24 Aug 2023 04:33:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d65cb000000b003179d7ed4f3sm22063938wrw.12.2023.08.24.04.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:33:33 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 24 Aug 2023 13:33:22 +0200
Subject: [PATCH v2 3/7] dt-bindings: crypto: qcom,prng: document that RNG
 on SM8450 is a TRNG
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-topic-sm8550-rng-v2-3-dfcafbb16a3e@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=58wxphp2h2TI0jORKIXbWmrB3KQFcJDowKn8tdRUZt8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk50AHfonZie7b9AdU6R0NgcQ8qLlFJ07pEbuDwRPy
 LMYxB7GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOdABwAKCRB33NvayMhJ0fYjEA
 Cbmh8vjHfB/JtBtuEtXZ3GvClNvgfaYfr2V+grZgSUPiBD1Mxgx+jxQ49BRifHMDBxZrLKlN/ydraX
 SrqQdUsnKqskCEIaypmqRi7zZbPdzZPnAXuMKbyHr9zmfXc5+pGToiseqhiBUtKEQyevNbstyCKgbn
 WRSYTFdoVsONJSdrXToI08CZHNRDPO7cUbVn7gvactk6JMFhw5u1X/d52svCCLKfj9QS/eYweRZ8f5
 GxefR7QpbdvnT8v5fYpAA9p/vnUL/lvALK9iBrkvwV8GOdeOjd/OdljfbrOoR1asp8kDQfOkQ+/QWp
 2XzBZEqcR41CITJIGpo0leRZ7w/5F1xtpiCDrpWG9WwHcjYWOXAcQ1z/w0FppNRTY5HeAbaa2ttsw0
 gxWklLb1znrWhaDkNje01FndKVtqOiXIDEyzgqVk+lhitIoaHA+EUYjgsChCj30xnjZ/ghqTLiyU1H
 KvANLDb6h/r0Levrk/lDtf7nS3WFHM5KYkEzq4NVN62r6Aks/m8Rm4khkPjBTIpTsmygaB4A1S8p4S
 rDqp/7iTFOYD1bwVKdGZA5OLfrnSwCw57LNr7CM269I++GBlIKYpLPZEqFGGhcRWQfoRkg/Wtk8tI5
 qUxTxyFar3oVyxcBm9Q1DcIxGufSd0C2Ex+fCbqKAMb0NJsiTJLYJBsMPxuQ==
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

It has been reported at [1] the RNG HW on SM8450 is in fact a True Random
Number Generator and no more Pseudo, document this by adding
a new qcom,trng and the corresponding SoC specific sm8450 compatible.

[1] https://lore.kernel.org/all/20230818161720.3644424-1-quic_omprsing@quicinc.com/

Suggested-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/crypto/qcom,prng.yaml      | 24 +++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index bb42f4588b40..4245c9e424a3 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -11,9 +11,13 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,prng  # 8916 etc.
-      - qcom,prng-ee  # 8996 and later using EE
+    oneOf:
+      - enum:
+          - qcom,prng  # 8916 etc.
+          - qcom,prng-ee  # 8996 and later using EE
+      - items:
+          - const: qcom,sm8450-trng
+          - const: qcom,trng
 
   reg:
     maxItems: 1
@@ -28,8 +32,18 @@ properties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
+
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: qcom,trng
+    then:
+      required:
+        - clocks
+        - clock-names
 
 additionalProperties: false
 

-- 
2.34.1

