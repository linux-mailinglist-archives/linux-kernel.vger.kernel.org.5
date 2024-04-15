Return-Path: <linux-kernel+bounces-145933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AE58A5CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F62B20D56
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D388157468;
	Mon, 15 Apr 2024 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbjY1I9B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DF823CE;
	Mon, 15 Apr 2024 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216541; cv=none; b=RN44D5FKe6fGxDKlGpKqoP/iN4Ca2YoGCGdNyV2vtOHEiSr7MUnaSC1QFhW95tULLhMMUiujSo6BHqBwxgEi0nW5udnZouamhUtpxFDrWAS8eNNonBnVKDhqF0ItkFz9blRzmYwCZpGxyzJNVf0dVgF55TBaATu3WuaQQ7xKmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216541; c=relaxed/simple;
	bh=tnp3Gy5QouPkq1ZPCN4tIf7ajUpjlx10BNU1uvCdm1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LZ6d7bRsOXtqaGqefIDuEyYdDhzuV9P6I6ujWf9KzweWRTtlVj51D+b39Qzm2oA+xA064UiJTBhkuz8hJAhSwwpmc2VTWRBy0jY+wsxrrZdMTJF8oXiEi8AaSarW/ts36OlEsxZHY2WPPvY6aFsb/U/za/2pdcIrA+FSy8KbVSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbjY1I9B; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713216540; x=1744752540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tnp3Gy5QouPkq1ZPCN4tIf7ajUpjlx10BNU1uvCdm1w=;
  b=NbjY1I9BLv/TH7w2c05nU+IpksXoEmoUsPO8zQjKWsbImR/Zln2rUsSW
   I/toEjfyeyvgju5v9+sdfNaVJurtw42b2vmQ6qF5PoG1Oy/jUWvxIcoX0
   wKbW3I8rAz/s8ZRpLVtwFncTXCSFcSm0SYY2aeKEI9LNVVh0rAYg7hoRq
   F8TSP2jL58rIms7f9wSSdKpnWIMMh5oRop9RJkiEHSaw+zTjt4E1UJK6p
   RA/ylH/oxSklADzuqHrVabuAoTZH4Y2Gr0iyojHoxul/9iRlbbwkRhUly
   zoSSVb/PdfZkPj0QQGu2NvlyTN3aUR5ro8UqH0nj0d7+wKu5mYNjkqTdv
   g==;
X-CSE-ConnectionGUID: 7p0zlTKGQZyQHSnd77TBVQ==
X-CSE-MsgGUID: mmgZyEKvQke32K8fj0ie3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="11573450"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="11573450"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 14:29:00 -0700
X-CSE-ConnectionGUID: om3b2GjhTnaJonPR5+AUyQ==
X-CSE-MsgGUID: Z3aD3ybBT1Gzg1V2Xdg4Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="52984360"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orviesa002.jf.intel.com with ESMTP; 15 Apr 2024 14:28:59 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	markgross@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86: ISST: Add Granite Rapids-D to HPM CPU list
Date: Mon, 15 Apr 2024 14:28:53 -0700
Message-Id: <20240415212853.2820470-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Granite Rapids-D to hpm_cpu_ids, so that MSR 0x54 can be used.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 08df9494603c..30951f7131cd 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -719,6 +719,7 @@ static struct miscdevice isst_if_char_driver = {
 };
 
 static const struct x86_cpu_id hpm_cpu_ids[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
 	{}
-- 
2.40.1


