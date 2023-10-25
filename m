Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D27D6370
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjJYHhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjJYHgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:36:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985E230D1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:34:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32d9552d765so3845020f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219270; x=1698824070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vl8vmMHFFGT76d4GtNSEupCDJ3JGe7v4mICOWNP1wjM=;
        b=lJjsVdAy81NEfpgKYjO12CBzI1Inayejilg6HXkRoaakwHTjfEpwxM017o74UDWNNG
         GYJSPplNfE8rNIIF61WQAhflJhwabvRwLRcKmmZzT28b65DHB9PYCbQs+w5/Kx+F1A8f
         T4HAJQjxznjNcGj3pGYnej522tVfFFhilEBlGJiZg3gkYoe3upd34ZTmFKEuXoUiOWJv
         mHf+L3SwcLPEmyMHpOj9FjuG9nbMkGsFE2ZM8H9H1Fsm+Ov45vQmalKRyUQnKPODXcXH
         CFuIi8MKF0dqbysmDrjx6vmrGXzaySAU9/w5T5VISh+mCAzh4fRVSqVNKlJOm2iRo7LD
         C4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219270; x=1698824070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vl8vmMHFFGT76d4GtNSEupCDJ3JGe7v4mICOWNP1wjM=;
        b=JDe98WOdyQSlTfEwyyPsQCZ7hmlZGmTIdtjDlsl9g4UlzEB3y9hxqwH8Dpm+HPZLBx
         Cxo6S3+34UVTTmXaD0UEnvqaPEa+D7CTZQvanWtmtOXc+P4yTe0diCGFTwTGTQVlNYSU
         ZOD85g8399PihIHvwKlMnJmcffN3X2u4dfh7fNTHcZ53ZEkpPy3GKWg3BSzcV4sWBuGc
         q2ecdMFc3Bo4jPJC+GiA1buahupZRIOaw61hOwplZ6EGBqksTXYeB8NYGifwcq0l0Fz8
         iXZV8Z9LFLrCKu/uAoVDaV0TmL7+VyZH/ykgNW121SlDPOqkQv6SNG+b0jTRmluIzvUI
         rQIg==
X-Gm-Message-State: AOJu0Yw2o7yUtrENzXqgjHsYUKsSrY1oK5Lxr5lIEaBhloNXptZxBmJF
        LjGGExBoNHkshuH94L5IhPRGJQ==
X-Google-Smtp-Source: AGHT+IEG+KvzpSTGHFZWxScY2uqX4IQOYRoXOYbZRpZ0ixHJRz+JlKuREIS4JAMlFfxiQVIcNBhOBg==
X-Received: by 2002:adf:e507:0:b0:329:6e92:8d77 with SMTP id j7-20020adfe507000000b003296e928d77mr10006667wrm.51.1698219270510;
        Wed, 25 Oct 2023 00:34:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4ac7000000b0032dde679398sm11431392wrs.8.2023.10.25.00.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:34:30 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:34:23 +0200
Subject: [PATCH 1/7] dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: document
 the SM8650 QMP UFS PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-phy-v1-1-6137101520c4@linaro.org>
References: <20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=787;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=bCDRPrc9BmxSVH1ZE52SGnJTh1cBQGHH2pHl/JHy1Zs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMUB/Rgsky+njvVrJXJbvuwUArcU0sDiqnrO1N8N
 pAvdLqOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjFAQAKCRB33NvayMhJ0egCD/
 0Z/peMhuVXDFPX6l619YKuLHavzzASJjOYOFRtymDk/f+k91hac1amhsj4hV4oENfR8MDSk8mbGJsW
 plA2zrzFyk0OA8crsNmSoHIrkwQp5WVVZui4aHaJStdqsmg+PQiW6AsQUpqT+caKoICBFJyRdBxpv0
 8RCaMoSgTiREwq5L29YdzGMWYZzD6jvynLCEONcU9fNwb5HmayvBQs6jR3OHPDJYoZdtgRUaTqPAju
 8/HKBF9CXUfmT/qifiQAldScLX61b/e5l9DxmrSXSbwC0qH+vEgsFk1QMgrn8hkAPWLrR10aryxUTX
 4bSQdOnxnmgeJy9u85bX0K/njEcMLS32/ASvwxjtFiBT+1pL16iwdxlizOC/3XyCzcCFGG20GYGyZc
 490JLcTu3kVBqWNR2uHS8dxNjj7XzoDKYIil+Sn5vwbnb/whl1UjvhhRB6m4y9oqtX26uCt6aQJ+Qf
 +nDi44RLRYBjm1yzT6PBAAViXb2GIl2H1Tiij0wYTDU3B80+ukSWrG1S3Ucat9jXylpv0/xoQeylGG
 wo/NKnv21igWRsXFmWKaCe8WEncEMRqM4oWVF2ZuQCC+0jdifmiGiz50wPyK1fwAAMoQtI6rrWr6X1
 uE9B8KQgOqylyq2ZdnSkWlfRnY7dKyk68NyA52qGXH2XwkpkroAyz7HBbvEQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the QMP UFS PHY on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index f3a3296c811c..1d54d564fe9b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -32,6 +32,7 @@ properties:
       - qcom,sm8350-qmp-ufs-phy
       - qcom,sm8450-qmp-ufs-phy
       - qcom,sm8550-qmp-ufs-phy
+      - qcom,sm8650-qmp-ufs-phy
 
   reg:
     maxItems: 1

-- 
2.34.1

