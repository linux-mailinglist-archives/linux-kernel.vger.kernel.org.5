Return-Path: <linux-kernel+bounces-27977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B37782F898
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2700F28CE70
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D6725576;
	Tue, 16 Jan 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx1l4nwY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08F3135A44;
	Tue, 16 Jan 2024 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434738; cv=none; b=JTG9BeCHbnlFmi9cRouboWvAYaA5Q1ET1dUI5N7PSKl0pGJLsGzFBV4FX3oxATgQSl4ibw7ldzx4yFTG8vp8JtJAOCqO934oEIV6l1/54NtgoT+PGdSLvRQid3dwitRT90txzB/n6AUuZx7nz08qXjzic0mY61vqj259+6rsBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434738; c=relaxed/simple;
	bh=PkJUZ51GVZfJP1VfxNoyBMED/5M1vBhzRXC3BJhZB9I=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=nwZFHadP2hGM0kN5eU3Okq1uM9w/L4cIooSuZ1EeaaetmAL2JKv6GJyq57/BtTBiBpZf09OW6nGknzkGWHpVkDuD/JLXo6YmSqUrUpnv8prJKu5uBflCLae0xfecJJmXstq6yPBvyT+y5kwX6RgOD4CSOUlDSE5PuwG7u/pwS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx1l4nwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CEEC43143;
	Tue, 16 Jan 2024 19:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434738;
	bh=PkJUZ51GVZfJP1VfxNoyBMED/5M1vBhzRXC3BJhZB9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hx1l4nwY3DzkRj+721weLX0Rioqu/hE06NYaIF+aaERHIctrcoXCnP2eJ4iFZg48F
	 ghF2W3ExUVlwirV99dhCHQADcifV+r4HJMu+lNVi8DjsXARzOpzR5xWGErcLBKCdt+
	 aDeZwB8u7W8SWf7gySqzmH16InPIw/QnP0g5W0EW3yiPU6J8aBv2AE1a58fD6QJ56N
	 z1VxWsYS5DHgzNIONQua294kvTzOgP3xAN8eGScvuEYb2yOrlTAUhgxW+5Y3lhNwQd
	 jAvNXmz1Y+Hz+3QqvVA3cG8ya6MvlYBDRMkPIn/HQiY8L1KdRzc1zCLnEftwOAJe4a
	 5TFFFAgrbsYow==
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
Subject: [PATCH AUTOSEL 6.6 066/104] ARM: dts: imx25: Fix the iim compatible string
Date: Tue, 16 Jan 2024 14:46:32 -0500
Message-ID: <20240116194908.253437-66-sashal@kernel.org>
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

[ Upstream commit f0b929f58719fc57a4926ab4fc972f185453d6a5 ]

Per imx-iim.yaml, the compatible string should only contain a single
entry.

Use it as "fsl,imx25-iim" to fix the following dt-schema warning:

imx25-karo-tx25.dtb: efuse@53ff0000: compatible: ['fsl,imx25-iim', 'fsl,imx27-iim'] is too long
	from schema $id: http://devicetree.org/schemas/nvmem/imx-iim.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx25.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx25.dtsi b/arch/arm/boot/dts/nxp/imx/imx25.dtsi
index 5f90d72b840b..5ac4549286bd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx25.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx25.dtsi
@@ -543,7 +543,7 @@ pwm1: pwm@53fe0000 {
 			};
 
 			iim: efuse@53ff0000 {
-				compatible = "fsl,imx25-iim", "fsl,imx27-iim";
+				compatible = "fsl,imx25-iim";
 				reg = <0x53ff0000 0x4000>;
 				interrupts = <19>;
 				clocks = <&clks 99>;
-- 
2.43.0


