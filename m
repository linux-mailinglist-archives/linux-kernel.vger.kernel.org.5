Return-Path: <linux-kernel+bounces-78863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4028B8619D9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547501C2547B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAD11420C1;
	Fri, 23 Feb 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="C0w9IwhP"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619F1420B3;
	Fri, 23 Feb 2024 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709363; cv=none; b=cVDoHJLMqEbNkaJYiKo5cGVnQQcV94OuXrwoWYJnYxw6E1HKCmuMj+KRg82ct/ZLWsBC4GhKN2sDWd7hlDroW3I3z1V2UMG9MclMrYsKh+AgNGkunvhnyuM4iT+g4+wZcARU7tbvGqyC4DOYbFLGR8mbdL8OGGqq1KgihzS/wdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709363; c=relaxed/simple;
	bh=032mMVSQqEKqmJWHEH/kd/ajYLY2Zrh+cOXnnpQqiKQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqZFrADTjl8M4Yq2h4vEngS7eqZ10RV3GcKOfwObV8k1UFZapdvBrL8rB0IYwbX20nU3kEIgXkgNtlKbkikdv48lyP1wUkvIyFMtdLd2TLFDRAepPGdMk3HDOQbbSJPwCltSPN2qrLeO8u+HZb9ap2DBzoISoMAMwn6exVoTr1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=C0w9IwhP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709362; x=1740245362;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=032mMVSQqEKqmJWHEH/kd/ajYLY2Zrh+cOXnnpQqiKQ=;
  b=C0w9IwhP1dEjGcfci+1ijL4HhXC3xCZVAi2cdQHmJ9U4yVJIVZ/wxITM
   nbyLSKTtuGdf5kXFOdL+aOJHbPAL/Wl/WDKXbquC/Qm7Z6W68IJds1EEN
   dtFMxFcAbqpCHMCyVEjBfdYUHjq+8LRCJ163pq0ElcgJNoxxNbgt26XSc
   qxt8307R+Ij2YDU1eT+4eBaE9OPQD3kXwu3iA9oSOkE0KT8CgwwcVlo8T
   W+t557TPFlxDRowQvA6C2sy4xNaKzrEPa1B3lyjWY6wMIOGdjbSUcdaO3
   tDk5AQyClKzEyFxCP1LuDPBLyR1/mZQ8sGhN+Vzc83A8ORP8dsHrYAAqW
   g==;
X-CSE-ConnectionGUID: UUhv/eVbQlm9nBTg2b0S7g==
X-CSE-MsgGUID: rc+ohozORYusiT9RdenFHA==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="16734688"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:29:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:29:19 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:29:14 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <tglx@linutronix.de>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<andre.przywara@arm.com>, <mani@kernel.org>, <shawnguo@kernel.org>,
	<durai.manickamkr@microchip.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 29/39] irqchip/atmel-aic5: Add support to get nirqs from DT for sam9x60 & sam9x7
Date: Fri, 23 Feb 2024 22:59:05 +0530
Message-ID: <20240223172905.673053-1-varshini.rajendran@microchip.com>
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

Add support to get number of IRQs from the respective DT node for sam9x60
and sam9x7 devices. Since only this factor differs between the two SoCs,
this patch adds support for the same. Adapt the sam9x60 dtsi
accordingly.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v4:
- Changed the implementation to fetch the NIRQs from DT as per the
  comment to avoid introducing a new compatible when this is the only
  difference between the SoCs related to this IP.
---
 arch/arm/boot/dts/microchip/sam9x60.dtsi |  1 +
 drivers/irqchip/irq-atmel-aic5.c         | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index 73d570a17269..e405f68c9f54 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -1201,6 +1201,7 @@ aic: interrupt-controller@fffff100 {
 				interrupt-controller;
 				reg = <0xfffff100 0x100>;
 				atmel,external-irqs = <31>;
+				microchip,nr-irqs = <50>;
 			};
 
 			dbgu: serial@fffff200 {
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 145535bd7560..5d96ad8860d3 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -398,11 +398,16 @@ static int __init sama5d4_aic5_of_init(struct device_node *node,
 }
 IRQCHIP_DECLARE(sama5d4_aic5, "atmel,sama5d4-aic", sama5d4_aic5_of_init);
 
-#define NR_SAM9X60_IRQS		50
-
 static int __init sam9x60_aic5_of_init(struct device_node *node,
 				       struct device_node *parent)
 {
-	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
+	int ret, nr_irqs;
+
+	ret = of_property_read_u32(node, "microchip,nr-irqs", &nr_irqs);
+	if (ret) {
+		pr_err("Not found microchip,nr-irqs property\n");
+		return ret;
+	}
+	return aic5_of_init(node, parent, nr_irqs);
 }
 IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);
-- 
2.25.1


