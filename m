Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE127F6F51
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjKXJUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:20:46 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE97D71
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:20:51 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507b9408c61so2352561e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700817650; x=1701422450; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=086g1AiAU7fHTZ3LVhKxUqWPniivF63EvtQmG/0Hxpk=;
        b=YC+c5PMnXJanRyFsth3WyyrSF3IiTT6sZGhLLW62Xa0XvAQcfifJtALNnq83LY1Tww
         REHzhB1w4kj7zyeex4fRPG11qUlbIiG+SZyQnmLp/EhMFMFJczrQNbbNG/iJ/t5A2p7S
         CR7TCwGCzPRz8b5/Tg+e68hxVhHEYd8ulGpDbpgewVJcLAdB6ySQjO3WflW6UfD67pfB
         zOH3jOtTxqbGjkfLszk5G+aCzU71DYnWLSj2DHOr8MwuF+OYcnXh8VMLQ0m721gHCHKE
         OrpsbR/W3CoYgq6XHaHzepHGzqmqOCjmgPF6v+l0mySGeCNH+7v+CcUYXlWJcMyV+kiL
         blJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700817650; x=1701422450;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=086g1AiAU7fHTZ3LVhKxUqWPniivF63EvtQmG/0Hxpk=;
        b=HOrIET1zLfVmvqw8xiHGv8aVPsoSRsWbM9gndYumYwjia2sxG1wPBHgYLBlyVItGLk
         UfHhKpvySR7mw3C5keP2qEhdLsl9HPQTWJrH4kozkHzFMGIjDa5Prjjruf5G5z3mtLiF
         1bmADLpd+HL+TegUvrLmfJmfazvaYuf/+gWMHcRh+Z0ScxOToflAo2wcjKAJbEOIBYDa
         jgriCzY7yxBCbFCgYXeewqyal3Hx9cdbh7ivhqDZm1UTWm98UYbTGvPbEQbHW/C1Mukg
         t5jmL4lE4i0195FKZOfxZAPvuWY1C31VbkobsvC9HJdXSAORA2k7bdIA8NY0a23toty+
         QgEg==
X-Gm-Message-State: AOJu0YwRFKc/hhQjY8NPMLImI70uEL+/l+cgvqdt2W6bNNYDvmlvwcCr
        31nJzvg3H7Ggjbt5f9KJUYO1lQ==
X-Google-Smtp-Source: AGHT+IEAf6Omca8pGVDGFuCEwnGv4OaGfcv9NPrJmfhBJxSzKxYb15PC7rM1pAhwwiG6Jpc4mD5MiA==
X-Received: by 2002:ac2:4194:0:b0:503:7dd:7ebd with SMTP id z20-20020ac24194000000b0050307dd7ebdmr1187215lfh.24.1700817649803;
        Fri, 24 Nov 2023 01:20:49 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m23-20020a056000025700b00332ce0d7300sm3805755wrz.92.2023.11.24.01.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:20:49 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/8] arm64: dts: qcom: Introduce SM8650 platforms device
 tree
Date:   Fri, 24 Nov 2023 10:20:37 +0100
Message-Id: <20231124-topic-sm8650-upstream-dt-v4-0-e402e73cc5f0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOVqYGUC/33OwQoCIRCA4VcJzxnOuKvZqfeIDpZaQq2LmhTLv
 ntuBBVRx39gvpmBJBu9TWQ1G0i0xScfuhrNfEb2R90dLPWmNkGGHBgImkPv9zSdl6Jl9NKnHK0
 +U5OptUIJpZRxAkld76N1/vqgN9vaR59yiLfHpQLT9Ili+xstQBnVSwQJqCvs1iff6RgWIR7Ip
 BZ8ScD+vFewSk1jhFMSmNPyS+JvEsIfiVfJ7JRhLZPOGf4hjeN4Bw9VR1ZVAQAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7545;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=La+Nc6KPp5Q4QvPfL9ZM+Q6FqRetUHqYyyDJMInH5BY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlYGrta1Krju1UdVuXMXsardWdfbDL78UKWBjkar+y
 9vjZgumJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWBq7QAKCRB33NvayMhJ0UW/EA
 DHh6u74KE1TuM1Z+ia2hOY1hEp0zc29l8mScZpjBPRD5jDsiEu2JjenPMGppELySgMSU8wOuIJgXLt
 T51OpaRP4RfUkb09jhSQEH0vUVHQqep7zFdpPo2GAlPqCf5IP+NViBCCzU46hCGs+5kfj+XVmu5fmm
 r4ZLH9xiRgVsyoTRLKwIayxQJvX7qj7/7exJHc2cgG00QOwmVRjo1LEpaVvFTi+HB7/4s+0qq7aCCs
 +lbYdTt1sV9QnuGUkpxfZBp+qdrvP6HqrydNwDUCmIdAFH4w4aNOrGJQMpYciLnah4kS0snwkdf8lG
 G+nDGVGAb4nv42tsBOp5YE8J7YdTqKedKfnhhje8K3HHJXZD0t5v6y1kOQe5vP1+6dDMaIz189oZoF
 TYWQDslXctWMUec0ABcw/l5hE8c5+ho38CAK9k/Qh9zunGoHGPrrU7dAeg7nAgPZA+Kk4Ak2hJcMHZ
 XZOJF3Kx51NxZ64cfxUrjQ2TECBRPWlotbMjr89ki3RFC+OsLqI9aM1tsG1LOrB8krEnLjgBIEdQCx
 tzFRXUr3LwYYvW+xDpA/e8ryYl7Sg7KHbRIryh7Q4HciGlk5bS7ggWNEgp8HBafQOKldVTEQN93yFJ
 TQ5ZPJ+8BsbHnUfmF+vTsFDOxIMudNIzrXOEi2jUmjjnOS74h8jXuYLA7Ltw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
- aoss-qmp: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-aoss-qmp-v1-1-8940621d704c@linaro.org/ - Reviewed
- bwmon: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-bwmon-v1-1-11efcdd8799e@linaro.org/ - Reviewed
- cpufreq: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-cpufreq-v1-1-31dec4887d14@linaro.org/ - Applied
- dwc3: https://lore.kernel.org/all/20231030-topic-sm8650-upstream-bindings-dwc3-v2-1-60c0824fb835@linaro.org/ - Applied
- gpi: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-gpi-v2-1-4de85293d730@linaro.org/ - Reviewed
- ice: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-ice-v1-1-6b2bc14e71db@linaro.org/ - Applied
- ipcc: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-ipcc-v1-1-acca4318d06e@linaro.org/ - Reviewed
- pcie: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-pcie-v1-1-0e3d6f0c5827@linaro.org/ - Reviewed
- pcd: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-pdc-v1-1-42f62cc9858c@linaro.org/ - Reviewed
- pmic-glink: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-pmic-glink-v1-1-0c2829a62565@linaro.org/ - Reviewed
- qce: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-qce-v1-1-7e30dba20dbf@linaro.org/ - Applied
- rng: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-rng-v1-1-6b6a020e3441@linaro.org/ - Applied
- scm: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-scm-v2-1-68a8db7ae434@linaro.org/ - Reviewed
- sdhci: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-scm-v2-1-68a8db7ae434@linaro.org/ - Applied
- smmu: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-smmu-v1-1-bfa25faa061e@linaro.org/ - Reviewed
- tsens: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-tsens-v2-1-5add2ac04943@linaro.org/ - Reviewed
- ufs: https://lore.kernel.org/r/20231030-topic-sm8650-upstream-bindings-ufs-v3-1-a96364463fd5@linaro.org - Applied
- clocks: https://lore.kernel.org/all/20231106-topic-sm8650-upstream-clocks-v3-0-761a6fadb4c0@linaro.org/
- interconnect: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org/ - Reviewed
- llcc: https://lore.kernel.org/r/20231030-topic-sm8650-upstream-llcc-v2-0-f281cec608e2@linaro.org - Reviewed
- mdss: https://lore.kernel.org/all/20231030-topic-sm8650-upstream-mdss-v2-0-43f1887c82b8@linaro.org/ - Reviewed
- phy: https://lore.kernel.org/all/20231030-topic-sm8650-upstream-phy-v2-0-a543a4c4b491@linaro.org/ - Applied
- remoteproc: https://lore.kernel.org/r/20231030-topic-sm8650-upstream-remoteproc-v2-0-609ee572e0a2@linaro.org
- rpmpd: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-rpmpd-v1-0-f25d313104c6@linaro.org/ - Applied
- tlmm: https://lore.kernel.org/all/20231106-topic-sm8650-upstream-tlmm-v3-0-0e179c368933@linaro.org/ - Applied
- goodix: https://lore.kernel.org/all/20231106-topic-goodix-berlin-upstream-initial-v11-0-5c47e9707c03@linaro.org/ - Reviewed

Build Dependencies:
- clocks: https://lore.kernel.org/all/20231106-topic-sm8650-upstream-clocks-v3-0-761a6fadb4c0@linaro.org/
- interconnect: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org/ - Reviewed

Other:
- socinfo: https://lore.kernel.org/all/20231030-topic-sm8650-upstream-socinfo-v2-0-4751e7391dc9@linaro.org/ - Reviewed
- defconfig: https://lore.kernel.org/all/20231121-topic-sm8650-upstream-defconfig-v1-1-2500565fc21b@linaro.org/

Merge Strategy:
- Merge patches 1-5 with Clock bindings immutable branch
- Merge patches 6-8 with Interconnect immutable branch

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- Collected reviewed-bys
- Fixed dwc3 interrupts
- Added comment on the reserved i/o ranges
- fixed s/resetn/reset-n/
- Used minimal patch strategy to make patch 6 readable
- Link to v3: https://lore.kernel.org/r/20231121-topic-sm8650-upstream-dt-v3-0-db9d0507ffd3@linaro.org

Changes in v3:
- Cleanup of thermal zones
- Rename SDE pinctrl to real signal names
- Link to v2: https://lore.kernel.org/r/20231106-topic-sm8650-upstream-dt-v2-0-44d6f9710fa7@linaro.org

Changes in v2:
- Drop RFC since most of bindings were reviewed
- Collect Reviewed-by/Acked-bys
- Remove #ifndef PMK8550VE_SID in favor of #define in sm8550 dts
- Add allow-set-load/allowed-modes to LDOs
- Add QCOM_ICC_TAG_ALWAYS/QCOM_ICC_TAG_ACTIVE_ONLY to interconnects = <> instead of 0 & 3
- minimal sm8650-qrd.dts cleanup
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org

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
 arch/arm64/boot/dts/qcom/pm8550ve.dtsi          |    6 +-
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts         |    1 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts         |    1 +
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts         |  679 +++
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts         |  804 ++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi            | 5384 +++++++++++++++++++++++
 8 files changed, 6881 insertions(+), 3 deletions(-)
---
base-commit: 4e87148f80d198ba5febcbcc969c6b9471099a09
change-id: 20231016-topic-sm8650-upstream-dt-ee696999df62

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

