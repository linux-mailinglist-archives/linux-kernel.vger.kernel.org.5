Return-Path: <linux-kernel+bounces-78828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC68C861969
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D10D1F253C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CF013A264;
	Fri, 23 Feb 2024 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yqoXhedy"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC75312D1F9;
	Fri, 23 Feb 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709130; cv=none; b=moor8x7zImsqylNh98MA03X7mjbvh3n0jWzqz6kpWCrtxO76Zkx98f38OCj5/vzYNsBaca81lpqZMVXKEyWPIJPI0R1ElzZDK9XSmm81hv+D2tmLEP+7asH9qHunXJKMTnORY0H/+l9hRjwy9GLwvnPmhDHH72iOzZXj+AyDJ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709130; c=relaxed/simple;
	bh=/hz/8AXXj+ZzSkJYQl0qnE60nI3MGQJXY6qlslTKKp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bT3yd/dBQS0D9xmhyyiAVUKn+YcWxhHiSi8kTPWL7fC42qH/oHwH3RvGeKFRr8cpiL0cQdf3z8JGIJY3R1rgrPz5DzbFA7jCV5pXjmpu/zeS4C06eC415BLybVffiG5GoOpAh0CUYa57Y7JPRRmaTYGz7Xe0udeQBxlrGCwctKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yqoXhedy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709113; x=1740245113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/hz/8AXXj+ZzSkJYQl0qnE60nI3MGQJXY6qlslTKKp0=;
  b=yqoXhedyeY9HQD5E3eqc/HXSflSy8Zpg6TyFpCXS01pBo7pTo/mcXHCC
   bg2VEEFoKfmX4/6l2P6wluV2cSoxe/J+q7GBATkFT4nroP5y3dU/PmQxS
   J7Y8AvMT4JDFV2mD2LpvqMMUZ9fo/gJsupQcvsHbHrbaN8rqdAQbkDZb/
   hvuUaCZkfXJAGhfPdBMBlV8eJYvUbFTYxir2u/4E+O/XYqVE7qnY6Ipn8
   nTislpP5fMj9hSD4MXUL0UMH4xOKJtKNwN7TNH11SxEDBmyL2fZlsSn6E
   uWVBpaRJ8yZAISjMOo4VPLgzBiTuPOEBenOO9nV2FP0zj1/e3Mmc22pSS
   A==;
X-CSE-ConnectionGUID: /5CNF92eR9i+Xpx5LCibjQ==
X-CSE-MsgGUID: xtED5/yRT4aDO/oItKs/JA==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="184009396"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:25:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:24:58 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:24:53 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<tudor.ambarus@linaro.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v4 05/39] dt-bindings: crypto: add sam9x7 in Atmel TDES
Date: Fri, 23 Feb 2024 22:54:45 +0530
Message-ID: <20240223172445.671783-1-varshini.rajendran@microchip.com>
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

Add DT bindings for atmel TDES.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Changes in v4:
- Updated Acked-by tag
---
 .../devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml  | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
index 3d6ed24b1b00..6a441f79efea 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
@@ -12,7 +12,11 @@ maintainers:
 
 properties:
   compatible:
-    const: atmel,at91sam9g46-tdes
+    oneOf:
+      - const: atmel,at91sam9g46-tdes
+      - items:
+          - const: microchip,sam9x7-tdes
+          - const: atmel,at91sam9g46-tdes
 
   reg:
     maxItems: 1
-- 
2.25.1


