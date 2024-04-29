Return-Path: <linux-kernel+bounces-161667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F7B8B4F37
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73C3281EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08301C27;
	Mon, 29 Apr 2024 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QPVjxbt5"
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EC39B;
	Mon, 29 Apr 2024 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714354398; cv=none; b=Zw/ixUFSRTA11uU1UVXuVFB6Asa3b/J/mJvMfySFFQ3ZeYIH1/Z6DyqOENQnHTAtUHvRXfb0aTH71op17zc7lfg+w1f+nHfaXEc6rPzh9Lxnk5OYSxyPHhPTItfCVy+YhwdM2PClMuyeI7Pwgiozcf8chMo7xRo4pbDnYyzxsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714354398; c=relaxed/simple;
	bh=9C6faDAQEmad8o7+66WBO/zaYHnr/MM9Us0C56pm7/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+wYojX+hhItHM2dWOzB/xLbo+F2cYPign0FIwVslCXUPraNFSIUzRWHCYOVCs3Caa4iTmmsMIOqZvpIPfGspSjB8xFBO/IuLD7nbxua79D+rIw4qYr5K+ZZBXb+WJPQENmnPUTr8x576/5hZuFS889f46YPB0u0ubtv088XH70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QPVjxbt5; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1714354395; x=1745890395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9C6faDAQEmad8o7+66WBO/zaYHnr/MM9Us0C56pm7/Q=;
  b=QPVjxbt5mlda/cM9bIJndu+d7vckclgKEcEy4p8FN6/Haf4823WGz4Re
   1Y3wolz+P6efwj3SYJlL8O+1VYcKhBobBwHOm7a2+2z3YHsB5aNHxhFly
   q/cB7ioBgfI2jxtnR0w/ZOJa+iDkdOUmWyLcW450RcGvX2MTWYWVxVmme
   3qiZ2KwqPmP+uI1amcpwO6xGYDjbA91vT+EgJcNiOP6O0YB231ExserZ2
   QmrKoa3MUqD2mv4E781aWjnEECrQ2NDJsYMN3P34/uSzIhMahzcBqm3v1
   EZgBzkp66bVpK1nP+OA5sRrPWLlqDjMICv9BTkxo8ii1ovei8qFZ7rw0L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="135810658"
X-IronPort-AV: E=Sophos;i="6.07,238,1708354800"; 
   d="scan'208";a="135810658"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 10:32:02 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A302AC2AC3;
	Mon, 29 Apr 2024 10:32:00 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E0C0712F6E2;
	Mon, 29 Apr 2024 10:31:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 66196E206E;
	Mon, 29 Apr 2024 10:31:59 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id CA99C1A000C;
	Mon, 29 Apr 2024 09:31:58 +0800 (CST)
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
Subject: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Date: Mon, 29 Apr 2024 09:31:54 +0800
Message-Id: <20240429013154.368118-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429013154.368118-1-lizhijian@fujitsu.com>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28350.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28350.004
X-TMASE-Result: 10-1.444300-10.000000
X-TMASE-MatchedRID: MqppGi75AUU8c+bQ4YQ9BhmCYUYerLHrTFQnI+epPIY0DNPwjqLncGsW
	ZV9YMDBb9GF0M6TbxPxoVBGpf4JXIy/7QU2czuUNA9lly13c/gF13MofE6YQy5soi2XrUn/J8m+
	hzBStantdY+ZoWiLImydET58jp62SPXgxlenIvYLdnUkTfH1zvcYAUrvpAu24bUT0WFPJAlmhPe
	a+lnFpXh4wA+Ks4bAaZnUnCHe3cUAcpzLq5IeMIPVxvlzS0OquwGC8e6520fKw0PJt06oJaHpaQ
	l5xviY7wxgWdRvK9Un9g+oMf9KM6Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

>         mutex_lock(&cxlrd->range_lock);
>         region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
>                                        match_region_by_range);
>         if (!region_dev)
>                 cxlr = construct_region(cxlrd, cxled);
>         else
>                 cxlr = to_cxl_region(region_dev);
>         mutex_unlock(&cxlrd->range_lock);
>
>         rc = PTR_ERR_OR_ZERO(cxlr);
>         if (rc)
>                 goto out;
>
>         if (!region_dev)
>                 region_dev = &cxlr->dev;

When to_cxl_region(region_dev) fails, put_device(region_dev) should be
called to decrease the reference count added by device_find_child().

Simply put_device(region_dev) if region_dev is valid in the error path.

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/cxl/core/region.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3c80aa263a65..75390865382f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3117,8 +3117,9 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 				p->res);
 	}
 
-	put_device(region_dev);
 out:
+	if (region_dev)
+		put_device(region_dev);
 	put_device(cxlrd_dev);
 	return rc;
 }
-- 
2.29.2


