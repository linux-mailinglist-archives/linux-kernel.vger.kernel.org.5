Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1FD7A43A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240498AbjIRHzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbjIRHy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:54:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740483A82;
        Mon, 18 Sep 2023 00:53:00 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rpxlv5B87zVky9;
        Mon, 18 Sep 2023 15:50:03 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 15:52:58 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 0/5] There are some bugfix for the HNS3 ethernet driver
Date:   Mon, 18 Sep 2023 15:48:35 +0800
Message-ID: <20230918074840.2650978-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some bugfix for the HNS3 ethernet driver

---
ChangeLog:
v1->v2:
  add Fixes tag for bugfix patch suggested by Simon Horman
  v1: https://lore.kernel.org/all/20230915095305.422328-1-shaojijie@huawei.com/
---
	
Jian Shen (1):
  net: hns3: only enable unicast promisc when mac table full

Jie Wang (3):
  net: hns3: add cmdq check for vf periodic service task
  net: hns3: fix GRE checksum offload issue
  net: hns3: add 5ms delay before clear firmware reset irq source

Jijie Shao (1):
  net: hns3: fix fail to delete tc flower rules during reset issue

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c     |  9 +++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 13 ++++++++++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c   |  3 ++-
 3 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.30.0

