Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A177799C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbjHKVoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbjHKVoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:44:19 -0400
Received: from out-96.mta0.migadu.com (out-96.mta0.migadu.com [91.218.175.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61C92722
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:44:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1691789865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=18Wju2cWFvjmQ9qUiOe/EfSoCb+kWjaIJNtd2yPa9iw=;
        b=g1BRN/Tq8fV2yEN5eyNAMTsBNYEeOJmLKwtabNvAuV2PA1tRvDd7j8Nt35CTfgMvJ2/gHF
        s71DoLXbAS/sMNKNilWkGFZoF8mTAaHnGN8v+TpsLB0ISILFO/30Re6Z4oKUizX+A/BD/K
        K6/R57G66MJr1yJn18OfQ4yyryKfXPU=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/7] Initial support for MSM8x26 Lumias
Date:   Fri, 11 Aug 2023 22:35:17 +0100
Message-ID: <20230811213728.23726-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following patches: 
- Add device tree files for Nokia/Microsoft Lumia phones based around
  the MSM8x26 family of Qualcomm chipsets, utilising a common tree 
- Document this support

Rayyan Ansari (7):
  dt-bindings: arm: qcom: Document MSM8x26-based Lumia phones
  ARM: dts: qcom: add common device tree for MSM8x26-based Lumia phones
  ARM: dts: qcom: add device tree for Nokia Lumia 630
  ARM: dts: qcom: add device tree for Microsoft Lumia 640
  ARM: dts: qcom: add device tree for Microsoft Lumia 640 XL
  ARM: dts: qcom: add device tree for Nokia Lumia 735
  ARM: dts: qcom: add device tree for Nokia Lumia 830

 .../devicetree/bindings/arm/qcom.yaml         |   9 +
 arch/arm/boot/dts/qcom/Makefile               |   5 +
 .../qcom/qcom-msm8226-microsoft-common.dtsi   | 332 ++++++++++++++++++
 .../qcom/qcom-msm8226-microsoft-dempsey.dts   |  17 +
 .../qcom/qcom-msm8226-microsoft-makepeace.dts |  17 +
 .../qcom-msm8226-microsoft-moneypenny.dts     |  23 ++
 .../qcom-msm8926-microsoft-superman-lte.dts   |  52 +++
 .../dts/qcom/qcom-msm8926-microsoft-tesla.dts |  66 ++++
 8 files changed, 521 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-dempsey.dts
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-makepeace.dts
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-moneypenny.dts
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-superman-lte.dts
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-tesla.dts

-- 
2.41.0

