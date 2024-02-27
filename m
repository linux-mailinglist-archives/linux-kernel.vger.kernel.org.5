Return-Path: <linux-kernel+bounces-82626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA470868765
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187821C27DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC5E2376A;
	Tue, 27 Feb 2024 02:48:04 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706B2260A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002084; cv=none; b=LI8+4cCZRhgyl7NtG3UbPNY1pvYLxJyN90v+9iG3PIwRnQ3WAsaTAwVFmFWXiWoxZw0tG8NvXz+7i0POt6TkT4sfBz1QRb5FOs9i5pt9gHU6SrzKQuQKPkTjDO/Lq1SZyxtHMxHRhWnvi+SW4cNPY8Q1tbLvhn05D8wQr89CTJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002084; c=relaxed/simple;
	bh=QBa8dkJ9GlA6xvpAmZYy9lueVtALhB5J4toOaigjbII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=poPBxvLYkgKLQpVxmsaqIx+Y8tqTf9nhF5yKIlR6ZTMv0Ujw703B5Bypr21+UbvXRE0PBhLQV+H5NLXI5QaU4uuiBs58lHatkyhXhO1s5WSrcc0XBr6UY7y+5/J8CV3gNveD1v1EBf9ZMx8N/MxVCXI1DoZ/635Ic0AZd8YkElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TkML204DHz1h0jW;
	Tue, 27 Feb 2024 10:45:46 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id A16071A0178;
	Tue, 27 Feb 2024 10:47:59 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 10:47:59 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lkp@intel.com>
Subject: [PATCH -next] ubifs: add_or_start_queue: fix kernel-doc warning
Date: Tue, 27 Feb 2024 10:42:04 +0800
Message-ID: <20240227024204.1080739-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Fix kernel-doc warning found when using "W=1":
  fs/ubifs/journal.c:369: warning: expecting prototype for
  wake_up_reservation(). Prototype was for add_or_start_queue() instead.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402261912.yAxZePRG-lkp@intel.com/
Fixes: 556c19f563b6 ("ubifs: Queue up space reservation tasks if retrying many times")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 74aee92433d7..f997a85bcdce 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -359,7 +359,7 @@ static void wake_up_reservation(struct ubifs_info *c)
 }
 
 /**
- * wake_up_reservation - add current task in queue or start queuing.
+ * add_or_start_queue - add current task in queue or start queuing.
  * @c: UBIFS file-system description object
  *
  * This function starts queuing if queuing is not started, otherwise adds
-- 
2.39.2


