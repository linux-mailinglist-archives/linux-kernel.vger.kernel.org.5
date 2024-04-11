Return-Path: <linux-kernel+bounces-139987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B817D8A09FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A092822E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C79C1448E7;
	Thu, 11 Apr 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PtK3Bi82"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842513F004;
	Thu, 11 Apr 2024 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820893; cv=none; b=t8Re7DU0kwMcJY+y0XuKsZRj4HNehadBDzt3C0zLbUYVgAgDwWvNxtbsQHveaQZoMbG2QgtwLDMl0UsyCZQO2RZcD/MiI+ixb94knxYzYKYD6+Xze+NNSA4ypdGxcggHRH83k3bS8TqIaux3xlwmPv2XcBhHwwc+r8L/ICi6mM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820893; c=relaxed/simple;
	bh=XZs6ZmQfTipHk+wXDzAHbcQXB2qepvg/C5tzIIpS1Q8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfJ11KJvOmENev/Q1kPEs1FxdN3Wr3aDcbi6jtjVhXvpTLFi5amCJILTvqlD7xYzG0e4ZmlA6c2pCbBfwOkIwnuN7Rdq9rNo2V7ZRi+2NH7qihw4wkkhJvXL4UvFhc9sc8InTEDqGYoosdt47Kw3OQrwmAIce0mU9djutdKrNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PtK3Bi82; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712820891; x=1744356891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XZs6ZmQfTipHk+wXDzAHbcQXB2qepvg/C5tzIIpS1Q8=;
  b=PtK3Bi82ufz1vJTq3NIyNVC6kuSmZecGsRS4GEwnSYNoVPeSAzBmWoVc
   l0qpMAad1uFgXVMu+KE5CxCNkD6dch3fr4I0anoq9svViC6e2M1xgeePD
   a466IAuWg0jEwQAeXd/Kvl6SuME7morR10MO9BVWB6fWpEHMCXBfhRqX3
   FVY65x5gnsWddHZ/P9rTJDAQ7jWLD/vFgZiSgDxcVwwX+2lZ7Rd4m7dRA
   ZibLhS29qBu2M2IwADL/4gGC2TiySrhwPuOQC+wcaLTa3RlTvtfcMK2nv
   SoSyop2j2wbIOD9lTt62BZ31N1hbXr/IBAPnA23Hf0kFvsv4Btg6TZOvF
   g==;
X-CSE-ConnectionGUID: dQ5jbtg2Q1GDLCjGLtSnbQ==
X-CSE-MsgGUID: 664Z6hcjT2ayWGagiGejGg==
X-IronPort-AV: E=Sophos;i="6.07,192,1708412400"; 
   d="scan'208";a="20534672"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 00:34:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 00:34:37 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 00:34:35 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 11/13] ARM: dts: microchip: sama5d3_xplained: Remove the empty line 377
Date: Thu, 11 Apr 2024 10:33:51 +0300
Message-ID: <20240411073353.3831-12-mihai.sain@microchip.com>
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

Remove the empty line 377 from gpio-keys node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts
index 820033727088..185f8cf84735 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts
@@ -374,7 +374,6 @@ vcc_mmc0_reg: fixedregulator_mmc0 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio>;
 
-- 
2.44.0


