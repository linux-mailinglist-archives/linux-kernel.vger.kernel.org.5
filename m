Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B23F7D629F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjJYH3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjJYH3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:29:00 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3EBBB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:28:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so81078081fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698218936; x=1698823736; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rj2UZ1DerP02Kvz7nBD2BYMRhHfwgHO4B0bw4IzavzA=;
        b=NrMKbWbZ77nT0GpvdIZxI+bqV6A0VHTl1ZuebjmNh/R2v5Cu66kGy2PPgOTbJ5vcDC
         VVJLmPjcG0GrGV0cuMIGAyWfOTYulLx1TuGDg3yN3FXtnbNwu4qqyIHGAP/8i/zFXTJ3
         QyW4OPYj+YSCgB7jY0oPWN+vePCTeaukpGWqOGQ1Ql8joEs00BrbUongeCKqIsbZbki9
         8CvZng5Ga1Yn4yiPULCPKV8J5RzgEuSEj09R4+pOwLTimHC58Vnh2N68SAJZ5AKpFkPg
         5Kqf2SQUFNrqJVjqcO5rfoj8GRQnSAbO9KHknmfFTcCfH153tMLQVAOrQuZxr8BpYYg2
         +XQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698218936; x=1698823736;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rj2UZ1DerP02Kvz7nBD2BYMRhHfwgHO4B0bw4IzavzA=;
        b=hpBsOUpTHo21cNjHKJb2MZETxBDluw7055Z800oi4x5piN0WdEtbEp/tdE+5TX4jbL
         6m3/B70cLZ4hWfUgHJaysagcS4J/7h1CMAB1MT7ITy/CTM7hGy+kiNPO5H3u5yDHb/U/
         koGHhnUxKTZS331bWGFysPUuyG4dEZy9LuhBBTsmMr2CK9iAvOw26h5AEexzm1yMNzhr
         uzHJFzLY8Hzub/v1Q9DSOwdhBPG+7oN7jMjaomLSHpIWvKDkz9jt+aKsFCYv3ipfL5Kb
         deRQN8OBp1aP8sAoJgbsHbKhYjwc7h5AAN8oVJmTkOQDCtxkmGEeKhlsfanYUs8nVtBG
         RNNQ==
X-Gm-Message-State: AOJu0Yy/dY9MKNX4deG8ayt4LEZY+i0Ds9BKl89CkjUyX+d4XfVovrgo
        LlUAgKlFYMwBm4J7DMplkzjb5w==
X-Google-Smtp-Source: AGHT+IGC4jpkT6X4I1gXb80yuzb3uOWZzg6EozqrJLlPAkboFymFgdbdJQS1JFZR4oDSSUu3HDhldg==
X-Received: by 2002:a05:651c:1991:b0:2c5:13e8:e6dc with SMTP id bx17-20020a05651c199100b002c513e8e6dcmr12371522ljb.31.1698218936533;
        Wed, 25 Oct 2023 00:28:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003fe1fe56202sm13947883wmq.33.2023.10.25.00.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:28:56 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:28:54 +0200
Subject: [PATCH] dt-bindings: crypto: qcom,prng: document SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-rng-v1-1-6b6a020e3441@linaro.org>
X-B4-Tracking: v=1; b=H4sIALXDOGUC/x3NwQrCMAyA4VcZORtoNyzOVxEPtYk1h2UlmSKMv
 bvF43f5/x2cTdjhOuxg/BGXVTviaYDyyloZhbphDOMUQ0y4rU0K+nJJ54Dv5ptxXvAhSqLV0bT
 iTDNNnHLhSNBDzfgp3//kdj+OH1/iT5l0AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Vaz65RGdAS7lWIJwTzD14uUdUy5+Qch7iLWH1bBWhzU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMO3yaX+HJC0OAoNGGynPnC3QQcA2q5+EUpiaLLQ
 e2wfBEeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjDtwAKCRB33NvayMhJ0W5bD/
 9kTl2IIbKewGtplayNMtMqODqcn6mAZuefSBY+38pZAA2SDf1CLtXvTFnK9C4d30nd/Y/+fjXqY/4V
 eJS/wzFJtaWtsFSY8xvJXJ0JZsFWT64aE8ZI3UuOzjbqnEmQ6MZ/+bBJBOxHJicSm0cyQya1J9iRO7
 iEPyLAmjJjc8pxBr5cf7RHwfv9IZGs7I/CPub/EHwgBrydrWD20aMUisXjDEWQYsYLzPXnlFStULit
 OM7sXOsnjusXKADU7hhX8Bm54H2fPKZXdTdWyR0q6dQ8hyXQvWzR18QVJCY1386zUZG8RvvQ8YpSGd
 Begg25ebmhUjQlk230yil3Y2EktpDNwyPBGVwJITQDHz3n+vYTh2+rIGbOvaa7eNBF72XlyY3Dx7HT
 jZ8voZKmNkY/skFj8CPcd3qVB/dZxw0VF1z60rAGyhUyivl/LXoRxeKE0anRS45NrnCmX0iZ6w6HfK
 lOVDk6LsgIPrF4ioq75byU2o6UgHrAsAiMEzL6XOQRHT6gzH/JuYhr24Omq4c9h5LNJpbCwOP/SMkO
 4jOgXjam7BdFWukJA2AHjr9JkZSWjpXWdU1BXT27jM33ukAaHcVU0zjG7sdymbXH3MlBoxxXTrfrlV
 Hyd06i3Rex8kxgWo8jRxjfnjwi0f1/Kv7oypA9k3ObE2CCj9612tPuoCFb/A==
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

Document SM8650 compatible for the True Random Number Generator.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index 633993f801c6..fdfa61a508d2 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -19,6 +19,7 @@ properties:
           - enum:
               - qcom,sm8450-trng
               - qcom,sm8550-trng
+              - qcom,sm8650-trng
           - const: qcom,trng
 
   reg:

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-rng-9d9d3e6ace1d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

