Return-Path: <linux-kernel+bounces-129528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1441B896C28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461671C26AA0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABFF136E01;
	Wed,  3 Apr 2024 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSxUD/Dh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66F259C;
	Wed,  3 Apr 2024 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139795; cv=none; b=OgGqTgdJMyXIaSjLbJLSCoi+1BkCGBkAvBe4sshJnxQoWR1cpz/R2ebN9SlnjhI+OJixWgV1xHIQqGMIomiaGhQ/gWCS7mX7ZRWwoob+FVUuo32AVwcQoqA3Ud3BcXTKUucaFEuv2jOc3rB+A6JT/BU0H1uYNigV6632tN3KuXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139795; c=relaxed/simple;
	bh=Viy3GgCDJ7qyHcGUPSF+AlvmzsQeSr8sZWdoICy0T70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OztoJornKvx776rugI4LjTqT2ZxZjl9Yb8kJylYtDoJo4mKl+xdv39HQubdcoBnCRLKEka5K8OdBpSIaql1dOZJSbu8qus6cScdsb5v69FV8JWBhDz+PJTsv5M/XVQrqGKIWsox8mpqxOE3MpfbeDD6s/EgnxKEIJTpfvFR8bIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSxUD/Dh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F101C433F1;
	Wed,  3 Apr 2024 10:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712139794;
	bh=Viy3GgCDJ7qyHcGUPSF+AlvmzsQeSr8sZWdoICy0T70=;
	h=From:To:Cc:Subject:Date:From;
	b=VSxUD/Dh6qLEqngMy6HZH96KdR19I0YFv/Y/ptrkzTDcPC3HdUSr769+VoL8FRVtN
	 EfdqEYOgmNNb87JEF8Gxe6EOOITteMo/ioPRnpm4uFTtgKty0u314KGRYOsfQsXQ6I
	 0TdXg5RK/Y4OfUzKwwAzndCIPWUM55T6yL9UIAHUxQNEybIkFhkSe1/9s2tnmfbxSa
	 3QFJnpuT22VoZHBsScnoW3XwcTfsBN1wVz2/JOTWV9nGzRv0yYUv6tHyYjTDyffaMw
	 G9Uohp0BLQ6c+OYYEvb1lr54pwRxaH5IMos9x03imWeDew/Z4UbZZa2123WXfCpc73
	 urbn36WsGuYsg==
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
Subject: [PATCH v2] arm64: dts: ti: k3-j722s-evm: Enable eMMC support
Date: Wed,  3 Apr 2024 12:23:02 +0200
Message-Id: <20240403102302.3934932-1-mwalle@kernel.org>
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
v2:
 - move status="okay" last
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index cee3a8661d5e..6b148da2bcdc 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -369,6 +369,13 @@ partition@3fc0000 {
 
 };
 
+&sdhci0 {
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+	bootph-all;
+	status = "okay";
+};
+
 &sdhci1 {
 	/* SD/MMC */
 	vmmc-supply = <&vdd_mmc1>;
-- 
2.39.2


