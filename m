Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0787F781702
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 05:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244905AbjHSDR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 23:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244654AbjHSDRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 23:17:35 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB014218
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:17:33 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-56d455462c2so1019840eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692415052; x=1693019852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q7Mi/sRAGm8lhYDAZVLrk5zgyos5NQEy7qr6AIL6DU=;
        b=UbhUG+mLPhnobKlykd6gqCDeeDq8gYEW1q5+RAqlhFXRpBNUiy//H6n0gEWJqpVrcH
         28aRiT4idt5ZYLJBqPU5B2RE2A4MdKUbCIxdO4K/hrpuGv1rzWLUtNJL7dpeflV4nmTN
         r3ofwS0Wmef5p09OdV++XIPPcuWVLFnxW8LWpQUU8zuQ1+d8SOn43mO9XUJCEw2UtP9L
         Z1clpoHaYrlluHt6sKzRuUU3MjQymbq7PUdqzd61X0Ps3CYbs4I7YMHgenuCsv6BXnbe
         YQeYciSH3dB2FnzHwE+5apWRLTKzYLELeJ66GSe1rSbaeQOhKNHA0dkmDWhHgd0XdABW
         z96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692415052; x=1693019852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Q7Mi/sRAGm8lhYDAZVLrk5zgyos5NQEy7qr6AIL6DU=;
        b=AYnjqFsjL+csluQTZ4Vph7D3ADNjtmQ5bneWbX+Z3IgWjBxOGLteuTXyL/CahuYE6p
         YZq/uo54Qu1mEniNZxkIQFApzonm4XuS59ewVhMLIJYXKW4CDndqL5AedO8vVltHeLWf
         BBVvxidtHnkwhaFiFnMyzLRBEs37xBt7UefApotzmxpq6Dv35dv69fZVI38PeRitKOC2
         UJIPu5p5sLPM28fhQpFbf2bU8/uen7OcVuGpixqvIhiCrGGDY+/9gqyFVorJiKSrn/3G
         IiMP4fyLik9EgMLo0fP4fGbOoiNztRmlbeOihygIRJOn935EnkS61/cf556wKL04pkDR
         suoA==
X-Gm-Message-State: AOJu0YzvMwdLZT7++pGbZUtHKAS4dRu8WfF3ANTlBpERcQ3+eMrLZr9Y
        ymz/2Mjvy6uLrnOEAOJfYSAoig==
X-Google-Smtp-Source: AGHT+IFVUmkUoC3QURVVvQmtTQIMGCKsvM2bNgWNvvFiOc8n9HKAZXjCVFIJolRC3nL5ZZHZ4ysstQ==
X-Received: by 2002:a4a:654e:0:b0:56e:4ee2:9189 with SMTP id z14-20020a4a654e000000b0056e4ee29189mr1647457oog.5.1692415052465;
        Fri, 18 Aug 2023 20:17:32 -0700 (PDT)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id v7-20020a4a8c47000000b0054fba751207sm1494141ooj.47.2023.08.18.20.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 20:17:31 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     JaeHun Jung <jh0801.jung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/8] arm64: exynos: Enable USB for E850-96 board
Date:   Fri, 18 Aug 2023 22:17:23 -0500
Message-Id: <20230819031731.22618-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables USB gadget, USB host and Ethernet support for
E850-96 board. The most major change was done in USB PHY driver, as the
register layout of PHY block in Exynos850 is very different from
Exynos5 one.

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

