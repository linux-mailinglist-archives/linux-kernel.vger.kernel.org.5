Return-Path: <linux-kernel+bounces-15575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45243822E57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71C42840DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1231B27B;
	Wed,  3 Jan 2024 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="D5U+W56d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54B199C9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B967B3F751
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704288548;
	bh=0xlyxKFbvUzm4zLJgn5EKeObZzal+VTFR9Rg6ALS2M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=D5U+W56dz22Sq5TDFhArSwNC6juXtPifx6+sxiRd13o2b4tsYBMEhE9DxQxqrmzQU
	 fetYQSrjtyA93a5o+iUYptn1rzQG7t7t+8haaSOMa9lL/T5Ebpb0/Qvl3Q1gH+VY2W
	 ta7vnJ8F4GoK7fre8LyV5Z2Gy6BqFcdzIyEWJ3HQOL2sVEUmZgdYvXCn0IZtw8tMFK
	 IlJdCvbqfZhmtYxJ7Kfa1Y70bb3Nfgvgc5qcybtOU9I9T3Z8HFgcX0I52hLmtRGUTA
	 OU4Nq3cORuoSopLR471qRSJW7aCbfo+aKtGAvs2vPE/3lUC1MzjvdhkaEi+WEyEXvt
	 y3lDz2B14DRaQ==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50e69fc4574so6997460e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704288541; x=1704893341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xlyxKFbvUzm4zLJgn5EKeObZzal+VTFR9Rg6ALS2M4=;
        b=bZeTHBJrDF8SDVJXGL0Qbu8P/Sovs6RXykBvyF2THrTODryciicEEhHyn/RnLWvOBD
         J9IaFNDb2RpEqfk/6GNLl0ec+KvYFbpA3Fq8AKGhM5ln7LzCzDFb5bkzRQZTSEU1JsOO
         /muMZCmjq0sUMhyDxHLbAt7Mlierv1qyqD8FvKNP3eEvFIj6/Zn5dU2au+h3N7eDR5O9
         2tCjRvkdjr+Ykjg84nfeUNTYO0v17K98yXvwzDfm/ZbgmydcaACeeLUM+o51p4Ocyse3
         6vp13WsXSbwgBJMc5OaRjUBfnRCyXgBjx3Aee/p/BMAiEQ0Xgg0ZBy34sjWjM1JYDDag
         IqIw==
X-Gm-Message-State: AOJu0YwssEz4sAIh9NXFqGGxV5P3agHwVChvn4U6oVqbKB++txTd0ZVI
	P5fAn2SQzhfwefaua0EbA/P47MkdJc0RVspIogq+n3k6RDdu/p/uqmfAoPNGeYfvx50PL/JBtkF
	/cCgoVSv3VOYUG16a/J5UYN7mpwhMdFexsa6U5MvTDZuxrBXcUWDuT3h8
X-Received: by 2002:a05:6512:4d0:b0:50e:9a0d:d402 with SMTP id w16-20020a05651204d000b0050e9a0dd402mr1985093lfq.105.1704288540735;
        Wed, 03 Jan 2024 05:29:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFglWpNfCSmVpHzBKEgsAU+8MjxYPm2sCoW5U4VmzTKq+1KMDXtev6vYNkRZ5n9/d/lOFNERw==
X-Received: by 2002:a05:6512:4d0:b0:50e:9a0d:d402 with SMTP id w16-20020a05651204d000b0050e9a0dd402mr1985076lfq.105.1704288540552;
        Wed, 03 Jan 2024 05:29:00 -0800 (PST)
Received: from stitch.. ([2a01:4262:1ab:c:5af0:999b:bb78:7614])
        by smtp.gmail.com with ESMTPSA id eu18-20020a170907299200b00a26e53be089sm9549873ejc.44.2024.01.03.05.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:29:00 -0800 (PST)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2 7/8] riscv: dts: thead: Add TH1520 pinctrl settings for UART0
Date: Wed,  3 Jan 2024 14:28:44 +0100
Message-ID: <20240103132852.298964-8-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
References: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pinctrl settings for UART0 used as the default debug console on
both the Lichee Pi 4A and BeagleV Ahead boards.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../boot/dts/thead/th1520-beaglev-ahead.dts   | 26 +++++++++++++++++++
 .../boot/dts/thead/th1520-lichee-pi-4a.dts    | 26 +++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index f1e8eaed487c..c697a50ca9b1 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -62,6 +62,32 @@ &dmac0 {
 	status = "okay";
 };
 
+&padctrl0_apsys {
+	uart0_pins: uart0-0 {
+		tx-pins {
+			pins = "UART0_TXD";
+			function = "uart";
+			bias-disable;
+			drive-strength = <3>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		rx-pins {
+			pins = "UART0_RXD";
+			function = "uart";
+			bias-disable;
+			drive-strength = <1>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+	};
+};
+
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
index 0ae2c20d5641..932838c55f90 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
@@ -29,6 +29,32 @@ chosen {
 	};
 };
 
+&padctrl0_apsys {
+	uart0_pins: uart0-0 {
+		tx-pins {
+			pins = "UART0_TXD";
+			function = "uart";
+			bias-disable;
+			drive-strength = <3>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		rx-pins {
+			pins = "UART0_RXD";
+			function = "uart";
+			bias-disable;
+			drive-strength = <1>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+	};
+};
+
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
-- 
2.43.0


