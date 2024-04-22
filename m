Return-Path: <linux-kernel+bounces-153515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E968ACEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687A2282818
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006E1509BE;
	Mon, 22 Apr 2024 14:09:07 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377C136988;
	Mon, 22 Apr 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713794947; cv=none; b=ANTeq44yfF7vCubEdcRwnBYDzmiKQ8mhWgOLGaJD3f3moGFdaR1rqrmhwQb3Oq2xCu4aHH1tsENTeeIbKr35VvkEa4UtG9nS4e05pl6JXsR/aOO1XRXEMbTiDrn40YpCnce3vMU3WvYpWFlCwGGitoairBS3aZUTQPyAqG/DcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713794947; c=relaxed/simple;
	bh=vKJZyvXkK+t7IlJu/N/9ZkAItcFt061OigD7Pym38VU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hi0yllEZW3vSfeTcRjZcRVyyjaN3DgPVhGFh2ij2vw0ypfBMKYnduJqQS851/izfSh3GEYn2qaGN3pyV6kLmPLI8iSrwvgbe1BpO9fYpwztglAK6of8Y5Ga/JOhr9jAsGPv5SHchZQKLG6ZqcDW9TU4ORzV/IhLg9RMbNCtvUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VNRQ04rZ9zNspP;
	Mon, 22 Apr 2024 21:47:20 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 093DF18007C;
	Mon, 22 Apr 2024 21:49:50 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 21:49:49 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/7] There are some bugfix for the HNS3 ethernet driver
Date: Mon, 22 Apr 2024 21:43:20 +0800
Message-ID: <20240422134327.3160587-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)

There are some bugfix for the HNS3 ethernet driver

Jian Shen (1):
  net: hns3: direct return when receive a unknown mailbox message

Peiyang Wang (4):
  net: hns3: change type of numa_node_mask as nodemask_t
  net: hns3: release PTP resources if pf initialization failed
  net: hns3: use appropriate barrier function after setting a bit value
  net: hns3: using user configure after hardware reset

Yonglong Liu (2):
  net: hns3: fix port vlan filter not disabled issue
  net: hns3: fix kernel crash when devlink reload during vf
    initialization

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 35 ++++++++++++-------
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  5 ++-
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  7 ++--
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 14 +++++---
 .../hisilicon/hns3/hns3vf/hclgevf_main.h      |  2 +-
 6 files changed, 42 insertions(+), 23 deletions(-)

-- 
2.30.0


