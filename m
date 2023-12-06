Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D183E807156
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378816AbjLFNz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378730AbjLFNzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:55:47 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB90D49
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:55:53 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cc02e77a9cso6582465b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701870953; x=1702475753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo4sjmVaV/TBAMJQg43OcyML+wJBUfl40Ts13Xx0yio=;
        b=VGVCEW5CyMHN8E1h+aLD/A+6crvPQMWmcbbuWt2k06l3JtSk6Wg5L64bNPXGygSB5D
         SysxNdeZIA7Rta1jwrz637PiEMinkzsfNNI9NUrS83rdED3Ad7C8y8quhRm+ib13IMBb
         gAgx0fhJj6lV7tpIeGWWVI/jUm/naom4JBKzECJTygamAvUf4zz/baATD0jj3bVsTog2
         tx8SmYWhYq8l3QNcz38WSklkzOZiJ4p568ls6Wwrzp1xpmo2G6e2PApJv7xcwR/8LLGC
         NzclMFoRoJ8j081uno4YK0Ipvex1oRpD04GKl8oQG3d0Go5StE/6emG99Nuvw608SQKN
         9PQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870953; x=1702475753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jo4sjmVaV/TBAMJQg43OcyML+wJBUfl40Ts13Xx0yio=;
        b=fK1Aagg+s/CUymopnux8JujcyAmcWneh3kmlhuhURMa6WuXTmVrh0cNlRw9Sw68km5
         VOoMfuqL6LPnWXE0W/azi0nccCgJnyWmgzUssh/WgCtnJUthCLRtxbWyxQtupq9K+iKY
         4Zi3PtqG+aKeA2TWV4jiNVkPVvq9+Hxt24OGGwBFKuN/38RtYvQAPEhJZWbEWUclDxJw
         SrGZi0IsHPnIXl5fwG3GbV2XVwD6L1IseZcNPvv2H8Y0kxwtdVJERrVHIkyAEdQIr5Eg
         PoNpU+wk+KcZgW4Lwbh589VoiLLcpXrRYDImAPBkGqTLPY3xU3rG15I0B4jON/GzKWRR
         TwDA==
X-Gm-Message-State: AOJu0YynBtXtOXpJnbF5ARPdUHIL5zW1OpHrftoa6Y8CTVjdEfeyCfoD
        8DfRGmypFAVK5/AN+IpNBFoZ
X-Google-Smtp-Source: AGHT+IFtRa9+0838RSSI9ko0zFdJdodaKRgyzIqc6JbiWzTHnFiflLRfRI9fQ6/eZ/NpRcFfWuZ26w==
X-Received: by 2002:a05:6a00:3391:b0:6ce:3f6b:638a with SMTP id cm17-20020a056a00339100b006ce3f6b638amr947618pfb.48.1701870953263;
        Wed, 06 Dec 2023 05:55:53 -0800 (PST)
Received: from localhost.localdomain ([117.202.188.104])
        by smtp.gmail.com with ESMTPSA id n38-20020a056a000d6600b006ce91cdb1c4sm1366056pfv.188.2023.12.06.05.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:55:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Qcom PCIe DTS fixes
Date:   Wed,  6 Dec 2023 19:25:37 +0530
Message-Id: <20231206135540.17068-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This small series has some fixes for the PCIe nodes in Qcom DTS.

- Mani

Manivannan Sadhasivam (3):
  ARM: dts: qcom: Use "pcie" as the node name instead of "pci"
  arm64: dts: qcom: Use "pcie" as the node name instead of "pci"
  arm64: dts: qcom: sa8775p: Add missing space between node name and
    braces

 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi           | 2 +-
 arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi | 2 +-
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi           | 2 +-
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi           | 6 +++---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              | 2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi              | 2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi               | 2 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 4 ++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 2 +-
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 8 ++++----
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 4 ++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi               | 4 ++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 6 +++---
 arch/arm64/boot/dts/qcom/sm8350.dtsi               | 4 ++--
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 4 ++--
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 4 ++--
 17 files changed, 31 insertions(+), 31 deletions(-)

-- 
2.25.1

