Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FA97D6267
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjJYHYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJYHYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:24:45 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15A0E5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:24:43 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso79302481fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698218682; x=1698823482; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ac9q5i+bRg4eQ6Gru0c2g4ILCIg31t/aQvKt6OAjZY=;
        b=oREKufJokOzWE8uzXLAy+b4Va1F1HBjUiPI5X7KtqPAqqyoK8haUsFQCWwHwqtC2Kt
         szL4b1GDMK9fTQsjjZRIkV0Y+bMxCTVG6lKYrOikY2j0VQ/Sqy05ginSoTFV1NjR8xdo
         kmD7EeMRIRdbi8OtN76PB6lf0l6p5U5bHzCbnzA/51OswW/DIBlpMmwX3D2o/iMBKjKB
         uhNu1WXvxnSaMr7+CVXC0xMushO1jpa/aFmEjixYzEeQVJD3YHyg5Oc/a1H5C5L4Zvxj
         hBO2/hf2BUUSTU4J8DhitfPQD9C0Ij+PMAFGzWN5Q2tyC7G2OPw5zLGfJ4+Wi+7m070x
         cumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698218682; x=1698823482;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ac9q5i+bRg4eQ6Gru0c2g4ILCIg31t/aQvKt6OAjZY=;
        b=V/pDBoMjlqSzAkl3CTAr3InSZuniY250Whu0AoCPCfdNt0rVusgK6rKxhTjNPqr2u0
         icXcnTYjG03YPwkVoOYZmKr1Rbt6D/NmWEsXfwNIjdjVotaG4T5LUyV9rfBIqKmNhAWV
         2lywG+JK1AJzwMo5YmrUryYxv9vKLbCFaqfsUJnZ/VAeqvw2xQn+cHH72lYAPl5Fjh9S
         nJWQz2KQAkTcT8Az3aAcYBVIMm6jX3kKV0mkvJpeM/kemuizh6QutXGD02agjOmDP7uZ
         9wohryPepR5BVnqLFaz+PMxOdDT3tlOSDvy+ts504egIQHXt7nz3Yr0BtbqshsU9Cx4G
         zlGA==
X-Gm-Message-State: AOJu0YwyUMg6TsA2QczDBEBFoTYtjGtA7sk9nE/Gs7+kYOaBY6tT3BVM
        +++5qbxek46AhHQ7gYhzYe9mvA==
X-Google-Smtp-Source: AGHT+IEQlMSO1gYMlKxW+S+AsH15992ahXmDNkzV3J3CmeF0KWZ+MO4rk34Av20fdxIfM+aNgj9Gnw==
X-Received: by 2002:a2e:9613:0:b0:2c2:9810:3677 with SMTP id v19-20020a2e9613000000b002c298103677mr10456563ljh.6.1698218681748;
        Wed, 25 Oct 2023 00:24:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v3-20020a05600c428300b003fee8793911sm13572564wmc.44.2023.10.25.00.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:24:41 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:24:39 +0200
Subject: [PATCH] dt-bindings: interconnect: qcom-bwmon: document SM8650
 BWMONs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-bwmon-v1-1-11efcdd8799e@linaro.org>
X-B4-Tracking: v=1; b=H4sIALbCOGUC/x3NPQ7CMAxA4atUnrGUtCIqXAUxpLFTPORHcQtIV
 e9OxPgt7x2g3IQV7sMBjd+iUnKHvQwQXj6vjELdMJpxssY63EqVgJpmdzW4V90a+4SLZJK8Ki6
 fVDKSj7eJYpidJ+ip2jjK9795PM/zB5u07lp2AAAA
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1712;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hHZucPj04DU1Jj0CKr8lD/Iuz06DdZDfwCz5YPj1tPk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMK4vVhcCGv5tVX83oQt8O4rXRZ51G1S/zZrRqfo
 tIolGluJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjCuAAKCRB33NvayMhJ0eI+EA
 Co1u+PprLooljdG2wZzc9IlfNyGAUUURvCWGrmklMaUXFZq2mK8VN6H1vvyfaqS8YM5cXR9w/dj76G
 znUNFKYFjE++wnL0JlgKgtjOLjyWWwzYRcfIjxbBxHnKqn6aIXt5tRIeQlIW65naWjTuuDQikCRFoi
 KqMwSs6E3ziBHPnpoHXHkFNbmfjFF0tpp5kAVRXGtbRxOPNPQc4XDSGHu/Xz6ixLCngQlMgVhIrcu6
 Sg2TmqWA9mmp/+u07XfkPX4ijZcdxtQo4ctSauqHUdFc1YUAfaTuk7JwHZShZc7HfpapB+/ZqN7jtC
 yyctBqfoJkooiJ0iLQ+p0UK8UyGkHzbDmczT2KFP5b7Yv2tHQwBj8L0VHDUKbx2trXPbjhZ/wCKGmu
 +idTDCSTK5N48Jiib97JvCeGr8mimKbtvtYZUb+qYwnwJskLcTvjIrZqac2GfdrOEh6ZkyRJTyd9ol
 cLvgIQzGGnmQf+LzX1sQYzEVjotkLbbfJA/vr8Ut5n2/oGj5Ow/WEi+wp/oZ8WtmgzxcYY4dLagQmC
 /74KXZsAKj2MeeXOtL/HOz/AM6A0XAVRKvx7d3R8CFAzeqDUSlR5Zceo1Ixvd43r/VrreAUZ13bFqp
 6tmZRaX2iwZibUf7N3QxCMmS8fL/TjBdR2p9aIxY5LfWqVEXeMpt6YFQDVxA==
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

Document SM8650 BWMONs which has - just like SM8550 - a BWMONv4 for
CPU-LLCC and a BWMONv5 for DDR-LLCC paths.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 73f809cdb783..7cb8df757477 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -32,6 +32,7 @@ properties:
               - qcom,sm6350-llcc-bwmon
               - qcom,sm8250-cpu-bwmon
               - qcom,sm8550-cpu-bwmon
+              - qcom,sm8650-cpu-bwmon
           - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
       - items:
           - enum:
@@ -40,6 +41,7 @@ properties:
               - qcom,sm6350-cpu-bwmon
               - qcom,sm8250-llcc-bwmon
               - qcom,sm8550-llcc-bwmon
+              - qcom,sm8650-llcc-bwmon
           - const: qcom,sc7280-llcc-bwmon
       - const: qcom,sc7280-llcc-bwmon   # BWMON v5
       - const: qcom,sdm845-llcc-bwmon   # BWMON v5

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-bwmon-daf93dfc86ad

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

