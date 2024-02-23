Return-Path: <linux-kernel+bounces-78848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26CA8619B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC1D288033
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9EA146E97;
	Fri, 23 Feb 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c6h1r/6r"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8AB12AAE0;
	Fri, 23 Feb 2024 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709198; cv=none; b=av1GFtAWNuf8xHYU6vL0HvGfVGcWredQtNcY5AKQ0k5Z8RcgZvA8VeWtNmP8YZw1c2YcXgEzP5gvuHbREL7GVrmsAss7QwKWk9AevKF35g2ahx45Uw95WFkIKzSxXTZtZhIGCooWLzZY/Mbh3NZKoz3STvQ/VfrvUPsXjKHkAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709198; c=relaxed/simple;
	bh=7D7QN22dZMevSxIgkvWzAcMkdzVrR6HmrNDS9+rfmco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJh3lRxafgGBdznqYcweQBz/Xw0DH7kOAxgWqibLI5aA39dTVgZWLVK7jgIj4PDNiu5bKhqOGawZHjX/vcR1KXLdhjjVcRrDCrpMkiDCmCjqFvNMH4ozz5enQkwxWLmz4bepj82Tjc4qciawz09nDQ3kiQDAH/Wt0E2ZYdrXho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c6h1r/6r; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709197; x=1740245197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7D7QN22dZMevSxIgkvWzAcMkdzVrR6HmrNDS9+rfmco=;
  b=c6h1r/6rEJ9AcBU7/cOZVnwEIe37o9fZfTSdd5lltN4ADQZ5p6WDtcCa
   exLVeT+SJZdO4i3mJHsi6qg1WDn4ozXFodRIzHabKT+ehf5w32G3F6LPr
   /DOgONRSJ/2KW8g7I2EcSnomCfJAjLzlzbsRuMWmMPJuWLvDzkKp7aw6s
   Vljw19zjifsQQExepI/A6tht5svHlSIdO2b6YBAlrtAzHbvopx4sHdZVT
   BUh3PZb0x4bTCiUkj+eLwSR2i9N3I/jJvDy3e2OXIrLW6E0cDVXmTi0+G
   2m+0rZMv0iGixwAiR9pWDEvhxmy1FV7rFu6WAwJqBsijl3SCYC5N5oTGM
   g==;
X-CSE-ConnectionGUID: +I+FaeeiQtWNdanq9i7vCw==
X-CSE-MsgGUID: Usph6H1EQ5SYvZ4cQ2lXHA==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="17267227"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:26:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:25:58 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:25:54 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v4 11/39] dt-bindings: rtt: at91rm9260: add sam9x7 compatible
Date: Fri, 23 Feb 2024 22:55:52 +0530
Message-ID: <20240223172552.672094-1-varshini.rajendran@microchip.com>
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

Add compatible for SAM9X7 RTT.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v4:
- Made sam9x7 compatible as an enum with sam9x60 compatible as
  suggested
---
 .../devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
index b80b85c394ac..a7f6c1d1a08a 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
@@ -19,7 +19,9 @@ properties:
       - items:
           - const: atmel,at91sam9260-rtt
       - items:
-          - const: microchip,sam9x60-rtt
+          - enum:
+              - microchip,sam9x60-rtt
+              - microchip,sam9x7-rtt
           - const: atmel,at91sam9260-rtt
       - items:
           - const: microchip,sama7g5-rtt
-- 
2.25.1


