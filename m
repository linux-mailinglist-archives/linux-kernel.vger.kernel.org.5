Return-Path: <linux-kernel+bounces-167895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2318C8BB0C8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5013EB20D33
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3F5155A33;
	Fri,  3 May 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYPv4iYO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224401553A9;
	Fri,  3 May 2024 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753314; cv=none; b=No4g9nVYoELxevYhsRJrm/k6fwY5pFsU/jZNoHglmLwOGThHeHXwAMN1oC6Td0W80UHq/9qmlA3XbXvW+z1/t8kld/uRoxQKdnxWOJI9Zo4oQ0n3MhRJ5c849RC1/ozyohPYK+4qfZO+3SgmU7KZnGHjXrq5SeKZJP2adEAJJKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753314; c=relaxed/simple;
	bh=+WZYw0B4OM/rKACRXsBObMoY+qjIrv25dqxO8/Jv2gM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=V+ATQkHXCqYU18O7G1nN4ZxN8dVwW4GDML6veP+mhKRAjDDAwDRFYAmQhQyP/c0JDsrMyxlsMZYa9D4YaY2M1UvFDDzyNvs8uOT20/EKsu++UBxMO/FykcA3t8NTnv0+cY2EJr7s9QJfttbbVQMzFV++79L81lua/GF2AfqzAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYPv4iYO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714753313; x=1746289313;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=+WZYw0B4OM/rKACRXsBObMoY+qjIrv25dqxO8/Jv2gM=;
  b=RYPv4iYO/+P2zOKLCQ44zth654oBoxsFFFTzkaIBZ7OmZ/XlunnPIfRe
   gj00H+UK4e3IihgKXRcHoGUuMP7aEgZyZvspKo8aUjXOgtk4yB6QBLfG5
   WU110L53ZKQZ4tc8QMfSeZ4iDkVHjjZr31sVBMdEeamNY1fFRVGqSDWnr
   2kgK67z5LxJMIc41LpGxiCQ98QHcxUJkP5/xkpqHp0zOnY3CILClRp6vI
   pz9UVV8MuJyPjgnTczBmwo8sbaomthgZ3XPOkkZY3NHrJgioChVnjnvrA
   X2ZqhAhba8x2mC6zI6cegRy/pxOFB4Vx3gmS1U0yGeTqBIGFQ4CbFSVI1
   w==;
X-CSE-ConnectionGUID: cPjQt6PzR6OMp7BD7mYn+g==
X-CSE-MsgGUID: xvvbC1FISXGKV4/GRjEhvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="13513323"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="13513323"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 09:21:52 -0700
X-CSE-ConnectionGUID: rHUZUIC5ScK6smLyKYSS/A==
X-CSE-MsgGUID: LBVLLm3iRjaMaSNWitCPrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27367922"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.124.222.56]) ([10.124.222.56])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 09:21:52 -0700
Message-ID: <64b8cfc3-c2f2-487a-bced-8519690239a4@intel.com>
Date: Fri, 3 May 2024 09:21:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fix for 6.9-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.9-rc7

..to receive a fix for the CXL subsystem.

A late bug was reported by Robert Richter that the Restricted CXL Host
(RCH) support was missing in the CXL endpoint access_coordinate
calculation. The missing support causes the topology iterator to stumble over
a NULL pointer and triggers a kernel OOPS on a platform with CXL 1.1 support.
The fix bypasses RCH topology as the access_coordinate calculation is not
necessary since RCH does not support hotplug and the memory region exported
should be covered by the HMAT table already. A unit test is also added to
cxl_test to check against future regressions on the topology iterator.

This has build success notification from kbuild-robot. It has been in the -next
for several days with no reported issues.

---

The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.9-rc7

for you to fetch changes up to 5d211c7090590033581175d6405ae40917ca3a06:

  cxl: Fix cxl_endpoint_get_perf_coordinate() support for RCH (2024-04-29 09:03:26 -0700)

----------------------------------------------------------------
cxl fix for v6.9-rc7

- Add missing RCH support for endpoint access_coordinate calculation

----------------------------------------------------------------
Dave Jiang (1):
      cxl: Fix cxl_endpoint_get_perf_coordinate() support for RCH

 drivers/cxl/core/port.c      | 15 ++++++++++++++-
 tools/testing/cxl/test/cxl.c |  7 +++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

