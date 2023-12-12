Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0FD80E8FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjLLKYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLKYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:24:20 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C65AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:24:26 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1c8512349dso722749566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702376665; x=1702981465; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XTguM6PQ9T5zh1V2+n3dMiBXy0OpcHUacKeTSRi6+rE=;
        b=GFtDk35MTBHTaJKECIw/cTF7zj5YpXmVpVrDMX+RPFle9bufkxjmVPH2/NeErsIUBW
         DaHK2W1G9onMRngfKO0UYdk88YmnmmRF6PbKVbHOkPxSTwkiNKqp5tiwBENI0jAmu0t/
         FX6pywNXg9qOen+ZC3hDb2wQEspyIMCAVx0b7tYVuyjscTosZgqdukcdVLITyC3I7okv
         AgT5WVg6UkascVaBzPuR9tFu1R4Q7ShWLySgyKZp8AF1Rhs9KeMFgk4nSWQQxSdkwo68
         CwD8qubukvYT7e11UjykgEv3S6vqnVdx0Q1P7Uuuu6BreYnstgueeaqoa7borKqVWKIW
         y3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376665; x=1702981465;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTguM6PQ9T5zh1V2+n3dMiBXy0OpcHUacKeTSRi6+rE=;
        b=XJKkq4yKuKNk1zDdWpnevuf8jYacVvSGDrhmKOsx4kfLxOtl3918BlrmwSQlmxczjr
         Q+EPx+xVm8OrGbNAfRCzH68+t4Cvd53pJvtQa49FC6bTzjF4mo/Fonwa1zfSZF2qemrU
         4m5ogXRlkc2vN13dcT6iFtiOvp9D0NbLO9losGrCphI9nr5K93ulL2E2cPThjl1kEOEg
         q0tycevp1kBaBcfR9H0OsNK80+dEBr1Wx1gxkKzUnI5xtf8QreIc1ul/2hghCyU2PJlL
         qVSKl5U6j5ryE8rnNS+J1NhIA0v96tOZNY+yYy7T80ESfQ5gBltdjTWnN+A+auyLYjts
         +vPg==
X-Gm-Message-State: AOJu0Yzh0fJjx+FtN+2gslIfVoHvuFLSveVJmQLrAnT73HIArYCQKxtz
        SgdqbSZRLOawJsvyO8M0xPEWow==
X-Google-Smtp-Source: AGHT+IHx/LSmsYF58LhEO7TDQMI7uHt13h7X3MrU1QacUVufQHIgFVxLdKGC2BBXQBrKGoil9RkZsA==
X-Received: by 2002:a17:907:76d5:b0:a1c:f745:e0b6 with SMTP id kf21-20020a17090776d500b00a1cf745e0b6mr3496139ejc.61.1702376665375;
        Tue, 12 Dec 2023 02:24:25 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id ga16-20020a1709070c1000b00a1c7f8fe581sm6052801ejc.221.2023.12.12.02.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:24:25 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: Add missing nodes to X1E80100 base
 dtsi and CRD dts
Date:   Tue, 12 Dec 2023 12:24:09 +0200
Message-Id: <20231212-x1e80100-dts-missing-nodes-v1-0-1472efec2b08@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMk0eGUC/z2OwQrCMBBEf6Xk7OJu9GD9FfGQNttmoSaSDaVQ+
 u8mCs7tMbxhdqOchdXcu91kXkUlxQp06swYXJwZxFc2Fu2FLBJsxDckRPBF4SWqEmeIybOCw34
 i9n2LqQODU4YhuziGNjFcz3/5V6VUoCTQwMvShHfmSbbvm8fzOD67Re6PnQAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Nny2t8OlCViPk3BxX9ZWPLYgvvv2FpLQtO2ib/R0FhM=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBleDTQJU5Kc4im338f6d5NP54Ug8Eh0qaNqDo1a
 BgVupvAUACJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXg00AAKCRAbX0TJAJUV
 Vo6NEAC5lHLTOTe/RLAcyhpltJTtZqJA1q6sslx5LDxGjywfLiwov4veC1HQ8MQAEzq91Hvpbz4
 F69Lg3akmmDMtDuvF9f3G2YCf6n6GzRsfByysAtoMK1XzbOHvcnEWGrSbDBEdV5tgZAOIAnLFKW
 3Jkofm+GvXTVdBH+tQB4O9HQeulmySlAWuuN9AF1ThvT7A5LZ/mlORht4HAzEXCzFRXgeiOImqN
 TVIjPIHUnXHtg7hLgisoKc4C38COP8jntxv6wQJX+zEE2Fr8ULb5UtFNYOlAQBOCs4RcDAAXKe1
 d0xacWvx4QCOTBnCxaVKruS0mZw6qWK8+vYt0imK4riT8H4Ayl151fZgetYUfLQlXFoN8D4//QB
 pm2LdnxJCFjDYytW0A7mjRm77tEfB4TxAfpuRChJfrBYX93IqbXbabUiWW2OtkdaL1Dayp3tcZ+
 +W9/r6fKXQ98WD+LKvOVTb9XmTAXJP9UUEOnrLy+2SQyIwn0Fa+cA2Xv/SXWlhge+AXkou2rpvp
 L1Wpg45D9EZE2ENgP1zyPsKrkKazbkbdCCLs0oPIkMNVM4zsHTnSRe3hQosVLpVwmdi1CG/GwD4
 GgtWqetSTH6UZDVVNul/CpIpEYCaAJEaJtLyVb8ca2/w+QuEb7YOD/ZJWmNAbTkjtDeIQb/08NH
 6jjEmu4IXA3i9Mg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds all missing nodes in order to describe the entire
platform. Most of these have dependencies on multimedia clock
controllers and so the entire patchset depends on the clock controllers
patchset:
https://lore.kernel.org/all/20231212-x1e80100-clock-controllers-v1-0-0de1af44dcb3@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (2):
      arm64: dts: qcom: x1e80100: Add all missing nodes
      arm64: dts: qcom: x1e80100: Add missing nodes for CRD

 arch/arm64/boot/dts/qcom/x1e80100-crd.dts |  303 +++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi    | 1282 ++++++++++++++++++++++++++++-
 2 files changed, 1580 insertions(+), 5 deletions(-)
---
base-commit: 10ef05bf74d045c6636bcbaf2cc60aabbda8a54c
change-id: 20231201-x1e80100-dts-missing-nodes-a09f1ed99999

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

