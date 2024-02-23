Return-Path: <linux-kernel+bounces-78847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15568619AF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A3A288073
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9150B146E73;
	Fri, 23 Feb 2024 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WL20f8zg"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4612F379;
	Fri, 23 Feb 2024 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709192; cv=none; b=MKYKAPfYp9iBObTQrAF7yCKGKxtmb5a1S4PaKLx5dL8TaY3BcW/FgVh9nU4XCb0TWmbbL75d7zNBuCXoSWukmDH82oa3Q76fdZVRL/yvkjO3FJ7MQjN/LaoW8sLR6yJHC0pQJN4q47CkGkEIY96CoBgQN4LMcLnwDZa2UT2EINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709192; c=relaxed/simple;
	bh=mfK3CVg0+fhZh3qQ1M3R9KIJX9QW8WJLAAfA0+fk6+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5qbZRtqNfoiHtK5ce0SVH0sK+OL3VbQqK0wXl4cM9jA57Atezcup2eqqFdf2y81N2lJhpo1YGhM2IQtvpG/C1PaECGhs/Ek8IRTd8JcXmjNInj4NjBbKho5FRXTQ9V7sRNJBFoWHAlh10vMWwgjUC5Y0dzZ4IiYXB5ho1Uax5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WL20f8zg; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709191; x=1740245191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mfK3CVg0+fhZh3qQ1M3R9KIJX9QW8WJLAAfA0+fk6+Y=;
  b=WL20f8zg6yqo5aIbPgQQg10smVwZWGBCDz8wRWLy+Bspq0mPhFhiUJsz
   hZU+uZ8dfx1o3W+3VTBSXYLgCu/dg7c8Q+aG9LLX0V/nKCbX9fTUHmSb6
   7dLgXOmXd5ee1AihERkRmVsAqR4OjPeMDr/sHHs5cCzGbmg4eDbPoevnS
   GQQ000H+Rdp0PLLTlmLKOYfimvdw9S7eApVhunn9W/LaHKX4gV8V6ObPH
   gLsSFOfK1Z+jAvUsfSj5jOy6UTr1jmc4YoBLpH6EeGTCVOEoJyFuCaCVu
   qjhKyTaV0Qpx47Qu08yJec+u5IGnuuNOgk3pSUGkDCDgmvS1P2nadM4a3
   w==;
X-CSE-ConnectionGUID: t18HA6KHT7+gZ8BIMsEZ6A==
X-CSE-MsgGUID: HS/vplxHT7qt8E56e2XNrQ==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="16734509"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:26:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:26:27 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:26:22 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <u.kleine-koenig@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v4 14/39] dt-bindings: pwm: at91: Add sam9x7 compatible strings list
Date: Fri, 23 Feb 2024 22:56:19 +0530
Message-ID: <20240223172619.672262-1-varshini.rajendran@microchip.com>
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

Add compatible strings list for SAM9X7.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
index d84268b59784..96cd6f3c3546 100644
--- a/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
@@ -25,6 +25,9 @@ properties:
       - items:
           - const: microchip,sama7g5-pwm
           - const: atmel,sama5d2-pwm
+      - items:
+          - const: microchip,sam9x7-pwm
+          - const: microchip,sam9x60-pwm
 
   reg:
     maxItems: 1
-- 
2.25.1


