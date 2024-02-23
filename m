Return-Path: <linux-kernel+bounces-78853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A78619C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27AA28823F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691F113EFEB;
	Fri, 23 Feb 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wXjmOKOT"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D40612BF0E;
	Fri, 23 Feb 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709268; cv=none; b=hXUT7WOb6Hz3R5sXOUgmqysQijCggo2cBXf7+gwoxlAYGS5AfFM0JnSTvlmPHkfFxOqUxDN/2pY1Om5Os+CLSu/OCe6EOQ4Rx4sAkM7JwHdE8V8KydwJG5yyqnxLCycfyOJpQwiK2OSgdbRlkab9CQQUdSZqVZuwRgEy0X77LNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709268; c=relaxed/simple;
	bh=fyoBnQeNxysyCAOKxGPQPZwk0/Da+nnXlqxeKUbLErw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N90+iZ2n+B1rLSEw7C79wQXnPKc+vGyPDLj+XKVfJXgscsFIr2fCFdRaeEjM410s8+IIjNfEm1TtsWV5hIbi+xALhOoFpCPBl9rWOTu4IBqZsgcNegGIpDwOB3vFdKfIdWx0TBL3xN8kafFGFCxyJ6GJmKpqkb6sum4yLWICj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wXjmOKOT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709267; x=1740245267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fyoBnQeNxysyCAOKxGPQPZwk0/Da+nnXlqxeKUbLErw=;
  b=wXjmOKOT7bzHntOtkDzythVDWVJvfTJHuCMJs2Lj90BXw5RnbHI/Z4EG
   1JCHb/sGqDp73LG/PxALWK/0UakSGyXfHQwijm+C1ZOICUnHvXVIjVDgf
   1LrdYV42KXocoCcvhPWt5O4278/iWXOeNYi1UPL6RfvcyoW6Z2JoCVAHq
   cnIrPaFeuR8V8fM8SmfbmlcPKUXGRW6av1eriEfzSN2RKVFvh9vJ5AsPr
   JA9j4LBS1hlvUECoFvAmuITcFAndkUbzkRyJRUil43Bd29FO+ubKIbhUy
   GRPvuSRqnhunZopEL/RE/O1XkRfVRxLWcRlRGLtm0IPU0zjufDUf9M4va
   w==;
X-CSE-ConnectionGUID: iZtwyvAnSDiGSjp9f2te9Q==
X-CSE-MsgGUID: SfAuet4QRmGYKgEasc5kNQ==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="184009568"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:27:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:27:40 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:27:36 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v4 21/39] dt-bindings: clk: at91: add sam9x7
Date: Fri, 23 Feb 2024 22:57:32 +0530
Message-ID: <20240223172732.672645-1-varshini.rajendran@microchip.com>
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

Add bindings for SAM9X7's slow clock controller.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v4:
- Added sam9x7 compatible as an enum with sama7g5 compatible as per the
  review comment
---
 .../devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
index 7be29877e6d2..ab81f0b55ad5 100644
--- a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
+++ b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
@@ -18,7 +18,9 @@ properties:
           - atmel,sama5d4-sckc
           - microchip,sam9x60-sckc
       - items:
-          - const: microchip,sama7g5-sckc
+          - enum:
+              - microchip,sama7g5-sckc
+              - microchip,sam9x7-sckc
           - const: microchip,sam9x60-sckc
 
   reg:
-- 
2.25.1


