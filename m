Return-Path: <linux-kernel+bounces-78850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449E68619BA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5C11F22814
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BC71384A0;
	Fri, 23 Feb 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sh/bG1Q8"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2712DD86;
	Fri, 23 Feb 2024 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709228; cv=none; b=XxpX84VgcX9EnpMtaoOJKYY9C/QACei05dx/2toOrqDFQTwPQ8m/3xOnlKSRSfyP8Q6CJOs2Rw1JI4xNYLw/DT3L6Iwk+/gLddlPI1evwf5o2w/9QCUVDr/63Sux+m5Z1cYTu1uNKnHHh/1/DN0JMIFv2TIVaRyU1+JS8lhtGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709228; c=relaxed/simple;
	bh=hA6t0dUmMpp366ADXyoHTsVlJuJfCOs9fFBiMBv3M+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oy8/nn8WMrMiQ1Ca7Dy0zsuZiGi8uzE/1Cs3HQ0r4CAw/mNjdUP4gB+JYbghX6L/6naBzQMvqQfEL6CJ2wNRtKZj9Ad/h1lyPt3YBX8Mml77MPRE8TvlWpDJShJgHHHteRx6CevX9ncIDaz4B8MG1H8TVsTMDcZ6M0/TH2WTJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sh/bG1Q8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709227; x=1740245227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hA6t0dUmMpp366ADXyoHTsVlJuJfCOs9fFBiMBv3M+4=;
  b=sh/bG1Q8tLE8/pAwY0b9QFMMq7W3hUWGOpTkvzFh8IcLe1DG0MYvOnoT
   l6k4HrvIu11HWIqZRa+Q3zh/Xim1AoLsYF8M2sRWdLAqPRPsY2ECkZ1Ig
   Gz57Sq0k3RWrxfRnA0QzAr09POXduFz8/zbyK4BN7EUP9uNkjV4FCdaj6
   hAslFH8EuAqs9/31kUki/sl8KXVWfwaJEvLadq7rmWBtGg3hWdUd2bN0O
   EBS3t94RkjFyKVdIVCUi8GQ0EliVssTu026mKypqA1K36f9xVpE+7s11R
   ryDhTXHK/nm/MPQ9dP6UJKX+yS121xlDNLc4Y0m0M0fZjIg94D+GlXZPY
   g==;
X-CSE-ConnectionGUID: O9nSenaIQFe/RJGNzUZuEw==
X-CSE-MsgGUID: 5IlSLmlrTv6CGNoCqJRYVg==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="16735880"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:27:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:26:56 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:26:51 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <tudor.ambarus@linaro.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v4 16/39] spi: dt-bindings: atmel,at91rm9200-spi: remove 9x60 compatible from list
Date: Fri, 23 Feb 2024 22:56:38 +0530
Message-ID: <20240223172638.672366-1-varshini.rajendran@microchip.com>
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

Remove microchip,sam9x60-spi compatible from the list as the driver used
has the compatible atmel,at91rm9200-spi and sam9x60 devices also use the
same compatible as fallback. So removing the microchip,sam9x60-spi
compatible from the list since it is not needed.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v4:
- Elaborated the explanation in the commit message to justify the patch
---
 Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
index 58367587bfbc..32e7c14033c2 100644
--- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -22,7 +22,6 @@ properties:
           - const: atmel,at91rm9200-spi
       - items:
           - const: microchip,sam9x7-spi
-          - const: microchip,sam9x60-spi
           - const: atmel,at91rm9200-spi
 
   reg:
-- 
2.25.1


