Return-Path: <linux-kernel+bounces-26989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDBB82E8D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8F9B22C93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCFD1D529;
	Tue, 16 Jan 2024 04:52:40 +0000 (UTC)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB71BF5E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="125018791"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="125018791"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:30 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 75CE2D7AE4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:52:28 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id B1E14D88DF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:52:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 521FF6B4C7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:52:27 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E8BF91A0070;
	Tue, 16 Jan 2024 12:52:26 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 42/42] kernel/cpu: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:51 +0800
Message-Id: <20240116045151.3940401-40-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116045151.3940401-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.005
X-TMASE-Result: 10--8.440000-10.000000
X-TMASE-MatchedRID: CncXHiplHCc4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckCj5
	3aEB5qDLe+eZU8eiw0ZM0AWQBBcXdpRSkbxKeJc4TuctSpiuWyUUi4Ehat0546MQi364g884JmV
	7j1WQqoeX81JAaXNO9negIXkiA/apHxPMjOKY7A+u65UDD0aDgsRB0bsfrpPIfiAqrjYtFiTSD7
	LVFuqzShTyJuDzjSSy44JuqCZ4XjOXA4DyqZTZ6X7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./kernel/cpu.c:3013:8-16: WARNING: please use sysfs_emit
> ./kernel/cpu.c:3026:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Thomas Gleixner <tglx@linutronix.de>
CC: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index a86972a91991..a36fcf4a9eb6 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3010,7 +3010,7 @@ static ssize_t control_show(struct device *dev,
 		return sysfs_emit(buf, "%d\n", cpu_smt_num_threads);
 #endif
 
-	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
+	return sysfs_emit(buf, "%s\n", state);
 }
 
 static ssize_t control_store(struct device *dev, struct device_attribute *attr,
@@ -3023,7 +3023,7 @@ static DEVICE_ATTR_RW(control);
 static ssize_t active_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
+	return sysfs_emit(buf, "%d\n", sched_smt_active());
 }
 static DEVICE_ATTR_RO(active);
 
-- 
2.29.2


