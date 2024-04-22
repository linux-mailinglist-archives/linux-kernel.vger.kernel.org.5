Return-Path: <linux-kernel+bounces-153695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C80C8AD1C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE47D1C20C09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F415380A;
	Mon, 22 Apr 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRd38Ero"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276391474D2;
	Mon, 22 Apr 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802858; cv=none; b=E+RpiZPhBndCwvqg/F0fEQ7HJUkAQ1lrA+i5C6/kzLAD4ntNQjWRrEJVaZxq1IuBaK51/+wmg0db14idRqcVraog8wYUPXJh3U281JOc5zrko+mH3yLlQL681XFNgRMT5zwAoQp43hauv8Zsslsp7Ds1EoTBb8FNbJBXkDEENe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802858; c=relaxed/simple;
	bh=euB9xiHJ0ccVpu4VLR6T/Kab+BOh3URfAC/WOlN5Gos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BRojWiEVQi6zajZI/Kp/4++oBKhHsludZ6DKalh1n3Nc7h4I4tixjZvvKTCk23Em4leSQnzq2c1HqDre8hbGCziYWtpHd+ckM0u3dAR4f6LlKKlFVfeJFJzD/KTgq4GezibD58DaILd4ocMinU/DFD1MCiami3zZ1RTu8hPX/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRd38Ero; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713802856; x=1745338856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=euB9xiHJ0ccVpu4VLR6T/Kab+BOh3URfAC/WOlN5Gos=;
  b=GRd38EroC5vttlIJOKESCxBQap3MYzs7kgFQMtvcAR2r/DNXzeR3IhTr
   20L2E7POx8okIxl0yLcmyV6Uns2Mkypi90qH9R+EUO0t4z1ajXlruZ6On
   6QsTVeZBBM2JG9KQd9fW/c+tI7l3/HE9QEuy7RcEi8tD70d6DlyLrit9r
   URq7hk4I6ZJKM3BuaQCjOPUGZUtjyhpObOwukw5dvNV+LPWeWmWcr24QH
   H5obKlw8q+ad7o2R9/vNq/yIPPmA0dA1gCiOTAG/3+MuDKb7H5pk/aQS3
   zQTy4ljXvR7XtxGKqSBfLU+NmzYHXL+8N/8n2kESS3vStIhAquj0dsW2l
   Q==;
X-CSE-ConnectionGUID: cCzaZf3jRmq7DuoRFsswiA==
X-CSE-MsgGUID: u/0C10ppRZmSGe3zPbLCWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20754868"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="20754868"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 09:20:55 -0700
X-CSE-ConnectionGUID: S5DNLaSiSFaelJ20/iLS0g==
X-CSE-MsgGUID: 1izRHuorTDuGqouMcS3uPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28738993"
Received: from lxia1-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.209.16])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 09:20:53 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH V3 0/2] powercap: Introduce TPMI RAPL PMU support
Date: Tue, 23 Apr 2024 00:20:38 +0800
Message-Id: <20240422162040.1502626-1-rui.zhang@intel.com>
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

 drivers/powercap/intel_rapl_common.c | 578 +++++++++++++++++++++++++++++++++++
 drivers/powercap/intel_rapl_tpmi.c   |   3 +
 include/linux/intel_rapl.h           |  32 ++
 3 files changed, 613 insertions(+)

