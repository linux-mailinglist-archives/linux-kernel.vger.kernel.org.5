Return-Path: <linux-kernel+bounces-146572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A355C8A6775
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395C01F21D30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C0585644;
	Tue, 16 Apr 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKp3pUIk"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B343FE2A;
	Tue, 16 Apr 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261092; cv=none; b=JXr8O4ueJIFcTKHo7jTdcH5wroUgo8hvzfrNaAnMtC9VNk43NrdEJXQY7xQ5I0a7zpYNbKDfB+fZf0wS5/7aphMjm4Mhwc+Yj2D4xruKWuirAA3v0W0WYkTAFWCam1JHneeD6dSWMxqunuPpHbiImB0Wl0AO6NCbF6Huoc+ortQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261092; c=relaxed/simple;
	bh=xpvoI8aRsr4RIndXSsQx0e1Xx+6a2BKP0J1OQSqC7CU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3c/kW6VKiyd0E1cgnO2TINh2Wg9uH1WtzOnyS25RQPiy+wjvKZMNOdvByk3OjF52FZLhzuMbZYnm04UPkgux95g0wN53mPmLT/UX2vTVrm7vzMWpB1sUUMw9jS/7NDBRRHI1t+Ufa6Dz8IF/nB7HgYPJTPTdzJ9WdEjp58gSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKp3pUIk; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6eb8ea5ac95so405990a34.2;
        Tue, 16 Apr 2024 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713261090; x=1713865890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKVl3O7EHtWd97mA3oU7jwLqrHCbe1j887QmZeXMuow=;
        b=kKp3pUIk67n3XTnGMmLlMBRUOugfR67E1lXgFZrAw+0cESZUr5UNrH4ZtvsicXljwt
         i8i2tDXhh7lpH1RddUNg564E+GENleQZ4Dr6ldlJKRgFbRRu9e6ZWtTNu/puOd6TSiWF
         f5sCYwKY5wmkP2O4J0GeiXylbjQkPRMVqR5g7UOhiqixCjg/bXIhzq/msW03/zhmYB1X
         s2dsC0lUcK5EOZKT1ZsATrbDPFMEV726YASG+sMGgSuVkdEYDtL4sYgXSjevf2L1IlJh
         ZIvwMr8GiqpZ995QUSxMu9ZT87jt5s3yLLc3g5Az8SHZd+B1BOXDqCu8LNhqdldddGtM
         5EiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261090; x=1713865890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKVl3O7EHtWd97mA3oU7jwLqrHCbe1j887QmZeXMuow=;
        b=SRg5IX0kPL5DkowAPHco5Hxh7RXvD05wRffc1rpLXKfunrYqqGSByYwJs++n9kFuLi
         ciUZ/bDTTgCKHzvpfl7EpdZ40ETDh3dJV5zs2g26gM9v9mEcLaOg5leP/FNBKn3lEkEp
         0W2qCukiS4RypkkdTnqWBzXRuiQ/43UTg0GR51cacaJ1P6jhp1Mcin8z61woXOmARq2x
         mWjHzP9W4F9YGMTTj/EcRGUhzNYh3Ski1Db+wuuZwBfuMG3L0nzdUr+qpJAW/vEoQVSU
         hYWIePRvPDuMmc5c2f9Jc6rVH/YrBiTCllX6IzqKCI+mmW3wk6hsGzEy7HE7DT8cUt4N
         p7rA==
X-Forwarded-Encrypted: i=1; AJvYcCXe0dUp4zoLHLcr1VYGY2/qYoYTpg5agruoT/JtQ57emaQX+m5ayylbO3DhfrjQH49TViLNRy3Gf5sc0qPh2v4YhHZR4WlWIgtcvhFteKC/zyd7DV9E62z/kTxmZAEzzuquRapETLcpE5KE7oZ5PKh1XXGEATTPWXLWJLYQ4vFS3qcLTQ==
X-Gm-Message-State: AOJu0YwTLH/vcLycfMdhohLfsHFnQ6GnF6ifpSRR6kzA9ywlrhiZpwva
	Gm6aGgpBHj9uIDPuSfvqxIOagikfwDde8KeOM6gfAvn8Z44hTJ7t
X-Google-Smtp-Source: AGHT+IHl5acEs2pYbrqTh5iHgq44xiaQV4kYEp3Vhk+eWUjXxy/E4raAKDXC5MVfqMp/9gtwJB7ODA==
X-Received: by 2002:a9d:6b09:0:b0:6ea:2b0b:6171 with SMTP id g9-20020a9d6b09000000b006ea2b0b6171mr14412997otp.5.1713261089960;
        Tue, 16 Apr 2024 02:51:29 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id h13-20020a9d600d000000b006ea23d8fcaasm2190528otj.32.2024.04.16.02.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:51:29 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH 3/3] riscv: dts: add mmc controllers for Sophgo SG2042 SoC
Date: Tue, 16 Apr 2024 17:51:17 +0800
Message-Id: <05f55d1c83b1dd6b810ec1710b38771c03112876.1713258948.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713258948.git.unicorn_wang@outlook.com>
References: <cover.1713258948.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

SG2042 has two MMC controller, one for emmc, another for sd-card.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 15 +++++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 32 +++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 80cb017974d8..c4037eff5c97 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -26,6 +26,21 @@ &cgi_dpll1 {
 	clock-frequency = <25000000>;
 };
 
+&emmc {
+	bus-width = <4>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	status = "okay";
+};
+
+&sd {
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 8aab027cf730..0b176712a43c 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -393,5 +393,37 @@ uart0: serial@7040000000 {
 			resets = <&rstgen RST_UART0>;
 			status = "disabled";
 		};
+
+		emmc: mmc@704002a000 {
+			compatible = "sophgo,sg2042-dwcmshc";
+			reg = <0x70 0x4002A000 0x0 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <134 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =
+				<&clkgen GATE_CLK_AXI_EMMC>,
+				<&clkgen GATE_CLK_100K_EMMC>,
+				<&clkgen GATE_CLK_EMMC_100M>;
+			clock-names =
+				"core",
+				"timer",
+				"card";
+			status = "disabled";
+		};
+
+		sd: mmc@704002b000 {
+			compatible = "sophgo,sg2042-dwcmshc";
+			reg = <0x70 0x4002B000 0x0 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =
+				<&clkgen GATE_CLK_AXI_SD>,
+				<&clkgen GATE_CLK_100K_SD>,
+				<&clkgen GATE_CLK_SD_100M>;
+			clock-names =
+				"core",
+				"timer",
+				"card";
+			status = "disabled";
+		};
 	};
 };
-- 
2.25.1


