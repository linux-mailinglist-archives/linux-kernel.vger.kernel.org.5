Return-Path: <linux-kernel+bounces-162316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878BE8B594B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DF2289958
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BA28121F;
	Mon, 29 Apr 2024 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiI0IzXt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EAC8060A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395729; cv=none; b=Y4Wo7L7SniUJw3R3op+CE3Vt62DAIWqJCCaJ14m9WdYsPREqpaSupiS2QRF2Jrv7iS0KsssgsWgu68XOOmMUyTbG/3fGr1iVZnJN/XBZdu9Ze4cm9FTQlJ3SR6S3WCmDkFfT9i6TICPJxiObRMYsMO4XTBkseHGgZHkMlyv/12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395729; c=relaxed/simple;
	bh=6oEQ8SmB24y33MxFtl+D/rMkW5uAGu9qGTWbUveLuYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1WgJ7GKlIKC7jeLQVW+ZT//mGX4+GyKZp9rti3eoFi8joU9OShNKuxxMXoW638/CG89q6/TQzD2msbIr5xUn5JDEdTFSnU+kfLaOv2ZcF/w4xU/6M7TLUzK6KRYgWLB1ChUaENLAthD6fXu7xGZE2ZCw7vFJvjUASTmAHEyVys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiI0IzXt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395728; x=1745931728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6oEQ8SmB24y33MxFtl+D/rMkW5uAGu9qGTWbUveLuYk=;
  b=SiI0IzXti8bBwG1QeNOW/gaq/jaGAq+0qzNCZqaubX65hftYiJUtlfkN
   fGwO6hUps0XYzS5lE7RLHXFVpTpVn7bcQHJDDZEYmyDylOalTFP+L3ctE
   2kIVcqCDuANGTygVqoOuQ3yPWzKAyMZJ6s8jQbM8VgWPZEhpCmaFDpFij
   9yRXhIt9tV8fEhDmzwU6qvo7CnbeXI0eHvg1oobtqkf78cstujzioV1jh
   +LITQEh3C2DQvoRS7UM7mFi5oX1CcA+qbkMvsgJjxQsYANqTTX8gND1iX
   es+4WHILKABDdDVL/AxfUJcRrWeYCEcoS7Of00UmbtYYKBADUDQIscdUl
   A==;
X-CSE-ConnectionGUID: WhZD3Os+ShSfrG0guuiyQA==
X-CSE-MsgGUID: sZJwrwc4Rxi8Kr9CKixc5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986967"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986967"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:02:08 -0700
X-CSE-ConnectionGUID: OVy405HkRWmQBAoOhQC/xA==
X-CSE-MsgGUID: fDqrNWCLQBqSxcw8fAjkNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507206"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:02:05 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH v1 13/15] intel_th: pci: Add Meteor Lake-S support
Date: Mon, 29 Apr 2024 16:01:17 +0300
Message-ID: <20240429130119.1518073-14-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
References: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Trace Hub in Meteor Lake-S.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 08c956fb4995..7bb50d414027 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -289,6 +289,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7e24),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Meteor Lake-S */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7f26),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Raptor Lake-S */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7a26),
-- 
2.43.0


