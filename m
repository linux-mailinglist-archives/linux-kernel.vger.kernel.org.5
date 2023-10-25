Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB34B7D6498
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjJYIKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjJYH6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:58:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9971FC1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:47:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507962561adso7749447e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698220068; x=1698824868; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LIf6kFAZdgHcnEPedK1Ps2aBEEAWZ3C5+iD+Qqkmr8=;
        b=vpSXh7kg23wD8TgPLEYY3PvIDyfHSmIqQyOZu7H2fCSE6d3SEa9SAQ0hbqKfJTOkBS
         jW/TaR6foR30sIR+/4nL4B2qJkKrp1MJL/lcDRvCkfDO0xD9Kap3t1QlYo19hIteH1CS
         Zo615Ck8OhcwVmoH0J0lEEctlGmWETY0iCL9SFqx7to12V4CKvNROc9vOG8y2PMISR2a
         yTmXl+Sqtp0CouWC9lnslPNI3WodnqPSXZe2+T3lJa5BBcPhi0Pt3Wus+hII6emOlzg/
         uQld7P0nht7Q9cTR7Zp4XUTUTjVUKF3FODwN/Ig6Prd1xtLG0vbT/5Dj1NuMpJqilVFA
         DIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698220068; x=1698824868;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LIf6kFAZdgHcnEPedK1Ps2aBEEAWZ3C5+iD+Qqkmr8=;
        b=dFfvty345fu18U0zmMvxtDrABbe7LjSt+6edfDd6UoOEKeiUx0LP0JGA9aN6SmApl8
         GHwcNOArgArM5aMkhsA7UIgI9Zi5qGfI+vCdQ4GS+TzxtKEHnbWER2TzlDvc9JS/N8tv
         i6q1pL+OQZIl5+URNthm2KHQxDA06Tlkx/yDy+SVNbQh3lWhFwDvsq6kj+m15uQbVVk1
         gLqtowlRJ9aweqhOudYfAnwYKz10b0JKT2Ec1jhgTT7zTuTG70j7Nn7ab5J7CVbsunjL
         zYG6SA9e1QGEvPpzN1j6Bx95YjVnvK1hV0Si6pVaaKg4xynd/+3hGESPnk8s5mzt8E6y
         rOOA==
X-Gm-Message-State: AOJu0Yyglb/+f966PlB2f9OSm0w9vAdhLCGJQeZzKMJNI5dmT3aABJYH
        cBAAypYib+CNmZGLdNfxCgWLcg==
X-Google-Smtp-Source: AGHT+IH5FXPnRLTWwJANbU+KMxUTlV+iJ2g9mOiCciekkL298o0creNrr3DayZg6Tb0yVcHyqgP3iA==
X-Received: by 2002:a05:6512:72:b0:503:778:9ad2 with SMTP id i18-20020a056512007200b0050307789ad2mr10531132lfo.19.1698220067617;
        Wed, 25 Oct 2023 00:47:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b004053a6b8c41sm13900970wmq.12.2023.10.25.00.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:47:47 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFC 0/8] arm64: dts: qcom: Introduce SM8650 platforms
 device tree
Date:   Wed, 25 Oct 2023 09:47:40 +0200
Message-Id: <20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzIOGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0Mz3ZL8gsxk3eJcCzNTA93SguKSotTEXN2UEt3UVDNLM0tLy5Q0MyM
 loPaCotS0zAqw0dFKQW7OSrG1tQDYL8QobwAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6112;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IcbRXZ0yD6mmIuqoxdnV+myQn0UsRWxvU2xKHKupRgs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMgeCQALa0l0/gEhSUSKs5s7OjCrxLHngF17oAGU
 jjms9PuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjIHgAKCRB33NvayMhJ0ZtqD/
 wOOwZriCpMK7rXdaOnWJBPQ829gwWJ+lcC6k7rL5BtbqWukjADDl/SEfI47amrLxA9LbFQKCK3QQei
 oTDRwf6nUyZcHkG3M39SzrwgJSMN9WAlvXzzQ/vGvE5mfDFEjCgZA8z5lZwemWYhtvijNtv9flxu2k
 KS+PSWZjxd+w7zsE33UbcDazCgFxuoRmmENvdBNDf6q4x/JMbxCWHicoCxLrojf3scDn+50J57KOwR
 J1luu5k3Uq3f0YS+iWXBXKUQJMLCE47t2wuhQ02zzcf/3utlauRo2IJ5CYxuKXaHC7dMspPKhuc5EP
 5uftBKOkfaPHPj7YQL7ekn8SUcnWuUxsG6Swmhp/a9S8Kt2HOFAelhfW+7INa6N1LM8decp+VZEJhu
 5uQKsdS+ghSmXRbhPYBFVWzpjVKGzk9F3HGEwTvCyovBwfSQR5JX5NrnlB6q2PvyBXuUQbKP8gkGJL
 BpkoYPIG5ni3364bYJrkVa22gR3HXJjgUxq7s6Z2XFlWTonnJVaxzaCBITikONhLUi1QR4sGJ/dvjk
 a2b3I5sQk7z1s6ChiJSXNBMN69GJFczzVc4vSpYXY4P6+4zY1FR1J/uCcH+DN8coSY7AmvwnM/rMQ9
 cKEStjCsgP6ffOoEThtqFNRtvukZb1PAM2Z0mGFFQ8iASaiO6Q2ku4ve79lA==
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

This introduces the Device Tree for the recently announced Snapdragon 8 Gen 3
from Qualcomm, you can find the marketing specifications at:
https://docs.qualcomm.com/bundle/publicresource/87-71408-1_REV_B_Snapdragon_8_gen_3_Mobile_Platform_Product_Brief.pdf

Bindings and base Device Tree for the SM8650 SoC, MTP (Mobile Test Platform)
and QRD (Qualcommm Reference Device) are splited in two:
- 1-5: boot-to-shell first set that are only build-dependent on Clock bindings
- 6-8: multimedia second set that are build-dependent with Interconnect bindings

Features added and enabled:
- CPUs with CPUFREQ, SCPI idle states
- QICv3, IOMMU, Timers
- Interconnect NoCs with LLCC/CPU BWMONs
- SoC 3xTemperature Sensors
- Pinctrl/GPIO with PDC wakeup support
- Global, GPU, Display, TCSR Clock Controllers
- cDSP, aDSP and MPSS with SMP2P
- QuP/I2C Master Hub I2C and SPI controllers + GPI DMA
- PCIe 0/1
- USB2/USB3 with USB3/DP Combo PHY
- UFS with Inline Crypto Engine
- Crypto Engine + DMA and True Random Generator
- SDHCI
- Mobile Display Subsystem with 2xDSI output
- PMIC Glink (USB-PD UCSI + Altmode) provided by aDSP firmware
- GPIO and PMIC Buttons/LEDs on QRD board
- WCN7850 Bluetooth
- DSI + Touch panel

Bindings Dependencies:
- aoss-qmp: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-aoss-qmp-v1-1-8940621d704c@linaro.org/
- bwmon: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-bwmon-v1-1-11efcdd8799e@linaro.org/
- cpufreq: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-cpufreq-v1-1-31dec4887d14@linaro.org/
- dwc3: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-dwc3-v1-1-fdd447e99865@linaro.org/
- gpi: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-gpi-v1-1-3e8824ae480c@linaro.org/
- ice: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-ice-v1-1-6b2bc14e71db@linaro.org/
- ipcc: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-ipcc-v1-1-acca4318d06e@linaro.org/
- pcie: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-pcie-v1-1-0e3d6f0c5827@linaro.org/
- pcd: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-pdc-v1-1-42f62cc9858c@linaro.org/
- pmic-glink: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-pmic-glink-v1-1-0c2829a62565@linaro.org/
- qce: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-qce-v1-1-7e30dba20dbf@linaro.org/
- rng: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-rng-v1-1-6b6a020e3441@linaro.org/
- scm: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-scm-v1-1-f687b5aa3c9e@linaro.org/
- sdhci: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-sdhci-v1-1-e644cf937321@linaro.org/
- smmu: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-smmu-v1-1-bfa25faa061e@linaro.org/
- tsens: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-tsens-v1-1-09fdd17b1116@linaro.org/
- ufs: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-ufs-v1-1-a355e3556531@linaro.org/
- clocks: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org/
- interconnect: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org/
- llcc: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-llcc-v1-0-ba4566225424@linaro.org/
- mdss: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-mdss-v1-0-bb219b8c7a51@linaro.org/
- phy: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org/
- remoteproc: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-remoteproc-v1-0-a8d20e4ce18c@linaro.org/
- rpmpd: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-rpmpd-v1-0-f25d313104c6@linaro.org/
- tlmm: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-tlmm-v1-0-4e3d84a3a46b@linaro.org/
- goodix: https://lore.kernel.org/all/20231023-topic-goodix-berlin-upstream-initial-v10-0-88eec2e51c0b@linaro.org/

Build Dependencies:
- clocks: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org/
- interconnect: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org/

Other:
- socinfo: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-socinfo-v1-1-6776a5183fa0@linaro.org/

Merge Strategy:
- Merge patches 1-5 with Clock bindings immutable branch
- Merge patches 6-8 with Interconnect immutable branch

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (8):
      dt-bindings: arm: qcom: document SM8650 and the reference boards
      arm64: dts: qcom: add initial SM8650 dtsi
      arm64: dts: qcom: pm8550ve: make PMK8550VE SID configurable
      arm64: dts: qcom: sm8650: add initial SM8650 MTP dts
      arm64: dts: qcom: sm8650: add initial SM8650 QRD dts
      arm64: dts: qcom: sm8650: add interconnect dependent device nodes
      arm64: dts: qcom: sm8650-mtp: add interconnect dependent device nodes
      arm64: dts: qcom: sm8650-qrd: add interconnect dependent device nodes

 Documentation/devicetree/bindings/arm/qcom.yaml |    7 +
 arch/arm64/boot/dts/qcom/Makefile               |    2 +
 arch/arm64/boot/dts/qcom/pm8550ve.dtsi          |   11 +-
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts         |  615 +++
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts         |  743 +++
 arch/arm64/boot/dts/qcom/sm8650.dtsi            | 5483 +++++++++++++++++++++++
 6 files changed, 6858 insertions(+), 3 deletions(-)
---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-dt-ee696999df62

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

