Return-Path: <linux-kernel+bounces-164544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F205E8B7F25
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFEB1C2333C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47180181BAF;
	Tue, 30 Apr 2024 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AeMrYl1N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66461527A4;
	Tue, 30 Apr 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499084; cv=none; b=LkDOK1ldlo9vX2IS/QEpuwVG4zE817Pz/BOJekjH84R4A2l2xXzebcTMmNfThlKjFmhYFvU2MJrGoDirfWio6iciQJdATyCMyfYOFpADf9TmqRCXA3GlntRBowm7m/9n0WBUP56atVfhPYK2TuWbiD9kX7NfzJ1L3rdM6Hgp/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499084; c=relaxed/simple;
	bh=gio3jLLisOYiwSCHgts3s1OVVKVXVcSqgOny8/3ijS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ao98sSkqvBar3a7M79Krq4nwzojUAvxzLy17Ivf3R5Vzq9XXILCCeXLGZhjONMX2wM1Jh4Un9JcsAVs+1h42eU+ez6r/dUzf+Ba/v+bhLTiNfL6QIFjfaxtfc14WfpcDOEReITjQJnHtXuu6lq21bMxBrlmVnEYX2gEQDp/d+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AeMrYl1N; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714499083; x=1746035083;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gio3jLLisOYiwSCHgts3s1OVVKVXVcSqgOny8/3ijS8=;
  b=AeMrYl1NM56Svp3SF2rt0cDlnOVGLhmTttPukEx0wnxMa1bOBHKEj5cx
   GnR+cy5aXB65fQHs+A4KVcKYohtTw6XtB5W820iBZQ/UcFmviH9RDId/r
   1VXEkCP0MgeNxK+gEW9yCJlWtelUoagUtOY3pnwGqfJ+cD/NataLRWhsN
   hnJU/PwWIAoBdU3Ex3ljMhyD93VOeYMEUZhfp8dRVy4w4z4Wko32T4AIT
   eaebjkT4H5YCB5mF4Vh9Asj0G0ayv8LmIqEJ3CetAE2OlueSPLXHpu4dX
   Bzy3TAjURHfQ1q2a4B8vlN+5dtWie6iBN2nCXFduRn8ND2NX8n6jjGNJ+
   w==;
X-CSE-ConnectionGUID: DG5DnNl/RJGtKV5QFWby0w==
X-CSE-MsgGUID: AMBCpB0oQfKgUPSIpNtvIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="27669833"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="27669833"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:44:41 -0700
X-CSE-ConnectionGUID: vUHJ8AZ/ROSdvFB65Gqnzg==
X-CSE-MsgGUID: 3yH+c089QruBFvwvGrcGMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26534774"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.82.45])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:44:41 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Tue, 30 Apr 2024 11:44:23 -0600
Subject: [PATCH v3 1/4] dax/bus.c: replace WARN_ON_ONCE() with lockdep
 asserts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-vv-dax_abi_fixes-v3-1-e3dcd755774c@intel.com>
References: <20240430-vv-dax_abi_fixes-v3-0-e3dcd755774c@intel.com>
In-Reply-To: <20240430-vv-dax_abi_fixes-v3-0-e3dcd755774c@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.14-dev-5ce50
X-Developer-Signature: v=1; a=openpgp-sha256; l=3512;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=gio3jLLisOYiwSCHgts3s1OVVKVXVcSqgOny8/3ijS8=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDGmGehy/X3i2bl5UXHXK9oJR6df6WDNr/ogFV+0jdzSKn
 Dv5W4ito5SFQYyLQVZMkeXvno+Mx+S25/MEJjjCzGFlAhnCwMUpABM5c5bhf27l+tfGXX8Yrwkp
 mor1nb0wtbx2WkdNe9UlkWtu66O2XWJkOGLO9bQoViY29766nXvdvIxXs6+KyS/8NDW1qfTjh2u
 aPAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

In [1], Dan points out that all of the WARN_ON_ONCE() usage in the
referenced patch should be replaced with lockdep_assert_held, or
lockdep_held_assert_write(). Replace these as appropriate.

Link: https://lore.kernel.org/r/65f0b5ef41817_aa222941a@dwillia2-mobl3.amr.corp.intel.com.notmuch [1]
Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/dax/bus.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 797e1ebff299..7924dd542a13 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -192,7 +192,7 @@ static u64 dev_dax_size(struct dev_dax *dev_dax)
 	u64 size = 0;
 	int i;
 
-	WARN_ON_ONCE(!rwsem_is_locked(&dax_dev_rwsem));
+	lockdep_assert_held(&dax_dev_rwsem);
 
 	for (i = 0; i < dev_dax->nr_range; i++)
 		size += range_len(&dev_dax->ranges[i].range);
@@ -302,7 +302,7 @@ static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
 	resource_size_t size = resource_size(&dax_region->res);
 	struct resource *res;
 
-	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
+	lockdep_assert_held(&dax_region_rwsem);
 
 	for_each_dax_region_resource(dax_region, res)
 		size -= resource_size(res);
@@ -447,7 +447,7 @@ static void trim_dev_dax_range(struct dev_dax *dev_dax)
 	struct range *range = &dev_dax->ranges[i].range;
 	struct dax_region *dax_region = dev_dax->region;
 
-	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
+	lockdep_assert_held_write(&dax_region_rwsem);
 	dev_dbg(&dev_dax->dev, "delete range[%d]: %#llx:%#llx\n", i,
 		(unsigned long long)range->start,
 		(unsigned long long)range->end);
@@ -507,7 +507,7 @@ static int __free_dev_dax_id(struct dev_dax *dev_dax)
 	struct dax_region *dax_region;
 	int rc = dev_dax->id;
 
-	WARN_ON_ONCE(!rwsem_is_locked(&dax_dev_rwsem));
+	lockdep_assert_held_write(&dax_dev_rwsem);
 
 	if (!dev_dax->dyn_id || dev_dax->id < 0)
 		return -1;
@@ -713,7 +713,7 @@ static void __unregister_dax_mapping(void *data)
 
 	dev_dbg(dev, "%s\n", __func__);
 
-	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
+	lockdep_assert_held_write(&dax_region_rwsem);
 
 	dev_dax->ranges[mapping->range_id].mapping = NULL;
 	mapping->range_id = -1;
@@ -830,7 +830,7 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 	struct device *dev;
 	int rc;
 
-	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
+	lockdep_assert_held_write(&dax_region_rwsem);
 
 	if (dev_WARN_ONCE(&dev_dax->dev, !dax_region->dev->driver,
 				"region disabled\n"))
@@ -876,7 +876,7 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 	struct resource *alloc;
 	int i, rc;
 
-	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
+	lockdep_assert_held_write(&dax_region_rwsem);
 
 	/* handle the seed alloc special case */
 	if (!size) {
@@ -935,7 +935,7 @@ static int adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res, r
 	struct device *dev = &dev_dax->dev;
 	int rc;
 
-	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
+	lockdep_assert_held_write(&dax_region_rwsem);
 
 	if (dev_WARN_ONCE(dev, !size, "deletion is handled by dev_dax_shrink\n"))
 		return -EINVAL;

-- 
2.44.0


