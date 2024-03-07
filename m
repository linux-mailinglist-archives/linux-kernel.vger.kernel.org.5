Return-Path: <linux-kernel+bounces-94812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBDC874582
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA961C21369
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418731BF50;
	Thu,  7 Mar 2024 01:06:25 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10134E554;
	Thu,  7 Mar 2024 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773584; cv=none; b=qY1T7gx6NlOvfqncx/0KkXblokHw3Px6AGjCOj1NIMEH3E8JRQzYKnpvkByqjPJV/8cwURmkF0C5x65YmrRF5wEb64wfp6KDlZmoANn7vmbiBSq66U2UVBFB16B234tkzJFO3d+Vn03HO8VM3QBFK+nJiFAe30P7Tckp7iS0MJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773584; c=relaxed/simple;
	bh=nlN01KDBSH4+Pka9XVMq7JUSeBb/MIozDu4QRGEyP1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GWPviuffmdq/xfgzuMZFJxTz5XAMc5iLld3s1k7ZGgsTF9t26bkt6NUaS2CSmeKblqm+DMEI6JJwB0zZotsV+YGhV7waXjvz1rjvZ50N/NZGU3p8KVHGh0WjUkxDM0HPqpvWblOqDnQt4GFLps1yhoT1to+OFEG60y6c7Ny6wqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TqrfK0Rtzz1h1Gw;
	Thu,  7 Mar 2024 09:03:53 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 831691402E0;
	Thu,  7 Mar 2024 09:06:14 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:06:13 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/8] There are some bugfix for the HNS3 ethernet driver
Date: Thu, 7 Mar 2024 09:01:07 +0800
Message-ID: <20240307010115.3054770-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)

There are some bugfix for the HNS3 ethernet driver

Hao Lan (2):
  net: hns3: add new 200G link modes for hisilicon device
  net: hns3: Disable SerDes serial loopback for HiLink H60

Jian Shen (1):
  net: hns3: add checking for vf id of mailbox

Jie Wang (1):
  net: hns3: fix port duplex configure error in IMP reset

Jijie Shao (2):
  net: hns3: fix wrong judgment condition issue
  net: hns3: fix delete tc fail issue

Peiyang Wang (1):
  net: hns3: fix reset timeout under full functions and queues

Yonglong Liu (1):
  net: hns3: fix kernel crash when 1588 is received on HIP08 devices

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 +
 .../hns3/hns3_common/hclge_comm_cmd.c         |  2 +-
 .../hns3/hns3_common/hclge_comm_cmd.h         |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3_dcbnl.c  |  2 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  2 +
 .../hisilicon/hns3/hns3pf/hclge_cmd.h         |  3 +-
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         |  2 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 44 +++++++++++++------
 .../hisilicon/hns3/hns3pf/hclge_main.h        | 11 ++++-
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  7 +--
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 16 +++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.h |  1 +
 13 files changed, 74 insertions(+), 22 deletions(-)

-- 
2.30.0


