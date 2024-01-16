Return-Path: <linux-kernel+bounces-26952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E7382E873
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3D01F23736
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0A379E2;
	Tue, 16 Jan 2024 04:12:05 +0000 (UTC)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5D79C0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="134626161"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="134626161"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:11:53 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6671CD618D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:11:51 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9CAA9C5CC2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:11:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2B9A8200983D8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:11:50 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B8DF51A0160;
	Tue, 16 Jan 2024 12:11:49 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/42] arch/arm/mm: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:10:49 +0800
Message-Id: <20240116041129.3937800-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116041129.3937800-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.004
X-TMASE-Result: 10--8.585000-10.000000
X-TMASE-MatchedRID: 6SYb29c3rTQ4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckIP+
	YDa/Dhu9O3wTUW8jWH5M0AWQBBcXdpRSkbxKeJc4rMZ+BqQt2NoUifIaLms/AsC5DTEMxpeQfiq
	1gj2xET/gr0WZ6u+ypaeNx/Zz/USXzYigC8AbwLLfSQNpZkETVH0tCKdnhB58I/9UW5M5dRM+8F
	JNGdxYq46HM5rqDwqtJxiHvT5zQ4vlRDUzkOYMqBVC0mL9ZRV4EWtJOIHOjS/zvPuoTJCGYg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./arch/arm/mm/cache-l2x0-pmu.c:346:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Russell King <linux@armlinux.org.uk>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 arch/arm/mm/cache-l2x0-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 993fefdc167a..a9bd05b82003 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -343,7 +343,7 @@ static ssize_t l2x0_pmu_event_show(struct device *dev,
 	struct l2x0_event_attribute *lattr;
 
 	lattr = container_of(attr, typeof(*lattr), attr);
-	return snprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
+	return sysfs_emit(buf, "config=0x%x\n", lattr->config);
 }
 
 static umode_t l2x0_pmu_event_attr_is_visible(struct kobject *kobj,
-- 
2.29.2


