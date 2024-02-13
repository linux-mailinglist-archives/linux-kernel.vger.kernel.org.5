Return-Path: <linux-kernel+bounces-62844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F42D8526C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F57288144
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ACA6DD1D;
	Tue, 13 Feb 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgvLpeCz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3035B6997E;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786236; cv=none; b=mLsVet/I4fhzDUnqYPUys8RoSwaG+FlksBMko8R8L2GiYB92zZ255UgOsDaxxvFHztBP3Hh39RYQRkRMSOCMRiOPotfeidO7r2SJD/43nETj2x3IIK4RB9YEC/zHlR7f6FcPgiOn4hFXKXxRKj7/+A909LLlmEaSqcycD/TSLXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786236; c=relaxed/simple;
	bh=jWTFkWLAfHQn/N4QeNXzUQZEB7hyrlDD3WfPhQ90sdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbYkL7WQ7c5jpglEXPVK/shAfXYLnXy62YTsMrczTC27Dptn72izVIXtBt28yqzUBmQKDpfnaBF9OQbYIEgkOrooJkLHJPrHzOWMbY58HmgYZ9Fz7e5Y2SVYJ3cSXegpVZehVJRVicNs2m302j66f89p2hU9p5mfUj5zM70BWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgvLpeCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4237CC43394;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786235;
	bh=jWTFkWLAfHQn/N4QeNXzUQZEB7hyrlDD3WfPhQ90sdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgvLpeCzqKsE6VI7S+in61Gm29nyEnnezYxJW0JzWbXepPvE96Fdg0jBB52jToVp/
	 dRE7281w540zmhfR2/h5Mes4keP2ZVIKccV6cPzHXU4M2yUlAdjmQTePmZ5UNnMeq8
	 s7IUgN2O+v+tEACUW20YI2Pq8h0TtZC2hBzKH3H3ZVXkKYa+snqsXKQUOmjsex4FCV
	 sV1xapuez2rEHQNwUvs9WwUNbfZHob4r5H2clrZmqmh34YO2MCOG2FUg04S0Pr+7g3
	 7mYttahNCiEWEqQNa/FqZ2ZfyIDkMZcN2xeMcjpWJAlYqLn3m82t/cxdj66dMbfjuX
	 Jf7vdgf5Lt0Lw==
Received: by mercury (Postfix, from userid 1000)
	id 5E3B3106D639; Tue, 13 Feb 2024 02:03:49 +0100 (CET)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/17] ARM: dts: imx6ul: add missing #thermal-sensor-cells
Date: Tue, 13 Feb 2024 02:01:00 +0100
Message-ID: <20240213010347.1075251-12-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213010347.1075251-1-sre@kernel.org>
References: <20240213010347.1075251-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following warning found via CHECK_DTBS:

tempmon: '#thermal-sensor-cells' is a required property

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index 9eb4eee0c272..45b7605ac381 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -638,6 +638,7 @@ tempmon: tempmon {
 					nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
 					nvmem-cell-names = "calib", "temp_grade";
 					clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
+					#thermal-sensor-cells = <0>;
 				};
 			};
 
-- 
2.43.0


