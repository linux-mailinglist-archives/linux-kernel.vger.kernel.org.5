Return-Path: <linux-kernel+bounces-128612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF22C895D11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653481F245EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E583D15E1E8;
	Tue,  2 Apr 2024 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeIFZCVa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834F15D5AF;
	Tue,  2 Apr 2024 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087599; cv=none; b=JjLDapFSD2WzG4MuAHEo1e24Hu9SltZU2j+fqQkWMO5sRn14ocTjnNIUGmgHqa3Fcr2iKrI2Yz37dv5qOTJLJmAxA6Nq8Qn0TYoVWOQKMvogxmljmJIhtoo+dW7YM1ahPaz8hQzSuTgji1FgSgwKoqz+FQwDO/PxGqHITA9bMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087599; c=relaxed/simple;
	bh=n8VkQDEUtV5+Oh39C+hut59NEcsvenhzLvwxnXGx6ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5DS2osCOykdeJfTWtzxUVroEwy5ERmrtUXqgAWlkMltXiPlKc9Behn3InF/LoL1r+5SWoZL21+k/dRjlLScw9fIEXEuROorRxvyMnNZw816EO4ZOgiUAJfnZmW4K0kV93UqmBKfHGHM7DMYUgCsGhJgusktmihjPCTuKp936SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeIFZCVa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087598; x=1743623598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n8VkQDEUtV5+Oh39C+hut59NEcsvenhzLvwxnXGx6ZY=;
  b=VeIFZCVaaPw4i+uMJxXMy/NKhAagTL/YhH4dLftb/OA5qzzOTZNggjcI
   Eu6Al7vBZshR2gD3AKCNjvCXyxz92Cue/FdMp/H2Q2hcrvsiDOLcnkZWJ
   WT3FyuWdH3rNsChArY5rWOXO5Qi99hiTu5+NUHQCjcKWrbJrWpHcbzzk5
   E8w5DyPS+fNeObwgHg64nd1/eBj60o/q7KtRVUZo9SR5WE6bFGIbNyw5t
   JX+OhcbtzSg/zJ+CVe01abCqxCK6Zynn0tmf+h2nMnNI//mrpV+qxNGKM
   MyOWcqDAmPdQwhf1LNns3U1JxJa/ivk1x9aPpcgo4F/HwO8Tw3fQZuSKo
   g==;
X-CSE-ConnectionGUID: mpQQmDFPTRKFl2Wh5FvQNA==
X-CSE-MsgGUID: Wi1SlnYvSweQLduk+kR8zQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7151001"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7151001"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083786"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083786"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CC9D8525; Tue,  2 Apr 2024 22:53:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 03/16] serial: max3100: Fix bitwise types
Date: Tue,  2 Apr 2024 22:50:30 +0300
Message-ID: <20240402195306.269276-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
References: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse is not happy about misuse of bitwise types:

  .../max3100.c:194:13: warning: incorrect type in assignment (different base types)
  .../max3100.c:194:13:    expected unsigned short [addressable] [usertype] etx
  .../max3100.c:194:13:    got restricted __be16 [usertype]
  .../max3100.c:202:15: warning: cast to restricted __be16

Fix this by choosing proper types for the respective variables.

Fixes: 7831d56b0a35 ("tty: MAX3100")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index b3e63b6a402e..3d2b83d6ab51 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -45,6 +45,9 @@
 #include <linux/freezer.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/types.h>
+
+#include <asm/unaligned.h>
 
 #include <linux/serial_max3100.h>
 
@@ -191,7 +194,7 @@ static void max3100_timeout(struct timer_list *t)
 static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
 {
 	struct spi_message message;
-	u16 etx, erx;
+	__be16 etx, erx;
 	int status;
 	struct spi_transfer tran = {
 		.tx_buf = &etx,
-- 
2.43.0.rc1.1.gbec44491f096


