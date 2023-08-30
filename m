Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3274778E01E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243772AbjH3TVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242905AbjH3J6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:58:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F66A1BF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:58:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-500a398cda5so8598720e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693389522; x=1693994322; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ImC06/+tS7Twj3eQRRUsuycUqqVXH052q1hemh/ikWU=;
        b=r8GAC4lMHUa5I2T/ySPKd0cIPPQWidpqX97LzVX/TOy2IDuwivuTKw8Iqz6DA1VQa/
         OhFvUiDvaCIz0TNirzmBBK15++Vh0P+RiGU2RZfYPIPTR3zqJCoL242WasZCd3Jf4ggt
         fYi+QCfjcNwHIWoAvP48Fnl5foc1u4ZK0KJuTuHxxwiaipK+AFmotyUc3xkom+RpsL+V
         njQA0ZTUlUhBDurGXIM8dqBq7pZfioWaNfD6VjN/QnbQOquX/9vlivBZ77/Bs7tHF7dc
         1/vlbj454uSNwRyAIPqc3hRzyCrEiCoCKBXWVU+P4sYVqoAEeF4quaM1zoncUfiJREG6
         GvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693389522; x=1693994322;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImC06/+tS7Twj3eQRRUsuycUqqVXH052q1hemh/ikWU=;
        b=DEa7dGKJDLjRyJVc0PU6AMJKxS8QeT+JEZ9oPOK2ZFhH/hpmZhugW3+QTCngXdr7Xe
         sWZwgxVFeaXX4UeEJpyuRQSWVU95xhmfX7RM8pkoeInFzJ/L5aaX1iU3VSoTdocYbKmL
         HxB4MEUM37UfVsbW2ryOLTqi2nu2pzjVUEcB++C7EdogUZLahUi3z4hGWLnFk8fAU8ni
         +tQ0Mb5UC4d12yjGOotyloJtYyaxCG+kdOrziyhzHnXuKAGYlPCtbWO2vqtoW4WKRWdP
         eV5HbPrb/7Zd4dOXQwprtZAnC9dcQkGL03cN4DUHavVOCh73SEpSVmOJ3RiharrrMUdk
         5P1g==
X-Gm-Message-State: AOJu0Ywp0l84AjEBO3utAIOg4OqtiCGC0SDA4IbC6BAdtYgjDbtLng/x
        Cux1BB7Fs7x9ge4QQCLkZS7Owg==
X-Google-Smtp-Source: AGHT+IHhkgd47WHbYn3fJiBbQlVzHfchnV6Zhz/9BP+uHBaTqzKkkSmXoZ5vGmgUP4lJA5UX0lAuqQ==
X-Received: by 2002:a05:6512:224c:b0:4fe:cc2:247a with SMTP id i12-20020a056512224c00b004fe0cc2247amr1121093lfu.49.1693389522330;
        Wed, 30 Aug 2023 02:58:42 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (5073ED84.static.ziggozakelijk.nl. [80.115.237.132])
        by smtp.gmail.com with ESMTPSA id i15-20020a1709064ecf00b009a2202bfce5sm6957130ejv.118.2023.08.30.02.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:58:41 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 00/11] Initial support for the Fairphone 5 smartphone
Date:   Wed, 30 Aug 2023 11:58:25 +0200
Message-Id: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMES72QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC0ML3bQCU93MvMySzMQc3SSzZAsjQ4OkRMtkCyWgjoKi1LTMCrBp0bG
 1tQCNAZuXXQAAAA==
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to boot up mainline kernel on the QCM6490-based Fairphone 5
smartphone.

These patches only cover a part of the functionality brought up on
mainline so far, with the rest needing larger dts and driver changes or
depend on patches that are not yet merged. I will work on sending those
once these base patches here have settled.

Since QCM6490, like SC7280 are 'yupik' in the vendor-provided kernel, we
can base the dts on it and leverage existing support. Though current
sc7280 support mostly assumes ChromeOS devices which have a different
TrustZone setup, so we need to move some ChromeOS-specific bits to the
sc7280-chrome-common.dtsi file to make it boot on a standard TZ board.

Depends on (just for the #include in sc7280.dtsi):
https://lore.kernel.org/linux-arm-msm/20230818-qcom-vmid-defines-v1-1-45b610c96b13@fairphone.com/

The pm7250b patch has been picked up from this series:
https://lore.kernel.org/linux-arm-msm/20230407-pm7250b-sid-v1-2-fc648478cc25@fairphone.com/

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (11):
      arm64: dts: qcom: sc7280: Mark some nodes as 'reserved'
      nvmem: qfprom: Mark core clk as optional
      arm64: dts: qcom: sc7280: Move qfprom clock to chrome-common
      arm64: dts: qcom: pm7250b: make SID configurable
      arm64: dts: qcom: pm8350c: Add flash led node
      dt-bindings: pinctrl: qcom,sc7280: Allow gpio-reserved-ranges
      dt-bindings: arm: qcom,ids: Add SoC ID for QCM6490
      soc: qcom: socinfo: Add SoC ID for QCM6490
      cpufreq: Add QCM6490 to cpufreq-dt-platdev blocklist
      dt-bindings: arm: qcom: Add QCM6490 Fairphone 5
      arm64: dts: qcom: qcm6490: Add device-tree for Fairphone 5

 Documentation/devicetree/bindings/arm/qcom.yaml    |   6 +
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml      |   4 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              |  23 +-
 arch/arm64/boot/dts/qcom/pm8350c.dtsi              |   6 +
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 659 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |  17 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   7 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
 drivers/nvmem/qfprom.c                             |   2 +-
 drivers/soc/qcom/socinfo.c                         |   1 +
 include/dt-bindings/arm/qcom,ids.h                 |   1 +
 12 files changed, 717 insertions(+), 11 deletions(-)
---
base-commit: 0255bba921438ea1e45d3f0873c3e8c5a1e03876
change-id: 20230818-fp5-initial-b6c8210ba9c8

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

