Return-Path: <linux-kernel+bounces-128229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C17F8957F3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1051C21D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915EB12CD82;
	Tue,  2 Apr 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDsvp13q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33212C526;
	Tue,  2 Apr 2024 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071002; cv=none; b=BkaZlchLpV8xK3xyHo+CShhyiXoA0sgMfkxDhWakiTIkP61Et39eK+rV4XKkBEeubXCpLxXdPQbPY62bKxtQGHGcbzln3qDhLi7utvaDRNqHWNtJTWp05U5w9meEXwe72LvvB+lNFZvGONsVivE4xYpDfgXpXLwKSLgYXnzFOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071002; c=relaxed/simple;
	bh=bGQKsjg01/1kGo3cS43aTtLbJmlbte8HsmSPUewqK4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dDT6uURC/SrxXBhDClkln/TTENT8OtWCD39GGsoj4BErxct/NURpYb6nddfQFZwuM6BEEnDfPEvuqLll0sszbK4I9IXk3zLvpherLNiXuDC90ybIctDj3vnEIuYNeLvwxMdaia12uqvpTj8eXzYvxcJig/5NM8xJwbtU4SHNO1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDsvp13q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345E2C433C7;
	Tue,  2 Apr 2024 15:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712071002;
	bh=bGQKsjg01/1kGo3cS43aTtLbJmlbte8HsmSPUewqK4c=;
	h=From:To:Cc:Subject:Date:From;
	b=aDsvp13qUtPGompTjj99ZDOgpeGCchKSuS4Kt3/8fcUrO4qBxru1iRdTO7Kej+mad
	 N5GXzmUfOfy1WVRvEwb99BGvX2gX6MIk/ZmCYxOKeY48gXMZCL8es4257wKeIzdCum
	 s1ClbqXQ0pItPSkDw41fgd3fb3hhoMfTArcamb+DoOttqMk/jsBGX8p0FPZo1490Ey
	 Q+3hOrzLtGevCfIJj6Fd3wRiOPtxv1AWl5Zme4QvUyyFwiT+HZz37lntZIaHMbP53/
	 MUUZERJYrevfk6f0Poxwh23JR//tO4uKj72Xk/jo8A2GzFTc+ABxVg3CCveIMHPlW0
	 6c0IsDuMUOp8A==
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
Subject: [PATCH] arm64: dts: ti: k3-j722s-evm: Enable eMMC support
Date: Tue,  2 Apr 2024 17:16:35 +0200
Message-Id: <20240402151635.3803406-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The J722S EVM has an on-board eMMC. Enable the SDHC interface for it.
There is no pinmuxing required because the interface has dedicated pins.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index cee3a8661d5e..d045dc7dde0c 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -369,6 +369,13 @@ partition@3fc0000 {
 
 };
 
+&sdhci0 {
+	status = "okay";
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+	bootph-all;
+};
+
 &sdhci1 {
 	/* SD/MMC */
 	vmmc-supply = <&vdd_mmc1>;
-- 
2.39.2


