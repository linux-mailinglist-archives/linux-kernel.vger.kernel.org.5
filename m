Return-Path: <linux-kernel+bounces-79866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD0F8627CE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989D41C20FC2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC10552F70;
	Sat, 24 Feb 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJqBmAWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D84EB4A;
	Sat, 24 Feb 2024 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810395; cv=none; b=GOad8wGkmONz6kfbn2w1Dcsdwl14KYVGUn0ctu0aIN7W5w7B5Q49M71CpbhSSPKoc9qOdvj15ZMUXhiLbFkUouzuJAP83x9AiK37a7njG2hLfoH/NNBG3lZN+g5ABMQbmcBoUlHJ3ducPWynoFBU7oflwBsLTwL4HO+uy88QOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810395; c=relaxed/simple;
	bh=vtAZITKGgVXHTJ0/cBoLL4qU11MSmOF3yKsVn/EyOdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUka9QhYv1b76C/bgoKueA1NVCjyYWRt2CLK7c34y8WU0Wma7YKMRDCXtrjGmLxorvPAsimYxadZ7GuL0cjMkrz34ymsXvHz5AEkR2FqHJFgLIMtSwB4Eclv4d+w0dv1XWVHRLDbxRHbfgYNxLcagu8stPJua5TbRTqewqQxJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJqBmAWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860BDC4166A;
	Sat, 24 Feb 2024 21:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708810395;
	bh=vtAZITKGgVXHTJ0/cBoLL4qU11MSmOF3yKsVn/EyOdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJqBmAWrapxM2cfz/pKBJptZdGYYRaNf49wb9t4mfQMY3Zx5fAf5T1Qet0kfXnpio
	 ShYfW5UrBL3vQUezyDJF1RVQ3GRy3Lxtr/PevXKKdRYRhWCdhydake3+8sO3t3L84b
	 U5MWVDZt9Xammuf4oXgQDDQK3Kz3PSv20AEyw+yy65b7OfBoPEqBUQLe92mRFhdeiN
	 U6b4j0rSQfc9CHMgdpJr4Wd64EkCjytGF2RF1JYYtCKxpJ2M1+RX6RmQ/Tk7DuNF8g
	 eSakqUSQ5Vo9IDKit+w6ccqG1QBDAz5b70rvWxr3cIst5rgIM2rYY1WHzptXDRqtl9
	 166ggc+KHDVCw==
Received: by mercury (Postfix, from userid 1000)
	id 1940E1060E90; Sat, 24 Feb 2024 22:33:10 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 08/16] ARM: dts: imx6ull: fix pinctrl node name
Date: Sat, 24 Feb 2024 22:29:40 +0100
Message-ID: <20240224213240.1854709-9-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224213240.1854709-1-sre@kernel.org>
References: <20240224213240.1854709-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pinctrl node name must be either pinctrl or pinmux.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ull.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull.dtsi
index 2bccd45e9fc2..8a1776067ecc 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull.dtsi
@@ -75,7 +75,7 @@ rngb: rng@2284000 {
 				clocks = <&clks IMX6UL_CLK_DUMMY>;
 			};
 
-			iomuxc_snvs: iomuxc-snvs@2290000 {
+			iomuxc_snvs: pinctrl@2290000 {
 				compatible = "fsl,imx6ull-iomuxc-snvs";
 				reg = <0x02290000 0x4000>;
 			};
-- 
2.43.0


