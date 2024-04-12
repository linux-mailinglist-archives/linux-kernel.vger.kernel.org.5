Return-Path: <linux-kernel+bounces-143126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1D8A34B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A2F1F230F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2530414EC52;
	Fri, 12 Apr 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoPwyqei"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811F14EC4A;
	Fri, 12 Apr 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943047; cv=none; b=eYPu3K+AKLvLtYr9GagvvXNu0bR3tT0tYycGLrF1aLB5FgZdu37sHwn5RH9Jq9eOa3MNDTROxzMYuNwlb3nxgTOwXH/F8DR9P0K1m5IAxNOHhoR+EIK2jlu1qZgwMLZsYMJ4iDo++BK0i5/Y0Phk2/a95cIwwoCyUYMTxCRX4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943047; c=relaxed/simple;
	bh=j6VXfKkHgF7ZyzHZ2Ll+dz8fG0uzNqJxRFoI19lkgis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iyEhlXNIe5t4LCcXGqqReXFLZ+Q7G1UI/cmVSTglb4o3qthbKcW4UgdD/krFLBvvh+qfECPdBWC8JnGJBQJcnsXoG62oqi7eF5naeeztot2M5kj6oUJRZifHRj7KSxyIf3kA0wrOsjLilvJrYXBH4xc76ZACOZMYWYyQhAslQdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoPwyqei; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712943046; x=1744479046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j6VXfKkHgF7ZyzHZ2Ll+dz8fG0uzNqJxRFoI19lkgis=;
  b=MoPwyqeilSjcpgiyx8NLkN11ERPW9ccH7hEPPx9EEygBdcInDYHH6uka
   wNDdkRsfcr9BHxQdq1SH5X+cDDRxPjkfCLfU5hkmjUvV3o5eBQoXLQZWy
   NgKfxCJQeQ21UKv0WEKo/3X/L1Dvs6IPeXYq4Uw8SqUH984NE5g7ul7dI
   fgxzlJxkLCw8dNxE4V0jkFT6MjZoaMdSJUBVERVZLZrWrYnq3jYCw+pMC
   /JYZ8ShEXQPTPpcEWXqI7wwxMJWsNBCfa7rOdDW+ixYE036VpGTClP4EU
   At8TPEH7TZvh5uSjKI0WC3joo1D8iCvhPuogUoCiZRPmIYCY28/PHqt3V
   Q==;
X-CSE-ConnectionGUID: v4K78v4sRcK1IKKbVDMLAg==
X-CSE-MsgGUID: ISFrtysQRwqYFGYyo8OWpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="11365688"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="11365688"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:30:42 -0700
X-CSE-ConnectionGUID: UuBykGrERsmnkS9tg+FQhA==
X-CSE-MsgGUID: 03gP47ICSL2Vn6ax703TzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21780772"
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
Subject: [PATCH 1/3] platform/x86/intel/ifs: Classify error scenarios correctly
Date: Fri, 12 Apr 2024 10:23:47 -0700
Message-Id: <20240412172349.544064-2-jithu.joseph@intel.com>
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

Based on inputs from hardware architects, only "scan signature failures"
should be treated as actual hardware/cpu failure.

Current driver, in addition, classifies "scan controller error" scenario
too as a hardware/cpu failure. Modify the driver to classify this situation
with a more appropriate "untested" status instead of "fail" status.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/platform/x86/intel/ifs/runtest.c | 27 +++++++++++++-----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 95b4b71fab53..282e4bfe30da 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -69,6 +69,19 @@ static const char * const scan_test_status[] = {
 
 static void message_not_tested(struct device *dev, int cpu, union ifs_status status)
 {
+	struct ifs_data *ifsd = ifs_get_data(dev);
+
+	/*
+	 * control_error is set when the microcode runs into a problem
+	 * loading the image from the reserved BIOS memory, or it has
+	 * been corrupted. Reloading the image may fix this issue.
+	 */
+	if (status.control_error) {
+		dev_warn(dev, "CPU(s) %*pbl: Scan controller error. Batch: %02x version: 0x%x\n",
+			 cpumask_pr_args(cpu_smt_mask(cpu)), ifsd->cur_batch, ifsd->loaded_version);
+		return;
+	}
+
 	if (status.error_code < ARRAY_SIZE(scan_test_status)) {
 		dev_info(dev, "CPU(s) %*pbl: SCAN operation did not start. %s\n",
 			 cpumask_pr_args(cpu_smt_mask(cpu)),
@@ -90,16 +103,6 @@ static void message_fail(struct device *dev, int cpu, union ifs_status status)
 {
 	struct ifs_data *ifsd = ifs_get_data(dev);
 
-	/*
-	 * control_error is set when the microcode runs into a problem
-	 * loading the image from the reserved BIOS memory, or it has
-	 * been corrupted. Reloading the image may fix this issue.
-	 */
-	if (status.control_error) {
-		dev_err(dev, "CPU(s) %*pbl: could not execute from loaded scan image. Batch: %02x version: 0x%x\n",
-			cpumask_pr_args(cpu_smt_mask(cpu)), ifsd->cur_batch, ifsd->loaded_version);
-	}
-
 	/*
 	 * signature_error is set when the output from the scan chains does not
 	 * match the expected signature. This might be a transient problem (e.g.
@@ -285,10 +288,10 @@ static void ifs_test_core(int cpu, struct device *dev)
 	/* Update status for this core */
 	ifsd->scan_details = status.data;
 
-	if (status.control_error || status.signature_error) {
+	if (status.signature_error) {
 		ifsd->status = SCAN_TEST_FAIL;
 		message_fail(dev, cpu, status);
-	} else if (status.error_code) {
+	} else if (status.control_error || status.error_code) {
 		ifsd->status = SCAN_NOT_TESTED;
 		message_not_tested(dev, cpu, status);
 	} else {
-- 
2.25.1


