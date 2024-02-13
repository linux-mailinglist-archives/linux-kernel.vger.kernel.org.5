Return-Path: <linux-kernel+bounces-63161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26423852BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CEC285952
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81DA1B5A0;
	Tue, 13 Feb 2024 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QqHCEJC5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503131B5B1;
	Tue, 13 Feb 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814603; cv=none; b=YTw6E7v1URcAJ2FmRHDlApBJpBUVs2A6Qqn8WK0y7T+VqsI6qbOGI0jb30EnSScSPSUKbD3eY3SYfF5pIN++ULdiLPQ0JBm7rhPeXQCOHLgCOW4OlQsJokGxAg1xXRMQAOUET1iW52y6KRxREkCglt789NhJYiCkEgb16yr1Rkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814603; c=relaxed/simple;
	bh=Z9T600NECZrWahsm619Mm8SqCKLiaWqAJuUPPk3JSEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8klCttTLPGbyYRRvUFc4LfWbpNBLedcgGYMyUmiKZBoVDff88Q2jCoY9cAQ0EQXx+sRCKNcH5Pv4bUU0uRiGW+KJcodYCkhVeNqLwz3kp5cVubLndAp5GfI5WKfBU2pTkQdZjJW4ZhJQMeyKc+Qq+HMLr8GjuiCaJek+CuSyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QqHCEJC5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707814601; x=1739350601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z9T600NECZrWahsm619Mm8SqCKLiaWqAJuUPPk3JSEE=;
  b=QqHCEJC5NbZUiaTgTord1c2c5mhj2ea2szFOCJiqrlfdiDZ5a1UiuQ1v
   Ec1HWKhQpFnnSEcSUHlE9XVnbTHZXqTkR8nM9B6So9VnaDz3BE5Qh02JX
   XmYFJDEU+quY6nx32QIjji1TruGnAohiMuJfBHwOpZbDEC0yK4+AmxDIa
   t3FIo4S3PmgIB58/8em7XFrCmkfscd/HaQwYbs4IvdweoKfbVSLUYxzwI
   BV5Pkf17E4l6UZpEzWNtZ1SHQxH0MtqLIAiYEwqTyNBTekBGJfNNsDiMg
   YKYXTViDct/oP3lJp6q4HSBZRhrx42zYVZhE1tFQltWaHskiQPKMylrcl
   w==;
X-CSE-ConnectionGUID: Tcx08rzESzahUneDj9mfvQ==
X-CSE-MsgGUID: h6M8831uRp6QpmqYoV/afw==
X-IronPort-AV: E=Sophos;i="6.06,156,1705388400"; 
   d="scan'208";a="183422417"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 01:56:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 01:56:26 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 01:56:23 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<andre.przywara@arm.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 1/3] dt-bindings: ARM: at91: Document Microchip SAMA7G54 Curiosity
Date: Tue, 13 Feb 2024 10:56:12 +0200
Message-ID: <20240213085614.26804-2-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213085614.26804-1-mihai.sain@microchip.com>
References: <20240213085614.26804-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Document device tree binding of the Microchip SAMA7G54 Curiosity board.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 89d75fbb1de4..82f37328cc69 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -179,6 +179,12 @@ properties:
           - const: microchip,sama7g5
           - const: microchip,sama7
 
+      - description: Microchip SAMA7G54 Curiosity Board
+        items:
+          - const: microchip,sama7g54-curiosity
+          - const: microchip,sama7g5
+          - const: microchip,sama7
+
       - description: Microchip LAN9662 Evaluation Boards.
         items:
           - enum:
-- 
2.43.0


