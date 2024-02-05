Return-Path: <linux-kernel+bounces-53082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB9B84A075
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1402D282011
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C24144C88;
	Mon,  5 Feb 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlawTVO1"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F744C8A;
	Mon,  5 Feb 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153628; cv=none; b=XtdXjgDaT8M4BLQrU5w0XDlskX6gUxTG9SjdWETUCqOmVwT2aismI/hB4o+mB6XQR6eFcIzGJ69wPHy8Z8LSHxwL39BAMrAqt556WxwhVkcjJng7ev3YjbUXfGdbgNe1ieMb9PLxEj8D5CcSFF0LcP0SgpcbBIotmPnsTYy1A+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153628; c=relaxed/simple;
	bh=4+21U0YhDWyF8xGtSfJ9TD3cmFgq1ygvYsG9OHnGaXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4QKSSU5/iAr3rVg5u60Hi4c+ywyLsKY4sqkJtApN013c8AgmFvN3F7rZ18CbpG6C2DRdSVsWm4nZLIxCyVKzPnvCyhNn8TOsgnDk/TiBxsTF17SUHg0wKJJIPWDNqqEkxu/vnTmEBjtbMMx+C3YAcaQ+2vfa0WHyK5MnAc2IzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlawTVO1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7393de183so34979295ad.3;
        Mon, 05 Feb 2024 09:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707153626; x=1707758426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnDfdiBxUJ7B1xjtLpqJ3avr3LVR1mRIgOV+jI5F51c=;
        b=PlawTVO1AbqITzZ1xb6IYv0FbhWI8q3R8m49EKkhyS0JCd3CNi7Fvuc/xL1PfyrUMl
         VxwU84pLFc87eNhwJ9Ao2tBctvK4zkfqjGGlPxzO/Sr9h1c9zDjUeCOSbQpbo1iiK0f7
         BszZOMKs7qx+WA7EuJkkJgvUoL4gCkQ2evmdGLgrC0Gs7oaN4PymmIXV8Y2JqLsX045i
         x2adEPnIaMvsN1J277Ne84BLkNfhTJO4jfuCYIBTBBzfjbfqFsEy8UcQoy/FXuCFiiaf
         aZEz4cOuHq/LjgY3IeEq4AUQKZ4iXN3m6hV+6+JnVCXc1jtWlBw3q6qE/p5yZE4NzlQe
         bZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153626; x=1707758426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnDfdiBxUJ7B1xjtLpqJ3avr3LVR1mRIgOV+jI5F51c=;
        b=dnDoAuZvdDWqKo+sZzFBLId3jM0AzQMzzJ9//DDCZC4S7M1tdFrzdyrZHYwFEQlhPu
         vWEUOgZu5x/ZhCsrDQSiZVKzjjDJ8vyZMo30yX/qbTqnMpUCxVYCR21j5cBUxrwcb+pt
         ospr0XgWUDxA6k079r1Gs2PK4OVFYD+c9LULyPtL9LS8a8wwcRAh+dTriOHC43dOVmMM
         0yT4WkMYT+J1xOx3CSMtK/7tIh7F5o5yT4o85DqzT85YZpVSOI+uze4hZeoeLF49+rjd
         WJWffkoqx5BFNirwkqXKkVDSvOrJQFW43Li29e0mYaVZoRRNUQzvawCvZQ9DhEdvY0KV
         5DCw==
X-Gm-Message-State: AOJu0YwSkJJHJfkKJAlNrP5pYF6Z/yfAw7jZQ6ExIlxwcFdp8UalgwHN
	wxhjPUHlje1Y7sS+cyDU8qmWdIBUebvdz3AwmI3fPLyd1MoS6fAQ
X-Google-Smtp-Source: AGHT+IEF6AzcPzjWBjxbTGCLdvr9YdSdC01kCPkAJv7K7CUcIAheuwkTV2bLVUSbdhTX0UF5mfBmNA==
X-Received: by 2002:a17:902:eb53:b0:1d9:6009:c23d with SMTP id i19-20020a170902eb5300b001d96009c23dmr127754pli.54.1707153626453;
        Mon, 05 Feb 2024 09:20:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU1elTh9SN9v38NWSf1rePgCvyzfn4m3+8JVqdjjh6w7OZ6L0CGN1+JXZrPiCubQSIt1FC+FebLlf7otoIHL3l3/COk0aMmn1hDP2lr1uBiyARxiTxr8t6gkk4e9zJFIZdJhE6Ydm9OGYHAIm3Fi8Rwhi/on81QuDIyh5LIdF7lVEPd0qsY/ePDkDp2mBfn20JIQ1ojwUSMeUoBZqT7u5v8MTkeH0Gd38K8oMMcXiP3UJb9OcZIqME/TRBuKLSjIV8YZ2NY/2rVcG8sVE+Urt0w492I16BJWdu7rkYtgSBzb8X+T+uJnk1FbCfH4xw3f+qliQz6OZPdr/lutNmekGYOEOhEPavZnNmBoKrf8IVRB8Npvr6dqrAAcWij4EGdFoD9R7jY2irgrY8q1+Y/kGa0WsgmsQRBxll+ctUw9/Gb2jPPLOR1dBEUEAB5i6M0YFtL/g3V
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001d8f3c7fb96sm107518plb.166.2024.02.05.09.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:20:25 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv1 2/5] arm64: dts: amlogic: Add cache information to the Amlogic SM1 SoC
Date: Mon,  5 Feb 2024 22:49:20 +0530
Message-ID: <20240205171930.968-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205171930.968-1-linux.amoon@gmail.com>
References: <20240205171930.968-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per S905X3 datasheet add missing cache information to the Amlogic
SM1 SoC. ARM Cortex-A55 CPU uses unified L3 cache instead of L2 cache.

- Each Cortex-A55 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L3 cache.

To improve system performance.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Datasheet
[0] https://dn.odroid.com/S905X3/ODROID-C4/Docs/S905X3_Public_Datasheet_Hardkernel.pdf
[1] https://en.wikipedia.org/wiki/ARM_Cortex-A55
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 39 ++++++++++++++++++----
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 643f94d9d08e..403443e782e4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -55,7 +55,13 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
-			next-level-cache = <&l2>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l3>;
 			#cooling-cells = <2>;
 		};
 
@@ -64,7 +70,13 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
-			next-level-cache = <&l2>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l3>;
 			#cooling-cells = <2>;
 		};
 
@@ -73,7 +85,13 @@ cpu2: cpu@2 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
-			next-level-cache = <&l2>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l3>;
 			#cooling-cells = <2>;
 		};
 
@@ -82,14 +100,23 @@ cpu3: cpu@3 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
-			next-level-cache = <&l2>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l3>;
 			#cooling-cells = <2>;
 		};
 
-		l2: l2-cache0 {
+		l3: l3-cache0 {
 			compatible = "cache";
-			cache-level = <2>;
+			cache-level = <3>;
 			cache-unified;
+			cache-size = <0x7d000>; /* L2. 512 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
-- 
2.43.0


