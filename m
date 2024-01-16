Return-Path: <linux-kernel+bounces-27978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20F82F89D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43EFC1C2507F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169D45A783;
	Tue, 16 Jan 2024 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYbcU8nx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4AC135A75;
	Tue, 16 Jan 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434741; cv=none; b=gvy5NH6lp4ncR0BKszxj8ozP3NR3G7n1ViR7t+bBgLoZ9FxPIMGHa1+HnwlWhHv2WTpO8poejkdluf1zF33v4Iw24E453176RwlpODPhh2XxMe6KOOB+brJMOuOOHFDapFrJY8fttYmhwank/H6ADstAULkcxmG/y1EAfKfgJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434741; c=relaxed/simple;
	bh=5u2vTWPgKEBUq5c9vvYEj9YAW+41bi0fIPRi2W+aozk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=e7px+D3bbhursFm5XuyX8cFoLswnOswpyj9VOo9zW3DgwgnHcAAPgwYjxD2ulo6wald2EPypAPcELkI3wif7KlKYbPo0N9qajO6WmDK4aN6Qs6MTF/QCSel7qubUS86CAYWbImjyHVPb/vL468LUTvJ5HOj6Xifh+6sT8jPnWAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYbcU8nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A142C433F1;
	Tue, 16 Jan 2024 19:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434740;
	bh=5u2vTWPgKEBUq5c9vvYEj9YAW+41bi0fIPRi2W+aozk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYbcU8nxwDfUSDOdskJpoJI6p0ZWPzVcbIy+6HQG0Q2hmpZLZWxQudC3sqdjg8CNF
	 BtRIhKikMZocOyizhbS7KHyT+1V24SMylHohxE/87H5VLTpc+ANzsDmMsPrfzhqDLp
	 K1d9Wy796zqV4JT/CQQS6J3AL3IjeysZS0fn9Mq0cVmhhbKIWiuolnvfqQF/BWbhWk
	 tFWw307G9WVSdwodNBLp4IKDiThDqFFHtUmzYOAC3CxejsCtn7DGFuL+ZsGslYlE8r
	 Usm+6Nn+dRZyQzf08gBCs+dkt9oZBbSu/HLD9QIujBbTRwGXM+ZHCUTfVEk0VTt7B+
	 tkGZ8ApsVjqIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 067/104] ARM: dts: imx25/27: Pass timing0
Date: Tue, 16 Jan 2024 14:46:33 -0500
Message-ID: <20240116194908.253437-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 11ab7ad6f795ae23c398a4a5c56505d3dab27c4c ]

Per display-timings.yaml, the 'timing' pattern should be used to
describe the display timings.

Change it accordingly to fix the following dt-schema warning:

imx27-apf27dev.dtb: display-timings: '800x480' does not match any of the regexes: '^timing', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/panel/display-timings.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts   | 2 +-
 .../dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts   | 2 +-
 .../dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts    | 2 +-
 arch/arm/boot/dts/nxp/imx/imx25-pdk.dts                         | 2 +-
 arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts                    | 2 +-
 arch/arm/boot/dts/nxp/imx/imx27-eukrea-mbimxsd27-baseboard.dts  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-rdk.dts        | 2 +-
 arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dts          | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
index fc8a502fc957..6cddb2cc36fe 100644
--- a/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -16,7 +16,7 @@ cmo_qvga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&qvga_timings>;
-			qvga_timings: 320x240 {
+			qvga_timings: timing0 {
 				clock-frequency = <6500000>;
 				hactive = <320>;
 				vactive = <240>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
index 80a7f96de4c6..64b2ffac463b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
@@ -16,7 +16,7 @@ dvi_svga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&dvi_svga_timings>;
-			dvi_svga_timings: 800x600 {
+			dvi_svga_timings: timing0 {
 				clock-frequency = <40000000>;
 				hactive = <800>;
 				vactive = <600>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
index 24027a1fb46d..fb074bfdaa8d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
@@ -16,7 +16,7 @@ dvi_vga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&dvi_vga_timings>;
-			dvi_vga_timings: 640x480 {
+			dvi_vga_timings: timing0 {
 				clock-frequency = <31250000>;
 				hactive = <640>;
 				vactive = <480>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx25-pdk.dts b/arch/arm/boot/dts/nxp/imx/imx25-pdk.dts
index 04f4b127a172..e93bf3b7115f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx25-pdk.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx25-pdk.dts
@@ -68,7 +68,7 @@ wvga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&wvga_timings>;
-			wvga_timings: 640x480 {
+			wvga_timings: timing0 {
 				hactive = <640>;
 				vactive = <480>;
 				hback-porch = <45>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts b/arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts
index a21f1f7c24b8..f047a8487073 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts
@@ -16,7 +16,7 @@ display: display {
 		fsl,pcr = <0xfae80083>;	/* non-standard but required */
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 800x480 {
+			timing0: timing0 {
 				clock-frequency = <33000033>;
 				hactive = <800>;
 				vactive = <480>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx27-eukrea-mbimxsd27-baseboard.dts b/arch/arm/boot/dts/nxp/imx/imx27-eukrea-mbimxsd27-baseboard.dts
index 145e459625b3..d78793601306 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-eukrea-mbimxsd27-baseboard.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx27-eukrea-mbimxsd27-baseboard.dts
@@ -16,7 +16,7 @@ display0: CMO-QVGA {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 320x240 {
+			timing0: timing0 {
 				clock-frequency = <6500000>;
 				hactive = <320>;
 				vactive = <240>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-rdk.dts
index 25442eba21c1..27c93b9fe049 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-rdk.dts
@@ -19,7 +19,7 @@ display: display {
 		fsl,pcr = <0xf0c88080>;	/* non-standard but required */
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 640x480 {
+			timing0: timing0 {
 				hactive = <640>;
 				vactive = <480>;
 				hback-porch = <112>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dts
index 7f0cd4d3ec2d..67b235044b70 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dts
@@ -19,7 +19,7 @@ display0: LQ035Q7 {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 240x320 {
+			timing0: timing0 {
 				clock-frequency = <5500000>;
 				hactive = <240>;
 				vactive = <320>;
-- 
2.43.0


