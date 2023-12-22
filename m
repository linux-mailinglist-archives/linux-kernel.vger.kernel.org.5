Return-Path: <linux-kernel+bounces-9928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D294D81CD59
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1E61F232C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B5D2C199;
	Fri, 22 Dec 2023 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3mkzOnT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46E228DC9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so12068505e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703264085; x=1703868885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CivDZddIU1oXgeJl9yAANMyChstbAynIX36qq2yqXq0=;
        b=d3mkzOnT0NqkpTiPlPgB4vbou6YNlPJsX1kjhDRhVT321SBhn3bKd0BdJAIIFocmBs
         kM5+GNckSkN7sURU36NELzWL42yxZBNVdoemG7DPjhuP95KCuaY4eKTHix4EeyCkHWvF
         /r4b5WWMYh0BmVoiWh66BAU70P2aTPvJz2VLYeRKO5vqGQVklOOnJJGSq1bZ+jpterjT
         El/06zR5Lt91fUTc4EDOe5gqGjv/KONVD79q6El1r4Fonk6PGkucgPNZ/83KC22MnVtG
         jjW6xhQjY9cOaEUXrckwRvRfjkBlNbsnHAFwZmhPYlToiG+p7LPdDlnZIOJz1vzOLg4J
         uZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703264085; x=1703868885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CivDZddIU1oXgeJl9yAANMyChstbAynIX36qq2yqXq0=;
        b=LnCQPx1q5smEqWG/MSa7+XQPxtpQYsVvVuj+zFJolxpLoM6k9seDfYQjUZIgwAE2ne
         f6gL7qi8HOHemYtCiSNJ8u7efs1KAzrnGBlbUnxx0NBinqh6WEmrNPE8dHEH31CwPZGO
         3iWrQ7lKvb1NbN5rL7XMoHTwCnn4SPrK/ppH02epFirsfDsaNp9dXbo3eh4HYNDYoGWR
         5OKAMPdQzl5B2QSuTCkOYcXOzMn2EHCOYwpsTlOj5c9BDI+Kq4zDy0JqLYvb7TkaNx6A
         6fq4s8dksNbIo6iinRHviqhdrRLfsw0dVbLsBjNiXZXpcU/jtRVirHWrXqTU8iN06sLf
         SXMA==
X-Gm-Message-State: AOJu0YzVp8CgnumuweJwd5IyYCg7NbuBdkVNt99PjBqSVq00GcyXb2yN
	BP+n0YMeSrh7nMhrhss/AgB/6R1u28d31Q==
X-Google-Smtp-Source: AGHT+IEAvkSh4ddQHp5zuB6x9sxaGJ/xdv0XpTipLUPjLXBv1HMvTHIR8c78uD3+cHX5A/MeMODLVw==
X-Received: by 2002:a05:600c:1d26:b0:40d:2876:def6 with SMTP id l38-20020a05600c1d2600b0040d2876def6mr971581wms.45.1703264085160;
        Fri, 22 Dec 2023 08:54:45 -0800 (PST)
Received: from gpeter-l.lan (host-78-151-55-40.as13285.net. [78.151.55.40])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b0040d378510adsm10138520wmq.1.2023.12.22.08.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 08:54:44 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	semen.protsenko@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com
Subject: [PATCH 3/3] arm64: dts: exynos: gs101: define Multi Core Timer (MCT) node
Date: Fri, 22 Dec 2023 16:53:55 +0000
Message-ID: <20231222165355.1462740-4-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231222165355.1462740-1-peter.griffin@linaro.org>
References: <20231222165355.1462740-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MCT has one global timer and 8 CPU local timers. The global timer
can generate 4 interrupts, and each local timer can generate an
interrupt making 12 interrupts in total.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 9747cb3fa03a..4b09e740b58a 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -292,6 +292,26 @@ cmu_misc: clock-controller@10010000 {
 			clock-names = "dout_cmu_misc_bus", "dout_cmu_misc_sss";
 		};
 
+		timer@10050000 {
+			compatible = "google,gs101-mct",
+				     "samsung,exynos4210-mct";
+			reg = <0x10050000 0x800>;
+			interrupts = <GIC_SPI 753 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 754 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 755 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 756 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 757 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 758 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 759 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 760 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 761 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 762 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 763 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 764 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&ext_24_5m>, <&cmu_misc CLK_GOUT_MISC_MCT_PCLK>;
+			clock-names = "fin_pll", "mct";
+		};
+
 		watchdog_cl0: watchdog@10060000 {
 			compatible = "google,gs101-wdt";
 			reg = <0x10060000 0x100>;
-- 
2.43.0.472.g3155946c3a-goog


