Return-Path: <linux-kernel+bounces-167971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254498BB1BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74791F244A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F23159562;
	Fri,  3 May 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpO6gdHM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05F158D83;
	Fri,  3 May 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756790; cv=none; b=RJUR6Mzy3/WqK7GxMhiLZ5vdZr4GDvdxo27Ogsp7KsNzpW0QTW+coFRL5r/rRYPu9lhTpxat/3VI9UL6oEeV0K6Lv/pReWSKzJjD2Blrpe8netTm6OqxfRJ8ED6cxgavy8gabSN0c0pXe0blckpm9zs/YsfNc1Z/7/SgHs2RSuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756790; c=relaxed/simple;
	bh=D3jt870yoFvqED61Si69xAWDTepSVEoraL3qTLi/MZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+J5yQ64428XYn2uCCByg9wNKVywl7zYStx2/cR66Ocw3A2QXqPC8M8f7yLutEbEJj/IjFpK97cv982nXRzsjxE5DgSEhaU3dMIeHlFSQbDZeNan8EnbOOLFBuzjwTd7Ay1A4VC84R+3Dw/Cjb0W/D02Mcf1Ae7ny5/2dzDqLn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpO6gdHM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756788; x=1746292788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D3jt870yoFvqED61Si69xAWDTepSVEoraL3qTLi/MZQ=;
  b=JpO6gdHMoKzo/39rggp7cxqzKpcPifvGBOBdc+1LXqczX50VFnuiygPi
   Agn2UhcpaZDcDmI52RaMXZt5pjSSMJ+IFbHFXBA0gSS5ROQ89bUDMQAP3
   Pl2fS9GkzKfUBj5SgxSAMU0cSf3LEL49qwZf+yuRYxY2/DGoow5nFOBSK
   U2qwGWS9U+sl2p0BjT5QStLL0S6+3FwIxaHESq2hlr6p/6sGNJOL7e2mW
   IyWRmNREZaxyyNpoU5lgGZFKM8y6fpEKVpace5Txknm2XKi3k/OnVuUB7
   oOXO+8By4asU4p7D6/iv9DbMxUKz1AR/pvjKGdPA8O91rXSscILehpl8Y
   A==;
X-CSE-ConnectionGUID: 8OtsgXmFR7mtOsWSAgKM9w==
X-CSE-MsgGUID: mM+2mnC5Sh6xJUqLR/wfgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="35962118"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="35962118"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:44 -0700
X-CSE-ConnectionGUID: mzw7Ut4cS1ahZgmqYKBp+w==
X-CSE-MsgGUID: 7cXWdcVsRP25VozkTlFYGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28098220"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 03 May 2024 10:19:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B2076C2A; Fri,  3 May 2024 20:19:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 13/13] serial: 8250_exar: Keep the includes sorted
Date: Fri,  3 May 2024 20:16:05 +0300
Message-ID: <20240503171917.2921250-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the includes sorted.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 85085b73706c..616128254bbd 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -6,6 +6,7 @@
  *
  *  Copyright (C) 2017 Sudip Mukherjee, All Rights Reserved.
  */
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -20,7 +21,6 @@
 #include <linux/property.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <linux/bitfield.h>
 
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


