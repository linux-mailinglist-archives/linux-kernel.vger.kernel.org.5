Return-Path: <linux-kernel+bounces-143128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2E68A34BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7371F22100
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C587014F139;
	Fri, 12 Apr 2024 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKKRrOyb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0914EC76;
	Fri, 12 Apr 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943049; cv=none; b=PdHVKee6f6KbyeUC72ZbCdLEsaUxPI5tbso3mwunMs8Vf+5OnaD5kzs8qJGM6f2Jn7N+7JiqMPXOIfxAXFFUzJq87yTebyKFN1heZN4ALO+cvox9PZdrgTU1SFcr21eAwTA7Mpi3Ea4a/YTSd8DUbQsiZN2jOaJjxE4yITGtYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943049; c=relaxed/simple;
	bh=0q/n4BB5A4qfKK7WTII1e9HuGi84JwM3B21N0UMYoMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tiIZ9BVbcMitdQJZDQB+dGCGCnRVTR9k6PKuKjuvQO9iF1CpNFb8/0ijiPvGoq0gyZzSJcaLBVKln0QggzUVC+H+dQGicUtRlnQsQRTWzgYvMKWh4Zg3+AnHClk04Io+g/BdoghOJr8SZnf7dEmhf66rmmbK+3RtfONpKv3SP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKKRrOyb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712943048; x=1744479048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0q/n4BB5A4qfKK7WTII1e9HuGi84JwM3B21N0UMYoMo=;
  b=eKKRrOybPFyQitMwSC8LilydS1LD+NAA3RKncuHdtoUbcsaiPtuRC4zx
   UtVK5fELIYAdXX2liXAv1Yb1hJQBy5EwA1ETWlg9OHNbfiJFioYF5wcme
   jKCUD0TF6LuhmWSD1Gj94/6vm0NSSDZUyBQrr6oW9zFtyGpJO+3txNEug
   qzNggYevA4X6MvYHwf2R6E2VdU5D47DNSvYoZMfc1qn8zGTDjxi7TBmKc
   mprn6qs1vy/88KZj0gba0+Pmj116N61pm28yGzk5G1+NTjyWDxdx7Pzaa
   nC+S8ErSGhF/SdFSaYYch/KvlBsX+gqLzrrvHcM805nAw4pnh37DzfH4v
   A==;
X-CSE-ConnectionGUID: dsqflwa8Q7K5Iwdn+80Wbw==
X-CSE-MsgGUID: SE20U8scR1G2W+0jQ3LQrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="11365694"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="11365694"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:30:43 -0700
X-CSE-ConnectionGUID: zPCuEzLMT5miAOxrOYdj0Q==
X-CSE-MsgGUID: OFOLKwADSD+tETiNBK/HVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21780778"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:30:43 -0700
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
Subject: [PATCH 3/3] platform/x86/intel/ifs: Disable irq during one load stage
Date: Fri, 12 Apr 2024 10:23:49 -0700
Message-Id: <20240412172349.544064-4-jithu.joseph@intel.com>
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

One of the stages in IFS image loading process involves loading individual
chunks (test patterns) from test image file to secure memory.

Driver issues a WRMSR(MSR_AUTHENTICATE_AND_COPY_CHUNK) operation to do
this. This operation can take up to 5 msec, and if an interrupt occurs
in between, the AUTH_AND_COPY_CHUNK u-code implementation aborts the
operation.

Interrupt sources such as NMI or SMI are handled by retrying. Regular
interrupts may occur frequently enough to prevent this operation from ever
completing. Disable irq on local cpu around the aforementioned WRMSR to
allow the operation to complete.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 584c44387e10..39f19cb51749 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -233,7 +233,9 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 		chunk_table[0] = starting_chunk_nr + i;
 		chunk_table[1] = linear_addr;
 		do {
+			local_irq_disable();
 			wrmsrl(MSR_AUTHENTICATE_AND_COPY_CHUNK, (u64)chunk_table);
+			local_irq_enable();
 			rdmsrl(MSR_CHUNKS_AUTHENTICATION_STATUS, chunk_status.data);
 			err_code = chunk_status.error_code;
 		} while (err_code == AUTH_INTERRUPTED_ERROR && --retry_count);
-- 
2.25.1


