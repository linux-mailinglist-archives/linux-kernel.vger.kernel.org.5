Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F5C7890DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjHYVzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjHYVyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:54:49 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381F826AF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:54:47 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a36b52b4a4so773678b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693000486; x=1693605286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ED3W7s12gubynwmMQJJ5mT7Z84AD3DiBoyeGrhqMwHs=;
        b=q+NdNGNUcySfhgoSgFumNTOS4wlUTngAqhcxwENzdMjVjwoEjkXDVt7d4Q9NcGZHZ0
         JwioqaoDWsbNQobKHqLJGUbU63inXej8lUUewxxQ0K2T57zAepCEiicq+GfBTySmbeXK
         gRrikx7nWnEygE7Iy7JaEW9sCGcUzpCNYHEkX/Up7el7E6BB7kHCOmQoJ7pJli3foc3L
         tSBU3gNTwtR/OGutFxtR/vavFCKkGJCNVuHcB0EEe0c+hDYSXtdp+DhFUjS+tG4MVLLB
         H3IMOOGJJLaC9c4LaDjrdDcrYP8NsLqkgLXNrjz1jWHpB9p/98c6WfY72ZbLp4nGoM2u
         qCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693000486; x=1693605286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ED3W7s12gubynwmMQJJ5mT7Z84AD3DiBoyeGrhqMwHs=;
        b=hdlgY+QXne8nffhaB0QmGj5ZN4yqZz3UaK1Tr/+bVmJ1Boe4A5Ao4EhrjJrXgcsUo4
         rFMotKk023nAO7n7wojykUQDaSK90NIxLGsEdigV73Wxha3OEtD/lDejquOoO+MpOySv
         2fGTx2HKOF6uqLQVwUeriKJuPqpaiiaXNQ4M5HYvyD4gy5PuRHoar79+5rw9LYyeOeZM
         9JqmkW+FdVMtyOJIIWs3mwaAsWRMBqkG+9LShq3NP4lIHagB2Qt+FkRcrTFCE3AtHooW
         YJEYDGvcTQ2gehwHy/vUbH3zEeBMhDYQUqlfi4T9UULmM0eo6VaSVN7IKqCqDz+ka6Mz
         JmkA==
X-Gm-Message-State: AOJu0YzjspPjK7TpDnLdOCnF3W+XIE+5CQLQ3FXOT7oUQ654mDVlymTT
        oBfTeilUD8Ghv+A+WXMdXLdwGQ==
X-Google-Smtp-Source: AGHT+IHoZV3JvOhzhTqu5b0Kb+MjoNzOTBJvjrpdzduCjg96IVE1UXtO5l3VDKX+pPUzxVDktV/5wA==
X-Received: by 2002:a05:6808:198f:b0:3a7:e779:7fc1 with SMTP id bj15-20020a056808198f00b003a7e7797fc1mr2708077oib.7.1693000486561;
        Fri, 25 Aug 2023 14:54:46 -0700 (PDT)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id r185-20020a4a4ec2000000b00570cb3e8a6dsm1405191ooa.7.2023.08.25.14.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:54:46 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        JaeHun Jung <jh0801.jung@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: dts: exynos: Enable USB for E850-96 board
Date:   Fri, 25 Aug 2023 16:54:43 -0500
Message-Id: <20230825215445.28309-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables USB gadget, USB host and Ethernet support for
E850-96 board. The most major change was done in USB PHY driver, as the
register layout of PHY block in Exynos850 is very different from
Exynos5 one.

Changes in v2:
  - Removed already applied patches from the patch series
  - Rebased on top of latest linux-next
  - Put ranges after compatible in usbdrd node (patch #1)

Sam Protsenko (8):
  dt-bindings: usb: samsung,exynos-dwc3: Add Exynos850 support
  dt-bindings: phy: samsung,usb3-drd-phy: Add Exynos850 support
  usb: dwc3: exynos: Add support for Exynos850 variant
  phy: exynos5-usbdrd: Make it possible to pass custom phy ops
  phy: exynos5-usbdrd: Add 26MHz ref clk support
  phy: exynos5-usbdrd: Add Exynos850 support
  arm64: dts: exynos: Enable USB in Exynos850
  arm64: dts: exynos: Enable USB support on E850-96 board

 .../bindings/phy/samsung,usb3-drd-phy.yaml    |   1 +
 .../bindings/usb/samsung,exynos-dwc3.yaml     |  16 ++
 .../boot/dts/exynos/exynos850-e850-96.dts     |  58 ++++++
 arch/arm64/boot/dts/exynos/exynos850.dtsi     |  30 +++
 drivers/phy/samsung/phy-exynos5-usbdrd.c      | 182 +++++++++++++++++-
 drivers/usb/dwc3/dwc3-exynos.c                |   9 +
 6 files changed, 294 insertions(+), 2 deletions(-)

-- 
2.39.2

