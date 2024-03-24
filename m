Return-Path: <linux-kernel+bounces-115052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC94A888CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1AC21F29616
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C483B1C2311;
	Mon, 25 Mar 2024 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQir3qqX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B6131BAA;
	Sun, 24 Mar 2024 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323855; cv=none; b=sTq/9LDR6MzC8t38UGuHLNNYpWY/dhICCyZ0j/BGwoo7fLZm9SmCdKLpNgUMWY+0MhaEj+9bEI9ad9c3Rnx7P9OQFRJ0/PPaxA0yBCqnZijAYi71O9MW3FxwR1drDmcbPv8IEjSp4BKnykRHkymj94U0y5I4E7DMatLz7Ld17nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323855; c=relaxed/simple;
	bh=nmx0U2KmulJ7xDHIJW5s6GGwnezIqUNiH+3mH1f/4gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJLIwPqykVKLh+CBTGoP7Ud/C2cBzMprscXCw0Ri3JUhY47kt8oLWTbwQsGMqN84g/a/t08N40liwEty1LGb8fwAgD1sxvNWQiOb3WRhooRuBhKEkqYETmXoeqrWrGesXALrwnOkLAPkCgQ1yvUAxid6J/oj6djNmy3Htiaq2KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQir3qqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B24C433C7;
	Sun, 24 Mar 2024 23:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323854;
	bh=nmx0U2KmulJ7xDHIJW5s6GGwnezIqUNiH+3mH1f/4gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQir3qqXfXvlwnw180fdZ3eQdwh4aVrSrlorMAPdkRk2Yps8wrEbCbA92FgGDG2jB
	 qGIcE3zFPqgJPnOMLIcrW7Kq7kX8nbm1x/jWces/9TKZsnBzHoSzR1qusTFVfX6SuP
	 3b7ZW42FqhXeKoPASWJU5yevCkNU6f8WInG4ez8tejzJLymaepbv3cbywtZmjEcFCd
	 LnGsY3rdBYhsePTRuY8l6u7lmLT7T913FhT2UKNaOAO88X7P40Uu8fKn1gE1EQD9i9
	 Ze8Juxx/GEKft1vAa6kAFkHW6lgHJN1TgRnlPAfp8nuAsyK7Da4Oq9nQ23qv5Z+QEV
	 1LHo8soBJyEJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Klein <michael@fossekall.de>,
	Maxime Ripard <maxime@cerno.tech>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 232/238] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add regulator nodes vcc-dram and vcc1v2
Date: Sun, 24 Mar 2024 19:40:20 -0400
Message-ID: <20240324234027.1354210-233-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michael Klein <michael@fossekall.de>

[ Upstream commit 23e85be1ec81647374055f731488cc9a7c013a5c ]

Add regulator nodes vcc-dram and vcc1v2 to the devicetree. These
regulators correspond to U4 and U5 in the schematics:

http://forum.banana-pi.org/t/bpi-m2-zero-schematic-diagram-public/4111

Signed-off-by: Michael Klein <michael@fossekall.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://lore.kernel.org/r/20201130183841.136708-1-michael@fossekall.de
Stable-dep-of: 4a0e7f2decbf ("netfilter: nf_tables: do not compare internal table flags on updates")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index 4c6704e4c57ec..74d5732c412ba 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -62,6 +62,30 @@ reg_vdd_cpux: vdd-cpux-regulator {
 		states = <1100000 0>, <1300000 1>;
 	};
 
+	reg_vcc_dram: vcc-dram {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-dram";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
+		vin-supply = <&reg_vcc5v0>;
+	};
+
+	reg_vcc1v2: vcc1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+		vin-supply = <&reg_vcc5v0>;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
-- 
2.43.0


