Return-Path: <linux-kernel+bounces-164545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A68B7F27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB031F24DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD6C184123;
	Tue, 30 Apr 2024 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZXzoPK+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F163180A70;
	Tue, 30 Apr 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499085; cv=none; b=ml0DQ2c2RHgIBQZQL7dFXNTZ2QxDGFHFdV8KWUV9WDe2UwmIwywypwqCm3QYDq1hna0lfza2hTPm96Q3y0BmspkmKX0C5SsnZQscCVwf2gU52ZMwIG0Ja0vzz1UGi9HxewMafDW0Z4K04FB83hkdv8/b3L2tLSru0pcFVLW5k+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499085; c=relaxed/simple;
	bh=T52oU7nq5CORc4zUmW3MiR7iyOzbCEAUapTKwbnnDtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZH+bOZXy/fSx43V8nrQ6a+/2TT2GG/bz2uUrwafZox31IPj7KJ+GXA6/yZQ1UGVW4bWddoA9dUuQRt44Oz9h/YmCsG7/eCzcjkhe5t6Z2UQhLyAiqKtM8hDsgZG6UTeCzeBXElTCUpWZfafIpvm5DorkGcy+7196TDLZ7k4STOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZXzoPK+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714499084; x=1746035084;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=T52oU7nq5CORc4zUmW3MiR7iyOzbCEAUapTKwbnnDtE=;
  b=iZXzoPK+B9TEtKYFOCVLbzTPi4qTg/RwFnnPDeW7LEn1JGaPH2+cvUVS
   M6SFdaIERgDAOmBb1PogES0+C4Lq/o8O/pY3AHV0qY7LkHRsMNzAtEgn2
   yrY0xMIl9TbkwnoZkYKWX0K4dghajPhQ4sepgxci9FjraWtCpHuifbT0M
   hEfxntsVyEurj+TsOt6/fRzuvbGtnsxiwEwH60xM0vzhx7Bm4wW7V/G34
   pn6IOzR03xZkRKTzBuQfABRJvJvAUsiXyhLtZ+HXz2f32dF41Yk6G9sz6
   6Z6Zcht9lZnWdmA743BDH8tY2q8n18NhOaYaPLzpd5N58eXNp+nuqzea5
   g==;
X-CSE-ConnectionGUID: XL3fs/hIR7iv2kEHVj7OGg==
X-CSE-MsgGUID: /90zm1V5Ry+upKCQIYh0mA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="27669837"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="27669837"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:44:41 -0700
X-CSE-ConnectionGUID: mAtDHbLVRkeXR30fmCFHxg==
X-CSE-MsgGUID: liAd+UmlS8+j6gqf+bh/lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26534777"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.82.45])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:44:41 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Tue, 30 Apr 2024 11:44:24 -0600
Subject: [PATCH v3 2/4] dax/bus.c: fix locking for unregister_dax_dev /
 unregister_dax_mapping paths
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-vv-dax_abi_fixes-v3-2-e3dcd755774c@intel.com>
References: <20240430-vv-dax_abi_fixes-v3-0-e3dcd755774c@intel.com>
In-Reply-To: <20240430-vv-dax_abi_fixes-v3-0-e3dcd755774c@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.14-dev-5ce50
X-Developer-Signature: v=1; a=openpgp-sha256; l=3760;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=T52oU7nq5CORc4zUmW3MiR7iyOzbCEAUapTKwbnnDtE=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDGmGehxf90/d0nXems10qoBf6nS+bxeNLjG1dP1Rc0w4I
 ZLQVyrYUcrCIMbFICumyPJ3z0fGY3Lb83kCExxh5rAygQxh4OIUgIlozmFkOLHqhbMVN3/OfKaM
 yUJ3l3GLbshgnx3VKqeklKO6MZqFi+GfUd+7g/M8FsVor3m469bJ2YYu7+06zvy3FJl/6Ln69rP
 X+QE=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

Commit c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
aimed to undo device_lock() abuses for protecting changes to dax-driver
internal data-structures like the dax_region resource tree to
device-dax-instance range structures. However, the device_lock() was
legitamately enforcing that devices to be deleted were not current
actively attached to any driver nor assigned any capacity from the
region.

As a result of the device_lock restoration in delete_store(), the
conditional locking in unregister_dev_dax() and unregister_dax_mapping()
can be removed.

Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
Reported-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/dax/bus.c | 42 ++++++++----------------------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 7924dd542a13..e2c7354ce328 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -465,26 +465,17 @@ static void free_dev_dax_ranges(struct dev_dax *dev_dax)
 		trim_dev_dax_range(dev_dax);
 }
 
-static void __unregister_dev_dax(void *dev)
+static void unregister_dev_dax(void *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 
 	dev_dbg(dev, "%s\n", __func__);
 
+	down_write(&dax_region_rwsem);
 	kill_dev_dax(dev_dax);
 	device_del(dev);
 	free_dev_dax_ranges(dev_dax);
 	put_device(dev);
-}
-
-static void unregister_dev_dax(void *dev)
-{
-	if (rwsem_is_locked(&dax_region_rwsem))
-		return __unregister_dev_dax(dev);
-
-	if (WARN_ON_ONCE(down_write_killable(&dax_region_rwsem) != 0))
-		return;
-	__unregister_dev_dax(dev);
 	up_write(&dax_region_rwsem);
 }
 
@@ -560,15 +551,10 @@ static ssize_t delete_store(struct device *dev, struct device_attribute *attr,
 	if (!victim)
 		return -ENXIO;
 
-	rc = down_write_killable(&dax_region_rwsem);
-	if (rc)
-		return rc;
-	rc = down_write_killable(&dax_dev_rwsem);
-	if (rc) {
-		up_write(&dax_region_rwsem);
-		return rc;
-	}
+	device_lock(dev);
+	device_lock(victim);
 	dev_dax = to_dev_dax(victim);
+	down_write(&dax_dev_rwsem);
 	if (victim->driver || dev_dax_size(dev_dax))
 		rc = -EBUSY;
 	else {
@@ -589,11 +575,12 @@ static ssize_t delete_store(struct device *dev, struct device_attribute *attr,
 			rc = -EBUSY;
 	}
 	up_write(&dax_dev_rwsem);
+	device_unlock(victim);
 
 	/* won the race to invalidate the device, clean it up */
 	if (do_del)
 		devm_release_action(dev, unregister_dev_dax, victim);
-	up_write(&dax_region_rwsem);
+	device_unlock(dev);
 	put_device(victim);
 
 	return rc;
@@ -705,7 +692,7 @@ static void dax_mapping_release(struct device *dev)
 	put_device(parent);
 }
 
-static void __unregister_dax_mapping(void *data)
+static void unregister_dax_mapping(void *data)
 {
 	struct device *dev = data;
 	struct dax_mapping *mapping = to_dax_mapping(dev);
@@ -713,25 +700,12 @@ static void __unregister_dax_mapping(void *data)
 
 	dev_dbg(dev, "%s\n", __func__);
 
-	lockdep_assert_held_write(&dax_region_rwsem);
-
 	dev_dax->ranges[mapping->range_id].mapping = NULL;
 	mapping->range_id = -1;
 
 	device_unregister(dev);
 }
 
-static void unregister_dax_mapping(void *data)
-{
-	if (rwsem_is_locked(&dax_region_rwsem))
-		return __unregister_dax_mapping(data);
-
-	if (WARN_ON_ONCE(down_write_killable(&dax_region_rwsem) != 0))
-		return;
-	__unregister_dax_mapping(data);
-	up_write(&dax_region_rwsem);
-}
-
 static struct dev_dax_range *get_dax_range(struct device *dev)
 {
 	struct dax_mapping *mapping = to_dax_mapping(dev);

-- 
2.44.0


