Return-Path: <linux-kernel+bounces-162309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A3D8B5948
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575231C2389A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E037BAF4;
	Mon, 29 Apr 2024 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8apVw3Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F57768EF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395718; cv=none; b=rrsmb1NqSw6ptjczGU2F3VPnlg36EBlrKnMObZ1nTNdygwQovl2XtFFYaNKwafVj6/Fm7Ck9phD/9ahAbSrhHIATxwv1XSInCA9K+GVUn9uZhnBvgz5Wn0S62cc2J0ysJH+cXVGTZ4f4pwC40amud3MlPBUwlB1AVLqT2/2lz/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395718; c=relaxed/simple;
	bh=NfZcypoD1CZ34fuMUBVKQlaVjj4H35Y4xSOcxQL65lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQXqB9nYqo2XYGdND0CcdUhyF/0Wa/+SPuLO4JxQMPVYXUPDppmubiSG5xonz8kyNN0VOZGx0P1NBKASrp+8VzlWwTTD8aqtYI0YBIWKmIho/dp6KMXeeaKR0JcQoCnO1Y/KY+oHFxm1W44+GjTS/e1xKO9FuFyLVkUDbmsX1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8apVw3Q; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395717; x=1745931717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NfZcypoD1CZ34fuMUBVKQlaVjj4H35Y4xSOcxQL65lQ=;
  b=O8apVw3Qo9RPJJm7sNr/5/0LJcvqtrSeDqdSG1zGlj+MueggdLOtyVvT
   medO8iZQ3PHgq9xf4niKorJEg7IsdX85M1ZhZrjJTzM+orKjs1nreB1aw
   8sy7nmnfSH/kKYizWomERBTWaeSUCmEjgIkppvneqaNvFEpc4O0u8g5Bx
   A1SnxKKTE0L5cGz2zlEyHqSU0JbvYo3PNA65u0EZRb7ogVAyLw4ukq+Xb
   AocD1xSsCmAwGXGCzl80ElyDCV5B3TrLuQLI0XE3UvZW3k4onHK9s1u/y
   k7wGEy6gmL7VFUEzv4lsK/C3tTkeKQ0VKbol0RTG+hZXySzxQh+PRXk5P
   A==;
X-CSE-ConnectionGUID: I8dmqWhWSCifDXvg2nGTIQ==
X-CSE-MsgGUID: s2lWpEFGSJ2skGjfCFJ9fA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986892"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986892"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:01:56 -0700
X-CSE-ConnectionGUID: xho7eiCgR3uwaHCBL6rwXQ==
X-CSE-MsgGUID: ljapeiPYR+6ztpyeJkJ3EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507087"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:01:54 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 07/15] intel_th: Convert sprintf/snprintf to sysfs_emit
Date: Mon, 29 Apr 2024 16:01:11 +0300
Message-ID: <20240429130119.1518073-8-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
References: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Zhijian <lizhijian@fujitsu.com>

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() will be converted as weel if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/gth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/intel_th/gth.c b/drivers/hwtracing/intel_th/gth.c
index b3308934a687..3883f99fd5d5 100644
--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -154,9 +154,9 @@ static ssize_t master_attr_show(struct device *dev,
 	spin_unlock(&gth->gth_lock);
 
 	if (port >= 0)
-		count = snprintf(buf, PAGE_SIZE, "%x\n", port);
+		count = sysfs_emit(buf, "%x\n", port);
 	else
-		count = snprintf(buf, PAGE_SIZE, "disabled\n");
+		count = sysfs_emit(buf, "disabled\n");
 
 	return count;
 }
@@ -332,8 +332,8 @@ static ssize_t output_attr_show(struct device *dev,
 	pm_runtime_get_sync(dev);
 
 	spin_lock(&gth->gth_lock);
-	count = snprintf(buf, PAGE_SIZE, "%x\n",
-			 gth_output_parm_get(gth, oa->port, oa->parm));
+	count = sysfs_emit(buf, "%x\n",
+			   gth_output_parm_get(gth, oa->port, oa->parm));
 	spin_unlock(&gth->gth_lock);
 
 	pm_runtime_put(dev);
-- 
2.43.0


