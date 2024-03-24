Return-Path: <linux-kernel+bounces-115647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09468889D07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A933D299B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537842072DD;
	Mon, 25 Mar 2024 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfFc2MHG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5DD206CB6;
	Sun, 24 Mar 2024 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321515; cv=none; b=Q1ezI6jQJgRC+bAeyMPYKikofDVeRFRPB4Ye6dm/VsINJDDb+LBby3V4QazgIOrODtXucMNGx50CTCetU3zEoczaLR2sBOD4+JoFfzI/Xe7qG/VeVcBOmt6FWKulwyoleAetrZwG5XPUdD5EFvlmDBAz9BbB29xtEfVtOI09n5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321515; c=relaxed/simple;
	bh=IGQOYvFioDMkyrLxmhntj7OAsZokzDK/vs//sb00Q/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMsir5eaTWVtDcbcRIjXre5SOQMW0xPkQY2ppWqv168yzn/d3SqpsmTE8iG60bb7BqzS6XNGGivZ4Vki7uf9XSU3u2oh9P37ReR/FkEK9yzrMq8NQp6h+MK9PDv79S9ePd2hLbyt0OvRhQGnWeoIA2YPVDEIMhFjrUL6C6tEMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfFc2MHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243AFC43394;
	Sun, 24 Mar 2024 23:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321515;
	bh=IGQOYvFioDMkyrLxmhntj7OAsZokzDK/vs//sb00Q/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gfFc2MHGk4P3szIEfhlfC5WwajkXitfuWtc7D505rYfML6isSPFjbFowWVhhUwKqv
	 efUFUGcc2t3jcrb/mLh+EuY9X+/Dv1PHIHhF3VWR3GhrCHT0tt28EuMfjWg3WtVk9F
	 17/bx+hmhU3UIfcVUrMSWprHMf0TMZ5dItm756G5zqfZZy/KqSFxCga02/TOrTDcwQ
	 CNFHq1WBBtQKgsgGM7QWxJJ/I+PRYkMNgU3CVHORA6uTI7Pefzbv/BYyTRxBbq70hM
	 PjpsDT6kBxo4W6/EMSlfMkRg0NajpqI0IeZf+7KiC0sib4pe+JIxFbDiXo6yS65Ina
	 cdG8451NLMEXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Davis <afd@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 242/638] arm64: dts: ti: k3-am64: Enable SDHCI nodes at the board level
Date: Sun, 24 Mar 2024 18:54:39 -0400
Message-ID: <20240324230116.1348576-243-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andrew Davis <afd@ti.com>

[ Upstream commit 3b6345e3fcf4c93a79f396121cd0e6f98f04da13 ]

SDHCI nodes defined in the top-level AM64 SoC dtsi files are incomplete
and will not be functional unless they are extended.

As the attached SD/eMMC is only known about at the board integration level,
these nodes should only be enabled when provided with this information.

Disable the SDHCI nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20231117163339.89952-2-afd@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Stable-dep-of: 379c7752bbd0 ("arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi                 | 2 ++
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi          | 1 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                  | 6 ++++--
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 1 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts                   | 4 +++-
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts   | 1 -
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi           | 1 +
 7 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 0df54a7418247..693e7550bf955 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -612,6 +612,7 @@ sdhci0: mmc@fa10000 {
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x6>;
 		ti,otap-del-sel-hs200 = <0x7>;
+		status = "disabled";
 	};
 
 	sdhci1: mmc@fa00000 {
@@ -630,6 +631,7 @@ sdhci1: mmc@fa00000 {
 		ti,otap-del-sel-sdr104 = <0x6>;
 		ti,otap-del-sel-ddr50 = <0x9>;
 		ti,clkbuf-sel = <0x7>;
+		status = "disabled";
 	};
 
 	cpsw3g: ethernet@8000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 1c2c8f0daca9f..1dcbf1fe7fae4 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -200,6 +200,7 @@ flash@0 {
 };
 
 &sdhci0 {
+	status = "okay";
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index d0e1191baecd6..91d726ef7594a 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -478,17 +478,19 @@ eeprom@0 {
 	};
 };
 
+/* eMMC */
 &sdhci0 {
-	/* emmc */
+	status = "okay";
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
 
+/* SD/MMC */
 &sdhci1 {
-	/* SD/MMC */
 	bootph-all;
+	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	bus-width = <4>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 9175e96842d82..53b64e55413f9 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -264,6 +264,7 @@ &main_uart1 {
 };
 
 &sdhci1 {
+	status = "okay";
 	vmmc-supply = <&vcc_3v3_mmc>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index f29c8a9b59ba7..bffbd234f715a 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -439,6 +439,7 @@ &mcu_gpio0 {
 };
 
 &sdhci0 {
+	status = "okay";
 	vmmc-supply = <&wlan_en>;
 	bus-width = <4>;
 	non-removable;
@@ -458,9 +459,10 @@ wlcore: wlcore@2 {
 	};
 };
 
+/* SD/MMC */
 &sdhci1 {
-	/* SD/MMC */
 	bootph-all;
+	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	bus-width = <4>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index 04c15b64f0b77..76ff44e71ec17 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
@@ -420,7 +420,6 @@ &sdhci1 {
 	ti,driver-strength-ohm = <50>;
 	ti,fails-without-test-cd;
 	/* Enabled by overlay */
-	status = "disabled";
 };
 
 &tscadc0 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
index 6229849b5d968..65dbbff64ed96 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
@@ -207,6 +207,7 @@ partitions {
 };
 
 &sdhci0 {
+	status = "okay";
 	non-removable;
 	disable-wp;
 	no-sdio;
-- 
2.43.0


