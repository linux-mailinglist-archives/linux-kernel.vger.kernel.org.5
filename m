Return-Path: <linux-kernel+bounces-166581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89108B9CAD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41D31C2199F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF95153BDD;
	Thu,  2 May 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThqCYQDF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DF6153595;
	Thu,  2 May 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661197; cv=none; b=ETSa4JP2GZg51qyggVYHymBy666BGxkC8q8Oz/zPUjOxlt3OI4Oib+vwAzxDro2ViksJ23eDSoAG1MJVuVLDA4hKjbGKjIxspPGDu48TtNOSTILhWt8VaxdGrdUE1W1GHvjfTEIaCCFJ27NOaJAyf6PbvOJIYUkdAI2CFevEVYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661197; c=relaxed/simple;
	bh=t4GElT9Cf8GLEDUkp9KzuLxTLCrrLC4H8X0vZ1KYv78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ9joTKHao51bOntg2faZM4KNy2xoVolTa67D5mGdbIj8/HPgFhD1KCW37HjYI0dbNZrcjHL+bVdROwJDxVBwJRfv8MAi2LmcRW33Mms4NVnKA9Cs6r1on1pd/ZowQgLUC8zXiCo1zbCnVPw9R7yhnU6hV64XqFb0aKD4zavGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThqCYQDF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714661196; x=1746197196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t4GElT9Cf8GLEDUkp9KzuLxTLCrrLC4H8X0vZ1KYv78=;
  b=ThqCYQDFUOlrNiGxLtw33KUmNRnPYKyMnMiKj9ewXTUUG17m/ULFle7A
   kbut+qZE7qW1jsQKSmm3N1/LNUVOnwaq9hG8KR5VEkWj0CqgYuCY8l343
   JzHj15LBz0izDtkWhg8mDVA9wvhm6BimJl4jZncB/p7HjnwepRtvluH/X
   Fi1JuyKyh+kom26fbSq7MKf1NYFzJR4WYHrO0O1skpI+6QE4Zgy0UsGw/
   BF7bn9rsy+uszjM99s5rpCrGAdkWdti7L69DLVrTyVOSXwVaxpvQjMbXh
   kX0W7vYS3iioj6lu9Y9jmlpEc4nnTtdFKUZrJVqnAWqxkPVugO/GruwV4
   Q==;
X-CSE-ConnectionGUID: mQZsRzl1TtWPFyU4JW49Ng==
X-CSE-MsgGUID: vKaX7NizSpmLJAmNTM7hMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10306067"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10306067"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 07:46:33 -0700
X-CSE-ConnectionGUID: vRzOV0x3Rh2SfIeOYYrczw==
X-CSE-MsgGUID: bPR2IJ0GT2Wt+HPIdtznag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31632826"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 02 May 2024 07:46:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C03DC161; Thu,  2 May 2024 17:46:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 01/13] serial: 8250_exar: Don't return positive values as error codes
Date: Thu,  2 May 2024 17:43:55 +0300
Message-ID: <20240502144626.2716994-2-andriy.shevchenko@linux.intel.com>
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

PCI core may return positive codes for the specific errors.
There is a special API to convert them to negative stanrard ones.
Use that API to avoid returning positive values as error codes.

Fixes: f7ce07062988 ("serial: exar: add CTI specific setup code")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 5e42558cbb01..9930668610ca 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -1162,12 +1162,12 @@ static int cti_board_init_fpga(struct exar8250 *priv, struct pci_dev *pcidev)
 	// Enable external interrupts in special cfg space register
 	ret = pci_read_config_word(pcidev, CTI_FPGA_CFG_INT_EN_REG, &cfg_val);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 
 	cfg_val |= CTI_FPGA_CFG_INT_EN_EXT_BIT;
 	ret = pci_write_config_word(pcidev, CTI_FPGA_CFG_INT_EN_REG, cfg_val);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 
 	// RS485 gate needs to be enabled; otherwise RTS/CTS will not work
 	exar_write_reg(priv, CTI_FPGA_RS485_IO_REG, 0x01);
-- 
2.43.0.rc1.1336.g36b5255a03ac


