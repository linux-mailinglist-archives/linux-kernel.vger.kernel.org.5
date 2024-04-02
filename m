Return-Path: <linux-kernel+bounces-128270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF7895881
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71381F256CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B7D13E3EF;
	Tue,  2 Apr 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBP7VhyT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86613A890;
	Tue,  2 Apr 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072557; cv=none; b=Jj7TRjb0xJEeHmwqC1B2+G8Ow+u8rA7LMzGRpqD2DCiSRCNmHw8DTcQsIpsnmSnQDtnHVVSI6vr2T/ZRb8oxHhR87kftO0R0th93qWj+2Bti/FSvIPdpSd0pYCGKr7EjLER22AAViQnLYGc+XxxdjCysuDnEdZe3vXZljmyYLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072557; c=relaxed/simple;
	bh=Pzd4zF55D0Q5tN3ZT/f+vvK1+li7w9jn5Gn98hnh/Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICHBmyuohMRZlodt1DOr5/7a7jmUTTbNAMiYImMDDRxGs6Jq46hFIx1Le2FmEjo2m5MQFUQyxXKvRcsTGlulFeeQyt8G9yeGPwhxPvd6rLCc4gff+pHe3hbs1fnp2bT/pm0W4gouq7XonrAfHcJeQ8yDqBhnLBRJ+E7Ib36YIMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBP7VhyT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072555; x=1743608555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pzd4zF55D0Q5tN3ZT/f+vvK1+li7w9jn5Gn98hnh/Tk=;
  b=nBP7VhyTTRyoCcONpmr8jmQ6qOIWoW42Q4Lzz2huPYZKgAk/PiPgGsTs
   kzAX5wB7bQrR3mz74qEB0BcbCmDiGA8G7M5l8C6SZKv4LUHvd+b8ycNUO
   oI5VQWQj0W5M+BLcbZZskLqNXEbG+xssUMX9TwVuzuYqaJ7eKQkah1M5+
   OjudtXhbHPDixLKasnbYJRwTjutPzoCHkZDoGQGNyXJlWQsIuwfNdCj/l
   1tIIlU3U7IzwSlrldSgvj+hCPXc017x/TY8Ub78iMHS29bHXpGZvmnMjv
   CPK1v4cpZxurdibIoxBlUVBgC8sa2r5AM0hE3Vu6TM0TBOe66xnZBzJq7
   A==;
X-CSE-ConnectionGUID: kSOzQfISRcWO2NZSh8cLCg==
X-CSE-MsgGUID: CHzj9OOQRYiAGGoK6ahx1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870099"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870099"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083651"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083651"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E0BC016EF; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 16/16] serial: max3100: Update Kconfig entry
Date: Tue,  2 Apr 2024 18:38:22 +0300
Message-ID: <20240402154219.3583679-17-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver actually supports more than one chip.
Update Kconfig entry to list the supported chips.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e636a51eb7b6..dcb67c40bf92 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -307,11 +307,14 @@ config SERIAL_TEGRA_TCU_CONSOLE
 	  If unsure, say Y.
 
 config SERIAL_MAX3100
-	tristate "MAX3100 support"
+	tristate "MAX3100/3110/3111/3222 support"
 	depends on SPI
 	select SERIAL_CORE
 	help
-	  MAX3100 chip support
+	  This selects support for an advanced UART from Maxim.
+	  Supported ICs are MAX3100, MAX3110, MAX3111, MAX3222.
+
+	  Say Y here if you want to support these ICs.
 
 config SERIAL_MAX310X
 	tristate "MAX310X support"
-- 
2.43.0.rc1.1.gbec44491f096


