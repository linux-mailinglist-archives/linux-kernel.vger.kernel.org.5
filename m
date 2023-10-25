Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD8A7D62A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjJYH3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjJYH3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:29:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6A6AF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:29:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso2875145e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698218959; x=1698823759; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bGkZEVofczS00OVbiU+3nKDBd5cVGRM1njkdSQF25p4=;
        b=df93vjQljmOxHz38t45Z09IvIKL08nidOTRyxcTMDqw7qGesmcS2L96MmDmcH8kgMo
         qrsqHVozrQmFYoKScaATw5YyjfVli2br9KXV3QetY6Npv/ZjXcX936hB4TE97fcDYYDH
         lJWGDUCYCWKmk+uiOvN+Fq3DN57zQOvY3+rbpUNm0Wn3pNXLET7/4WmdraPaKNXoikXG
         XqNESHJgH7x+mS03bWqn0vAejGj2NHuzBBslaM/Bq/5vQjGLrZci9KOI+O7CStlSwURj
         Cl3onr+O3Wrl63HpBQkgYhIkdepKb9toCFKwr9dVcvd1nSTrlGUrhMp/qSaP+BD4wWTa
         hdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698218959; x=1698823759;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGkZEVofczS00OVbiU+3nKDBd5cVGRM1njkdSQF25p4=;
        b=pVlEKoT3MKQZ9oR+Xxb2AvVmsRyz0RThMblSDsDp9pGfxta0QICGFtajIt7QL4bA0H
         jomTr235Y5qekgEjDlsktMq4ndCjmZNYILPqiyNmGCDyXG25IkK0uT4UlXazuG5Kfs0k
         0MiWj4yFVAVE1XqBYe1wwhyHt91hA4htz0vcpxod7x4T6LKS+dyAwEER4fBF4OVT/uCP
         oOcsj4arBtgw8cRxWWBf75yeVHKlbiqhjmqjvKqCVSRxw4hGblMo36koD67ahf9DsvDd
         3Dh/+n3DWtTgUGVM3SVaArzfklHZ+BTEaHme2tfL1KAyYz0tdbZFzeeVsnx28cK230JI
         5sOQ==
X-Gm-Message-State: AOJu0YwknSD5dzrbYpXhg7ZMqhdXxi5mTryfGmDpikJXofORxhuur2zc
        iT9jpnCTJi9Wrn0BVMWgcMxNMA==
X-Google-Smtp-Source: AGHT+IH2hNdQ1mwBdHghRFm47/JhjC+0ygXvrVXX4caAZU6TA1RybWWsfi9izaV9K5xyLKVT7ZIPcQ==
X-Received: by 2002:adf:c041:0:b0:31f:fc9a:a03 with SMTP id c1-20020adfc041000000b0031ffc9a0a03mr15215333wrf.20.1698218959506;
        Wed, 25 Oct 2023 00:29:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r4-20020adff704000000b0032d88e370basm11481696wrp.34.2023.10.25.00.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:29:19 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:29:17 +0200
Subject: [PATCH] dt-bindings: firmware: qcom,scm: document SM8560 SCM
 Firmware Interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-scm-v1-1-f687b5aa3c9e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMzDOGUC/x3NQQqEMAxA0atI1gbajop6FZmFtqlm0VoaHQbEu
 1tcvs3/FwhlJoGxuiDTj4X3WKDrCuw2x5WQXTEYZT5a6Q6PPbFFCX3XKjyTHJnmgAtHx3EVFBv
 QNI31bjA9+RZKKGXy/H8n0/e+HzhuFW90AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4wto6rFmvdSry3CQyqy8qgRLvFLNNNL9cs4BEfysmgo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMPOYHMbKO+5nMtWnDQqnQVL57gJHFbyGieGZX0j
 XC1y7jKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjDzgAKCRB33NvayMhJ0TWVD/
 9dD0HW+fTCJGB2eBQVoOXhbSyLESpJlQR/By07Gk1cixI6X5TdEJOmWYZa+Ec6QHM3LMzcEFsSGrrI
 1rCm6x4oZv1hBHLeKagaAHbRSWr09CyC91aw+ej2OOZuEB+xs0M7/yTxAok+WPKsu5Yo0isCa1zEbx
 e3udOXThmDQLebZEsAXyxsItprbx/+TPP8ULl0a006eQptYpO1Wds5v2j9YsnLqneE+aZX/tRZDxDo
 OBh9F7ds75bGW5BKdTktySsTZkM++TSTTW/SYAXRzh6nT3nHp3fTsujlU/e1S4QTTFJWOjPI32Tjnp
 WYvvtZRFhZG9gfslNr367tLHDReZnfu25fOg25461v/EMeV3KwgJo8lKB3vsNQHpE1AvsBEK7JVKX8
 Wn0VQWhdUqzrcSkmj/NG5yeruemRDNz9ZHj2kBK+buO9ydwqXL2uE+FGloHCrqPAX4paHYt6r1SjyV
 vjzm53PSsWNBVxbDpKYhIs4SyFyBDNUKUGhrOaqlypeLuNvP3C9b/9sh1jyzmcSY2aVGWErJiaCxyd
 4BpsjRUs5Rg3taT/Knwmk0T/7MS/9b/t7z7nYR3lzAcpGgO4sn3dcEOF4mLPwFEY7cBF7hnF5mSkso
 19Nj3htpB+A1Gc5ntQrIUKM0CJAacRhA7tPwfmp/DEzoRlpQ04sdluaaGM6g==
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

Document the SCM Firmware Interface on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 0613a37a851a..3212c8b30ed9 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -63,6 +63,7 @@ properties:
           - qcom,scm-sm8350
           - qcom,scm-sm8450
           - qcom,scm-sm8550
+          - qcom,scm-sm8650
           - qcom,scm-qcs404
       - const: qcom,scm
 
@@ -189,6 +190,7 @@ allOf:
                 - qcom,scm-sc8280xp
                 - qcom,scm-sm8450
                 - qcom,scm-sm8550
+                - qcom,scm-sm8650
     then:
       properties:
         interconnects: false
@@ -202,6 +204,7 @@ allOf:
               enum:
                 - qcom,scm-sm8450
                 - qcom,scm-sm8550
+                - qcom,scm-sm8650
     then:
       properties:
         interrupts: false

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-scm-244cfd928ef5

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

