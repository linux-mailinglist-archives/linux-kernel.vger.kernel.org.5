Return-Path: <linux-kernel+bounces-138728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDC289F99A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89971F30165
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2C815EFD2;
	Wed, 10 Apr 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ld28G/CH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E615ADB0;
	Wed, 10 Apr 2024 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758313; cv=none; b=OyDArCv/3dBUukiEZqN3NJCjyLnFp9b5WHb5K8XMoWA0nVMR49QolhG8f2BiM2/V8D6loQeireDzmOjgFGxgupCT/DqYidb5L4l8S+gUaQGgiBIGrK7+crTPP9ZNOeKd2FhQATCXZQe+YMc8P83z9OwpsCAB0M02FdhsMfKoEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758313; c=relaxed/simple;
	bh=sygr61+yPFLUXgEFhp4qbUoHSiqZR3IMEGHe5hFJJ3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qluBTmpjCbGG921tM4K6TtqJ/AFe2tI7Nhijvvqz85J9/Xr2/XVudVs26CaLTpHqieuGPRVxx7ybtFH3gOAcb2ZWWIa0cQXqwY1AYW2elQNX2Cq/boIprgWLbWsDHIej7JsaWvOCQAKyR7MNGRXN6qcUH2ODoWR6SwIyS4uXwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ld28G/CH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712758312; x=1744294312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sygr61+yPFLUXgEFhp4qbUoHSiqZR3IMEGHe5hFJJ3c=;
  b=ld28G/CHqH2NShNdP8Q/MGEkoyUgNUqqXltqnU0Qy4q5D1bK3OzREACK
   Z9j2iNFqQcNAmFcN2YSJ9s8bPgcqoRL+4JDUqMTzSY0Nz2YGZVWyXmugK
   5dctiyJYAnQA+FuINbmhDYQTOo06Zu0C9Mr87486LcY7FL8bAPlKvIvF5
   o5n4DR9k177KxkdHbW2w7ts4gWsk65wxKYwUmr6TgacG8BqMIhvb14JEb
   BY3a4BZE2ns9/Q6c0/fn6PluI1d9XqMVPNK0orS0MWuhIiR7T98PBBe8q
   FHCEw8ODeRDQdHiT1c6ns6uN2xAGKopdUFBd3ublE15CUhnF3dQZh+gLw
   g==;
X-CSE-ConnectionGUID: 0XFet8XpRv2I7uMQU36g1A==
X-CSE-MsgGUID: hKILSHlGQE+QxJYveF9xGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19548456"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19548456"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 07:11:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937095145"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="937095145"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 07:11:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8AC8F161; Wed, 10 Apr 2024 17:11:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: max3100: Convert to_max3100_port() to be static inline
Date: Wed, 10 Apr 2024 17:11:35 +0300
Message-ID: <20240410141135.1378948-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Jiri rightfully pointed out the current to_max3100_port() macro
implementation is fragile in a sense that it expects the variable
name to be port, otherwise it blow up the build.

Change this to be static inline to prevent bad compilation.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 1e6b5763ce3f..07ee001640bb 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -111,7 +111,10 @@ struct max3100_port {
 	struct timer_list	timer;
 };
 
-#define to_max3100_port(port)	container_of(port, struct max3100_port, port)
+static inline struct max3100_port *to_max3100_port(struct uart_port *port)
+{
+	return container_of(port, struct max3100_port, port);
+}
 
 static struct max3100_port *max3100s[MAX_MAX3100]; /* the chips */
 static DEFINE_MUTEX(max3100s_lock);		   /* race on probe */
-- 
2.43.0.rc1.1.gbec44491f096


