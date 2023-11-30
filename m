Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A29A7FECB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjK3KUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbjK3KUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:20:06 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3FE10D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:20:09 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9d0d327d6so3035931fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701339608; x=1701944408; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0L1kzNCbVJmlCo9UccP+bZR9/gYD/8dye18U7Av0jCE=;
        b=UTCoEqsg6zZSNyKruBsVhkJ+/xbGC9rXCGJqFIrDlWfce8mvPVdO/I6L/Ck03jfhmJ
         C9swDy0fKuuCyKOX3F4KUtKHyiMNSkEIX87Nnw4cBFpIKywEWCFa6hqIqN+OnSQa4IjT
         OByCpoEtR7SwD3bVwUU2WLRLIZc47En/sUO/NGjkzpfDhl50QGjyy1iCuVFpggXBKDVN
         /J8XqoUHBjvSgr2qwz2hVEBO3Tc3tEv2CsOoVJn8BRXLvF/UFst1bpB6ehYycLUYfJhz
         +bPc9UX6DbLWKdowIwrf2vfomi4znZGibu7E92VoIO1IhrlQX74sE+PEKeOn+DiY3ML0
         BY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701339608; x=1701944408;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0L1kzNCbVJmlCo9UccP+bZR9/gYD/8dye18U7Av0jCE=;
        b=qWl4gbIBkP1rT1tU4Q6p2EaShMXEcozDmd7A8iYhm+MJSTdvn3KH9Asb2ZSDMplHl1
         iNbaOhflW4gX4MvvCfh9BvwFWN9efYohUcTMS8SRYl4De/+rgWv+xlbAFSXoM4arin4f
         OnTQINedLprWETiys0IKPGEsxitwHm798UhPtyO08VJC//C8A9yJnmpW+PyfNKsAFvSy
         jA6kToZYUZMPsQxnmUlmq+tB20Pd7UrNcL1rpxv0illRRLaSUaOg3O2m3zkVaOEUIBDZ
         +jA9qOaNfyF09EVCa90BFqtHth3g+27cK4feUpZH5mwCWNJoX85WoFg6DHkH8L08yXvG
         O4VA==
X-Gm-Message-State: AOJu0YwX6Y35w1MO49O9/IZOA5QLlJZGGp4AhGypQj3gmxtlPsh87sn3
        pXSs6yzBMTz55GWv0/Kc5cDd/A==
X-Google-Smtp-Source: AGHT+IEFVaQg5P0eebtAiq9ayUXLk5vitfMLbDC50c5Wt/kkW+OmfAu+Cz3oFvWKnZGdwRPm5poJzQ==
X-Received: by 2002:a2e:8709:0:b0:2c9:c192:42a8 with SMTP id m9-20020a2e8709000000b002c9c19242a8mr2564232lji.38.1701339607994;
        Thu, 30 Nov 2023 02:20:07 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c1d0a00b00407460234f9sm1465217wms.21.2023.11.30.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 02:20:07 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 0/8] arm64: dts: qcom: Introduce SM8650 platforms device
 tree
Date:   Thu, 30 Nov 2023 11:19:55 +0100
Message-Id: <20231130-topic-sm8650-upstream-dt-v5-0-b25fb781da52@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMthaGUC/33OzWoCMRDA8VeRnE2ZTL5MT32P0kPcTDSgmyXZh
 hbZd28UoRbpHv8D85u5sEolUWWvmwsr1FJNeeyhtxs2HP14IJ5Cb4aAUoAwfM5TGng974wG/jn
 VuZA/8zBzIuOMcy5Eg6yvT4Vi+rrR7x+9j6nOuXzfLjVxnd5R1P+jTXDgfofCCvQdjm+nNPqSX
 3I5sKva8FcSsPJewy4pFUx0VkD09kmSDxKKFUl2KexdAA02xiCfJPUoqRVJdYkUIFk5DDrCH2l
 Zlh/HrVjanwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8064;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=T3e6Ya4GlL2XESwVX4pZPmJKXgtuVvbajHlNLrVFVc8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlaGHTAntQEHULv4X7j8LgFETXNcJ/GYIyINu/Hx/Q
 FVgu5n+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWhh0wAKCRB33NvayMhJ0YXWD/
 9j5xsmaft1hos2CYIScPql7u6Mh6jZlFhKu1kA16BNgSvpcDxXJCAtX17GJhnhM5+9CUK2o4KtSHw2
 K+mZiRbfg0vbrTK4JzReOXe8egLm0wMW9eEwnt/XfKNoBfty1qX2CQTUYrYO2QO/JaMF478xYTmSdK
 Ie9Hzrmk6VC1jBJ85bE3WHLUYM47KKbU0NRNYcCil5Df439jjMdQW0Hw5PPhF60N4KH7m8LhK0Vhxl
 5hyoqlHX3x0trscLlAsmzCkCdrJxWOmThaBDGtKzOJac6RlpsjSfUwg1zKDCQPLUWAupR8j5/hI64b
 IQHHtagCAgttfThcypr6AXfKAbSOlA3L6ri62NtOk1juzFcl+CO/yacWlQfsl1S6Skl63f+rPNmDAu
 vy7aSLAFxNYKDwjaUgVwdMb3PiV+4eKYBIEy8utSUS0KD03/HawQfnl3E8xQlH6UN7sX4/YnsbeXDS
 rljK4Pu7s55CDpQCEG/b4ItRn5WFFndGyokgooWpcWIvlE8L6GBygE8V0V2o1Oe8Io69hjvuXKVnrw
 xxCVt9WaZp2SVkjf4rxJsRE/QWDFaMFbxe6WAg9ryTbG0jrVdtYwxT+9N+kJ4rUKVa7sloIL5MKkfM
 hwiwvGiOTITZ6rxQoABsHdY5OU/R5dRiZyCt6GgWaCRAkaiUhaFfWv9jRt0Q==
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
- bwmon: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-bwmon-v1-1-11efcdd8799e@linaro.org/ - Applied
- cpufreq: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-cpufreq-v1-1-31dec4887d14@linaro.org/ - Applied
- dwc3: https://lore.kernel.org/all/20231030-topic-sm8650-upstream-bindings-dwc3-v2-1-60c0824fb835@linaro.org/ - Applied
- gpi: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-gpi-v2-1-4de85293d730@linaro.org/ - Applied
- ice: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-ice-v1-1-6b2bc14e71db@linaro.org/ - Applied
- ipcc: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-ipcc-v1-1-acca4318d06e@linaro.org/ - Applied
- pcie: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-pcie-v1-1-0e3d6f0c5827@linaro.org/ - Reviewed
- pdc: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-pdc-v1-1-42f62cc9858c@linaro.org/ - Applied
- pmic-glink: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-pmic-glink-v1-1-0c2829a62565@linaro.org/ - Reviewed
- qce: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-qce-v1-1-7e30dba20dbf@linaro.org/ - Applied
- rng: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-rng-v1-1-6b6a020e3441@linaro.org/ - Applied
- scm: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-scm-v2-1-68a8db7ae434@linaro.org/ - Reviewed
- sdhci: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-scm-v2-1-68a8db7ae434@linaro.org/ - Applied
- smmu: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-smmu-v1-1-bfa25faa061e@linaro.org/ - Reviewed
- tsens: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-tsens-v2-1-5add2ac04943@linaro.org/ - Applied
- ufs: https://lore.kernel.org/r/20231030-topic-sm8650-upstream-bindings-ufs-v3-1-a96364463fd5@linaro.org - Applied
- clocks: https://lore.kernel.org/all/20231106-topic-sm8650-upstream-clocks-v3-0-761a6fadb4c0@linaro.org/ - Reviewed
- interconnect: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org/ - Applied
- llcc: https://lore.kernel.org/r/20231030-topic-sm8650-upstream-llcc-v2-0-f281cec608e2@linaro.org - Reviewed
- mdss: https://lore.kernel.org/all/20231030-topic-sm8650-upstream-mdss-v2-0-43f1887c82b8@linaro.org/ - Reviewed
- phy: https://lore.kernel.org/all/20231030-topic-sm8650-upstream-phy-v2-0-a543a4c4b491@linaro.org/ - Applied
- remoteproc: https://lore.kernel.org/r/20231030-topic-sm8650-upstream-remoteproc-v2-0-609ee572e0a2@linaro.org - Reviewed
- rpmpd: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-rpmpd-v1-0-f25d313104c6@linaro.org/ - Applied
- tlmm: https://lore.kernel.org/all/20231106-topic-sm8650-upstream-tlmm-v3-0-0e179c368933@linaro.org/ - Applied
- goodix: https://lore.kernel.org/all/20231106-topic-goodix-berlin-upstream-initial-v11-0-5c47e9707c03@linaro.org/ - Reviewed

Build Dependencies:
- clocks: https://lore.kernel.org/all/20231106-topic-sm8650-upstream-clocks-v3-0-761a6fadb4c0@linaro.org/
- interconnect: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org/ - Applied

An interconnect immutable branch with bindings is available at:
https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git/log/?h=icc-sm8650 

Other:
- socinfo: https://lore.kernel.org/all/20231030-topic-sm8650-upstream-socinfo-v2-0-4751e7391dc9@linaro.org/ - Reviewed
- defconfig: https://lore.kernel.org/all/20231121-topic-sm8650-upstream-defconfig-v1-1-2500565fc21b@linaro.org/ - Reviewed

Merge Strategy:
- Merge patches 1-5 with Clock bindings immutable branch
- Merge patches 6-8 with Interconnect immutable branch

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v5:
- Minimal initial DTSI changes:
  - Removed undocument pwr_event irq for dwc3, breaking dtbs_check
  - Removed GIC_CPU_MASK_SIMPLE(8) that are unnecessary for GICv3
- Collected review tags
- Rebased on next-20231130
- Link to v4: https://lore.kernel.org/r/20231124-topic-sm8650-upstream-dt-v4-0-e402e73cc5f0@linaro.org

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
 arch/arm64/boot/dts/qcom/sm8650.dtsi            | 5382 +++++++++++++++++++++++
 8 files changed, 6879 insertions(+), 3 deletions(-)
---
base-commit: 3cd3fe06ff81cfb3a969acb12a56796cff5af23d
change-id: 20231016-topic-sm8650-upstream-dt-ee696999df62

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

