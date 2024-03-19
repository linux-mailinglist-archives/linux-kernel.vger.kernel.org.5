Return-Path: <linux-kernel+bounces-107020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98E287F6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073271C2183A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E51353378;
	Tue, 19 Mar 2024 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="V6Caiv/K"
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A17C446A4;
	Tue, 19 Mar 2024 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827154; cv=none; b=NNOgL8J8uAgbo9ybY1qtWYHbLwY3rprgxXi2zfIy9AtycmigFixQqA0LAYihgOL7fh1Ep0T9Ak+Oylgvv++bbpj1LGb6ESnCV/FM8o+sxHr2QgyeHy5B4DhJMZHZPFx3v3kTtIo250KieeSKj+xApb6aIMsg38AEggY3Pgfzh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827154; c=relaxed/simple;
	bh=9LwcHb5I/PqBxCGsw2jSjTsarGi71YCxE7eSH5fG7Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mi9h/rZ6zF5cfAPI+N8YWHccVkLuQECqo/5UoqpUBG6UjzQga3vfblfK6oVsyD8BJZ6759UUSxhqAuA5L+JBqe3zCPvfIjdeZdqWTCMaLWYU35FSM3AeKdceeKNMUtB1W10PpnaXtzjK1YK7Zoj3S1FVEBZrtNmPS1TYmCAj4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=V6Caiv/K; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710827153; x=1742363153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9LwcHb5I/PqBxCGsw2jSjTsarGi71YCxE7eSH5fG7Gg=;
  b=V6Caiv/KOvtKxotvKZ+89711Kt22M8jICFpZF8pDRd+KTyCX8UpmOpRu
   eWmA9MLqwF+ZAtzJyVsHOghnVCAa7vb11bXCQwjd3bMcOUtNVHFYr3/AN
   ieyFApvYYogGijfKmiMtpQnXAmsrb7FJfFUV5zuqxs4uNn8dLBTYXlJb2
   XjOapWakQO+tdfpLM/uw05R6bvWDCxN4MYEA+S33sw7KqwVH4GIe7VshR
   PmsW9m1kj6r45LP+GCy4PMb2cL6mhGchQrO2+QGJZlM5WJkq4n1YcnrqQ
   4VeiPPc08TF2KnK+5TTF355Vj/BAg01uiGx8RsBFo2EeFTOixc/56ilw5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="132057739"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="132057739"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 14:45:43 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 22F2DE5E85;
	Tue, 19 Mar 2024 14:45:40 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 62997D7B91;
	Tue, 19 Mar 2024 14:45:39 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id EF37D2235E1;
	Tue, 19 Mar 2024 14:45:38 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 38E1A1A006D;
	Tue, 19 Mar 2024 13:45:38 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 2/4] HID: hid-sensor-custom: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 13:45:25 +0800
Message-Id: <20240319054527.1581299-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240319054527.1581299-1-lizhijian@fujitsu.com>
References: <20240319054527.1581299-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.005
X-TMASE-Result: 10--5.660400-10.000000
X-TMASE-MatchedRID: BNZKu07XGZ9zKOD0ULzeCR1kSRHxj+Z5w77CRCdy4LzXFJ7W3lIp4x2r
	rGe8rZbLPsj5qjS+dCHKSyLhniwKzf+tuWXZk8lIEVuC0eNRYvJxXefgn/TNQ2O0yVK/5LmccxZ
	+avxQRTyEkt/L8HtAJ785xNkZcrN2ePWEUnWb98FBDn6Fjq77jvioIsi7Sa0gwLkNMQzGl5B+Kr
	WCPbERPznpYPqS6jzxEi2pD9yuITrh15/JKUJo/p4CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyH4gK
	q42LRYkBr/OIWYnO5hWUxEG9fqrIWdrYeVp6egUSuBokyF9P6R+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() and scnprintf() will be converted as well if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Jiri Kosina <jikos@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: linux-input@vger.kernel.org
CC: linux-iio@vger.kernel.org
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
   rewrap the line as will be under 80 chars and add Reviewed-by # Jonathan
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/hid/hid-sensor-custom.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index d85398721659..ac214777d7d9 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -155,7 +155,7 @@ static ssize_t enable_sensor_show(struct device *dev,
 {
 	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", sensor_inst->enable);
+	return sysfs_emit(buf, "%d\n", sensor_inst->enable);
 }
 
 static int set_power_report_state(struct hid_sensor_custom *sensor_inst,
@@ -372,14 +372,13 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 				     sizeof(struct hid_custom_usage_desc),
 				     usage_id_cmp);
 		if (usage_desc)
-			return snprintf(buf, PAGE_SIZE, "%s\n",
-					usage_desc->desc);
+			return sysfs_emit(buf, "%s\n", usage_desc->desc);
 		else
-			return sprintf(buf, "not-specified\n");
+			return sysfs_emit(buf, "not-specified\n");
 	 } else
 		return -EINVAL;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t store_value(struct device *dev, struct device_attribute *attr,
-- 
2.29.2


