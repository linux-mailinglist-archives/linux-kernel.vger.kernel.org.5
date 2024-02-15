Return-Path: <linux-kernel+bounces-66506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEDB855D99
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D241C21FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F0E171CE;
	Thu, 15 Feb 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cDVBzCIz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8AD13FF6;
	Thu, 15 Feb 2024 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988563; cv=none; b=JjJdtGnDlwwMstOKWm+qyhOfmjxcOBVE7cVTK9MuTIAgffyjfBYfK+ojatAO3dW/nj3TSlDjj4AofFXXzyFw0BJFXw2xBg5Iu7b0SXDYvPSlH/S/BLFBrbLzs4QLSUh5lIAOZVnJuQbVd05BXy8/6C+j7uZxIWqQNwQlAQwz6DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988563; c=relaxed/simple;
	bh=0AumbT9VD7jrQpuV2WNJF2ZTS/F/XT/yJPrnJl5acKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahF6TSP3R1wLAs0FkjvHaGuZAO1gniJx9DfFHrU0q89i2d02iZPn49o0i/28kxWdgaS1XfeDpJhgJlKlDG59bWadELs1oWmhZ3kiFTPX/M1apjK8hSP6/3BENG4lnLD+gLk9xRfqRd/HEE6nQtQfL9W5P1d/nR+W61HjBg5XukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cDVBzCIz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707988560; x=1739524560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0AumbT9VD7jrQpuV2WNJF2ZTS/F/XT/yJPrnJl5acKE=;
  b=cDVBzCIz68KlXxU10koFaNSs3wYjZFt7JKIKmOYEaKw6HeKrHtONkAbY
   KAvQ3lQgHIxUfmfEqDER7h2TO07cKw00F3X0ONgSo1M1UsZ6tyQS5YFyX
   ZXgdZGeIdRF6aYn7clj2Vao7D0oS3ZqDQ46Z22+0MncBhm3bByHOIj0Z9
   f5gdCFpOQMICqueCYdfaUvPZ+w8GYJpgocDW9V+nf/FmahmDr+IKUsiLL
   v44mx45LokGvhDdKt13unZQXBztyQNSR0J9tTFeqYcH/rUuEP1feMM3o3
   dwQko1+OSIGnSeCAS5HLwlHdy6l6TCeOZQfDjBrBNi1VmvqhfLPp56Djf
   Q==;
X-CSE-ConnectionGUID: KRer2CuFQguroFb+z375Pg==
X-CSE-MsgGUID: C/eRW1o/RCqs1wRnhGI5tg==
X-IronPort-AV: E=Sophos;i="6.06,161,1705388400"; 
   d="scan'208";a="183550554"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 02:15:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 02:15:33 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 02:15:30 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<andre.przywara@arm.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: ARM: at91: Document Microchip SAMA7G54 Curiosity
Date: Thu, 15 Feb 2024 11:15:22 +0200
Message-ID: <20240215091524.14732-2-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215091524.14732-1-mihai.sain@microchip.com>
References: <20240215091524.14732-1-mihai.sain@microchip.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


