Return-Path: <linux-kernel+bounces-134843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA3389B7BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F751C21453
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9441802E;
	Mon,  8 Apr 2024 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2PdKNkB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC611755B;
	Mon,  8 Apr 2024 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558311; cv=none; b=GVvtvgN29ijm097td2q5wGj4/9XzApnufcX2nXQIKzg6DzHRl0noYPRAN0R7qJ1bIIJLSUu4RE4LOYgouf+74zMTQlD526gRaBiuCR9+kU1BNV6nHEARdGI4kPTt983h1DvYR/YV1uEG5bLckZrLja+ShBoZgodaZ3N7KPw02sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558311; c=relaxed/simple;
	bh=V51gHvSprZIHY9Mr6N9wyHn63LwMS3Sg3j8AjFjJFQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dS/HVzEgViGuNuRxqJS0qpmow7kj7X4NZRaw87ds39Et1eKxpL3b6GrcGH+nlHnrFK0GuNa3uXblFoBNrvZxtovgtu1oCgub1NXA9FUrcNPIT/2DpB9pJt7tJOC2S7nbYynw1TulKqtE8Q5SXBGW1dRSA4F5vmc/4FoD9oPfM/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2PdKNkB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712558310; x=1744094310;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V51gHvSprZIHY9Mr6N9wyHn63LwMS3Sg3j8AjFjJFQ0=;
  b=T2PdKNkB43tNH5uDz+oiZZHIm72kNs3cmvwui1xNAnDXQ9yglFCdsSEc
   YhdsEj0XrGBJj/B/HcoQ6eDOLrnlbgQDYkLNDJ+IKa1Ck1inmzB3ipN/V
   0BFclohYb81ILTyMx0A9GwmCxJr4hcf0YR6/GG7U0sWsfPM2pJfWaazfE
   6Pd+6RpWwOTgwEJuJsq163rBxvjwg722SbJRe8/xhEIhE6+4PxoWglTyX
   YZvQNlxWAqAWB8OcAEi3Aq0+i4oAcbdExzOdfXBDcLLzzuaUfYXayxKeT
   I3JmYLZnR2ffCjDjeQrvSAhk4rBfSVZ1DVS3NSPrgLdyzfvkZgeAKBYXo
   A==;
X-CSE-ConnectionGUID: N6qyxxdVQCeGo+iu679xkA==
X-CSE-MsgGUID: P5poqTAQRSyUc9350XXWxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="33216961"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="33216961"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 23:38:29 -0700
X-CSE-ConnectionGUID: Q3ON63GPRzWV4DWNwInY/g==
X-CSE-MsgGUID: dKQwETuIR8y3tdyTKhVEEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="20344569"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 23:38:28 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2] soundwire: reconcile dp0_prop and dpn_prop
Date: Mon,  8 Apr 2024 06:38:22 +0000
Message-Id: <20240408063822.421963-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The definitions for DP0 are missing a set of fields that are required
to reuse the same configuration code as DPn.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
Changes in v2:
 - Remove unnecessary leading space 

---
 include/linux/soundwire/sdw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index e5d0aa58e7f6..7bb9119f3069 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -235,6 +235,7 @@ enum sdw_clk_stop_mode {
  * @BRA_flow_controlled: Slave implementation results in an OK_NotReady
  * response
  * @simple_ch_prep_sm: If channel prepare sequence is required
+ * @ch_prep_timeout: Port-specific timeout value, in milliseconds
  * @imp_def_interrupts: If set, each bit corresponds to support for
  * implementation-defined interrupts
  *
@@ -249,6 +250,7 @@ struct sdw_dp0_prop {
 	u32 *words;
 	bool BRA_flow_controlled;
 	bool simple_ch_prep_sm;
+	u32 ch_prep_timeout;
 	bool imp_def_interrupts;
 };
 
-- 
2.34.1


