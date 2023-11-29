Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC01C7FDE43
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjK2RXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjK2RW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:22:58 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F15D48
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:23:02 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9bd3557cfso451981fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701278580; x=1701883380; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eXGa7bSQ7Dh/xlQXLCiIqwu0jh+a/kOUDdTadTRA+es=;
        b=r+B9JsFdYGBjOCf8BqSiXLTtenNm/p1/pq1JZUQgBpOwB1/apGPJ329/w1QSa7VXSr
         p3T6bobV+6AlysWg1j7c4SN9g4yyIvfTQFvtf6MS/qRQWuvqPEb+g3a4nim4CURRjT9h
         A6reZzYWTBgocERYDzWWuEXrH+GfvkczuTI0vAaQncmSTtiaX3ifYrqxCqL1SeOha9U6
         1/25W5diffZtAWUDL3L9dVQVSQ4GIKSK9VbbwdDSs4PgUw3c2znFNwBmGsAOTITONIkG
         W+ZSh0YZG/9QhFognNoOWMwFdPwxrAzwNzAk51gHfqL071W9E0MiKuqTUrk1SgjFMKwy
         8tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701278580; x=1701883380;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXGa7bSQ7Dh/xlQXLCiIqwu0jh+a/kOUDdTadTRA+es=;
        b=cul5LJP8bmSHlp0zOTuQQ5HBoziNtj7c/l9tZC9dwCmuMGfxvX2JwWbkxykb2LfzBT
         bjvC4JgWEYLo9//y1NoWsdaLY4pP9a2Pivmvkm6aHvvf0Y7JDqhtw62W+BPC/76cS1c6
         5fYSuHHolHzPpJr95GS4LB+/H9X+3CD0nd8HXgXJAKSEqKAwKRdz0Dmp6en5s/xf+8pr
         lgAL6Oae5KmN4FBa4FCWbT4PIz22z6bd1q+1cll5/NPyAqtLjRtt9I+L27LZxPqOh1OU
         Ty5uJDpwLL7vqbxsVE7KSZ7bStyLxkgqiChPn2PAtZ1Lx9HACwEzZ7TzbrzvpFrJCzZt
         QCpg==
X-Gm-Message-State: AOJu0YwCCDkTr1iZ/eZCWA28AXD3z4CuvIEld8Q6v9nJn6XeeFOKtOjc
        zvUS5Cry7h02BWv6y8IW5tlUOg==
X-Google-Smtp-Source: AGHT+IER6Cl/d4MD6OqgkdQAg6vEXVoVK4JZglhzHg1miJp531LLd3j1a3CQTenCK62R+I3/U7Wsrg==
X-Received: by 2002:a2e:9f4f:0:b0:2c9:c348:5260 with SMTP id v15-20020a2e9f4f000000b002c9c3485260mr1161607ljk.38.1701278580319;
        Wed, 29 Nov 2023 09:23:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c198d00b003feea62440bsm2856049wmq.43.2023.11.29.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 09:22:59 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 29 Nov 2023 18:22:58 +0100
Subject: [PATCH] dt-bindings: net: qcom,ipa: document SM8650 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-topic-sm8650-upstream-bindings-ipa-v1-1-ca21eb2dfb14@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHFzZ2UC/x2NwQqDMBAFf0X23IUkpTHtrxQPUbf6DsaQVSmI/
 97Q48Awc5JKgSi9mpOKHFCsqYK9NTTMMU3CGCuTM+5urXvytmYMrEvwD8N71q1IXLhHGpEmZeT
 IoYqt8d4G11MN5SIffP+Td3ddP9S85fl0AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=o8xig82rjh29g1YR2tft59ttywpVEwUjXy7a6/IvzCM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlZ3Ny0bIaIeooNeuKZ+WAH6b+yziEKCVtfUICSjS9
 KRh4jaOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWdzcgAKCRB33NvayMhJ0eiKEA
 DIpsOR5nkaKqMbLKxrWVZV+kEvwH79DS56mRxH9P/6G7lafLyG+rpCMoO7Do0eGM7sd5OSXJTcNd25
 hMAzBC2jODUzkJmOOM57TKgjLGgVlFomj2oiytfaPHxsOL7YTsTiWhrL/BvL3ifgjYKmNMDRCoQbdj
 7YeA8G+RrYvnmI+IlGHdWh6PKJPz3kttihu9bbfg/vGgvELK0lGr+JjSRD/4bFHT7rwzcr3anP3zPq
 DOEMsksoz5sPNks5o6YKfHP6ROs207N2XeoDHpy1O6E9kpK1wNoawVhW4dUX2Sp39NQdIFjEVW1J1z
 My1C0ZuGcFKiTr5UMncjg/2ncBrXN1Cnc6tGPmByBRbxWDDgL4wIUmDAXqwtphOLmEoQluoUoXAlXh
 /7JGHFirqMHY4UyAoLHFxXIC2iKYeRffn3akBA3RIi7+c+/bIWHoDNIIZPQIrPcZsOHEfNd1NhcxIi
 RFlHk34QU07x/loeOYTzJHYEbRmARiJHWI0lGiGB0OO+kcTTzxhAot9TBWrLaSzW9ng/7N/sXLW3X1
 zV32dVXoxpd+nHVtbRTV97DccF9fA1Q065FCXOrIpmzxcsfYPQ7QY4ynGekhcpl7o/G3k3ed0iYOBb
 KXdjE3uk2P4XyzALw+bSkV6/LHRjIvikLfbuloykIwdMFqilRUqetrsdFsPg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the IPA on the SM8650 Platform which uses version 5.5.1,
which is a minor revision of v5.5 found on SM8550, thus we can
use the SM8550 bindings as fallback since it shares the same
register mappings.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/net/qcom,ipa.yaml          | 25 +++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 702eadccdf99..c30218684cfe 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -43,16 +43,21 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,msm8998-ipa
-      - qcom,sc7180-ipa
-      - qcom,sc7280-ipa
-      - qcom,sdm845-ipa
-      - qcom,sdx55-ipa
-      - qcom,sdx65-ipa
-      - qcom,sm6350-ipa
-      - qcom,sm8350-ipa
-      - qcom,sm8550-ipa
+    oneOf:
+      - enum:
+          - qcom,msm8998-ipa
+          - qcom,sc7180-ipa
+          - qcom,sc7280-ipa
+          - qcom,sdm845-ipa
+          - qcom,sdx55-ipa
+          - qcom,sdx65-ipa
+          - qcom,sm6350-ipa
+          - qcom,sm8350-ipa
+          - qcom,sm8550-ipa
+      - items:
+          - enum:
+              - qcom,sm8650-ipa
+          - const: qcom,sm8550-ipa
 
   reg:
     items:

---
base-commit: 48bbaf8b793e0770798519f8ee1ea2908ff0943a
change-id: 20231129-topic-sm8650-upstream-bindings-ipa-81127066182b

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

