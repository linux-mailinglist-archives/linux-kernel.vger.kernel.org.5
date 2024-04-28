Return-Path: <linux-kernel+bounces-161266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3365B8B49D6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652E51C20AFD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5886FA7;
	Sun, 28 Apr 2024 05:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ftm4YHUE"
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC8539A;
	Sun, 28 Apr 2024 05:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714282659; cv=none; b=EiS2V67Z2LVQJDQ+NUisXtTpjMTDo4lZA0Jcv55idhmP2G2HCSj4+0YDy1u6dbsSq68E/BlC+v9Q1ZVxR6k+ha5byTq4Le6Z8M9CSPwofU/IKOKkO2OKxvBj0565aENqSYuF+MoYlDE0ViVGemDDi0KRwb6dalAvsnYmZzPtVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714282659; c=relaxed/simple;
	bh=PaE6ax4QmX/HhnTs8HhMqfa8MzrpfD8uyWaaK4HrJSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m8RCxMOgHQIPfLxPDKHGnOquObgl2im5ofYou9/07Rayyhyj8dcjV2a5VPUS9CI0Jh1zGgRY4AvblaoAfANwlulhh+FxIFSwYZibIr6tk8OkufqXsGAieUEOd6kVVAC6ZEYjZvUniwgPh6rqEKaLskv3PS70YF9VeVBHcTUBw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ftm4YHUE; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1714282656; x=1745818656;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PaE6ax4QmX/HhnTs8HhMqfa8MzrpfD8uyWaaK4HrJSk=;
  b=ftm4YHUEnsOxy+Ea+cQU7iyjrNPYtaguWWTt339aXX5fbHf/gbTY5eT2
   HmJT/11xrl14BDL63dsQuSqZ8RSn5foVyMRTePQy5gnPc922Yn/3MUuHW
   WMOu8S+yCdfiko79wRaI4Maa4eeLebDePV6m+AmWN3zCOH/xvqYZryhAc
   7v+6vlA8ICNEO0j5AOgwmDCrO8NdevwuDW3+0ADzz8skU4WPeBkgfbhjJ
   84ZAxoRmRfjwmvRZagH8bynbwxjgJ8J0czTZKpoV7e7wg7HYawj/10986
   1O72gJFN6m3gxPCE9BotqhJA1mpa3N6OluIw8RWkC4pZybKLiRnGDjNNk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="136329096"
X-IronPort-AV: E=Sophos;i="6.07,236,1708354800"; 
   d="scan'208";a="136329096"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 14:37:27 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id F0C17D9DB7;
	Sun, 28 Apr 2024 14:37:24 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1E8D352491;
	Sun, 28 Apr 2024 14:37:24 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8F93E20091434;
	Sun, 28 Apr 2024 14:37:23 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id A53961A0002;
	Sun, 28 Apr 2024 13:37:22 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] cxl/region: Fix memregion leaks in devm_cxl_add_region()
Date: Sun, 28 Apr 2024 13:37:15 +0800
Message-Id: <20240428053715.327444-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28348.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28348.005
X-TMASE-Result: 10--2.684300-10.000000
X-TMASE-MatchedRID: RtHHqK+8YWP75cEN6/qvTKoXHZz/dXlxG24YVeuZGmPAuQ0xDMaXkH4q
	tYI9sRE/L2EYbInFI5vOFmC5kH12JjmpL9mXE1+szr16YOzjZ11YMtqMzbYRNsfASe7knCttvov
	cnF8n89/i8zVgXoAltuJ5hXsnxp7jC24oEZ6SpSmcfuxsiY4QFFp3bogl53+pQFLFy95C7ElulB
	LEUQ16Nptnho2B3IzFjhUUlHERxbWqkxn7jYOWbW/ptvynGFw2N7hJehVG5Wvxva4W570igpsNE
	GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Move memregion_free(id) out of cxl_region_alloc() and
explicately free memregion in devm_cxl_add_region() error path.

After cxl_region_alloc() succeed, memregion will be freed by
cxl_region_type.release()

Fixes: 6e099264185d ("cxl/region: Add volatile region creation support")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/cxl/core/region.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 812b2948b6c6..8535718a20f0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2250,10 +2250,8 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 	struct device *dev;
 
 	cxlr = kzalloc(sizeof(*cxlr), GFP_KERNEL);
-	if (!cxlr) {
-		memregion_free(id);
+	if (!cxlr)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	dev = &cxlr->dev;
 	device_initialize(dev);
@@ -2358,12 +2356,15 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 		break;
 	default:
 		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
+		memregion_free(id);
 		return ERR_PTR(-EINVAL);
 	}
 
 	cxlr = cxl_region_alloc(cxlrd, id);
-	if (IS_ERR(cxlr))
+	if (IS_ERR(cxlr)) {
+		memregion_free(id);
 		return cxlr;
+	}
 	cxlr->mode = mode;
 	cxlr->type = type;
 
-- 
2.29.2


