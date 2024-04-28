Return-Path: <linux-kernel+bounces-161342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89318B4AF6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E9EBB212CC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D5354F86;
	Sun, 28 Apr 2024 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHxXMuFm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887A2524B7;
	Sun, 28 Apr 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714296280; cv=none; b=bbeGvd3OMIlsnS36nAwK2gTeU5zAWCO4e84NucSdUPNzS9ywqOBb3KEOLPhKnnHB0SjduZ+yQFF6mUQ0tlK0mmbYbfE6M9v1fLHqdFQFbccocGcbz+ry8Z5O2GWJxTFUU1MyCztofZRe7+aOdvhmqEoEkS88275jSMD99k4he3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714296280; c=relaxed/simple;
	bh=J+wrIvkEUJJ4NAAL2RM/Y60fLE6nSOmAeZ1QKeBR//s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hDq9Xhi3XTOVUnt4PTk25fJ2jhqex3SZw1kAW+nh1GmddF/ncFyi8oTtdtGnEteJHSPS4Fr3+fjX+38ZlZQSLF+5jVtWUJmJLAFdn7+55fgZ5chrl/v4w4FuzqNOwBRpdixB2ng2ArqUuNLp5y/lZP59EivDuDszHYTiEVlvLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHxXMuFm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714296279; x=1745832279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J+wrIvkEUJJ4NAAL2RM/Y60fLE6nSOmAeZ1QKeBR//s=;
  b=WHxXMuFmfIyRXC7tfnpnsMEEnVILqh1gDIGx1+cF8vr+ZSjZlPXRDEAN
   LdHNQ9taDDrzV+HeknBBgZhhkD2cdXpN+wDkYBH9m2ObClsyxLRYrTwct
   BhAZPAV7NMnVDnPxPXoBdPxayyCanNpPD8JNfk0QgAcyl5/uoKYg63BEq
   RUC5Y1ZzUMv4vGRB2iKHxvzsS3dLUYZ7MrWBi8JVSn3Nr6Hv0pkAW2h+Z
   AzWMHTZP8DPy4zVZ1BIWfzyDD4ooPj5b9VKNOQTPNckz/JkeU8n79I18N
   K6Vrafq9Hs3z20wPo5c9Y3iTrAm6L0Uhy0NnD/xj/zXAym5XCacApWqQp
   w==;
X-CSE-ConnectionGUID: CMq/R/2jSGa3bo0mulmwXw==
X-CSE-MsgGUID: ab9VD6AZRv+90G4NnjoW4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21127806"
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="21127806"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 02:24:38 -0700
X-CSE-ConnectionGUID: eJibCNLwSnqm9b9RSDyp2w==
X-CSE-MsgGUID: wlN4xaxhRhypCMX7spNcrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="63303775"
Received: from xingyeyu-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.249.169.4])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 02:24:36 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH V4 0/2] powercap: Introduce TPMI RAPL PMU support
Date: Sun, 28 Apr 2024 17:24:25 +0800
Message-Id: <20240428092427.24959-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RAPL energy counter MSRs are exposed via perf PMU. But this is done by
separate code which is not part of RAPL framework, and it cannot be
reused by other RAPL Interface drivers like TPMI RAPL.

Introduce two new APIs for PMU support in RAPL framework. This allows
TPMI RAPL PMU support and also makes it possible for future cleanups of
MSR RAPL PMU code.

Changes since V3:
- Fix is_rp_pmu_cpu() return value. (Rafael)
- Following the conversion in other PMU drivers to use
  local64_try_cmpxchg() instead of local64_cmpxchg(). E.g. bcc6ec3d954b
  ("perf/x86/rapl: Use local64_try_cmpxchg in rapl_event_update()"), and
  update with a comment.

Changes since V2:
- drop patch 1/3 and rebase on PM tree bleeding-edge branch.
- fix a regression introduced in patch V2 that RAPL PMU is not
  successfully unregisted when unbinding the device. This causes kernel
  calltrace about duplicate PMU name in sysfs when reloading the module.
  Our unit test cases reproduced this but the test framework failed to
  catch it, and now that problem is also fixed.
- add comment for RAPL PMU implementation details.
- add comment/document for struct rapl_pmu and rapl_package_pmu_data.
- remove unneeded global RAPL PMU cpumask.
- use an array to map RAPL PMU events to RAPL Domains.
- Other minor improvements.

Changes since V1:
- remove the MSR RAPL PMU conversion because it is a separate work that
  can be done later.
- instead of using a flag to indicate the need of PMU support, introduce
  two APIs for the RAPL Interface driver to invoke explicitly.
- minor code/comments/changelog improvements.

thanks,
rui

----------------------------------------------------------------
Zhang Rui (2):
      powercap: intel_rapl: Introduce APIs for PMU support
      powercap: intel_rapl_tpmi: Enable PMU support

 drivers/powercap/intel_rapl_common.c | 582 +++++++++++++++++++++++++++++++++++
 drivers/powercap/intel_rapl_tpmi.c   |   3 +
 include/linux/intel_rapl.h           |  32 ++
 3 files changed, 617 insertions(+)

