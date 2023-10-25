Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379497D6293
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjJYH2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjJYH22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:28:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D8EDD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:28:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4084de32db5so45105305e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698218905; x=1698823705; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ2oRpaoJhce9I8GPs6HN/A2iLP6BscGnxopX3PgLBM=;
        b=RMfAAfulNGvcxjip3liXEbYW6VGMPpYhK0i00RfK4zZCK2Kxo1E8L5r007nG+t43Ig
         ZaP9QFFJ3BGlfXEEmA28ckUpebTbOvdwYb77rWLgIYywx26DaM+6hiYP+gI6LOHf7oK3
         kYBR/ynzHFeZqoPrywRXIBgKrRn/Y37dsaGEj9LspbRdXhh0KdQGAdShtVfu+dMLnH6J
         JJGNy8wIxtbut+BErM0XWn8E3OfOz3Hw/xfGN8NhzGzmJdSntLoPTTVXKOte6o8APvtF
         KyVetCh5wcLze81nvSBmwnfaYs6dQgvkGHkxe7Xk7l5Z5uhwYQkzf4o8kyVdJ/RcayXr
         em7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698218905; x=1698823705;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJ2oRpaoJhce9I8GPs6HN/A2iLP6BscGnxopX3PgLBM=;
        b=BOjkfeofXQpl5pWp8XKx8AIZ1tDXgt1Je/GSsje2rgwNbVT+g36TC+qRYJnsSR2Ibp
         FOZz1dRcuBoQMeINTUvhsBbJvCE4wYzI5fpqPscGfjR4mI1Edf6pC+2mwlnIbYvO41xm
         wxR0+LRd4wOy1B3XGKvkwi9PXzzAxzmyoCD2nxrQAER1w6lugWbxOoJxcMSRIal6LDSQ
         PB4EFzIeYqYT/K9PeoY5s7LkGK1rSRHnBkVbaxUF8CF/j8TXbCl2o1aE3CYIBrgYEss0
         jwUfAruJoTnK9c1pxdZvHdl/vfmHu3uI5DR9S/KMn04GTZV2a0JFw/HXBW4ShiD6wUwo
         GY9g==
X-Gm-Message-State: AOJu0Yw5louNxjOzbYA74oqP+NwUwvyGnt/Vv1PsQokm/MZ8hpRV7zh+
        dEH5OCn8UPraq1Y3CSngXp/Vwg==
X-Google-Smtp-Source: AGHT+IFor3h+dAr5oQsSJ1vHc/MU2j9muM4tBS5eoWssbySl5NgMcsBNmIBjd7BJk1YIpCgKCjIEkg==
X-Received: by 2002:a05:600c:198a:b0:3fb:a0fc:1ba1 with SMTP id t10-20020a05600c198a00b003fba0fc1ba1mr11964689wmq.35.1698218904902;
        Wed, 25 Oct 2023 00:28:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c320900b0040644e699a0sm18495839wmp.45.2023.10.25.00.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:28:24 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:28:22 +0200
Subject: [PATCH] dt-bindings: crypto: qcom-qce: document the SM8650 crypto
 engine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-qce-v1-1-7e30dba20dbf@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJXDOGUC/x3NMQ6DMAxA0asgz7WUUBGqXqXqYBwXPBDSGBAS4
 u6NOr7l/xNMiorBszmhyK6mS6rwtwZ4ojQKaqyG1rV373zAdcnKaPMjdA63bGsRmnHQFDWNhl8
 W5EDSS6SOB4IaykU+evwnr/d1/QCZifSUdAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=BOUjaS/EmVt+3/Odcqx3EdTXwZy8c1+gLrnQRALTOxs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMOXdANPwSzrGljuoM1hjjOOdVulE+eo81QTVr/y
 j+OOf0iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjDlwAKCRB33NvayMhJ0WqgEA
 CTcnEC2yItqtgysd1O56cU5W92ZUXW86INCYQjp3ThOJ3nLtWb5K2hvzXSBW4ubWFln70So8vEh5LF
 hgZZB3TdAnmNb7NPrSoaCd3U4VpKLEwZwq7VYqMjQFxcONA5s+N1vWw1EM72aml8JRYDAAeFzJJx1c
 vzszHpHFTDRiWP3co7c8NLlSU0WBYemhNCQ+ozyQ9wZU78pVI0Pp2KNE9F3c1D5Zf1Q4XOUJ6LOnq8
 5DmD+pPCnhRKniKxuxPgQ79jJUKJcZvd91B0ICIfvRLke4Skaut7WcBhbN7VHhx+99OXB/rcTVZiS7
 qIBx+l62bWffXp+9lhX+DrOD+3kIRwUvNPQYEl+e+182m53WXwCCgtorWdGXEPISNDAT81evKq983o
 iLkycqxxu3vIPu+Tm2iRvIfSG1PSBrboziwCCZMMANDi8/GVXC2hei9yhSKvIm9YbnzIgYsQtEN6pO
 oF9oCXN/5FL4GOkLZumbu95Np5U1roLXe0796nVvUQJ8Wlb/dXoZ6N0cbx60XiOnGF+i0cjnlbMrKF
 ozKO9GjtX21GBKIo6rWy7X4lBU9GdyISFSFH8rDZp8akS6tUVLHaLzMG+gjd/euckYDPUzbEF5eGLw
 3yV/L+me0mhqnA5imKcj2KN7BFleyf3XTg8u8ipK2TsjFr1uprZjispQgpuw==
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

Document the crypto engine on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index 8e665d910e6e..eeb8a956d7cb 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -48,6 +48,7 @@ properties:
               - qcom,sm8350-qce
               - qcom,sm8450-qce
               - qcom,sm8550-qce
+              - qcom,sm8650-qce
           - const: qcom,sm8150-qce
           - const: qcom,qce
 

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-qce-c6ae7eda5cba

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

