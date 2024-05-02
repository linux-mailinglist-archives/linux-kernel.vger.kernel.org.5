Return-Path: <linux-kernel+bounces-166580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7F08B9CA9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13381F21B84
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AA215359C;
	Thu,  2 May 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzbQefYl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5913C68D;
	Thu,  2 May 2024 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661195; cv=none; b=blSy5BuKTPjIPosOqgjXkSaQKwGGKR2WY19K2XX8Jc2ZWJKxlwrPFmORoUZ9oi1fyIYAp9c5QHi/PFnDf4y8I+YzLDg2lyoLkDLOHzkz5aQrxfQN4lj4WKfm92Ha0tL5NSObTMwGXV9nxWktcQkriFv2HfQXSAIGz1PsBcekIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661195; c=relaxed/simple;
	bh=XptqbUg5xNIQKmQKuni+sa4YXQiyH4WIn+t4Dt1W1MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2OWXSetx1RnLpe/7/uZFr5v4p+XqOSPbYO4LDLv7LwQBQL3sU0sIgiP61XWsv5dNC3B5EcdFp65jdQevRRpQM/tqd8EAFQJ2+KFdVbsZ2ywFiC110yKhfjckxxlKP+ZJGSPLqbkJW/5wREkV3MKYeWFsxMiuYjmx2AUKvVLRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzbQefYl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714661194; x=1746197194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XptqbUg5xNIQKmQKuni+sa4YXQiyH4WIn+t4Dt1W1MA=;
  b=TzbQefYlZfoO4Ied6SJD86PSCr3VjWq7dCi0jyiB1DRZ+/lnwP84omaB
   YYWJycfkECXnbxhoMywYIN+8d+fL7B3DNsn50ZoaT8uTp4kaD+q1863mI
   C7/kCQKWSsGJWR0PCfEPWBKB6yoQ0MXnunv7wluKcc5XdQtSgPe3Ilfw3
   OB6BocLi+VDgs6e8wqQKv2EPT8991g+ahVRP6apSRcyjpUcj7NHB/ENa1
   nkV4qCC8zmDrvVfv0jzo9yPz9NFW4SLu/NaTJ4+kslF9wiCF8CdlUIMXo
   Cy/mYfmpPV21VhESmJxDQVc/vGIwvy7IA6auJsxeN/h3hH4xgoNd3B2tu
   g==;
X-CSE-ConnectionGUID: vHCHbcF2Tti5eRWqocDCGQ==
X-CSE-MsgGUID: Hx/Ip/E3QcqrTQeqT/oNvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10306065"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10306065"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 07:46:33 -0700
X-CSE-ConnectionGUID: qIjp9/dATeyAA7Ij6nuAeA==
X-CSE-MsgGUID: ivJ0cS98Tg2/N32pmd+ugQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31632823"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 02 May 2024 07:46:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B087817E; Thu,  2 May 2024 17:46:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 00/13] serial: 8250_exar: Clean up the driver
Date: Thu,  2 May 2024 17:43:54 +0300
Message-ID: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a rework for CONNTECH was done, the driver may need a bit of
love in order to become less verbose (in terms of indentation and
code duplication) and hence easier to read.

This clean up series fixes a couple of (not so critical) issues and
cleans up the recently added code. No functional change indented by
the cleaning up part.

Andy Shevchenko (13):
  serial: 8250_exar: Don't return positive values as error codes
  serial: 8250_exar: Describe all parameters in kernel doc
  serial: 8250_exar: Kill CTI_PCI_DEVICE()
  serial: 8250_exar: Use PCI_SUBVENDOR_ID_IBM for subvendor ID
  serial: 8250_exar: Trivia typo fixes
  serial: 8250_exar: Extract cti_board_init_osc_freq() helper
  serial: 8250_exar: Kill unneeded ->board_init()
  serial: 8250_exar: Decrease indentation level
  serial: 8250_exar: Return directly from switch-cases
  serial: 8250_exar: Switch to use dev_err_probe()
  serial: 8250_exar: Use BIT() in exar_ee_read()
  serial: 8250_exar: Make type of bit the same in exar_ee_*_bit()
  serial: 8250_exar: Keep the includes sorted

 drivers/tty/serial/8250/8250_exar.c | 454 ++++++++++++----------------
 1 file changed, 200 insertions(+), 254 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


