Return-Path: <linux-kernel+bounces-128232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D198957FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CFA1C222B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4BD12CD96;
	Tue,  2 Apr 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkkeAzzv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B9D85283;
	Tue,  2 Apr 2024 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071093; cv=none; b=GeDq3Ei94br7nl1l+BLcrL7X6r3EwfrKi6Q9+pPYLaUK6QD3LYBcjQuSRb7I2L8gtkfPBL4ezU/oROUvbR7HIAiNXUUXTC6wujZm8tZ9JGwn82B5QmaB/pCmlGBzovilsiJ4F2g8Wuj4mVW1cV5VbR/vZ9Gy5ITO16eVhv4buc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071093; c=relaxed/simple;
	bh=uoXTVBYmsXH4CuxeXyMn5r530R+RfFIEalMgma3ikU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VEPhaiYuyV50W4CWuT//otKLrwt4v5uSNrPYbp/yyZhM2CHoRJiAWVcyAplropgcSyohD1MHuW+97INMxcjMfwmi9/yIGQOrnmZCtA4h+RYbAgMnDt9Tq1USaR9hiyu7eTWcqVVKHfWkK+QyFlath1QBWk/CmvcSNpKITayfw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkkeAzzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2430AC433C7;
	Tue,  2 Apr 2024 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712071093;
	bh=uoXTVBYmsXH4CuxeXyMn5r530R+RfFIEalMgma3ikU8=;
	h=From:To:Cc:Subject:Date:From;
	b=GkkeAzzvoitP4WU/zFxkWc//dpYnH6fshYUVURDOBdBCnTMcOViE3rLVb7qjfIftR
	 u05v8hsXMsKnKsgZ0uP3nlW7okuWUw7fLBIiI5a6kOWWc9bEQAb/yotcuOB5EIe4du
	 kHNqDT9Gofxy9ntVZyfrSbTqQlQK/q03jgv1xxP2lWlzXT55XU1nGWQOuj2MXBb1kB
	 Ga0l0d+yJbrxV6IU1CNDqRxv9Mz1/6ru+GPSchFSe8oCm1fK9s+GB+OEfVTI5EXdZe
	 ShA0e5NbnQg83H8sTg74Og8DWz+WU4oxYFbQ5W3/9FA5qjnc4Szr4DHPNXWSWH0ckr
	 cKA2qRVZ0zw/Q==
From: Michael Walle <mwalle@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-j722s: Disable ethernet ports by default
Date: Tue,  2 Apr 2024 17:18:02 +0200
Message-Id: <20240402151802.3803708-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device tree best practice is to disable any external interface in the
dtsi and just enable them if needed in the device tree. Thus, disable
both ethernet ports by default and just enable the one used by the EVM
in its device tree.

There is no functional change.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
This should also be true for all the other SoCs. But I don't wanted to
touch all the (older) device trees. j722s is pretty new, so there we
should get it right.
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 5 +----
 arch/arm64/boot/dts/ti/k3-j722s.dtsi    | 8 ++++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index d045dc7dde0c..afe7f68e6a4b 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -224,14 +224,11 @@ cpsw3g_phy0: ethernet-phy@0 {
 };
 
 &cpsw_port1 {
+	status = "okay";
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
 };
 
-&cpsw_port2 {
-	status = "disabled";
-};
-
 &main_gpio1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
index c75744edb143..d0451e6e7496 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -83,6 +83,14 @@ &inta_main_dmss {
 	ti,interrupt-ranges = <7 71 21>;
 };
 
+&cpsw_port1 {
+	status = "disabled";
+};
+
+&cpsw_port2 {
+	status = "disabled";
+};
+
 &oc_sram {
 	reg = <0x00 0x70000000 0x00 0x40000>;
 	ranges = <0x00 0x00 0x70000000 0x40000>;
-- 
2.39.2


