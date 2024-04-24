Return-Path: <linux-kernel+bounces-157509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5228B1239
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF60F1F2100D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A32F1C9EB0;
	Wed, 24 Apr 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4ROe+QE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB61C8FAE;
	Wed, 24 Apr 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982541; cv=none; b=WPNgx9ewSssahaccjIjuPOrqHyYrb21qZJYrzZfBxFq8VyXBgE1eXUk2LHn7iC/vUPEbcyGRSFpumYRsp9MgvKnW/UZyh2bXLlCPDkGn8/4I7nH16znSezqcJfQLTk1dWqOZ3kKORg00sQTyLkx6LiWf+7KkDDVlbiTclRkoW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982541; c=relaxed/simple;
	bh=zq3PVQPAcMWcn9vz87aBSrEUPTNktf+avk5R+71nh50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcKyVNZTPfvERqLkBKk2oUYnrnr86RrG6WfQgXhBno6cMru+OdoTQqIs3Cjtb1z8XcVATg3oH+AO5XSPp9e3qyd1PrcenTvSoGrOI66BNz2nJ89PiJ33eKwqhPRdIh20WaPsNd/uCtPeBxgid9B5S4X6+V8dWEwiWM2638nNxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4ROe+QE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982540; x=1745518540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zq3PVQPAcMWcn9vz87aBSrEUPTNktf+avk5R+71nh50=;
  b=J4ROe+QEUDlTYkQOBf2b6e+XC/sRAFCkm8h7OO9mmN39ALdLPH48TDO7
   6jDEoCxzYw8rQpvVa57fLCQ8YeiCKGrJturf6P9CJmJbkxbxpSrUjeJuF
   0xvWRrF1wEBsRHAp7KTQ7lHbwVLxNLeE80/TCG/XY+wGkhf6FdcwbqzH0
   GtM22Eey29plslbl059Y97ai6q3qx985UK5erTUq03kaYFkyyyGJWDGqw
   7+m0Vnjz9NtW9JJqfi16pJZ2EDBYd6kkl5L/o+cByKS/5439HDOZSaLH6
   4o8Imw8HsuhUOsNC9jZhXDplV/iL+IZHofcWbr+BVg56Qkb5Qu9xSuqtJ
   g==;
X-CSE-ConnectionGUID: O7AAwozaSgaCS2d6UShNaA==
X-CSE-MsgGUID: 6To1xjM9SK6oShmHlkysvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503685"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503685"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:39 -0700
X-CSE-ConnectionGUID: oVdKoGGKQtaObO59uusIfQ==
X-CSE-MsgGUID: 1/zjBpQ8SWGxLILHsjFVdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750304"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:39 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 60/71] platform/x86: ISST: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:39 -0700
Message-ID: <20240424181539.42311-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 08df9494603c..96f3b221b6c8 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -719,8 +719,8 @@ static struct miscdevice isst_if_char_driver = {
 };
 
 static const struct x86_cpu_id hpm_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	NULL),
 	{}
 };
 
-- 
2.44.0


