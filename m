Return-Path: <linux-kernel+bounces-53081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74C784A073
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBC11C21F6F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2393241748;
	Mon,  5 Feb 2024 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXCx+wYw"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8624121B;
	Mon,  5 Feb 2024 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153623; cv=none; b=jQfBGyyV8YdH4hBR8MW63M9YYyFjV+CLTEyvqCyzYvco9/C8YNZgtKaq4O9hchLXVRgUYqt28YA7Ov47WHH6rNa2gB3WlFrGFnXV5qVKaYgifqQ5Xs4HG5HM1uE1OcxGFhR8dOZTuAuoe2nbJ755I2EzOi14RzFgEoe6YUNNvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153623; c=relaxed/simple;
	bh=tfG76yRqDK/luXO6etvpkAupEzDugyfS3UQHqVynP5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0MW4X4Xm+GCVwcGyaVTbsDaYrw95oNQFBw1D9W441QOaknHiQYbgkQx/3KXQ1+JULZNyuTOgO6qs+Q2szMlwP+eRFjYOMtvi8sbjQ7vHcEkXoiicYDI5SHqQ2sF8cUOuaYMMFXh8FjQvtGcKAZIXENx0hkG1hXHNywesnVHE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXCx+wYw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d76671e5a4so37446085ad.0;
        Mon, 05 Feb 2024 09:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707153621; x=1707758421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQKgDn03i1GuOds6l+szL2kWc+E6jwK9dMeqY6Pk45o=;
        b=BXCx+wYwUqyk6x3MltxyYmF2L8RfgwcjB4CrWleM/zcwu8kWK82foi3s11J/8p4aVn
         4LMdmVwXngmuQy3FBoZY4CjC08EMUXbVazddvMO/U0fmdDKEjMlyP7aE/KhttAFsLL7X
         WolmI3yH7VvVVhFnADKcxTuwtDjNh1VIbXV+LpqqpuqU4SgctxUKevBs+EWVqY69gcHa
         BwTLif+L2ofkqWJ5cElwKzSLfDBTMCeMTceFmCc5uCLpH6TTPqDXYWLTwBjSMjcK6uQf
         HNrzbok11jT8ajMPUdVbrjFW7kBcPL03zMqFtMX2bvWLi2fBrUv7ImYtvITDVEngQVlM
         yCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153621; x=1707758421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQKgDn03i1GuOds6l+szL2kWc+E6jwK9dMeqY6Pk45o=;
        b=hW59uytXEok5LQAs6MxwXeft+XVEGU8USZpISLLKtZVQ3MC5JcTFJI4XtGeqxygpi9
         SJLYTf9AzG7AtpM1GfXnQ0ewiCUrtOxbigy8kwir2+nR8L3O+NG9sZ4hamRvSQSHTk5E
         7KsfDKh8klOHaiovaqGK3lSCNhkej8NGElIBSElCSQIQaXjXI/iq5MQzEc5kJWN5LZD+
         /Jw6NtljWRBmU58r4jnN+SMeU8zGnpFIA3WBPBUmjYe8h+j8H24ss7WxZXcLg38p/GBf
         VO5QfrG+nN6maNjgr2euZL4S7mUhieXnGKUb5xmXSOIW2DOhXz2HfqRG/C02EZFBUC4q
         JKRw==
X-Gm-Message-State: AOJu0YwSGBIT7iV3TBHsUjommiQ5jijiVjC3mwp9/LIbhc+NTZoZy6OG
	DUo7+EWSEbiEH9JFENGegFFeUP4/trUG9VhOleV1z17IGteSSerR
X-Google-Smtp-Source: AGHT+IFqPTMGGZiQP3HR1CzvHwk7T9mUypcca+zTGAW/g1IqTd3017nW97CqgG7CXeTtQY9DilS0Qw==
X-Received: by 2002:a17:902:6b08:b0:1d9:c367:201b with SMTP id o8-20020a1709026b0800b001d9c367201bmr127932plk.29.1707153621183;
        Mon, 05 Feb 2024 09:20:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUFDNn7JCUbUV3ym9LXRogPi6B/69fTu5XgtGm6JfDORTFNSkvLThm4P3H00hXfqDGOngeghOPWvrt88Nclu682qJ+d7/MaTSyfYUtjHAUyynDy+tzzWPAVpGFWYNsFQfR/8D1WSFS6NeBRyeu6bxfWl1p+DI4zrxpj/B1ErQLccrRmEm+S3P06NnYEHk0yFrsVU/y2Ar/M7h3EDPYxffiKZukgfEQNRDLKb+3b2/5GLlwiFr49eTFbL71cohH+9hWi0jVBJAf4Re/mLDTnXxtXiQUC10r/O0XGH7ZoXg7HtlS3bQrn2A8T6dx6xKEu1yjHLFiK46vvLJVXT1ZZehieSXHkjKJyUs9DzVB04vS5Jz4+Z2tacBfzeAc/2nCVj6rMTvGTrJGPwcBEW2GsG3Zo/OAxMX/oQSurUHyitdfgYZF7ek7fWwl3tc36+Ydf6uTrDJKz
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001d8f3c7fb96sm107518plb.166.2024.02.05.09.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:20:20 -0800 (PST)
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
Subject: [PATCHv1 1/5] arm64: dts: amlogic: Add cache information to the Amlogic GXBB and GXL SoC
Date: Mon,  5 Feb 2024 22:49:19 +0530
Message-ID: <20240205171930.968-2-linux.amoon@gmail.com>
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

As per S905 and S905X datasheet add missing cache information to
the Amlogic GXBB and GXL SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

To improve system performance.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Datasheet
[0] https://dn.odroid.com/S905/DataSheet/S905_Public_Datasheet_V1.1.4.pdf
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 2673f0dbafe7..e141ade5e49b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -95,6 +95,12 @@ cpu0: cpu@0 {
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
 			clocks = <&scpi_dvfs 0>;
 			#cooling-cells = <2>;
@@ -105,6 +111,12 @@ cpu1: cpu@1 {
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
 			clocks = <&scpi_dvfs 0>;
 			#cooling-cells = <2>;
@@ -115,6 +127,12 @@ cpu2: cpu@2 {
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
 			clocks = <&scpi_dvfs 0>;
 			#cooling-cells = <2>;
@@ -125,6 +143,12 @@ cpu3: cpu@3 {
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
 			clocks = <&scpi_dvfs 0>;
 			#cooling-cells = <2>;
@@ -134,6 +158,9 @@ l2: l2-cache0 {
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


