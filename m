Return-Path: <linux-kernel+bounces-28146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2764C82FACD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CB31F23AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC3415B2F9;
	Tue, 16 Jan 2024 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYPsQhj5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7D15B2E6;
	Tue, 16 Jan 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435272; cv=none; b=rOiVUnaKKQHZBZDP+Qt88LRc9Ij9R6adTm95YiAztQdMDwo1su5tMkpI+7YnWC6Q+z19+8T9SgFVL2wcg5uxZMU4u5Uz9Q6ApDZFw2LvN7M+fvU+XL60todEs7qWP3vvjPIS3A5nQTAW/jnZ0noNgHNNroxQeRHfoKtPx5DdlSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435272; c=relaxed/simple;
	bh=fGprZBy3+nxeed8ydxo3YYBwrhSwqEY2nnUHhL1DVcU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=YrduVxRJkvFA3IDW20BSlWWdInSHnkJF8jxW6maE/nQFX3stIf/k1XHgejWR+4hZm6yJVyXa+bMlZDEt+gjh5u5LMNxkgDux4dg32ru7VioRPrpqCNuS4FqEaLOr3rv/4ui2ISPKhSqzBIcytjdYCdnOyOEG4EnAeyAQPsqfhqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYPsQhj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68292C433F1;
	Tue, 16 Jan 2024 20:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435272;
	bh=fGprZBy3+nxeed8ydxo3YYBwrhSwqEY2nnUHhL1DVcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYPsQhj5OZ4luDzPUHcBNCd/a1aKj4b/d6QtIJtI9EMT23FE7E6Tm5HVCmEPPXwZ8
	 6T6KXBf1bjpznSvoHiIeySgK7+USnbBL6PXov34MEXn0p/1yeo0O+fPRTYDhdLNr7P
	 3MQKbV/yHRWKPPX8x44tYEq5QEdLs+hb6+xCFrSpnkfuuMONnpmKbsLtPsiVPxfxOd
	 6+4bCPB3qmzrbRefeTtiIUTlNW/6+N9KOgwezXwCN2Gb55Bom6tAqhSlRRAMc3NuXJ
	 Uvq2DWXxZhsiszrSVx3MrYeJdey6merf/tuUf62wbrQkKW+yx84t9kyOJAcnWktAmW
	 hH42X3PngKS2A==
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
Subject: [PATCH AUTOSEL 5.10 10/44] ARM: dts: imx7s: Fix lcdif compatible
Date: Tue, 16 Jan 2024 14:59:39 -0500
Message-ID: <20240116200044.258335-10-sashal@kernel.org>
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
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 622c60bd8b75..31ccf65d159b 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -773,7 +773,7 @@ csi_from_csi_mux: endpoint {
 			};
 
 			lcdif: lcdif@30730000 {
-				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
+				compatible = "fsl,imx7d-lcdif", "fsl,imx6sx-lcdif";
 				reg = <0x30730000 0x10000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
-- 
2.43.0


