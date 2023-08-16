Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8078277DBC1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbjHPIHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242738AbjHPIGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:06:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDD326BE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:06:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso5485992f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692173211; x=1692778011;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JEScRVk2p7TCkzthmHvScXKkSivAXxQZS8rbl/NgHlY=;
        b=R7A+bMPMMMd+VokhgnlbmXQjAey6gG3sUo5oNPRK+tIgnBoY2X6woZrZY+9pIohQfF
         nmZngXvQyTOHDZUTmqqUTurltM2C0y95c18yeCz+f62ejpKHMYLfpKG2naLmdsCbOw1A
         8skaxm5RWgXJz46mHurQ6N2i9YRnn2zj5VrQ1iQs2yLC8xZL9ch3/yliFwMAoOFGkefl
         mIL7Qm/mPsbUlyEtJyiFRp4zs4/6aOiOxPoc1YYm5vHhnNQZaAQLS8aJxtJm3+DJA4Nk
         JMjlhcPqpAzVyrrvSyaHuhqWP9dfSMqiHxg3OzPVdI5nZZFCeLt+a3HiBYRXTpIDUUcQ
         G3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173211; x=1692778011;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEScRVk2p7TCkzthmHvScXKkSivAXxQZS8rbl/NgHlY=;
        b=ZE+ZIbb+P7eRTZUXOjszy9Vej4yr7nsMwjfIUy7qPprd4JnEz043qWzjzXgoSDhYZo
         7b7NiejTX8EJqk1iA3vHh1SZtjrDeDtGYSoFdGKE8AZlEUBtgenMREHyaPrXslodA6aK
         6K833iwIyqKxbuqlQehnh2PjkwWWoA1wa2xyF7E93m3Nb+zXQvSLynAYyDiRO+frVwc4
         N1dMRD4vhxz1JWFGQEnbVOsuwhvvH2hW3Vvq4d9gWNKa6JZvt2d20UFX7aCFGZWsAwVQ
         PsajOE02FaHyDjt5Rqi9gwigbMSnBKmmWxGJJAnOiuFtceMoOgap+e/MY1G2DUZXDSWf
         oHAA==
X-Gm-Message-State: AOJu0Yxiv3ofKfg8dnKsUP2b8LC42affUrrBBuIk4OR4NyHmu1Hy9i72
        sD/sUb8JpEM4+q5/W1i2XXmjug==
X-Google-Smtp-Source: AGHT+IFPmUXB4tJPw9TGc+c9MuPhyglV11opsGx1lwF/m+2dSp1eWuzkA+hkA6/atgxQPR5aF3oK1A==
X-Received: by 2002:a5d:45c1:0:b0:314:1b36:f440 with SMTP id b1-20020a5d45c1000000b003141b36f440mr739436wrs.70.1692173209793;
        Wed, 16 Aug 2023 01:06:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x5-20020adfdcc5000000b00317878d83c6sm20430428wrm.72.2023.08.16.01.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 01:06:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/3] Bluetooth: qca: enable WCN7850 support
Date:   Wed, 16 Aug 2023 10:06:45 +0200
Message-Id: <20230816-topic-sm8550-upstream-bt-v4-0-2ea2212719f6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJWD3GQC/43OTQrCMBAF4KtI1o5M/troynuIizRNbaAmJalFk
 d7d0Y2IIC7fg/ne3FnxOfjCdqs7y34OJaRIQa1XzPU2njyEljITKCRWAmFKY3BQzkZrhMtYpuz
 tGZoJ2s4pibrbOq4YnTe2eGiyja4nIF6Ggcox+y5cX3uHI+U+lCnl22t+5s/2j6WZA4KqhdGV6
 oypxX4I0ea0SfnEnuos/pUESVvTICrZSm7VlyTfkkH5Q5IkVaZWlmuk18yHtCzLA/4ALS9qAQA
 A
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HpliNodIkJkO7BfM8VD9wzTxvJGh7BpxG+eVr4WWBZ0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk3IOX5iBmi6+J5FmBpVEMuboBu6ZKGjJO6WcJS3W8
 mv5u61GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZNyDlwAKCRB33NvayMhJ0e2+EA
 CtYCVPI+CcDW00b1mzvsOvGphdKea1moRVXYfJxvuipJ4is7bMg/G1AKrvi6fgxz4oNMSuTD9ITSHY
 4T0Fy8KYoWUlGfj92OHZIK4jl1TPVzS9nLmqSxXceHu8ptMZ558tXQNLWNDLnyAVPW5cUKz0Kj1jkz
 rlf4BJMtnJ9TGd3CYfWtY3hmwGz5Aa9luc4Qxh9KLVNPOIFsaVNJYENQuxkRGm9C+FDjE0KsXnjW0I
 2pbO7mNWBwyYod/C/XGcrAo+NklOJeyhgropv0QlXXYc/U7qHwbGrFmLZqU2OU+MaT8wtnzQDyhtbu
 kolnzEVDmH2G3o4sSeWhxU7uYus8DWui3cXak3c6Pqmn2HZiOhU6xEExy7EDPxn7xcwBbTC6zN+Zfp
 ps2O7plcEHn5Hmz3GB+9HGsy+OHYBbjyTDswOqYUJjVfVqJ9F5i/+iv1zT6dXVtQovXZSPm98r/ubt
 S8YVX/8F4Ibnc4su+x4qhyLD5eYeCGi/uGB4qiF4321k5fEJd6lwuUCsmndD6zs+tXsK6K+sds41V5
 cpEfKkjxonYeqv8FFvZ9F/9RhinwHNMUuly6KuRTCBYjQ/1SSmBdy37eKBfrvdyPRUCuZR19R944G+
 9nn1qdSIqCEt3NX7y+HkTS7nUcdfq4ldFE0WSUzc2bzAYs7a4Lz+l8i5q4FQ==
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

This serie enables WCN7850 on the Qualcomm SM8550 QRD
reference platform.

The WCN7850 is close to the WCN6855 but uses different
firmware names.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- Changes subjects to Bluetooth
- Fixed typo
- Link to v3: https://lore.kernel.org/r/20230803-topic-sm8550-upstream-bt-v3-0-6874a1507288@linaro.org

Changes in v3:
- Rebased on next-20230803 (including WCN3988 changes)
- Dropped DT patches to be sent in a separate serie
- Link to v2: https://lore.kernel.org/r/20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org

Changes in v2:
- Convert if/else and qca_is_*() macros by switch/case to simplify adding now BT SoCs
- Add bindings reviewed-by
- Link to v1: https://lore.kernel.org/r/20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org

---
Neil Armstrong (3):
      dt-bindings: net: bluetooth: qualcomm: document WCN7850 chipset
      Bluetooth: qca: use switch case for soc type behavior
      Bluetooth: qca: add support for WCN7850

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  23 ++
 drivers/bluetooth/btqca.c                          |  97 +++++---
 drivers/bluetooth/btqca.h                          |  37 +--
 drivers/bluetooth/hci_qca.c                        | 264 ++++++++++++++++-----
 4 files changed, 300 insertions(+), 121 deletions(-)
---
base-commit: ef66bf8aeb91fd331cf8f5dca8f9d7bca9ab2849
change-id: 20230620-topic-sm8550-upstream-bt-dfc4305f9c14

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

