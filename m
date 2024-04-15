Return-Path: <linux-kernel+bounces-145775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB8D8A5AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDEB1C22E68
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4853B15667B;
	Mon, 15 Apr 2024 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYGj/UVw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEBF156641;
	Mon, 15 Apr 2024 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209628; cv=none; b=aCo4+JM00Tv9jOOmUkHvvka5TW55Dn5gD0yEPemGK2qtI2gZbEGQI4Q2Vou9iHlz63Z4KXAleOhj7YXbr4UHOWOKanIjiKg/C6ZWmwp+jZ3T3iHRyTjvVDKXJC0UnsWIxFJQHpMLX/w+8pQicR3/p49z6buzm/mFwY88kWlWbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209628; c=relaxed/simple;
	bh=lJ43QwVCH35eew4twZ4gDga7AlocnW3yaGcqYV4R5jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcxVV99AVYxsQhRkdwkkIavmmp6m7j9hwtV3nMjLBGkTlV1hpzvam7anNFLfGrtFgFrzP7p4pMpppWjv92ru2WfbTZziAZd7ckN4Xqg0EZ4IvxigP4k/Ky/o8sJEBEtZmWzx56DJLvM+HYF/RSx2bDD+eJtucsRVxBmUdgOlVco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYGj/UVw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713209627; x=1744745627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lJ43QwVCH35eew4twZ4gDga7AlocnW3yaGcqYV4R5jc=;
  b=gYGj/UVwBhmC/0sF9NEIcNuwDNI39+JtSg5K2w7xeHWeTtxblD2G/1bA
   NW72Uo3GFYRiHAsga5bLXjbkzCLNSs/QYZiSM+8cHJTfhm3T2JYNdY7h6
   ZQkhlfZQqkM/XJAorAXfK/Nun/krm44aJl0FKV4XWer1lnDojSbTeZh2u
   EMbkuW2RpAKUkqqMKKe2zCYBwv8RxXiwiI/26rMO8qNvlIytaiypIpEbh
   O5U1+xC7V1OVbe+pLzP8+oS5QxKLxdFyW0p5MRu3UpK3ZdojYPiZKfYy6
   M8LRflKw8CwUCs4PhRbgLght4ikjq2HjfIxYMWSuQEgPMwRyd5HGtgjCY
   w==;
X-CSE-ConnectionGUID: PrLbtyLJR8KASZVvgLR//g==
X-CSE-MsgGUID: LJYR4bq/RAOnsvid/eNWfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8741053"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8741053"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 12:33:45 -0700
X-CSE-ConnectionGUID: r/GOW/l2Qn25BrmC40hP3w==
X-CSE-MsgGUID: Zcq3Z338TjqItuiiDt8c/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="53214031"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 15 Apr 2024 12:33:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 12617455; Mon, 15 Apr 2024 22:33:42 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] spi: Extract spi_toggle_csgpiod() helper for better maintanance
Date: Mon, 15 Apr 2024 22:31:19 +0300
Message-ID: <20240415193340.1279360-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240415193340.1279360-1-andriy.shevchenko@linux.intel.com>
References: <20240415193340.1279360-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The multi-CS support splits the comment and the code in the spi_set_cs().
To avoid this in the future extract spi_toggle_csgpiod() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 49 ++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ff75838c1b5d..4e40efd25aec 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1036,6 +1036,29 @@ static inline bool spi_is_last_cs(struct spi_device *spi)
 	return last;
 }
 
+static void spi_toggle_csgpiod(struct spi_device *spi, u8 idx, bool enable, bool activate)
+{
+	/*
+	 * Historically ACPI has no means of the GPIO polarity and
+	 * thus the SPISerialBus() resource defines it on the per-chip
+	 * basis. In order to avoid a chain of negations, the GPIO
+	 * polarity is considered being Active High. Even for the cases
+	 * when _DSD() is involved (in the updated versions of ACPI)
+	 * the GPIO CS polarity must be defined Active High to avoid
+	 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
+	 * into account.
+	 */
+	if (has_acpi_companion(&spi->dev))
+		gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx), !enable);
+	else
+		/* Polarity handled by GPIO library */
+		gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx), activate);
+
+	if (activate)
+		spi_delay_exec(&spi->cs_setup, NULL);
+	else
+		spi_delay_exec(&spi->cs_inactive, NULL);
+}
 
 static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 {
@@ -1072,31 +1095,9 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 
 	if (spi_is_csgpiod(spi)) {
 		if (!(spi->mode & SPI_NO_CS)) {
-			/*
-			 * Historically ACPI has no means of the GPIO polarity and
-			 * thus the SPISerialBus() resource defines it on the per-chip
-			 * basis. In order to avoid a chain of negations, the GPIO
-			 * polarity is considered being Active High. Even for the cases
-			 * when _DSD() is involved (in the updated versions of ACPI)
-			 * the GPIO CS polarity must be defined Active High to avoid
-			 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
-			 * into account.
-			 */
 			for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
-				if ((spi->cs_index_mask & BIT(idx)) && spi_get_csgpiod(spi, idx)) {
-					if (has_acpi_companion(&spi->dev))
-						gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
-									 !enable);
-					else
-						/* Polarity handled by GPIO library */
-						gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
-									 activate);
-
-					if (activate)
-						spi_delay_exec(&spi->cs_setup, NULL);
-					else
-						spi_delay_exec(&spi->cs_inactive, NULL);
-				}
+				if ((spi->cs_index_mask & BIT(idx)) && spi_get_csgpiod(spi, idx))
+					spi_toggle_csgpiod(spi, idx, enable, activate);
 			}
 		}
 		/* Some SPI masters need both GPIO CS & slave_select */
-- 
2.43.0.rc1.1336.g36b5255a03ac


