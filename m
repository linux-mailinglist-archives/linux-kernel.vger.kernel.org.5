Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C937EB83A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjKNVIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjKNVIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:08:19 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB54FD3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:08:12 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1ea98ad294cso2989478fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699996092; x=1700600892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sez5TNXPSBGATbv4iH/EIetO26Yi46HMN2DlkNo1h/Y=;
        b=EQdgnux3ySpzlG+ZpdaXbVSbtmGgOgk/OgXiCjgdAPBluXeYam2kcYmhIZJqmJg0ic
         PYlXfuhUJUxqdOt+pBbPADW4vCGodjcRed0HFDGiPx7iXNESYZV5qAcMerPb0sfOKNjx
         Ax9zCmkOPR08MCsYS/w04FBrcJeTLK1Rb12O/8lS9R48xkEC/hLN4jZjJwW2wvP+LzkQ
         kAz5i1AC7b7FpFYIaRNnhWf/mF/YuDYXkYEFswC+sp/dcDTEt6ZVgb9rAfSb/UOFOCul
         vq7TKn+XGGIg0xy/tR01ZuSLnKvG0X7+Kt58ogY8TPoy8hu3jmP5QUf6MTIRlDp6/+DH
         yHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996092; x=1700600892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sez5TNXPSBGATbv4iH/EIetO26Yi46HMN2DlkNo1h/Y=;
        b=pX0tyKQRHUC3tQNPLw75tXBUgEPS4pqcM0O1+2pdZOrzsLV1mfZJ7htB9lHsD0dH76
         fROYjb5rnOQfcGINKtksHII3V9VcNEmvffNgGdjh0hdcW+4mUef4i8fNDdafhXMaIU9Y
         LLsOqOch96nQP+OLta4+s2Alc9rml05W6hjoWqDQkgvY1aVGttJCPbq8inAsnjydfPO5
         rtxAWiC2jaqPuuCGzf+ttc0L+2JI9xt12IfP3pbnjK+OsXamHCRPNicy1JtjhJNxS+KZ
         yCBDNK5L3qPNkFZg26g6t3CJWFXtaklL+OpnHiYSJdmY1TgGmwe4unaOn8nd35IQJQ9c
         IcSA==
X-Gm-Message-State: AOJu0YxpfK8gvE7gmx2iTYFPmVsSYgoG+oqeOszmpmy5QAaNCKw0peGj
        noCgBqp7VZmGsXcSHdcBpAJjjg==
X-Google-Smtp-Source: AGHT+IH8BurOsz3HvxflMOcmou3k9iE9yOvNj8QSVkmj8wmmZZH9NXkHgQkBGtnbIJL3wDlNIlsdBw==
X-Received: by 2002:a05:6870:6ec4:b0:1ea:2447:5181 with SMTP id qv4-20020a0568706ec400b001ea24475181mr10001030oab.9.1699996092052;
        Tue, 14 Nov 2023 13:08:12 -0800 (PST)
Received: from [127.0.1.1] ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id x16-20020ac85390000000b004198d026be6sm3027549qtp.35.2023.11.14.13.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:08:11 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Tue, 14 Nov 2023 16:07:59 -0500
Subject: [PATCH v6 5/7] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-th1520-mmc-v6-5-3273c661a571@baylibre.com>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
In-Reply-To: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699996086; l=1662;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=5F3cUoM9uPwZr3nAbkkg8hlE/aYbHbZypGZJHmRKKkc=;
 b=sThdFfxHu7C2ISnkASyL2+wqHUobTAv8LAVRkg+GAuiicLGX3E6KGT3ZKwLzgZL2o3ywX/aly
 pVCC5HUCjOrDQuteATDqXpsfo/PxZDp6Iyt51XFI1h/TTmrr5Ki+T4F
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the SDHCI fixed clock. Add mmc0 node for the first mmc
controller instance which is typically connected to the eMMC device.
Add mmc1 node for the second mmc controller instance which is typically
connected to microSD slot.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index ff364709a6df..fb8a4a04d3c4 100644
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
@@ -292,6 +299,24 @@ dmac0: dma-controller@ffefc00000 {
 			status = "disabled";
 		};
 
+		mmc0: mmc@ffe7080000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7080000 0x0 0x10000>;
+			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+			status = "disabled";
+		};
+
+		mmc1: mmc@ffe7090000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7090000 0x0 0x10000>;
+			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+			status = "disabled";
+		};
+
 		timer0: timer@ffefc32000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xefc32000 0x0 0x14>;

-- 
2.34.1

