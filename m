Return-Path: <linux-kernel+bounces-53083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AB184A077
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C952827F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E813244C9D;
	Mon,  5 Feb 2024 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUzc23/w"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930945949;
	Mon,  5 Feb 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153634; cv=none; b=BuwwbKyYZ4w3b9CLHqIyjz0tMNogFzbMn5kOzH+JlBzC0xj7W1hUooo9O2xyjsMNTqRdetpY2DRHf8yg1taoeNUSlp9mUcagp7lo9say8L6MQPU2watbSLEcVXeuhBMqGAx8JwvIq1hwiifUGXZ7SrbchegGsKCUbZuUQRq/UEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153634; c=relaxed/simple;
	bh=6rBTdzj9PHDyFJHtKnnQE4vD2kj940xHhDpCPHSigqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBZlMIbafbvfiSku9hHkgH+VreU4Xlbx8JzAfnsCa/M5vKWZ0BMCiDCQVsqNQI9FpMNkFuxZSTX0Z8NSXKswZqeYtlr4SdJTxX6HaGCkovDNdQJoFD2cXcm0+uHG3gV5bi0MTr0IDB05V/loIs9wFW8/JE/Au0myoWpsi2xA26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUzc23/w; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d93edfa76dso39605535ad.1;
        Mon, 05 Feb 2024 09:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707153632; x=1707758432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwtrPptp9yS7J0efJI/zQfvo+vFL61xsfjw+Jvw6kY4=;
        b=QUzc23/wg+027G3xF0wB8brvNxcCg9tLsp1ml/QaB3sjbqrnNeiwk9dWUPIDRUB7Op
         +HGgsoJlJ0lgXty/sAxTXlKJ3kQdJ5vOPMMUeOcppU5/Tu6T1ViNqDViljO7tjU4u9nV
         2k6aRq4cGY/bdKXniGWLzO+hB3AeFEZFunaIPEg6q2tAqOmWDuKs14SJDVzEIICKxHTL
         wKIHWb8EAvx7chM7UcMlhkAJMHk93N5GA0uT2Ode2YQ5ULQ+sDxao0GLeE0VM8pybeKo
         O/0w3HHtpvs187IBAum9y2s5iMOHzioEDueLgN/ZsUt15+mWl7aXERiEFy5KRRzIb8kw
         3t6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153632; x=1707758432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwtrPptp9yS7J0efJI/zQfvo+vFL61xsfjw+Jvw6kY4=;
        b=mH8ZQbunt/4Ncsp5esZUYgUWP0JH8uaT1mr7B6wkh+OIa2VRI8meBF/nGEnU3GTiTS
         gv6aiQstpN74l2r3XE5A9ik1/wgeiSjtVio5ZMPuhlwupfLLKjreC7M8hTX0HCtx7QeU
         cpoI2loeDPLR/uErELoFvDc9p1O0QJ1Uxsp+b9mfzecwl3GQp/84it7qdei/Avt/uC7c
         Xvr06AS0pKgDef3YHK/gawYU6Un6fjtQAi1WsoHXBLk8jGv24UQvGnDlaMLWUDVxo13d
         7I1WX1U8yBTkNyN+kGVWHLbXceVujrgRQGa0QpZ3K7CjWlni1t8rY9NW2xdZfwh2iNtI
         /Hpg==
X-Forwarded-Encrypted: i=1; AJvYcCU2pUi1MHg2+9IuH+5b9c0J/LIJAMax8/NniTRDJM4WAjGQ4w01KJu1GrVFrh9AuuxosMyTGLL6sGS5Fd5r0bIFwnCb0mB0kJGPQvJ5rHwc4/c7cPB0Tkvu0XqVZsS11UypURSLNsRdGg==
X-Gm-Message-State: AOJu0YygyOUZVkqzFqQDKM7VnMobk2X8/muiN++nj9lRm3md2Ak8mtE0
	16qzKWCiCdm3V1oD0ywSnvsM6HA0/Tduo4mAMHKqHg2ahGYW3Wo6
X-Google-Smtp-Source: AGHT+IGSxOnN3RiqnWu/RNkjg6hUPZonpI1lU2dV8B3WFCeNtN3DdM4CDdzW5pXlOyizLnKrDbV9LA==
X-Received: by 2002:a17:902:e812:b0:1d9:b5d8:854c with SMTP id u18-20020a170902e81200b001d9b5d8854cmr116767plg.58.1707153631888;
        Mon, 05 Feb 2024 09:20:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVpn8zV0pf4QEYWgO3F0/g8SDqndzS7Tn92SKwwurjdmJ6DOkMNAYT/pA85lGPDRGkgiDKVMtXgV3BBwBwemsP7hPa0AshDujpJaxWT50+flioxQMKHWVgBJav+PvxyUgNfWLb6Xmd+WrVIkkADK4yGu5fXTZ+v5iTlYhacFRFfDiqqG60iKyWuZm6Ekhh2DsABsQjygzc9mtmKCOVE9QAcxP1dc1pSEgGGq6TvXpbFMKEWGjKkkAwBpt719i4qDlCi+SysxySW+9vZMI7LylW1rDeSceWWnYTcnOn5Jcnkz0Fq61YoUuPiUc1aJ7yFy1h2MZ/thbUcfxNFx5c7FguQnKa6gWitZuwE0lNwgScmLyGPlm6awvYPo20HeZsazmCU+BBXmf6GglZkerDtuR6d5llp+/MFYkFLhQaOU4ofAc32vU/nlhj5KDqFjmumNNcr6UWJ
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001d8f3c7fb96sm107518plb.166.2024.02.05.09.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:20:31 -0800 (PST)
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
Subject: [PATCHv1 3/5] arm64: dts: amlogic: Add cache information to the Amlogic G12A SoCS
Date: Mon,  5 Feb 2024 22:49:21 +0530
Message-ID: <20240205171930.968-4-linux.amoon@gmail.com>
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

As per the S905X2 datasheet add missing cache information to the Amlogic
G12A SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

To improve system performance.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
No public dataheet available, since S905X2 support Arm Cortex-A53 cpu
nence used the same cache size as S905 and S905X.
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 27 +++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 543e70669df5..6e1e3a3f5f18 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -17,6 +17,12 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			#cooling-cells = <2>;
 		};
@@ -26,6 +32,12 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			#cooling-cells = <2>;
 		};
@@ -35,6 +47,12 @@ cpu2: cpu@2 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			#cooling-cells = <2>;
 		};
@@ -44,6 +62,12 @@ cpu3: cpu@3 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			#cooling-cells = <2>;
 		};
@@ -52,6 +76,9 @@ l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
+			cache-size = <0x7d000>; /* L2. 512 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
-- 
2.43.0


