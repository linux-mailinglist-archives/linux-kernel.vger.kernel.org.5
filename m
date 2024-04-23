Return-Path: <linux-kernel+bounces-155868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0858AF835
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0ADFB2657F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B591448C0;
	Tue, 23 Apr 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhgR6eEB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07035143881;
	Tue, 23 Apr 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905188; cv=none; b=oIMf09SP5V5KVlWp5VK1lZHrXgDvUiI2pBZyNHd6Oc5hjqUvqn/VYFOHeRl8bK/W3rZ6TgWVZEfNrIFJJ2H1zt1CVnP7W8NRD+eyp3zYzkUL8XwMOJ5vpzSTwiVUNgtyzhnL9iseIsbVWln8NhC6yEwphrePFedx+IdrfHdb208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905188; c=relaxed/simple;
	bh=8Ynf/Pm+14Q4LJbIb6hfnZAW5/G6gUx7m7m0EFyWFBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddbd0yquHFKnIpuw4rrP5hJdQKENSVHf8s7cpHKOXyLedHlpzDyWZ/NDC+ykOYCXBJJ80NbFJGjNGdaolm0xw7jEZSYBjU2IEVlhHII6S7QRgN05YPUtl9X6S7GhzhDucT1CTNVBcmmN3QDPsvptdb4SsjbgZaPzpJqQw+iR7gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhgR6eEB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713905187; x=1745441187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Ynf/Pm+14Q4LJbIb6hfnZAW5/G6gUx7m7m0EFyWFBo=;
  b=lhgR6eEBmvHnDWW5La/MfxJJYP6jRkOcYwPsoG9oeKR30EdJRWUaJAdC
   SQNo+e3alpE6sm70AKlcfqh97lN+czK2508ZagWNnO05730LFc7vIi+nN
   kw+OwW7iNgwkZTrW7RhF/rWOxACfygZAU+RO6Z6jGuUGtP5rNoITl/B90
   Vufb1kp3O7MEDMNrllxM+J46tFQiNOGh+fjBrGKPfdg7gPA8J32Ca9tW5
   xfeCOJL6NjzLAsMV/bt9PIe6HsvDC0vUdbWFDCQkNZ3kqtXwJBwh4jrid
   fWhVZLLO/NkB1mNrCKIomQHZa6A3OYxPrjDwdVPrj4IM/cYoQz8MDiVNH
   A==;
X-CSE-ConnectionGUID: rYou+DyqTOmzs2psF60Xfw==
X-CSE-MsgGUID: /JRBjFzfSFSX37rqersWbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34912328"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34912328"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:46:24 -0700
X-CSE-ConnectionGUID: G8CsckxyQ3eULXmtEoTyOg==
X-CSE-MsgGUID: mnmGiIUwTZ+2UxerMoRWBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24533087"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa010.fm.intel.com with ESMTP; 23 Apr 2024 13:46:24 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 06/10] platform/x86: ISST: Shorten the assignments for power_domain_info
Date: Tue, 23 Apr 2024 13:46:15 -0700
Message-Id: <20240423204619.3946901-7-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
References: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of long lines for assignment to tpmi_sst->power_domain_info, use
a local variable pd_info and assign later. Also move the assignment
of number of resources after the assignment of pd_info.

No functional change is expected.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 33 +++++++++----------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 4e09a5611aca..49d573fcbd72 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1271,6 +1271,7 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 
 int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 {
+	struct tpmi_per_power_domain_info *pd_info;
 	bool read_blocked = 0, write_blocked = 0;
 	struct intel_tpmi_plat_info *plat_info;
 	struct device *dev = &auxdev->dev;
@@ -1311,35 +1312,31 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 	if (!tpmi_sst)
 		return -ENOMEM;
 
-	tpmi_sst->power_domain_info = devm_kcalloc(dev, num_resources,
-						   sizeof(*tpmi_sst->power_domain_info),
-						   GFP_KERNEL);
-	if (!tpmi_sst->power_domain_info)
+	pd_info = devm_kcalloc(dev, num_resources, sizeof(*pd_info), GFP_KERNEL);
+	if (!pd_info)
 		return -ENOMEM;
 
-	tpmi_sst->number_of_power_domains = num_resources;
-
 	for (i = 0; i < num_resources; ++i) {
 		struct resource *res;
 
 		res = tpmi_get_resource_at_index(auxdev, i);
 		if (!res) {
-			tpmi_sst->power_domain_info[i].sst_base = NULL;
+			pd_info[i].sst_base = NULL;
 			continue;
 		}
 
-		tpmi_sst->power_domain_info[i].package_id = pkg;
-		tpmi_sst->power_domain_info[i].power_domain_id = i;
-		tpmi_sst->power_domain_info[i].auxdev = auxdev;
-		tpmi_sst->power_domain_info[i].write_blocked = write_blocked;
-		tpmi_sst->power_domain_info[i].sst_base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(tpmi_sst->power_domain_info[i].sst_base))
-			return PTR_ERR(tpmi_sst->power_domain_info[i].sst_base);
+		pd_info[i].package_id = pkg;
+		pd_info[i].power_domain_id = i;
+		pd_info[i].auxdev = auxdev;
+		pd_info[i].write_blocked = write_blocked;
+		pd_info[i].sst_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(pd_info[i].sst_base))
+			return PTR_ERR(pd_info[i].sst_base);
 
-		ret = sst_main(auxdev, &tpmi_sst->power_domain_info[i]);
+		ret = sst_main(auxdev, &pd_info[i]);
 		if (ret) {
-			devm_iounmap(dev, tpmi_sst->power_domain_info[i].sst_base);
-			tpmi_sst->power_domain_info[i].sst_base =  NULL;
+			devm_iounmap(dev, pd_info[i].sst_base);
+			pd_info[i].sst_base = NULL;
 			continue;
 		}
 
@@ -1350,6 +1347,8 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 		return -ENODEV;
 
 	tpmi_sst->package_id = pkg;
+	tpmi_sst->power_domain_info = pd_info;
+	tpmi_sst->number_of_power_domains = num_resources;
 	auxiliary_set_drvdata(auxdev, tpmi_sst);
 
 	mutex_lock(&isst_tpmi_dev_lock);
-- 
2.40.1


