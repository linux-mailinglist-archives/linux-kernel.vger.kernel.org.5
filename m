Return-Path: <linux-kernel+bounces-57912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A07384DEEC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4AD1C23792
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F4F762E4;
	Thu,  8 Feb 2024 10:54:09 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A756EB57;
	Thu,  8 Feb 2024 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389649; cv=none; b=NDY3aYOczNAb5vI7NbJirc8Zgw432W4I245RHw6ceaZfxvxb4G6L4BH+B3zVc0EdSli20n0C0TzKZnCsmTxl+aJvOfozf7fTiTgNyQAi6hLI/5LTuWLzYfEHwNv8etaJOqejx8RuamKpWnURI4H+tLhyb+hm/PBKIhrSOuJcimI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389649; c=relaxed/simple;
	bh=1Zn0pbl+Us/lPLFf385YwPJy/pjFtQA4GG45Zc7JrJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mMlb09kpoTjtXpA0b2c2X6591sjdQN3qZeRkIxuVXbYc9eke7nK+Ng1A/MWIFy/j1cvUt8tm3UyLT54fqbaNpD12GDWL7mYB8hE1aLForP7Eugl9cyfUL/gT5qwQc6ayQ+l9i0rCHhaWDR6pzRYrHi8yLpjPewHaeuKFwMIxtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: f43A0h59SpgNhVabT0v/FWECLT2PvuDQyIElbP435wbk32GuoFB2uW3sopjxHLLbEdiXH5iDWK
 lSy0AvC88KNg==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 08 Feb 2024 16:24:02 +0530
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
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [RESEND PATCH v1 03/13] dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
Date: Thu,  8 Feb 2024 16:23:33 +0530
Message-Id: <20240208105343.1212902-4-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208105343.1212902-1-bhargav.r@ltts.com>
References: <20240208105343.1212902-1-bhargav.r@ltts.com>
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
TPS6594 and TPS65224 have significant functional overlap.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
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


