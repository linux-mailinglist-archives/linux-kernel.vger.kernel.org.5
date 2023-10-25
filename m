Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565AA7D64F9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjJYI0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjJYIZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:25:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDD11AB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:25:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so3123475e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698222351; x=1698827151; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aiqLs+3J8ocbMk/USKLhzS0VZ0dnUDi87OArXxCKu9I=;
        b=ae6SPT/ahDNGoCCzLyaRCoO1ly+U/yMUw3xs62NvHF6BrGJCIYhZW2enQDNouqg59c
         STJ2eQttTgrlXZHj6q5zLzo2cgqtGYOsb8SrLgj7b8NixZ8iew2cZl4kLUVzbFci7u9H
         vSINPGk+xWXC28xeuhi6Mokbq8/PJIhBEvz+OCeFC/tUg/hvleiRnEW+xsPAeCqsu0FA
         B54PdPaVj+yVfcSwFQRJMNdxYlQzBmrq8RYjJV+alIYozOVvmZoYV32+6uU5OCPduvnU
         Lv80oRq1q2tCERkd1PX6yEqe0+6H6u4MGKNblw+WXYEOJzcLe/lDSndyq+AUkklstFS1
         XiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698222351; x=1698827151;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiqLs+3J8ocbMk/USKLhzS0VZ0dnUDi87OArXxCKu9I=;
        b=dowa+DuhdrZMRYUK/jlt4yrojVf1JzLFUxmrFobVv3eGxe6YRw1A2MUvxASx+Calny
         0DmCNKIKq8zG5nw/F9aF/FBfbf4GhmXKRUm43oUM385xtHQwYAIu1fTG7Md2rIAwzHku
         ESbUFacsBnGnV5Yjz8ozGq0ZeMzh8HA6j21LiL5IBZNR0AJwpFpgeNyup+6u3yipMAA6
         7EwdJ3WcZ9N1PYCC82RQhCLaAb4XKX6zJNowUSj+wCE0uyaQYsQMrUJWT5ZB9h0HYr4Y
         YjVXhoS9sTJDiJraqanp2NdCj9NEBG3i2Hk8FcnGm2Mvmt1Ci3sceAh5HgQadcFC1dPR
         2XlA==
X-Gm-Message-State: AOJu0Yw/iuDulX3ptS5fkKeLkAeYFl8O79RVazdw5DMV9V10yASmH+C0
        YZB0WTw2LieoZdSD3Y4xIg5oIw==
X-Google-Smtp-Source: AGHT+IEi2BjEfe4yJYq061IxNTMQpM2ahhlufXypcgsDDRHR1BglE83aON7CdQqH9o2yY0qDiN8acw==
X-Received: by 2002:a05:600c:b4d:b0:408:33ba:569a with SMTP id k13-20020a05600c0b4d00b0040833ba569amr18364282wmr.8.1698222351375;
        Wed, 25 Oct 2023 01:25:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c130e00b0040772934b12sm18473467wmf.7.2023.10.25.01.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:25:50 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 10:25:47 +0200
Subject: [PATCH v2] dt-bindings: mailbox: qcom-ipcc: document the SM8650
 Inter-Processor Communication Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-ipcc-v2-1-b1a4670ed6fa@linaro.org>
X-B4-Tracking: v=1; b=H4sIAArROGUC/42NSw6CMBBAr0Jm7ZhO+QRdeQ/DopQRJtG2aZFoC
 He3Eg/g8r3FeyskjsIJzsUKkRdJ4l0GfSjATsaNjDJkBq10SYoanH0Qi+nRNrXCZ0hzZPPAXtw
 gbkwowVpUfcV00hWzbiGXQuSbvPbLtcs8SZp9fO/Thb7219f1X/2FkNBYa6qS2kE1fLmLM9Eff
 Ryh27btA8FxwmLXAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=0PrADmM9pW58GSAafxMnkqLRaQh4TRNl79Py82x9/OY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlONENlpNBhAxj66NUXtzE0TNkFnDmb+y5gacLK55l
 h91n12GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjRDQAKCRB33NvayMhJ0fwID/
 9wQhgQULh6+c5xAUA9DNlfrh6drHxSb+qOu27GhcitqZFqX+TAW9tO7i7tG8myvkZ5cWCNgeE6EOBj
 Rm6A853hEh1eXLo5Xh+204OFjYVnPjNF+9LWIikwEPAXW9moCPi7YKUh9K5pnR5VIFh1vNDAkcO+BP
 I0PQeIg6QbEoGaHRO+kol7G63jQeXjwVbwDYfhhP2jgVCmtzFOyz+NDW2tdB/hnp16ZOvvHqROutxP
 UfNiEUC/kmnI9YgdP/tIxjggd8LcCqVpd/oUlmcnn/9Vzs8+RLgu9wde9aC5wXVB9RmKtA81kL2qE9
 FCFt5EYZfgGfZVdLUhnfkKJ54ICoorqLeBB8iNVe7LSF0m/T/wOtaeWx/XrYe39ONG7JfrQL3t9Phy
 IyVz/Vh0EASrCFhNUT6vroALv+wD6KPE2ebUpbswVIBYiQgW+cPQ2GDBsQz9l1oJb6VuVWYQJ4Uv3s
 t4QVsSVVYMEXoYldtQioPjdL2sQ7zRTg7kq0wv44a+AUBP9+rhYY7NiN7OLuZ3rhM7e70xSAe8kSEt
 3QrE1D1bxhRb+jZMCz99eh77RkrPa3F/zUNSTaioSRbOtsiIghAm1YktGBoWDJME77QtU6bbdEAUtc
 KAF1A5kBzcd3M/NBorZ38G4HOlhHAnNX7X3yLuHR6xtDP9dPQU5PjizCX0Pw==
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

Document the Inter-Processor Communication Controller on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
Changes in v2:
- Fixed typo in subject
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-ipcc-v1-1-acca4318d06e@linaro.org
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index cc6f66eccc84..a35f9483dc71 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -34,6 +34,7 @@ properties:
           - qcom,sm8350-ipcc
           - qcom,sm8450-ipcc
           - qcom,sm8550-ipcc
+          - qcom,sm8650-ipcc
       - const: qcom,ipcc
 
   reg:

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-ipcc-0b4e1924ee28

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

