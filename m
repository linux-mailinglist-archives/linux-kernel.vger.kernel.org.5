Return-Path: <linux-kernel+bounces-160281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631028B3B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0421F240BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8850914A617;
	Fri, 26 Apr 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNTRe161"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BEE143886;
	Fri, 26 Apr 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145133; cv=none; b=cOwB0ZvrxdYBodz5z82Vr7nyw4BAgBPfPxTadkRa3VbmnXCFfkX5UuiUa4BQ3Rx1X1ww8gCFIsdYoMqjKLADh9bMNCjpkG8V0tQQhDGlaBDT6DEePUBKCzVTOhkP8Xzdad/gid1Dho4F/caqidGJvGhMoV36VuK5opFgqbYzIOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145133; c=relaxed/simple;
	bh=IL2++mNo2aq1MBXdWEeDx4hUUCVamp5GSDIQcKWJuhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kxgcp9KRy6ohxOASAHAKkeUdDhZf5JgU6QroeMhQNGrP3ORiGsE35jLHPAmQ3sfR7aP7tl/RrRcNalMbweOl4b1TJxnfVXaCJcLo3lo7a+NawimMxX5ivRD5qdnhZV1/MrNrGFJnOhH0SThYevzjrk1UIeToWO6kS09x6COMmzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNTRe161; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714145133; x=1745681133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IL2++mNo2aq1MBXdWEeDx4hUUCVamp5GSDIQcKWJuhY=;
  b=RNTRe161LOr/5ptq90ev0Wa1eq2n2x14GA3vepkNRaWcP27xvUSFuMkZ
   WLEU6bBvjUvlB5ME77nE1x1EPotLyayErOmIr+o2u/FSA/4S5NpgDN0MM
   eB0drR6R3+smdeZvpwgLYHXn9+puuXxaO05i+0C9FyMUJpkfx7ZhcNOpJ
   xPBXjLgYIH78RDxMDhVFe+RfePBvm/pDsFgHffuSMODtmKQNGTaf0Z5Qh
   4V3BL/kZqT6JL6UdDUkv+jC+7ETrYwuszMkCxWjoxUGepzUZYm/Z82a4C
   buOBNSv2xptf4SmJA+g6MTe2RJZNzM7Ua8Yicne3Gdi9QWULKBDg6Bq0l
   A==;
X-CSE-ConnectionGUID: qCPKZeNpQmSPVepkfKHkLQ==
X-CSE-MsgGUID: BD/9o2ZLSsa0dQsfB0hIOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10005888"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="10005888"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:25:32 -0700
X-CSE-ConnectionGUID: 1bBkQqt7QkSddjdFx/K+hg==
X-CSE-MsgGUID: AtZdl5jVTUSEYoTRDvhmlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="30084013"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 26 Apr 2024 08:25:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1DFF01CB; Fri, 26 Apr 2024 18:25:28 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Samuel Holland <samuel@sholland.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v1 1/1] leds: sun50i-a100: Use match_string() helper to simplify the code
Date: Fri, 26 Apr 2024 18:25:15 +0300
Message-ID: <20240426152515.872917-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

match_string() returns the array index of a matching string.
Use it instead of the open-coded implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-sun50i-a100.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/leds/leds-sun50i-a100.c b/drivers/leds/leds-sun50i-a100.c
index 62d21c3a3575..119eff9471f0 100644
--- a/drivers/leds/leds-sun50i-a100.c
+++ b/drivers/leds/leds-sun50i-a100.c
@@ -252,18 +252,16 @@ static int sun50i_a100_ledc_parse_format(struct device *dev,
 					 struct sun50i_a100_ledc *priv)
 {
 	const char *format = "grb";
-	u32 i;
+	int i;
 
 	device_property_read_string(dev, "allwinner,pixel-format", &format);
 
-	for (i = 0; i < ARRAY_SIZE(sun50i_a100_ledc_formats); i++) {
-		if (!strcmp(format, sun50i_a100_ledc_formats[i])) {
-			priv->format = i;
-			return 0;
-		}
-	}
+	i = match_string(sun50i_a100_ledc_formats, ARRAY_SIZE(sun50i_a100_ledc_formats), format);
+	if (i < 0)
+		return dev_err_probe(dev, i, "Bad pixel format '%s'\n", format);
 
-	return dev_err_probe(dev, -EINVAL, "Bad pixel format '%s'\n", format);
+	priv->format = i;
+	return 0;
 }
 
 static void sun50i_a100_ledc_set_format(struct sun50i_a100_ledc *priv)
-- 
2.43.0.rc1.1336.g36b5255a03ac


