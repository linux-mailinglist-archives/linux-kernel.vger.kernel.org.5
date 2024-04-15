Return-Path: <linux-kernel+bounces-145333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2A8A52EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB0E1F2100B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A2874E3D;
	Mon, 15 Apr 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkESSmo9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834973175;
	Mon, 15 Apr 2024 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190739; cv=none; b=SwBzYhEHfXsayLpPX0m94K/RzyIsoFdIhfi89dVRP1vqHyGoyDeAGWFPw/MEZZSrGBnLnEMO7JixrZ0oQN5q0vyiq88xXLw8hL3BMNR4eRdz73mkZZYOmc+zH2Qr7ASaENyFq2QgZ0wf+eKr254fjShCZ7m3hrkjTvwSGSV2mVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190739; c=relaxed/simple;
	bh=6ADPjgD9QQhJ43e2oiyLf588Js1OyldkNAhzTKchJME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ItX6BL/qyMcbhrheqtwZE3PU3G495Sx2wkiJLD4acmFlSGYKXERLWEgRAsvnvAb1dcNIeEy857QeYAyNswuUhsR6AfgsEoPEOAifm6iVgQVdA22DnfwKNEyc1naawT6TBnSXZBYNUnB4CkkNoEX4KDALDW3+5t3flaWaBdbZSDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkESSmo9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713190738; x=1744726738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6ADPjgD9QQhJ43e2oiyLf588Js1OyldkNAhzTKchJME=;
  b=fkESSmo9F1JoqZ8fWQ+uEOA6zNb/ang/yH8xOG/ZOMBBfg9tVO/tJecY
   k4MKNUx+K2leTG0j3J5K2nN4pOiWBViFdCsRwhRLw7RDaBDrK11bFIcJZ
   UBzow6RIm9bztDAnmJsJWSPq9hEwj9y4iSVcwqApKu1T51+IMzPYHi4U7
   W5hofvNrjBYv253f21j2iwFb0JrG5TJp4QbJX0XAhtjuGmbKssecgFkXV
   +j8SKRL48QcDHh5wH7xKeAWGHm7i5xjThnGaHSQk1mSVPzXXFCqpuzdu4
   DPKLn7MHfOruFDbdwkrQCuDrwMdQACFzlEuQELb1HWM/N21Nd9k9xoc0r
   w==;
X-CSE-ConnectionGUID: l4xlMDI3QoSeDM7FY0U3tw==
X-CSE-MsgGUID: HksOqgBtRCiTdZM97QwpQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19184626"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="19184626"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 07:18:57 -0700
X-CSE-ConnectionGUID: PXuKd1zlT1q4A8p18SiWPg==
X-CSE-MsgGUID: aMFZxfavRn26xUAd8/9j+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="22026966"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2024 07:18:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DDDCA455; Mon, 15 Apr 2024 17:18:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Martijn Braam <martijn@brixit.nl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: light: stk3310: Drop most likely fake ACPI ID
Date: Mon, 15 Apr 2024 17:18:52 +0300
Message-ID: <20240415141852.853490-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit in question does not proove that ACPI ID exists.
Quite likely it was a cargo cult addition while doint that
for DT-based enumeration.  Drop most likely fake ACPI ID.

Googling for STK3335 gives no useful results in regard to DSDT.

Fixes: 677f16813a92 ("iio: light: stk3310: Add support for stk3335")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/stk3310.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 7b71ad71d78d..08d471438175 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -693,7 +693,6 @@ MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
 static const struct acpi_device_id stk3310_acpi_id[] = {
 	{"STK3310", 0},
 	{"STK3311", 0},
-	{"STK3335", 0},
 	{}
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


