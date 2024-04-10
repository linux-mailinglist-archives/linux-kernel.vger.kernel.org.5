Return-Path: <linux-kernel+bounces-137849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C8289E83C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C221C23E76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036F310A1F;
	Wed, 10 Apr 2024 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDW7X7wk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE745BA2E;
	Wed, 10 Apr 2024 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716489; cv=none; b=P/IP8iejBbQ13zU2Cj5xvBZ1Vyflts0T7gl5sv6PLR2/xuq2r5N5P+sVFF0pncYPYacUZuJJ5MkNqf8eNMdp74O36VENtEtX/uU9/o7fRE5hUtsKlFyamJrySVl2+XkrFr26mo0fOiEav42HjCJjbvcNQapXcYsSTU7hG+sPGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716489; c=relaxed/simple;
	bh=Rn0azuAjLZ3nmPsyZ9+vuDVhIZO652cxcna9Kq/oIgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omHJYCLWZcUGau9fSEHOLTVV72GxGUbye/rlQjP2RG2kGOBr4XHnx2viqOrsjXrfQhOY5/95vwJFxV9lBV3u1PuxPpcZQAkmHwLmvfSZ+PBj7uEneLl8X91mQcE7E1GmuLp3hVvq+pw+pGVdfyMWylZ72UOMOXXRht3W7fDnUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDW7X7wk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712716488; x=1744252488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rn0azuAjLZ3nmPsyZ9+vuDVhIZO652cxcna9Kq/oIgw=;
  b=LDW7X7wkd4o/vPBKnfdfeaALPFvt4P5LlW3QZKILTVPlDZ4fobKwq5KJ
   uWB0n/B3NwqLbb3Kr4ZHxdmAAerH3urL4ApXAztDXb8j+QKAGM8FfgTDJ
   iQy3h8FIFjHb8y9cVD3Y6npKXb+lJ7+Z3ZcragtkzEGmCtDnAWa1cU5tC
   PHR8IrxRwx0boGtB5LCCit+ErkDQtr8jOO5p08NKVfygi5zmEha8JxcOI
   VRHiGdPcQKbOW49BEHkLaC9eCu+iCLA/zZpSv2eSQ/ZVgDk/UvK1JSrqd
   v4Z19AIWyMNSp7/r01G1HvIaei0hmEC2GmvtLetugiVphXgNfp4ve9R0M
   A==;
X-CSE-ConnectionGUID: 0Jkws6lgTfaSfH5qLJX4Mg==
X-CSE-MsgGUID: JwuZAkpjTpWR1X54wbE82g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11900176"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11900176"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:34:45 -0700
X-CSE-ConnectionGUID: uF1j9F4bTVG6DnxNTO799w==
X-CSE-MsgGUID: Jfq8zdJ2QeODDczbAk7aMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43658581"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:34:44 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org,
	broonie@kernel.org,
	tiwai@suse.de
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 3/4] soundwire: intel: export intel_resume_child_device
Date: Wed, 10 Apr 2024 02:34:37 +0000
Message-Id: <20240410023438.487017-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410023438.487017-1-yung-chuan.liao@linux.intel.com>
References: <20240410023438.487017-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will resume each child in the next patch, and
intel_resume_child_device() will be used.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_auxdevice.c | 2 +-
 drivers/soundwire/intel_auxdevice.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 012232cfbf7f..296a470ce1e0 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -440,7 +440,7 @@ int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
  * PM calls
  */
 
-static int intel_resume_child_device(struct device *dev, void *data)
+int intel_resume_child_device(struct device *dev, void *data)
 {
 	int ret;
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
diff --git a/drivers/soundwire/intel_auxdevice.h b/drivers/soundwire/intel_auxdevice.h
index a00ecde95563..acaae0bd6592 100644
--- a/drivers/soundwire/intel_auxdevice.h
+++ b/drivers/soundwire/intel_auxdevice.h
@@ -6,6 +6,7 @@
 
 int intel_link_startup(struct auxiliary_device *auxdev);
 int intel_link_process_wakeen_event(struct auxiliary_device *auxdev);
+int intel_resume_child_device(struct device *dev, void *data);
 
 struct sdw_intel_link_dev {
 	struct auxiliary_device auxdev;
-- 
2.34.1


