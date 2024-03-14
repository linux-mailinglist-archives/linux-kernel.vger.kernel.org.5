Return-Path: <linux-kernel+bounces-103034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F1587BA2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5771F23D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D046CDB0;
	Thu, 14 Mar 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IJCZ1lEd"
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C226AD6;
	Thu, 14 Mar 2024 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407734; cv=none; b=D+fozOlvYTzpcpneowIfmWArKjmEZH6IDi1mRPJeCSsDuIZM9AfRbL6yOFMZIBZHO2pkEryXlhzuiUPE6+ftwvrTTmu240H/9yQiG50luSZa9yyG2sz1gP8DmJrcs8Ogc4WMwQjo7uak9Kf29P6RH3ejlM000jLbsDsbUJsxNrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407734; c=relaxed/simple;
	bh=uApUjC5YdwCr0tkc9ThyODjdMT/+nu/W6brBLQ7RlsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cRXzY9qhAWqUPJpLAEImcN4ye+Z8iTs1Va4PW1syQyH72SBO27IjIKrHd1PPXem78QP43Q8mZnPeNi8ju0+4acf3Paet2pksf1SVvXoI4zI0xCSAi5p4N9Yha92b+/CxSJBaobmyfJNahg8t5T5plRfHix6vXKQe/18CZ9jQHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IJCZ1lEd; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710407733; x=1741943733;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uApUjC5YdwCr0tkc9ThyODjdMT/+nu/W6brBLQ7RlsE=;
  b=IJCZ1lEd9afcaX66LRRjynDbbURulgyo3ifMiRe23vDhY1a9vY3Xhndp
   ByW/ANd6DETcADEWXGMncWf7XxI6Z4UyjoepVi1iX85e4E/WA83A0UvD3
   iB1wUKswTlhKHVqgrTdDA0vpUKfEfhAQ0qzjeu7rTOxWKztqatJhLEr31
   yXCdq7Gq7WqfFshnZV3RCWU3+PqunhZ26Gy0CB7NcZWHUBKwe9WrRVDaC
   5Rs18EGGsfT1khkDKoG20AKChTqaKbut9U/G3ZY0FaY1MShxjPn/T8mvx
   LIqMIef+sHnDOhFrMIhSHy8tco36k6n76ZSUb31WgDjCItPZlYJhCxtZ9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="154095754"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="154095754"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:15:24 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3A4B5C32E2;
	Thu, 14 Mar 2024 18:15:21 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 691B6B0D79;
	Thu, 14 Mar 2024 18:15:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 016546B4C5;
	Thu, 14 Mar 2024 18:15:20 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 80F291A006B;
	Thu, 14 Mar 2024 17:15:19 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: core: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 17:15:12 +0800
Message-Id: <20240314091512.1323650-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28250.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28250.006
X-TMASE-Result: 10--6.925300-10.000000
X-TMASE-MatchedRID: 84oovQVhL8E4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSrMZ+BqQt2NpBHuVYxc8DW3hh5KUdlgWiKqF
	q1hn3Eb3d+/nM3Koh0iaTw03n/wYO0ekSi+00U24ReM8i8p3vgEyQ5fRSh265uBsk5njfgGwHBN
	wMIojZclkG0yevELlY5nGjEm4IlfpEY+rVKhaSwJ4CIKY/Hg3AaZGo0EeYG96m4/3ODjvukSq2r
	l3dzGQ1bvsoMHHm4Yje41SHp05NwSTlv00df6MuF3aCMgMiMs9sOKrFPGAUQA==
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

CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-mmc@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/mmc/core/block.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 64a3492e8002..1e1e136d9e72 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -234,7 +234,7 @@ static ssize_t power_ro_lock_show(struct device *dev,
 	else if (card->ext_csd.boot_ro_lock & EXT_CSD_BOOT_WP_B_PWR_WP_EN)
 		locked = 1;
 
-	ret = snprintf(buf, PAGE_SIZE, "%d\n", locked);
+	ret = sysfs_emit(buf, "%d\n", locked);
 
 	mmc_blk_put(md);
 
@@ -296,9 +296,9 @@ static ssize_t force_ro_show(struct device *dev, struct device_attribute *attr,
 	int ret;
 	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
 
-	ret = snprintf(buf, PAGE_SIZE, "%d\n",
-		       get_disk_ro(dev_to_disk(dev)) ^
-		       md->read_only);
+	ret = sysfs_emit(buf, "%d\n",
+			 get_disk_ro(dev_to_disk(dev)) ^
+			 md->read_only);
 	mmc_blk_put(md);
 	return ret;
 }
-- 
2.29.2


