Return-Path: <linux-kernel+bounces-114190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA6888900
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1EC1F24721
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450F424C320;
	Sun, 24 Mar 2024 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teiLZrff"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282D206CA4;
	Sun, 24 Mar 2024 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321514; cv=none; b=Ymvktw3x/C62j1xDRFKhHALb6YO6sNoyNXk3xiwXIhG8+VVyWfNS5ywh8ytUTPbDrG5DekVvKnSieZ6LKW5Fx2tyGPMHe9RUKbTOy04DwxLjHT437nylNGgON4zhdVMEX45naGJ46WcKnwWODvZYrETPlwuHBISyJQ54YMKu+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321514; c=relaxed/simple;
	bh=hwBbYoWGEEKSopLdY4x77EeEvapUEV0W9UCXR8bjLI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVlQFMGacgMMeVTvfjLdgMcAsHjlzkTneMOd2bXuzlq1qvZLh3KheA4BMMnEg6GbcX9ohOZncRkDxbbLc8/R7eNbUE4d3oSHPY4L2bzKidFgYGWY47mtPLaoXIbsMHDke1HWc1wH4JRkaCGFjZZc9ppUM0QZo/mWivDS7iKs2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teiLZrff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AD2C433C7;
	Sun, 24 Mar 2024 23:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321513;
	bh=hwBbYoWGEEKSopLdY4x77EeEvapUEV0W9UCXR8bjLI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=teiLZrfffInjRN3Me4iaq+liq6/qYUowyb3RVOp+6/ZBDQYHfHcAdSfJtkbk/tn1k
	 xGf7oO6JS6I+WKStcOt+oC4C89eF60c4CO0Bwo9bMxG4n1yuDqr/rfoc+vdY+2vrep
	 6O9kcrkh0x57TOqtEuajCxP3cyxzgruZgtV4xcWP4BuEkPsCoD+IIk19kEyTneC8C/
	 ExJLylM8DF2s9yoXlD1LpHxeMGuqVWwxhpkGq0b8bHzOWBPvII6Uz6fYLNXsm1eoIR
	 6QIkzLW3aHUMyFMaWvwkPskgLhBDTXzXsxSHwpm1KU4zu45eipbya2F4Kxim9f1rdi
	 gN1YhpDLJsoDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bhavya Kapoor <b-kapoor@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 239/638] arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in wkup_uart0
Date: Sun, 24 Mar 2024 18:54:36 -0400
Message-ID: <20240324230116.1348576-240-sashal@kernel.org>
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

From: Bhavya Kapoor <b-kapoor@ti.com>

[ Upstream commit d29a6cf980572d8cf7b63935716fca663e2610f0 ]

Only Tx and Rx Signal lines for wkup_uart0 are brought out on
the J784S4 EVM from SoC, but CTS and RTS signal lines are not
brought on the EVM. Thus, remove pinmux for CTS and RTS signal
lines for wkup_uart0 in J784S4.

Fixes: 6fa5d37a2f34 ("arm64: dts: ti: k3-j784s4-evm: Add mcu and wakeup uarts")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Link: https://lore.kernel.org/r/20240214105846.1096733-5-b-kapoor@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 5991c2e1d994c..39f99ee39dab9 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -296,8 +296,6 @@ &wkup_pmx2 {
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (L37) WKUP_GPIO0_6.WKUP_UART0_CTSn */
-			J721S2_WKUP_IOPAD(0x074, PIN_INPUT, 0) /* (L36) WKUP_GPIO0_7.WKUP_UART0_RTSn */
 			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (K35) WKUP_UART0_RXD */
 			J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (K34) WKUP_UART0_TXD */
 		>;
-- 
2.43.0


