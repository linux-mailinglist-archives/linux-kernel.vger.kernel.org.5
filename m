Return-Path: <linux-kernel+bounces-28098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE8382FA37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA2C5B27270
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7382629EC;
	Tue, 16 Jan 2024 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmRFt+OV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CAD1509B4;
	Tue, 16 Jan 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435142; cv=none; b=naClWBnx3bEbT2jDGt6SQD+6DuYtTdBgOwKnxdDcnVXl73/CvnfZqp71htuuRZHPs/wr/UNI/774TWDFqKndsVY5P1YrE3PKwMPszNdmzIh2jqPZo99i458GBm8LeS3jn6R6k7eqR/ylvgHbu7wp2MR5Ya+NvlFd1tgFsJOscf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435142; c=relaxed/simple;
	bh=FRYK+CaRjonrlyJKFoR7We7FOsOcohxD79wXKx8VLYY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=AOW39R3iGW+xG/8IhTpJRB1CzxZ7TwzxC8u1HswnULZsdt/k7cgL01pY8MSe0Uc4TKHcq0x9NbsOUrZxxMl8Ef4YaMktgCgXeOh5YQ1MaDPKHL+Tx0nz04c1XV25EbpgNNvPB5R4aJQUoVyiPM5fd+zvjy4dWCaQGcBmFCSDpLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmRFt+OV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7243C43394;
	Tue, 16 Jan 2024 19:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435140;
	bh=FRYK+CaRjonrlyJKFoR7We7FOsOcohxD79wXKx8VLYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MmRFt+OVKN1DI3fiac5RUlNEJdDul358OAcHdRaswiYDkbs1VltMs7O+fyLnOzRzK
	 pwqSFb+qiJflYllFCNVZ2308Pg3yKkbmYiEnp3A74CYkG3+7zU3FnUmcyuUishNf69
	 SgTQaEafqyUgvThwDHB9aUrG+LrUgefAD9HElF+0WKlqLhU+Ddk+GL+qiGO1lAJt8t
	 +2OqqZHJesLWmGA7RP6p0ZAwcMigj3N5xOqiVfSuYLkrskGzSAYGJztuSrp5v42niK
	 vT+Ll9P1Qd3FZxPhNFaRWzFgziinPaUBSZg51HRlw7IuE/msY/Rm0c34HGY2uhqup9
	 o6Sie6A3mozng==
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
Subject: [PATCH AUTOSEL 5.15 11/47] ARM: dts: imx7s: Fix lcdif compatible
Date: Tue, 16 Jan 2024 14:57:14 -0500
Message-ID: <20240116195834.257313-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index 6cdaaacd9e36..35ee179e5ae3 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -802,7 +802,7 @@ csi_from_csi_mux: endpoint {
 			};
 
 			lcdif: lcdif@30730000 {
-				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
+				compatible = "fsl,imx7d-lcdif", "fsl,imx6sx-lcdif";
 				reg = <0x30730000 0x10000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
-- 
2.43.0


