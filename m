Return-Path: <linux-kernel+bounces-166559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B6E8B9C68
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C8E1C21A61
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC4F153501;
	Thu,  2 May 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tl5dugvB"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A4153519;
	Thu,  2 May 2024 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660535; cv=none; b=GXDvuPJBwHslLa9QTIl92xY0T0agNcE3VvWW0EU+/i7ygRxcN9wzusbU00ZhDdLE/sT9WTnj9n6uSSisZM89ynVCNOof222XfRFi/dd67XG/rihz01iQC/ZDntf1KHAvBe4lJqZCrGErVPGq9bl6MvkOQ5pjJmAJBktfNTCMcgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660535; c=relaxed/simple;
	bh=srvRpnt+6CmvKsyLXphEyCpMECe+q0Va3JX9d0EkVVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDxUj3H/lLKiwQPdlIK8HecUiz8tJ49MCF+mTLqsH3BLTISwONSn4iF2FlXuBjGxK9scUx6EnzZyQHXSepPQtgOGZxuOAYuh2DYsejzgTP/cQ6PO6/RKSt0RIkb4ubZOeThtuwhig/flmwmBrrqQBz8V7yxjrYCJS7a/n0VPFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tl5dugvB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714660533; x=1746196533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=srvRpnt+6CmvKsyLXphEyCpMECe+q0Va3JX9d0EkVVw=;
  b=tl5dugvBHtPU7IgnDwpgN4Jm/cTciRgIcwq28m8M895Ja52pelkpvubu
   kqwXfOcGDJCbQL2XVJXH3FtK3g3x0nTK7PNc0Yl/e1zqOH6QA//XBEwy/
   JQ91a6CtQQmNROn4FEn7tA/16rNtPnOzJlUwEBc1JfP3mvluWPSWI5Jit
   fPxoeDGGaKFAYNgFCiWofiFx1o0TWCw5Lx4hQXSYTmuyh9Ihgzo6C1OfU
   aX/YT8ok3ZRXWBfL+e3Z2cvSwbbg7WVQ3EOkLT3g1Kd1eFe6RgbNOqDZX
   H+V9TlCB1xvZiV1eDsn52+D5teQ9WdQ5uBIC/mATjKGG7ybg6CPRISgJ/
   g==;
X-CSE-ConnectionGUID: F9keJgHaQq6ZBD0kgjKFCA==
X-CSE-MsgGUID: 2p2e97gBSBSzumW7E9JOdA==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="190725994"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2024 07:35:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 07:34:52 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 2 May 2024 07:34:50 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	<valentina.fernandezalanis@microchip.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH 2/3] spi: dt-bindings: Add num-cs property for mpfs-spi
Date: Thu, 2 May 2024 15:34:09 +0100
Message-ID: <20240502143410.12629-3-prajna.rajendrakumar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502143410.12629-1-prajna.rajendrakumar@microchip.com>
References: <20240502143410.12629-1-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The PolarFire SoC SPI controller supports multiple chip selects,but in
the MSS, only one CS line is physically wired. To reflect this hardware
limitation in the device tree, the binding enforces that the 'num-cs'
property defaults to 1 and cannot exceed 1 unless additional
chip select lines are explicitly defined using GPIO descriptors.

Fixes: 2da187304e55 ("spi: add bindings for microchip mpfs spi")
Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
---
 .../bindings/spi/microchip,mpfs-spi.yaml      | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
index 74a817cc7d94..19951951fdd6 100644
--- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
@@ -13,9 +13,6 @@ description:
 maintainers:
   - Conor Dooley <conor.dooley@microchip.com>
 
-allOf:
-  - $ref: spi-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -43,6 +40,22 @@ required:
   - interrupts
   - clocks
 
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,mpfs-spi
+      not:
+        required:
+          - cs-gpios
+    then:
+      properties:
+        num-cs:
+          default: 1
+          maximum: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1


