Return-Path: <linux-kernel+bounces-25504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0AB82D13C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5123F1C20DC3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABE379DB;
	Sun, 14 Jan 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lv2cvrH3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058625231;
	Sun, 14 Jan 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705246088; x=1736782088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gErb4SvLDcsU5HgGSgzQl+lRFtQWIMD24E+MzwAOiTg=;
  b=lv2cvrH3ZI/CZfvOKUvkZ1pRjK8AEWogUEIolZdWqIcY8h59JIRIrQeK
   Fl6sgPUpkWCmdftzgMeOgGACqFeogl//Iez6V1ueBoGoUoEnyvGH49XUA
   fkUSs8RcsVnbTrVoH3enng7yTqVgsCluuI5rxVojCEPM/YQ0U8y1OMbW1
   t0dfRvnCAtFY7PHp7Uh9xF59EOGH2rZ+jTJvEcmLt4vg88cKl8VDz9wHv
   GTC5N9GkLFAQNHscDpttncI/yvwCunGwOUZA5CRCdf4b0q1yMOkzL+Z9H
   IOxH/d4qyWuY7QrRn/LNKCX8aPWBUSVOTMf1SeM6VKS0YkINsMnDUz1u7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="12835872"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="12835872"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 07:28:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030429356"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="1030429356"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jan 2024 07:28:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3825C3AE; Sun, 14 Jan 2024 17:28:02 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v1 2/4] backlight: hx8357: Move OF table closer to its consumer
Date: Sun, 14 Jan 2024 17:25:09 +0200
Message-ID: <20240114152759.1040563-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move OF table near to the user.

While at it, drop comma at terminator entry.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/hx8357.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index c7fd10d55c5d..8709d9141cfb 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -566,19 +566,6 @@ static struct lcd_ops hx8357_ops = {
 
 typedef int (*hx8357_init)(struct lcd_device *);
 
-static const struct of_device_id hx8357_dt_ids[] = {
-	{
-		.compatible = "himax,hx8357",
-		.data = hx8357_lcd_init,
-	},
-	{
-		.compatible = "himax,hx8369",
-		.data = hx8369_lcd_init,
-	},
-	{},
-};
-MODULE_DEVICE_TABLE(of, hx8357_dt_ids);
-
 static int hx8357_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -640,6 +627,19 @@ static int hx8357_probe(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id hx8357_dt_ids[] = {
+	{
+		.compatible = "himax,hx8357",
+		.data = hx8357_lcd_init,
+	},
+	{
+		.compatible = "himax,hx8369",
+		.data = hx8369_lcd_init,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, hx8357_dt_ids);
+
 static struct spi_driver hx8357_driver = {
 	.probe  = hx8357_probe,
 	.driver = {
-- 
2.43.0.rc1.1.gbec44491f096


