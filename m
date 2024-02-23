Return-Path: <linux-kernel+bounces-78844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE4F8619A6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D59287D39
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F3134CE5;
	Fri, 23 Feb 2024 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GU46yDfo"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB651339B6;
	Fri, 23 Feb 2024 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709172; cv=none; b=tpdiTPh7f1X5YqrWZDEkorhYQ0XqQ6OQvIpZFE5xGutFM6UG1toXPZeovjArAm/AdfcvGH4o19Nhk2B68i6pI5raP5VUHIkVgTEyUFnVck0Agis8/tBncG0bjYlcUJXZOqE5mMh6pin26VqPsvrNPa7cCcoSgwNtGey+JhnEWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709172; c=relaxed/simple;
	bh=kk/UiHsga5gmFS3zENAHY1LBewwoUNLNuFmDepPq+yA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mM0lXo6IDmrGZHkGpy5wOyzLzRqJQW4O51PKG0p/z7weJblVqZaEvcoejA48GUJEKXnOJKP8XP12WZBLrT+WdlO6KIbSV9aFxijhKmlGL/IotfOvvcRzs3hVRwUzIpxgxydVT+O4pD/Rg0zjQ3672BWQNkpdnakV1hqeNTDbZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GU46yDfo; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709171; x=1740245171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kk/UiHsga5gmFS3zENAHY1LBewwoUNLNuFmDepPq+yA=;
  b=GU46yDfoPS3ajRwVdtMZwnOHdK3gYg+k3Nm8yehRpHOKqAXjtVKEbC8b
   Sd+pTP565rAzmV0rB75xaE1GONdis/5xX/DpPOJgQM4KBK51xqwVoBBqF
   f+IQpmhJ/vlmapk0G7h8j2vvcOg7XardxFJJS7W1cUbJWzg9/6JneQSH0
   V+ehvT58eu7Kk3OCozX9HrBApDfgu1Etm6T73yKG4W9EMpPll725yHCW0
   WIllOmdeZs2KoJwrgo4DA2Y1sNs+x+Mk/kGemQe4lIw5+Zk6kF5FHtSeo
   YBZuHdfFAIFW+QLeH3K/1cQBQoQ8qo2uYh7iDQ8Pq6XLd3ix9cRYGoVzp
   w==;
X-CSE-ConnectionGUID: Ely1r2TiR4Wv3Obixr7frw==
X-CSE-MsgGUID: VI9R6XZzTteN3DbNWpHX6w==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="16735838"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:26:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:25:19 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:25:15 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 07/39] dt-bindings: atmel-ssc: add microchip,sam9x7-ssc
Date: Fri, 23 Feb 2024 22:55:09 +0530
Message-ID: <20240223172509.671880-1-varshini.rajendran@microchip.com>
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

Add microchip,sam9x7-ssc to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
- Updated Acked-by tag
---
 Documentation/devicetree/bindings/misc/atmel-ssc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
index f9fb412642fe..894875826de9 100644
--- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
+++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible: "atmel,at91rm9200-ssc" or "atmel,at91sam9g45-ssc"
+	       or "microchip,sam9x7-ssc", "atmel,at91sam9g45-ssc"
 	- atmel,at91rm9200-ssc: support pdc transfer
 	- atmel,at91sam9g45-ssc: support dma transfer
 - reg: Should contain SSC registers location and length
-- 
2.25.1


