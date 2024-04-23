Return-Path: <linux-kernel+bounces-155862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 419DB8AF828
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC4AB23293
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE25F142E8C;
	Tue, 23 Apr 2024 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neODTHt9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680613E02C;
	Tue, 23 Apr 2024 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905185; cv=none; b=O5PHusJi4kattca8NpXiHpJI7X8vZqHhDfWxO3GJ1tv3NDJPATFz6K2gz0WdVpk4lwBXucj1LoJQTVGS7Qj4so/yXmSmwc2ptvotXTsWBjoG2dajzQfk1liliZHL5B5q2Hqxr8s+NbyQrCh8Hrdmo1DsTzKfpU1HsNOdTCILgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905185; c=relaxed/simple;
	bh=FdRbkelJyyMp+XaA02zYd2JJk9swSDq0G/GC5XIBIBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k4X2B/GlToWnYwksGgz0JAIEcchMeSoy0WYpBR1p9LULVCsOfeXy5biwHw6j+CBfFWU6husZg3tSfCMYTMqay+Q9x9BI4dQwFrZSZJTmvF55JC5WsOpADETD3XRobA31G1KunwJP0ieBiUJWqK4Rzks/dLP9GopK53LnC2E+p7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neODTHt9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713905184; x=1745441184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FdRbkelJyyMp+XaA02zYd2JJk9swSDq0G/GC5XIBIBU=;
  b=neODTHt9JJydGFItn4XWygb4mhvxD78qcK1AaHKIIZBnBkfAYPkTXtPs
   KvUQAynnjhnDzKShvHz53FDqyZxkEFqXkj7hlukdHEj7PJ1DX/JMFwWMO
   g8zjZApPY7yYWI1wd80B0jLCBN/KNllc81gyiw8HBdJ9BGKtd8AfponZQ
   Lzi4VIMTgHhSqJWjxoaxwy7W+xF+fq5GOUDfsU3gH7qbsnaocjNbYI8DN
   sFWtmoRrMONysJJL+xMzn/D8vqxDG4jZCYhF/WmnQdOfi3equwPNdvi7K
   myV7iSypR1XfUAJJPvb2WQMI3zoqUmokDiIIjBerbP7//7SYojhtAmLzH
   Q==;
X-CSE-ConnectionGUID: ooD2albNSUicqfWdjdE5bg==
X-CSE-MsgGUID: RxqjX9uCQWmAkahHFnkzgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34912314"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34912314"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:46:23 -0700
X-CSE-ConnectionGUID: Ao8U5ampRTaBJ6wEIyqcOw==
X-CSE-MsgGUID: tMNMSPcCSJCYnTKLS4ir1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24533078"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa010.fm.intel.com with ESMTP; 23 Apr 2024 13:46:23 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 00/10] Support partitioned systems
Date: Tue, 23 Apr 2024 13:46:09 -0700
Message-Id: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A partitioned system has two PCI device per package compared to only one.
This doesn't change any TPMI functionality. Just while reading, different
MMIO region is used for TPMI instances.

Some patches are not directly related to partitions, but added for easy
application of series.

Patches are applied on top of origin/review-hans branch as of April 23,
2024.

Srinivas Pandruvada (10):
  platform/x86/intel/tpmi: Handle error from tpmi_process_info()
  platform/x86/intel/tpmi: Check major version change for TPMI
    Information
  platform/x86/intel/tpmi: Align comments in kernel-doc
  platform/x86/intel/tpmi: Add additional TPMI header fields
  platform/x86: ISST: Use local variable for auxdev->dev
  platform/x86: ISST: Shorten the assignments for power_domain_info
  platform/x86: ISST: Support partitioned systems
  platform/x86: ISST: Use in_range() to check package ID validity
  platform/x86: ISST: Add dev_fmt
  platform/x86: ISST: Add missing MODULE_DESCRIPTION

 .../intel/speed_select_if/isst_if_common.c    |   1 +
 .../intel/speed_select_if/isst_tpmi_core.c    | 345 +++++++++++++++---
 drivers/platform/x86/intel/tpmi.c             |  39 +-
 include/linux/intel_tpmi.h                    |  12 +-
 4 files changed, 333 insertions(+), 64 deletions(-)

-- 
2.40.1


