Return-Path: <linux-kernel+bounces-137847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2620289E83A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5643C1C211A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C8DBE66;
	Wed, 10 Apr 2024 02:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j207AYj/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A30443D;
	Wed, 10 Apr 2024 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716487; cv=none; b=Gze6PmO+XzjTt68VGOM5/zllHQ8zyDhonVdoyDkiOgSndSRxDVSAiWT3HFKtjl9an/uGNqWrZzYTGv5oHz1n+kzqOkosf51vQnAKbpCwZCqRCSgXvhGYQY9Pv2XYOpmzWYgPalxXBKWe3bbkh4HRuIgNd7D7SO5vRpRwh9lk2mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716487; c=relaxed/simple;
	bh=obH8pri35IMIPHiw0rnrgYA4QrSMOsXif7LAyLVLGB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXO0v2ib5oqBMR3zXtknkBqNXZQFVdoAYneP/AWVLKyuJ5cyiKAa7v2eQ9PSbWaTqv/SESC2Oqin4tnrFVES/UflaBdsxIVMjhSedlGQ9b/W/mm4W9Kj6xhq1ETzaRVLOv2++VMgcJAi6XHzgxVQhPibXXxSQLtIvGqPICBEChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j207AYj/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712716487; x=1744252487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=obH8pri35IMIPHiw0rnrgYA4QrSMOsXif7LAyLVLGB0=;
  b=j207AYj/M9WDmWFONmDfypYTPio64PkH4M2pAzsmNlqLi7VpGZWVBY4Q
   YRGHxz+BVrly1qd8VB+El0Yar2to9Bj1+y0FjetbKZjXz5kguSY+NwTLR
   ll0N9HcdrJ3bPr+3POZeGnhe3ZybprORkSPdBZNDua/aQRRrfc9VWnq79
   HMJtOBq/2cQTEywB+2VhrLj4Vx442ruHPpVhVvr+MEwmsgtqqAtna2+6/
   5gJLmQAdZSStbJ98CK40kUtGfpRLj74mJKGopGgI1scMbPqNIhUTewm3l
   qtodJTMTxSELbCq2T+WkUKHcwUqxGDH+9yBeVDsqyDckeHjDKUzJIdiRM
   A==;
X-CSE-ConnectionGUID: Dcc+fXY4TG26QBT9RUsbWw==
X-CSE-MsgGUID: UjlgGBg+RRC78/mgtAcjqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11900172"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11900172"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:34:44 -0700
X-CSE-ConnectionGUID: foB0regWTUimANlQnBFcWQ==
X-CSE-MsgGUID: yyTcIY9BQM2aAHkseN552A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43658577"
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
Subject: [PATCH 2/4] soundwire: intel_auxdevice: use pm_runtime_resume() instead of pm_request_resume()
Date: Wed, 10 Apr 2024 02:34:36 +0000
Message-Id: <20240410023438.487017-3-yung-chuan.liao@linux.intel.com>
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

We need to wait for each child to fully resume. pm_request_resume() is
asynchronous, what we need is to wait synchronously to avoid race
conditions.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_auxdevice.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 95125cc2fc59..012232cfbf7f 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -454,9 +454,9 @@ static int intel_resume_child_device(struct device *dev, void *data)
 		return 0;
 	}
 
-	ret = pm_request_resume(dev);
+	ret = pm_runtime_resume(dev);
 	if (ret < 0) {
-		dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);
+		dev_err(dev, "%s: pm_runtime_resume failed: %d\n", __func__, ret);
 		return ret;
 	}
 
@@ -499,9 +499,9 @@ static int __maybe_unused intel_pm_prepare(struct device *dev)
 		 * first resume the device for this link. This will also by construction
 		 * resume the PCI parent device.
 		 */
-		ret = pm_request_resume(dev);
+		ret = pm_runtime_resume(dev);
 		if (ret < 0) {
-			dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);
+			dev_err(dev, "%s: pm_runtime_resume failed: %d\n", __func__, ret);
 			return 0;
 		}
 
-- 
2.34.1


