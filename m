Return-Path: <linux-kernel+bounces-64855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8612A8543C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E85288DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BED12E5C;
	Wed, 14 Feb 2024 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="POUGozEL"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B91173D;
	Wed, 14 Feb 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897861; cv=none; b=LNaC4YAjWDASxpvDPzbi7JoHkFFk+893q//M4f7HeJd46Mk5UXGYUVYAn5Kp/nC8pAu0p5i8yFcH2HQvh75e5pc25nMpg8R2CY3Ka5Yf93tcKTgz3NLHw14mwRdhp6Ei6pyArsVY4xCe0mT6uNMlxNEL9uGnBG/ZKFv1sHGpxVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897861; c=relaxed/simple;
	bh=0AumbT9VD7jrQpuV2WNJF2ZTS/F/XT/yJPrnJl5acKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6LzDNLOs8lhTQ0BoFhjP3M6fkWmld+7RL0YCt11nkT7BIrrmsgpZwn4s+Tc1sR61Mn/IQL6hTW5nC1/A0bkM3jxRms3u12XRE7Ml7CwVSiwdHZya1rIM4671qXZdZ+xEActSwJa8UlbXwefPtNGS15PTWL+HEbkOHKzerjpyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=POUGozEL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707897857; x=1739433857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0AumbT9VD7jrQpuV2WNJF2ZTS/F/XT/yJPrnJl5acKE=;
  b=POUGozEL3MaFIilExhzqd6FiozE4YW0C9/iUGSxQVwusZtFzZYjpkNz4
   hfOfCcvriSdevCNPxyP0iDuoxMqSjjp/VDUaOiSdqFCm/eUp77m9R6zsx
   4rX3i8K9LGrTkldWSvkcW20RQM/ty8HPlOvb2FKQToAxjm6g0YY289o7T
   BDU2IAsRtWYSR5k8xiwsANwg0YFqbhcdTOgHQm814wisosbn8EXJk6KDx
   Gwxh4aRibCs8x+HrdOVeTpRKPEcuzU6+xzVZeaCVphzjVpfi1pQp1sBM6
   ugxAHDnvQiUUpuG4Q/IbFlZzrjpZYlozzBeck6LgoxQt7mm5YQcR5Vcjm
   Q==;
X-CSE-ConnectionGUID: 5EMCBeoZQRC2nXyc/ouEeQ==
X-CSE-MsgGUID: YPtgnR9uSziuzLevygoeXA==
X-IronPort-AV: E=Sophos;i="6.06,159,1705388400"; 
   d="scan'208";a="17666783"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2024 01:04:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 01:03:59 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 01:03:56 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<andre.przywara@arm.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: ARM: at91: Document Microchip SAMA7G54 Curiosity
Date: Wed, 14 Feb 2024 10:03:46 +0200
Message-ID: <20240214080348.7540-2-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214080348.7540-1-mihai.sain@microchip.com>
References: <20240214080348.7540-1-mihai.sain@microchip.com>
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


