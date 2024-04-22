Return-Path: <linux-kernel+bounces-153612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DCC8AD060
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11091F229C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B38152530;
	Mon, 22 Apr 2024 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBhhJ31k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE81514E2;
	Mon, 22 Apr 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798795; cv=none; b=DP8KeHP5g0KIu779uOI/2S5P22T0wwHKvXaQUzYmxKOe4LeiOfQyBU6YCr8nuYE9sEITBXQEzmL0YzS0Im5EBrNeyPNPOHd1LmYgTKssfa5a/DdUcGJdkSDNsrx0Pb9fwQwJAOWXngrhw86WZMeuc/f8SmAf5mRtoYF0A9jJAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798795; c=relaxed/simple;
	bh=/AMmdr+oqGTzvdw8xKCcbJi/tBqxLz+UAfz82GEpzP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8sWoLVXNiTHKfBzdIFJjxsMHQPWwBPqXvzzw8bS9g9viB6doorj3jUt1CdgJaCpxYAQwfpkZ1fQkvTJpSEKRtNRCtAvUO4lVY7PTk6KlUNFx1gMEZ1pJj6eUBSrugDZqZBOct/cfC06QVmU1QzTo6Htrf+AvB/6om7c8zJ9Zhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBhhJ31k; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713798793; x=1745334793;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/AMmdr+oqGTzvdw8xKCcbJi/tBqxLz+UAfz82GEpzP0=;
  b=hBhhJ31kDHaORwSFQVHuyDj1zWPaPJB1iETBjl1pRnf55tTFokjm47YI
   Arwph5Ra6o3VIdcK7gzD8HJG/h1HMKzDsjaD0e0JkN7XxrvASqCRXbBJy
   VE5KPeyi7Dsyt/E3CPWzG0YIieSyELV+hTcyR1ufBjoN2lbGNyCBbthtr
   LPPYGETl+4oiAHG0bhw7lDXlMSoDEtcbCC9xejzoHFBp8m8OufkuBKcpI
   56JSriKlLkEDPJnemdafqGtcyyketecD6HredTEJyza/GvcYG3X7puGD1
   uWR8RuyOIZO+CadkrJi2L2A+HHd9cQwBS7r4TnZ1Pk1HtZbz7LXtJHWo1
   w==;
X-CSE-ConnectionGUID: 9dTRe7Y/SYyRGcNGeAMKpw==
X-CSE-MsgGUID: jIaGRcvhQNK3XQumSZegOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9510962"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9510962"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 08:12:43 -0700
X-CSE-ConnectionGUID: SQj5F+0aRPmcMUwEkuq66Q==
X-CSE-MsgGUID: Wypch99BQNux4zms5S08kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24086646"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 22 Apr 2024 08:12:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9FAF8FD; Mon, 22 Apr 2024 18:12:39 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86: classmate-laptop: Add missing MODULE_DESCRIPTION()
Date: Mon, 22 Apr 2024 18:12:38 +0300
Message-ID: <20240422151238.2051330-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The modpost script is not happy

  WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/classmate-laptop.o

because there is a missing module description.

Add it to the module.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/classmate-laptop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 87462e7c6219..fb208c68a7eb 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -13,8 +13,6 @@
 #include <linux/input.h>
 #include <linux/rfkill.h>
 
-MODULE_LICENSE("GPL");
-
 struct cmpc_accel {
 	int sensitivity;
 	int g_select;
@@ -1139,3 +1137,5 @@ static const struct acpi_device_id cmpc_device_ids[] __maybe_unused = {
 };
 
 MODULE_DEVICE_TABLE(acpi, cmpc_device_ids);
+MODULE_DESCRIPTION("Support for Classmate PC ACPI devices");
+MODULE_LICENSE("GPL");
-- 
2.43.0.rc1.1336.g36b5255a03ac


