Return-Path: <linux-kernel+bounces-120660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180D888DB1D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3DD1C27180
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E98B52F86;
	Wed, 27 Mar 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QG4jVano"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52E652F75;
	Wed, 27 Mar 2024 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534710; cv=none; b=ZunHu6+EIrsdXoK3D6mjFIGFgtarrEqbxa15p9loDnLxESqy1HkeyTqtg7eI6uilv9a1zDVxpC5mtPad4s1q12WIlESZzGQjCNTs3TKV6TWt8z7iHEqWuLGtNj+ztUOUSzHnh3c+8MNBRPXAi/x2hmkcPWN/LvQHWgyY9gbNgdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534710; c=relaxed/simple;
	bh=/XP+OdQeoB19J4KIQiJ/hmItC3hcLTOi4yoVWsZK9vk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpHUX8pqpI9UHWxA3LTHX6R0qp7vWjPSgd7Bu4rg8a+deFu91/vlBd3gpLR3JotoJnItPzvOzx3BfKpxMKghTa+GPxQEp4lKs9sNIdSMKBOr28mlyHNmzuvpk2P4N2839fWyeiUgVa+Nd2IYF6aduT9Aw4rsxfxX+943dX+BwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QG4jVano; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711534709; x=1743070709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/XP+OdQeoB19J4KIQiJ/hmItC3hcLTOi4yoVWsZK9vk=;
  b=QG4jVanogHkF6gJJL5OGFMAVpE8BX36eqhn047HRKSJDsboAfU4/OaeG
   2NkoQD8C7rvTI2Kn4uEaXLrhLyLg+ZxplwydPOmWlagOJFADVM2j63GPZ
   UDZkRLr9LKbDDdx6RevJKwdP9Se02jsBdikdfFg1AiWaabFzxfynA6sIx
   Ww56/jhxIC17Am9MkKYzLJV8JaSqye9LMjDDV+Znz/kvC5scQRafqhO1e
   /vXb449bdXtSms66z4JRCTTNoMFbVkGahgsnnLKhzk8C/AIX2eIN6NgFp
   Wb21Tphw/e455eif90cvVxgruNlUDgZV6Le8IA/rDg4fZzL/DwY9nmoic
   A==;
X-CSE-ConnectionGUID: iLwE0uHlR2GxnqPkfUjRug==
X-CSE-MsgGUID: wpvBVBh6QYCffiWbDKfL+g==
X-IronPort-AV: E=Sophos;i="6.07,158,1708412400"; 
   d="scan'208";a="18904354"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2024 03:18:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 03:17:59 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 03:17:57 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <andrei.simion@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 7/7] regulator: mcp16502: Update the names from buck regulators
Date: Wed, 27 Mar 2024 12:17:24 +0200
Message-ID: <20240327101724.2982-8-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327101724.2982-1-mihai.sain@microchip.com>
References: <20240327101724.2982-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Use generic names for buck regulators to avoid any confusion.
Update the names from buck regulators in order to match
the datasheet block diagram for the buck regulators.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 drivers/regulator/mcp16502.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 0c15a19fe83a..d6fc9f1afaef 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -468,13 +468,13 @@ static const struct linear_range b234_ranges[] = {
 
 static const struct regulator_desc mcp16502_desc[] = {
 	/* MCP16502_REGULATOR(_name, _id, ranges, regulator_ops, ramp_table) */
-	MCP16502_REGULATOR("VDD_IO", BUCK1, b1l12_ranges, mcp16502_buck_ops,
+	MCP16502_REGULATOR("BUCK1", BUCK1, b1l12_ranges, mcp16502_buck_ops,
 			   mcp16502_ramp_b1l12),
-	MCP16502_REGULATOR("VDD_DDR", BUCK2, b234_ranges, mcp16502_buck_ops,
+	MCP16502_REGULATOR("BUCK2", BUCK2, b234_ranges, mcp16502_buck_ops,
 			   mcp16502_ramp_b234),
-	MCP16502_REGULATOR("VDD_CORE", BUCK3, b234_ranges, mcp16502_buck_ops,
+	MCP16502_REGULATOR("BUCK3", BUCK3, b234_ranges, mcp16502_buck_ops,
 			   mcp16502_ramp_b234),
-	MCP16502_REGULATOR("VDD_OTHER", BUCK4, b234_ranges, mcp16502_buck_ops,
+	MCP16502_REGULATOR("BUCK4", BUCK4, b234_ranges, mcp16502_buck_ops,
 			   mcp16502_ramp_b234),
 	MCP16502_REGULATOR("LDO1", LDO1, b1l12_ranges, mcp16502_ldo_ops,
 			   mcp16502_ramp_b1l12),
-- 
2.44.0


