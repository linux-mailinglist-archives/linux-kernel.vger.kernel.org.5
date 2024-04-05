Return-Path: <linux-kernel+bounces-132374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710A08993C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878061C21F8C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077FB1B94F;
	Fri,  5 Apr 2024 03:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d61Ahqwe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDF15E9B;
	Fri,  5 Apr 2024 03:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287514; cv=none; b=op3AVNiPrDF3ukI/WwEOCZffpKzUZ4lW1lZ2dTmE0Eb3Lj7wIxaQvxPJjOu9iAm6OtVpoGCnwpf8NWyFn+Z1V7B0onZqyxqHn3bUozw3g9+MR0d5qY5Nwegnn13L9RzQsGvbGlBjtH3Ph5lq4n+iK140Qonf312ymwjYyhhLNgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287514; c=relaxed/simple;
	bh=fmbf22/6PrzbvehPK0DfA68erI1ahHCSNNgi1ygbKPE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Egwj3x37uVSBpIH+AB0kfJ8Y3mvh6oWYBHe1xqmSZRhruEIITTXrsJPQZ1YYR/ZjHPFRO2Xalov9b7iYnppYWzFKdOruz37Lh7V/naf+aQfY6qZJm0MyEmM2e5u09TAni1dtC21jNaabkd3479CdkMbkU23pqecJQtmiE7+QuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d61Ahqwe; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712287513; x=1743823513;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fmbf22/6PrzbvehPK0DfA68erI1ahHCSNNgi1ygbKPE=;
  b=d61AhqweSuJKiZuxKvqFJXjQwrbj+Gw+Y28wDp5ETbbNvEz2OOb0Jq7u
   4CO48rmkYnvgwJOcPZChvVlptwGa/yj0vXUN0o2m8cEvqdswxAHZooQE5
   M7HrVhWt08es2Di49zCzKbS9SmywLP3fH0Vg5VZTUBR1qlb6F6f7yKxHH
   HyslK2EQufLZFZe9L3Vsx+EniHT+/+kk9qUoGOzaCzYzuZyXj/pTf4EhN
   JidGqPEodpjCgpuhHuQYimTdKtTBLMj+HKPo9tMjQD7LxHsjtB/x/fP1a
   XFcOBKBK4h773zcYo/r2sz9fjYur81kTas5A6SwVERLgk5lmytnwrLBiL
   g==;
X-CSE-ConnectionGUID: mnsn+GoEQ1So4mPbdWZ79w==
X-CSE-MsgGUID: sJdZ/JuRS7WNSCc8xrf+Fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25112456"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25112456"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:12 -0700
X-CSE-ConnectionGUID: kcXpTs3dTda2GdisN+6LJw==
X-CSE-MsgGUID: BpBkgbB2SmqZm3C7B36fxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18955979"
Received: from alexpabo-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.209.49.45])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:11 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V3 0/9] Intel On Demand changes
Date: Thu,  4 Apr 2024 20:24:58 -0700
Message-Id: <20240405032507.2637311-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds driver and tool support for a new "current" meter that allows reading
the most current, but not attested, value of the meter counters. Also adds
fixes for the intel_sdsi tool.

David E. Box (8):
  platform/x86/intel/sdsi: Set message size during writes
  platform/x86/intel/sdsi: Combine read and write mailbox flows
  platform/x86/intel/sdsi: Add attribute to read the current meter state
  tools/arch/x86/intel_sdsi: Fix maximum meter bundle length
  tools/arch/x86/intel_sdsi: Fix meter_show display
  tools/arch/x86/intel_sdsi: Fix meter_certificate decoding
  platform/x86/intel/sdsi: Simplify ascii printing
  tools: intel_sdsi: Add current meter support

Kuppuswamy Sathyanarayanan (1):
  platform/x86/intel/sdsi: Add in-band BIOS lock support

 drivers/platform/x86/intel/sdsi.c      | 118 ++++++++++++++++---------
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 110 ++++++++++++++---------
 2 files changed, 145 insertions(+), 83 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.34.1


