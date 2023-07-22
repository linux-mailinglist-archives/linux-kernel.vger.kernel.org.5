Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6A075DEB7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjGVV4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGVVz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:55:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E8D10FB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:55:57 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666edfc50deso2026180b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690062957; x=1690667757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNq3ooibllsS+ZhvG+WZ/pKEIVkHTikeXp8/+4bIvoo=;
        b=Zvk+6o3mp1GMdDNIyKe1pvP3sneiDUgo19KNiwhQKJTBanqA5dfWnFClpbKq9VmUNo
         pv02PcLdEqUqY23UQko7HUIIMRYxbSaiAbl3TUyD0ULBdJvj0QqBsC6iSkXLh1YC/CYg
         OIjlWFvCzo/+FadPASi0Vj7n4PFH5i1xMWwmKNiXaHoocIkChA1CVdsXaMR/tbI1+vVP
         5CRW8vdBGoSszfhffKJ+Jym7/Z0glbf8TOctSYkIJM+0+75SEmiBESWeGKxZssOWzuUY
         xxcXzbO9870E9RNfdNsFTIsDss38VHGj9uu+31lzXEgZNAehNv3IocH1DYKQjnNpw2Ay
         tAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690062957; x=1690667757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNq3ooibllsS+ZhvG+WZ/pKEIVkHTikeXp8/+4bIvoo=;
        b=fMEKXgxcPw4RaQpd2JBlOCrJ9RX7UZ2KwePq9Cl4Q1uxjqtfiR2bIrii7gdXtNqbkD
         nonOdmPumZxD31+JCPS2ptg/PeeSPh7pHYNFIoeEpIaiDAYVu4NAfxsTufV54CBDdJ7N
         NS98rUQzE+IrcuHU8rhtV99zOzk3J0UBzLXxRpbAuWPRoFarlGOxA9Gj/30t5BlO4gpJ
         EDCUr2jyAhy+3WaX5nG+owo0d0GBrvd3lmeAjPCL97veZLe8il/Q+noynNCvhDBFhPCK
         Kc1aSjauA5lr7tvGlFb2FUEU3csu03R3R+KcQh7dmRaa4QV5FLCbD2JQrLyRDG4W+Ufl
         wJpw==
X-Gm-Message-State: ABy/qLaNo46APueh40WfSeLxDv9bt7YpMLUb2kCMHlkZnGJyX2t3NkeP
        7V3TkPrplt6xhV+xDDX0RnSi1Q==
X-Google-Smtp-Source: APBJJlETDgMMQUmKERqHdpjyeUGuasuXqwF3qVJ8DnTZ2PhV8XDiCClkTLr65ubbixENCL+6hzLcHg==
X-Received: by 2002:a05:6a20:8f20:b0:128:ffb7:dcfe with SMTP id b32-20020a056a208f2000b00128ffb7dcfemr8454200pzk.1.1690062957244;
        Sat, 22 Jul 2023 14:55:57 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2a8c:966f:392d:7230])
        by smtp.gmail.com with ESMTPSA id e23-20020a633717000000b0056368adf5e2sm5517642pga.87.2023.07.22.14.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 14:55:56 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Sat, 22 Jul 2023 14:55:39 -0700
Subject: [PATCH 1/3] riscv: dts: thead: add BeagleV Ahead board device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230722-upstream-beaglev-ahead-dts-v1-1-ccda511357f4@baylibre.com>
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
In-Reply-To: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
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
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690062955; l=2149;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=+rZmnfftb0bAD+1sg0Qa75JPTOTZrN2NaupHAuKG1ME=;
 b=H2Yel4vLh8WU569bA3DeA3vPh7RYAVO9fVFeX+pv6CgRHteYDElL8T7ZRggo6w6KgbsHdYgGe
 bPfhHVnoHYnDXNhKHEDTSLpb24s4Iz6Nz3LvykBGJ3h9085tg/rcVVb
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BeagleV Ahead single board computer uses the T-Head TH1520 SoC.
Add a minimal device tree to support basic uart/gpio/dmac drivers so
that a user can boot to a basic shell.

Link: https://beagleboard.org/beaglev-ahead
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
index 000000000000..c315e5bd3d2d
--- /dev/null
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
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

