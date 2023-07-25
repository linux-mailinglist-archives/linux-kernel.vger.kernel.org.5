Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE3760484
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjGYBAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGYBAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:00:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA78310FA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:00:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e6541c98so4666960b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690246847; x=1690851647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vubcOJoroAr2qpLW2iybw1ATfvK07sgIvUXsKV/dGPo=;
        b=ZdxNwW6iD+ATHVZZmgMI/K5jv3cH2Ujnpa1n4KF84BDR/TFSOAgnarse9TTxC1kVHW
         xqBDH5rfDJk7lEaPUaVKWLlKqeZAlNF29DCSuXXiQyo5L3nvzeoUUq/9qe1Y0BSiJfzm
         1C9AS63LVx0DIY0JJfZkSjBJ/T9s6e7yPM//pm91rXImPCUIDMJISbUUboI3IapNhzBk
         0aQYmbQX7yeZcu2vlGe7QfCW5B8UjmClt7XtvwAa28hca7hr1AJ0/KAWYXrv0WRRKIVO
         oyZ8IFYxB/66dZR4O9OkKlipdd4bGMWHqmQLrQ1By1Uozf8yhIxDXeyFxKOFpQx3sRP1
         mPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690246847; x=1690851647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vubcOJoroAr2qpLW2iybw1ATfvK07sgIvUXsKV/dGPo=;
        b=FC8uNAJigoEfjaQovqOn7mwAN7MRTkOEyY68e3XSko4caR2EYy66SQkv0ovbZZMLrY
         ZT3M+EFoweLsWCAPHsyjKvEdBahBQBtdE3DyLZ3SC+ruagz9FXxWqevbEeqBfKSHi8+R
         vZ9W7/VPuz28eFOfLaltvVHoLGFU+Mjh92O33Hg5BuWXu3A71M9NjqKY6vUzX6f1cNaG
         NkoiGsMuhIKrB2Elw/GulxoMKi85fMrXaIgmQJduOcLyRuoo+TLGUc/ioGj8DjdX65j5
         POO+upQPhhNozW9JlsL92DCs1AdwlOrS9FD/oK8HSdFcEKFWgkClbozdu5MywOrMNaWo
         zdGQ==
X-Gm-Message-State: ABy/qLbx1YpxSYUAnb45dAVP7IlHjLftsZ7JmxuPdsa8Y+eANEl63XOQ
        S4LgW/KR8WDw70el0QOD80ICgg==
X-Google-Smtp-Source: APBJJlEAhjbsPgk3JD0vupzmDd8EQKw4DMuvw92Ytu2yFQiDXb5Y2QzGEzDlhzbWXyacnSEsLpMj0w==
X-Received: by 2002:aa7:88d5:0:b0:63a:ea82:b7b7 with SMTP id k21-20020aa788d5000000b0063aea82b7b7mr13452644pff.28.1690246847286;
        Mon, 24 Jul 2023 18:00:47 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2cbf:9196:a906:e222])
        by smtp.gmail.com with ESMTPSA id h18-20020a62b412000000b00682a75a50e3sm8576900pfn.17.2023.07.24.18.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 18:00:45 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Mon, 24 Jul 2023 17:59:16 -0700
Subject: [PATCH RFC 2/4] riscv: dts: thead: Add TH1520 mmc controller and
 sdhci clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-th1520-emmc-v1-2-cca1b2533da2@baylibre.com>
References: <20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com>
In-Reply-To: <20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690246840; l=1329;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=6awbEzIrA6nzn4c2XYrw0EelLQcw8R2AyCuPywQYMDA=;
 b=K/Sjhx5qpvJO6IrC2wQpAqRt+DIritcPNunTAz3bS4QTSmeXIj/8HZ8iSzjVoM9e4wViBk+q+
 s1qzxGvdPrQB5vXLmlawMw5qj8+rijZgtPdfrY4hxhbHh7fXpKK1n+2
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the SDHCI fixed clock and the first mmc controller which
is typically connected to the eMMC device.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 56a73134b49e..b33bfb04c955 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -134,6 +134,13 @@ uart_sclk: uart-sclk-clock {
 		#clock-cells = <0>;
 	};
 
+	sdhci_clk: sdhci-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <198000000>;
+		clock-output-names = "sdhci_clk";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -291,6 +298,16 @@ dmac0: dma-controller@ffefc00000 {
 			status = "disabled";
 		};
 
+		mmc0: mmc@ffe7080000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7080000 0x0 0x10000
+			       0xff 0xef014060 0x0 0x4>;
+			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "sdhciirq";
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+		};
+
 		timer0: timer@ffefc32000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xefc32000 0x0 0x14>;

-- 
2.34.1

