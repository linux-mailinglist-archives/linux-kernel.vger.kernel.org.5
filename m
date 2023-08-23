Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9A078531E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjHWIxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjHWIrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:47:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F3810D2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:46:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so84259871fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692780373; x=1693385173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNochH5AzkkbM02iKAt64Ac4DR2vD4vaGcqyxMvLZVY=;
        b=FhCexy8y7ro104msZGjkcgIBCQaHn2CRqvB2kep4Km9TOq/UMGFXLndYDYmnI5Mp6s
         K4Nmnf7rhCKtTxqYeoN/ftfysDdubtlQXvoSym2EFt4ICaqVkQu5fW7cj1kDBkP0Hyqh
         In0BKnVqt2+tYrO+9hJ2KpvIkIvWIBhiyvll4Y5G3itusRUgfgcK/sFjvWT9Z3iUbMlR
         ep5rPN8RJuanqW62Pwqa+3iUiMl6XxdN1m8f8vQsWVIlqNbaVqK5n7C4wfoZJjZm9a6Z
         LbK/qqgfLDnPuQZ03j3WqGpE/dnyfGc7DFIeo6e/h9fFCaho4h6hSZFbaOUMEY+5flnG
         L3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780373; x=1693385173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNochH5AzkkbM02iKAt64Ac4DR2vD4vaGcqyxMvLZVY=;
        b=PWmyGyS8sgkdLvIQUWO51ekNpkmUilKH+L9zKvPLkNwZhLq/LKktF3nzCSeX2wb80O
         l+iDGZI6ZX2KLPhoMeU6UMgrAIOMq8mKbcmRy2SUa4MmBvB+QRSjLue7NnnmNfGw4bRI
         B1AS18S7VsYeenj6BsPlEeEdHYA89BPo+bkzDDHI2LuCX3AGa116/GYkP6f1/AROgkGQ
         NQNAfFpbz9nJo2++8Bo+mSM6/7WPAceVFP2EmROmYKxjncQhHCAv5PlUKm3idrMSjlXG
         2RQZ6JrRurxZ/DQws3olGonOBcu0gVSNXNSDPBl4gtpoZi1gqzSc2Rz5QBecwxpHp6EX
         cujQ==
X-Gm-Message-State: AOJu0YwSYt71qaaEelp3RCNepOuHLqnWSl811gWGhJZqta+OclKQq4An
        LuLL/7bo6eKDynshEY/xlZRAng==
X-Google-Smtp-Source: AGHT+IHkGj/NYJq/FRYjSbgE8fN+I3rSglzTGyg8tmrvX8t4CCjOU29Ss7Prv9aY3uR4AaZALKPw5g==
X-Received: by 2002:a2e:7e10:0:b0:2b9:eaa7:c23f with SMTP id z16-20020a2e7e10000000b002b9eaa7c23fmr8238886ljc.49.1692780372918;
        Wed, 23 Aug 2023 01:46:12 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090615c700b00999bb1e01dfsm9462805ejd.52.2023.08.23.01.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:46:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: use capital "OR" for multiple licenses in SPDX
Date:   Wed, 23 Aug 2023 10:45:40 +0200
Message-Id: <20230823084540.112602-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/process/license-rules.rst and checkpatch expect the SPDX
identifier syntax for multiple licenses to use capital "OR".  Correct it
to keep consistent format and avoid copy-paste issues.

Correct also the format // -> .* in few Allwinner binding headers as
pointed out by checkpatch:

  WARNING: Improper SPDX comment style for 'include/dt-bindings/reset/sun50i-h6-ccu.h', please use '/*' instead

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Rebased on next-20230822, so might not apply cleanly.  What does not
apply, can be skipped and I will fix it after next RC.
---
 Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml    | 2 +-
 .../devicetree/bindings/arm/arm,coresight-dummy-sink.yaml       | 2 +-
 .../devicetree/bindings/arm/arm,coresight-dummy-source.yaml     | 2 +-
 .../devicetree/bindings/arm/arm,embedded-trace-extension.yaml   | 2 +-
 .../devicetree/bindings/arm/arm,trace-buffer-extension.yaml     | 2 +-
 Documentation/devicetree/bindings/arm/arm,versatile-sysreg.yaml | 2 +-
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml        | 2 +-
 .../devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml      | 2 +-
 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml      | 2 +-
 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml  | 2 +-
 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml  | 2 +-
 Documentation/devicetree/bindings/clock/ti,cdce925.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/ti,sci-clk.yaml         | 2 +-
 Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml          | 2 +-
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 +-
 Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml | 2 +-
 Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml | 2 +-
 Documentation/devicetree/bindings/display/msm/dsi-phy-20nm.yaml | 2 +-
 Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml | 2 +-
 Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml  | 2 +-
 .../devicetree/bindings/display/msm/dsi-phy-common.yaml         | 2 +-
 Documentation/devicetree/bindings/display/msm/mdss-common.yaml  | 2 +-
 Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml    | 2 +-
 Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml    | 2 +-
 .../devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml       | 2 +-
 .../devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml      | 2 +-
 .../devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml       | 2 +-
 .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml      | 2 +-
 .../devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml        | 2 +-
 .../devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml       | 2 +-
 .../devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml        | 2 +-
 .../devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml       | 2 +-
 .../devicetree/bindings/display/msm/qcom,sc8280xp-dpu.yaml      | 2 +-
 .../devicetree/bindings/display/msm/qcom,sc8280xp-mdss.yaml     | 2 +-
 .../devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml        | 2 +-
 .../devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml       | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml        | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml       | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml       | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml       | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml        | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml       | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml        | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml       | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml        | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml       | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml        | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml       | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml        | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml       | 2 +-
 .../devicetree/bindings/display/panel/himax,hx8394.yaml         | 2 +-
 .../devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml | 2 +-
 .../devicetree/bindings/display/panel/orisetech,otm8009a.yaml   | 2 +-
 .../devicetree/bindings/display/panel/panel-dsi-cm.yaml         | 2 +-
 .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml   | 2 +-
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 +-
 .../devicetree/bindings/display/panel/raydium,rm68200.yaml      | 2 +-
 .../devicetree/bindings/display/panel/rocktech,jh057n00900.yaml | 2 +-
 .../devicetree/bindings/display/panel/visionox,r66451.yaml      | 2 +-
 .../devicetree/bindings/display/panel/visionox,rm69299.yaml     | 2 +-
 .../devicetree/bindings/display/panel/visionox,vtdr6130.yaml    | 2 +-
 .../devicetree/bindings/display/rockchip/rockchip-vop2.yaml     | 2 +-
 .../bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml         | 2 +-
 .../devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml          | 2 +-
 Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml         | 2 +-
 Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml       | 2 +-
 Documentation/devicetree/bindings/hwmon/lm75.yaml               | 2 +-
 Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml  | 2 +-
 Documentation/devicetree/bindings/hwmon/national,lm90.yaml      | 2 +-
 Documentation/devicetree/bindings/hwmon/nxp,mc34vr500.yaml      | 2 +-
 Documentation/devicetree/bindings/hwmon/sensirion,sht15.yaml    | 2 +-
 Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml          | 2 +-
 Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml          | 2 +-
 Documentation/devicetree/bindings/input/elan,ekth3000.yaml      | 2 +-
 .../devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml | 2 +-
 Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml      | 2 +-
 Documentation/devicetree/bindings/mailbox/ti,omap-mailbox.yaml  | 2 +-
 .../devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml        | 2 +-
 .../devicetree/bindings/phy/nvidia,tegra210-xusb-padctl.yaml    | 2 +-
 .../devicetree/bindings/power/reset/gpio-poweroff.yaml          | 2 +-
 Documentation/devicetree/bindings/power/reset/gpio-restart.yaml | 2 +-
 .../devicetree/bindings/power/reset/restart-handler.yaml        | 2 +-
 Documentation/devicetree/bindings/power/supply/bq256xx.yaml     | 2 +-
 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml         | 2 +-
 .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml         | 2 +-
 .../devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml      | 2 +-
 .../devicetree/bindings/remoteproc/ti,pru-consumer.yaml         | 2 +-
 Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml  | 2 +-
 .../devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml       | 2 +-
 Documentation/devicetree/bindings/reset/ti,sci-reset.yaml       | 2 +-
 Documentation/devicetree/bindings/reset/ti,tps380x-reset.yaml   | 2 +-
 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml     | 2 +-
 Documentation/devicetree/bindings/usb/cypress,hx3.yaml          | 2 +-
 Documentation/devicetree/bindings/usb/genesys,gl850g.yaml       | 2 +-
 Documentation/devicetree/bindings/usb/realtek,rts5411.yaml      | 2 +-
 Documentation/devicetree/bindings/usb/ti,usb8041.yaml           | 2 +-
 Documentation/devicetree/bindings/usb/vialab,vl817.yaml         | 2 +-
 include/dt-bindings/ata/ahci.h                                  | 2 +-
 include/dt-bindings/clock/hi3559av100-clock.h                   | 2 +-
 include/dt-bindings/clock/r8a779f0-cpg-mssr.h                   | 2 +-
 include/dt-bindings/clock/rockchip,rk3588-cru.h                 | 2 +-
 include/dt-bindings/clock/stm32mp1-clks.h                       | 2 +-
 include/dt-bindings/clock/sun20i-d1-ccu.h                       | 2 +-
 include/dt-bindings/clock/sun20i-d1-r-ccu.h                     | 2 +-
 include/dt-bindings/clock/sun50i-a100-ccu.h                     | 2 +-
 include/dt-bindings/clock/sun50i-h6-ccu.h                       | 2 +-
 include/dt-bindings/clock/sun50i-h616-ccu.h                     | 2 +-
 include/dt-bindings/clock/sun6i-rtc.h                           | 2 +-
 include/dt-bindings/display/sdtv-standards.h                    | 2 +-
 include/dt-bindings/gpio/meson-g12a-gpio.h                      | 2 +-
 include/dt-bindings/power/amlogic,c3-pwrc.h                     | 2 +-
 include/dt-bindings/power/meson-a1-power.h                      | 2 +-
 include/dt-bindings/power/meson-axg-power.h                     | 2 +-
 include/dt-bindings/power/meson-g12a-power.h                    | 2 +-
 include/dt-bindings/power/meson-gxbb-power.h                    | 2 +-
 include/dt-bindings/power/meson-s4-power.h                      | 2 +-
 include/dt-bindings/power/meson-sm1-power.h                     | 2 +-
 include/dt-bindings/power/meson8-power.h                        | 2 +-
 include/dt-bindings/power/r8a779f0-sysc.h                       | 2 +-
 include/dt-bindings/power/rk3588-power.h                        | 2 +-
 include/dt-bindings/power/summit,smb347-charger.h               | 2 +-
 include/dt-bindings/reset/rockchip,rk3588-cru.h                 | 2 +-
 include/dt-bindings/reset/stm32mp1-resets.h                     | 2 +-
 include/dt-bindings/reset/sun20i-d1-ccu.h                       | 2 +-
 include/dt-bindings/reset/sun20i-d1-r-ccu.h                     | 2 +-
 include/dt-bindings/reset/sun50i-a100-ccu.h                     | 2 +-
 include/dt-bindings/reset/sun50i-a100-r-ccu.h                   | 2 +-
 include/dt-bindings/reset/sun50i-h6-ccu.h                       | 2 +-
 include/dt-bindings/reset/sun50i-h6-r-ccu.h                     | 2 +-
 include/dt-bindings/reset/sun50i-h616-ccu.h                     | 2 +-
 130 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
index d6c84b6e7fe6..6216cfb0a188 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 # Copyright 2019 Linaro Ltd.
 %YAML 1.2
 ---
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
index cb78cfa56702..c960c8e0a9a5 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/arm/arm,coresight-dummy-sink.yaml#
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
index 5fedaed49a1f..6745b4cc8f1c 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/arm/arm,coresight-dummy-source.yaml#
diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
index 108460627d9a..a88f96b0ca16 100644
--- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 # Copyright 2021, Arm Ltd
 %YAML 1.2
 ---
diff --git a/Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml b/Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml
index b1322658063a..bc0c6d8b7fdb 100644
--- a/Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 # Copyright 2021, Arm Ltd
 %YAML 1.2
 ---
diff --git a/Documentation/devicetree/bindings/arm/arm,versatile-sysreg.yaml b/Documentation/devicetree/bindings/arm/arm,versatile-sysreg.yaml
index 491eef1e1b10..3b060c36b90c 100644
--- a/Documentation/devicetree/bindings/arm/arm,versatile-sysreg.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,versatile-sysreg.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/arm/arm,versatile-sysreg.yaml#
diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e17b3d66d6e5..68f717670f78 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/arm/aspeed/aspeed.yaml#
diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
index ff378d5cbd32..4a323e8c785d 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/arm/keystone/ti,k3-sci-common.yaml#
diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
index 86b59de7707e..c24ad0968f3e 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/arm/keystone/ti,sci.yaml#
diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
index 2ec9b5b24d73..ea3c5db6b52d 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 # Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
 %YAML 1.2
 ---
diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 5c08342664ea..3bad47b7b02b 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 # Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
 %YAML 1.2
 ---
diff --git a/Documentation/devicetree/bindings/clock/ti,cdce925.yaml b/Documentation/devicetree/bindings/clock/ti,cdce925.yaml
index a4ec8dd5ddf1..95c1c6f8b755 100644
--- a/Documentation/devicetree/bindings/clock/ti,cdce925.yaml
+++ b/Documentation/devicetree/bindings/clock/ti,cdce925.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/ti,cdce925.yaml#
diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml b/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
index 63d976341696..0a9d6a4c4b66 100644
--- a/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/ti,sci-clk.yaml#
diff --git a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
index f0ef7685550a..ff10a0838ad6 100644
--- a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
+++ b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/crypto/ti,sa2ul.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index b8d1f2b7d541..c6dbab65d5f7 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/dsi-controller-main.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
index e6b00d7387ce..69d13867b7cf 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/dsi-phy-10nm.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
index 2361da5f6736..52bbe132e6da 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/dsi-phy-14nm.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-20nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-20nm.yaml
index 9c1f9140c731..7e6687cb002b 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-20nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-20nm.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/dsi-phy-20nm.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
index 62fb3e484eb2..288d8babb76a 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/dsi-phy-28nm.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index 8e9031bbde73..dd6619555a12 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/dsi-phy-7nm.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-common.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-common.yaml
index 0f6f08890e7e..6b57ce41c95f 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-common.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/dsi-phy-common.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
index a8086ca09d9f..f69196e4cc76 100644
--- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/mdss-common.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
index 2fe032d0e8f8..91c774f106ce 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,mdp5.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
index 5854a3a1224b..0999ea07f47b 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
index 8d3cd46260fb..d5a64c8a921f 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,msm8998-dpu.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml
index 3c2b6ed98a56..e320ab1de6de 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,msm8998-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
index 414f4e7ebdf1..be6cd8adb3b6 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-dpu.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index 2995b84b2cd4..4184b84d4c21 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
index ea75f0f95d5c..8137618237ce 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sc7180-dpu.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
index 42ef06edddc4..3b9c103e504a 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sc7180-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
index 26dc073bd19a..b0fbe86219d1 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sc7280-dpu.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
index 078e1d1a7d2f..43500dad66e7 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sc7280-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-dpu.yaml
index f2c8e16cf067..d19e3bec4600 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-dpu.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sc8280xp-dpu.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-mdss.yaml
index c239544bc37f..db680fb12b6a 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sc8280xp-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
index 0f7765d832e7..b917064bdf33 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sdm845-dpu.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
index 6ecb00920d7f..d6d7ac1b2ef8 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sdm845-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
index bf62c2f5325a..510eb6c19364 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm6115-dpu.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
index b9f83088f370..17221b62a642 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm6115-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
index 63962a8f2faf..db255b1f4c20 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm6350-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
index 595a9d56949c..30d36fffaedb 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm6375-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
index 2b3f3fe9bdf7..13146b3f053c 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm8150-dpu.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml
index 5182e958e069..54cdaa827cd3 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm8150-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml
index acd2ed391b2f..ffa5047e901f 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm8250-dpu.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
index 5cfb9b917e90..e887f031b8be 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm8250-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml
index 1a4e03531a1b..96ef2d9c3512 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm8350-dpu.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
index 8c89fb7fc8a3..60d4aae1131b 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm8350-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml
index da3fd66c564f..2a5d3daed0e1 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm8450-dpu.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
index cfad5049a966..bb22940b9385 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm8450-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml
index 99908fbe74f0..16a541fca66f 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm8550-dpu.yaml#
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
index 5390a8e79ad3..48aea8005c86 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/msm/qcom,sm8550-mdss.yaml#
diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
index 1b2a1baa26f9..ffb35288ffbb 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/panel/himax,hx8394.yaml#
diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
index a4b8569ab81c..74ff772973d6 100644
--- a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
+++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/panel/mantix,mlaf057we51-x.yaml#
diff --git a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
index ad7d3575190e..1e4f140f48b8 100644
--- a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/panel/orisetech,otm8009a.yaml#
diff --git a/Documentation/devicetree/bindings/display/panel/panel-dsi-cm.yaml b/Documentation/devicetree/bindings/display/panel/panel-dsi-cm.yaml
index 4a36aa64c716..f8dc9929e833 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-dsi-cm.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-dsi-cm.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/panel/panel-dsi-cm.yaml#
diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
index 2f0238b770eb..2786c0b9b65d 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/panel/panel-mipi-dbi-spi.yaml#
diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index 90c04cff8281..73674baea75d 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/panel/panel-simple-dsi.yaml#
diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm68200.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm68200.yaml
index e8ce2315631a..46fe1014ebc4 100644
--- a/Documentation/devicetree/bindings/display/panel/raydium,rm68200.yaml
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm68200.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/panel/raydium,rm68200.yaml#
diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
index 150e81090af2..5ea74426b1d5 100644
--- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/panel/rocktech,jh057n00900.yaml#
diff --git a/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml b/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml
index 6ba323683921..187840bb76c7 100644
--- a/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml
+++ b/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/panel/visionox,r66451.yaml#
diff --git a/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
index 444ac2a4772d..fa745a6f4456 100644
--- a/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
+++ b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/panel/visionox,rm69299.yaml#
diff --git a/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
index 84562a5b710a..d5a8295106c1 100644
--- a/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
+++ b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/panel/visionox,vtdr6130.yaml#
diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
index fba45091d909..b60b90472d42 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/rockchip/rockchip-vop2.yaml#
diff --git a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
index 38478dad8b25..584cce3211c0 100644
--- a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
+++ b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/hwlock/allwinner,sun6i-a31-hwspinlock.yaml#
diff --git a/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
index 0a955c7b9706..5ba60d532fcd 100644
--- a/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
+++ b/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/hwlock/ti,omap-hwspinlock.yaml#
diff --git a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
index 0e49b3901161..bf3332153ad8 100644
--- a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
+++ b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/hwmon/jedec,jc42.yaml#
diff --git a/Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml b/Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml
index b1a4c235376e..e62aff670478 100644
--- a/Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/hwmon/lltc,ltc4151.yaml#
diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
index 8226e3b5d028..0b69897f0c63 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/hwmon/lm75.yaml#
diff --git a/Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml b/Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml
index 028d6e570131..f5e104c1b0d0 100644
--- a/Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml
+++ b/Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/hwmon/microchip,mcp3021.yaml#
diff --git a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
index 7b9d48d6d6da..6e59c8fdef30 100644
--- a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
+++ b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/hwmon/national,lm90.yaml#
diff --git a/Documentation/devicetree/bindings/hwmon/nxp,mc34vr500.yaml b/Documentation/devicetree/bindings/hwmon/nxp,mc34vr500.yaml
index 306f67315835..48d654e52114 100644
--- a/Documentation/devicetree/bindings/hwmon/nxp,mc34vr500.yaml
+++ b/Documentation/devicetree/bindings/hwmon/nxp,mc34vr500.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/hwmon/nxp,mc34vr500.yaml#
diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,sht15.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,sht15.yaml
index 80df7182ea28..14ac783c9a5f 100644
--- a/Documentation/devicetree/bindings/hwmon/sensirion,sht15.yaml
+++ b/Documentation/devicetree/bindings/hwmon/sensirion,sht15.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/hwmon/sensirion,sht15.yaml#
diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
index c5a889e3e27b..7e5b62a0215d 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/hwmon/ti,tmp102.yaml#
diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
index dcbc6fbc3b48..8b5307c875ff 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/hwmon/ti,tmp108.yaml#
diff --git a/Documentation/devicetree/bindings/input/elan,ekth3000.yaml b/Documentation/devicetree/bindings/input/elan,ekth3000.yaml
index 2a9bb6ace021..24dc2d69613f 100644
--- a/Documentation/devicetree/bindings/input/elan,ekth3000.yaml
+++ b/Documentation/devicetree/bindings/input/elan,ekth3000.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/input/elan,ekth3000.yaml#
diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
index 65523d9459d8..3cd5a1822e14 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/interrupt-controller/ti,pruss-intc.yaml#
diff --git a/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
index be1539d234f9..3528b81daa25 100644
--- a/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
+++ b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/iommu/xen,grant-dma.yaml#
diff --git a/Documentation/devicetree/bindings/mailbox/ti,omap-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/ti,omap-mailbox.yaml
index 4943c75e8a60..1a2001e58880 100644
--- a/Documentation/devicetree/bindings/mailbox/ti,omap-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/ti,omap-mailbox.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/mailbox/ti,omap-mailbox.yaml#
diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
index b35c4d256e40..99eac888ae03 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/phy/mediatek,mt7621-pci-phy.yaml#
diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra210-xusb-padctl.yaml b/Documentation/devicetree/bindings/phy/nvidia,tegra210-xusb-padctl.yaml
index d16bd6e47f90..e9237c58ce45 100644
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra210-xusb-padctl.yaml
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra210-xusb-padctl.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/phy/nvidia,tegra210-xusb-padctl.yaml#
diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
index 45d66c775115..b54ec003a1e0 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
+++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/power/reset/gpio-poweroff.yaml#
diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
index d3d18e0f5db3..53535de0d41c 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
+++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/power/reset/gpio-restart.yaml#
diff --git a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
index f2ffdd29d52a..965a834a3dbe 100644
--- a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
+++ b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/power/reset/restart-handler.yaml#
diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
index 4fe9c3705265..a76afe3ca299 100644
--- a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 # Copyright (C) 2020 Texas Instruments Incorporated
 %YAML 1.2
 ---
diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index f16e90380df1..9768db8663eb 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
index 54eecc567e0b..a492f74a8608 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/remoteproc/ti,k3-r5f-rproc.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml
index 1fdc2741c36e..94eb2033e79c 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/remoteproc/ti,omap-remoteproc.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
index 35f0bb38f7b2..2811334515d1 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/remoteproc/ti,pru-consumer.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
index cd55d80137f7..baccd98754a9 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/remoteproc/ti,pru-rproc.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
index 9f677367dd9f..78aac69f1060 100644
--- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/remoteproc/xlnx,zynqmp-r5fss.yaml#
diff --git a/Documentation/devicetree/bindings/reset/ti,sci-reset.yaml b/Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
index dcf9206e12be..e10eb98eddad 100644
--- a/Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/reset/ti,sci-reset.yaml#
diff --git a/Documentation/devicetree/bindings/reset/ti,tps380x-reset.yaml b/Documentation/devicetree/bindings/reset/ti,tps380x-reset.yaml
index f436f2cf1df7..6063784f0352 100644
--- a/Documentation/devicetree/bindings/reset/ti,tps380x-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/ti,tps380x-reset.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/reset/ti,tps380x-reset.yaml#
diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
index 5df7688a1e1c..a750035d6234 100644
--- a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/soc/ti/sci-pm-domain.yaml#
diff --git a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
index 47add0d85fb8..28096619a882 100644
--- a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
+++ b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/usb/cypress,hx3.yaml#
diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
index 383625c2ef00..d0927f6768a4 100644
--- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
+++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
diff --git a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
index 9309f003cd07..f0784d2e86da 100644
--- a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
+++ b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/usb/realtek,rts5411.yaml#
diff --git a/Documentation/devicetree/bindings/usb/ti,usb8041.yaml b/Documentation/devicetree/bindings/usb/ti,usb8041.yaml
index 88ea6c952c66..c2e29bd61e11 100644
--- a/Documentation/devicetree/bindings/usb/ti,usb8041.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,usb8041.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/usb/ti,usb8041.yaml#
diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
index 23a13e1d5c7a..76db9071b352 100644
--- a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
+++ b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/usb/vialab,vl817.yaml#
diff --git a/include/dt-bindings/ata/ahci.h b/include/dt-bindings/ata/ahci.h
index 77997b35612c..b3f3b7cf9af8 100644
--- a/include/dt-bindings/ata/ahci.h
+++ b/include/dt-bindings/ata/ahci.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause */
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
 /*
  * This header provides constants for most AHCI bindings.
  */
diff --git a/include/dt-bindings/clock/hi3559av100-clock.h b/include/dt-bindings/clock/hi3559av100-clock.h
index 5fe7689010a0..a4f0e997546c 100644
--- a/include/dt-bindings/clock/hi3559av100-clock.h
+++ b/include/dt-bindings/clock/hi3559av100-clock.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later or BSD-2-Clause */
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause */
 /*
  * Copyright (c) 2019-2020, Huawei Tech. Co., Ltd.
  *
diff --git a/include/dt-bindings/clock/r8a779f0-cpg-mssr.h b/include/dt-bindings/clock/r8a779f0-cpg-mssr.h
index f2ae1c6a82dd..c34be5624954 100644
--- a/include/dt-bindings/clock/r8a779f0-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a779f0-cpg-mssr.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/dt-bindings/clock/rockchip,rk3588-cru.h
index b5616bca7b44..5790b1391201 100644
--- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
+++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
  * Copyright (c) 2021 Rockchip Electronics Co. Ltd.
  * Copyright (c) 2022 Collabora Ltd.
diff --git a/include/dt-bindings/clock/stm32mp1-clks.h b/include/dt-bindings/clock/stm32mp1-clks.h
index 25e8cfd43459..0a5324bcdbda 100644
--- a/include/dt-bindings/clock/stm32mp1-clks.h
+++ b/include/dt-bindings/clock/stm32mp1-clks.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
  * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
diff --git a/include/dt-bindings/clock/sun20i-d1-ccu.h b/include/dt-bindings/clock/sun20i-d1-ccu.h
index e143b9929763..fdbfb404f92a 100644
--- a/include/dt-bindings/clock/sun20i-d1-ccu.h
+++ b/include/dt-bindings/clock/sun20i-d1-ccu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (C) 2020 huangzhenwei@allwinnertech.com
  * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
diff --git a/include/dt-bindings/clock/sun20i-d1-r-ccu.h b/include/dt-bindings/clock/sun20i-d1-r-ccu.h
index 4c2697fd32b0..f95c170711e5 100644
--- a/include/dt-bindings/clock/sun20i-d1-r-ccu.h
+++ b/include/dt-bindings/clock/sun20i-d1-r-ccu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
  */
diff --git a/include/dt-bindings/clock/sun50i-a100-ccu.h b/include/dt-bindings/clock/sun50i-a100-ccu.h
index 28dc36e1a232..06a2031d466b 100644
--- a/include/dt-bindings/clock/sun50i-a100-ccu.h
+++ b/include/dt-bindings/clock/sun50i-a100-ccu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
  */
diff --git a/include/dt-bindings/clock/sun50i-h6-ccu.h b/include/dt-bindings/clock/sun50i-h6-ccu.h
index a1545cd60e75..ef9123d81937 100644
--- a/include/dt-bindings/clock/sun50i-h6-ccu.h
+++ b/include/dt-bindings/clock/sun50i-h6-ccu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
  */
diff --git a/include/dt-bindings/clock/sun50i-h616-ccu.h b/include/dt-bindings/clock/sun50i-h616-ccu.h
index 1191aca53ac6..6f8f01e67628 100644
--- a/include/dt-bindings/clock/sun50i-h616-ccu.h
+++ b/include/dt-bindings/clock/sun50i-h616-ccu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (C) 2020 Arm Ltd.
  */
diff --git a/include/dt-bindings/clock/sun6i-rtc.h b/include/dt-bindings/clock/sun6i-rtc.h
index c845493e4d37..3bd3aa3d57ce 100644
--- a/include/dt-bindings/clock/sun6i-rtc.h
+++ b/include/dt-bindings/clock/sun6i-rtc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 
 #ifndef _DT_BINDINGS_CLK_SUN6I_RTC_H_
 #define _DT_BINDINGS_CLK_SUN6I_RTC_H_
diff --git a/include/dt-bindings/display/sdtv-standards.h b/include/dt-bindings/display/sdtv-standards.h
index fbc1a3db2ea7..8249a2b47b79 100644
--- a/include/dt-bindings/display/sdtv-standards.h
+++ b/include/dt-bindings/display/sdtv-standards.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only or X11 */
+/* SPDX-License-Identifier: GPL-2.0-only OR X11 */
 /*
  * Copyright 2019 Pengutronix, Marco Felsch <kernel@pengutronix.de>
  */
diff --git a/include/dt-bindings/gpio/meson-g12a-gpio.h b/include/dt-bindings/gpio/meson-g12a-gpio.h
index f7bd69350d18..fa7bb0bbf010 100644
--- a/include/dt-bindings/gpio/meson-g12a-gpio.h
+++ b/include/dt-bindings/gpio/meson-g12a-gpio.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
  * Author: Xingyu Chen <xingyu.chen@amlogic.com>
diff --git a/include/dt-bindings/power/amlogic,c3-pwrc.h b/include/dt-bindings/power/amlogic,c3-pwrc.h
index 1d98a25b08a4..61759df4b2e7 100644
--- a/include/dt-bindings/power/amlogic,c3-pwrc.h
+++ b/include/dt-bindings/power/amlogic,c3-pwrc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2023 Amlogic, Inc.
  * Author: hongyu chen1 <hongyu.chen1@amlogic.com>
diff --git a/include/dt-bindings/power/meson-a1-power.h b/include/dt-bindings/power/meson-a1-power.h
index 6cf50bfb8ccf..724c370d6853 100644
--- a/include/dt-bindings/power/meson-a1-power.h
+++ b/include/dt-bindings/power/meson-a1-power.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2019 Amlogic, Inc.
  * Author: Jianxin Pan <jianxin.pan@amlogic.com>
diff --git a/include/dt-bindings/power/meson-axg-power.h b/include/dt-bindings/power/meson-axg-power.h
index e5243884b249..ace0e468ce21 100644
--- a/include/dt-bindings/power/meson-axg-power.h
+++ b/include/dt-bindings/power/meson-axg-power.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2020 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
index 93b03bdd60b7..44ec0c50e340 100644
--- a/include/dt-bindings/power/meson-g12a-power.h
+++ b/include/dt-bindings/power/meson-g12a-power.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2019 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
diff --git a/include/dt-bindings/power/meson-gxbb-power.h b/include/dt-bindings/power/meson-gxbb-power.h
index 1262dac696c0..8d0b32b6c02c 100644
--- a/include/dt-bindings/power/meson-gxbb-power.h
+++ b/include/dt-bindings/power/meson-gxbb-power.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2019 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
diff --git a/include/dt-bindings/power/meson-s4-power.h b/include/dt-bindings/power/meson-s4-power.h
index 462dd2cb938b..f210a524a592 100644
--- a/include/dt-bindings/power/meson-s4-power.h
+++ b/include/dt-bindings/power/meson-s4-power.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2021 Amlogic, Inc.
  * Author: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
diff --git a/include/dt-bindings/power/meson-sm1-power.h b/include/dt-bindings/power/meson-sm1-power.h
index a020ab00c134..d78e710dbfff 100644
--- a/include/dt-bindings/power/meson-sm1-power.h
+++ b/include/dt-bindings/power/meson-sm1-power.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2019 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
diff --git a/include/dt-bindings/power/meson8-power.h b/include/dt-bindings/power/meson8-power.h
index dd8b2ddb82a7..7a55ba2cd22e 100644
--- a/include/dt-bindings/power/meson8-power.h
+++ b/include/dt-bindings/power/meson8-power.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2019 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
  */
diff --git a/include/dt-bindings/power/r8a779f0-sysc.h b/include/dt-bindings/power/r8a779f0-sysc.h
index 0ec8ad727ed9..cde1536e9ed0 100644
--- a/include/dt-bindings/power/r8a779f0-sysc.h
+++ b/include/dt-bindings/power/r8a779f0-sysc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
diff --git a/include/dt-bindings/power/rk3588-power.h b/include/dt-bindings/power/rk3588-power.h
index 1b92fec013cb..6b91a50cc6d6 100644
--- a/include/dt-bindings/power/rk3588-power.h
+++ b/include/dt-bindings/power/rk3588-power.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 #ifndef __DT_BINDINGS_POWER_RK3588_POWER_H__
 #define __DT_BINDINGS_POWER_RK3588_POWER_H__
 
diff --git a/include/dt-bindings/power/summit,smb347-charger.h b/include/dt-bindings/power/summit,smb347-charger.h
index 3205699b5e41..14f2f9cf2020 100644
--- a/include/dt-bindings/power/summit,smb347-charger.h
+++ b/include/dt-bindings/power/summit,smb347-charger.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0-or-later or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR MIT) */
 /*
  * Author: David Heidelberg <david@ixit.cz>
  */
diff --git a/include/dt-bindings/reset/rockchip,rk3588-cru.h b/include/dt-bindings/reset/rockchip,rk3588-cru.h
index 738e56aead93..d4264db2a07f 100644
--- a/include/dt-bindings/reset/rockchip,rk3588-cru.h
+++ b/include/dt-bindings/reset/rockchip,rk3588-cru.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
  * Copyright (c) 2021 Rockchip Electronics Co. Ltd.
  * Copyright (c) 2022 Collabora Ltd.
diff --git a/include/dt-bindings/reset/stm32mp1-resets.h b/include/dt-bindings/reset/stm32mp1-resets.h
index 4ffa7c3612e6..9071f139649f 100644
--- a/include/dt-bindings/reset/stm32mp1-resets.h
+++ b/include/dt-bindings/reset/stm32mp1-resets.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
  * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
diff --git a/include/dt-bindings/reset/sun20i-d1-ccu.h b/include/dt-bindings/reset/sun20i-d1-ccu.h
index f8001cf50bf1..79e52aca5912 100644
--- a/include/dt-bindings/reset/sun20i-d1-ccu.h
+++ b/include/dt-bindings/reset/sun20i-d1-ccu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2020 huangzhenwei@allwinnertech.com
  * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
diff --git a/include/dt-bindings/reset/sun20i-d1-r-ccu.h b/include/dt-bindings/reset/sun20i-d1-r-ccu.h
index d93d6423d283..e20babc990af 100644
--- a/include/dt-bindings/reset/sun20i-d1-r-ccu.h
+++ b/include/dt-bindings/reset/sun20i-d1-r-ccu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
  */
diff --git a/include/dt-bindings/reset/sun50i-a100-ccu.h b/include/dt-bindings/reset/sun50i-a100-ccu.h
index 55c0ada99885..d13764bc1860 100644
--- a/include/dt-bindings/reset/sun50i-a100-ccu.h
+++ b/include/dt-bindings/reset/sun50i-a100-ccu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
  */
diff --git a/include/dt-bindings/reset/sun50i-a100-r-ccu.h b/include/dt-bindings/reset/sun50i-a100-r-ccu.h
index 737bf6f66626..1e7c4431f03c 100644
--- a/include/dt-bindings/reset/sun50i-a100-r-ccu.h
+++ b/include/dt-bindings/reset/sun50i-a100-r-ccu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
  */
diff --git a/include/dt-bindings/reset/sun50i-h6-ccu.h b/include/dt-bindings/reset/sun50i-h6-ccu.h
index 81106f455097..d038ddfa4818 100644
--- a/include/dt-bindings/reset/sun50i-h6-ccu.h
+++ b/include/dt-bindings/reset/sun50i-h6-ccu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
  */
diff --git a/include/dt-bindings/reset/sun50i-h6-r-ccu.h b/include/dt-bindings/reset/sun50i-h6-r-ccu.h
index 7950e799c76d..d541ade884fc 100644
--- a/include/dt-bindings/reset/sun50i-h6-r-ccu.h
+++ b/include/dt-bindings/reset/sun50i-h6-r-ccu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
  */
diff --git a/include/dt-bindings/reset/sun50i-h616-ccu.h b/include/dt-bindings/reset/sun50i-h616-ccu.h
index cb6285a8d128..1bd8bb0a11be 100644
--- a/include/dt-bindings/reset/sun50i-h616-ccu.h
+++ b/include/dt-bindings/reset/sun50i-h616-ccu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (C) 2020 Arm Ltd.
  */
-- 
2.34.1

