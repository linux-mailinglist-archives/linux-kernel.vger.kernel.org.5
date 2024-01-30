Return-Path: <linux-kernel+bounces-45095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A283E842BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B061C246B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822861586F8;
	Tue, 30 Jan 2024 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKZCZtX+"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158A1586E6;
	Tue, 30 Jan 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638901; cv=none; b=DQnVXxqooL6zyac/2gvwYQcx6qso45z1JGBS/5AdvmnqcUu3P25s0A7dSYG9e89/m9q3FnmjBk7LA+Tgt+DGFfri5MgDeEq/0k/OUv8dalXBHxr2a+NA074wIrs2AIpLqPq3gZHUdOpMYVHqMUSJ02wHhB+4xpHE20MFGVTZXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638901; c=relaxed/simple;
	bh=HGDpyfKI2RDyGPXzCZEZxUOoyZ5xEWyQzEQkIW49rB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBrPncbT6+XEyqaLXLaY7ZMBSErfgsFsWYBo/9wgB1zQ5VgRVZYCchK64+x/CkCFMorEqs1hL/34FWLMKWerC6eVgGQpuWSBFczcX7kfSWre0MJJr5f03jtPnvKaN3I8Ru0b77cvA4+sGN+s+LzHtLwL3Rs1mpGYZ8hkePLR9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKZCZtX+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ae42033e2so2539620f8f.1;
        Tue, 30 Jan 2024 10:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706638898; x=1707243698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2U4TAbafybXjGIReik+c+16abvnMXxD9lt1dnQ2x+0=;
        b=AKZCZtX+tGhMkICgE6x05b3YYPhRf+g8aiT8WCmcSM+JuACwpqHE2bYwAo6TTpPvU4
         pFHPqxpqxrQ1HmLFWIJ5IvgP6v4EbxV6wrI9I8uUu3pnumfpnrt0tF6Vl7pc0nxIVqGG
         1sXnAqC7ENoI+aRUREsCjQZkB8USOysorYyPBqOnIKo4YRO4XZtkY4QJywrxZjLp8SNB
         ZWcXrQo/um5UXo5vsITdiSGqnVPOtcDjCvp1Y8hgmMNMasCMq3ndHud8mw7Ko0Rm1A/K
         InbQZE+jYp6P6d89XPWqcjkeNPkweAK1TE9ca4+M/4g9Zhyp5AJJdCtS83Zm6xik0Vdi
         MRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706638898; x=1707243698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2U4TAbafybXjGIReik+c+16abvnMXxD9lt1dnQ2x+0=;
        b=oDX3Mt5kkSbQKS8wZtK3JUN8QcCbk4vpDflpyoKu5H0983YLeV4Z2oyWW+3u3d2wOP
         YPqs3NJU8ZQ5op/Va4+0nJ+H2cM1LVjCvHAVYrv9LzMVme9VZeowaP7pZuCHh5hz8HRB
         d6R8/spmzOxsSjFbht3iBIamsaPLNofwr0ZHZloAdfgX0m+iv6Mz9NDDHEhscMHhnJYk
         bVvtz8dBf4WP5Sm/RWrry0GAIVePhTEz83SiHreihlGeq1BYSalNGtxptS/uLknIvSYG
         +lpqlU9AQuaWveN5RwNMf+5pahi/U+Dhm1MY1sht/QrcM8SgJjTm5er1D3GVzZHLZE+B
         ITTQ==
X-Gm-Message-State: AOJu0YywpFNkkELfLb2/YOFzcH1NRAJvzsHZeu7gTVb4BNW8CWmaBpyT
	cHAIprLibDu6l54zGqD/PJfZfoP28UYotscxJeM5NHPKIXzuf8YfCKKcFn2fcfiSiw==
X-Google-Smtp-Source: AGHT+IHBQCMkepKWAeKxDUBpAUlEm/TcMlAb0frcezMSAbReG028bhaOw7guEcR7uXYxNnjS1D6e1g==
X-Received: by 2002:a5d:648e:0:b0:33a:f0cf:3d5d with SMTP id o14-20020a5d648e000000b0033af0cf3d5dmr4379648wri.23.1706638897973;
        Tue, 30 Jan 2024 10:21:37 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:50fb::d35])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d4352000000b003392b1ebf5csm11374254wrr.59.2024.01.30.10.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:21:37 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 30 Jan 2024 22:21:14 +0400
Subject: [PATCH v2 2/4] arm64: dts: rockchip: enable temperature driven fan
 control on Rock 5B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-rk-dts-additions-v2-2-c6222c4c78df@gmail.com>
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
In-Reply-To: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706638888; l=1891;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=HGDpyfKI2RDyGPXzCZEZxUOoyZ5xEWyQzEQkIW49rB8=;
 b=SYlXApX3kBczLS+c6uzRjnh8soVjqGOy2sCKbiM9vFvUCq7QzrBgjPc4X6RD1zHn7x6nI6c5T
 NphLweK5PuFB48PdHMzbxOCZQm/mH4l0jyf+QEWD/Ieb4W7jpHn3xIr
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

This enables thermal monitoring on Radxa Rock 5B and links the PWM
fan as an active cooling device managed automatically by the thermal
subsystem, with a target SoC temperature of 65C and a minimum-spin
interval from 55C to 65C to ensure airflow when the system gets warm

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 34 ++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index a0e303c3a1dc..b485edeef876 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -52,7 +52,7 @@ led_rgb_b {
 
 	fan: pwm-fan {
 		compatible = "pwm-fan";
-		cooling-levels = <0 95 145 195 255>;
+		cooling-levels = <0 120 150 180 210 240 255>;
 		fan-supply = <&vcc5v0_sys>;
 		pwms = <&pwm1 0 50000 0>;
 		#cooling-cells = <2>;
@@ -173,6 +173,34 @@ &cpu_l3 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
 
+&package_thermal {
+	polling-delay = <1000>;
+
+	trips {
+		package_fan0: package-fan0 {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+		package_fan1: package-fan1 {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&package_fan0>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+		map1 {
+			trip = <&package_fan1>;
+			cooling-device = <&fan 1 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0m2_xfer>;
@@ -731,6 +759,10 @@ regulator-state-mem {
 	};
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &uart2 {
 	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";

-- 
2.43.0


