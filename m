Return-Path: <linux-kernel+bounces-53085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1484A07F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611ABB254C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1BB41218;
	Mon,  5 Feb 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRSv9xwa"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAF247A7B;
	Mon,  5 Feb 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153647; cv=none; b=O0GQ1hiAwbeZJLkJfiahO8XNoEqmjlRRmgvYk3OICpqbaBFTWZKIF+yiVUIIwAUlzQL8HyBGjnajRaT/6/M/ACbpisOFvQWpnNQbPYZond5gbSAIE+dvhYaHnzE4S4kLkjlbUGhhbGCVFPmZSlpnbt33JhePNO95mz1RIaPO1x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153647; c=relaxed/simple;
	bh=7F7eONmJXnLRd75fXrJvRe4uunv1k8PGlqMRIxje1G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrUekvU2itzdyDLtOVNrsrhbMCZFsPw/XQEh/NVT43xEgq+QG3EDckS1lbgDXZZKXabZv/Fh3EBY85OqZ/15hZvjQ0EApxMsrwlkUQVdQb+VY9sdEfhKr1guwhqdvDKjJPvagxB6V89W2Ym/x/DvG+03wgoeJt69jgPMunO53EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRSv9xwa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d731314e67so31053165ad.1;
        Mon, 05 Feb 2024 09:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707153643; x=1707758443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWaLBR0WlEM6D0U1zRhCBiq+gAlYg7I48ZvwUp7dgNM=;
        b=HRSv9xwaxhPZaXkXIU6mW3MMDr3CWv87F0ioYFtKURPn9ZFdJ6BSmnW2B9gmZpqlTe
         XNj3zu34njYHzHdyCSfQxxryFQbdEvPJsBslJU9reXL6tMyHY8hAYfoLpGg4+/SQwQ8N
         IjpriUS/OkYPxv6I6sIgt/DefyFd3MxoxQt2vEhcygy/jda779WnMeibVX8qOR6eshJz
         MWQFYNOhE4z8HfGHyX4qRIQuFHXIJY+MRvat0/FvPDkft0axhkK7N3YqFxMsnOb77+fK
         r1IQHdncDiMAg+kHwBNBcEEdrh+U8VePKUkUB9T/Eh8Fj59PLzzsg6zhN9CQCyfzFnqC
         iNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153643; x=1707758443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWaLBR0WlEM6D0U1zRhCBiq+gAlYg7I48ZvwUp7dgNM=;
        b=GZngW62BmYn5dfKTRiRM1fZKFKQwkyrgwITm4PFtQbVPBOFSOlKbfN7QQhwq2EMkg0
         zM7jz16DCN1VpRIkf7tuw64PA3Rx3P3cEdwqh0K5UpnjwnIwLnbERjER8s07alZJOmOF
         7FkKwoi9G/PknzxhhZkEzBe/25gzyXQCRiVtvBflWG/WfLzKnChj+8QG78ccRIq+ExBT
         ofFI61NBsBrefNnUWXM8HMzEMxIO9YKhgu6V7Vz8tym2eTKkmyGNwmfHxgAj6jI7QuaP
         ztBzk6fv82YmD8NXrn32GI78pgnafsT01mYJvas80yxnbDhOtgVx4aNWFER6BiA/nUiV
         bcWQ==
X-Gm-Message-State: AOJu0YwwVC+/3VdrZ3PeBk3hRcDTKQhFVlYzGCLaWBh5ISGNT1xyjCES
	0txOvCaIAyn+bFXEFm/BNWsj09j0YBTB6lVPIm2PMpcGiKuveMlo
X-Google-Smtp-Source: AGHT+IFux0vnAcGSigV2zamwXtg4bl0sAU+FnlK0V6Xxw8ZKPFwer90li5pVZLPDbgLC4VCq7hwykQ==
X-Received: by 2002:a17:902:ea02:b0:1d9:2369:d0f8 with SMTP id s2-20020a170902ea0200b001d92369d0f8mr206724plg.9.1707153642721;
        Mon, 05 Feb 2024 09:20:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW+4pcPDNpzBNw2iVMRZ7RtzGLMVV861ND21C1gOLQ9OKfpXU+VXgZXr9Eit972ikAKaNX4N28yaCXscWhRZo9KgUTsTztuw5GJK1vQSzv6rwf7PCBATiPIjC1homl0WEJtu8WDNYsl4XaOu6CtUw3TirF27PvyOXaeR92OBCznQgcvd3WdTrmm+OUvoLmMcF3OVTJ8s7NvArr9yM8D7zBwG9wHv0dGnnLitWIzpJ1tX/WVPJOxmSdpexTRNjpV6RGXsx657DbX/bOdg9nUKvHVZWim0VYOlXnZWsjU0FyUnAbjYkHIR5NMWxkthYZY4YZaV9uetBjIBQqTPqMOh/1+HsPcwySVfwf8pHk1KU7OP1mN3AHKXTlmwdwwsVcnU43ap6Fag123DpoJumMVLcMu9YQkx66BdOD0wG4J9ZQmEZ4xrZ3Z1GsMZvC30DU=
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001d8f3c7fb96sm107518plb.166.2024.02.05.09.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:20:42 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv1 5/5] arm64: dts: amlogic: Add cache information to the Amlogic A7 SoC
Date: Mon,  5 Feb 2024 22:49:23 +0530
Message-ID: <20240205171930.968-6-linux.amoon@gmail.com>
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

As per A311D datasheet add missing cache information to the Amlogic A7 SoC.

- Each Cortex-A53 core has 32 KB of instruction cache and
	32 KB of L1 data cache available.
- Each Cortex-A73 core has 64 KB of L1 instruction cache and
	64 KB of L1 data cache available.
- The little (A53) cluster has 512 KB of unified L2 cache available.
- The big (A73) cluster has 1 MB of unified L2 cache available.

To improve system performance.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
[0] https://dl.khadas.com/products/vim4/datasheet/a311d2_quick_reference_manual_v0.6.pdf
[1] https://en.wikipedia.org/wiki/ARM_Cortex-A73
[2] https://en.wikipedia.org/wiki/ARM_Cortex-A53
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 74 +++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index a03c7667d2b6..72dedc40f460 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -52,6 +52,13 @@ cpu100: cpu@100 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 		};
 
 		cpu101: cpu@101{
@@ -59,6 +66,13 @@ cpu101: cpu@101{
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 		};
 
 		cpu102: cpu@102 {
@@ -66,6 +80,13 @@ cpu102: cpu@102 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 		};
 
 		cpu103: cpu@103 {
@@ -73,6 +94,13 @@ cpu103: cpu@103 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 		};
 
 		cpu0: cpu@0 {
@@ -80,6 +108,13 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a73";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
 		};
 
 		cpu1: cpu@1 {
@@ -87,6 +122,13 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a73";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
 		};
 
 		cpu2: cpu@2 {
@@ -94,6 +136,13 @@ cpu2: cpu@2 {
 			compatible = "arm,cortex-a73";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
 		};
 
 		cpu3: cpu@3 {
@@ -101,6 +150,31 @@ cpu3: cpu@3 {
 			compatible = "arm,cortex-a73";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
+		};
+
+		l2_cache_l: l2-cache-cluster0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+		};
+
+		l2_cache_b: l2-cache-cluster1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
 		};
 	};
 
-- 
2.43.0


