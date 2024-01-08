Return-Path: <linux-kernel+bounces-19209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260EF8269D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B6528284D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E49013FF0;
	Mon,  8 Jan 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="jCZSvBCd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0CE125D3;
	Mon,  8 Jan 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E46DC00F3;
	Mon,  8 Jan 2024 09:51:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1704703885; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=IKeKgwpFsNj9YrDVbsZmnB9SqQh3ugfmHYM2RQIQqoo=;
	b=jCZSvBCdh5hgEt0vTTIxc3qjwTQDrB7dSySqS5pevTOIVeI+Xd592qrzMLrxdajbCoVkyi
	IDRujbuBlJKg6SmF29tEB3cvb4ug3hQhQp1WM2kwItwpLxK7VmdqIiCgmSsKNDBzDYOfzb
	R+AnC+cz2zkJUCz0rblakw4FHQ7XVxof+KQjIe7hK+TqsslVAIH99dqdhWA6iIkp2IaDn1
	h21H1fRhJl3FsnShVrlMl6qXw7SSwG4BYGSYqJdthulT0nUHA3hV/k87UYfL+6h/vBkv8E
	ceX0nnxEvHVd/gMX5BOPkGFtldbthSbdRXc9jVNRPFGjPMf5Bk3eWyDaMee4WA==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v4 10/12] arm64: dts: imx8mm-kontron: Remove useless trickle-diode-disable from RTC node
Date: Mon,  8 Jan 2024 09:49:07 +0100
Message-ID: <20240108084945.75356-11-frieder@fris.de>
In-Reply-To: <20240108084945.75356-1-frieder@fris.de>
References: <20240108084945.75356-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The RV3028 driver doesn't use this property. Remove it.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v3:
* none

Changes for v2:
* none
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 60abcb636cedf..b161b0c85d61e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -211,7 +211,6 @@ rv3028: rtc@52 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rtc>;
 		interrupts-extended = <&gpio4 1 IRQ_TYPE_LEVEL_LOW>;
-		trickle-diode-disable;
 	};
 };
 
-- 
2.43.0


