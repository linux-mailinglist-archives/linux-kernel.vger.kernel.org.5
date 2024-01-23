Return-Path: <linux-kernel+bounces-34905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 570A0838909
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F13428DA13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD9759B6E;
	Tue, 23 Jan 2024 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wjOCL1lb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A8258AB1;
	Tue, 23 Jan 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998776; cv=none; b=eqKy88k8eUQGH7xeEBQkxZWTKLjqEd6lNHXenVZXMZHDD546Nj/Mil94SiAD4Qm41H6UC6f9VjMr8uFONa7FcXfI25wUQh/mEnAXgs8hRt6bMwPkW3EOYZemYomPhXcgDs+KkGLrdGYs/4m5ttnCXqjNuoOj5cF+jseXC4rrHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998776; c=relaxed/simple;
	bh=aMjnesXHKBDV3aicngyOzqkOjqoV7cEBGGqpxTYP7IU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOBkVXxvYRROVbOVNk4n0aWVHzx/cFQs22Gc7B2eQ/dwZU7VuVAd7Y7Typ2Hw4n30jn0n4c/7BpTnlxUX4GxbqWnfvbCLNxhNbv9/93oR2nFw/LWa7chX1w04IyzbXMUdZOrr+hriPQC9BOf5m3iZUT3+ZIiQQkLVYeN02GjFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wjOCL1lb; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705998776; x=1737534776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aMjnesXHKBDV3aicngyOzqkOjqoV7cEBGGqpxTYP7IU=;
  b=wjOCL1lb8XytdDbUvdwKZhmdP+0pSqPdkRy6AvD98Pg84xAPUzx7Qa0e
   +SvvgBQMjIK+/jrhPQT/aqzb9R+xqVjznIxx3r0z3qYbtKP60P4BmAMdV
   o6uSRuXDQnob8Db0UkwGTsq7TPFl0YB7Pru7nYW7Hv6wn+qAToOHVTq7+
   eK3RI/rgsVKv/0Kwsf225hrpdp7WpPYziMxrIMEYMa0sDdnLZydh/gT4X
   NQQz6kEwfmARKOFaZy6FU/EFvNTIkgz0TR8YhFve8CR3A+LVCScpT0n+7
   44yj8AGRZV0tNlvyF/omebikYAu5ICNtc7Rcor2zvEZBUdOvOmlrm+ncs
   w==;
X-CSE-ConnectionGUID: 8Z0MiRbqTTiGlgq+aKWHzg==
X-CSE-MsgGUID: kWCxMrVVQxKhkGpnlkJECQ==
X-IronPort-AV: E=Sophos;i="6.05,213,1701154800"; 
   d="scan'208";a="15154467"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 01:32:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:32:41 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 01:32:39 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 7/8] ARM: dts: microchip: sama5d2_icp: Add power-supply property for sdmmc0 node
Date: Tue, 23 Jan 2024 10:31:57 +0200
Message-ID: <20240123083158.7339-8-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123083158.7339-1-mihai.sain@microchip.com>
References: <20240123083158.7339-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The sdmmc0 controller is powered from 3.3V regulator.
Add vmmc-supply and vqmmc-supply properties to sdmmc0 node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
index 999adeca6f33..adcb3240e5f5 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
@@ -712,6 +712,8 @@ &sdmmc0 {
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
+	vmmc-supply = <&vdd_io_reg>;	// 3.3V
+	vqmmc-supply = <&vdd_io_reg>;	// 3.3V
 	status = "okay";
 };
 
-- 
2.43.0


