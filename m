Return-Path: <linux-kernel+bounces-105622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2452D87E1AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85481F21EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981D61D558;
	Mon, 18 Mar 2024 01:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="JdNraSZf"
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207632032D;
	Mon, 18 Mar 2024 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725343; cv=none; b=UpYyli2IZX8lV8fBevM72TdtBIgDnvSPLoeQETdUNnBz4mckgT/t8iWLyNdpdbAmboF+RMvTi6QSilhBG4nJTpN0YPf/Yo6RwwY9j+yT1Tu8QuS75YDcgXsifb4gXisYmVAgoFd5KbjCdOZczZipg9t3R3S/iYbgPl7UaXULs3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725343; c=relaxed/simple;
	bh=lEAICoD6xublrvyvwGo3OfFKv8FKH3HxG+GESGhe6oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=peYwfEpiFPoXFHfTEIQ2DKHzgBt40NqsvN9vi8rA+AeCj242ueGbimf2ZnJuTi57mZU5D7TzfBWf4UcehL3GjNGZo4Zs8GHdrqRIwhYp3tBRR4NLD+3ksycF0aIido0o/9CVP4JYCngnfooj2haRi063JkFEgJbbPER8IoQFmOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=JdNraSZf; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710725342; x=1742261342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lEAICoD6xublrvyvwGo3OfFKv8FKH3HxG+GESGhe6oc=;
  b=JdNraSZf/VPCf4r4QFUnGgq9ulAFuwCk8bz5aybzlQNem3bZnpa8/m+b
   PEobNAdmEzXmXvcfFrw6YSbZ2e3lHYMY2USpbhp/hm618Z51oXMI3vDEZ
   IjhvNOTXWirSF5Fm2SX1W1RK4bBA+GhcWnC8/aqNcoNNYEc3dn8pjyCjp
   +Ffem6fWMgcRdU9a9M+xSQFNpIehcTr2scuWgjBsK0r5m2JtuNneGrhI6
   3+M/vnYxJJsM9XLjELpnxxSE7wHV1m1fonyiGzjxnKFOncACiqzcLErm2
   XX2lSeLS2snb7UwnB9tg/Tgmrz0FgFni4WCAvOo45iXtQmGXzeX6huw+B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="154385599"
X-IronPort-AV: E=Sophos;i="6.07,133,1708354800"; 
   d="scan'208";a="154385599"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 10:28:52 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5EF95D9F03;
	Mon, 18 Mar 2024 10:28:49 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8FDA8D561E;
	Mon, 18 Mar 2024 10:28:48 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 19FA120098E1C;
	Mon, 18 Mar 2024 10:28:48 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 609231A006D;
	Mon, 18 Mar 2024 09:28:47 +0800 (CST)
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
Subject: [PATCH v3 2/4] HID: hid-sensor-custom: Convert sprintf/snprintf to sysfs_emit
Date: Mon, 18 Mar 2024 09:28:17 +0800
Message-Id: <20240318012819.1405003-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240318012819.1405003-1-lizhijian@fujitsu.com>
References: <20240318012819.1405003-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28258.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28258.003
X-TMASE-Result: 10--5.660400-10.000000
X-TMASE-MatchedRID: aug7Rh7TzMkI7eJeU5hen5iHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/0swHSFcVJ6OTpBuL72LoPQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSArq
	oIZrVn15fzUkBpc072hKK/bK+QypCR9GF2J2xqMxRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7tk/P
	KAEDs5ka64lbDnlTvs+39t8ZqOEjsNJi689wOTYNkUSDDq742k=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() will be converted as weel if they have.

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


