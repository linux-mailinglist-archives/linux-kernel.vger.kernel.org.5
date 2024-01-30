Return-Path: <linux-kernel+bounces-45096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56F1842BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A934286C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBE015A49D;
	Tue, 30 Jan 2024 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHpRRr+j"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B9159584;
	Tue, 30 Jan 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638905; cv=none; b=SHvf8pO1w57J+Gaf7rO3Nezum4KX76xM+VbHDk1ohqo7Lb3omWQ0vbQD3wKayTAAjYbjtG0hPH+BRU98+ZgY3h+vtpoD3BG6PJOLWhYtw4br10CYULlXFzoDNnVOOlDapxwGJ79o8e5L4aMX4hIfsmNTUwiR1gii/so1LKf2sN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638905; c=relaxed/simple;
	bh=qKHxRZMdX7Ar4Tj1hshUChwl60L+N5VIFghv04DWmdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGCNixNcHaM6KNRZ/WO0i0pVr8ShCTdK0lxomdnHCO/xcHAGUA9Oh+nKe7R/MflyRIMEajhMTZk3GheRwzBIEr92o8HMIa0S+Ffco6gamVpsY2R5Bj/gsR5Fc2H3HIlUO++EmZDsMdqZLBKPotUjn6GiiIoUavENvRC9o8LwAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHpRRr+j; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394ca0c874so3552609f8f.2;
        Tue, 30 Jan 2024 10:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706638901; x=1707243701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gI9Ml9wRgXKLGlzoLORIisEejDK3Kkmbvg0DC8EST0=;
        b=iHpRRr+jmgUoFmwOhklUqYrwqTpCr7U+fy9K/WfeVVX6wnFMGYl4te1nIaWlxiumOh
         h5si9YlKcjF/60XVQIGL6Ap2+9/FaNNZCxnhnFZyJrciH03zj3DV6V37AZPDZdw9uHVo
         E7OyNkQMHwyFeCHlFrqsnjZumM9MrPdkV+ko7EaSE6lzpeNHiR5kraLP1QD3c9NlE/ZX
         g39ZF1vBs2JQB4PS/xJwYVtBBHv+axQX3hyMLIhYmpnZljoVslLS1E97m8cxSERnuQXZ
         vxyWeqmu3Z4uEuLXQjQqa8jfs5+QIhx8kBC2wglfpcWsKNnHoM6PPoduKnyZQAJF8nqR
         fjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706638901; x=1707243701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gI9Ml9wRgXKLGlzoLORIisEejDK3Kkmbvg0DC8EST0=;
        b=lxUVlnVSA4IHfkFuEm758kYGkmpSi0oqhMOVWFjoy030jaKlXsUO2r8mSOtCenp7EK
         /cobmgjngE9XFrG62mr2mHWDZ9DOK65Lzx6pa+gfQbtG+XzuiW4oSCEiRA0khcr28jLl
         9jFJYKaqFkWFwoLyUao259lRHUUMKJ6Uqdt9IHTILq+Ec217wZSC70tvQexmTqx+3iRF
         tpnJJKTa54By0EsSThd8g50azFYbv/2eQa9Qkc3Zn/7/MSVvbU3PzPAOWfU01tb6I2O+
         2A1hQAkO1VNvdzm35wy8p4NLhE5+pUy5zPUZMibwekEXEJyZ+JNb3Xo4siDlheuimy4Q
         EqqA==
X-Gm-Message-State: AOJu0Yy+2JB9xAztfBBAuit4C1ZjvonYx/jl6mKWd/MX6Re6oROq6xiY
	AthJQnoIZBhS1zuOlqTgFGAcbhFluBecUPztCHl7SfmbTzdyI8m6
X-Google-Smtp-Source: AGHT+IHg3hKiKQ2Rqr2darLpiuJG03zVu17ObsODDESWVoas/zrX7VMxxmtrtisvBwd5wFBqnoUeVg==
X-Received: by 2002:adf:eb4f:0:b0:33a:ee08:7541 with SMTP id u15-20020adfeb4f000000b0033aee087541mr4331501wrn.35.1706638901496;
        Tue, 30 Jan 2024 10:21:41 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:50fb::d35])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d4352000000b003392b1ebf5csm11374254wrr.59.2024.01.30.10.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:21:41 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 30 Jan 2024 22:21:15 +0400
Subject: [PATCH v2 3/4] arm64: dts: rockchip: Add OPP data for CPU cores on
 RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-rk-dts-additions-v2-3-c6222c4c78df@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706638888; l=6248;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=qKHxRZMdX7Ar4Tj1hshUChwl60L+N5VIFghv04DWmdU=;
 b=WXAIPQODiocjnhp//mdzH3nuuSrciVnNBAux59L7tdp7xACtmHuZJ1Wg4lponVsLVlAF8Lp3F
 chMkRm3fnEiADfxjk6X2rWqR6lIWCScYgpjDOEPCY+eQk5VEC22S1s/
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

By default the CPUs on RK3588 start up in a conservative performance
mode. Add frequency and voltage mappings to the device tree to enable
dynamic scaling via cpufreq

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 122 ++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 696cb72d75d0..af8b932a04c1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -97,6 +97,7 @@ cpu_l0: cpu@0 {
 			clocks = <&scmi_clk SCMI_CLK_CPUL>;
 			assigned-clocks = <&scmi_clk SCMI_CLK_CPUL>;
 			assigned-clock-rates = <816000000>;
+			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
@@ -116,6 +117,7 @@ cpu_l1: cpu@100 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <530>;
 			clocks = <&scmi_clk SCMI_CLK_CPUL>;
+			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
@@ -135,6 +137,7 @@ cpu_l2: cpu@200 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <530>;
 			clocks = <&scmi_clk SCMI_CLK_CPUL>;
+			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
@@ -154,6 +157,7 @@ cpu_l3: cpu@300 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <530>;
 			clocks = <&scmi_clk SCMI_CLK_CPUL>;
+			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
@@ -175,6 +179,7 @@ cpu_b0: cpu@400 {
 			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
 			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB01>;
 			assigned-clock-rates = <816000000>;
+			operating-points-v2 = <&cluster1_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -194,6 +199,7 @@ cpu_b1: cpu@500 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
+			operating-points-v2 = <&cluster1_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -215,6 +221,7 @@ cpu_b2: cpu@600 {
 			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
 			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB23>;
 			assigned-clock-rates = <816000000>;
+			operating-points-v2 = <&cluster2_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -234,6 +241,7 @@ cpu_b3: cpu@700 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
+			operating-points-v2 = <&cluster2_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -348,6 +356,120 @@ l3_cache: l3-cache {
 		};
 	};
 
+	cluster0_opp_table: opp-table-cluster0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <675000 675000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <712500 712500 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <762500 762500 950000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <850000 850000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <950000 950000 950000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
+	cluster1_opp_table: opp-table-cluster1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <725000 725000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <762500 762500 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <850000 850000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <925000 925000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-microvolt = <987500 987500 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
+	cluster2_opp_table: opp-table-cluster2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <725000 725000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <762500 762500 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <850000 850000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <925000 925000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-microvolt = <987500 987500 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
 	firmware {
 		optee: optee {
 			compatible = "linaro,optee-tz";

-- 
2.43.0


