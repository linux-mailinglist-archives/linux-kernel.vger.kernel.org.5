Return-Path: <linux-kernel+bounces-166589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564898B9CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD20E2860ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6750215AAA4;
	Thu,  2 May 2024 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzHwtzpI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED034155754;
	Thu,  2 May 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661203; cv=none; b=smEeDdjbjM+ur3HOWJFlZKHptz8xg57Vi95DZ/qOPyE2jFxtgNTNFzZoqhrvF4cM1kKI/33OcBOblIC6w4j0Na0evkpHemgsWK52Ctp6jZts42e9sOs9NtilbdxE2PnupUqnpAfbLmG678AyYaLgJaqvDeSquQIJHwmcgyGTyZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661203; c=relaxed/simple;
	bh=5DuY6WAqhp93PuCEXWGtdXgyMtCRkfRxNV8OoPPbmFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R916URJFkT12sdbqT0sfo+b5DFA7QVcADCR6TG7JbaqMySmfEevhYmsI8qApWhizhUxCtfd/bwBjur6t92bvub8Y4t9ozriqHS1yPKwOMeXTaVPUVv57pppLLDu52C58InpubrLHa3QwD2BPgzBAoWAP8gSDsxyZjrriKjstydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzHwtzpI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714661202; x=1746197202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5DuY6WAqhp93PuCEXWGtdXgyMtCRkfRxNV8OoPPbmFw=;
  b=BzHwtzpIj/Q7lIzqDc1qKrbshA5DBrOUUbOrRx9iF90NtCm8VjPbco7R
   10HOcOjwsesObBK1l4t0wK1PlvDU9TtyKMZw36XKUzRgp35cp3dw3FLk3
   zNTfa0+J9nRMC5DHYQAt2pii2Fth0n9ljxy4TfYCNYJ474CHQI9AKt4U8
   IW1dZdbrH6WKgZxI50Hg+Ns3ojUL925hCPWDyCNR97GZF5RV3YYRFKjor
   V/89gOitJ0WRBPBiLHdAxLWSOBfnddpErk7zGJ3dR0Q8Xv6PfPY4C4BFK
   5hlgZ+RSectAdcbGkKUQCaFapuM+X8xOjwDfADF7syVM1gzKOlGiUQqLA
   w==;
X-CSE-ConnectionGUID: FeMKodL1SMG/Y8EOGl3slA==
X-CSE-MsgGUID: 8igCV2YmRM6alVirLeCdfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10306114"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10306114"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 07:46:36 -0700
X-CSE-ConnectionGUID: qJ8afCjLRHqiHGILVtcUxw==
X-CSE-MsgGUID: kCr9v5D4RFqX2hhhss3x1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31632847"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 02 May 2024 07:46:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 62589D7B; Thu,  2 May 2024 17:46:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 13/13] serial: 8250_exar: Keep the includes sorted
Date: Thu,  2 May 2024 17:44:07 +0300
Message-ID: <20240502144626.2716994-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
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
index 6764aaa20df2..dd179a291594 100644
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


