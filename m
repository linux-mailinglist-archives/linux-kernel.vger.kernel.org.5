Return-Path: <linux-kernel+bounces-128675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E14895E00
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C07D286315
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B8A15E1E4;
	Tue,  2 Apr 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3Qs0mFP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BFA1E4AE;
	Tue,  2 Apr 2024 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090882; cv=none; b=a6IYda1M4pYHXHM49NbLyPXxRhNhYEcBJAHRSTAsbP1/PqVmH8JTL87eYWsAPnqftAZ/O49Nz3aZdI9VqWhGxXFnVgrOVtiSYo0skHZPswPuU/wpo/P2HKZ0Ne+y/o6KlxMaNjq4bXqY9u6LuTn4LrfuiKnufJ+1V697Jk/WAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090882; c=relaxed/simple;
	bh=O4EE+8JYmgEDbA6Lqhv249ruqQwRW5Y8TLOMHMU3C+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AevVpg88FbQqUk9XFMCb2Nn6qTzewNmqVH9/DUQscycu4P86r1u+zTVTjW2aAFxkCXIGGn9/Mnfa6QRQgvTGhDX+9kIvfEAQdwM+piRHDvDCdfaVJ+X82VL4ay8/hg21NEdONIID9gWBE9q/cowiKvDr4VdFNmTgLDzqMCDnLf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3Qs0mFP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712090880; x=1743626880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O4EE+8JYmgEDbA6Lqhv249ruqQwRW5Y8TLOMHMU3C+A=;
  b=g3Qs0mFPPAP43zvVo+xMmA2XsItASNbzwi91wNiRFkbldx+Z9uxY2t/p
   dYmC9BPa80AmZu01eYqbC+xPhMFQVn90FF9k+ZzkiGxr/CSxXLmtmhEh5
   f7uqqN0ihP7uONXklOUZpvJ/fOMEmqbwsdMMSQ4pRYtFNoeuzaXXef5Fi
   DkOYh4hmV1gQ/GVF9OyIa5mu/yBLsktGxMGPMYzlTZK3DEQsABqlwbnGD
   jghCiCaMR14ZfD7QMi4/P1G/AHbjxLbxj5TeKgELRGpOSWhKAN/ELVntC
   3lpKohHRubPekHndbPzyrbp8wCDIFmXyhsT2DPmybwAJVk91pzSdNmh7u
   A==;
X-CSE-ConnectionGUID: ecvDZd2GTf+6l04+SFEVow==
X-CSE-MsgGUID: JdBsFWU+QtSBpiyAwTD06Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7217060"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7217060"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 13:47:59 -0700
X-CSE-ConnectionGUID: 7/Qh/N4PQ2ubLJuGzHCiYg==
X-CSE-MsgGUID: SpK/FaZ+QtKGexKHXPoagQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18099330"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 13:47:59 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Alan Tull <atull@kernel.org>,
	Shiva Rao <shiva.rao@intel.com>,
	Kang Luwei <luwei.kang@intel.com>,
	Enno Luebbers <enno.luebbers@intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	kernel test robot <lkp@intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v2] fpga: dfl: fme: revise kernel-doc comments for some functions
Date: Tue,  2 Apr 2024 16:47:43 -0400
Message-ID: <20240402204743.1069624-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yilun <yilun.xu@intel.com>

This amends commit 782d8e61b5d6 ("fpga: dfl: kernel-doc corrections"),
which separately addressed the kernel-doc warnings below. Add a more
precise description of the feature argument to dfl_fme_create_mgr(),
and also use plural in the description of dfl_fme_destroy_bridges().

lkp reported 2 build warnings:

   drivers/fpga/dfl/dfl-fme-pr.c:175: warning: Function parameter or member 'feature' not described in 'dfl_fme_create_mgr'

>> drivers/fpga/dfl/dfl-fme-pr.c:280: warning: expecting prototype for
>> dfl_fme_destroy_bridge(). Prototype was for dfl_fme_destroy_bridges()
>> instead

Fixes: 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
v2:
- Correctly rebase patch onto commit 782d8e61b5d6.
---
 drivers/fpga/dfl-fme-pr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index cdcf6dea4cc9..b66f2c1e10a9 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -164,7 +164,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 
 /**
  * dfl_fme_create_mgr - create fpga mgr platform device as child device
- * @feature: sub feature info
+ * @feature: the dfl fme PR sub feature
  * @pdata: fme platform_device's pdata
  *
  * Return: mgr platform device if successful, and error code otherwise.
@@ -273,7 +273,7 @@ static void dfl_fme_destroy_bridge(struct dfl_fme_bridge *fme_br)
 }
 
 /**
- * dfl_fme_destroy_bridges - destroy all fpga bridge platform device
+ * dfl_fme_destroy_bridges - destroy all fpga bridge platform devices
  * @pdata: fme platform device's pdata
  */
 static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pdata)
-- 
2.44.0


