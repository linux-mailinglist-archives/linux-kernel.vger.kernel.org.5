Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B43F7FE669
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbjK3BtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3BtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:49:10 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1661A3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:49:16 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfbda041f3so4485145ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701308956; x=1701913756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Jr7JkNTCoyAHbuKHVkD5XQJ6tzPUzNpAQ8g+iKdWxE=;
        b=YpPDzzfglEuXfTgqsAREQ/UmOmzlttalzqR38FsnqnLz3f6LOaFQ5gAzk5sB324vN5
         QzDaDxpbj1YEgJi+cOV7zyYYX2Kk1WtLf2QjuEONPY7QVQriMl5iEVSXciCM9sjuVmY8
         TBstW97607j/i6hdGUK+hMR6Tf7aEBBQB5FxBqY/AUfKjWALA6nXmx6vJjY7XC/vTjqf
         +Q4S+0HW1MyB3JSrehINz80CduAFhIApCg95gN1OhD4iNpqAPiF4OCwekZUEyU4l2HLm
         noWLhuM7BXjPV91ql0p5KMdvj+HYRxglm0R0pka+Z71FAGRFpiKvSrrtK80NuGxSiYr4
         R+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308956; x=1701913756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Jr7JkNTCoyAHbuKHVkD5XQJ6tzPUzNpAQ8g+iKdWxE=;
        b=kO66z/oLqAVnDG3cgSWNSBV6cqPXVfkvHsr261dAQ2aXfLlcDdbCg4+ORWCyWgGSqZ
         JlQ7jYoxtJG40+qh8c7OQ6hPCghoWGE+UQ3Kf9ZFbsDmfH0dfSJwbrXu1tAEEVZkjwxO
         F+FvakyhkCLiYzH2s0yktwQlgzjhZC4d4FZyPsgFobh5lf3XZ6CAhYJCDky+LAqtCJFu
         gIwMNwSUh2sUueMmN6Q07QX0tcM+0QlSDcxUP3Bp0LYbKVrJ32Z5gE2avAfJtN+WoJhm
         4I3NLy4CQZmTK2Qv+Wb/v/gw6Td8P7AlRuLztwH3Fphl6bjTvpC0KwiFBLGAeMpOiEwt
         XK0A==
X-Gm-Message-State: AOJu0YzRVYkBtqrfeYOBrP8WVvwPx46Z8vrZeYynnji1abD5ZWh6gn4Y
        HDgq7HMpHb0AE+/AEnLsZbRT9w==
X-Google-Smtp-Source: AGHT+IHQc/jfjKv11FHDAZ6SssqWcsxklBpB0+uT5dFsDWyCXUV6EYlxkHDsqbFW3Z2rHO8iX8TjLw==
X-Received: by 2002:a17:902:e74f:b0:1cf:e4d2:bdf with SMTP id p15-20020a170902e74f00b001cfe4d20bdfmr9817512plf.51.1701308955904;
        Wed, 29 Nov 2023 17:49:15 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:9707:1e8c:3166:6a23])
        by smtp.gmail.com with ESMTPSA id bc3-20020a170902930300b001d00b0bd306sm24455plb.251.2023.11.29.17.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:49:15 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Wed, 29 Nov 2023 17:48:49 -0800
Subject: [PATCH v7 3/4] riscv: dts: thead: Enable BeagleV Ahead eMMC and
 microSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-th1520_mmc_dts-v7-3-c77fc19caa6f@baylibre.com>
References: <20231129-th1520_mmc_dts-v7-0-c77fc19caa6f@baylibre.com>
In-Reply-To: <20231129-th1520_mmc_dts-v7-0-c77fc19caa6f@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701308949; l=1108;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=x4GrcOzQSHp6HC4WBUnYJkDmvdf8pnCHmIBijw3/K20=;
 b=22ATaiedZ7qoXu7rErPn74nYsPkB3Xum86xjFWOL/OdPNZV6jrsAtQx7tUW/pYkpE0TebmKFx
 QJ3R6ApWzRtC9w/W/38Qwc+tU4oYlO2rQu8Cnr0Ga7klX1hTo7W2d4y
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mmc0 properties for the eMMC device and add mmc1 properties for
the microSD slot. Set the frequency for the sdhci clock.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index 70e8042c8304..b767d3f078d7 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -48,6 +48,10 @@ &apb_clk {
 	clock-frequency = <62500000>;
 };
 
+&sdhci_clk {
+	clock-frequency = <198000000>;
+};
+
 &uart_sclk {
 	clock-frequency = <100000000>;
 };
@@ -56,6 +60,22 @@ &dmac0 {
 	status = "okay";
 };
 
+&mmc0 {
+	bus-width = <8>;
+	max-frequency = <198000000>;
+	mmc-hs400-1_8v;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&mmc1 {
+	bus-width = <4>;
+	max-frequency = <198000000>;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };

-- 
2.34.1

