Return-Path: <linux-kernel+bounces-106169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B08E87EA2A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84620B20C43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442774879B;
	Mon, 18 Mar 2024 13:34:59 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C353D20315;
	Mon, 18 Mar 2024 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768898; cv=none; b=emQ/+MFvsc0nkv3EcMCwrFViW3nw3xv3SEdpqEmPXdOQlS0SZvQXzZwgFwetaF02LAyC0RGAqrMVSCxup76eE6l2PgVxf4iAj8QOVIYwXGwS4MKcKq0CCNlGN/8JTfZh4qY/Lsd718LWtKags5gkAV8cWkm5Uiyh1/qzbcSmgtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768898; c=relaxed/simple;
	bh=i7L+uyAp6jzXG6FrEwW95VcUBTdNwNKLRMEINIXnofM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NCqwy2jzNY0p6mCGtJyaaHNVqXLJ+/UBhe0INDzJ54R36bZOh4/a35pL/2HzUp9IvhapX3yzqBTeZrg5LvT3Z7LVUr7DH0fBwKps4kKKgcAs7KVT4P9fIvbH1KeQiE1g/kNzFXnnS6E4VOGCj+w6iM22gvbZabZRCc9BHh463VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tywkp2YSnz1h2mY;
	Mon, 18 Mar 2024 21:32:18 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id E39F31A0172;
	Mon, 18 Mar 2024 21:34:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 21:34:49 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.kubiak@intel.com>, <rkannoth@marvell.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 net 0/3] There are some bugfix for the HNS3 ethernet driver
Date: Mon, 18 Mar 2024 21:29:45 +0800
Message-ID: <20240318132948.3624333-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

There are some bugfix for the HNS3 ethernet driver

---
changeLog:
v2 -> v3:
  - Fixed a syntax error in git message, suggested by Ratheesh Kannoth
  v2: https://lore.kernel.org/all/20240316111057.277591-1-shaojijie@huawei.com/
v1 -> v2:
  - Fixed some syntax errors in git messages and comments, suggested by Michal Kubiak
  - Optimized the code by using a flag, suggested by Michal Kubiak
  v1: https://lore.kernel.org/all/20240315100748.2913882-1-shaojijie@huawei.com/
---

Jian Shen (1):
  net: hns3: mark unexcuted loopback test result as UNEXECUTED

Jie Wang (1):
  net: hns3: fix index limit to support all queue stats

Yonglong Liu (1):
  net: hns3: fix kernel crash when devlink reload during pf
    initialization

 .../hns3/hns3_common/hclge_comm_tqp_stats.c   |  2 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 19 +++++++++++++++++--
 .../hisilicon/hns3/hns3pf/hclge_devlink.c     |  5 +++--
 3 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.30.0


