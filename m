Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB057E45D4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjKGQVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbjKGQUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:20:39 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7F64796
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:55:54 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a98517f3so7255681e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699372552; x=1699977352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdPLm4V5Hkn6PmKk4G4TX5qad8wgg2qashR0qo8Jkhg=;
        b=pDsPALb0e6J1a1jCURrRD9/tXYB1gEpZMaylUGGaYQsiiUgRGOqi/IcW3qs42ixF4r
         CqDFd2DRdX2zRBRAzYMweHNnofPMJ3IOL5YsqGfjNFFWz8hXgggMHQWsPJsrcS9cBgFZ
         IoPJu2BHW0CX/3tOh9fIWXAkwLaq6nb2+2vAUbTWh7on34eZNvJZsKcsBWocChsFjkhJ
         hpOv1RnGrkUf+8plzdhM13sEHK3uTZeOlFRI2xeuzOnF6s19d53kSrzBdX/hsRGiWPRu
         zWVh996Vek1+lRwalCgGE5ObE3RR14iKNoFcwK5EF/nDvu6y7dZ9nGSaPig94WR1ro2A
         gBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699372552; x=1699977352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdPLm4V5Hkn6PmKk4G4TX5qad8wgg2qashR0qo8Jkhg=;
        b=MiNgQhBZLmSJLyDie3sXObWvuvX1gc9F+c6JD9EoabmDgAZxsKCMc5TtadmRcTAsBs
         kJIaJraB2bpfUDAff7zpztUEWcrGrLZEGMfGxwJH9tjdmeLx/Zmjsqm0RutjlvsjYhkQ
         mfBN2k2aS8abl7+Gbfs7Xr7YJDNPo7WI6A1j7KUVpJq0us1p4cW3hVAPVPDZwqotn/B2
         zaidl8G+FxwH1TaOoiRdVTngxcffTWp0x6adk/NDpjewXSvlTq1hZK6xYgFoghD911by
         IeeVNf6pwU6tKL2ugTPOQ6+izslVU9Xd4s8m/WN8CqG+ZTm+kBrSmcLlrzB9C1c4Ud7H
         7qFQ==
X-Gm-Message-State: AOJu0YwVKzMPTCkbZaV9Pwk11+U73tc1E1ID0IYtyVw2Rdv0EPo2iw9S
        eNRuCGNylaVOZvIw8enR6gazSA==
X-Google-Smtp-Source: AGHT+IEdPqFLLB97FsJn9HE6PuUCXYD1MUIYJLqs8/8KgotwzZO95QNjFhJZQBPn7vpBWJhUDXeo1w==
X-Received: by 2002:ac2:5234:0:b0:508:264e:2ded with SMTP id i20-20020ac25234000000b00508264e2dedmr24676229lfl.38.1699372552470;
        Tue, 07 Nov 2023 07:55:52 -0800 (PST)
Received: from arnold.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f6-20020a05600c4e8600b003fefb94ccc9sm16579085wmq.11.2023.11.07.07.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:55:51 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 4/6] ARM64: dts: rk356x: add crypto node
Date:   Tue,  7 Nov 2023 15:55:30 +0000
Message-Id: <20231107155532.3747113-5-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107155532.3747113-1-clabbe@baylibre.com>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both RK3566 and RK3568 have a crypto IP handled by the rk3588 crypto driver so adds a
node for it.

Tested-by: Ricardo Pardini <ricardo@pardini.net>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 0964761e3ce9..c94a1b535c32 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -1070,6 +1070,18 @@ sdhci: mmc@fe310000 {
 		status = "disabled";
 	};
 
+	crypto: crypto@fe380000 {
+		compatible = "rockchip,rk3568-crypto";
+		reg = <0x0 0xfe380000 0x0 0x2000>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_CRYPTO_NS>, <&cru HCLK_CRYPTO_NS>,
+			 <&cru CLK_CRYPTO_NS_CORE>;
+		clock-names = "aclk", "hclk", "core";
+		resets = <&cru SRST_CRYPTO_NS_CORE>;
+		reset-names = "core";
+		status = "okay";
+	};
+
 	i2s0_8ch: i2s@fe400000 {
 		compatible = "rockchip,rk3568-i2s-tdm";
 		reg = <0x0 0xfe400000 0x0 0x1000>;
-- 
2.41.0

