Return-Path: <linux-kernel+bounces-103173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB0787BBE7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F1B1C22B68
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757C36F07C;
	Thu, 14 Mar 2024 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e02Lk7fr"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E46EB76
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415624; cv=none; b=VFwrIVhPONcywHk/4pRyjv46n+DFm89d+oymVvSDSH5NXk5uP5QJ3m1gZZtMxzgKKDz8b08kffaKrft17dPkS/ivGzrYX/XUjeIv8Trd4JMXJ/qltj3DIgWabDbeYrwfFEdPMktSsQzd6w1RvZQ3isjGsOv4hNf6KwsOeVFpyCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415624; c=relaxed/simple;
	bh=NZQktpdrtfs7qW27jx8uDV2H4cOGOdMPNZEZKyZNqn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A3a3Bd5cXzbIRLCgp0WWuWveKjlR9Xdg7tYlb9OJVgIIQGQPDBZHYNs7AF2qBqnwyDhRgfMGPVJB0jbgTd10hYnWj2n4oNRoshrvOvossnbZ92pxcYr3q92UY8pXGoEHNVfuBBNW9pH7iKRKuL/XN0ubjNS6nEarm+RQGE9q1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e02Lk7fr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51320ca689aso1032462e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710415621; x=1711020421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RqhAHkzb4BHsXhRmp42tjCgM0t0AB1g5Lp7YtW1X1vg=;
        b=e02Lk7frLO8mGFG2llXaOzkBKU7MbQLlhs3kBLmkjjbWK7ISkzfHp9TNSZNSHDw684
         g7i0y8ZNhCoXeL1UiJG9DSUJkl2+W4b7VEgrNu2RE9l9zHiDjiWf1k2uapEA6S5kJjn+
         MFAEudv5fm5ZUTqsyTESSK2JWTCccGsYFGqmuljv+UQYfLeGSUD+XNl0WO7eOpseOpgB
         YIw/AGMtGdQ4MeEX0TmEvqwcOjqZGJA25h1h4e+3idxe9tvmgA6Te44UFdPKA5qRuIyl
         fNds+KudlkYqd3v8AC9cTw+uvSgj42YnwnTAXVyLtXGUdObi2WikMURQiktU6jL6tvDm
         slVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710415621; x=1711020421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqhAHkzb4BHsXhRmp42tjCgM0t0AB1g5Lp7YtW1X1vg=;
        b=eNHR8VInYH3VQ8P9fDWoO7OOhqQcWO54OI6rMQ9oIYSE/Folvx1qJ2bQCjIbG8mQj+
         J0rOoJRtUGOMnbA2sUiyiNepI66GQykRDZ/PsaUibPps07CKTNUEQGhBSO3h5p0mkZb2
         wpTTq2M5iz2leBwJnXcG/o8EHRs0tXN7j3DReCWsQ6PPHqZi6iu/qNbrkY8cuoziF7m/
         joPIKy63Ck4BdiLVtzrqfDL+7eqEeEfU/apO3eVflYLxOGF0oF3MTO0wjMtAK2gH/Xx/
         7iF2mUVzxDDBvQEdYRNNWEc8qPNghrNvxDpcL3tlsmuD3gouCVfVmoISCACT42kg9mDS
         iYDg==
X-Forwarded-Encrypted: i=1; AJvYcCXLLhNdyJcNIqNnIo7qtCm83n5F+nUPQBte7CB4gdDmY5lsPqdjc4XcY+aHYwymjcJsNtskwjTgsShUsLFiHJaPDvqeiJY7QE85ZQr+
X-Gm-Message-State: AOJu0Yx2lnYlBubw9BZrCbGG+xHjvxVmU6TndbRClYRf+N9GeIhoDS3v
	ukwTYomH9/XE1AVkBIZBCrFBjlGptFaslouw8/VOOFOYfZZlxpv4qzu/fGQzPXA=
X-Google-Smtp-Source: AGHT+IFiOaTUBm/dmApeywx7C2FjUTaLu385b2URTg8PSx1WzFj+iIemPcjjAzN72x90SEFH8nsUrg==
X-Received: by 2002:a19:8c47:0:b0:513:b062:98c4 with SMTP id i7-20020a198c47000000b00513b06298c4mr950278lfj.11.1710415621009;
        Thu, 14 Mar 2024 04:27:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id j16-20020adfe510000000b0033e42ab5114sm560922wrm.2.2024.03.14.04.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 04:27:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] arm64: dts: qcom: apq8016-sbc: correct GPIO LEDs node names
Date: Thu, 14 Mar 2024 12:26:57 +0100
Message-Id: <20240314112657.167006-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Individual LEDs in a GPIO LEDs device node are not addressable, thus
unit address is not correct.

dtc is also not happy:

  Warning (unit_address_vs_reg): /leds/led@5: node has a unit name, but no reg or ranges property

Reported-by: Sumit Garg <sumit.garg@linaro.org>
Closes: https://lore.kernel.org/all/CAFA6WYNRwF7GqhBk2B7i-deT3aLxNQckhnOasjip2TYm4HZgAw@mail.gmail.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 9ffad7d1f2b6..aba08424aa38 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -91,7 +91,7 @@ leds {
 
 		compatible = "gpio-leds";
 
-		led@1 {
+		led-1 {
 			label = "apq8016-sbc:green:user1";
 			function = LED_FUNCTION_HEARTBEAT;
 			color = <LED_COLOR_ID_GREEN>;
@@ -100,7 +100,7 @@ led@1 {
 			default-state = "off";
 		};
 
-		led@2 {
+		led-2 {
 			label = "apq8016-sbc:green:user2";
 			function = LED_FUNCTION_DISK_ACTIVITY;
 			color = <LED_COLOR_ID_GREEN>;
@@ -109,7 +109,7 @@ led@2 {
 			default-state = "off";
 		};
 
-		led@3 {
+		led-3 {
 			label = "apq8016-sbc:green:user3";
 			function = LED_FUNCTION_DISK_ACTIVITY;
 			color = <LED_COLOR_ID_GREEN>;
@@ -118,7 +118,7 @@ led@3 {
 			default-state = "off";
 		};
 
-		led@4 {
+		led-4 {
 			label = "apq8016-sbc:green:user4";
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
@@ -127,7 +127,7 @@ led@4 {
 			default-state = "off";
 		};
 
-		led@5 {
+		led-5 {
 			label = "apq8016-sbc:yellow:wlan";
 			function = LED_FUNCTION_WLAN;
 			color = <LED_COLOR_ID_YELLOW>;
@@ -136,7 +136,7 @@ led@5 {
 			default-state = "off";
 		};
 
-		led@6 {
+		led-6 {
 			label = "apq8016-sbc:blue:bt";
 			function = LED_FUNCTION_BLUETOOTH;
 			color = <LED_COLOR_ID_BLUE>;
-- 
2.34.1


