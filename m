Return-Path: <linux-kernel+bounces-82132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BACC867FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D6E1F25DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A83B12F371;
	Mon, 26 Feb 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndoDhY9W"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C660DC5;
	Mon, 26 Feb 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971809; cv=none; b=O+0Yc2cmIghBzMmZ2wxNcCmSy4YxbaD0VE/uIBhPPVSjpZ3Xv6pIs1nZKxR0IfXg/uXgHvK166ej1BvBFMEkFRTz1xLzHDHO411PCcTin2WxlLVkvuBhci7IHoOLhp2vs00VNmchUPSpL+vLe5lfCOYX1RkNxQKR1MN1jQG+BQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971809; c=relaxed/simple;
	bh=Q+hnu8amVqGGKWiAAjeU+PULKBuLit8f6zcLD9Zz+aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEFgOPCsTybtUirtP2zog+No9trgk+9SqnpL/VfZ1mcBotcdfKWw68SRVPDo2haLnOBudMI0Bpvj22erYlc71NP/SXj/QJmxhJNrboamARJrkOmpzoogezlNoL9QEBSMYFYlLoJprY3cUGP4PFazSZezfEa2ImXXcHY4jANz0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndoDhY9W; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d944e8f367so23751305ad.0;
        Mon, 26 Feb 2024 10:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708971807; x=1709576607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oq9kS8EeuXsGUVpRBBrLiDhME6a4wGuEkqHoj3EbhjU=;
        b=ndoDhY9W9X0+nLzs52XUR6L0iuX8Mk88PsKZ6hdRNjbdOGoXtZ0y8ijDVWWZD3QDtD
         wqb09dlS1MhmLxw3BMchgfSVFCqLDoeKLmjAoH4V6d3hNjwJ9JYXeR5BLnTvwuiJfal0
         onYj03PDjQDOSfW+uLqpd7poHntT1WBgK0n/OCD1tBaZkdEMWbWwUtzyb3xP/DhmbQUo
         ADSXwmjodDpnUiNqun8ywx/oZ0aWEZXwlJCYBYA4wHzzT3bjbxIaETW48gdXb4PQ8Tjz
         XTzdJ3IznT5aRssBZrrDRCWNnt2UZ6QofuCLaATZVzpup/59IcgDbj8ZeAffSvMVoerw
         DKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708971807; x=1709576607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oq9kS8EeuXsGUVpRBBrLiDhME6a4wGuEkqHoj3EbhjU=;
        b=h0rhluAnHrxbZ4UdECYUcs2na4gLRKb+iOWVCDjLqWsh7CKHgzrM4oc5Ek/7XbUSwx
         YGH/WFklo7oUlVwa6oHYGNnTCmWbw9qBZaxV57HciFzKCg9xC6CTuPf577ll5xlpBAwS
         BZL2mEACq1EksDeRtku4hKSMUQnIjnpmIou48D6dcQkgnv3yc6hDUgU8Sookpz4N+RPv
         5rbfnI+3JZvmHBGWDRuL4wbM76v8Rq0W/cIeTEkZrKZA7ZbYll2dS0bVP1L0PKL1BZLD
         t2ItLqEyWeEGae1M0aW3jvMnUFIaWK5FnIkHcnZ4d38Byrj25ugHNbEgN+drFL38zA5t
         yqwg==
X-Forwarded-Encrypted: i=1; AJvYcCUlGU4+ob4+NQTGu12BbG7Ua6qa/+9MsZwr+OdJy46K/XarLubihOjypWdUD7+ssjQSXjKsRmjXVmwOf9jZ8+21FD4CppzsVHFg27p0GZtBxPL9SjejR+XJ34KsCZOn5iM8GxYr2WnOhw==
X-Gm-Message-State: AOJu0YyraBaR0Syt0ed9gQjhF5olTfpuryqV8NzZTJhSTZ1qHqyK0/Tp
	gDfWoAdSVUZBkaNFERttOtXbDNgJTubPiHxrMwBB+PNL6HNbaX86
X-Google-Smtp-Source: AGHT+IGcMiAe18D+5u0jq2w+Qc6RGbcBVwo+6peup7V+MeX/rhw3iKmj2TOIPAmop9O04XOqDlG6/A==
X-Received: by 2002:a17:902:e9c4:b0:1db:f23f:678e with SMTP id 4-20020a170902e9c400b001dbf23f678emr6781170plk.15.1708971806955;
        Mon, 26 Feb 2024 10:23:26 -0800 (PST)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id v19-20020a170902d09300b001dba98889a3sm2353plv.71.2024.02.26.10.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:23:26 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: rockchip: Add cache information to the Rockchip RK3566 and RK3568 SoC
Date: Mon, 26 Feb 2024 23:53:03 +0530
Message-ID: <20240226182310.4032-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per RK3568 Datasheet and TRM add missing cache information to
the Rockchip RK3566 and RK3568 SoC.

- Each Cortex-A55 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available with ECC.
- Along with 512KB Unified L3 cache with ECC.

With adding instruction cache and data cache and a write buffer to
reduce the effect of main memory bandwidth and latency on data
access performance.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
[0] http://www.rock-chips.com/uploads/pdf/2022.8.26/191/RK3568%20Brief%20Datasheet.pdf
[1] https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index c19c0f1b3778..49235efefb6b 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -56,6 +56,13 @@ cpu0: cpu@0 {
 			clocks = <&scmi_clk 0>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
@@ -65,6 +72,13 @@ cpu1: cpu@100 {
 			reg = <0x0 0x100>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
@@ -74,6 +88,13 @@ cpu2: cpu@200 {
 			reg = <0x0 0x200>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
@@ -83,8 +104,24 @@ cpu3: cpu@300 {
 			reg = <0x0 0x300>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-unified;
+			cache-size = <0x7d000>; /* L3. 512 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
+		};
 	};
 
 	cpu0_opp_table: opp-table-0 {
-- 
2.43.0


