Return-Path: <linux-kernel+bounces-78843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4AE8619A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86B01C23446
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFBC1448D7;
	Fri, 23 Feb 2024 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zZMJ2HuC"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C413A867;
	Fri, 23 Feb 2024 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709158; cv=none; b=VbF45MLiVFJG10iifuYdMTyf7nJDVrKnDVgpSIdi+lyb6vCQhoXNIFGOJ46veRiV6vhV8Sblvm2NvDT8rlq17he6dHwH5sI98Nq5YybXugtp2laVRB9C7HeR1/yIrJXCUIP3wX6Y2BGODwRton+KZXRjFYXuo6J+prJ74BblAog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709158; c=relaxed/simple;
	bh=g91B3meQdr4oVLlRU/qSl9oUcfHnjcbSkMBCurrIdyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/8BQ6R5DvZzKQVvil7IIeMPQWf6Mi0dTVwA+eJxCsWSUWLJuffoOHFo9BRJANaKpJ4fUmLah7rgjAeeY89CBihpEYN47VOlMnw+xabeGu5bS5SYaJFyVHaWuBWxWT3W4684/vNljDuoUiF+a07od6vqVYtwxaLZMFIV12zQRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zZMJ2HuC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709157; x=1740245157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g91B3meQdr4oVLlRU/qSl9oUcfHnjcbSkMBCurrIdyQ=;
  b=zZMJ2HuC1AQQASXst/7oYQn0ccrlHR4RQ8a7BUWq62cFnaCu6wnif2rj
   u/sUxhE6vlH24M3mYYLu6J1TOFDzR3XCtjYOJjAkoGl/vJKP+/v70Bo5b
   muWnjJtMcammzMrYNSeYn2AH6QH/zeBWnWi3xtkNzXwEBYpXD90+y1Zct
   81E5BnQY16d24g8oh6ZUcoRHMjLOyGJ519PrXWl7nfXYSRQZush3OVS4V
   327L/+t0eEWNpH0q6vnqIJeW3fNTYxIKhhWaywbcR7CDtQH2f7m4uAz0G
   4DuM6GV1RgfXroZ8iVa3EQKrJDuOlBaG1x8NGNykqOAXAK1DBxaaTsgXp
   Q==;
X-CSE-ConnectionGUID: yqAR4j5MT/u3WWYb46nLgA==
X-CSE-MsgGUID: RU5l/ePiSym6AdW8F3g4+w==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="247481346"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:25:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:25:39 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:25:35 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-gpio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 09/39] dt-bindings: pinctrl: at91: add sam9x7
Date: Fri, 23 Feb 2024 22:55:31 +0530
Message-ID: <20240223172531.671993-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223171342.669133-1-varshini.rajendran@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add device tree binding for SAM9X7 pin controller.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
- Updated Acked-by tag
---
 .../devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
index e8abbdad7b5d..0aa1a53012d6 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
@@ -20,6 +20,7 @@ such as pull-up, multi drive, etc.
 Required properties for iomux controller:
 - compatible: "atmel,at91rm9200-pinctrl" or "atmel,at91sam9x5-pinctrl"
 		or "atmel,sama5d3-pinctrl" or "microchip,sam9x60-pinctrl"
+		or "microchip,sam9x7-pinctrl", "microchip,sam9x60-pinctrl"
 - atmel,mux-mask: array of mask (periph per bank) to describe if a pin can be
   configured in this periph mode. All the periph and bank need to be describe.
 
@@ -120,6 +121,7 @@ Some requirements for using atmel,at91rm9200-pinctrl binding:
 For each bank the required properties are:
 - compatible: "atmel,at91sam9x5-gpio" or "atmel,at91rm9200-gpio" or
   "microchip,sam9x60-gpio"
+  or "microchip,sam9x7-gpio", "microchip,sam9x60-gpio", "atmel,at91rm9200-gpio"
 - reg: physical base address and length of the controller's registers
 - interrupts: interrupt outputs from the controller
 - interrupt-controller: marks the device node as an interrupt controller
-- 
2.25.1


