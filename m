Return-Path: <linux-kernel+bounces-166557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05D08B9C62
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C1A1F219E5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E89C15356D;
	Thu,  2 May 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hoqG6wE2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1441534F3;
	Thu,  2 May 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660501; cv=none; b=CYaPd1/5ZfEl6sxX7F8/21MSS2s6gFxQtz41RNe74lFGIuZabdJtDr4g8Ylc8GvdooD/135K3ow1+KEBhb4xG4g9hSE5M6FWgddBXuz1814KCPIlvNdbMOtfcq3oPFlq+QySabTiz9DrfPt1XW/MlxVbmt+gs3Vl1l4w67DrkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660501; c=relaxed/simple;
	bh=az+H6CKJ3JtshNX3ivWDCWH1KSrZJLRxlg2naRmB0/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjGcW7zt/Ysqn2rwnV1VGxwJ6XYbKqBNHnqxwxR2F+KPojSrzJ/ZG4mqosdVp0tDtgIRIIKqWbLXSW/KlakL23ZrMWWm48aGffcIq54CaP7Q2iCXRBprBMCqdOmGA/I7K9JQiLuQbTFfZvg8xewSrlFaVWlmYDsGvARzN8JHa2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hoqG6wE2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714660499; x=1746196499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=az+H6CKJ3JtshNX3ivWDCWH1KSrZJLRxlg2naRmB0/8=;
  b=hoqG6wE2d2U2qFoMvn7xDYzY4YZ58ZQJbUhMP3MnXLJqPYNdKJX+oQRD
   0fboPx+bWnbvyLbNNohuafcxGdVDEYwBGmMbEpdh9QjUZOLkPVlnkOAvN
   ETQC6/nCYxhfhlgQt+Ctl8q6k7UJ5iOOyznnaivCF5LMM4iRQYujhD6J2
   26+GYJ+ozsXnySo17uKcJ6o8jdM8JSe68kdP7Vji21cN8ZKf3w3Bkw6NE
   PLQ5xkpyslfpul/W1lmWVdUVogMg8zzw4ZsbjczOdxzR3T36vZsmCtlA4
   NOuTD6XXzeSOsHr1lWSwMLJsZ9Zn2YyPSeQjAxAMYxUDf5cOVwAGJk1OC
   w==;
X-CSE-ConnectionGUID: 6Y5bhyOoSXq5FFQlA0lIog==
X-CSE-MsgGUID: bmojybWRRfSEIw4Ew2+m2g==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="23394532"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2024 07:34:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 07:34:55 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 2 May 2024 07:34:53 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	<valentina.fernandezalanis@microchip.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH 3/3] spi: spi-microchip-core: Fix the number of chip selects supported
Date: Thu, 2 May 2024 15:34:10 +0100
Message-ID: <20240502143410.12629-4-prajna.rajendrakumar@microchip.com>
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

The SPI controller in PolarFire SoC has multiple chip selects, but only
one is wired up in the MSS. Therefore, fix the driver to chose one
chip select.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
---
 drivers/spi/spi-microchip-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 71886c27bca3..4289dfba9af5 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -21,7 +21,7 @@
 #include <linux/spi/spi.h>
 
 #define MAX_LEN				(0xffff)
-#define MAX_CS				(8)
+#define MAX_CS				(1)
 #define DEFAULT_FRAMESIZE		(8)
 #define FIFO_DEPTH			(32)
 #define CLK_GEN_MODE1_MAX		(255)
-- 
2.25.1


