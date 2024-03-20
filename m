Return-Path: <linux-kernel+bounces-108763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C3B880FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD391F21326
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010003F8DA;
	Wed, 20 Mar 2024 10:26:26 +0000 (UTC)
Received: from esa1.ltts.com (unknown [118.185.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D643FBA8;
	Wed, 20 Mar 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.185.121.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930385; cv=none; b=lQivXuSTwoTeVoVhH7P5bIQ5Up1aW3uACXHkRqf/xpeaBRCFEMs4oZ0Z/hrO8fC5fgBfKE8m1AMuwf5pcixsHIUBm3PcxRtvXnjCKmEYxQ3a8TbUEI3IWIwj+/ix7602/3YzqPD5VL4f0XcLTOJ95ixtmi0Jx1DgcSJqTflEfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930385; c=relaxed/simple;
	bh=UEdOs4UfnECnvOUdq3tW2tCJOukxn82iBBTNqs61wr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f54BTx5NqT5wRz2PqlQXVQ13crDMSRQ+lsiWsXB87lAFx+Sj0pNi9RysvO9VdHqYW7EoLl7JqMOjCVUWm60a4F/ZNLkaT9moysn2TOR94mqih3KoIFnk5b/lelcUny8y8HGcx+jNUBuNqR2i4/QlwqS/R8btQmfErC7UB70EO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=118.185.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: v80gQx3T86vrObtKBsRJLs50cs7joyVm5GIKWUt4XeiWtGbRz5aMY+Mwerzg7SNG/yRiGUAFXy
 AriHF/tENM8g==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa1.ltts.com with ESMTP; 20 Mar 2024 15:56:16 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jpanis@baylibre.com,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	eblanc@baylibre.com,
	Bhargav Raviprakash <bhargav.r@ltts.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 04/11] dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
Date: Wed, 20 Mar 2024 15:55:52 +0530
Message-Id: <20240320102559.464981-5-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320102559.464981-1-bhargav.r@ltts.com>
References: <20240320102559.464981-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TPS65224 is a Power Management IC with 4 Buck regulators and 3 LDO
regulators, it includes additional features like GPIOs, watchdog, ESMs
(Error Signal Monitor), and PFSM (Pre-configurable Finite State Machine)
managing the state of the device.

In addition TPS65224 has support for 12-bit ADC and does not have RTC
unlike TPS6594.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
index 9d43376be..6341b6070 100644
--- a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
@@ -21,6 +21,7 @@ properties:
       - ti,lp8764-q1
       - ti,tps6593-q1
       - ti,tps6594-q1
+      - ti,tps65224-q1
 
   reg:
     description: I2C slave address or SPI chip select number.
-- 
2.25.1


