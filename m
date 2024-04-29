Return-Path: <linux-kernel+bounces-162202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F1C8B578B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937A81C20298
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC7876405;
	Mon, 29 Apr 2024 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqAKCN0e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E8574C07
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392579; cv=none; b=WXR86EpevLicWfJqsbwF+UESylnqSx16WyBe8VpUhrYgvSdmImwtAhk5DQcl2m75LTY1YyLxuxNNhTBf9aNHL47sL7aqr1D1ZZcZX2u/l4rUHgzfUmzlqQIj64XYB9E84NghaM9MSDSQiaj9CsUqEBhNTYnm2e+K1BrJiOUIKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392579; c=relaxed/simple;
	bh=6oEQ8SmB24y33MxFtl+D/rMkW5uAGu9qGTWbUveLuYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqDoHhbbZUijIQL5Q3xRo2IOQ9i7bBZskJ/Yixz12Fh+52YXLnFmzyp7XSe8P59iHNc8e1MbU125SBxbyJSAMNlR6/+NDSC2UtfzvL98mTi1F6Jeg3Lf4DoaQrgtZNLCRPDVXuOcetYRegfS/ZW52ig0RRS3d7ElUtlBMgkeexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqAKCN0e; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392578; x=1745928578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6oEQ8SmB24y33MxFtl+D/rMkW5uAGu9qGTWbUveLuYk=;
  b=fqAKCN0etbtcUrCg7LnJqAJTnunHAHdUx1vzYCxJ0qn2A6RjQdsDQAFf
   j5NKkXdCD/Owe52/AfnOcFznL4L6s5eDSGJKxL1hK4cK7brGqu0JDCYQU
   D87cMRKx2R+FIslqa7gJHpew2HWLQTC/zyLDx+rsw/K2k255d11Y5snjt
   FVkBwMFaU1uZVYqTj1FKUAzP3iA2g1lg0v8D71EwGzfumjmP9McSKyUyh
   1ZWnR+Zqk89G6YZUMYNK8DeTrynUoZ0BKzDHecsHWSBkOffdxHx2WsKg1
   wOKGe/+04l/PeeAoaFkDYQeorFKohhA31OTs7Ya9Tg6OVfJqPR9+CYd+o
   g==;
X-CSE-ConnectionGUID: kHiAWewdQ+i8J4qSANSgrA==
X-CSE-MsgGUID: Rp/VGpBTR1ad43a1trSGyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908283"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908283"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:38 -0700
X-CSE-ConnectionGUID: +fqvG9R1Rmus9DGVjPtRQw==
X-CSE-MsgGUID: slNfCorNR06f6euAjbpI4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166660"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:36 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 12/14] intel_th: pci: Add Meteor Lake-S support
Date: Mon, 29 Apr 2024 15:09:06 +0300
Message-ID: <20240429120908.3723458-13-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
References: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
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


