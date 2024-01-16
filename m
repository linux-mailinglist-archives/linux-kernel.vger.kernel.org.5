Return-Path: <linux-kernel+bounces-27937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5327082F80B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDCEDB25901
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E5412C525;
	Tue, 16 Jan 2024 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bljfmkYg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6712BEB3;
	Tue, 16 Jan 2024 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434620; cv=none; b=W2kxRHxXwwnkobWmsrNMOiE0L4NW8D9JUKkVOsPzrvmZQ4A/24I0V1wv0GGKG/KxG0olU/YGzjeZNX3XgeoqYTKZyA6yKavt1P5rnGbF8omMaWwIgPzORgrPRSid85QNPMLWf2sxRR47W2OJrdoQIzCeOivs+Wh5RYvE9nAR2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434620; c=relaxed/simple;
	bh=bfO+CiieIBYSIJmESm0U3iZ47ri/BgqAhZvUsJT2bCk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=LrPAq6z7M0dxIv22EsyGIuaJkTGBIVSRfYf5AVx402+2v7lN27SqSVzvt18RFpr5YUTljbS3bOxQQSHU9eePCp8CxyzAxTXN/wnKLhPRLcKiCQ3fgKolL6T5rfEU12mVO5tn+pUm6scNvpE2E8J8yssiDGWuTb+9AiPpJMehm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bljfmkYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2EDC433F1;
	Tue, 16 Jan 2024 19:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434619;
	bh=bfO+CiieIBYSIJmESm0U3iZ47ri/BgqAhZvUsJT2bCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bljfmkYgBpQqyRyAq6x/m46qFKk9A58++CErBX8kyZOOACrU4+KDkAn0SK4WeEs4V
	 PdTC00/DnsnzBpwwxGp03XytfF8PdokkA1MBFXfz+FN9gElymvrFHm8PoNBF8jfAcP
	 W3zAH2f/PzeChufhifUKxIk4Ja771nqhJQpLIzW3tEfwMPAkzUNA8U399YD3fK3KfA
	 i3DAtyAi3yoMzLsfZSaMLwKmVDIRfTEp7A8hbS6pqObBES/RF7PZlTCZ8u/PeOhOtY
	 HKAe5KG6f+Vy5uW/Bl2yj61cLtS4g/b1tzT3LAcx/rMQRL9k+ouXgemIjKrmtQm+4y
	 oyvnftDtgMjVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 029/104] ARM: dts: imx7s: Fix lcdif compatible
Date: Tue, 16 Jan 2024 14:45:55 -0500
Message-ID: <20240116194908.253437-29-sashal@kernel.org>
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

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 5f55da4cc37051cda600ea870ce8cf29f1297715 ]

imx7d-lcdif is compatible to imx6sx-lcdif. MXSFB_V6 supports overlay
by using LCDC_AS_CTRL register. This registers used by overlay plane:
* LCDC_AS_CTRL
* LCDC_AS_BUF
* LCDC_AS_NEXT_BUF
are listed in i.MX7D RM as well.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index 2e3513b7111e..b6d03794d8d9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -818,7 +818,7 @@ csi_from_csi_mux: endpoint {
 			};
 
 			lcdif: lcdif@30730000 {
-				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
+				compatible = "fsl,imx7d-lcdif", "fsl,imx6sx-lcdif";
 				reg = <0x30730000 0x10000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
-- 
2.43.0


