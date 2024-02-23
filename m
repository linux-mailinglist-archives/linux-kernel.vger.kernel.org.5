Return-Path: <linux-kernel+bounces-78845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85C8619AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F66D1C2343F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC4D133991;
	Fri, 23 Feb 2024 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2C9F9l/s"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE712F5B5;
	Fri, 23 Feb 2024 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709174; cv=none; b=KE/kqRDwqZMTEv7I69wu2of8BGsSS60Pylc/qd9l1rHw58g2a6J8PobObiZfaeAKIfdKmT3FGVv4weiAnVKQDx1v40Fy1lX1+79SKK3f5906ncrYc69Zs2hSlEtVQLwjyA0wz8YZccKnxOz29e+2w9qrjyt9M5Y/7KXSphhU3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709174; c=relaxed/simple;
	bh=BZJTjqUHwuQlXlsd7x2WfXnXThGZTz45hMZUxsxzH20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hH5+ZjcTB5YAdxD+XhhsFKR/TD+2BARsuGJM7Bqr4HBjeGedg8qSvM+5GrsrxtUBYnbo4rAMzYb64Cqke7KFJUBa08P092I1iSm+UnMcqDJbU17x2rn5YxQziDnMAUaJVrkO+sZzY+UsDT6k0n9MYEowX5/aU09RsEZc7OPhwjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2C9F9l/s; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709172; x=1740245172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BZJTjqUHwuQlXlsd7x2WfXnXThGZTz45hMZUxsxzH20=;
  b=2C9F9l/sKx+IpXU2K7JoS5ggXsuZHhLsLYsugjmNCx85baycCgX8XKiQ
   vUKhIQLVHzceQGG1fbCBa2BgOsSFcFfK0qUL6rfyIA2i+TPP3+OI0Lg9C
   nemNzF312XF5Uo3Elh5z5cQG5Gd2/joER1Nx95Hjin+AJqsPAlJXzdwVi
   21iuW4H9toZihm3QWOTD6Sx8YGzIsr39vdoDy6GDOHpD/fJMDmZPe3rd6
   jgREmh05+NjVSdZ+D2kj35xSndZy/IlFWa0dwmtvaOQfMjcPtVNDSP5cY
   hMX5KcZQGxAMnQcpzALSYmiYVgTTHKk2zKAAHJkWwD+OEPy3LD/1sqO9a
   w==;
X-CSE-ConnectionGUID: Ely1r2TiR4Wv3Obixr7frw==
X-CSE-MsgGUID: M4vXw7loRkeKQ5VN/WOdcQ==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="16735843"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:26:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:26:08 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:26:02 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v4 12/39] dt-bindings: serial: atmel,at91-usart: add compatible for sam9x7.
Date: Fri, 23 Feb 2024 22:55:59 +0530
Message-ID: <20240223172559.672142-1-varshini.rajendran@microchip.com>
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

Add sam9x7 compatible to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v4:
- Fixed the wrong addition of compatible
- Added further compatibles that are possible correct (as per DT)
---
 .../devicetree/bindings/serial/atmel,at91-usart.yaml | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index 65cb2e5c5eee..30af537e8e81 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -23,11 +23,17 @@ properties:
           - const: atmel,at91sam9260-dbgu
           - const: atmel,at91sam9260-usart
       - items:
-          - const: microchip,sam9x60-usart
+          - enum:
+              - microchip,sam9x60-usart
+              - microchip,sam9x7-usart
           - const: atmel,at91sam9260-usart
       - items:
-          - const: microchip,sam9x60-dbgu
-          - const: microchip,sam9x60-usart
+          - enum:
+              - microchip,sam9x60-dbgu
+              - microchip,sam9x7-dbgu
+          - enum:
+              - microchip,sam9x60-usart
+              - microchip,sam9x7-usart
           - const: atmel,at91sam9260-dbgu
           - const: atmel,at91sam9260-usart
 
-- 
2.25.1


