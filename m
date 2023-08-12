Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C92779C23
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 02:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbjHLArp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 20:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbjHLArk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:47:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A695B10DF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:47:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bdbbede5d4so8440035ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691801259; x=1692406059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05BikiCLpUIHGHjBbtQXpjem9/6VYbL8VEjebyzDVSo=;
        b=Nfo84er8B87Ux9oCI5j+m3UNMamRr/ciYPhN73kyWkhw7OIsCMQvJv7TXg37w3Ybh8
         4ZKe/7qjsdKUiUsNd/wAe/YQQtDHl1SatFHBhDQ0l2wahIB0rAGDPhRQhH2Ye3h0fRjp
         R0+afrfQ76Oiab8sNaY976b0rpV8yLs6KcP0d8vvTS7I43DBb2i/0w6OeoLitpveyjJ6
         J40f1AAjoRw0r2+mv9mOMOYapXGipSTC3pVf1B/QPMCtmuqdtg/lnZnnLH4kxI0xj09F
         PzO1zINiaC+dG3XJZ94sPNMsiW6nLKmW4xCuQnAXhWkp9iU5fWFxlrawJNE2BScbW6HL
         YwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691801259; x=1692406059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05BikiCLpUIHGHjBbtQXpjem9/6VYbL8VEjebyzDVSo=;
        b=R7tKe9OS+XR8TV1AN5PBza+fD8QsHHG2Wd1Qtrz9V6tjPFQ2vLtMYEjVpv+v02EryH
         Ky8C96cgQ8lrJ2iHOGaBa5tV0evSIlV+tAWZ3CLCarsj6boZApr2+0/jJ3SGiY+ir8CK
         Yfi8A1sxKugQHLdGw38jqkqFlRbS42MP4a77cr+/xRnhx3CF194JajZMoQx47AIFqteq
         rs+YWKKSymlM4V3/q8Z4wA6UOM6K3FI9dCtjwlgTbzttJvoz5cQ8Hod1qC0qUYc9d8MS
         3dASO/hjzmkDGyA7SOJgFaKXJkSEKzqpNedeXXz6016Rp1MZQkqcWpy17XmuxG8w+9qk
         eIew==
X-Gm-Message-State: AOJu0YxhbLHOf4YHaCuTWGyz2A+oUqzi0RVAhq8QHyWPO2hfAfPnKG63
        fTobQa7zPJWw9m267ynoSbSW5g==
X-Google-Smtp-Source: AGHT+IFdDX562eGbJtNruygyIF2dN53hOpTDe7X+mKpz434vbf5cpu8OlnawmM1dZhBGKfVOn3zixQ==
X-Received: by 2002:a17:902:b591:b0:1b9:ea60:cd82 with SMTP id a17-20020a170902b59100b001b9ea60cd82mr3320103pls.5.1691801259187;
        Fri, 11 Aug 2023 17:47:39 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:5b85:b986:e090:9abc])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902724b00b001b246dcffb7sm4559247pll.300.2023.08.11.17.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:47:38 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Fri, 11 Aug 2023 17:47:17 -0700
Subject: [PATCH v3 2/2] riscv: dts: thead: add BeagleV Ahead board device
 tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-ahead-dt-v3-v1-2-aef2294bed86@baylibre.com>
References: <20230811-ahead-dt-v3-v1-0-aef2294bed86@baylibre.com>
In-Reply-To: <20230811-ahead-dt-v3-v1-0-aef2294bed86@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691801256; l=2256;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=Z2atrlGM8tcTPwr3A1Vti2dKZVGQj5R9fuQgJnqj1sI=;
 b=oyWcZ20LG4j7WS2sLMTHpSAPtOXFSF78Rdy3L88QLepL03Vrvp9oXTy0m39sCgx5A3inTSWkA
 cGzxPKP4sijASypHQEOtJpEM9fUMs/KYFXZEiA84pK6GCc7iOI/rzg1
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BeagleV Ahead single board computer uses the T-Head TH1520 SoC.
Add a minimal device tree to support basic uart/gpio/dmac drivers so
that a user can boot to a basic shell.

Link: https://beagleboard.org/beaglev-ahead
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/Makefile                 |  2 +-
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 61 ++++++++++++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/thead/Makefile b/arch/riscv/boot/dts/thead/Makefile
index e311fc9a5939..b55a17127c2b 100644
--- a/arch/riscv/boot/dts/thead/Makefile
+++ b/arch/riscv/boot/dts/thead/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_THEAD) += th1520-lichee-pi-4a.dtb
+dtb-$(CONFIG_ARCH_THEAD) += th1520-lichee-pi-4a.dtb th1520-beaglev-ahead.dtb
diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
new file mode 100644
index 000000000000..70e8042c8304
--- /dev/null
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2023 Drew Fustini <dfustini@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "th1520.dtsi"
+
+/ {
+	model = "BeagleV Ahead";
+	compatible = "beagle,beaglev-ahead", "thead,th1520";
+
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0  0x00000000  0x1 0x00000000>;
+
+	};
+};
+
+&osc {
+	clock-frequency = <24000000>;
+};
+
+&osc_32k {
+	clock-frequency = <32768>;
+};
+
+&apb_clk {
+	clock-frequency = <62500000>;
+};
+
+&uart_sclk {
+	clock-frequency = <100000000>;
+};
+
+&dmac0 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};

-- 
2.34.1

