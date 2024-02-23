Return-Path: <linux-kernel+bounces-78867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D58619E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DB81F26FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ABE143C45;
	Fri, 23 Feb 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="syyMWUX5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D461420B9;
	Fri, 23 Feb 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709427; cv=none; b=sPi6GT97PkDNWqUYannIcYWxIwGFgsYEqmdpHXj7DJOTF9qfrxf+Y29P7N1uQjg60DF5BgOoFw0gl2UivZ6nFG0w/QzlIfqyNfJ/k2WUHZXCRcbPFmlIkbVcSrnoIdMZhTkGjE5n5+pZljVWAxzcIKaBYFCTuybJRGWx89uDkiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709427; c=relaxed/simple;
	bh=Xx2zZ9i9EIHbEar9eU5E/skr6kuP4647DfkLBbEDqwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=II3189OXia9yYmiu22324IA0n1pQ+0aDcc/w0bebw6CQloCQeinPkfKhoYpk0NSzwAq/rDLeFF1vD7Ce3N+teJADa7Bo4ou67bwKa6GetEdgYdwdFNf3rLX1cXYjZmacg9nCjulLru7cpPeI5ZS84LZCcNPEgtDd0nnFghB9uuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=syyMWUX5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709426; x=1740245426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xx2zZ9i9EIHbEar9eU5E/skr6kuP4647DfkLBbEDqwM=;
  b=syyMWUX51eCR8k+I/moTPXBRNrJeoblqG5SUP6Etd4lYE2F+8v6ftbv8
   VbVjEeQFbq1Vwjws0+FMg0KAf38z6buix1EcqO8XbuqvrwADBpFM0ZBIo
   jiFN1hx8bgobNeCXAvRdNEWzq23pVV1wIm5vNqIfiSNhziLRSS50QlGCd
   cDQeoUozI9bx/0qIq/y0BWT13YH8J4o9i140BICm0PZ4umbFr3A1/bXiU
   Li0OcZIoc4b67t+UPR0nGbOYb5OsC348ab6n/1vzF1tsU1yD1r5gwb0z5
   0fnbokAlOCQu57uXHufTbsZ94WvM555xeuAxus0YcQRkaOujlfQomyRrL
   g==;
X-CSE-ConnectionGUID: QbP5QoTlTPilSlYKCz5csw==
X-CSE-MsgGUID: l142dJI0QKOIJtky/VH7FQ==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="17267453"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:30:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:30:22 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:30:18 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 33/39] dt-bindings: reset: atmel,at91sam9260-reset: add sam9x7
Date: Fri, 23 Feb 2024 23:00:15 +0530
Message-ID: <20240223173015.673281-1-varshini.rajendran@microchip.com>
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

Add documentation for SAM9X7 reset controller.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes in v4:
- Updated Acked-by and Reviewed-by tags.
---
 .../devicetree/bindings/reset/atmel,at91sam9260-reset.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
index 98465d26949e..c3b33bbc7319 100644
--- a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
@@ -26,6 +26,10 @@ properties:
       - items:
           - const: atmel,sama5d3-rstc
           - const: atmel,at91sam9g45-rstc
+      - items:
+          - enum:
+              - microchip,sam9x7-rstc
+          - const: microchip,sam9x60-rstc
 
   reg:
     minItems: 1
-- 
2.25.1


