Return-Path: <linux-kernel+bounces-45097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89099842BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFFE1C23C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2CF15A4BE;
	Tue, 30 Jan 2024 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtaOnWp0"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3515A4A0;
	Tue, 30 Jan 2024 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638908; cv=none; b=ErIAaTk9vYStOIu4MZLNwBM7sf1oeaKjuFKvIFduWXOr1tHCk4hJxFB+TIQYRYViJBvvZylG/sBEuSFl47vnce2tr4wlBOQqrvsCYKCmJBf5N9hOVu1QUf6dLzuPSBc1TcgozplMy3oqHwqPL0Ry9Kk3E4KzTV11ojNRoT0zjVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638908; c=relaxed/simple;
	bh=aJBlbBzLk35xluhYDDqKkPd7JghGWbRpRxQd2L86Bv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVflgGaNFTsZH1L8HY8scOu7jl65TpVbjZeC/f3PGg/TE0+TtOtU1z0dZGAGSQDyebdQOA79PtiZoytR6dLkh6darVe1Hu6BZO7+zPhMTUrwpAV9lM9VgdwfQMJl2e95nhs7XzFhnBmsLKHLuD5zQj3zLwxiKpra0gvLdHwzqBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtaOnWp0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so47211825e9.3;
        Tue, 30 Jan 2024 10:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706638905; x=1707243705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCgr8fam0PZwcsY4iS5GHvHyFYZQiFYZ6P//7dIPCFI=;
        b=gtaOnWp01fk5DF9qfQY2jX5n5WF3xOpa3asi6FPf5S1OIFEext8qhCi4i+KNYv2IUA
         h234GUCfDVl5tL7KjdhTxFZGE+QyekuptAFiW5fdn9ByFJ7lov2f6giMC4Q/+Jc7zdo/
         7pnrLnMY128+PJn1pRu4eqIfg9y1CkSDPecSGgfsc5RQDn8ObfE4dVeyMfR+GwCK4+mn
         JNKCmzT1GkLnTxQfBOErWhC7DjneLXvJkPY+CTbxRr8EqnVLxVSc7O4R+BqF8h5DB3X+
         h4bJO8Mr0GkkgjqSt8frcfM3TzRTtKNcKLdLdohekbK7MjHMRL/w1OphWHjfNDEcBxg4
         DLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706638905; x=1707243705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCgr8fam0PZwcsY4iS5GHvHyFYZQiFYZ6P//7dIPCFI=;
        b=RJmoo6VyVI9kbnXKC2xefhrvTluzrqVzvxrpdAKQU6Otn0WJhoYdCP8rV7RrJNja+I
         Ym35PWw6G+VL5elMohswhSsTu6+o8ARdcFAooZ83qNZp+a+nMGmsZFh1pXJWTCnKB3ml
         EzXOq/doYhMvL7oQorZ9QQ0PrNxf7NWhz40KV4fWsTBweyG8F3kUi6/nhNNe8z4lrjBd
         xWQA7NTFGLWd9D24jMpAQ9tenF6/6ZwYzxTazatBRRk7uJRsWSeMUkbD1swoEbYp4RII
         78QNubfLk0wbmolEayT+kjRQwXRL+8Bt53ZLm/DPdzOipJ675C2YfNdU2kRTSyUnVro8
         g6pg==
X-Gm-Message-State: AOJu0YzCqDhdhREywxwwinUWGouRo6yNBXrOMOkNAep5Yk44FVkbW0IF
	FDkZwiTE9UrqNxjNVy6Q0XaJM/PMvI1/arym6IdwAvgFG2duBh9PP8xaN+ZuDh+xtQ==
X-Google-Smtp-Source: AGHT+IEaGClGMCGaMap75kEkKgVtQ/kO1vzv7boK9OwuWCkBIx23u3amrCwLk/Im7kbuzD8yEt8yYQ==
X-Received: by 2002:a5d:4048:0:b0:33a:f431:3489 with SMTP id w8-20020a5d4048000000b0033af4313489mr4002337wrp.56.1706638904893;
        Tue, 30 Jan 2024 10:21:44 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:50fb::d35])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d4352000000b003392b1ebf5csm11374254wrr.59.2024.01.30.10.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:21:44 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 30 Jan 2024 22:21:16 +0400
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Add further granularity in
 RK3588 CPU OPPs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-rk-dts-additions-v2-4-c6222c4c78df@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706638888; l=4728;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=aJBlbBzLk35xluhYDDqKkPd7JghGWbRpRxQd2L86Bv0=;
 b=Wcw/w/Kf9x9YIWkZW/nCSxBwgCUVj9Q/t9fnjkvjyk30DG0la7ddy2b/FyVw3hAsYmpAVW46t
 JPdQ6dguXM1BgvVzctgFPWbpC0MaBl+PXUuTfTqB36+9z6OOdVTsKPy
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

This introduces additional OPPs that share the same voltage as
another OPP already present in the .dtsi but with lower frequency.

The idea is to try and limit system throughput more gradually upon
reaching the throttling condition for workloads that are close to
sustainable power already, thus avoiding needless performance loss.

My limited synthetic benchmarking [1] showed around 3.8% performance
benefit when these are in place, other things equal (not meant to
be comprehensive though).

[1] https://lore.kernel.org/linux-rockchip/CABjd4YxqarUCbZ-a2XLe3TWJ-qjphGkyq=wDnctnEhdoSdPPpw@mail.gmail.com/T/#me92aa0ee25e6eeb1d1501ce85f5af4e58b3b13c5

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 87 +++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index af8b932a04c1..506676985a7e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -360,6 +360,21 @@ cluster0_opp_table: opp-table-cluster0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <675000 675000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <675000 675000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <675000 675000 950000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <675000 675000 950000>;
@@ -392,6 +407,27 @@ cluster1_opp_table: opp-table-cluster1 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <675000 675000 1000000>;
@@ -422,6 +458,21 @@ opp-2208000000 {
 			opp-microvolt = <987500 987500 1000000>;
 			clock-latency-ns = <40000>;
 		};
+		opp-2256000000 {
+			opp-hz = /bits/ 64 <2256000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2304000000 {
+			opp-hz = /bits/ 64 <2304000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2352000000 {
+			opp-hz = /bits/ 64 <2352000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-2400000000 {
 			opp-hz = /bits/ 64 <2400000000>;
 			opp-microvolt = <1000000 1000000 1000000>;
@@ -433,6 +484,27 @@ cluster2_opp_table: opp-table-cluster2 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <675000 675000 1000000>;
@@ -463,6 +535,21 @@ opp-2208000000 {
 			opp-microvolt = <987500 987500 1000000>;
 			clock-latency-ns = <40000>;
 		};
+		opp-2256000000 {
+			opp-hz = /bits/ 64 <2256000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2304000000 {
+			opp-hz = /bits/ 64 <2304000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2352000000 {
+			opp-hz = /bits/ 64 <2352000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-2400000000 {
 			opp-hz = /bits/ 64 <2400000000>;
 			opp-microvolt = <1000000 1000000 1000000>;

-- 
2.43.0


