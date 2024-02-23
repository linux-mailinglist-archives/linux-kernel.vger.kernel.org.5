Return-Path: <linux-kernel+bounces-78842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D4586199E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4362852F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2781448C6;
	Fri, 23 Feb 2024 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ryi3R1uN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEDC143C62;
	Fri, 23 Feb 2024 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709157; cv=none; b=lahNm4+LgHUItm9SetHRCtLmp0Z990/DNhfc5xrYmOYqaTS4Kkj8M+nmb7ZEvuIB6mLjKlrBahaI6uMQZB7b1XAqZcMqEcwXhhKI5LyGBIpnN4hyTby4hVY4sRgstiuPIUPEZCKbTO37JMMxx2B9vNxDxKk7uNyS4ch0At3HuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709157; c=relaxed/simple;
	bh=1pa+nUeiMz0aVLSe9rutUmmIoy3zszoSlnt9C29TgLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PO9hmHkZA1ax6xEKaIqdNOxRL9A9rnfFwNVbNLYNzToV8v9JCoFd6ia/cnX1NFafp9RvKjAJxdelXYZMTjJO8GO2Aa/WNRFTdmlohdauDZ/idDy93A+PzC/QD3ez84p/xcicN3fcWXO4pKX4/fpzy+eFTJle+JSVGUQFJZVvn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ryi3R1uN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709155; x=1740245155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1pa+nUeiMz0aVLSe9rutUmmIoy3zszoSlnt9C29TgLk=;
  b=ryi3R1uNhxUfhSqPpHzb6NvvwTX5AwJLdGASi8UXGZBMGe+MJBymDUuU
   mY0/b+eCYcgjzmiFgchyXJXgzOTBKD791/v3K3tnouzFoLaF1GAXFaZRI
   BI4aKhBeMFnbu4LsoHdbfaIYKYYN+5yTpVsSmxzaSvnSC3V8xt83B/p7T
   ZSc60kQYRs3ykG+fOG9jcer/XmCNQx99qmDyosc7+Btd2QXQivzhLaQ9L
   SZ2CgrePWyQOUD18W73yoaEhGQN0I/i3aKLwSx9xxYdQewhsX2Kh/S5pX
   iBjpa0z65sYqvovsYwDxRcYWIAjzZW9yj5BKBj++AN80kda5hxKD8DOq7
   Q==;
X-CSE-ConnectionGUID: O0kOdwhCRya6tisT8ZRfCw==
X-CSE-MsgGUID: Bx/RauiIS1ukR8iK3Ocziw==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="16735824"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:25:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:25:51 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:25:46 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <olivia@selenic.com>, <herbert@gondor.apana.org.au>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 10/39] dt-bindings: rng: atmel,at91-trng: add sam9x7 TRNG
Date: Fri, 23 Feb 2024 22:55:40 +0530
Message-ID: <20240223172540.672044-1-varshini.rajendran@microchip.com>
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

Add compatbile for Microchip sam9x7 TRNG.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
- Updated Reviewed-by tag
---
 Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
index 3ce45456d867..b38f8252342e 100644
--- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
+++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
@@ -21,6 +21,10 @@ properties:
           - enum:
               - microchip,sama7g5-trng
           - const: atmel,at91sam9g45-trng
+      - items:
+          - enum:
+              - microchip,sam9x7-trng
+          - const: microchip,sam9x60-trng
 
   clocks:
     maxItems: 1
-- 
2.25.1


