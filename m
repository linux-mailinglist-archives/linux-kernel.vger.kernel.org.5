Return-Path: <linux-kernel+bounces-131450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 638A589880C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F89128EF14
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A68312AAE7;
	Thu,  4 Apr 2024 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ekfs0HVz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47106128361;
	Thu,  4 Apr 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234329; cv=none; b=GBHbMRJPKEfUQFCVZXfMQYFcH928JhbTxkx4MCBsxnz8rQzeH25XkJnBWisL6T98ZILU/ovT0cJtYieVwMazB0JPr6vwQ4yrxNlkNuRy+pwlm34bx+IOk75LCmaNbwcPcZO806Zm1ebbtpEYrI/CthueiDogzBMWRNAITrB557I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234329; c=relaxed/simple;
	bh=BqLh2TXuzSKAxHouEngvuuCxKj/tZMBJbO/Duq4WBP4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WiD0VMApFhpb0KDidX4HSP7k3guS2JMnlLfpB4p+kRKv7e6UypM1cojece9lv7rD/m1HJ/0hFQF0Ss2DUSZPjyGG4QTRUEmOA8RtIpJ3KRisepegXiWGKqe5tYwOauanFDcv7tWhibTd+5OZt8jSRfvqIV5eTWMxUQrngmmQnHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ekfs0HVz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712234328; x=1743770328;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BqLh2TXuzSKAxHouEngvuuCxKj/tZMBJbO/Duq4WBP4=;
  b=ekfs0HVzqctIkFCXU9f2uY/12x78sJdpH/u4zezIrD48i5jD2S9EZjZe
   W4XArne33s9nWimhmwJjux5fapky7h5e4YQJIc6WWawl1jdnV7IpzpIFq
   /x8JfGSkMADWuUg+fBdLspaAEC+vmS/NbZX1sZeDlWoAvfcq3v5gGbsSY
   U/YtXB5CZy30nHz0nlTS8fTmBoxqfe1Pv63ucrjfHYc+ysdCiXPbxBFAT
   68zTK9SrJogLwn5pl89cCFJbnSuqbFxxUaJobzwe1Q1KwjnVQ5SsVTT9/
   tFnWgX8AaXhdyXyMqa4aKoFoYrneT1U64Z+23QhLXsiYfg2fZsWbSJIsa
   g==;
X-CSE-ConnectionGUID: zxdOAx2MTCC4NEu2Y4szsg==
X-CSE-MsgGUID: C1GdgCJ7T5aXTz2Hl6Ze4g==
X-IronPort-AV: E=Sophos;i="6.07,179,1708412400"; 
   d="scan'208";a="250267567"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2024 05:38:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 05:38:30 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 05:38:28 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<mihai.sain@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v2 0/2] Fix the regulator-state-standby definition
Date: Thu, 4 Apr 2024 15:38:22 +0300
Message-ID: <20240404123824.19182-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

make dtbs_check DT_SCHEMA_FILES=microchip,mcp16502.yaml

at91-sama7g5ek.dtb: mcp16502@5b: regulators:VDD_(CORE|OTHER)|LDO[1-2]:
regulator-state-standby 'regulator-suspend-voltage' does not match any of
the regexes 'pinctrl-[0-9]+' from schema
$id: http://devicetree.org/schemas/regulator/microchip,mcp16502.yaml#

at91-sama7g54_curiosity.dtb: pmic@5b: regulators:VDD_(CORE|OTHER)|LDO[1-2]:
regulator-state-standby 'regulator-suspend-voltage' does not match any of
the regexes 'pinctrl-[0-9]+' from schema
$id: http://devicetree.org/schemas/regulator/microchip,mcp16502.yaml#

This patch series proposes to correct the typo that was entered by mistake
into devicetree definition regulator-state-standby by replacing
regulator-suspend-voltage with regulator-suspend-microvolt.

--------------------
v1 -> v2:
- drop "boot" from title
- put in commit message a snippet with the warning to explain the chang
--------------------
Andrei Simion (2):
  ARM: dts: microchip: at91-sama7g5ek: Replace regulator-suspend-voltage
    with the valid property
  ARM: dts: microchip: at91-sama7g54_curiosity: Replace
    regulator-suspend-voltage with the valid property

 arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts | 8 ++++----
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts          | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.34.1


