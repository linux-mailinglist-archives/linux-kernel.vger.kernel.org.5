Return-Path: <linux-kernel+bounces-139980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC918A09ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFB9281645
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739C513EFED;
	Thu, 11 Apr 2024 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ah+kiWpH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA6813E3F1;
	Thu, 11 Apr 2024 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820890; cv=none; b=ac2yCQZ3YtxPH99HhZd811iDSXFW+cvgdPsPMmIniuGWbpSP7NzFAKH42PWGGcRLXeBuZQj5zhNwz68HDO/B76D2/JqcrJG0Fu/TYC8es3rDAkRhYSwEVWbbssEIv9AKqYQ8MZmN+BfwMujgMgGecqj9uqkRrIflECL38Sm3Vno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820890; c=relaxed/simple;
	bh=yGRk8yxnEHIXn4GRZR+fA8TIUE7jTplx8k/Gb8VPrEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDMSOR3r7VXWt1tABKGMBngEQPlhPZp8PRCuhR683subQA8Fs+DGFEiLIuGkXgKzEo8sNNzZLP4n3EMRHJM26Z07njq8DpovkRw/evjsS3hq8u7ia9p+8GTcSJS3VZb7oM6K3NGDfydcEbrBYTlWOnShs5UWszCSmqZcFaEE1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ah+kiWpH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712820888; x=1744356888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yGRk8yxnEHIXn4GRZR+fA8TIUE7jTplx8k/Gb8VPrEo=;
  b=ah+kiWpHO97rXLtQudT8ktJfyV1FzzbPNAHwAixNL1kCYjAJRtBNmSIM
   z3sJ7X0kLx6eyLZ3iNHt0WTA35MH5Fm/lqLX0IEKHJxTa+rC5hh865jIl
   LJlS4k3/2+yh4fyB31hAuOH3bkASz38BxKf5VUx8UIghxzaYpPHDkgQ13
   5Dk18J8b+mHc7Ol0sC4rcYFtBR1URBT4t8B6vmwA+W4HFZm8QL1jDmlMt
   z8s8HgYkYW41YbMGPbg1LzSR+XRSYeRYkK2mI2z1rWVPuzks7hHqnQfBP
   XPVejEq+kHL8WNLFeUDiKa6krI0DCdaWuvTZfrpwnh5tmJH0lboOnkp3s
   w==;
X-CSE-ConnectionGUID: jDRmTUiXRgK//h330KmRHg==
X-CSE-MsgGUID: +5SP6HKTSjGGqMpSm8ZPlg==
X-IronPort-AV: E=Sophos;i="6.07,192,1708412400"; 
   d="scan'208";a="21068908"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 00:34:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 00:34:14 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 00:34:12 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 02/13] ARM: dts: microchip: sama7g5: Remove the empty line 139
Date: Thu, 11 Apr 2024 10:33:42 +0300
Message-ID: <20240411073353.3831-3-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411073353.3831-1-mihai.sain@microchip.com>
References: <20240411073353.3831-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Remove the empty line 139 from regulator node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7g5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 75778be126a3..1b99181d05d4 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -136,7 +136,6 @@ usb_clk: usb_clk {
 
 	vddout25: fixed-regulator-vddout25 {
 		compatible = "regulator-fixed";
-
 		regulator-name = "VDDOUT25";
 		regulator-min-microvolt = <2500000>;
 		regulator-max-microvolt = <2500000>;
-- 
2.44.0


