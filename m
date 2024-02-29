Return-Path: <linux-kernel+bounces-87553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFFD86D5D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E18C2869A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA69159575;
	Thu, 29 Feb 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5aMrLWb"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692EB1504FB;
	Thu, 29 Feb 2024 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240456; cv=none; b=AdcIr2c8MPjAD4rR8H95zBQzvXuT3Q+YK12D36e4Wzu7cjr8yeHrBFnseA/DhsC574CNEZzQiRZR8Y8Btz29+GhyeAHwki4IsnboHkvgQ7A69PE1Z1/J48jLeQwo4caT2qA+NJeSwBuKFOgVwf3CnW1KkOLK7T5FZLRjlBsI4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240456; c=relaxed/simple;
	bh=fh2szyAddSibibefZ4gfKtIWhGAidJRjH8vpo2f+lGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y4xoP/QD544/P9avvAoKdZrre2WqZ8IxfDeKtuazjvOCzCBCVOsxOrPLAMZvhNb4B1FJkZBuWuc2w2pvqYLorVLkYPqjXRYUQq2TTd0EXyd/zVlbagUZEmdUgda1wfeXHQ6OBeFTPTJnBkXLoaFHRNOC8YRDAovo5YCSSOuZo10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5aMrLWb; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512e568607aso1285127e87.1;
        Thu, 29 Feb 2024 13:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709240452; x=1709845252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=61xcQbBuP+qncwTpWvCEA8LwY1FmumIMLzlUbcrboIM=;
        b=C5aMrLWbhXkbJbdLdKKEGliwXc21/11Rg+B39YikmhTfr887SbsnR+8/PR0H6jeUOb
         3wfc3kIzgc0QRT0+nhUwFL+q67WCOjcVNqJKEY47QR9cJtZs8L/RPDr0OADE1yHm5I+h
         6ECYOqyQXa0xzsxjdcbehQ8OkFncUWpk5aUY1L2lkugQnNkrR3kgOw/uYHdUz70ghQF2
         gbn2LTexT3utwciTWic2I4vk84gZNenkIf4RAfkX5Q+F0k78kXAwyAZLxX39XES4BLTX
         46WbDQ8HIu6n+pNJjMDPSaosgejaAHTbOMIKqUCeOsJeQhBDY8nm4wLhZWPCw54OkYpw
         y74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240452; x=1709845252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61xcQbBuP+qncwTpWvCEA8LwY1FmumIMLzlUbcrboIM=;
        b=F5XP8Erjlfz7SJnDuWWTc5OLpAIf34FqVwvKJBex1ortOrBrbqmZsRp9UXaYX+sfz3
         Q2H23Smytc1ubyvTID5Yj4cAfSnpVIpB5RqnOIySds6MnIDt6+nY0o9y+MuBRK38BN4i
         p0MdInI8aykzsZW5+izt7Tr5Ut4ugVXNTP5OiYqszlP1XGde8TLUFNmo9/Cr340yxjjz
         XwLY2vRRAEKs4v2xoP82fqeQU7Ms+gw/CpGJyi2aevJTwfql992AW9MsyHqCIRt6czwz
         fsjlQ/Bvvet4ZFDzmWX/SGFZ2hTIU4fAvF+PX1ctpF6vbqRO7KCFxHCFs3gI2/aBS5Mc
         0Mqw==
X-Forwarded-Encrypted: i=1; AJvYcCU9VxF5KsR+Ur2N9bLxJKD2LM9tex43yUgiyT111e5NMQb0NdxdXyPaQ+RwUsSQoVqxfcu9jpnBKOcf5XFygmE4FNcZoF1uoMLl7BotBxf55xt8pt/tF7rBl6yITH2AQgVu//fUSAvMN1bKdLQqPFi+MlNx16a97xgchR4REDVHrvvNtA+0H8Q=
X-Gm-Message-State: AOJu0YwzcReN6DfutS4rXw7/+Tz78cKxyLouZrJ9Nhmel+gg82wlzizB
	C+FNVSj03t/qgYh7tYDQ7aQLnNM6S4nlsVmmrSdG16/GX9CO55n2Rl7ukKA=
X-Google-Smtp-Source: AGHT+IEKqTCkhKKM6RwcBjFa6DbKMNkuDKrqO09KCzkMybD56sC10cCnTprgXg+m+P8tOsff2vkVIw==
X-Received: by 2002:a05:6512:3c9e:b0:513:2c91:7960 with SMTP id h30-20020a0565123c9e00b005132c917960mr851874lfv.44.1709240452063;
        Thu, 29 Feb 2024 13:00:52 -0800 (PST)
Received: from frutis-latitude7490.lan (public-gprs367196.centertel.pl. [37.47.65.157])
        by smtp.googlemail.com with ESMTPSA id tj10-20020a170907c24a00b00a444526962asm943446ejc.128.2024.02.29.13.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:00:51 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: 
Cc: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: ipq8074: Add QUP UART6 node
Date: Thu, 29 Feb 2024 21:54:16 +0100
Message-ID: <20240229205426.232205-1-frut3k7@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add node to support the QUP UART6 controller inside of IPQ8074.
Used by some routers to communicate with a Bluetooth controller.

Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 26441447c866..9c259257adb0 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -321,6 +321,13 @@ serial_4_pins: serial4-state {
 				bias-disable;
 			};
 
+			serial_5_pins: serial5-state {
+				pins = "gpio9", "gpio16";
+				function = "blsp5_uart";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
 			i2c_0_pins: i2c-0-state {
 				pins = "gpio42", "gpio43";
 				function = "blsp1_i2c";
@@ -469,6 +476,18 @@ blsp1_uart5: serial@78b3000 {
 			status = "disabled";
 		};
 
+		blsp1_uart6: serial@78b4000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x078b4000 0x200>;
+			interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART6_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-0 = <&serial_5_pins>;
+			pinctrl-names = "default";
+			status = "disabled";
+		};
+
 		blsp1_spi1: spi@78b5000 {
 			compatible = "qcom,spi-qup-v2.2.1";
 			#address-cells = <1>;
-- 
2.43.2


