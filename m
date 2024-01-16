Return-Path: <linux-kernel+bounces-28164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F88282FB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BFDB2602C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399682032B;
	Tue, 16 Jan 2024 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYpED/jP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692CC15F30A;
	Tue, 16 Jan 2024 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435321; cv=none; b=Yq4lsnAdCx0u5SlpHx6QvPFVHQxqLWWJxsRxDIiim7WZAElV14fmGqRtuajzXIJDZy+5tfFGP0NwUri2UXNuwoU8TmJlmuL7gnRF0NLTBiEWLNWM3YOVgDc1Fppb41jfLvrOS6zNLdWgFxXgL9HbQlq2Fix7KXQ5wBxOxi2MBL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435321; c=relaxed/simple;
	bh=xGuuo4e0bBzjdPZ6rVN40xTxTNcAU9zE1RcpMWgjRHQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=qQyjy/ggOmYP/0RhxAX3bzTqzepn8k+bkX/n4wTpltOA78RS7vHUKy12ILUWOuODZWsejNY4wEaSdh7mk4fOt14626cBhT2R14s7Rw1A3zkq8WuwlaK6TlTJFT4q/N65sPaAwC+g7pfpvWaSmzwxUAEUd71hE+kicTnlNypl3hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYpED/jP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3AEC433F1;
	Tue, 16 Jan 2024 20:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435321;
	bh=xGuuo4e0bBzjdPZ6rVN40xTxTNcAU9zE1RcpMWgjRHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYpED/jPjZgEgSga4RQ2iRruJaw3jTkknRoXUiI6+RZu44yZRRyeVpuLCzXNnzPIv
	 M9pB5XdVa+/+V+Nx10dVD+Iibjb6yngCGFnUnghuXGjzZhRRd1Y8BA6rQqanC6XfZV
	 oj+ZyeCoRQwgcvuTphJDntArFE4+C0+ZaB7/8YifGK/HscLt+mX8v0/VhdQPe9TmKQ
	 58tEu2cSyF5fUAY3dmCMfRUdg5gOW34EvsNqDNc0Goe5TVYBVaxNswb20UfmJYANcV
	 58CGWzRYIGENJFz+E4/8PMQHIgM7k7TL2FwA6gW6CVcbuL7yeBISuD73WWAvxt0j1m
	 8GphHJzM4E64w==
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
Subject: [PATCH AUTOSEL 5.10 28/44] ARM: dts: imx25/27: Pass timing0
Date: Tue, 16 Jan 2024 14:59:57 -0500
Message-ID: <20240116200044.258335-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts | 2 +-
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts | 2 +-
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts  | 2 +-
 arch/arm/boot/dts/imx25-pdk.dts                                 | 2 +-
 arch/arm/boot/dts/imx27-apf27dev.dts                            | 2 +-
 arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts          | 2 +-
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts                | 2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts                  | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
index 7d4301b22b90..1ed3fb7b9ce6 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -16,7 +16,7 @@ cmo_qvga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&qvga_timings>;
-			qvga_timings: 320x240 {
+			qvga_timings: timing0 {
 				clock-frequency = <6500000>;
 				hactive = <320>;
 				vactive = <240>;
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
index 80a7f96de4c6..64b2ffac463b 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
@@ -16,7 +16,7 @@ dvi_svga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&dvi_svga_timings>;
-			dvi_svga_timings: 800x600 {
+			dvi_svga_timings: timing0 {
 				clock-frequency = <40000000>;
 				hactive = <800>;
 				vactive = <600>;
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
index 24027a1fb46d..fb074bfdaa8d 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
@@ -16,7 +16,7 @@ dvi_vga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&dvi_vga_timings>;
-			dvi_vga_timings: 640x480 {
+			dvi_vga_timings: timing0 {
 				clock-frequency = <31250000>;
 				hactive = <640>;
 				vactive = <480>;
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index fb66884d8a2f..59b40d13a640 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -78,7 +78,7 @@ wvga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&wvga_timings>;
-			wvga_timings: 640x480 {
+			wvga_timings: timing0 {
 				hactive = <640>;
 				vactive = <480>;
 				hback-porch = <45>;
diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 6f1e8ce9e76e..68fcb5ce9a9e 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -16,7 +16,7 @@ display: display {
 		fsl,pcr = <0xfae80083>;	/* non-standard but required */
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 800x480 {
+			timing0: timing0 {
 				clock-frequency = <33000033>;
 				hactive = <800>;
 				vactive = <480>;
diff --git a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
index 9c3ec82ec7e5..50fa0bd4c8a1 100644
--- a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
+++ b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
@@ -16,7 +16,7 @@ display0: CMO-QVGA {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 320x240 {
+			timing0: timing0 {
 				clock-frequency = <6500000>;
 				hactive = <320>;
 				vactive = <240>;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
index 188639738dc3..7f36af150a25 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -19,7 +19,7 @@ display: display {
 		fsl,pcr = <0xf0c88080>;	/* non-standard but required */
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 640x480 {
+			timing0: timing0 {
 				hactive = <640>;
 				vactive = <480>;
 				hback-porch = <112>;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 344e77790152..d133b9f08b3a 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
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


