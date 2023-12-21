Return-Path: <linux-kernel+bounces-8789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 421B681BC55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B46B213A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF185821B;
	Thu, 21 Dec 2023 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="uWToZ210"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B6D59913;
	Thu, 21 Dec 2023 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1703177282;
	bh=OUBsafXMgbKKwKeKHW98AeHHiie/LjHIzcQ1dOpPqmk=;
	h=From:To:CC:Subject:Date:From;
	b=uWToZ210+ervwTOs4Ip2PpJgyPW1ATQ/lckRtuORI2LreWnWqz5y8blQhBQjyhJYo
	 ru+ycX+P+48pwDQKGknznVNcHTnAV/74kYhXciLhaRZH/9ooD8P4T9I7JQ81fTKslo
	 Rc5EbEAwZCKd6tVjyGYHoWF3RkLeWt7wm/+I34ew0aP5HUy57++xj1C996/na0PnUg
	 6z+3DGjD3DkxJPsmxYTJNU8K8fonIBu4Z1vt2qtrOjqXNMnGsApzqXG781h09afQvm
	 hpDF9m3z4LN9CNTh7+TnxiTwCIgyO2vUFpH3c1gZHodttpgb5TjvfLn9kjCxcIcfb9
	 EoZU6V7q1o4qg==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <linux-arm-kernel@lists.infradead.org>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>, Fabio Estevam
	<festevam@denx.de>, NXP Linux Team <linux-imx@nxp.com>,
	<kernel@dh-electronics.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: imx6ull-dhcor: Remove 900MHz operating point
Date: Thu, 21 Dec 2023 17:46:33 +0100
Message-ID: <20231221164633.2029-1-cniedermaier@dh-electronics.com>
X-klartext: yes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Due to CPU lifetime consideration of the SoC manufacturer [1] and
the preferred area of operation in the industrial related
environment, set the maximum frequency for each DHCOM i.MX6ULL to
792MHz, as with the industrial type. This is done by removing the
operating point at 900MHz and set the clock-frequency to 792000000.

[1] https://www.nxp.com/docs/en/application-note/AN5337.pdf

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: kernel@dh-electronics.com
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-som.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-som.dtsi
index 45315adfaa86..75486e1b0c15 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-som.dtsi
@@ -28,10 +28,14 @@
 	/*
 	 * Due to the design as a solderable SOM, there are no capacitors
 	 * below the SoC, therefore higher voltages are required.
+	 * Due to CPU lifetime consideration of the SoC manufacturer and
+	 * the preferred area of operation in the industrial related
+	 * environment, set the maximum frequency for each DHCOM i.MX6ULL
+	 * to 792MHz, as with the industrial type.
 	 */
+	clock-frequency = <792000000>;
 	operating-points = <
 		/* kHz	uV */
-		900000	1275000
 		792000	1250000 /* Voltage increased */
 		528000	1175000
 		396000	1025000
@@ -39,7 +43,6 @@
 	>;
 	fsl,soc-operating-points = <
 		/* KHz	uV */
-		900000	1250000
 		792000	1250000 /* Voltage increased */
 		528000	1175000
 		396000	1175000
-- 
2.11.0


