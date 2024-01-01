Return-Path: <linux-kernel+bounces-13803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5248211A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 01:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF0628296B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 00:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0471AC8D4;
	Mon,  1 Jan 2024 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpzRpl1P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7EC2DF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso5258266a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 16:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704067209; x=1704672009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1INtN/KwPq/Kh+/tuqCsXKBvEKli+VsBh43RgsVDQQ=;
        b=dpzRpl1PomSZIYhR2GjpxTxDCBxboDuBOuKeC8A92+zLpovlUI9Frwy8fx/1A9ySW4
         SsM6ohlo8NGbaajV/+RR071R7UN7+6HSox6fsoGJwLHM7/LysYLNA+isqQ4wPjeEZWaj
         QwfVtxorNfkmB0dcTIumHuG5NqjBrJKm3cNlL5i2FxvpfMY4iYaaVWNl12EQQeAt7BV3
         Ibwh2ZbmPyD5cnTxz1buvaJKn/6e+qzJhrdWhbFJ+o+jNYPh6asxYRbJXHh6h94PwXTw
         WAWuJCtjJuCIj3o1d//1cyjX43KhDwiYJtdb6zgLDtUAbRtvjkEEQdPqG8UXe1grvf9H
         hFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704067209; x=1704672009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1INtN/KwPq/Kh+/tuqCsXKBvEKli+VsBh43RgsVDQQ=;
        b=ClOZGrf4RL0KBA0FT9xJ8Yiqloc4Eb/xxQzYbduBMtgiHtJrxQ1Xyot5c/ZHjyDYA3
         3naWED1FNtsJ6HXru92ExPwYPtlh/HlK1UZAZ1ElsNUWApFcnyvFnlNJ/qWnh9sOa2zp
         BVFW5B8rgLuAtCKQHeT/91M+zZcLtR/cyWa3yUII8v+TgjzX7mxOz2e+2VaLJQePoPtg
         p/l/qmjZbaXsj67oUafWsli4YwbIQf/cpADn1lRLrc/HLaeTIRx1/wwGA0EcbMJLtHmt
         Fxm+ccPiPR37NvavOfu5O3nr8cFUKJZCLBUAyuJEJlHqh1oaZ8wag0TmZZ81GjokzpIn
         Oq5g==
X-Gm-Message-State: AOJu0YzQZm9j72TGFBKCo/+7j1mo7v7ZE5FDptMCwA+w5F2mM+yzSsv9
	nBrEjQ3+ZuugLuJDOLsF550qnIzIRIjadw==
X-Google-Smtp-Source: AGHT+IFXEcZGbkvUmUE7n3yK8GOblmtp1rqPhnp6R3fS+jw+w58DxQeZOYGzzaX3pnL0cE39+XGT6g==
X-Received: by 2002:a50:96cf:0:b0:555:f39a:8c90 with SMTP id z15-20020a5096cf000000b00555f39a8c90mr829490eda.35.1704067209415;
        Sun, 31 Dec 2023 16:00:09 -0800 (PST)
Received: from tux.Home ([2.223.42.238])
        by smtp.gmail.com with ESMTPSA id ek20-20020a056402371400b00555f49e7080sm2710514edb.56.2023.12.31.16.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 16:00:09 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: anarsoul@gmail.com,
	tiny.windzz@gmail.com,
	linux-sunxi@lists.linux.dev
Cc: rafael@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	daniel.lezcano@linaro.org,
	peter.griffin@linaro.org,
	klimov.linux@gmail.com
Subject: [PATCH RESEND] arm64: dts: allwinner: a64: Add thermal trip points for GPU
Date: Mon,  1 Jan 2024 00:00:08 +0000
Message-ID: <20240101000008.65747-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without trip points for GPU, the following errors are printed in the
dmesg log and the sun8i-thermal driver fails to load:

thermal_sys: Failed to find 'trips' node
thermal_sys: Failed to find trip points for thermal-sensor id=1
sun8i-thermal: probe of 1c25000.thermal-sensor failed with error -22

When thermal zones are defined, trip points definitions are mandatory.
Trip values for the GPU are assumed to be the same values as the CPU
ones. The available specs do not provide any hints about thermal regimes
for the GPU and it seems GPU is implemented on the same die as the CPU.

Tested on Pine a64+.

Cc: Samuel Holland <samuel@sholland.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 62f45f71ec65..07963eea1bf0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -243,6 +243,29 @@ gpu0_thermal: gpu0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 1>;
+
+			trips {
+				gpu0_alert0: gpu0_alert0 {
+					/* milliCelsius */
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu0_alert1: gpu0_alert1 {
+					/* milliCelsius */
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				gpu0_crit: gpu0_crit {
+					/* milliCelsius */
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 
 		gpu1_thermal: gpu1-thermal {
@@ -250,6 +273,29 @@ gpu1_thermal: gpu1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 2>;
+
+			trips {
+				gpu1_alert0: gpu1_alert0 {
+					/* milliCelsius */
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu1_alert1: gpu1_alert1 {
+					/* milliCelsius */
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				gpu1_crit: gpu1_crit {
+					/* milliCelsius */
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 
-- 
2.40.1


