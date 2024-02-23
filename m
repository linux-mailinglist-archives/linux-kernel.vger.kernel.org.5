Return-Path: <linux-kernel+bounces-78866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF2A8619E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20D91F2706C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9FD138488;
	Fri, 23 Feb 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NcoGF6YI"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8C12E1FC;
	Fri, 23 Feb 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709425; cv=none; b=akoQnnC37qyC+tWk0beiaX9aJFxXPmZN+myURQ8x/iCcEl2a2LBZ3zsO0220jv7K/eBcRPK0az9JseA/gmGTuZTkxDYI5qaPCrezhVri/DQEhkyGhSEnyALas+yS/v2x/ZaPrIz9vMyhzgHY0oe9oO59c1cQnlhe5BSRWYiaii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709425; c=relaxed/simple;
	bh=+klO3bbOdffwzhA8ixlhjvL2TDFPdKbuHLwQA3504FQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ne37Vrg8HsZKc+2K1lw8D8ygIGjCRrdTxZUQbHXMH/qMvE2CDkaSl7kTtXG9LGj04+K578f/h463cHAp4KtW+ozE8hBTKDrGG00N3pykeNiCLKGk8txjZKCP4tkEiizlI24HQm5BNkrJ73ucugi7peQE9CIhYsbRcWVNre3wCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NcoGF6YI; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709424; x=1740245424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+klO3bbOdffwzhA8ixlhjvL2TDFPdKbuHLwQA3504FQ=;
  b=NcoGF6YIhjzbSwc2KexW0EnnL9oksoVZAStGbJJj0maluxFOsGUaOpFG
   RrOvWOQ9gEub66k+vHXk0IoBIHogpsIdltjIHxpEXpahfMVrAuNgmzeEx
   JipQwxAIgzb9TsmAyMO3CKk/xBGQft55TWFZTptYP0WNXqCpo2+4429wk
   8QL+QpkZS6LbUdM69BCW+lcCiI/dnVfD0BIIMNlRvWZkmlVjVodr7CZ09
   npbes+oQFgWuBKGt2GjIen7OWybOfC7KPaSLyrXB252BYuLFDMBa9B6+Z
   rUmSjNQS5/nRn8xYtTz2xSRJ/2ziRG/Rm8+tEiJ/zuYZoCyQD1QZmnFxN
   w==;
X-CSE-ConnectionGUID: QbP5QoTlTPilSlYKCz5csw==
X-CSE-MsgGUID: zcpPtxk2RJugE+TTZD4nVQ==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="17267448"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:30:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:30:15 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:30:12 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: [PATCH v4 32/39] power: reset: at91-reset: add sdhwc support for sam9x7 SoC
Date: Fri, 23 Feb 2024 23:00:10 +0530
Message-ID: <20240223173010.673231-1-varshini.rajendran@microchip.com>
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

Add shutdown controller support for SAM9X7 SoC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Changes in v4:
- Updated Acked-by tag
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index e3ebebc1f80d..dafb0126f683 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -34,7 +34,7 @@ config POWER_RESET_AT91_RESET
 config POWER_RESET_AT91_SAMA5D2_SHDWC
 	tristate "Atmel AT91 SAMA5D2-Compatible shutdown controller driver"
 	depends on ARCH_AT91
-	default SOC_SAM9X60 || SOC_SAMA5
+	default SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
 	help
 	  This driver supports the alternate shutdown controller for some Atmel
 	  SAMA5 SoCs. It is present for example on SAMA5D2 SoC.
-- 
2.25.1


