Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DBE755888
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 00:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGPWI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 18:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjGPWIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 18:08:02 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E215D9;
        Sun, 16 Jul 2023 15:08:01 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso6047852e87.0;
        Sun, 16 Jul 2023 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689545279; x=1692137279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nYE1OzOeBhQccZCxRXCiW95lO3wfa+AK9o1IGYC1QEk=;
        b=mcleJj0N4p5jnexgIjLEROM9yVpEYHkS4+f5PJqcySiGowsNdRsfEK37ijJJMRglpq
         U54P6efV26VIlGsn5CeHSeZq24EQ5M7aGd8JRRfLpLOYt1+MhFn0Dk8X9PX4uBqbgy27
         FW2OikEFhYVBCgxbEQym6bSI91iqbHAWYeUSYjVHRM6fXzmYamG5ZFbbUb8KPjpi8Ici
         bpC5HfuNeiGJXRuDEgPQS1/Zu4X2aNkEnT4UqXMH2BD8RmED0vNPwlNfKIMyAcdP0Gd4
         r+ljQibTDa4pVdkyTJMmLL2K2t9V2guNJrPTmdqnLsvgY+V2BkkB4HGeKZBpJ/VsceII
         X47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689545279; x=1692137279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYE1OzOeBhQccZCxRXCiW95lO3wfa+AK9o1IGYC1QEk=;
        b=RW8Opz6hiK2KGFzAKgovfbhYnPqvVJnLVVdKzZ+F2wSwQDkxCa33pu+/8ijX/1JG4k
         xzLb14woavxuO+z0ATUREeKjIeqptyb2yrZDJoxTjXADUi5hiQWWV4wp3BgVf/7b5+D3
         N0W3LEoUpmNNZZIVBFe/TKZb0uQfn4RPc4Uco8PATcI93uyjdFrU6B4973BS+Ckhh8/R
         G86GgQWGklkFHyPgKPHhHbPtyFzVe1OxIYVhQrGidEZRN6nv2XlIqcrALnSlHL08YR1N
         zlvQRen65eMkuMIOT0ypszaJA7w9WOnncO+TubCTeidZJ1ReaVLTpHmu/MFpKDtQMWDc
         lD6g==
X-Gm-Message-State: ABy/qLbrwYFDzRDhCBarRNELsMy9DsdlGP+uVmpAbFomOOzTSPzwtXdd
        JGi0Mptv965tEz77H2eI6/j8MR1hxy8=
X-Google-Smtp-Source: APBJJlEf+EqwAxr612OkC2gor1oXdI8hiJYGKttK8HAoCeLvLWSCKo7eVDVyGopxp7f8UeIRh9M7wQ==
X-Received: by 2002:a05:6512:202c:b0:4f9:69b8:1e7c with SMTP id s12-20020a056512202c00b004f969b81e7cmr6163150lfs.46.1689545279021;
        Sun, 16 Jul 2023 15:07:59 -0700 (PDT)
Received: from localhost.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id h24-20020a197018000000b004fb9c625b4asm2464091lfc.210.2023.07.16.15.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 15:07:58 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Add various peripheral support for K3G
Date:   Mon, 17 Jul 2023 01:05:01 +0300
Message-ID: <20230716220644.22158-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for some peripherals installed on
Samsung Galaxy S5 (SM-G900H). This includes the WiFi card,
GPIO keys, fuel gauge, touchkeys, notification LED and display.
Also documents the peripherals for which we currently lack drivers.

Markuss Broks (7):
  ARM: dts: exynos: k3g: Add WiFi card support
  ARM: dts: exynos: Add GPIO keys support for k3g
  ARM: dts: exynos: k3g: Add fuel gauge support
  ARM: dts: exynos: k3g: Add touchkeys support
  ARM: dts: exynos: k3g: Add notification LED support
  ARM: dts: exynos: k3g: Document the devices which are not supported
  ARM: dts: exynos: k3g: Add display support

 arch/arm/boot/dts/exynos5422-samsung-k3g.dts | 256 +++++++++++++++++++
 1 file changed, 256 insertions(+)

-- 
2.41.0

