Return-Path: <linux-kernel+bounces-78857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC138619CA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C442882FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D44B14AD03;
	Fri, 23 Feb 2024 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="J9Yrq5UH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA571493B7;
	Fri, 23 Feb 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709289; cv=none; b=W3RY7/taMwuVLwbjMyIEzQCOkDlRb4LUtmwlmufxvjD4gDvrWIaZohmmHeaI7B87JtbF8p5+NhUXZFnoauAQJWQ6LUVL80N2+3wrV7dyxxKUuVQ0GM75/kMnUWRsbUUq991B1INZkPu+mUZagr+K88GhJf/zbBi16m6Qz1TMw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709289; c=relaxed/simple;
	bh=v/5m3gxNBQBjk0zVfGu5YA/YA0U+1V5LTugMoezBWKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8X78jYCiPCNnXgfspL4pgfshDIHMuUDqvQtPODG/6mSmh1+iV6AiQY95IxDmhh7a5dn6K2ym/4CAyaTwp70mghkAi5vkdAGCvNQVlC6zHe2Guc07mRgw/Ns4bEpzFTcEULpDXmSTTDL4/kddqZJcULHKV7l1KF/EnudD4IlxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=J9Yrq5UH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709287; x=1740245287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v/5m3gxNBQBjk0zVfGu5YA/YA0U+1V5LTugMoezBWKk=;
  b=J9Yrq5UHM6eo4FVcTDMrv/+OHaep76aBtDSJMpS1PAPa+ug6f9OjVDxN
   NSTJBoYdWqn3gDOSIwAAV0UwxzheLbQ0q5o7Pst10a6VaP8HB+KMQudN0
   Ua95YovUoxfnkJAmg8R5tM8i4vDEcawQSI9izcIQiVxf4ZJozUSzCBXN9
   +v4WT5lIlhDYrJUzWVzvEql3QFf+rI4K4vRA/5yfJ6G+9vxtX8GKtQTdg
   64bEXLEqtNqhCFXHlWDAbP7BgcjUcAe7PiDN8GcVfRPTrIFD2fJCuEvSK
   QSoIzYVWBSMhXmkj9FKLEku6i3soBLwHJ6liMiqy691d656bqWWyBFS3v
   w==;
X-CSE-ConnectionGUID: gJ/sK2wtS+eZoePf6d6/6g==
X-CSE-MsgGUID: R00U9T/jS7S9AbeocYJ/Mw==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="17267306"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:28:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:27:50 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:27:45 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v4 22/39] dt-bindings: clk: at91: add sam9x7 clock controller
Date: Fri, 23 Feb 2024 22:57:41 +0530
Message-ID: <20240223172741.672694-1-varshini.rajendran@microchip.com>
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

Add bindings for SAM9X7's pmc.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v4:
- Added the sam9x7 compatible in the allOf section
---
 .../devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
index c1bdcd9058ed..eb5cd33ea9aa 100644
--- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
+++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
@@ -43,6 +43,7 @@ properties:
               - atmel,sama5d4-pmc
               - microchip,sam9x60-pmc
               - microchip,sama7g5-pmc
+              - microchip,sam9x7-pmc
           - const: syscon
 
   reg:
@@ -89,6 +90,7 @@ allOf:
             enum:
               - microchip,sam9x60-pmc
               - microchip,sama7g5-pmc
+              - microchip,sam9x7-pmc
     then:
       properties:
         clocks:
-- 
2.25.1


