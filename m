Return-Path: <linux-kernel+bounces-78869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9908619EC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46EB2B23AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8888E14DFCB;
	Fri, 23 Feb 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rd/t4PIc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC3143C70;
	Fri, 23 Feb 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709441; cv=none; b=q9KDmqjU7hRH866Gf0ChWxo1vEv5dMI2tq2a50JTs2WTi3yjHnpXRzZ7AJSm4w1F/oLNes+55VBYYIjF4RC7Lcas9C+UUxqrev/lvVl5g/esikm9R2oDILjKJbBwq9uXt2CQX/Fw6UR/m5KM7zIfcxsV+PtpQCstgan9I83JAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709441; c=relaxed/simple;
	bh=6yaUy0u5t4Wc+0M4Ut142hhEuqrEttKdZznrVqg+kFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lK6R1NDWJ0zpRwD/nuMUkXqdsWyDboUYqMfbMKKGqNT2R62P6a+VOZ7HBdnq21r9Wo1qTae4S7f0AC6UMvP1JXrXfK/+S3vrPFjdjcWXzVZYHPd9eWe7o27s9yqJ/wh1CFv9DsqJG5RVmuXwtVylGzl8JJb22IcD6Xta0U8UIm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rd/t4PIc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709440; x=1740245440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yaUy0u5t4Wc+0M4Ut142hhEuqrEttKdZznrVqg+kFw=;
  b=rd/t4PIcljgpLxnMvDsyfDQZlTrjjnZP3CHan+SqZtU0G5jykf8bIMSA
   F6nwNx/BdDQ9nH2Fl70lwfJDn09Q8L9Q0O2PLgaAANb6acY34XGPbPmHP
   2P2Ue4lVkmovQHQaElAEbRZdZ3vSWarCztT5gILc0mjfu+9Ys2GURh/sP
   2McCxLunqCN56xSpxTv5eyEXQB3PE0aaI+iGMhbxQhRqod1miv3VJFJfQ
   7/0aOK9c20uVmNeHYk96TMgYnqHYl2REkOyboXxxIPYsHHgoCU5nxK9ep
   +8w7nTB9GWZS5b7S6nOJW3Yl98RPD/spQvJDklD1Eb2ts3dFDNM3JEc2x
   Q==;
X-CSE-ConnectionGUID: f6QG3EKtShO/OUe1NBSJ1w==
X-CSE-MsgGUID: N5ToapxpR32c7ZiEAmLKug==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="184009734"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:30:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:30:09 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:30:07 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: [PATCH v4 31/39] power: reset: at91-reset: add reset support for sam9x7 SoC
Date: Fri, 23 Feb 2024 22:59:37 +0530
Message-ID: <20240223172937.673163-1-varshini.rajendran@microchip.com>
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

Add power reset support for SAM9X7 SoC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Changes in v4:
- Updated Acked-by tag
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fece990af4a7..e3ebebc1f80d 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -26,7 +26,7 @@ config POWER_RESET_AT91_POWEROFF
 config POWER_RESET_AT91_RESET
 	tristate "Atmel AT91 reset driver"
 	depends on ARCH_AT91
-	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
+	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
 	help
 	  This driver supports restart for Atmel AT91SAM9 and SAMA5
 	  SoCs
-- 
2.25.1


