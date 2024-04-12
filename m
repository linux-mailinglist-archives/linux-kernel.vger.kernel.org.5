Return-Path: <linux-kernel+bounces-143127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDAB8A34B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1861C22D02
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C8114F117;
	Fri, 12 Apr 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1NG5SPd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421214D44F;
	Fri, 12 Apr 2024 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943047; cv=none; b=JhlIx09WRzU5zdViSxvMJzdwtPwc6aCvG9GRP9PqfBo0nNvengnGNo5oCNBGKzoEQ6k3wW51oOd7LvswnHxQumbA21b3Ho/sebxFLj9P0tzA9Y5+F6VTdwoN9c2mfcZ7UdpnbPi/JoYpqVqQ7AXFj0HJJ7tFgBpoGKV4cYzNa74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943047; c=relaxed/simple;
	bh=53VPmLYStvI4gEILOZdjzTXxl1Rvmbkp0Ro+tl8CTdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rnWMog3wxeKH+lq72/m4ekyN0ADbKh52ySklN90HoTY3/L3zreHR5Pum6RIsg956uZMVB5YOL4Xq/as5C7Ln8LXv1TnMKOhK3j22AGD2WcwmwHRbUcLW0QkqAWz/ElphC4tkMPn+uRIGG/JMpCqyol9RreQWvqCduwkntpp4HLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1NG5SPd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712943047; x=1744479047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=53VPmLYStvI4gEILOZdjzTXxl1Rvmbkp0Ro+tl8CTdM=;
  b=H1NG5SPdvGw5OikyOl6Xtz1MZSbFhCDlr1GNbcK33CRiDApgEvKdO7bb
   aQwmRH0dnG3zcA+rtX8sw7qBymKkLYI1pio9O7/BLWtRHpfrCkeC0vdhI
   wCNALystGcV/L3gAfwyhd0SLGdwGAVH2nnCL5C6gZHT2O1w8rwWsNuCvE
   DJVM4h9sOTe8DmmTETvyoFLC/F1CKqvv8AiFT2eSi6RPvIBU3FrhrRy8P
   iScRj7Gt+KYW8IsWAS5kmXdZhIUrn9B8dO5ExAW5/xnfLxwcoDbhBPFjf
   tipQFNBmsOzY7U2TUNcKBeIP1Yz7gp6w/D9HLqtYuNm2kHbZDAEBBiVTy
   w==;
X-CSE-ConnectionGUID: hMQT4+R1RICs3OGxhFwrjg==
X-CSE-MsgGUID: vRIzfe73R0+vgfLYsolRCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="11365689"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="11365689"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:30:43 -0700
X-CSE-ConnectionGUID: BId4IbBrRS2kytb9eccrjQ==
X-CSE-MsgGUID: movp/L6LQHq5WdRBvF4hNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21780775"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:30:42 -0700
From: Jithu Joseph <jithu.joseph@intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	markgross@kernel.org
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	jithu.joseph@intel.com,
	ashok.raj@intel.com,
	tony.luck@intel.com,
	rostedt@goodmis.org,
	sathyanarayanan.kuppuswamy@intel.com,
	ravi.v.shankar@intel.com,
	patches@lists.linux.dev
Subject: [PATCH 2/3] platform/x86/intel/ifs: trace: display batch num in hex
Date: Fri, 12 Apr 2024 10:23:48 -0700
Message-Id: <20240412172349.544064-3-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412172349.544064-1-jithu.joseph@intel.com>
References: <20240412172349.544064-1-jithu.joseph@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Field Scan test image files are named in ff-mm-ss-<batch02x>.scan
format. Current trace output, prints the batch number in decimal format.

Make it easier to correlate the trace line to a test image file by
showing the batch number also in hex format.

Add 0x prefix to all fields in the trace line to make the type explicit.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 include/trace/events/intel_ifs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
index 8ce2de120f2d..0d88ebf2c980 100644
--- a/include/trace/events/intel_ifs.h
+++ b/include/trace/events/intel_ifs.h
@@ -28,7 +28,7 @@ TRACE_EVENT(ifs_status,
 		__entry->status	= status;
 	),
 
-	TP_printk("batch: %.2d, start: %.4x, stop: %.4x, status: %.16llx",
+	TP_printk("batch: 0x%.2x, start: 0x%.4x, stop: 0x%.4x, status: 0x%.16llx",
 		__entry->batch,
 		__entry->start,
 		__entry->stop,
-- 
2.25.1


