Return-Path: <linux-kernel+bounces-113665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979FF888EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE93B35DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E6A1DD2C1;
	Sun, 24 Mar 2024 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuSPH9wG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269A0143861;
	Sun, 24 Mar 2024 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320619; cv=none; b=KPLETmsr6UzbgDMt8tnljm3r72TVNBlNba/T6mtsYtPAvNH866s5Lwcp+4MLRpYttgoSxY2mKCovt9w7sQYrHKJpZhl8INLk7hZSAtNeXgwPh1l/XPDVuJDLz9x4/sggCNawP3wfuS0Yhq+KaH5TJuZOreFbBDoyVuw09IeBqlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320619; c=relaxed/simple;
	bh=aMDo02VAK1zjVAZyROahyTo3LEtSa9UVeeqPFxBRTII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+bpIxcxUTO45b1vb6mpRfSVUySXNCpR8m2yawAlaFsRoGY3RmEhh9e9kkT5nFULrOGqTBqmFa1yf04s8lR0uv317xXweAdxupmQepQIOO+55o1E/xM/3YrsByrfOnBCfqILsOYv8lNSq8Gb2DXlGP19HVQJCXXd0Zn/iDppTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuSPH9wG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60607C433F1;
	Sun, 24 Mar 2024 22:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320619;
	bh=aMDo02VAK1zjVAZyROahyTo3LEtSa9UVeeqPFxBRTII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JuSPH9wGq1ioo/kItxiECVSiXBWf/dO0nzLCHTRSAjB6F0u6QcE8An7erD8GXv1QO
	 ofOTd8o68MpKg2xEVmlc7tVFsXC2vep0rKFuAPNpiQpl0nGjlbaZTzClKg0AxP1J3h
	 +i9FosGdpR88tD2JQeE01FcF/j41skylrLIGKqBOlG4FFieH2gyoH+l0gTGV7Yb+Re
	 PulLGWxK2KhoxJyFsuD2EVevUsl2JPTW9VTKvUkujME4kx/dNqvEwXVQ0SPe+fyoXd
	 msPIEwW2eR5aGT0YG9+GC9MWwydzoZL8SGZQsbsZtFaPzOLg0CM8XLaC/2P0FOTXvJ
	 Ohc5psiXINCrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 180/713] arm64: dts: imx8mm-kontron: Fix interrupt for RTC on OSM-S i.MX8MM module
Date: Sun, 24 Mar 2024 18:38:26 -0400
Message-ID: <20240324224720.1345309-181-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


