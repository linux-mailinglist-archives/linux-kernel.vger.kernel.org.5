Return-Path: <linux-kernel+bounces-78868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9808619E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078311F26815
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5381448C3;
	Fri, 23 Feb 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wujqctl4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C012D77A;
	Fri, 23 Feb 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709441; cv=none; b=dH1K3vM+JsUJr/VabW7TmnKNJ7CXJhl7+W7tjbQmoXWEmOOXPzehHo/46Maefw307HE1vgpURVU6TVgmYGeWhbO2NKYDRuacYg1i7UuXnMIqAkjmYLcPL1/iDKK5XTl650Me+i/L5OaV5fPAK8HbqjHagWuvKHPwmKnqmzcThRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709441; c=relaxed/simple;
	bh=cYlBxp5NBE+Wc9M1WxlfVZ7eP5k9B5chPb5kAuyh3Jw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRZy90D9CZTKRmaZnSIWURQ5beMo+vFKcsFqJs6x1+XiCM7bxqkeSVmjFdhgPscoDQ3NFL1vQTU6bUaIdlwcoDwcVobRodvUw1zquFEvfnyyNk0UZ6Mw/tL3yu8luPegVKfuMgsNuT+EVGg/pFayXnt1iEePX3VkpWC/ukdB3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wujqctl4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709440; x=1740245440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cYlBxp5NBE+Wc9M1WxlfVZ7eP5k9B5chPb5kAuyh3Jw=;
  b=wujqctl4vpWtSJxoOTElla16lhYfwV6A1GFM6se1eIqVbr8WiST1X9nD
   n5OZNAgmnqsiWRj5x6Ju10fai+CpI702VLpfB9ZHbzazamM4Jk9qFrssZ
   HN9cDNSUWYaDYsY0+i3SMEdOw4jAt3tiC0APygqMLlduJ8cVg9gpVvfUj
   bJ06cA7gLtTid+LwtpXPMk+p7YgRkCPoJ0usXh7pmpqQXgcGJV7qBhZUo
   cvHJOymSfOdH2hjsW+Ogkp4qtAcKxTpBMe12eF3kaDTt3E01r0kFknGUP
   hD1/c367ext5TPNWO/jTh/DGIF8Ks19uw2a84/Yl5yZrLMGNZyaD0DZU3
   g==;
X-CSE-ConnectionGUID: WsimkxkcQRiUq4IidYZ/ag==
X-CSE-MsgGUID: h1jsnocJSfSFWYgiuCMAJA==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="16734771"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:30:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:30:34 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:30:29 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: [PATCH v4 34/39] dt-bindings: power: reset: atmel,sama5d2-shdwc: add sam9x7
Date: Fri, 23 Feb 2024 23:00:23 +0530
Message-ID: <20240223173023.673336-1-varshini.rajendran@microchip.com>
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

Add shutdown controller DT bindings.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Changes in v4:
- Updated Acked-by and Reviewed-by tags
---
 .../devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
index 8c58e12cdb60..0735ceb7c103 100644
--- a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
+++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
@@ -22,6 +22,9 @@ properties:
       - enum:
           - atmel,sama5d2-shdwc
           - microchip,sam9x60-shdwc
+      - items:
+          - const: microchip,sam9x7-shdwc
+          - const: microchip,sam9x60-shdwc
 
   reg:
     maxItems: 1
-- 
2.25.1


