Return-Path: <linux-kernel+bounces-167945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3C08BB170
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B362842B9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865F0157A61;
	Fri,  3 May 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6t5SzR3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD3A6FDC;
	Fri,  3 May 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756115; cv=none; b=bjc2SiXRrCZq5eAMeycuoMS4xZoFrN3Yp+WA0b9y6JP5Uq3OgS96eA+Sv1Odd1xGyXwUYJXEF0NlMuESwQrLXpnr/n/qHoVJCU4n4gNRCILAMfuTr0ndzXaO+AFaY93xBWHGNLD1lymZqH+Avbe8C0FbArP+sp5xkLEpQNaBqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756115; c=relaxed/simple;
	bh=kgnQClOvEvPony1dM6m9fceZQj8RktP5EO7t0n17OHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CR0oz5B6Nu/ePy4pUdwi/W0yph7rP/nb2Y+GNF1Y8+YvJbKPohQUVL0NmhJiX4AYG+gH7cfWAZaaCoFnd8fSrmWZ6mvdjmBUFdz0cXDysEqxHBZB8ODuPgCUYUALnp6PaDnlKR/sdacG9z6z753FJj9FTpiyV5a/4oQTRQ9C6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6t5SzR3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756114; x=1746292114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kgnQClOvEvPony1dM6m9fceZQj8RktP5EO7t0n17OHI=;
  b=d6t5SzR3Vk7L0IPuknt2r2RcDJyWzDZ78vzeaz7R5x0TW2H6cQf2oo1r
   tGPQLHX5Zk4D0hAvPkIXJw+cuoZvatDmhkVMmb786q4dCwpmUP8I9tvMk
   RflAwiNDlzY41RXe7t+0QYRrE98tS8MXCRjXC5Upbu6vdnOT8GVkutCQs
   EmdSbBqIjs8WChGsn+oWuJGWdoDNaRnHn4hJwJs31CdawXO3oWVEpVxeP
   bqDcx+7ZfzC/DWf++ubbbMa2w3i02DvAQPILPpdI5i8GPObA8n5erWo7w
   uCRohIh3GjQITPiJuRCFRYQkouPvjYkRsHhbR9l5hmM3xtUdPNLi9GuA6
   g==;
X-CSE-ConnectionGUID: 98x4AG3oT02rLIexeamOYQ==
X-CSE-MsgGUID: sP3x8rNMRhO0rxuVKihnkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="11106551"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="11106551"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:08:33 -0700
X-CSE-ConnectionGUID: 4QA1jk05SuS9MQLPaW7Pgg==
X-CSE-MsgGUID: 5f3IJkfrTk2PHf1ST9048g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="58412436"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 May 2024 10:08:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1FCEB1C7; Fri,  3 May 2024 20:08:29 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/1] spi: bitbang: Add missing MODULE_DESCRIPTION()
Date: Fri,  3 May 2024 20:07:47 +0300
Message-ID: <20240503170827.2920457-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The modpost script is not happy

  WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-bitbang.o

because there is a missing module description.

Add it to the module.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: dropped terminology changes as they are out of scope of this one
 drivers/spi/spi-bitbang.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index c11af39c9842..998b52c9da92 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -451,4 +451,4 @@ void spi_bitbang_stop(struct spi_bitbang *bitbang)
 EXPORT_SYMBOL_GPL(spi_bitbang_stop);
 
 MODULE_LICENSE("GPL");
-
+MODULE_DESCRIPTION("Utilities for Bitbanging SPI host controllers");
-- 
2.43.0.rc1.1336.g36b5255a03ac


