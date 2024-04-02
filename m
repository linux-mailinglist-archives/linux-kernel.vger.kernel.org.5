Return-Path: <linux-kernel+bounces-128255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02B4895861
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67D01B23DA9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA3013342E;
	Tue,  2 Apr 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKJUSJCx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D0131753;
	Tue,  2 Apr 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072546; cv=none; b=mABQjxGYxXbxQgxd334CqlvTEN7DLKPhYk2oQR5b9+y33RS3qlQPI1PmsVyA3IcTRlvy9fKl6fg8Lprt0WoA0ttoxrDjDw9n7rDDAZeTzmf+1qw5qCBTQcFTb87HxzY7K//oM93js2PXC4HUFpPvqR73IFUPXSgjaUMzBrfbrLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072546; c=relaxed/simple;
	bh=2/PWeuWesUzausxl//V13vqLBKaXiwUc4zo7E78hC44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u1IHl1cAV4TBK1QGppLC21ymAQ1Y809UBJB6btFs+OsRupNngQcljBBFDQv/gEIEAUh0wJkbcr0bKwr6RLLyNk6dQOJDfG023kFDWSIeRAEYzDL+qk67atHk+kjAkEBbb5NSjsRUmNqg5uhBkxeIIYIwBCWbWSI3wdaBiFC5xYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKJUSJCx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072545; x=1743608545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2/PWeuWesUzausxl//V13vqLBKaXiwUc4zo7E78hC44=;
  b=oKJUSJCxFyjN5UaqWIOvCVxj15hnQgwIqlh14SoHmW6cXONLlSUh3ieD
   s7y4kYvJqtI/ZXqYBGZ9p1DX7td2/uLTZWbV5cXn1LufLd5t2NlPl+aNT
   9uhdkNr7O0lq4kSG7WsYGXmbJnZosWDEwJ2KumUjQFKql+jNWg5c4mBpQ
   6Q48AN5gVWUuWRVf7a2WOufpNdRTvk/QSKIqgnTkRTesfCMttdSo1LzFj
   FZgfRVPGsgR+Yg8CnPlP4HtmtODi/fXeCsT28lD7uWQhYtmvhNWgUTUct
   dhSnRA2vai/Z476KqEYrUvpyzQZMg7+SIRH0gKo9iSQkLmrsQPIBSGLFh
   w==;
X-CSE-ConnectionGUID: dNz+PfqrQyuwugDVdefSOQ==
X-CSE-MsgGUID: hraLqaSNTY6fd8BSPtO3Ng==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870051"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870051"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083637"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083637"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1B4841C5; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 00/16] serial: max3100: Put into shape
Date: Tue,  2 Apr 2024 18:38:06 +0300
Message-ID: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Put the driver into the shape with all new bells and whistles
from the kernel.

The first three patches marked as fixes, but there is no hurry (as it
was for ages like this in the kernel) to pipe them to stable. That's
why I sent all in one series and it's good for tty-next.

Tested on Intel Merrifield with MAX3111e connected.

Andy Shevchenko (16):
  serial: max3100: Lock port->lock when calling uart_handle_cts_change()
  serial: max3100: Update uart_driver_registered on driver removal
  serial: max3100: Fix bitwise types
  serial: max3100: Make struct plat_max3100 local
  serial: max3100: Remove custom HW shutdown support
  serial: max3100: Replace custom polling timeout with standard one
  serial: max3100: Enable TIOCM_LOOP
  serial: max3100: Get crystal frequency via device property
  serial: max3100: Remove duplicating irq field
  serial: max3100: Switch to use dev_err_probe()
  serial: max3100: Replace MODULE_ALIAS() with respective ID tables
  serial: max3100: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
  serial: max3100: Extract to_max3100_port() helper macro
  serial: max3100: Remove unneeded forward declaration
  serial: max3100: Sort headers
  serial: max3100: Update Kconfig entry

 drivers/tty/serial/Kconfig     |   7 +-
 drivers/tty/serial/max3100.c   | 320 +++++++++++++--------------------
 include/linux/serial_max3100.h |  48 -----
 3 files changed, 131 insertions(+), 244 deletions(-)
 delete mode 100644 include/linux/serial_max3100.h

-- 
2.43.0.rc1.1.gbec44491f096


