Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3417783CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjHVJ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbjHVJ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:27:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED73F1A5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:27:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fee5ddc23eso28603075e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692696460; x=1693301260;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj6YDqEmJFxlDCYwFjQm+tlJhG5zQx6RDzzZXcXA+Ik=;
        b=eLpAt6XFcYBTtAB0Xldcl9vbJ0GRIwZOxfgRmnR2VCVvdYLz+FFCcW81o6XMBQgO09
         UB3GI5I41xKxnvEY/qW78AEj2lF91MR7pP3WNcqKs73hFJgLEMv2GywrkV+A7KQRLGfa
         zFfJW2RFmxBUA7/4CjiIvbE4jJZ1sxdYUBj3GFv6D8WcowCPqeVFhivpkVarVIHXvo72
         DLtDiNsxtz0zFpaw/n6g/YfefQ4Jf8XF0nadpbR9DzuFC4v4jBKN64iShIjpyPSYCZ7f
         ++eYglogDUBbSInWpZly7bR2BcJckt9aGRFX2yDK48LMwckZbQJ2+SIwwUyhLC++fFW2
         chPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692696460; x=1693301260;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gj6YDqEmJFxlDCYwFjQm+tlJhG5zQx6RDzzZXcXA+Ik=;
        b=h1cj9A1utFCa8MO5wAntOnrycnH9R+gae9LWUy4h6EpSlnrFRO5O+iE66mCY3MCumM
         c8uGHFrWO2mQ7/hk9ZRJO+YCAldhWyoI0zifZmtw7w4j8ClDnu6AlJwTLJMCOvZXWHWf
         CeSeKXrQAKIAWkIoKrg6HJGaGCOU6kS9cpwLzV3PooeRdbDPhHiL+khq7UFHnAirb5fb
         lG66hXw3lmBCBhkca2Ni1wrNKinA+5x1T+pMN56h7tD98gJLOHCenDxbMrxNx9jEMmh9
         dGqwT4u/xxza9EY+TTNv1WDfbez1ZctSfsAI46U71zM3YpWHjjP3l1W71aA9pzJG3/XI
         9Ryg==
X-Gm-Message-State: AOJu0YzHaPLFaSvTxEOJ/hz9DO17PqjMPPonAZlRCuW9tYxWV8MyZ9ED
        bU+8zu7zMvvMpvBz3O9zivRKkQ==
X-Google-Smtp-Source: AGHT+IGJx541TMwgMIPRY0Wk4ehe7vKuqAc4iq8OjG5/XVD35L5gHoDk2x62N1GBoCM36nd8+RGyYQ==
X-Received: by 2002:a05:6000:234:b0:317:6623:e33f with SMTP id l20-20020a056000023400b003176623e33fmr8043510wrz.14.1692696460381;
        Tue, 22 Aug 2023 02:27:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d638e000000b0031ae2a7adb5sm14746091wru.85.2023.08.22.02.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 02:27:39 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 22 Aug 2023 11:27:37 +0200
Subject: [PATCH] dt-bindings: regulator: qcom,rpmh-regulator: allow i and j
 as RPMh resource name suffix
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-topic-sm8x50-upstream-rpmh-regulator-suffix-v1-1-23fda17f81f7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIh/5GQC/x2NQQrCMBAAv1L27EJcCbR+RTzUuGkXTBN2EymU/
 t3gceYwc4CxChvchwOUv2KStw7XywBhnbeFUd6dgRzd3EiENRcJaGncvcNWrCrPCbWkFZWX9pl
 rVrQWo+xIU6SJKPqXD9CLRbnr/+3xPM8feFFNIn0AAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6jcszLXeVQ9QQyGq+cnphMr3iteKd4Jca12wTycwDeA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk5H+KCGr8PSuxxtdXxCz1N09WuzDU/fvA/dH8UQwH
 Nxlf1iaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOR/igAKCRB33NvayMhJ0RfuD/
 9XEheyKZhB1J5PRohKaAv4CXDR9yw3LSYm97EQdDRQAUun825O7hd2Z9Xl/zQ+2Ub0mDOFoQ5EK26s
 rwtcJWgVPxRsYKhrGWGa1dNf384yhclzhqySTQ321gSLOb302VZ4YdcluntXOFDjaN//GDjc0djNIe
 RSn25UKb8DIJnlhk8FMQc+5Itl5mqJktSf7f6dRyP2qtq49EHs5W6pQ73wLaZjcTd6ndDR3tyQsrRC
 +7vk0ggZ+4IhE6LUJeHDg1HJmQM4DH8uRap1s45liQ+hWz/I/xMvixJxC+2hWbvsS47AlFIVgapZ7T
 2ys0/myk3i0dkoVVEgF8YPeNO+peSVmw/VAopzEpSguaIH9y9kwueuzAN5m2+kwZ+3aW9rP8mwpU4B
 IbDP67Do+5pGtLooM4PVQ0y06CRd1KMuahDTJCsonpbQcZ8BHhzK4nlE3/9ceerKjBcVbvpHQ49H1k
 +GbA+YjCDF3L0RrjWdbsUZ1JIARtU7aBEhLyBv0RoeQNioFTlrxVbBxZUkyTHY2Tbdo5ahtPm/Wwzv
 9BzylH1Ll/nNqFuDlaJfsuTwSdxWF4+Zes9jSGmW/O6kbdH3zjEnQ/kzHg2xzEOcNrTXoDBeRKBmEX
 UBw5k1o80im4TMZ0eIqWKAy3M7b4n5w4f7ByH3heKFmynWx/ehukGosBA5Bw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "i" and "j" to the allowed subffix list as they can be used as RPMh
resource name suffixes on new platforms.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index e758093365bc..7afffdb91581 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -92,7 +92,7 @@ properties:
         RPMh resource name suffix used for the regulators found
         on this PMIC.
     $ref: /schemas/types.yaml#/definitions/string
-    enum: [a, b, c, d, e, f, g, h, k]
+    enum: [a, b, c, d, e, f, g, h, i, j, k]
 
   qcom,always-wait-for-ack:
     description: |

---
base-commit: 28c736b0e92e11bfe2b9997688213dc43cb22182
change-id: 20230822-topic-sm8x50-upstream-rpmh-regulator-suffix-29f2922f5b5c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

