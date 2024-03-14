Return-Path: <linux-kernel+bounces-103006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98F587B9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96035283013
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B707E6E604;
	Thu, 14 Mar 2024 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GKOyCHSr"
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EF56E2BD;
	Thu, 14 Mar 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406121; cv=none; b=ud8I2y5GRPjzBlUZbjC74UOLqp1B6/NtCL+IxPMcgmYHJiTr0ie1sErIP0Ww0xKjSqdgyh5pNxygNCaM+kFHafMZPOGdEWCIfDraLYBQ7U1JGfBNXatDDGBesU2xUKIKZbAoGNcS33+yCt9RJq300X61T5eQqLWu8qlsPjiMIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406121; c=relaxed/simple;
	bh=KWHHw8AdrVa/yYww2f3tWcNpA+3ogD6g03jLdbzloxE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HmGOiI1cO+Wz25gfNMA7nl0igy+fkZqtIuywreTfbvvORxONUACiJEnsG7A3pxjP4UAwNZhdArMW510JR8leUCako6XIiXA0KdXKioo5LEGD+/oTU+5PSIcWNBSTQBhLGFvRkn22z460+1OOu+pg4erTDRN8GZGzHUiH+uZZeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GKOyCHSr; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710406116; x=1741942116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KWHHw8AdrVa/yYww2f3tWcNpA+3ogD6g03jLdbzloxE=;
  b=GKOyCHSrt6qKlkQvJ8G+ks5Nm4RAdfjZqEOa6RASSGsh0+69csi/lggp
   Ipw/oA8QV3k5zV8sgR47VBGynPL4UhWytwQqxr43uLqn8rAH/ATcGoDDP
   vg/iR1gNa0kbe1QK0sglUG0XdpNqXe19KQMHcsFGjdt+NGolB1fnntr8e
   9XF0FdshqZQjrLeBfvWO+HJoyMaoU5PCjuVx3+r8cE5fANlkJ2WB7b+6R
   ferWwYg/LIaXDi62RHUhWBgyiTPsCBYNNtd5kA25bYsB+6PoW4AIk4a9e
   +nShZlnN5gAEGw/eBVtP6cXoSPSJzpLTMQ+0AHhESetxk0f3UvAMfqywT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="131618747"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="131618747"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 17:48:28 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 645A2E95F5;
	Thu, 14 Mar 2024 17:48:25 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 98EFDE61BE;
	Thu, 14 Mar 2024 17:48:24 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 25E9B200932DB;
	Thu, 14 Mar 2024 17:48:24 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 819BD1A006B;
	Thu, 14 Mar 2024 16:48:23 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	=?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org
Subject: [PATCH v2 1/4] HID: hid-picolcd_core: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 16:47:50 +0800
Message-Id: <20240314084753.1322110-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28250.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28250.005
X-TMASE-Result: 10--5.324200-10.000000
X-TMASE-MatchedRID: Jy5kObkVr+g4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSrMZ+BqQt2NpBHuVYxc8DW3hh5KUdlgWiKqF
	q1hn3Eb3d+/nM3Koh0iaTw03n/wYO0ekSi+00U24ReM8i8p3vgEyQ5fRSh2656hUULKzHRgQLm6
	NncNkETaGvCFqoKSwTX7bicKxRIU2No+PRbWqfRDsAVzN+Ov/soPjENVLc2pbdBcO/UNP0olix4
	n9Bi0emDYblnKmVeNx0j0UM11E4+w==
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

CC: "Bruno Prémont" <bonbons@linux-vserver.org>
CC: Jiri Kosina <jikos@kernel.org>
CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: linux-input@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/hid/hid-picolcd_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index bbda231a7ce3..fa46fb6eab3f 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -256,9 +256,9 @@ static ssize_t picolcd_operation_mode_show(struct device *dev,
 	struct picolcd_data *data = dev_get_drvdata(dev);
 
 	if (data->status & PICOLCD_BOOTLOADER)
-		return snprintf(buf, PAGE_SIZE, "[bootloader] lcd\n");
+		return sysfs_emit(buf, "[bootloader] lcd\n");
 	else
-		return snprintf(buf, PAGE_SIZE, "bootloader [lcd]\n");
+		return sysfs_emit(buf, "bootloader [lcd]\n");
 }
 
 static ssize_t picolcd_operation_mode_store(struct device *dev,
@@ -301,7 +301,7 @@ static ssize_t picolcd_operation_mode_delay_show(struct device *dev,
 {
 	struct picolcd_data *data = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%hu\n", data->opmode_delay);
+	return sysfs_emit(buf, "%hu\n", data->opmode_delay);
 }
 
 static ssize_t picolcd_operation_mode_delay_store(struct device *dev,
-- 
2.29.2


