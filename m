Return-Path: <linux-kernel+bounces-78862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A91F8619D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D946028394A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF57141989;
	Fri, 23 Feb 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jQxjzLSp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0702812DD85;
	Fri, 23 Feb 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709355; cv=none; b=Ljwm4DS05TtuC4CmNXIA0vIANeFPZXDRtDYCtleARhagIuo7Ut3FBTu0NH3r//NPyafPjMfHIxrEmq5ApvQWkSfnXSVmNBdMRxWmOg7YQLhjx3n+gFr2l9Dm/+sIRFGAM42zXh4VrSjycE2GZD76Ra5f2+rtFT+4tYXfPcKvapU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709355; c=relaxed/simple;
	bh=u6JeeHT9oRTlHnIjB/tPWNs3cODCuJ8lE0PAWT8DiHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etAfjsCU5DFl242lCovFBjRYD5jqEygRuun1X8PAFPRJ7z/bhThgbJDr9jtdo6mgcpwiIIZFKICyCGpk0vV36v7bNPcBnFhyxrtUzu6RTCBNRPviqCzbR7wHTwTqB6UuelwJ1Le6qz9MWHqQYKnDdeAp3sAZBuB2fEuS9DhtnUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jQxjzLSp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709353; x=1740245353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u6JeeHT9oRTlHnIjB/tPWNs3cODCuJ8lE0PAWT8DiHA=;
  b=jQxjzLSpg3FeTEzHdxy8K/gWQmZSwZl3kcyZN/yA2wOU8YuYilwgB8FE
   My1GQNSgiPkqxNkonS26r9S/wJfFF92O+SgdkssZLREsyeS+Gq9Vzps0J
   TsQ+HIrI7nzEc2OOxDcUmE6rpuV762upKuIeftf95JaaiaBRdSU727v0L
   tGdfGnyvk+k+VV0R2SEBKbscEIz9awB3pyBD7FybdoAuClLVwJX867eqo
   u/dJTgM1qMwnUjVHlqAf7fM6ahivPgswhQMntPXUrKPF9/RKKosnxli7T
   aUc5n3A8EUItBFB+/DxDBcKYVGNCx1VdkqdkVLRpOy+bE4zn1rGscba0L
   g==;
X-CSE-ConnectionGUID: nX+aFf6zR2a6Qs8N2xdKug==
X-CSE-MsgGUID: qzh6xr4eSEq0O3yKtlB6dQ==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="18276347"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:29:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:29:04 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:29:00 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <tglx@linutronix.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 28/39] dt-bindings: irqchip/atmel-aic5: Add support for sam9x7 aic
Date: Fri, 23 Feb 2024 22:58:55 +0530
Message-ID: <20240223172855.673003-1-varshini.rajendran@microchip.com>
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

Document the support added for the Advanced interrupt controller(AIC)
chip in the sam9x7 SoC family.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
- Updated Acked-by tag.
---
 .../devicetree/bindings/interrupt-controller/atmel,aic.txt      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
index 7079d44bf3ba..5fb9366c94a1 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
@@ -4,7 +4,7 @@ Required properties:
 - compatible: Should be:
     - "atmel,<chip>-aic" where  <chip> can be "at91rm9200", "sama5d2",
       "sama5d3" or "sama5d4"
-    - "microchip,<chip>-aic" where <chip> can be "sam9x60"
+    - "microchip,<chip>-aic" where <chip> can be "sam9x60" or "sam9x7"
 
 - interrupt-controller: Identifies the node as an interrupt controller.
 - #interrupt-cells: The number of cells to define the interrupts. It should be 3.
-- 
2.25.1


