Return-Path: <linux-kernel+bounces-164547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DED58B7F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF47281777
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE8D19066E;
	Tue, 30 Apr 2024 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggqfmnTI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D88618133A;
	Tue, 30 Apr 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499086; cv=none; b=Z3Hfi5ImXy0F+BN3PCsUM9ZNfN5+QNSShB2Ud0NhLt0XPWAd+BvPiny+cmfZG4e7tnrqHo7jEYiUZYx5jOHIU0Z9SAxnKfWsBaT9Aac5ZEuzvqIjrcFAHLdNn7cCkJBP0jRB2btAwQcWcUIJ5E1Mn7vYIu77tOfbsLR5VGwlKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499086; c=relaxed/simple;
	bh=NhTlptPmEedEHUiT46vqy1jTU5giIPfdgp2TteFj/UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HjrAfEb5F18yGvLEKcDfp0x+qIqxvi6M5SOgZ8FOKKcH6uCW+GyFD3PgsibyQTKF6ZnS5kz/5EHhawRx9rnbj/jbLFfOlLuQGYdt40OJEWtviDOvXH5WOJJrv+2oxs5ssM3pftYTlx34q4Y7WcF5255YNKuamUcFcVvmHUkKSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggqfmnTI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714499084; x=1746035084;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NhTlptPmEedEHUiT46vqy1jTU5giIPfdgp2TteFj/UU=;
  b=ggqfmnTI6RzGiyCpqI9k5msSlrX6ul5iw2pJkLPEjg8BrNapP1dT6zeC
   HsfSJfeBvi5nzQa82qg8HJrCrk74sWG0csBwY0pkZW1x7WWIFpapm6+iV
   dhjmV0uEj4KmN1gz+nnwzBBnf55B6KOpxdIq0dnY4Tn79/DfAuJy/gzMA
   jBlcJkDiNCO7GKfCqwnMSgYBUxSjlvXvbN8/no9NyGeqUl6nVkpWaNPpH
   BDTtP/onhsWT7U0V3LUBw7BHWvwkjyOYR4C4YHnLpgOhO5LY9hYl87Ru7
   l3iC1IihlseNnSEUCAiElZ1wGkk6VP0p7w9BEZqSQDcdtBVpxzB3EMQ1H
   Q==;
X-CSE-ConnectionGUID: znT0yRx4RU2+t9DF9zfAfw==
X-CSE-MsgGUID: 8ygP5gO9SzO32bhZJqX6GA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="27669841"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="27669841"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:44:42 -0700
X-CSE-ConnectionGUID: MTZbRtiIT46p1EZt8gC0Xw==
X-CSE-MsgGUID: PtnL8bTtQJuz5mXOFvW8pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26534780"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.82.45])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:44:42 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Tue, 30 Apr 2024 11:44:25 -0600
Subject: [PATCH v3 3/4] dax/bus.c: Don't use down_write_killable for
 non-user processes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-vv-dax_abi_fixes-v3-3-e3dcd755774c@intel.com>
References: <20240430-vv-dax_abi_fixes-v3-0-e3dcd755774c@intel.com>
In-Reply-To: <20240430-vv-dax_abi_fixes-v3-0-e3dcd755774c@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.14-dev-5ce50
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=NhTlptPmEedEHUiT46vqy1jTU5giIPfdgp2TteFj/UU=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDGmGehxcG/a8TGZ7GGendtTw8nyFaR2CS4KDrHMureQTe
 8XOJx7RUcrCIMbFICumyPJ3z0fGY3Lb83kCExxh5rAygQxh4OIUgIl4tTEy/F+18KzNXK/pAbHM
 YZzhbhWfskIF/QLXnjxRPZ95RabIdob/yWsvbDY4MY9zwd3/egXFfE36dhuc1cQ9lx8WVVhUH3i
 FGwA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

Change an instance of down_write_killable() to a simple down_write() where
there is no user process that might want to interrupt the operation.

Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
Reported-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/dax/bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index e2c7354ce328..0011a6e6a8f2 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1540,12 +1540,8 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 {
 	struct dev_dax *dev_dax;
-	int rc;
-
-	rc = down_write_killable(&dax_region_rwsem);
-	if (rc)
-		return ERR_PTR(rc);
 
+	down_write(&dax_region_rwsem);
 	dev_dax = __devm_create_dev_dax(data);
 	up_write(&dax_region_rwsem);
 

-- 
2.44.0


