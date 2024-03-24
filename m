Return-Path: <linux-kernel+bounces-113002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D2E8880AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3111C212AC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535B712FF87;
	Sun, 24 Mar 2024 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR0vzom9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677C12FF67;
	Sun, 24 Mar 2024 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319813; cv=none; b=fhxMhgB02jB5T/1hz9TSu9kGaWbzM7rk63GwkbNc/8oSh4I/R47jj0S70+qVg2EO4UgLb9wTTaFA8dS2ZC0xd6s9NDb1Vpfu3WSIK2LylLxdhg2WAVG22tGCpnYgzAshEWQFzzl3vLzDAc4n8SjbCdRGRHdTJftjYscXI8m/0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319813; c=relaxed/simple;
	bh=aMDo02VAK1zjVAZyROahyTo3LEtSa9UVeeqPFxBRTII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXYPNlG9k1TCj0zMGaEz4G3ZacNVn63YpYZMgJljzB1DQWawLf0OVY0prJR+C2I1aCIU/PX5PmBFK6iL2gHncsMJapnGIrskmgG28Ozfza4uitECyA7UasINIu8uIVMYH/fsvnvemNjgucwnMPhc2b2y6XDsGTG4i5AloAwjjl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR0vzom9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A69C433F1;
	Sun, 24 Mar 2024 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319813;
	bh=aMDo02VAK1zjVAZyROahyTo3LEtSa9UVeeqPFxBRTII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YR0vzom9WDP22kPpO3Fxe7qNF3pn35rZzkvPCCn5d5u5rqcG40ZSNL2dkJjWWWCoC
	 yMartm17DF5KgLDUUBJaSGAD22wQ2g85ilMUZ2WwtqYF0Hfs09KVcB/IPVMPsQsnH/
	 ugjthsLKGRkp3x7MjXMF4GOhoxI7CmTNILiOBZTS6ZMeXFoYmJU25cAkFz3LH9Pllx
	 ZdCBwIjRnIeVqMp9H4rT5uCzslSZg78iLatdXGruPyJigXDy9cwucnTLdmHbRX7l0p
	 iXpiPiZmG2EUlq+t6h5LUKyPbF081eglMeIW1E/A4gYXh8MKfoqMbiTrxic16DyDHT
	 t2Rms7HxiRBkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 115/715] arm64: dts: imx8mm-kontron: Fix interrupt for RTC on OSM-S i.MX8MM module
Date: Sun, 24 Mar 2024 18:24:54 -0400
Message-ID: <20240324223455.1342824-116-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit 8d0f39b7d04d864e89b84063b124fd10aa4b8809 ]

The level of the interrupt signal is active low instead. Fix this.

Fixes: de9618e84f76 ("arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 3e7db968f7e64..60abcb636cedf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -210,7 +210,7 @@ rv3028: rtc@52 {
 		reg = <0x52>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rtc>;
-		interrupts-extended = <&gpio4 1 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts-extended = <&gpio4 1 IRQ_TYPE_LEVEL_LOW>;
 		trickle-diode-disable;
 	};
 };
-- 
2.43.0


