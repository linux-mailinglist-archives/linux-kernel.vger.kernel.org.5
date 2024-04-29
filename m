Return-Path: <linux-kernel+bounces-162314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F2D8B594A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A70328928C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DB57F7DB;
	Mon, 29 Apr 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msvPWP39"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9E7D414
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395725; cv=none; b=DNMJhmjPQyOpXEJUfO28SmJORGr1pahCco8lt3zQsOWrryI84bKVSvzH3rpxfEHNgcuYegTF+MUqG+w/vwYquUFhADEAdFIUyLXCaEZqkxC51xYaiakQQXE6Hm/SbjBc8/JI/BSGpY7w2ro1J4EfFQtH983f7chXix7aonng2LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395725; c=relaxed/simple;
	bh=bxIRmwYGyryCI32YPKm+QfLssD8VLAYd6uQrJuFO2ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYWykTzd12bX+34geFAudMj5RhtfARN4rBpX4/Ks7ZiqkwdG6rvfSe+JOvKogru5TEIDAhxJen4DD3cN3ubTniuCmbTLmmSopnB6eDt+B7oHBLIPLl1mzI7wcdouCJ5oHhGBn24cMQZUAIlrtWblwIbDSNLIR9twnjj5OXcnTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msvPWP39; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395724; x=1745931724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bxIRmwYGyryCI32YPKm+QfLssD8VLAYd6uQrJuFO2ko=;
  b=msvPWP392qYoXRHxR0y4JKsCcGzkiDxNmG2rgs6cBQoycl6SvBzd5/qF
   nX4l7EWP25fk1T5FSUU15v95og73Kcni66T2m5nHiLyeyam8+BNzNgo8+
   abMQMmadkT/ngFmX+mcbrMxjRJxYDDAW16J9cTn8r7VLejrcP+q3GEf+u
   bOPbxrOxWez/53UQuraE9sCw1N99zqnQdUmv3BKvZTVxbacOWz4m5uaxi
   Kldg8STZ2R6RDDYVkZQ3BVZbb6s8U8z5ZRpQF2HZAG96kNk8WZBcIwblq
   g6WcHpaGqZgwTGUhsgWiJf4bcBITGRRA+Wywd1+GMcEsVQCkFwkaSt9vf
   w==;
X-CSE-ConnectionGUID: bjYAnKjDSr6t7sx0D4f27Q==
X-CSE-MsgGUID: oEjT9ntvTsafzWfYYG+E9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986944"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986944"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:02:04 -0700
X-CSE-ConnectionGUID: q2RJV0q8SMyBFnh+XbYcmQ==
X-CSE-MsgGUID: o0vrrZRARmKRRTPGJjGGbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507194"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:02:01 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH v1 11/15] intel_th: pci: Add Granite Rapids SOC support
Date: Mon, 29 Apr 2024 16:01:15 +0300
Message-ID: <20240429130119.1518073-12-alexander.shishkin@linux.intel.com>
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

Add support for the Trace Hub in Granite Rapids SOC.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index beb4b2766aae..44c08db253d8 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -304,6 +304,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0963),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Granite Rapids SOC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3256),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
-- 
2.43.0


